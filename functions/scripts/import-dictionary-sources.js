#!/usr/bin/env node
"use strict";

// Uses firebase-admin's Application Default Credentials. Locally, run
// `gcloud auth application-default login` (and set GCLOUD_PROJECT if needed).
const { spawn } = require("node:child_process");
const admin = require("firebase-admin");
const { sourceHash, SUPPORTED_LANGUAGES } = require("../dictionary-expansion");

const sqlitePath = process.argv[2];
if (!sqlitePath) {
  console.error("Usage: node scripts/import-dictionary-sources.js <dictionary.sqlite>");
  process.exitCode = 2;
  return;
}

const columns = ["id", "traditional", "simplified", "pinyin", "definition"]
  .concat(SUPPORTED_LANGUAGES.filter((language) => language !== "en").map((language) => `definition_${language}`));

function readRows(path) {
  // Python's standard sqlite3 module avoids native Node add-ons and streams
  // newline-delimited JSON, so even a large dictionary is not held in memory.
  const program = [
    "import json, sqlite3, sys",
    "db=sqlite3.connect(sys.argv[1])",
    "db.row_factory=sqlite3.Row",
    `cols=${JSON.stringify(columns)}`,
    "available={r[1] for r in db.execute('pragma table_info(words)')}",
    "selected=[c for c in cols if c in available]",
    "sql='select '+','.join('\\\"'+c+'\\\"' for c in selected)+' from words order by id'",
    "has_quality=db.execute(\"select 1 from sqlite_master where type='table' and name='localized_definition_quality'\").fetchone() is not None",
    "for row in db.execute(sql).fetchall():",
    " d=dict(row)",
    " d['_quality']=[dict(q) for q in db.execute('select language_code, score, expansion_eligible, hex(source_definition_hash) as source_definition_hash, scoring_version, reasons from localized_definition_quality where word_id=?', (d['id'],))] if has_quality else []",
    " print(json.dumps(d, ensure_ascii=False), flush=True)",
  ].join("\n");
  return spawn(process.env.PYTHON || "python", ["-c", program, path], {
    stdio: ["ignore", "pipe", "inherit"],
  });
}

async function main() {
  admin.initializeApp({ credential: admin.credential.applicationDefault() });
  const db = admin.firestore();
  const child = readRows(sqlitePath);
  const childExit = new Promise((resolve, reject) => {
    child.once("error", reject);
    child.once("close", resolve);
  });
  let buffer = "";
  let pending = [];
  let imported = 0;

  async function flush() {
    if (!pending.length) return;
    const batch = db.batch();
    for (const row of pending) {
      const wordId = String(row.id);
      const definition = typeof row.definition === "string" ? row.definition.trim() : "";
      if (!definition) continue;
      const hash = sourceHash(definition);
      const localizedDefinitions = {};
      for (const language of SUPPORTED_LANGUAGES) {
        const value = row[`definition_${language}`];
        if (typeof value === "string" && value.trim()) localizedDefinitions[language] = value.trim();
      }
      batch.set(db.collection("dictionarySources").doc(wordId), {
        wordId,
        traditional: row.traditional || "",
        simplified: row.simplified || "",
        pinyin: row.pinyin || "",
        definition,
        sourceDefinitionHash: hash,
        localizedDefinitions,
        importedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      for (const quality of row._quality || []) {
        const languageCode = quality.language_code;
        if (!SUPPORTED_LANGUAGES.includes(languageCode)) continue;
        batch.set(db.collection("dictionaryScoreEligibility").doc(`${wordId}_${languageCode}`), {
          wordId, languageCode,
          score: quality.score,
          eligible: quality.expansion_eligible === 1,
          sourceDefinitionHash: String(quality.source_definition_hash).toLowerCase(),
          scoringVersion: quality.scoring_version,
          reasons: JSON.parse(quality.reasons || "[]"),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
      imported++;
    }
    pending = [];
    await batch.commit();
    if (imported % 1000 === 0) console.log(`Imported ${imported} sources`);
  }

  for await (const chunk of child.stdout) {
    buffer += chunk.toString("utf8");
    let newline;
    while ((newline = buffer.indexOf("\n")) !== -1) {
      const line = buffer.slice(0, newline);
      buffer = buffer.slice(newline + 1);
      if (line) pending.push(JSON.parse(line));
      // One source plus up to 14 score records per row stays below 500 writes.
      if (pending.length >= 30) await flush();
    }
  }
  if (buffer.trim()) pending.push(JSON.parse(buffer));
  await flush();
  const exitCode = await childExit;
  if (exitCode !== 0) throw new Error(`SQLite reader exited with status ${exitCode}`);
  console.log(`Imported ${imported} canonical dictionary sources and eligibility records.`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});