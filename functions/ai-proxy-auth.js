"use strict";

/**
 * Caller authentication for the AI proxies.
 *
 * The proxies forward to a paid model with a project key, so they are an
 * *open relay* unless they know who is calling: before this module, both
 * handlers read the key and forwarded with no check at all, while the app's only
 * usage limit (`_checkUsageLimit()`) ran on the client and could be bypassed by
 * anyone holding the key. This is the server half of W0 in
 * `docs/AI_CACHING_ROADMAP.md`: the request has to become server-mediated, with
 * an identity attached, before any cache or quota above it can mean anything.
 *
 * `bearerToken` is deliberately pure so `node:test` can cover it - the same
 * shape `dictionary-expansion.js` uses to make its cache identity testable.
 */

/** The bearer scheme, case-insensitively, per RFC 6750. */
const BEARER = /^Bearer\s+(.+)$/i;

/**
 * Extract the token from an `Authorization` header value.
 *
 * Returns `null` for anything that is not a well-formed bearer credential, so a
 * caller cannot accidentally authenticate with a stray header.
 *
 * @param {unknown} headerValue
 * @returns {string|null}
 */
function bearerToken(headerValue) {
  if (typeof headerValue !== "string") return null;
  const match = BEARER.exec(headerValue.trim());
  if (!match) return null;
  const token = match[1].trim();
  // A JWT has three dot-separated segments; anything else is not an ID token and
  // must not be handed to `verifyIdToken` as if it were.
  if (token.split(".").length !== 3 || token.length > 4096) return null;
  return token;
}

/**
 * Verify the caller's Firebase ID token.
 *
 * @param {import("express").Request} req
 * @returns {Promise<{uid: string, token: object}>}
 * @throws {Error} when the credential is missing, malformed, expired or forged
 */
async function requireUser(req) {
  const token = bearerToken(req.headers && req.headers.authorization);
  if (!token) throw new Error("missing bearer credential");
  const admin = require("firebase-admin");
  const decoded = await admin.auth().verifyIdToken(token, true);
  if (!decoded || !decoded.uid) throw new Error("credential has no uid");
  return { uid: decoded.uid, token: decoded };
}

module.exports = { bearerToken, requireUser };
