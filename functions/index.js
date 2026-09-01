const { onCall, onRequest, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const fetch = require("node-fetch");
const cors = require("cors")({ origin: true });

admin.initializeApp();

const revenueCatSecretKey = defineSecret("REVENUECAT_SECRET_API_KEY");

async function deleteDocumentTree(path) {
  const document = admin.firestore().doc(path);
  try {
    await admin.firestore().recursiveDelete(document);
  } catch (error) {
    if (error.code !== 5 && error.code !== "not-found") throw error;
  }
}

async function deleteStoragePrefix(prefix) {
  const bucket = admin.storage().bucket();
  await bucket.deleteFiles({ prefix, force: true });
}

async function deleteRevenueCatCustomer(uid) {
  const apiKey = revenueCatSecretKey.value();
  if (!apiKey) {
    throw new Error("REVENUECAT_SECRET_API_KEY is not configured");
  }

  const response = await fetch(
    `https://api.revenuecat.com/v1/subscribers/${encodeURIComponent(uid)}`,
    {
      method: "DELETE",
      headers: {
        Authorization: `Bearer ${apiKey}`,
        "Content-Type": "application/json",
      },
    },
  );

  // A missing subscriber is already in the desired state.
  if (!response.ok && response.status !== 404) {
    const body = await response.text();
    throw new Error(`RevenueCat deletion failed (${response.status}): ${body}`);
  }
}

/**
 * Permanently deletes all server-side data owned by the authenticated user.
 *
 * Every cleanup operation is idempotent. Firebase Auth is deliberately deleted
 * last so a partial failure remains retryable by the same authenticated user.
 */
exports.deleteAccountV1 = onCall(
  { secrets: [revenueCatSecretKey], timeoutSeconds: 120 },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError("unauthenticated", "Sign in before deleting your account.");
    }

    const authTime = Number(request.auth.token.auth_time || 0);
    if (!authTime || Date.now() / 1000 - authTime > 5 * 60) {
      throw new HttpsError(
        "failed-precondition",
        "Recent authentication is required before account deletion.",
      );
    }

    const uid = request.auth.uid;
    try {
      // These are the only supported user-owned namespaces. Keep this list in
      // sync whenever a new cloud persistence path is introduced.
      await Promise.all([
        deleteDocumentTree(`users/${uid}`),
        deleteStoragePrefix(`users/${uid}/`),
        deleteStoragePrefix(`user_uploads/${uid}/`),
      ]);
      await deleteRevenueCatCustomer(uid);

      try {
        await admin.auth().deleteUser(uid);
      } catch (error) {
        if (error.code !== "auth/user-not-found") throw error;
      }

      return { deleted: true };
    } catch (error) {
      console.error("Account deletion failed", { uid, error });
      throw new HttpsError(
        "internal",
        "Account deletion could not be completed. No sign-in account was deleted.",
      );
    }
  },
);

exports.generateContentProxyV2 = onRequest({ cors: true, invoker: "public" }, (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      return res.status(500).json({ error: "Missing Gemini API Key" });
    }

    try {
      const { model, body } = req.body;
      const targetModel = model || "gemini-2.5-flash";
      const url = `https://generativelanguage.googleapis.com/v1beta/models/${targetModel}:generateContent?key=${apiKey}`;

      const response = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      const data = await response.json();
      return res.status(response.status).json(data);
    } catch (error) {
      console.error("Proxy error:", error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  });
});

exports.openRouterProxyV2 = onRequest({ cors: true, invoker: "public" }, (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    // Use the perfectly working Gemini API key instead of the broken OpenRouter key
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      return res.status(500).json({ error: "Missing Gemini API Key" });
    }

    try {
      // Use Gemini's official OpenAI-compatible endpoint
      const url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";
      
      // Intercept the request and force the model to Gemini 2.5 Flash, ignoring any OpenRouter models
      const requestBody = { ...req.body, model: "gemini-2.5-flash" };

      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${apiKey}`
        },
        body: JSON.stringify(requestBody),
      });

      if (req.body.stream) {
        res.setHeader("Content-Type", "text/event-stream");
        res.setHeader("Cache-Control", "no-cache");
        res.setHeader("Connection", "keep-alive");
        res.status(response.status);
        response.body.pipe(res);
      } else {
        const data = await response.json();
        return res.status(response.status).json(data);
      }
    } catch (error) {
      console.error("Proxy error:", error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  });
});
