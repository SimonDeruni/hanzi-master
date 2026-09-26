import json

en = json.load(open("lib/l10n/app_en.arb", encoding="utf-8"))
keys = [k for k in ("hskDescription1 hskDescription2 hskDescription3 hskDescription4 "
                    "hskDescription5 hskDescription6 libraryFilterOfficialHsk "
                    "libraryFilterCulture libraryFilterSports libraryFilterEducation "
                    "libraryFilterTravel libraryFilterBusiness librarySearchHint "
                    "libraryNoMatch libraryResetFilters shelfHskTitle shelfHskSubtitle "
                    "shelfCultureTitle shelfCultureSubtitle shelfSportsTitle "
                    "shelfSportsSubtitle shelfEducationTitle shelfEducationSubtitle "
                    "shelfTravelTitle shelfTravelSubtitle shelfBusinessTitle "
                    "shelfBusinessSubtitle shelfInstalled shelfAvailable "
                    "shelfSampleVocabulary shelfRemoveFromBookshelf shelfDownloadInstall "
                    "shelfGetButton shelfDeckCount shelfAddedThematic shelfRemovedThematic"
                    ).split()]
print("keys checked per locale: %d" % len(keys))
for lang in ("ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi"):
    j = json.load(open("lib/l10n/app_%s.arb" % lang, encoding="utf-8"))
    missing = [k for k in keys if k not in j]
    same = [k for k in keys if k in j and j[k] == en[k]]
    hsk = [k for k in same if k.startswith("hskDescription")]
    print("  %-3s missing keys: %d   values identical to English: %2d (HSK descriptions: %d)" % (lang, len(missing), len(same), len(hsk)))
    if same:
        print("      " + ", ".join(same[:10]))