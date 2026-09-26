"use strict";

const test = require("node:test");
const assert = require("node:assert/strict");
const { bearerToken } = require("../ai-proxy-auth");

// A JWT-*shaped* string - three dot-separated segments. It is not signed and
// never reaches verification: `bearerToken` only decides whether a header value
// is a credential at all, which is the part worth pinning down in a test.
const token = "aGVhZGVy.cGF5bG9hZA.c2lnbmF0dXJl";

test("accepts a well-formed bearer credential", () => {
  assert.equal(bearerToken(`Bearer ${token}`), token);
});

test("scheme matching is case-insensitive, as RFC 6750 requires", () => {
  assert.equal(bearerToken(`bearer ${token}`), token);
  assert.equal(bearerToken(`BEARER ${token}`), token);
});

test("tolerates surrounding whitespace", () => {
  assert.equal(bearerToken(`  Bearer   ${token}  `), token);
});

test("refuses anything that is not a bearer credential", () => {
  assert.equal(bearerToken(undefined), null);
  assert.equal(bearerToken(null), null);
  assert.equal(bearerToken(""), null);
  assert.equal(bearerToken(token), null, "no scheme");
  assert.equal(bearerToken(`Basic ${token}`), null, "wrong scheme");
  assert.equal(bearerToken("Bearer "), null, "empty token");
  assert.equal(bearerToken("Bearer not-a-jwt"), null, "not three segments");
  assert.equal(bearerToken("Bearer a.b.c.d"), null, "four segments");
});

test("refuses an oversized credential before it reaches verification", () => {
  const huge = `${"a".repeat(2000)}.${"b".repeat(2000)}.${"c".repeat(2000)}`;
  assert.equal(bearerToken(`Bearer ${huge}`), null);
});
