#!/usr/bin/env node
"use strict";

// Throwaway: report what is currently in Firestore for the dictionary.
const admin = require("firebase-admin");

async function main() {
  admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    projectId: "hanzi-master-bcef9",
  });
  const db = admin.firestore();

  for (const name of ["dictionarySources", "dictionaryScoreEligibility",
                      "dictionaryExpansionCache", "dictionaryExpansionQuotas"]) {
    try {
      const snap = await db.collection(name).count().get();
      console.log(`${name.padEnd(30)} ${snap.data().count} docs`);
    } catch (error) {
      console.log(`${name.padEnd(30)} ERROR ${error.message}`);
    }
  }

  const sample = await db.collection("dictionarySources").limit(1).get();
  if (sample.empty) {
    console.log("\ndictionarySources is empty");
  } else {
    const doc = sample.docs[0];
    const data = doc.data();
    console.log(`\nsample dictionarySources/${doc.id}`);
    console.log("  fields:", Object.keys(data).join(", "));
    console.log("  localizedDefinitions keys:", Object.keys(data.localizedDefinitions || {}).join(", "));
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
