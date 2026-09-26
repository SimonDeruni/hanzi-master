#!/usr/bin/env node
"use strict";

/**
 * Precompute the graded parse of every bundled story, once, for every user.
 *
 * A bundled story is identical for everyone, so parsing it on each device means
 * paying for the same answer again and again. This writes the answer into
 * `stories/{storyId}/parsed/{hskLevel}` so the app can read it instead of
 * calling the model. The client falls back to calling the model whenever a seed
 * is missing or stale, so this script is never load-bearing - it only removes
 * cost.
 *
 * Uses firebase-admin's Application Default Credentials. Locally, run
 * `gcloud auth application-default login` (and set GCLOUD_PROJECT if needed).
 * Needs GEMINI_API_KEY in the environment.
 *
 * **Defaults to a dry run**, unlike `import-dictionary-sources.js`: this script
 * spends money at the model, so writing has to be asked for explicitly.
 *
 *   node scripts/precompute-story-parses.js                 # report only
 *   node scripts/precompute-story-parses.js --levels=1,2,3  # report a subset
 *   node scripts/precompute-story-parses.js --apply         # generate + write
 *   node scripts/precompute-story-parses.js --only=<storyId> --apply
 *
 * Re-running is free: pairs already seeded at the current prompt version are
 * skipped, so an interrupted run can simply be repeated.
 */

const admin = require("firebase-admin");
const fetch = require("node-fetch");
const {
  GEMINI_ENDPOINT,
  MODEL_VERSION,
  STORY_PARSE_PROMPT_VERSION,
  buildPrompt,
  validateOutput,
} = require("../story-parse");

const apply = process.argv.includes("--apply");
const onlyArg = process.argv.find((value) => value.startsWith("--only="));
const only = onlyArg ? onlyArg.slice("--only=".length) : null;
const levelsArg = process.argv.find((value) => value.startsWith("--levels="));
const levels = levelsArg
  ? levelsArg
      .slice("--levels=".length)
      .split(",")
      .map((value) => Number.parseInt(value, 10))
      .filter((value) => Number.isInteger(value))
  : [0, 1, 2, 3, 4, 5, 6];

const apiKey = process.env.GEMINI_API_KEY;
if (!apiKey) {
  console.error("GEMINI_API_KEY is required (it is the credential this spends).");
  process.exitCode = 2;
  return;
}
if (levels.length === 0) {
  console.error("--levels= produced no usable levels.");
  process.exitCode = 2;
  return;
}

/**
 * Resolve the project without making the operator remember it.
 *
 * `admin.initializeApp()` with no project id fails with "Unable to detect a
 * Project Id in the current environment" - a confusing first experience for a
 * script meant to be run occasionally by hand, and exactly what happened the
 * first time this ran. `.firebaserc` already states the project, so read it.
 *
 * @returns {string|undefined}
 */
function resolveProjectId() {
  const fromEnvironment =
    process.env.GCLOUD_PROJECT || process.env.GOOGLE_CLOUD_PROJECT;
  if (fromEnvironment) return fromEnvironment;
  try {
    const rcPath = require("node:path").join(__dirname, "..", "..", ".firebaserc");
    const rc = JSON.parse(require("node:fs").readFileSync(rcPath, "utf8"));
    return rc.projects && rc.projects.default ? rc.projects.default : undefined;
  } catch (error) {
    console.warn("Could not read .firebaserc for a project id:", error.message);
    return undefined;
  }
}

admin.initializeApp({ projectId: resolveProjectId() });

/** Gemini wraps the JSON the model produced inside its own envelope. */
function extractModelJson(payload) {
  const candidates = payload && payload.candidates;
  if (!Array.isArray(candidates) || candidates.length === 0) {
    throw new Error("model returned no candidates");
  }
  const parts = candidates[0].content && candidates[0].content.parts;
  if (!Array.isArray(parts)) throw new Error("model returned no parts");
  const text = parts
    .map((part) => (part && typeof part.text === "string" ? part.text : ""))
    .join("")
    .replace(/```json\n?/g, "")
    .replace(/```\n?/g, "")
    .trim();
  return JSON.parse(text);
}

/**
 * Ask the model once for one (story, level) pair.
 *
 * @param {string} rawText
 * @param {number} hskLevel
 * @returns {Promise<{sentences: Array}>} validated, ready to seed
 */
async function generateParse(rawText, hskLevel) {
  const model = MODEL_VERSION.split("/").pop();
  const url = `${GEMINI_ENDPOINT}/${model}:generateContent?key=${apiKey}`;
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      contents: [
        { role: "user", parts: [{ text: buildPrompt(rawText, hskLevel) }] },
      ],
      generationConfig: {
        maxOutputTokens: 8192,
        responseMimeType: "application/json",
      },
    }),
  });
  if (!response.ok) {
    throw new Error(`model call failed (${response.status}): ${await response.text()}`);
  }
  return validateOutput(extractModelJson(await response.json()));
}

/**
 * Work out what needs generating, without generating anything.
 *
 * Reporting the plan first is the whole point: the number of calls is
 * `stories x levels`, and that should be visible before it is spent.
 *
 * @returns {Promise<{planned: Array, skipped: Array<string>}>}
 */
async function plan(db) {
  const planned = [];
  const skipped = [];
  const snapshot = await db.collection("stories").get();
  const docs = only
    ? snapshot.docs.filter((doc) => doc.id === only)
    : snapshot.docs;
  for (const doc of docs) {
    const rawText = doc.data().rawText;
    if (typeof rawText !== "string" || rawText.length === 0) {
      skipped.push(`${doc.id}: no rawText`);
      continue;
    }
    for (const level of levels) {
      const seedRef = db
        .collection("stories")
        .doc(doc.id)
        .collection("parsed")
        .doc(String(level));
      const existing = await seedRef.get();
      const data = existing.exists ? existing.data() : null;
      if (data && data.promptVersion === STORY_PARSE_PROMPT_VERSION) {
        skipped.push(`${doc.id} hsk${level}: already seeded at v${STORY_PARSE_PROMPT_VERSION}`);
        continue;
      }
      planned.push({ storyId: doc.id, level, rawText, seedRef });
    }
  }
  return { planned, skipped };
}

async function main() {
  const db = admin.firestore();
  console.log(
    apply ? "MODE: APPLY (this spends money)" : "MODE: DRY RUN (nothing will be written)"
  );
  console.log(`prompt version: ${STORY_PARSE_PROMPT_VERSION} | levels: ${levels.join(", ")}`);

  const { planned, skipped } = await plan(db);
  console.log(`\npairs to generate: ${planned.length}`);
  for (const item of planned) {
    console.log(`  ${item.storyId} hsk${item.level} (${item.rawText.length} chars)`);
  }
  console.log(`\npairs already done: ${skipped.length}`);
  for (const reason of skipped) console.log(`  ${reason}`);

  if (!apply) {
    console.log("\nDry run complete. Re-run with --apply to generate and write.");
    return;
  }

  let generated = 0;
  const failures = [];
  for (const item of planned) {
    try {
      const output = await generateParse(item.rawText, item.level);
      await item.seedRef.set({
        promptVersion: STORY_PARSE_PROMPT_VERSION,
        modelVersion: MODEL_VERSION,
        generatedAt: admin.firestore.FieldValue.serverTimestamp(),
        sentences: output.sentences,
      });
      generated += 1;
      console.log(`  seeded ${item.storyId} hsk${item.level} (${output.sentences.length} sentences)`);
    } catch (error) {
      // One unusable story must not abandon the other hundreds.
      failures.push(`${item.storyId} hsk${item.level}: ${error.message}`);
      console.error(`  FAILED ${item.storyId} hsk${item.level}: ${error.message}`);
    }
  }

  console.log(`\nseeded ${generated}/${planned.length}`);
  if (failures.length > 0) {
    console.log(`failures (${failures.length}):`);
    for (const failure of failures) console.log(`  ${failure}`);
    process.exitCode = 1;
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
