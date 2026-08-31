import json

with open("C:/Users/simon/Documents/hanzi_master/lib/l10n/app_en.arb", "r", encoding="utf-8") as f:
    arb = json.load(f)

search_terms = ["Guest", "Local account", "Create account", "sync progress", "Account", "Learning stats", "View your", "premium", "Sinospark", "premium member"]

print("=" * 60)
print("EXISTING KEYS IN app_en.arb:")
print("=" * 60)
for q in search_terms:
    found = False
    for k, v in arb.items():
        if isinstance(v, str) and q.lower() in v.lower():
            if not found:
                print(f"\n--- Search: '{q}' ---")
                found = True
            print(f"  {k}: {v[:80]}")
    if not found:
        print(f"\n--- Search: '{q}' --- NOT FOUND")

print("\n" + "=" * 60)
print("Looking for what we have that's close:")
print("=" * 60)
for k, v in arb.items():
    if isinstance(v, str) and not k.startswith("@"):
        if "guest" in k.lower() or "account" in k.lower() or "sync" in k.lower() or "premium" in k.lower() or "member" in k.lower():
            print(f"  {k}: {v[:80]}")