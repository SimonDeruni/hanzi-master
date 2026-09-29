#!/usr/bin/env node
"use strict";

// Throwaway: confirm a sample of merged db rows arrived in Firestore intact.
const admin = require("firebase-admin");
const fs = require("node:fs");
const path = require("node:path");

const samplePath = path.join(__dirname, "..", "..", "scratch", "_verify_sample.json");
const LANGS = ["ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"];

async function main() {
  admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    projectId: "hanzi-master-bcef9",
  });
  const db = admin.firestore();
  const sample = JSON.parse(fs.readFileSync(samplePath, "utf8"));

  let mismatches = 0;
  for (const item of sample) {
    const doc = await db.collection("dictionarySources").doc(String(item.id)).get();
    if (!doc.exists) {
      console.log(`id=${item.id}  MISSING from Firestore`);
      mismatches++;
      continue;
    }
    const localized = doc.data().localizedDefinitions || {};
    const bad = LANGS.filter((L) => (localized[L] || "") !== item.expected[L]);
    console.log(`id=${item.id}  ${item.simplified}  langs=${Object.keys(localized).length}  ` +
      (bad.length ? `MISMATCH ${bad.join(",")}` : "OK"));
    if (bad.length) {
      mismatches++;
      for (const L of bad.slice(0, 2)) {
        console.log(`    ${L} db=${JSON.stringify(item.expected[L])}`);
        console.log(`    ${L} fb=${JSON.stringify(localized[L])}`);
      }
    }
  }
  console.log(`\n${sample.length - mismatches}/${sample.length} verified identical`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
