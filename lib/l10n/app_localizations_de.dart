// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get originStoryChip => '📜 Ursprung';

  @override
  String get ancientFormChip => '🏺 Alte Form';

  @override
  String get threeMoreWordsChip => '📖 3 weitere Wörter';

  @override
  String get wordFamilyChip => '🔗 Wortfamilie';

  @override
  String get idiomChip => '🀄 Redewendung';

  @override
  String get proverbChip => '💬 Sprichwort';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'Gibt es eine chinesische Redewendung (成语), die dieses Schriftzeichen enthält?';

  @override
  String get strokeOrderChip => '✏️ Strichfolge';

  @override
  String get calligraphyTipChip => '🎨 Kalligrafie-Tipp';

  @override
  String get grammarNoteChip => '📝 Grammatik-Hinweis';

  @override
  String get similarWordsChip => '🔄 Ähnliche Wörter';

  @override
  String get culturalNoteChip => '🏮 Kultureller Hinweis';

  @override
  String get inMediaChip => '🀄 In den Medien';

  @override
  String get radicalMeaningChip => '🧩 Radikal-Bedeutung';

  @override
  String get componentBreakdownChip => '🔍 Komponenten-Aufschlüsselung';

  @override
  String get toneTipChip => '🎵 Ton-Tipp';

  @override
  String get homophonesChip => '👯 Homophone';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Frage mich alles über $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'KI-Tutor-Fehler: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'Der KI-Tutor ist gerade beschäftigt. Bitte warte einen Moment und versuche es erneut.';

  @override
  String get deleteAccount => 'Account löschen';

  @override
  String get deleteAccountSubtitle => 'Account dauerhaft löschen';

  @override
  String get deleteAccountTitle => 'Account dauerhaft löschen?';

  @override
  String get accountDataDeletedTitle => 'Accountdaten werden gelöscht';

  @override
  String get accountDataDeletedBody =>
      'Dein Anmeldekonto und die von SinoSpark gespeicherten Accountinformationen werden dauerhaft gelöscht. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get localDataKeptTitle => 'Daten auf diesem Gerät bleiben erhalten';

  @override
  String get localDataKeptBody =>
      'Lernfortschritt, Downloads und Einstellungen, die nur auf diesem Gerät gespeichert sind, werden nicht entfernt.';

  @override
  String get subscriptionNotCanceledTitle =>
      'Abonnements werden nicht gekündigt';

  @override
  String get subscriptionNotCanceledBody =>
      'Das Löschen des Accounts kündigt kein App-Store-Abonnement. Es verlängert sich weiter, bis du es bei Apple kündigst.';

  @override
  String get manageSubscription => 'App-Store-Abonnement verwalten';

  @override
  String get subscriptionManagementFailed =>
      'Die Apple-Abonnementverwaltung konnte nicht geöffnet werden. Öffne die Einstellungen, tippe auf deinen Namen und dann auf Abonnements.';

  @override
  String get confirmPassword => 'Aktuelles Passwort';

  @override
  String get confirmPasswordToDelete =>
      'Gib dein Passwort ein, um deine Identität zu bestätigen.';

  @override
  String get deleteAccountPermanently => 'Account dauerhaft löschen';

  @override
  String get deleteAccountFinalTitle => 'Letzte Bestätigung';

  @override
  String get deleteAccountFinalWarning =>
      'Dein Account wird dauerhaft gelöscht. Dies kann nicht rückgängig gemacht werden. Nur auf diesem Gerät gespeicherte Daten bleiben erhalten. Fortfahren?';

  @override
  String get deletingAccount => 'Account wird gelöscht...';

  @override
  String get accountPasswordRequired =>
      'Gib dein aktuelles Passwort ein, um fortzufahren.';

  @override
  String get accountPasswordIncorrect =>
      'Das Passwort ist falsch. Bitte versuche es erneut.';

  @override
  String get accountReauthenticationCanceled =>
      'Die Identitätsbestätigung wurde abgebrochen. Dein Account wurde nicht gelöscht.';

  @override
  String get accountReauthenticationFailed =>
      'Deine Identität konnte nicht bestätigt werden. Versuche es erneut und schließe die Anmeldung ab.';

  @override
  String get accountAlreadySignedOut =>
      'Du bist bereits abgemeldet. Es wurde kein Account gelöscht.';

  @override
  String get accountProviderUnsupported =>
      'Diese Anmeldemethode kann in der App nicht überprüft werden. Kontaktiere den Support.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'Ein mit Apple verknüpfter Account muss aus Sicherheitsgründen auf einem Apple-Gerät gelöscht werden.';

  @override
  String get accountDeletionNetworkError =>
      'Prüfe deine Internetverbindung und versuche erneut, den Account zu löschen.';

  @override
  String get accountDeletionFailed =>
      'Der Account konnte nicht gelöscht werden und bleibt aktiv. Bitte versuche es erneut.';

  @override
  String get accountDeletedSuccessfully =>
      'Dein Account wurde dauerhaft gelöscht.';

  @override
  String get globalMastery => 'GLOBALE MEISTERSCHAFT';

  @override
  String get masteredCards => 'Gemeistert';

  @override
  String get hsk1Candidate => 'HSK 1 Kandidat';

  @override
  String get hsk2Candidate => 'HSK 2 Kandidat';

  @override
  String get hsk3Candidate => 'HSK 3 Kandidat';

  @override
  String get hsk4Candidate => 'HSK 4 Kandidat';

  @override
  String get hsk5Candidate => 'HSK 5 Kandidat';

  @override
  String get hsk6Candidate => 'HSK 6 Kandidat';

  @override
  String get hsk6Master => 'HSK 6 Meister';

  @override
  String get currentRank => 'AKTUELLER RANG';

  @override
  String get next => 'Weiter';

  @override
  String get searchHanziOrPinyin => 'Hanzi oder Pinyin suchen...';

  @override
  String get dailyReview => 'Tägliche Wiederholung';

  @override
  String get upcomingForecast => 'Vorschau';

  @override
  String get laterToday => 'Heute später';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get next7Days => 'Nächste 7 Tage';

  @override
  String get theScholarWay => 'Der Weg des Gelehrten';

  @override
  String get beginJourney => 'Reise beginnen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get darkModeDesc => 'Schont die Augen';

  @override
  String get voiceSpeed => 'Sprechgeschwindigkeit';

  @override
  String get artAndIntellect => 'KUNST & INTELLEKT';

  @override
  String get theDigitalScholar => 'Der digitale Gelehrte';

  @override
  String get refineBrushVoice =>
      'Verfeinere Pinselstrich und Aussprache mit KI.';

  @override
  String get liveVoiceCall => 'Live-Sprachanruf';

  @override
  String get immersiveRoleplay => 'Immersives Rollenspiel mit KI-Avataren';

  @override
  String get readingRoom => 'Lesesaal';

  @override
  String get shadowingStudio => 'Shadowing-Studio';

  @override
  String get errorPrefix => 'Fehler: ';

  @override
  String get initializingLibrary => 'Bibliothek wird initialisiert...';

  @override
  String get unlockCharactersToQuiz => 'Schalte 4 Zeichen für ein Quiz frei!';

  @override
  String get practiceQuiz => 'QUIZ';

  @override
  String get curriculumPaths => 'LERNPFADE';

  @override
  String get noDecksFound => 'Keine Decks gefunden. Füge welche hinzu!';

  @override
  String get addCardsFirst => 'Füge zuerst Karten hinzu!';

  @override
  String get aiDraftingPath => 'KI erstellt deinen Pfad...';

  @override
  String get pathReady => 'Pfad bereit!';

  @override
  String get errorGeneratingPath => 'Fehler beim Erstellen des Pfads';

  @override
  String get brushingCurriculum => 'Pfad wird erstellt...';

  @override
  String get warmUp => 'AUFWÄRMEN';

  @override
  String get lessonComplete => 'Lektion abgeschlossen! +10 Tintenpunkte';

  @override
  String get step1Origin => 'SCHRITT 1: URSPRUNG';

  @override
  String get traceRadical => 'Radikal nachzeichnen';

  @override
  String get step2Forge => 'SCHRITT 2: SCHMIEDE';

  @override
  String get chooseEssence => 'Wähle die Essenz';

  @override
  String get wrongEssence => 'Falsch! Versuche es erneut.';

  @override
  String get step3Hunt => 'SCHRITT 3: JAGD';

  @override
  String get findCharacters => 'Finde die Zeichen';

  @override
  String get notThatOne => 'Nicht dieses!';

  @override
  String get successfullyInstalled => 'Erfolgreich installiert:';

  @override
  String get failedToDownload => 'Download fehlgeschlagen.';

  @override
  String get rescindTitle => 'Rückgängig machen?';

  @override
  String get removeCharactersWarning =>
      'Dadurch werden diese Zeichen entfernt.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get uninstall => 'Deinstallieren';

  @override
  String get removedLibrary => 'Entfernt:';

  @override
  String get tomeLibrary => 'Bibliothek';

  @override
  String get libraryError => 'Bibliotheksfehler';

  @override
  String get installTome => 'INSTALLIEREN';

  @override
  String get unitIntro => 'LEKTIONS-INTRO';

  @override
  String get constellationCluster => 'Sternbild-Gruppe';

  @override
  String get ok => 'OK';

  @override
  String get divingInto => 'Eintauchen in...';

  @override
  String get keyRadicals => 'SCHLÜSSELRADIKALE';

  @override
  String get noRadicalData => 'Keine Daten vorhanden.';

  @override
  String get discovery => 'ENTDECKUNG';

  @override
  String get startLearning => 'STARTEN';

  @override
  String get selectPersona => 'Persona wählen';

  @override
  String get customPersona => 'Eigene Persona';

  @override
  String get geminiLiveCall => 'LIVE-ANRUF';

  @override
  String get returnToMenu => 'Zurück zum Menü';

  @override
  String get strokeAnalysis => 'Strichfolgen-Analyse';

  @override
  String get excellentWork => 'Hervorragende Arbeit!';

  @override
  String get keepPracticing => 'Weiter üben!';

  @override
  String get drawingSubmitted => 'Zeichnung übermittelt';

  @override
  String get customPersonaHint => 'Definiere eine eigene Persona...';

  @override
  String get stepOneOrigin => 'SCHRITT 1: URSPRUNG';

  @override
  String get stepTwoForge => 'SCHRITT 2: SCHMIEDE';

  @override
  String get toForge => 'Zu schmieden';

  @override
  String get whatEssenceDoesNeed => 'Welche Essenz braucht';

  @override
  String get need => 'braucht';

  @override
  String get forged => 'GESCHMIEDET';

  @override
  String get stepThreeHunt => 'SCHRITT 3: JAGD';

  @override
  String get findCharactersWith => 'Finde Zeichen mit';

  @override
  String get uninstallButton => 'DEINSTALLIEREN';

  @override
  String get gradedAiStories => 'Gestufte KI-Geschichten';

  @override
  String get calligraphy => 'Kalligrafie';

  @override
  String get theScrollOfOrigin => 'Die Schriftrolle des Ursprungs';

  @override
  String get galaxyOf => 'Galaxie von';

  @override
  String get constellationDescription => 'Beschreibung des Sternbilds';

  @override
  String get noRadicalDataAvailable => 'Keine Radikaldaten verfügbar';

  @override
  String get learningPreferences => 'Lerneinstellungen';

  @override
  String get hardMode => 'Schwerer Modus';

  @override
  String get hardModeDesc =>
      'Erfordert präzise Eingaben ohne visuelle Hilfestellungen.';

  @override
  String get adaptiveGuidance => 'Adaptive Lernführung';

  @override
  String get dailyGoal => 'Tagesziel';

  @override
  String get audioAndHaptics => 'Audio & Haptik';

  @override
  String get autoPlayAudio => 'Audio automatisch abspielen';

  @override
  String get autoPlayDesc =>
      'Spielt die Aussprache beim Aufdecken einer Karte automatisch ab.';

  @override
  String get haptics => 'Haptisches Feedback';

  @override
  String get displayAndContent => 'Anzeige & Inhalt';

  @override
  String get useEnglishDefinitions => 'Englische Definitionen verwenden';

  @override
  String get useEnglishDefinitionsDesc =>
      'Englische Definitionen sind in der Regel genauer und detaillierter';

  @override
  String get animationSpeed => 'Animationsgeschwindigkeit';

  @override
  String get manageTomes => 'Bände verwalten';

  @override
  String get manageTomesDesc => 'Verwalte deine installierten Lernbände.';

  @override
  String get dangerZone => 'Gefahrenbereich';

  @override
  String get resetAllData => 'Alle Daten zurücksetzen';

  @override
  String get resetDataDesc =>
      'Hiermit werden alle deine Fortschrittsdaten, Statistiken und Einstellungen dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get areYouSure => 'Bist du sicher?';

  @override
  String get cannotBeUndone => 'Kann nicht rückgängig gemacht werden';

  @override
  String get deleteEverything => 'Alles löschen';

  @override
  String get appLanguage => 'App-Sprache';

  @override
  String get howDidYouDo => 'Wie lief es?';

  @override
  String get missedItEntirely => 'Ganz vergessen';

  @override
  String get gotItButStruggled => 'Gewusst, aber mit Mühe';

  @override
  String get gotItClearly => 'Sicher gewusst';

  @override
  String get perfectAndImmediate => 'Perfekt & sofort';

  @override
  String get again => 'Wiederholen';

  @override
  String get hard => 'Schwer';

  @override
  String get good => 'Gut';

  @override
  String get easy => 'Leicht';

  @override
  String get tapToReveal => 'Tippen zum Aufdecken';

  @override
  String get howWellDidYouRemember => 'Wie gut hast du dich erinnert?';

  @override
  String get completelyForgot => 'Komplett vergessen';

  @override
  String get gotItWithDifficulty => 'Mit Mühe erinnert';

  @override
  String get recalledCorrectly => 'Richtig erinnert';

  @override
  String get perfectRecall => 'Perfekte Erinnerung';

  @override
  String get practiceWriting => 'Schreiben üben';

  @override
  String get hideScratchpad => 'Notizblock ausblenden';

  @override
  String get whatCharacterMeans => 'Bedeutung des Zeichens:';

  @override
  String get tapCardToReveal => 'Karte antippen zum Aufdecken';

  @override
  String get ratePronunciationConfidence =>
      'Bewerte deine Aussprache-Sicherheit';

  @override
  String get botchedIt => 'Völlig verpatzt';

  @override
  String get struggledWithTones => 'Probleme mit den Tönen';

  @override
  String get acceptable => 'Akzeptabel';

  @override
  String get perfectlyNatural => 'Völlig natürlich';

  @override
  String get sessionComplete => 'Lektion beendet!';

  @override
  String get accuracy => 'Genauigkeit';

  @override
  String get reviewed => 'Wiederholt';

  @override
  String get correct => 'Richtig';

  @override
  String get backToLibrary => 'Zurück zur Bibliothek';

  @override
  String get revealAnswer => 'Antwort aufdecken';

  @override
  String get aiHubTitle => 'KI-Zentrum';

  @override
  String get textChat => 'Text-Chat';

  @override
  String get scholarlyPersonas => 'Gelehrten-Personas';

  @override
  String get shadowing => 'Shadowing';

  @override
  String get liveTranslation => 'Live-Übersetzung';

  @override
  String get scholarsLibrary => 'Die Bibliothek des Gelehrten';

  @override
  String get generate => 'Generieren';

  @override
  String get searchPinyinHanziEnglish =>
      'Nach Pinyin, Hanzi oder Deutsch suchen...';

  @override
  String get liveTranslate => 'Live übersetzen';

  @override
  String get travelInterpreter => 'Reise-Dolmetscher';

  @override
  String get realTimeSplitScreen =>
      'Echtzeit-Splitscreen-Unterhaltung mit Muttersprachlern. Beseitigt Sprachbarrieren sofort.';

  @override
  String get whisperEarpiece => 'Dolmetscher-Ohrhörer';

  @override
  String get listenToChineseAudio =>
      'Höre chinesische Audioinhalte und erhalte deutsche Echtzeit-Untertitel direkt auf deinem Bildschirm.';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get yourMindIsClear => 'Alles erledigt für heute!';

  @override
  String get noReviewsDueToday => 'Heute sind keine Wiederholungen fällig.';

  @override
  String get done => 'Fertig';

  @override
  String get hskLevel1 => 'HSK Stufe 1';

  @override
  String get hskLevel2 => 'HSK Stufe 2';

  @override
  String get hskLevel3 => 'HSK Stufe 3';

  @override
  String get hskLevel4 => 'HSK Stufe 4';

  @override
  String get hskLevel5 => 'HSK Stufe 5';

  @override
  String get hskLevel6 => 'HSK Stufe 6';

  @override
  String get generalVocabulary => 'Allgemeiner Wortschatz';

  @override
  String cardsRequireAttention(Object count) {
    return '$count Karten müssen wiederholt werden.';
  }

  @override
  String get begin => 'Starten';

  @override
  String get poweredByAi =>
      'Angetrieben von fortschrittlicher KI. Nahtlose Echtzeitübersetzung für jede Situation.';

  @override
  String get downloadingModel => 'Modell wird heruntergeladen...';

  @override
  String get soon => 'BALD';

  @override
  String get installed => 'INSTALLIERT';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'KERNMODUL';

  @override
  String get step6Context => 'SCHRITT 6: KONTEXT';

  @override
  String get tapBuildingBlocksTo =>
      'Tippe auf die Bausteine, um ihren Ursprung zu erkunden.';

  @override
  String get initiateRadicalSequence => 'RADIKALSEQUENZ STARTEN';

  @override
  String get holdToTalk => 'Halten zum Sprechen';

  @override
  String get customScenario => 'Eigenes Szenario';

  @override
  String get voiceCall => 'Sprachanruf';

  @override
  String get pronunciation => 'Aussprache';

  @override
  String get selectAScenarioTo =>
      'Wähle ein Szenario, um dein gesprochenes Mandarin zu üben. Der Gelehrte bewertet deine Töne und Klarheit.';

  @override
  String get create => 'Erstellen';

  @override
  String get createYourScenario => 'Erstelle dein Szenario';

  @override
  String get difficulty => 'Schwierigkeit';

  @override
  String get scholarsVerdict => 'URTEIL DES GELEHRTEN';

  @override
  String get completeReview => 'Überprüfung abschließen';

  @override
  String get conversationReview => 'GESPRÄCHSÜBERPRÜFUNG';

  @override
  String get linguisticAnalysis => 'Linguistische Analyse';

  @override
  String get examplesInHsk1 => 'BEISPIELE IN HSK 1';

  @override
  String get characterReference => 'Zeichenreferenz';

  @override
  String get askTutor => 'Tutor fragen';

  @override
  String get addToStudyDeck => 'Zum Lern-Deck hinzufügen';

  @override
  String get startPractice => 'ÜBUNG STARTEN';

  @override
  String get noOtherHsk1 =>
      'Keine anderen HSK 1 Zeichen verwenden dieses Radikal.';

  @override
  String get couldNotLoadAi =>
      'KI-Kontext konnte nicht geladen werden. (Ratenlimit oder Netzwerkfehler)\nVersuche es später erneut, indem du unten auf Aktualisieren tippst.';

  @override
  String get noAvailableCardsFound => 'Keine verfügbaren Karten gefunden.';

  @override
  String get addCards => 'Karten hinzufügen';

  @override
  String get removeCard => 'Karte entfernen';

  @override
  String get remove => 'Entfernen';

  @override
  String get review => 'Überprüfen';

  @override
  String get story => 'Geschichte';

  @override
  String get thisDeckIsEmpty => 'Dieses Deck ist leer.';

  @override
  String get tapTheAddCards => 'Tippe auf „Karten hinzufügen“!';

  @override
  String get noCardsFound => 'Keine Karten gefunden.';

  @override
  String get addCardsToSee => 'Füge Karten hinzu, um Statistiken zu sehen.';

  @override
  String get aiGenerated => 'KI-generiert';

  @override
  String get allCardsCaughtUp => 'Alle Karten wiederholt! Sehr gut gemacht.';

  @override
  String get latestDiscoveries => 'Neueste Entdeckungen';

  @override
  String get noCharactersInLexicon => 'Noch keine Zeichen im Lexikon.';

  @override
  String get yourBookshelf => 'Dein Bücherregal';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Suche in deinem Wörterbuch...';

  @override
  String get saveCard => 'Karte speichern';

  @override
  String get noCharactersFound => 'Keine Zeichen gefunden.';

  @override
  String get radicalsIndex => 'Radikal-Index';

  @override
  String get masteringRadicalsIsThe =>
      'Das Meistern von Radikalen ist der Schlüssel, um Tausende Hanzi zu verstehen. Wähle ein Radikal aus, um alle zugehörigen Zeichen zu sehen.';

  @override
  String get noRadicalsFound => 'Keine Radikale gefunden.';

  @override
  String get yourDrawing => 'Deine Zeichnung';

  @override
  String get reference => 'Referenz';

  @override
  String get rateYourRecall => 'Bewerte deine Erinnerung';

  @override
  String get contactUs => 'Kontaktiere uns';

  @override
  String get reportBugsOrRequest => 'Fehler melden oder Funktionen vorschlagen';

  @override
  String get allDataHasBeen => 'Alle Daten wurden gelöscht.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Mein Fortschritt';

  @override
  String get overview => 'Übersicht';

  @override
  String get aiStory => 'KI-Geschichte';

  @override
  String get usingYourDecksVocabulary =>
      'Verwendet den Wortschatz deines Decks';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get translate => 'Übersetzen';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Vollständige Übersetzung';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash strukturiert deine Geschichte...';

  @override
  String get aiDeckGenerator => 'KI-Deck-Generator';

  @override
  String get whatDoYouWant => 'Was möchtest du lernen?';

  @override
  String get targetDifficulty => 'Zielschwierigkeit';

  @override
  String get focusArea => 'Schwerpunkt';

  @override
  String get specificContextOrTone =>
      'Spezifischer Kontext oder Tonfall (optional)';

  @override
  String get numberOfCards => 'Anzahl der Karten';

  @override
  String get generateDeck => 'Deck generieren';

  @override
  String get aiGrammarExplanation => 'KI-Grammatikerklärung';

  @override
  String get scholarsDesk => 'Schreibtisch des Gelehrten';

  @override
  String get chooseADeck => 'Wähle ein Deck';

  @override
  String get whereWouldYouLike => 'Wo möchtest du dieses Zeichen speichern?';

  @override
  String whereWouldYouLikeWords(int count) {
    return 'Wo möchtest du diese $count Wörter speichern?';
  }

  @override
  String deckItemsCount(int count) {
    return '$count Einträge';
  }

  @override
  String get addToDefaultStudy => 'Zum Standard-Lern-Deck hinzufügen';

  @override
  String get ifOffItsOnly =>
      'Wenn deaktiviert, wird es nur im globalen Wörterbuch gespeichert';

  @override
  String get saveToLibrary => 'In Bibliothek speichern';

  @override
  String get pleaseEnterValidChinese =>
      'Bitte gib gültige chinesische Zeichen ein';

  @override
  String get reviewAiCard => 'KI-Karte überprüfen';

  @override
  String get pleaseDoublecheckTheAis =>
      'Bitte überprüfe die KI-Ausgabe unten. Du kannst Pinyin oder die Definition anpassen, bevor du sie in deiner Bibliothek speicherst.';

  @override
  String get alreadyInYourLibrary => 'Bereits in deiner Bibliothek!';

  @override
  String get meaningInContext => 'Bedeutung im Kontext';

  @override
  String get explainGrammar => 'Grammatik erklären';

  @override
  String get addToLibrary => 'Zur Bibliothek hinzufügen';

  @override
  String get masterYourMandarinPronunciation =>
      'Meistere deine Mandarin-Aussprache durch Echtzeit-Nachsprechen (Shadowing).';

  @override
  String get startSession => 'SITZUNG STARTEN';

  @override
  String get sessionHistory => 'Sitzungsverlauf';

  @override
  String get noSavedSessions => 'Keine gespeicherten Sitzungen.';

  @override
  String get aiBreakdown => 'KI-Analyse';

  @override
  String get sessionDetails => 'Sitzungsdetails';

  @override
  String partner(Object lang) {
    return 'Partner ($lang)';
  }

  @override
  String get youEnglish => 'Du (Deutsch)';

  @override
  String get noTranscriptToSave => 'Kein Transkript zum Speichern vorhanden!';

  @override
  String get sessionSaved => 'Sitzung gespeichert!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Bidirektionale Echtzeit-Übersetzung. Sprich Deutsch oder Mandarin, und es wird sofort für dich und deinen Partner übersetzt.';

  @override
  String get text_1782026184665 => 'Aufnahme';

  @override
  String get recording => 'Aufnahme';

  @override
  String get yourSilentCompanionListen =>
      'Dein stiller Begleiter. Höre Mandarin und erhalte sofort die deutsche Übersetzung.';

  @override
  String get startListening => 'ZUHÖREN STARTEN';

  @override
  String get skip => 'Überspringen';

  @override
  String get independentStars => 'UNABHÄNGIGE STERNE';

  @override
  String get notEveryCharacterHas =>
      'Nicht jedes Zeichen hat ein übergeordnetes Radikal. Einige sind eigenständige Piktogramme.';

  @override
  String get onTheMapWe =>
      'Auf der Karte gruppieren wir diese unabhängigen Zeichen in KONSTELLATIONEN (✨).';

  @override
  String get iUnderstand => 'VERSTANDEN';

  @override
  String get whatAreRadicals => 'WAS SIND RADIKALE?';

  @override
  String get hanziAreBuiltFrom =>
      'Hanzi bestehen aus Bausteinen namens RADIKALE.\nSie verleihen dem Zeichen seine Kernbedeutung oder sein Thema.';

  @override
  String get continueText => 'WEITER';

  @override
  String get hanziAreNotJust =>
      'Hanzi sind nicht nur Buchstaben, sondern Bilder, die in der Zeit eingefroren sind.\nUm sie zu meistern, musst du lernen, ihrem Strichfluss zu folgen.';

  @override
  String get iAmReady => 'ICH BIN BEREIT';

  @override
  String get youAreAScholar => 'DU BIST EIN GELEHRTER';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'Die Galaxiekarte erwartet dich.\nMeistere die Sonnen (Radikale), um die Planeten (Zeichen) freizuschalten.';

  @override
  String get enterTheScroll => 'SCHRIFTROLLE ÖFFNEN';

  @override
  String get openingTheOriginScroll => 'Ursprungsrolle wird geöffnet...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Die Gelehrten-Edition';

  @override
  String get weArePreparingThe =>
      'Wir bereiten die Gelehrten-Edition für den Start vor.';

  @override
  String get devBypassUnlockNow => 'DEV-BYPASS: JETZT FREISCHALTEN';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get welcomeScholarTheScroll =>
      'Willkommen, Gelehrter. Die Schriftrolle steht dir vollständig offen.';

  @override
  String get purchasesRestoredSuccessfully =>
      'Käufe erfolgreich wiederhergestellt.';

  @override
  String get noPreviousPurchasesFound =>
      'Keine früheren Käufe für dieses Konto gefunden.';

  @override
  String get unlockTheFullPotential =>
      'Entfalte das volle Potenzial deiner Lernreise. Einmaliger Kauf, für immer dein.';

  @override
  String get universalScanner => 'Universal-Scanner';

  @override
  String get noChineseCharactersFound =>
      'Keine chinesischen Zeichen im Bild gefunden.';

  @override
  String get addedNewCharactersTo =>
      'Neue Zeichen zu deiner Bibliothek hinzugefügt!';

  @override
  String get extractingTextAndObjects =>
      'Text und Objekte werden extrahiert...';

  @override
  String get scanATextbookSign =>
      'Scanne ein Lehrbuch, Schild oder Objekt, um chinesische Zeichen zu extrahieren.';

  @override
  String get extractedText => 'Extrahierter Text';

  @override
  String get useText => 'Text verwenden';

  @override
  String get noMatchingDictionaryEntries =>
      'Keine passenden Wörterbucheinträge gefunden.';

  @override
  String get quizComplete => 'Quiz abgeschlossen!';

  @override
  String get returnToCourse => 'Zurück zum Kurs';

  @override
  String get notEnoughCardsFor =>
      'Nicht genügend Karten für ein Quiz! Mindestens 4 Karten erforderlich.';

  @override
  String get creatorMode => 'Erstellermodus';

  @override
  String get noStoriesFoundMatching =>
      'Keine Geschichten gefunden, die deiner Suche entsprechen.';

  @override
  String get discard => 'Verwerfen';

  @override
  String get save => 'Speichern';

  @override
  String get generatingStoryViaDeepseek =>
      'Geschichte wird über DeepSeek generiert...';

  @override
  String get storySavedToLibrary => 'Geschichte in Bibliothek gespeichert!';

  @override
  String get storyNotFound => 'Geschichte nicht gefunden.';

  @override
  String get targetHskLevel => 'Ziel-HSK-Niveau';

  @override
  String get wedLoveToHear => 'Wir freuen uns auf dein Feedback!';

  @override
  String get whetherYouveFoundA =>
      'Egal, ob du einen Fehler gefunden hast, ein Feature vorschlagen oder einfach Hallo sagen möchtest: Dein Feedback hilft uns, SinoSpark zu verbessern.';

  @override
  String get pointYourCameraAt => 'Richte deine Kamera auf Objekte';

  @override
  String get reviewAddToLibrary => 'Überprüfen & zur Bibliothek hinzufügen';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Strichführung ausblenden bei Serie: $streak';
  }

  @override
  String inkPoints(Object points) {
    return '$points Tintenpunkte';
  }

  @override
  String speechRateMultiplier(Object rate) {
    return '${rate}x';
  }

  @override
  String animationSpeedMultiplier(Object rate) {
    return '${rate}x';
  }

  @override
  String get supportAndFeedback => 'Support und Feedback';

  @override
  String get reportBug => 'Fehler melden';

  @override
  String get suggestFeature => 'Funktion vorschlagen';

  @override
  String get generalFeedback => 'Allgemeines Feedback';

  @override
  String get pleaseDrawSomethingFirst => 'Bitte zeichne zuerst etwas';

  @override
  String get drawThisCharacter => 'Zeichne dieses Zeichen:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Folge der blauen Linie, um Strich $current von $total zu zeichnen';
  }

  @override
  String get skipCurrentStroke => 'Aktuellen Strich überspringen';

  @override
  String get submitDrawing => 'Zeichnung bestätigen';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '„$hanzi“ wurde zu „$deckName“ hinzugefügt';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '„$hanzi“ wurde aus dem Deck entfernt';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return '„$hanzi“ übersprungen – keine Strichdaten für dieses KI-Zeichen verfügbar.';
  }

  @override
  String get startingSession => 'Sitzung wird gestartet...';

  @override
  String get studySession => 'Lerneinheit';

  @override
  String get readyToStudy => 'Bereit zum Lernen';

  @override
  String get studyQueuePreviewDescription =>
      'Deine Lerneinheit basiert auf deinem heutigen Zeitplan und den Deck-Limits.';

  @override
  String get notNow => 'Nicht jetzt';

  @override
  String get newLabel => 'Neu';

  @override
  String get studyDeckEmpty => 'Dieses Deck ist leer';

  @override
  String get studyDeckEmptyDescription =>
      'Füge Karten hinzu, bevor du eine Lerneinheit startest.';

  @override
  String get studyDailyLimitReached => 'Tageslimit erreicht';

  @override
  String get studyDailyLimitReachedDescription =>
      'Du hast das heutige Limit für neue Karten oder Wiederholungen für dieses Deck erreicht.';

  @override
  String get studyCaughtUpDescription =>
      'Für heute steht nichts mehr an. Komm zur nächsten Wiederholung zurück.';

  @override
  String get noCardsAvailable => 'Keine Karten verfügbar';

  @override
  String get studyNoEligibleCardsDescription =>
      'Zurzeit sind keine Karten für diesen Lernmodus verfügbar.';

  @override
  String get studySessionLoadFailed =>
      'Lerneinheit konnte nicht geladen werden. Bitte versuche es erneut.';

  @override
  String get retryLimitReached =>
      'Diese Karte wird in deiner nächsten Lerneinheit wieder angezeigt.';

  @override
  String get masterBuildingBlocks => 'Meistere die Bausteine der Hanzi';

  @override
  String get totalWords => 'Wörter gesamt';

  @override
  String get newInk => 'Neue Tinte';

  @override
  String get learningStatus => 'Im Lernprozess';

  @override
  String get masteredStatus => 'Gemeistert';

  @override
  String get libraryMastery => 'Bibliotheks-Fortschritt';

  @override
  String get accuracyByMode => 'Genauigkeit nach Modus';

  @override
  String get upcomingReviews => 'Anstehende Wiederholungen (nächste 7 Tage)';

  @override
  String get culturalReadingRoom => 'Kultureller Lesesaal (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Bitte gib ein Thema ein';

  @override
  String createdDeckCards(Object count, Object name) {
    return '„$name“ mit $count Karten erstellt!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Bewertung: $grade';
  }

  @override
  String get listeningMode => 'Hörmodus';

  @override
  String get readingMode => 'Lesemodus';

  @override
  String get recallMode => 'Abrufmodus';

  @override
  String get speakingMode => 'Sprechmodus';

  @override
  String get aiMemoryHook => 'KI-Eselsbrücke';

  @override
  String get exampleSentences => 'Beispielsätze';

  @override
  String get ghostCharacters => 'Hilfszeichen (Vorschau)';

  @override
  String get commonWords => 'Häufige Wörter';

  @override
  String get personalNotes => 'Persönliche Notizen';

  @override
  String get addPersonalNotes =>
      'Füge hier deine eigenen Merkhilfen oder Notizen hinzu...';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get gallery => 'Galerie';

  @override
  String get arLens => 'AR-Kamera';

  @override
  String addedCharToLibrary(Object char) {
    return '„$char“ zur Bibliothek hinzugefügt';
  }

  @override
  String get scoreText => 'Punktzahl';

  @override
  String get searchDictionaryHint => 'Zeichen, Pinyin oder Bedeutung suchen...';

  @override
  String get searchDeckHint => 'Zeichen oder Pinyin suchen...';

  @override
  String get localRestaurant => 'Lokales Restaurant';

  @override
  String get taxiToAirport => 'Taxi zum Flughafen';

  @override
  String get silkMarketHaggling => 'Feilschen auf dem Seidenmarkt';

  @override
  String get medicalClinic => 'Arztpraxis';

  @override
  String get meetingAFriend => 'Einen Freund treffen';

  @override
  String get jobInterview => 'Vorstellungsgespräch';

  @override
  String get searchRadicalsHint => 'Radikale suchen (z. B. Wasser, 氵)';

  @override
  String get definition => 'Definition';

  @override
  String get undo => 'Rückgängig';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Dauerhaft freischalten – 9,99 \$';

  @override
  String get clear => 'Löschen';

  @override
  String get clearChat => 'Chat löschen';

  @override
  String get typeMessage => 'Nachricht eingeben...';

  @override
  String addedToLibrary(Object hanzi) {
    return '„$hanzi“ zur Bibliothek hinzugefügt';
  }

  @override
  String get generateNewStory => 'Neue Geschichte generieren';

  @override
  String failedToGenerateStory(Object error) {
    return 'Fehler beim Generieren der Geschichte:\n$error';
  }

  @override
  String get detail => 'Detail';

  @override
  String get scanText => 'Text scannen';

  @override
  String get createMagic => 'Magie erschaffen';

  @override
  String get learning => 'Im Lernprozess';

  @override
  String get upcomingReviews7Days =>
      'Bevorstehende Wiederholungen (nächste 7 Tage)';

  @override
  String get askFollowUpQuestion => 'Folgefrage stellen...';

  @override
  String get pasteScanToSimplify =>
      'Chinesischen Text zum Vereinfachen einfügen oder scannen';

  @override
  String get searchStoriesHint =>
      'Geschichten nach Titel oder Tags suchen (z. B. Mythologie, Reisen)';

  @override
  String get importAll => 'Alle importieren';

  @override
  String get ascendAll => 'Alle aufwerten';

  @override
  String get startAscension => 'Aufwertung starten';

  @override
  String get scenarioLocalRestaurant => 'Lokales Restaurant';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Übe das Bestellen von Gerichten und das Erfragen von Empfehlungen.';

  @override
  String get scenarioTaxiAirport => 'Taxi zum Flughafen';

  @override
  String get scenarioTaxiAirportDesc =>
      'Nenne dem Fahrer dein Ziel und sprich über den Verkehr.';

  @override
  String get scenarioSilkMarket => 'Feilschen auf dem Seidenmarkt';

  @override
  String get scenarioSilkMarketDesc =>
      'Versuche, einen besseren Preis für ein Souvenir zu verhandeln.';

  @override
  String get scenarioMedicalClinic => 'Arztpraxis';

  @override
  String get scenarioMedicalClinicDesc =>
      'Erkläre einem traditionellen Arzt deine Symptome.';

  @override
  String get scenarioMeetingFriend => 'Einen Freund treffen';

  @override
  String get scenarioMeetingFriendDesc =>
      'Stelle dich vor und halte Smalltalk.';

  @override
  String get scenarioJobInterview => 'Vorstellungsgespräch';

  @override
  String get scenarioJobInterviewDesc =>
      'Bewirb dich auf eine Stelle bei einem Tech-Unternehmen in Shanghai.';

  @override
  String get createCustomScenario => 'Eigenes Szenario erstellen';

  @override
  String get customScenarioTitleHint => 'Titel (z. B. Hochzeitsfeier)';

  @override
  String get customScenarioDescHint => 'Beschreibung (Kontext)';

  @override
  String get customScenarioPersonaHint =>
      'KI-Persona (z. B. ein neugieriger Kollege)';

  @override
  String get customScenarioDifficulty => 'Schwierigkeitsgrad';

  @override
  String get createAction => 'Erstellen';

  @override
  String get cancelAction => 'Abbrechen';

  @override
  String get mythsAndLegends => 'Mythen und Legenden';

  @override
  String get historyAndCulture => 'Geschichte und Kultur';

  @override
  String get idiomsTitle => 'Redewendungen (成语)';

  @override
  String get theMonkeyKing => 'Der Affenkönig';

  @override
  String get theMonkeyKingDesc => 'Sun Wukong (Die Reise nach Westen)';

  @override
  String get huaMulan => 'Hua Mulan';

  @override
  String get huaMulanDesc =>
      'Hua Mulan, die anstelle ihres Vaters in die Armee eintritt';

  @override
  String get confuciusTitle => 'Konfuzius';

  @override
  String get confuciusDesc => 'Das Leben und die Lehren des Konfuzius';

  @override
  String get theGreatWall => 'Die Große Mauer';

  @override
  String get theGreatWallDesc => 'Der Bau der Chinesischen Mauer';

  @override
  String get generateTopic => 'Thema generieren';

  @override
  String get simplifyText => 'Text vereinfachen';

  @override
  String get topicHint => 'Thema (z. B. Außerirdische in Peking)';

  @override
  String get tagsHint => 'Tags (kommagetrennt, optional)';

  @override
  String get speakWithMasterLin => 'Sprich mit Meister Lin';

  @override
  String get masterLinGreeting =>
      'Sei gegrüßt, Schüler. Die Tinte steht bereit. Welches Zeichen oder welchen Satz wollen wir heute untersuchen?';

  @override
  String get typeYourMessage => 'Gib deine Nachricht ein...';

  @override
  String get theMainLibrary => 'Hauptbibliothek';

  @override
  String get hsk1Foundation => 'HSK 1: Grundlagen';

  @override
  String get hsk2Elementary => 'HSK 2: Grundstufe';

  @override
  String get hsk3Intermediate => 'HSK 3: Mittelstufe';

  @override
  String get inDeckCheck => 'Im Deck ✓';

  @override
  String get addToDeckPlus => '+ Zum Deck hinzufügen';

  @override
  String get openCardArrow => 'Karte öffnen →';

  @override
  String get pronunciationPartial => 'Ungenau';

  @override
  String get pronunciationWrong => 'Falsch';

  @override
  String get toneExpected => 'Erwartet';

  @override
  String get toneYouSaid => 'Du hast gesagt';

  @override
  String get gotIt => 'Verstanden!';

  @override
  String foundNCharacters(int count) {
    return '$count Zeichen gefunden';
  }

  @override
  String get lookingUpCharacters => 'Zeichen werden gesucht…';

  @override
  String get practiceAll => 'Alle üben';

  @override
  String get arLensObjects => 'Objekte';

  @override
  String get arLensText => 'Text';

  @override
  String get arLensDetectedText => 'Erkannter Text';

  @override
  String get duration12Min => '1–2 Min.';

  @override
  String get aClassicTangDynastyPoem =>
      'Ein klassisches Gedicht der Tang-Dynastie';

  @override
  String get aClassicTangDynastyPoemBy =>
      'Ein klassisches Gedicht der Tang-Dynastie von';

  @override
  String get aStructuralComponent => 'Ein strukturelles Element.';

  @override
  String get addSelectedToDeck => 'Ausgewählte zum Deck hinzufügen';

  @override
  String addTo(Object target) {
    return 'Zu $target hinzufügen';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '„$hanzi“ zu deiner Bibliothek hinzugefügt';
  }

  @override
  String get adjustFontSize => 'Schriftgröße anpassen';

  @override
  String get againGoodEasyHard =>
      '⬅️ Wiederholen    ➡️ Gut    ⬆️ Leicht    ⬇️ Schwer';

  @override
  String get aiAnalysisFailed => 'KI-Analyse fehlgeschlagen';

  @override
  String get aiIsThinking => 'KI denkt nach...';

  @override
  String get aiSceneAnalysisFailed => 'KI-Szenenanalyse fehlgeschlagen';

  @override
  String get allLabel => 'Alle';

  @override
  String get allPinyin => 'Alle Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Bereits registriert? Anmelden';

  @override
  String get analysisFailed => 'Analyse fehlgeschlagen:';

  @override
  String get analyzingClassicalCharacters =>
      'Klassische Zeichen werden analysiert...';

  @override
  String get anatomy => 'Anatomie';

  @override
  String get ancientPhilosophy => 'Antike Philosophie';

  @override
  String get warringStates => 'Zeit der Streitenden Reiche';

  @override
  String get hanFeiLegalism =>
      'Han Fei (ca. 280–233 v. Chr.) war ein Prinz des Staates Han und der bedeutendste Denker des chinesischen Legalismus. Indem er die Ideen von Gesetz, Verwaltungstechnik und Autorität zusammenführte, beeinflussten seine Schriften im Han Feizi die politische Philosophie und die Institutionen des chinesischen Kaiserreichs maßgeblich.';

  @override
  String get articleSavedToMediaHub => 'Artikel im Medien-Hub gespeichert!';

  @override
  String get askAFollowUp => 'Eine Folgefrage stellen...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Audio, Datenschutz und Funktionsweise';

  @override
  String get audiobookPlayer => 'Hörbuch-Player';

  @override
  String get audiobookVoice => 'Hörbuch-Stimme';

  @override
  String get auntieMaTown =>
      'Tante Ma (马阿姨), eine energische Standbesitzerin, die die knusprigsten Roujiamo und Liangpi der Stadt zubereitet.';

  @override
  String get back => 'Zurück';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯), ein leidenschaftlicher junger Kaffeeröster, der gerne über Yunnan-Kaffeebohnen und Geschmacksnoten spricht.';

  @override
  String get bbc => 'BBC Chinesisch';

  @override
  String get beginYourJourney => 'Starte deine Reise';

  @override
  String get bestValue => 'Bestes Preis-Leistungs-Verhältnis';

  @override
  String get bookLinkCopiedToClipboard =>
      'Buchlink in die Zwischenablage kopiert!';

  @override
  String get bookmarkChapter => 'Kapitel mit Lesezeichen versehen';

  @override
  String get bookmarks => 'Lesezeichen';

  @override
  String get books => 'Bücher';

  @override
  String get briefing => 'Briefing';

  @override
  String get bugReport => 'Fehlerbericht';

  @override
  String get caoXueqinDecline =>
      'Cao Xueqin (ca. 1715–1763) war ein Romanautor der Qing-Dynastie, der in eine einst wohlhabende Bannerträgerfamilie hineingeboren wurde, deren Vermögen unter Kaiser Yongzheng zusammenbrach. Der Traum der Roten Kammer, in seinen von Armut geprägten letzten Jahren geschrieben, gilt weithin als Höhepunkt der chinesischen Literatur – ein riesiges, psychologisch vielschichtiges Panorama des aristokratischen Niedergangs.';

  @override
  String get cardsTitle => 'KARTEN';

  @override
  String get cc => 'Untertitel (CC)';

  @override
  String get characterOrWord => 'Zeichen / Wort';

  @override
  String get chatMore => 'Weiterchatten';

  @override
  String get chefChenShumai =>
      'Koch Chen (陈师傅), ein fröhlicher kantonesischer Dim-Sum-Koch, der frische Har Gow Garnelenknödel und Shumai empfiehlt.';

  @override
  String get chineseEpics => 'Chinesische Epen';

  @override
  String get chinesePoetry => 'Chinesische Poesie';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => 'Scharfes Chongqing-Hotpot-Festmahl';

  @override
  String get chooseAudiobookVoice => 'Hörbuch-Stimme wählen';

  @override
  String get chooseVoice => 'Stimme wählen';

  @override
  String get compare => 'Vergleichen';

  @override
  String get compare4Tones => '4 Töne vergleichen';

  @override
  String get configuration => 'Konfiguration';

  @override
  String get contemporary => 'Zeitgenössisch';

  @override
  String get context => 'Kontext';

  @override
  String get couldNotLoadLibrary => 'Bibliothek konnte nicht geladen werden';

  @override
  String get couldNotLoadVocabulary => 'Vokabular konnte nicht geladen werden.';

  @override
  String get couldNotOpenEmailApp => 'E-Mail-App konnte nicht geöffnet werden.';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get createNewDeck => 'Neues Deck erstellen';

  @override
  String get createScenario => 'Szenario erstellen';

  @override
  String get createStory => 'Geschichte erstellen';

  @override
  String get customLabel => 'Benutzerdefiniert';

  @override
  String get customWord => 'Benutzerdefiniertes Wort';

  @override
  String get days => 'Tage';

  @override
  String get deck => 'Stapel';

  @override
  String get deckName => 'Deck-Name';

  @override
  String get deckStory => 'Deck-Geschichte';

  @override
  String get deepAnalysis => 'Tiefenanalyse';

  @override
  String get defaultDeck => 'Standard-Deck';

  @override
  String get deleteLabel => 'Löschen';

  @override
  String get deleteScenario => 'Szenario löschen';

  @override
  String get deletesAllProgressPermanently =>
      'Löscht unwiderruflich alle Fortschritte';

  @override
  String get developerBackdoorUnlocked =>
      'Entwickler-Hintertür freigeschaltet!';

  @override
  String get doesNotExistInChinese => 'Existiert nicht im Chinesischen';

  @override
  String get dontHaveAccountSignUp => 'Noch kein Konto? Registrieren';

  @override
  String get draftingStoryOutline =>
      'Entwurf der Story-Gliederung wird erstellt...';

  @override
  String get dynamicFlowState => 'Dynamischer Flusszustand';

  @override
  String get dynamicFlowStateParenthetical => 'Dynamisch (Flusszustand)';

  @override
  String get editCard => 'Karte bearbeiten';

  @override
  String get egAnimeVocab => 'z. B. Anime-Vokabular';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'z. B. formelle Geschäftssprache, SMS-Slang...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'z. B. Restaurantbestellung, Geschäftsvokabular...';

  @override
  String get egWeddingReceptionTechInterview =>
      'z. B. Hochzeitsfeier, Tech-Interview...';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get english => 'Englisch';

  @override
  String get englishAndWorld => 'Englisch & Welt';

  @override
  String get episodes => 'Episoden';

  @override
  String get erase => 'Löschen';

  @override
  String get eraseDeckQuestion => 'Deck löschen?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Fehler beim Abrufen der Übersetzung für $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Fehler beim Laden der Mikro-Lektüren: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Fehler beim Laden der Romane: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Fehler beim Laden der Gedichte: $e';
  }

  @override
  String get exitFocus => 'Fokus beenden';

  @override
  String get explore => 'Entdecken';

  @override
  String get exportToThisDeck => 'In dieses Deck exportieren';

  @override
  String get extractAndSimplify => 'Extrahieren & Vereinfachen';

  @override
  String get failedToCreateDeck => 'Deck konnte nicht erstellt werden';

  @override
  String get failedToLoadDailyContent =>
      'Tagesinhalte konnten nicht geladen werden';

  @override
  String get failedToLoadEpisodes => 'Episoden konnten nicht geladen werden';

  @override
  String get failedToLoadShows => 'Sendungen konnten nicht geladen werden';

  @override
  String get finalizingDetails => 'Details werden finalisiert...';

  @override
  String get finalizingStoryDetails => 'Story-Details werden finalisiert...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth ist nicht aktiviert. Bitte aktiviere die erforderliche Anmeldemethode in deiner Firebase Console.';

  @override
  String get flashcardDeckTitle => 'LERNKARTEN-DECK';

  @override
  String get focus => 'Fokus';

  @override
  String get foodAndCooking => 'Essen & Kochen';

  @override
  String get forward => 'Weiter';

  @override
  String get freeFlow => 'Freier Fluss';

  @override
  String get frenchClassics => 'Französische Klassiker';

  @override
  String get full => 'Vollständig';

  @override
  String get gamingAndEsports => 'Gaming & E-Sport';

  @override
  String get germanClassics => 'Deutsche Klassiker';

  @override
  String get ghostPinyin => 'Geister-Pinyin';

  @override
  String get goodAttempt => 'Guter Versuch';

  @override
  String get gotItSimple => 'Verstanden';

  @override
  String get grammar => 'Grammatik';

  @override
  String get grandmaLiuFilling =>
      'Großmutter Liu (刘奶奶), eine herzliche Großmutter aus dem Norden Chinas, die dir zeigt, wie man Teigtaschen faltet und eine Füllung aus Schweinefleisch und Frühlingszwiebeln zubereitet.';

  @override
  String get great => 'Großartig!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Handgemachtes Teigtaschenfest in Harbin';

  @override
  String get hanziCharacter => 'Hanzi (Zeichen)';

  @override
  String get hapticFeedback => 'Haptisches Feedback';

  @override
  String get helpAndSupport => 'Hilfe & Support';

  @override
  String get hidden => 'Versteckt';

  @override
  String get hideEnglishTranslations => 'Übersetzungen ausblenden';

  @override
  String get hidePinyin => 'Pinyin ausblenden';

  @override
  String get highlight => 'HERVORHEBEN';

  @override
  String get howWouldYouLikeToStudy => 'Wie möchtest du lernen?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Obere Mittelstufe';

  @override
  String get hsk5Advanced => 'HSK 5: Fortgeschritten';

  @override
  String get hsk6Mastery => 'HSK 6: Meisterschaft';

  @override
  String get hskCollections => 'HSK-Sammlungen';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'HSK-Untertitel vereinfachen';

  @override
  String get hskVocabularyCollections => 'HSK-Vokabularsammlungen';

  @override
  String get i => 'Ich';

  @override
  String get ifTheAgain =>
      'Wenn das Transkript nicht dem Gesagten entspricht, wähle die beabsichtigte Formulierung und tippe auf „Ja, neu bewerten!“. Die ursprüngliche Aufnahme wird dann ohne erneutes Sprechen neu bewertet.';

  @override
  String get install => 'Installieren';

  @override
  String get just => 'Nur \$';

  @override
  String get keyword => 'Schlüsselwort';

  @override
  String get knowledgeBase => 'Wissensdatenbank';

  @override
  String get liRuzhenSubjects =>
      'Li Ruzhen (ca. 1763–1830) war ein Gelehrter der Qing-Dynastie mit tiefem Interesse an Phonologie, Schach und Kosmologie. Sein fantastischer Roman „Blumen im Spiegel“ über die Reise eines Kaufmanns durch unmögliche Königreiche ist bemerkenswert für seine feministischen Themen und seine enzyklopädische Bandbreite an Sujets.';

  @override
  String get libraryLabel => 'Bibliothek';

  @override
  String get lifestyleAndVlog => 'Lifestyle & Vlog';

  @override
  String get listenInAudiobookMode => 'Im Hörbuch-Modus anhören';

  @override
  String get listenToThisWord => 'Dieses Wort anhören';

  @override
  String get listening => 'Höre zu...';

  @override
  String get liuEEncroachment =>
      'Liu E (1857–1909) war ein Universalgelehrter der späten Qing-Zeit – Ingenieur, Arzt und Romancier –, dessen einziger Roman „Die Reisen des Lao Can“ das lyrische, aber politisch aufgeladene Reisetagebuch eines wandernden Heilers ist, der durch ein China im Umbruch zwischen dynastischem Verfall und ausländischer Einflussnahme reist.';

  @override
  String get loadingTranslations => 'Übersetzungen werden geladen...';

  @override
  String get luXunVernacular =>
      'Lu Xun (1881–1936), Pseudonym von Zhou Shuren, ist der Vater der modernen chinesischen Literatur. Als Arzt, der zum Schreiben wechselte, um den Geist seiner Landsleute zu heilen, nutzte er in seinen Kurzgeschichtensammlungen – „Tagebuch eines Verrückten“ und „Die wahre Geschichte des Ah Q“ – die Volkssprache (Baihua), um traditionelle Missstände schonungslos aufzudecken.';

  @override
  String get luoGuanzhongEpic =>
      'Luo Guanzhong (ca. 1330–1400) war ein Dramatiker und Romancier der Übergangszeit von Yuan zu Ming, der vermutlich bei Shi Nai\'an studiert hat. Sein „Roman der Drei Reiche“ synthetisierte historische Chroniken, mündliche Überlieferungen und dramatische Erzählungen zum definitiven chinesischen Geschichtsepos.';

  @override
  String get makeACustomCollection => 'Eigene Sammlung erstellen';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Tägliche Drops und Wiederholungs-Erinnerungen verwalten';

  @override
  String get managerYuOptions =>
      'Manager Yu (余店长), ein temperamentvoller Hotpot-Restaurantmanager, der seine Spezial-Kutteln, Entenblut und milde Brühen empfiehlt.';

  @override
  String get masterGaoRubs =>
      'Meister Gao (高师傅), ein charismatischer Holzkohle-BBQ-Meister, der mit Kunden über Schärfegrade und geheime Kreuzkümmel-Gewürzmischungen scherzt.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Meistere dies, um seine Galaxie freizuschalten.';

  @override
  String get masterZhaoBrewing =>
      'Meister Zhao (赵师傅), ein geduldiger und sachkundiger Tee-Sommelier, der gerne die Gongfu-Teezubereitung erklärt.';

  @override
  String get mastery => 'Meisterschaft';

  @override
  String get maybeLater => 'Vielleicht später';

  @override
  String get memes => 'Memes';

  @override
  String get midnightBbqSkewersInWuhan => 'Mitternachts-BBQ-Spieße in Wuhan';

  @override
  String get mo => '/Monat';

  @override
  String get modernChinese => 'Modernes Chinesisch';

  @override
  String get monthly => 'Monatlich';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Morgen-Dim-Sum-Wagen in Guangzhou';

  @override
  String get nameLabel => 'Name';

  @override
  String get native => 'Muttersprachlich';

  @override
  String get newCard => 'Neue Karte';

  @override
  String get newDeck => 'Neues Deck';

  @override
  String get newDeckName => 'Name des neuen Decks';

  @override
  String get noActiveSubscriptionFound => 'Kein aktives Abonnement gefunden.';

  @override
  String get noEpisodesFound => 'Keine Episoden gefunden';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Keine Schlüsselwörter für diese Geschichte gefunden.';

  @override
  String get noLabel => 'Nein';

  @override
  String get noNewWordsFound => 'Keine neuen Wörter gefunden!';

  @override
  String get noPinyin => 'Kein Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'Derzeit keine Premium-Pakete verfügbar.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'Keine Ergebnisse für \'$searchQuery\' gefunden';
  }

  @override
  String get noSavedArticlesYet => 'Noch keine Artikel gespeichert.';

  @override
  String get noShowsAvailable => 'Keine Sendungen verfügbar';

  @override
  String get noStoriesFound => 'Keine Geschichten gefunden.';

  @override
  String get noWordsSelected => 'Keine Wörter ausgewählt';

  @override
  String get notes => 'Notizen';


  @override
  String get objectivesTitle => 'ZIELE';

  @override
  String get openInYoutube => 'In YouTube öffnen';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Handfilterkaffee in Shanghai bestellen';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Kandierte Weißdorn-Spieße (Tanghulu) im winterlichen Peking bestellen';

  @override
  String partnerLang(String lang) {
    return 'Partner ($lang)';
  }

  @override
  String get partnerListening => 'Partner hört zu...';

  @override
  String get partnerSpeaking => 'Partner spricht...';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get pause => 'Pause';

  @override
  String get perfect => 'Perfekt!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Ein personalisierter Lernpfad basierend auf deinem Deck.';

  @override
  String get play => 'Abspielen';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Bitte gib eine Nachricht ein, bevor du sie sendest.';

  @override
  String get practiceInRoleplay => 'Im Rollenspiel üben';

  @override
  String get practiceModes => 'Übungsmodi';

  @override
  String get practicePronouncingWithAiGrading =>
      'Übe die Aussprache dieses Wortes mit KI-Bewertung';

  @override
  String get preparingReadingInterface => 'Leseoberfläche wird vorbereitet...';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get privacyAndAudio => 'Datenschutz & Audio';

  @override
  String get aiDataPrivacyTitle => 'KI-Daten & Datenschutz';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Erfahre, was KI-Funktionen senden, warum und an wen';

  @override
  String get aiDataPrivacyOverviewTitle => 'Wann KI verwendet wird';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark nutzt Cloud-KI nur, wenn du eine Funktion wählst, die diese benötigt, wie KI-Chat, Erklärungen, Übersetzung, Bildanalyse, Spracherkennung, Aussprachebewertung oder Cloud-Stimmen. KI-Ergebnisse können ungenau sein, bitte überprüfe wichtige Resultate.';

  @override
  String get aiDataPrivacyProvidersTitle => 'KI-Dienstanbieter';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini verarbeitet generative Text- und Bildanfragen. OpenRouter leitet einige generative Anfragen an Google Gemini oder DeepSeek weiter. Microsoft Azure AI Speech verarbeitet Spracherkennung, Aussprachebewertung und für Cloud-Sprachsynthese gesendeten Text.';

  @override
  String get aiDataPrivacySentTitle => 'Daten, die gesendet werden können';

  @override
  String get aiDataPrivacySentBody =>
      'Je nach Funktion senden wir den eingegebenen oder ausgewählten Text, relevanten Konversations- oder Lektionskontext, für die KI-Analyse ausgewählte Bilder, Sprachaufnahmen sowie technische Anfragedaten wie IP-Adresse und Geräte-/Netzwerk-Metadaten. Wir fügen KI-Prompts nicht absichtlich deinen Namen oder deine E-Mail-Adresse hinzu.';

  @override
  String get aiDataPrivacyControlsTitle => 'Deine Wahlmöglichkeiten';

  @override
  String get aiDataPrivacyControlsBody =>
      'Verwende keine KI-Funktion, wenn du deren Eingaben nicht an den genannten Anbieter senden möchtest. Du kannst Kamera-, Foto- oder Mikrofonberechtigungen in den Geräteeinstellungen verweigern. Wähle die lokale Stimme, um Text-to-Speech auf deinem Gerät zu belassen. Vermeide die Eingabe vertraulicher oder sensibler Informationen.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Speicherung und Aufbewahrung';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark speichert rohe KI-Prompts, übermittelte Bilder oder Sprachaufnahmen nach der Verarbeitung nicht absichtlich auf eigenen Servern. Generierte Ergebnisse können auf deinem Gerät oder in deinem Konto gespeichert werden, wenn du dich dafür entscheidest. Anbieter verarbeiten Daten gemäß ihren eigenen Bedingungen und Speicherregeln; siehe die vollständige Datenschutzrichtlinie für Details.';

  @override
  String get readFullPrivacyPolicy =>
      'Vollständige Datenschutzrichtlinie lesen';

  @override
  String get linkOpenFailed =>
      'Link konnte nicht geöffnet werden. Bitte versuche es erneut.';

  @override
  String get puSonglingLiterature =>
      'Pu Songling (1640–1715) war ein Schriftsteller der Qing-Dynastie, der Jahrzehnte damit verbrachte, „Seltsame Geschichten aus einem Gelehrtenzimmer“ zu kompilieren, nachdem er wiederholt die kaiserlichen Prüfungen nicht bestanden hatte. Seine übernatürlichen Geschichten von Fuchsgeistern, Gespenstern und Gelehrten bleiben das Meisterwerk der klassischen chinesischen Phantastik.';

  @override
  String get qaFaq => 'F&A / FAQ';

  @override
  String get questsTitle => 'QUESTEN';

  @override
  String get quickBookmarks => 'Schnell-Lesezeichen';

  @override
  String get radical => 'Radikal';

  @override
  String get ready => 'Bereit';

  @override
  String get readyToInterpret => 'Bereit zum Dolmetschen';

  @override
  String get readyToStart => 'Bereit zum Start.';

  @override
  String get recentBookmarks => 'Aktuelle Lesezeichen';

  @override
  String get refiningGrammar => 'Grammatik wird verfeinert...';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get removeFromSaved => 'Aus Gespeichertem entfernen';

  @override
  String get removeFromSavedScenarios =>
      'Aus gespeicherten Szenarien entfernen';

  @override
  String get removed => 'Entfernt';

  @override
  String get requestPermissions => 'Berechtigungen anfordern';

  @override
  String get rescind => 'Widerrufen';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get results => 'Ergebnisse';

  @override
  String get resume => 'Fortsetzen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get revenuecatError => 'RevenueCat-Fehler:';

  @override
  String revenuecatErrorE(String e) {
    return 'RevenueCat-Fehler: $e';
  }

  @override
  String get reviewExtractedDeck => 'Extrahiertes Deck überprüfen';

  @override
  String get reviewIn => 'Wiederholen in';

  @override
  String get reviewingYourTones => 'Deine Töne werden überprüft...';

  @override
  String get saveAll => 'Alle speichern';

  @override
  String get saveScenario => 'Szenario speichern';

  @override
  String get saveThisScenario => 'Dieses Szenario speichern';

  @override
  String get saved => 'Gespeichert';

  @override
  String get scanAnother => 'Weiteren Scan durchführen';

  @override
  String get scenarioRemoved => 'Szenario entfernt';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Szenario gespeichert! Du findest es im Tab „Benutzerdefiniert“.';

  @override
  String score(Object score, Object total) {
    return 'Ergebnis: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'Nach Pinyin oder Bedeutung suchen...';

  @override
  String get searchByTitleOrTag => 'Nach Titel oder Tag suchen...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Wörterbuch durchsuchen oder benutzerdefinierten Begriff eingeben';

  @override
  String get searchHint => 'Suchen...';

  @override
  String get searchOrEnterUrl => 'Suchen oder URL eingeben';

  @override
  String get searchScenariosHint => 'Szenarien suchen...';

  @override
  String get searchStoriesIdiomsNews =>
      'Geschichten, Redewendungen, Nachrichten suchen...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Themen suchen (z. B. Kochen, Geschichte)';

  @override
  String get seeAll => 'Alle anzeigen';

  @override
  String get selectADeck => 'Ein Deck auswählen';

  @override
  String get selectPracticeMode => 'Übungsmodus auswählen';

  @override
  String get selectingHskVocabulary => 'HSK-Vokabular wird ausgewählt...';

  @override
  String get send => 'Senden';

  @override
  String get sendMessage => 'Nachricht senden';

  @override
  String get serif => 'Serife';

  @override
  String get shadow => 'Shadowing';

  @override
  String get shiNaianEpic =>
      'Shi Nai\'an (ca. 1296–1372) war ein Literat der Yuan-Dynastie, der Berichten zufolge die kaiserliche Prüfung bestand, sich aber für das Leben eines zurückgezogen lebenden Gelehrten entschied. „Die Räuber vom Liang-Schan-Moor“, sein Meisterwerk über heldenhafte Gesetzlose und gerechte Rebellion, etablierte den Archetyp des chinesischen Heldenepos.';

  @override
  String get showEnglish => 'Englisch anzeigen';

  @override
  String get showEnglishTranslations => 'Englische Übersetzungen anzeigen';

  @override
  String get showHanzi => 'Hanzi anzeigen';

  @override
  String get showPinyin => 'Pinyin anzeigen';

  @override
  String get showTranslation => 'Übersetzung anzeigen';

  @override
  String get shows => 'Sendungen';

  @override
  String get signIn => 'Anmelden';

  @override
  String get simplifiedArticle => 'Vereinfachter Artikel';

  @override
  String get simplifyingSubtitles => 'Untertitel werden vereinfacht...';

  @override
  String get sincereHonest => 'aufrichtig; ehrlich';

  @override
  String get sleepTimer => 'Sleep-Timer';

  @override
  String get smartDeck => 'Smart-Deck';

  @override
  String get spanishAndWorld => 'Spanisch & Welt';

  @override
  String get speaker => 'Sprecher';

  @override
  String get spotifyStylePlayer => 'Player im Spotify-Stil';

  @override
  String get storyBookmarkedInLibrary =>
      'Geschichte in der Bibliothek gespeichert!';

  @override
  String get streetFoodNightMarketInXian => 'Streetfood-Nachtmarkt in Xi\'an';

  @override
  String get strokes => 'Striche';

  @override
  String get studyCharacter => 'Zeichen lernen';

  @override
  String get subtitleOpacity => 'Untertitel-Deckkraft';

  @override
  String get suggestion => 'Vorschlag';

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get supernaturalAndFolklore => 'Übernatürliches & Folklore';

  @override
  String get swipeToGrade => 'Zum Bewerten wischen:';

  @override
  String get tableOfContents => 'Inhaltsverzeichnis';

  @override
  String get tapToRetry => 'Zum Wiederholen tippen';

  @override
  String get teaTastingInChengdu => 'Teeverkostung in Chengdu';

  @override
  String get techAndGadgets => 'Technik & Gadgets';

  @override
  String get terms => 'Nutzungsbedingungen';

  @override
  String get theGalaxyCharacters =>
      'Die Galaxiekarte wartet.\nMeistere die Sonnen (Radikale), um die Planeten (Zeichen) freizuschalten.';

  @override
  String get theme => 'Design';

  @override
  String get thinking => 'Denke nach...';

  @override
  String get thisArticleCharacters =>
      'Dieser Artikel enthält traditionelle chinesische Schriftzeichen.';

  @override
  String get todaysWord => 'WORT DES TAGES';

  @override
  String get togglePinyin => 'Pinyin umschalten';

  @override
  String get toggleTranslation => 'Übersetzung umschalten';

  @override
  String get toneDoesNotExistInMandarin =>
      'Dieser Ton existiert im Standard-Mandarin nicht.';

  @override
  String get toneGraph => 'Ton-Diagramm';

  @override
  String get traceLabel => 'Nachzeichnen';

  @override
  String get trailer => 'TRAILER';

  @override
  String get translatingAndAddingPinyin => 'Übersetze und füge Pinyin hinzu...';

  @override
  String get translatingText => 'Text wird übersetzt...';

  @override
  String get turnOn => 'Einschalten';

  @override
  String get typeHanziPinyinOrEnglish =>
      'Hanzi, Pinyin oder Deutsch eingeben...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Die Schriftrolle wird ausgerollt...';

  @override
  String get upperIntermediate => 'Obere Mittelstufe';

  @override
  String get vibrationsForInteractions => 'Vibrationen bei Interaktionen';

  @override
  String get video => 'Video';

  @override
  String get viewAnswer => 'Antwort ansehen';

  @override
  String get viewAsList => 'Als Liste anzeigen';

  @override
  String get viewBookmarks => 'Lesezeichen anzeigen';

  @override
  String get viewMyDrawing => 'Meine Zeichnung ansehen';

  @override
  String get vlog => 'Chinesischer Alltags-Vlog';

  @override
  String get voice => 'Stimme:';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou =>
      'Wir freuen uns darauf,\nvon dir zu hören.';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get whatDoesThisMean => 'Was bedeutet das?';

  @override
  String get whatHappensToMyChatHistory =>
      'Was geschieht mit meinem Chatverlauf?';

  @override
  String get whatIfAiMishears =>
      'Was kann ich tun, wenn die KI mich falsch versteht?';

  @override
  String get whichCharacterIs => 'Welches Zeichen ist:';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Wörter gespeichert und Wiederholung (SRS) geplant!';

  @override
  String get writeYourMessageHere => 'Schreibe deine Nachricht hier...';

  @override
  String get wuChengenLiterature =>
      'Wu Cheng\'en (ca. 1500–1582) war ein Romanautor der Ming-Dynastie aus Huai\'an, Jiangsu. Gestützt auf jahrzehntelange Folklore, buddhistische Allegorien und satirischen Witz, verwebte er die Mythologie der Tang-Pilgerreise zu „Die Reise nach Westen“ – einem der erfindungsreichsten und beliebtesten Werke der Weltliteratur.';

  @override
  String get wuJingziClass =>
      'Wu Jingzi (1701–1754) war ein Romanautor der Qing-Dynastie aus Anhui, der sein ererbtes Vermögen aufgab und sein Leben dem Schreiben von „Der Gelehrtenroman“ (Rulin Waishi) widmete – einem bissigen satirischen Roman, der die Eitelkeit, Korruption und Absurdität des kaiserlichen Prüfungssystems und der Gelehrten-Gentry-Klasse aufdeckte.';

  @override
  String get xuZhonglinWarfare =>
      'Xu Zhonglin (bl. 16.–17. Jahrhundert) war ein Autor der Ming-Dynastie, dem die Zusammenstellung von „Die Investitur der Götter“ (Fengshen Yanyi) zugeschrieben wird, einem monumentalen Werk mythologischer Fiktion, das die Shang-Zhou-Geschichte mit daoistischer Kosmologie, himmlischer Bürokratie und heldenhafter Kriegsführung verbindet.';

  @override
  String get yearly => 'Jährlich';

  @override
  String get yesReGradeMe => 'Ja, neu bewerten!';

  @override
  String you(Object lang) {
    return 'Du ($lang)';
  }

  @override
  String get youAreSpeaking => 'Du sprichst';

  @override
  String get youLabel => 'Du';

  @override
  String youLang(String lang) {
    return 'Du ($lang)';
  }

  @override
  String get youMustAccount =>
      'Du musst die Nutzungsbedingungen und die Datenschutzerklärung akzeptieren, um ein Konto zu erstellen.';

  @override
  String get yourEchoModels =>
      'Dein gespeicherter Rollenspiel-Gesprächsverlauf bleibt zur späteren Wiederholung lokal auf deinem Gerät. Wir verwenden deine persönlichen Gespräche nicht zum Trainieren unserer KI-Modelle.';

  @override
  String get zhOnly => 'Nur Chinesisch (ZH)';

  @override
  String get hsk_1300_cards => '1300 Karten';

  @override
  String get hsk_154_cards => '154 Karten';

  @override
  String get hsk_162_cards => '162 Karten';

  @override
  String get hsk_2500_cards => '2500 Karten';

  @override
  String get hsk_299_cards => '299 Karten';

  @override
  String get hsk_602_cards => '602 Karten';

  @override
  String get added_to_review_queue =>
      'Zur Wiederholungswarteschlange hinzugefügt';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return '$cardCount Karten zu „$deckName“ hinzugefügt.';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '„$hanzi“ zu deiner Bibliothek hinzugefügt';
  }

  @override
  String get advanced => 'Fortgeschritten';

  @override
  String get ai_stories => 'KI-Geschichten';

  @override
  String analysis_failed(Object error) {
    return 'Analyse fehlgeschlagen: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Aussprache wird mit Gemini-KI analysiert...';

  @override
  String get analyzing_your_pronunciation =>
      'Deine Aussprache wird analysiert...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Bist du sicher, dass du „$deckName“ dauerhaft löschen möchtest? Dies kann nicht rückgängig gemacht werden und löscht alle enthaltenen Karten.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Frage zu $hanzi stellen...';
  }

  @override
  String get audio_haptics => 'Audio & Haptik';

  @override
  String get audio_could_not_start_check_your =>
      'Audio konnte nicht gestartet werden. Prüfe deine Verbindung und die Audioeinstellungen deines Geräts.';

  @override
  String get calligraphy_trace => 'Kalligrafie-Spur';

  @override
  String chapters(Object count) {
    return '$count Kapitel';
  }

  @override
  String get char => 'Zeichen';

  @override
  String get chinese_character => 'CHINESISCHES ZEICHEN';

  @override
  String get contact_us_and_report_issues =>
      'Kontaktiere uns und melde Probleme';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Smart-Deck „$deckName“ mit $wordCount Wörtern erstellt!';
  }

  @override
  String get custom_ai_generated_story =>
      'Individuelle KI-generierte Geschichte.';

  @override
  String get display_content => 'Anzeige & Inhalt';

  @override
  String get do_you_keep_or_store_my =>
      'Werden meine Sprachaufnahmen gespeichert?';

  @override
  String get elementary => 'Grundstufe';

  @override
  String error_creating_scenario(Object error) {
    return 'Fehler beim Erstellen des Szenarios: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Fehler beim Abrufen der Übersetzung: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Fehler beim Laden der Kapitel: $error';
  }

  @override
  String get error_loading_decks => 'Fehler beim Laden der Decks';

  @override
  String error_loading_microreads(Object error) {
    return 'Fehler beim Laden der Mikro-Lektüren: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Fehler beim Laden der Romane: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Fehler beim Laden der Gedichte: $error';
  }

  @override
  String get etymology => 'Etymologie: ';

  @override
  String get explanation => 'Erklärung';

  @override
  String get extracted_text_tap_to_lookup =>
      'Extrahierter Text (Tippen zum Nachschlagen)';

  @override
  String extraction_failed(Object error) {
    return 'Extraktion fehlgeschlagen: $error';
  }

  @override
  String get failed_to_download => 'Download fehlgeschlagen.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Szenario konnte nicht generiert werden: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Geschichte konnte nicht generiert werden:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Kontext konnte nicht geladen werden: $error';
  }

  @override
  String get feature_request => 'Funktionsvorschlag';

  @override
  String get foundation => 'Grundlagen';

  @override
  String get how_is_my_pronunciation_scored =>
      'Wie wird meine Aussprache bewertet?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'HSK $hskLevel Vokabular';
  }

  @override
  String get hsk_level => 'HSK-STUFE';

  @override
  String get intermediate => 'Mittelstufe';

  @override
  String get learning_stats => 'Lernstatistiken';

  @override
  String get mandarin => 'Mandarin';

  @override
  String get meaning => 'Bedeutung';

  @override
  String get no_decks_found => 'Keine Decks gefunden.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'Keine Ergebnisse für „$searchQuery“ gefunden';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'Aufnahmen, die du zur Aussprachebewertung sendest, werden sicher verarbeitet und nach Abschluss der Verarbeitung nicht von SinoSpark gespeichert. Rollenspiel-Verläufe, die du speicherst, können auf deinem Gerät verbleiben und lassen sich in der App löschen.';

  @override
  String get notification_settings => 'Benachrichtigungseinstellungen';

  @override
  String get open_settings => 'Einstellungen öffnen';

  @override
  String get phoneme => 'Phonem';

  @override
  String get play_reference_pronunciation => 'Referenzaussprache abspielen';

  @override
  String get please_select_a_deck_to_add =>
      'Bitte wähle ein Deck aus, um Karten hinzuzufügen.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Auf chinesischen Text richten, um zu übersetzen';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Übe das Schreiben der Striche von Hand';

  @override
  String get preferences_audio_and_display =>
      'Einstellungen, Audio und Anzeige';

  @override
  String get preparing_your_scholars_verdict =>
      'Urteil des Gelehrten wird vorbereitet...';

  @override
  String get previous => 'Vorherige';

  @override
  String question(Object current, Object total) {
    return 'Frage $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return '„$hanzi“ aus diesem Deck entfernen?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'RevenueCat-Fehler: $error';
  }

  @override
  String get review_tomorrow => 'Morgen wiederholen';

  @override
  String get roleplay => 'Rollenspiel';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Speichere $wordCount Wörter in „$deckName“...';
  }

  @override
  String get search_radicals_eg_water => 'Radikale suchen (z. B. Wasser, 氵)';

  @override
  String get select_target_hsk_level => 'Ziel-HSK-Stufe wählen';

  @override
  String get sentence => 'Satz';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Das Shadowing-Studio ist ein eigener Bereich, um das Nachsprechen von Muttersprachlern in Echtzeit zu üben.';

  @override
  String simplify_failed(Object error) {
    return 'Vereinfachung fehlgeschlagen: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Sprechen & Aussprache';

  @override
  String get statistics => 'Statistiken';

  @override
  String get table_of_contents => 'Inhaltsverzeichnis · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'Die KI bewertet deine Aussprache nach drei Kriterien:\n• Genauigkeit: Hast du die richtigen Silben artikuliert?\n• Vollständigkeit: Hast du Wörter ausgelassen oder vergessen?\n• Flüssigkeit: Hast du natürlich pausiert und die richtigen Töne verwendet?\nSie vergleicht deine Aufnahme mit Muttersprachlern, um eine Punktzahl von 100 zu berechnen.';

  @override
  String get this_cannot_be_undone =>
      'Dies kann nicht rückgängig gemacht werden.';

  @override
  String get title => 'Titel';

  @override
  String get to_be_reviewed => 'Zu wiederholen';

  @override
  String get traditional => 'Traditionell';

  @override
  String translation_failed(Object error) {
    return 'Übersetzung fehlgeschlagen: $error';
  }

  @override
  String get type_in => 'Eingeben...';

  @override
  String get type_your_message_in => 'Gib deine Nachricht ein auf...';

  @override
  String get unable_to_open_this_video_please =>
      'Dieses Video kann nicht geöffnet werden. Bitte versuche es später erneut.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Lernverlauf und Serien anzeigen';

  @override
  String get what_is_shadowing_studio => 'Was ist das Shadowing-Studio?';

  @override
  String get words => 'Wörter';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Dein Pfad für „$deckName“ ist bereit!';
  }

  @override
  String get you_said => '🗣️ Du hast gesagt';

  @override
  String vocabularyBatch(Object index) {
    return 'Vokabel-Deck $index';
  }

  @override
  String get yourDailyDropIsHere => 'Dein täglicher Drop ist da! ✨';

  @override
  String get timeToReview => 'Zeit zum Wiederholen! 📚';

  @override
  String get neverMissAStroke => 'Verpasse keinen Strich! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'Deine Testphase endet morgen! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Offizielle Standard-Vokabelstufen';

  @override
  String get failedToLoadCollections =>
      'Sammlungen konnten nicht geladen werden.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get aiSmartContext => 'KI Smart Context';

  @override
  String get aiSmartContextError => 'KI Smart Context Fehler';

  @override
  String get downloadOfficialHskCollections =>
      'Offizielle HSK-Sammlungen herunterladen';

  @override
  String get unableToLoadThisSection =>
      'Dieser Abschnitt konnte nicht geladen werden. Bitte versuche es erneut.';

  @override
  String get translationLanguage => 'Übersetzungssprache';

  @override
  String get dailyDrops => 'Tägliche Drops';

  @override
  String get wordOfTheDayNews => 'Wort des Tages & Nachrichten';

  @override
  String get reviewReminders => 'Wiederholungs-Erinnerungen';

  @override
  String get flashcardsDueForReview => 'Lernkarten zur Wiederholung fällig';

  @override
  String get dailyNewCards => 'Tägliche neue Karten';

  @override
  String get dailyReviewLimit => 'Tägliches Wiederholungslimit';

  @override
  String get practiceMode => 'Übungsmodus';

  @override
  String get liziqi => 'Liziqi (李子柒): Seidenblumen';

  @override
  String get theLifeOfGarlicTraditional =>
      'Das Leben des Knoblauchs – Traditionelles chinesisches Leben';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 Sätze';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Wesentliche chinesische Sätze für Anfänger';

  @override
  String get makingBambooFurniture => 'Bambusmöbel herstellen';

  @override
  String get peppaPigChinese => 'Peppa Wutz auf Chinesisch: Versteckspiel';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'Matschpfützen – Anfängerfreundlich';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 Verben';

  @override
  String get mostCommonChineseVerbs =>
      'Die gebräuchlichsten chinesischen Verben';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Essen bestellen';

  @override
  String get howToOrderFoodIn =>
      'Wie man in einem chinesischen Restaurant Essen bestellt';

  @override
  String get silkFlowersTraditionalCraft =>
      'Seidenblumen – Traditionelles Handwerk';

  @override
  String get mandarinCorner =>
      'Mandarin Corner: Chinesisch lernen – Arztbesuch';

  @override
  String get goingToTheDoctorReal => 'Zum Arzt gehen – Alltagsgespräche';

  @override
  String get hideAndSeekBeginnerFriendly =>
      'Versteckspiel – Anfängerfreundlich';

  @override
  String get linGdp6 => 'Xiao Lin erklärt: Warum 6 % BIP-Wachstum';

  @override
  String get why6GdpGrowthEasy =>
      'Warum 6 % BIP-Wachstum – Chinesische Wirtschaft einfach erklärt';

  @override
  String get bbcWorldNews => 'BBC 中文 (Weltnachrichten)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Aktuelle Ereignisse in vereinfachtem Chinesisch';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing =>
      'Interaktive Transkripte & Shadowing';

  @override
  String get showsDramas => 'SENDUNGEN & DRAMEN';

  @override
  String get extractToDeck => 'In Deck extrahieren';

  @override
  String get autoSimplify => 'Automatisch vereinfachen';

  @override
  String get rewriteThisArticleToMatch =>
      'Diesen Artikel an dein HSK-Niveau anpassen';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Extrahierte Wörter konnten nicht gespeichert werden: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Zum Deck hinzufügen ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Täglicher Entdeckungs-Drop';

  @override
  String get smartSpacedRepetition => 'Intelligente Spaced Repetition';

  @override
  String get trialProtectionAlert => 'Testphasen-Schutzwarnung';

  @override
  String get masteryLevel => 'Beherrschungsgrad';

  @override
  String get targetObjective => 'Zielvorgabe';

  @override
  String get dailyPractice => 'Tägliche Übung';

  @override
  String get aiSpacedRepetition => 'KI Spaced Repetition';

  @override
  String get iVeGrantedAccess => 'Ich habe den Zugriff gewährt';

  @override
  String get scanner => 'Scanner';

  @override
  String get interpreter => 'Dolmetscher';

  @override
  String cards(Object count) {
    return '$count Karten';
  }

  @override
  String get nWaMendsTheHeavens => 'Nüwa flickt den Himmel';

  @override
  String get terracottaArmy => 'Terrakotta-Armee';

  @override
  String get forbiddenCity => 'Verbotene Stadt';

  @override
  String get aBlessingInDisguise => 'Ein Segen im Unglück';

  @override
  String get drawingASnake => 'Einer Schlange Füße malen (Überflüssiges tun)';

  @override
  String get takingTheBulletTrain => 'Den Hochgeschwindigkeitszug nehmen';

  @override
  String get visitingTheDoctor => 'Den Arzt besuchen';

  @override
  String get orderingDumplings => 'Jiaozi (Teigtaschen) bestellen';

  @override
  String get theTeaCeremony => 'Die Teezeremonie';

  @override
  String get chineseCalligraphy => 'Chinesische Kalligrafie';

  @override
  String get theGiantPanda => 'Der Riesenpanda';

  @override
  String get simplifiedText => 'Vereinfachter Text';

  @override
  String get novels96 => 'Romane (96)';

  @override
  String get microReads => 'Mikro-Lektüren';

  @override
  String get poetry => 'Poesie';

  @override
  String get bookmarkRemoved => '书签已移除 · Lesezeichen entfernt';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Lesezeichen hinzugefügt: Kapitel $chapter';
  }

  @override
  String get readingVocabulary => 'Lesen & Wortschatz';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Vokabel-Deck $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'Dein täglicher Drop ist da! ✨';

  @override
  String get timeToReview1 => 'Zeit zum Wiederholen! 📚';

  @override
  String get neverMissAStroke1 => 'Verpasse keinen Strich! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'Deine Testphase endet morgen! ⏳';

  @override
  String get hskCollections1 => 'HSK-Sammlungen';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Offizielle Standard-Vokabelstufen';

  @override
  String get failedToLoadCollections1 =>
      'Sammlungen konnten nicht geladen werden.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return '$pinyinWithTone abspielen';
  }

  @override
  String errorE(Object e) {
    return 'Fehler: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'KI Smart Context';

  @override
  String get aiSmartContextError1 => 'KI Smart Context Fehler';

  @override
  String errorErr(Object err, Object error) {
    return 'Fehler: $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Offizielle HSK-Sammlungen herunterladen';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Dieser Abschnitt konnte nicht geladen werden. Bitte versuche es erneut.';

  @override
  String get searchRadicalsEgWater => 'Radikale suchen (z. B. Wasser, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Übersetzungssprache';

  @override
  String get appLanguage1 => 'App-Sprache';

  @override
  String get dailyDrops1 => 'Tägliche Drops';

  @override
  String get wordOfTheDayNews1 => 'Wort des Tages & Nachrichten';

  @override
  String get reviewReminders1 => 'Wiederholungs-Erinnerungen';

  @override
  String get flashcardsDueForReview1 => 'Lernkarten zur Wiederholung fällig';

  @override
  String get accuracyByMode1 => 'Genauigkeit nach Modus';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days =>
      'Anstehende Wiederholungen (nächste 7 Tage)';

  @override
  String get explaining => 'Erklärung:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Tägliche neue Karten';

  @override
  String get dailyReviewLimit1 => 'Tägliches Wiederholungslimit';

  @override
  String get listeningMode1 => 'Hörmodus';

  @override
  String get readingMode1 => 'Lesemodus';

  @override
  String get recallMode1 => 'Abrufmodus';

  @override
  String get speakingMode1 => 'Sprechmodus';

  @override
  String get practiceMode1 => 'Übungsmodus';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'Partner';

  @override
  String get partnerSpeaking1 => 'Partner spricht…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'Das Leben des Knoblauchs – Traditionelles chinesisches Leben';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 Sätze';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Wesentliche chinesische Sätze für Anfänger';

  @override
  String get makingBambooFurniture1 => 'Bambusmöbel herstellen';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Matschpfützen – Anfängerfreundlich';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 Verben';

  @override
  String get mostCommonChineseVerbs1 =>
      'Die gebräuchlichsten chinesischen Verben';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Essen bestellen';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Wie man in einem chinesischen Restaurant Essen bestellt';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Seidenblumen – Traditionelles Handwerk';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Zum Arzt gehen – Alltagsgespräche';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'Versteckspiel – Anfängerfreundlich';

  @override
  String get lingdp6 => 'Xiao Lin erklärt: Warum 6 % BIP-Wachstum';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Warum 6 % BIP-Wachstum – Chinesische Wirtschaft einfach erklärt';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Aktuelle Ereignisse in vereinfachtem Chinesisch';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Interaktive Transkripte & Shadowing';

  @override
  String get showsDramas1 => 'SENDUNGEN & DRAMEN';

  @override
  String error_error(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get extractToDeck1 => 'In Deck extrahieren';

  @override
  String get autosimplify => 'Automatisch vereinfachen';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Diesen Artikel an dein HSK-Niveau anpassen';

  @override
  String get addToDeck1 => 'Zum Deck hinzufügen';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Täglicher Entdeckungs-Drop';

  @override
  String get smartSpacedRepetition1 => 'Intelligente Spaced Repetition';

  @override
  String get trialProtectionAlert1 => 'Testphasen-Schutzwarnung';

  @override
  String get masteryLevel1 => 'Beherrschungsgrad';

  @override
  String get targetObjective1 => 'Zielvorgabe';

  @override
  String get dailyPractice1 => 'Tägliche Übung';

  @override
  String get aiSpacedRepetition1 => 'KI Spaced Repetition';

  @override
  String get iveGrantedAccess => 'Ich habe den Zugriff gewährt';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Zum Deck hinzufügen ($count)';
  }

  @override
  String get scanner1 => 'Scanner';

  @override
  String get interpreter1 => 'Dolmetscher';

  @override
  String entryvalueCards(Object count) {
    return '$count Karten';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Ergebnis: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'Der Affenkönig';

  @override
  String get huaMulan1 => 'Hua Mulan';

  @override
  String get nwaMendsTheHeavens => 'Nüwa flickt den Himmel';

  @override
  String get confucius => 'Konfuzius';

  @override
  String get theGreatWall1 => 'Die Große Mauer';

  @override
  String get terracottaArmy1 => 'Terrakotta-Armee';

  @override
  String get forbiddenCity1 => 'Verbotene Stadt';

  @override
  String get aBlessingInDisguise1 => 'Ein Segen im Unglück';

  @override
  String get drawingASnake1 => 'Einer Schlange Füße malen';

  @override
  String get takingTheBulletTrain1 => 'Den Hochgeschwindigkeitszug nehmen';

  @override
  String get visitingTheDoctor1 => 'Den Arzt besuchen';

  @override
  String get orderingDumplings1 => 'Teigtaschen bestellen';

  @override
  String get theTeaCeremony1 => 'Die Teezeremonie';

  @override
  String get chineseCalligraphy1 => 'Chinesische Kalligrafie';

  @override
  String get theGiantPanda1 => 'Der Riesenpanda';

  @override
  String get simplifiedText1 => 'Vereinfachter Text';

  @override
  String get novels961 => 'Romane (96)';

  @override
  String get microreads => 'Mikro-Lektüren';

  @override
  String get poetry1 => 'Poesie';

  @override
  String get readingVocabulary1 => 'Lesen & Wortschatz';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions wurden für Linux nicht konfiguriert.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions werden für diese Plattform nicht unterstützt.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'Striche dürfen nicht leer sein.';

  @override
  String get wrongStartPoint => 'Falscher Startpunkt.';

  @override
  String get rightShapeButWrongPlace => 'Richtige Form, aber falsche Position!';

  @override
  String get goodFollowTheFlow => 'Gut! Folge dem Strichfluss.';

  @override
  String get aBitShaky => 'Etwas zittrig!';

  @override
  String get aBitHesitant => 'Etwas zögerlich...';

  @override
  String get shapeIsOff => 'Form stimmt nicht ganz.';

  @override
  String get arabic => 'Arabisch';

  @override
  String get german => 'Deutsch';

  @override
  String get spanish => 'Spanisch';

  @override
  String get french => 'Französisch';

  @override
  String get hindi => 'Hindi';

  @override
  String get indonesian => 'Indonesisch';

  @override
  String get italian => 'Italienisch';

  @override
  String get japanese => 'Japanisch';

  @override
  String get korean => 'Koreanisch';

  @override
  String get portuguese => 'Portugiesisch';

  @override
  String get russian => 'Russisch';

  @override
  String get vietnamese => 'Vietnamesisch';

  @override
  String get microphonePermissionDenied => 'Mikrofonberechtigung verweigert';

  @override
  String get offset => 'Versatz';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService wurde beendet';

  @override
  String get fenrirZhcnyunxineural => 'Fenrir (zh-CN-YunxiNeural)';

  @override
  String get charonZhcnyunyangneural => 'Charon (zh-CN-YunyangNeural)';

  @override
  String get koreZhcnxiaoxiaoneural => 'Kore (zh-CN-XiaoxiaoNeural)';

  @override
  String get aoedeZhcnxiaoyineural => 'Aoede (zh-CN-XiaoyiNeural)';

  @override
  String get puckZhcnyunjianneural => 'Puck (zh-CN-YunjianNeural)';

  @override
  String get kore => 'Kore (weiblich, warm)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Ankerwort';

  @override
  String get creativeThematicTitle => 'Kreativer thematischer Titel';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Kurze pädagogische oder semantische Begründung';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'Das wichtigste Kernzeichen aus der Liste';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Eine ausgewogene Auswahl von Zeichen aus deiner Bibliothek.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Deine natürliche Gesprächsantwort in chinesischen Zeichen.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'Die deutsche Übersetzung deiner Antwort.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'Das Pinyin mit Tonzeichen für deine Antwort.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Eine vorgeschlagene Antwort, die der Benutzer dir geben könnte.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin für den Vorschlag.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Deutsche Übersetzung für den Vorschlag.';

  @override
  String get scholarsCritique => 'Kritik des Gelehrten';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'Die Echohalle bleibt stumm. Nimm einen tiefen Atemzug und versuche es erneut.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'Noch keine.';

  @override
  String get exactSentence => 'Genauer Satz:';

  @override
  String get englishTranslation => 'Übersetzung';

  @override
  String get previouslyGeneratedPhrases => 'Zuvor generierte Phrasen';

  @override
  String get iLikeDrinkingAppleJuice => 'Ich trinke gerne Apfelsaft.';

  @override
  String get theEnglishMeaningHere => 'Die Bedeutung hier...';

  @override
  String get failedToFetchDefinition =>
      'Definition konnte nicht abgerufen werden.';

  @override
  String get failedToLoadExplanation =>
      'Erklärung konnte nicht geladen werden.';

  @override
  String get failedToLoadComparison => 'Vergleich konnte nicht geladen werden.';

  @override
  String get emptyResponseFromOpenrouter =>
      'Leere Antwort von OpenRouter erhalten.';

  @override
  String get emptyResponseFromVisionModel =>
      'Leere Antwort vom Vision-Modell erhalten.';

  @override
  String get standard => 'Standard';

  @override
  String get theFullSentenceInChinese =>
      'Der vollständige Satz auf Chinesisch...';

  @override
  String get theWordOrCharacterInChinese =>
      'Das Wort oder Zeichen auf Chinesisch';

  @override
  String get thePinyinForThisSpecificWord =>
      'Das Pinyin für dieses spezifische Wort';

  @override
  String get emptyResponseFromDeepseekApi =>
      'Leere Antwort von der DeepSeek-API erhalten.';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'WICHTIG: Füge die deutsche Übersetzung ein in';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Deutsche Übersetzung des gesamten Satzes';

  @override
  String get hanziWord => 'Hanzi-Wort';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'Der vollständige vereinfachte Satz auf Chinesisch...';

  @override
  String get lyingFlatACulturalMovement =>
      'Tang Ping (Flachliegen): Eine kulturelle Bewegung...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'Der Benutzer, mit dem du sprichst, heißt';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'WICHTIGE REGEL: Sprich den Benutzer nicht mit Namen an. Verwende niemals Platzhalternamen wie';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Du bist ein prägnanter Tutor für chinesische Kalligrafie und Etymologie in einer mobilen Lernkarten-App.';

  @override
  String get theStudentIsStudyingTheCharacter =>
      'Der Lernende studiert das Zeichen';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Schreibe niemals Einleitungen, Verabschiedungen oder Füllphrasen wie';

  @override
  String get beDirectAndInformative => 'Sei direkt und informativ.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'KRITISCHE REGEL: Du musst VOLLSTÄNDIG in der Sprache antworten, die dem ISO 639-1 Code entspricht';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Du bist ein prägnanter Tutor für chinesische Grammatik in einer mobilen App.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'Der Lernende ist unsicher bezüglich des Wortes';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Schreibe niemals Einleitungen, Verabschiedungen oder Füllphrasen.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Azure Speech API-Schlüssel fehlen.';

  @override
  String get success => 'Erfolg';

  @override
  String get granularity => 'Granularität';

  @override
  String get phoneme1 => 'Phonem';

  @override
  String get dimension => 'Dimension';

  @override
  String get comprehensive => 'Umfassend';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Wir konnten dich nicht klar verstehen. Bitte versuche es erneut.';

  @override
  String get noNbestResultFound =>
      'Kein passendes Erkennungsergebnis (NBest) gefunden.';

  @override
  String get words1 => 'Wörter';

  @override
  String get word => 'Wort';

  @override
  String get phonemes => 'Phoneme';

  @override
  String get syllables => 'Silben';

  @override
  String get syllable => 'Silbe';

  @override
  String get omission => 'Auslassung';

  @override
  String get insertion => 'Einfügung';

  @override
  String get youMissedThisWord => 'Du hast dieses Wort ausgelassen.';

  @override
  String get extraWordAddedHere =>
      'Hier wurde ein zusätzliches Wort eingefügt.';

  @override
  String get mispronunciation => 'Falsche Aussprache';

  @override
  String get pronunciationWasInaccurate => 'Die Aussprache war ungenau.';

  @override
  String get goodEffortKeepPracticing => 'Guter Versuch! Übe weiter.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Perfekte Aussprache! Klingt wie ein Muttersprachler.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Großartige Arbeit! Nur minimale Tonungenauigkeiten.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Nicht schlecht, aber deine Töne brauchen noch etwas Feinschliff.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Übe weiter! Höre dir die Audioaufnahme von Muttersprachlern an und versuche es erneut.';

  @override
  String get lexical => 'Lexikalisch';

  @override
  String get chineseHanziHere => 'Chinesische Hanzi-Zeichen hier';

  @override
  String get aShortSummaryInEnglish => 'Eine kurze Zusammenfassung auf Deutsch';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'Kein zusammenhängender chinesischer Text im Scan gefunden.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'Die vollständige deutsche Übersetzung des gescannten Textes... ODER \'Kein zusammenhängender chinesischer Text gefunden.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Ein kurzer Titel (2–4 Wörter) für diesen Scan (z. B. \'Speisekarte\', \'Straßenschild\').';

  @override
  String get china => 'China';

  @override
  String get noTranslationAvailable => 'Keine Übersetzung verfügbar.';

  @override
  String get scanResults => 'Scan-Ergebnisse';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Wann wurde es verfasst und was geschah zu dieser Zeit in China?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Warum ist dieses Werk berühmt? Welche philosophischen oder kulturellen Themen behandelt es?';

  @override
  String get aBriefBioOfTheAuthor => 'Eine kurze Biografie des Autors.';

  @override
  String get informationUnavailable => 'Informationen nicht verfügbar.';

  @override
  String get noSummaryAvailable => 'Keine Zusammenfassung verfügbar.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'Testphase, Normal, Einführung';

  @override
  String get dailyDrop => 'Täglicher Drop';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Tägliche Benachrichtigungen für das Wort des Tages und Neuigkeiten.';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Ein neues Wort und eine Geschichte des Tages warten auf dich!';

  @override
  String get spacedRepetition => 'Spaced Repetition (Verteiltes Lernen)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Erinnerungen für zur Wiederholung fällige Lernkarten.';

  @override
  String get engagementReminders => 'Aktivitätserinnerungen';

  @override
  String get trialReminders => 'Testphasen-Erinnerungen';

  @override
  String get notificationsForYourTrialStatus =>
      'Benachrichtigungen über deinen Testphasen-Status.';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Wiederhole deine Hanzi und teste einen Live-Anruf, bevor dein kostenloser Zugang endet!';

  @override
  String get scholarsEye => 'Blick des Gelehrten';

  @override
  String get clMeasureWord => 'Zählwort (CL):';

  @override
  String get surnameShi => 'Nachname Shi';

  @override
  String get chineseFamilyNameShi => 'Chinesischer Familienname (Shi)';

  @override
  String get neutralToneLight => 'Neutraler Ton (Leicht)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Halte deine Tonhöhe hoch und gleichmäßig, wie beim Halten einer Gesangsnote.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Beginne in der Mitte und ziehe die Tonhöhe nach oben, wie bei einem fragenden \'Was?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Senke deine Stimme tief ab und hebe sie dann sanft wieder an.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Lass deine Tonhöhe scharf und bestimmt abfallen, wie bei einem energischen \'Nein!\'';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Sprich den Ton sanft, kurz und unbetont aus.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'Punktlandung! Die Tonhöhe war hoch, eben und konstant.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'Punktlandung! Der Tonhöhenanstieg war deutlich hörbar.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'Punktlandung! Der bogenförmige Tiefverlauf war präzise.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'Punktlandung! Der steile Tonabfall war punktgenau.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'Punktlandung! Der Ton wurde präzise getroffen.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Ich stimme den Nutzungsbedingungen und der Datenschutzerklärung zu.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Sende mir gelegentlich Updates, Lerntipps und Angebote.';

  @override
  String get signInToSyncYourProgress =>
      'Melde dich an, um deinen Lernfortschritt zu synchronisieren.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Erstelle ein Konto, um deine Statistiken dauerhaft zu sichern.';

  @override
  String get smartSpiral => 'SMART SPIRAL';

  @override
  String get origin => 'Ursprung';

  @override
  String get elements => 'Elemente';

  @override
  String get humanity => 'Mensch & Gesellschaft';

  @override
  String get village => 'Dorf';

  @override
  String get journey => 'Reise';

  @override
  String get city => 'Stadt';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Die einfachsten Formen. Der Beginn aller Dinge.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Sonne, Mond, Wasser und Feuer. Die natürliche Welt.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Der Körper, das Herz und die Familie.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Felder, Dächer und Werkzeuge. Das Fundament der Gesellschaft.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Bewegung, Sprache und Lebensunterhalt.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Handel, Kleidung und komplexe Artefakte.';

  @override
  String get equilibriumAlgorithm => 'Gleichgewichtsalgorithmus';

  @override
  String get misc => 'Sonstiges';

  @override
  String get cityOrOriginAs => '„Stadt“ oder „Ursprung“ als';

  @override
  String get miscToOrigin => '„Sonstiges“ zu „Ursprung“';

  @override
  String get constellation => 'Sternbild';

  @override
  String get whichOneIsWater => 'Welches Zeichen bedeutet \'Wasser\'?';

  @override
  String get whatIsThePinyin => 'Wie lautet das Pinyin?';

  @override
  String get nature => 'Natur';

  @override
  String get whatEssenceDoes => 'Welche Essenz hat';

  @override
  String get allTiers => 'Alle Stufen';

  @override
  String get active => 'Aktiv';

  @override
  String get theScrollOfOrigin1 => 'DIE SCHRIFTROLLE DES URSPRUNGS';

  @override
  String galaxyOf1(Object name) {
    return 'GALAXIE VON $name';
  }

  @override
  String get also => 'Auch';

  @override
  String get work => 'Arbeit';

  @override
  String get cloud => 'Wolke';

  @override
  String get youArchaic => 'Du (archaisch)';

  @override
  String get suddenly => 'Plötzlich';

  @override
  String get owner => 'Besitzer';

  @override
  String get door => 'Tür';

  @override
  String get occupy => 'Besetzen';

  @override
  String get nail => 'Nagel';

  @override
  String get and => 'Und';

  @override
  String get buddhistNun => 'Buddhistische Nonne';

  @override
  String get anxious => 'Besorgt';

  @override
  String get sprout => 'Spross';

  @override
  String get exchange => 'Austausch';

  @override
  String get sheep => 'Schaf';

  @override
  String get strange => 'Seltsam';

  @override
  String get opposite => 'Gegenteil';

  @override
  String get shorttailedBird => 'Kurzschwanzvogel';

  @override
  String get shoot => 'Spross / Schießen';

  @override
  String get small => 'Klein';

  @override
  String get gather => 'Sammeln';

  @override
  String get order => 'Ordnung';

  @override
  String get flat => 'Flach';

  @override
  String get thePersonWho => 'Die Person, die...';

  @override
  String get nobleman => 'Edelmann';

  @override
  String get cause => 'Ursache';

  @override
  String get pig => 'Schwein';

  @override
  String get bright => 'Hell';

  @override
  String get slowly => 'Langsam';

  @override
  String get give => 'Geben';

  @override
  String get arrow => 'Pfeil';

  @override
  String get dry => 'Trocken';

  @override
  String get obstacle => 'Hindernis';

  @override
  String get beg => 'Betteln';

  @override
  String get window => 'Fenster';

  @override
  String get fear => 'Furcht';

  @override
  String get drum => 'Trommel';

  @override
  String get why => 'Warum';

  @override
  String get talent => 'Talent';

  @override
  String get follow => 'Folgen';

  @override
  String get desert => 'Wüste';

  @override
  String get component => 'Komponente';

  @override
  String divingInto1(Object topic) {
    return 'Eintauchen in $topic';
  }

  @override
  String get unitIntro1 => 'Lektionseinführung';

  @override
  String get theBlueprint => 'DER BAUPLAN';

  @override
  String get theOrigin => 'DER URSPRUNG';

  @override
  String get theGalaxy => 'DIE GALAXIE';

  @override
  String get theScholarListens => 'Der Gelehrte lauscht...';

  @override
  String get consultingTheScrolls => 'Schriftrollen werden durchforstet...';

  @override
  String get traceWithTheGuide => 'Mit Hilfslinien nachzeichnen';

  @override
  String get traceTheGhost => 'Hilfslinie nachzeichnen';

  @override
  String get connectTheDots => 'Punkte verbinden';

  @override
  String get drawFromMemory => 'Aus dem Gedächtnis zeichnen';

  @override
  String get assistant => 'Assistent';

  @override
  String get puck => 'Puck (männlich, sportlich)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Hallo! Herzlich willkommen. Was möchtest du bestellen?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'Kellner Li';

  @override
  String get askForTheMenu => 'Nach der Speisekarte fragen';

  @override
  String get orderOneDishAndOneDrink => 'Ein Gericht und ein Getränk bestellen';

  @override
  String get askForTheBill => 'Nach der Rechnung fragen';

  @override
  String get fenrir => 'Fenrir (männlich, dynamisch)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'Fahrer Wang';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Dem Fahrer sagen, dass du zum Flughafen möchtest.';

  @override
  String get askHowLongTheTripWillTake =>
      'Fragen, wie lange die Fahrt dauern wird.';

  @override
  String get complainAboutTheTraffic => 'Über den dichten Verkehr sprechen.';

  @override
  String get charon => 'Charon (männlich, sachlich)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'Dieses Kleidungsstück ist von besonders guter Qualität, nur 200 Kuai.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'Tante Chen';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'Fragen, wie viel das Seidenhemd kostet.';

  @override
  String get sayItIsTooExpensive => 'Sagen, dass es zu teuer ist.';

  @override
  String get bargainThePriceDownTo100Rmb =>
      'Den Preis auf 100 RMB herunterhandeln.';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'Dr. Zhang';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Erklären, dass du seit zwei Tagen Kopfschmerzen hast.';

  @override
  String get sayYouHaveASlightFever => 'Sagen, dass du leichtes Fieber hast.';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Fragen, ob du Medikamente einnehmen musst.';

  @override
  String get aoede => 'Aoede (weiblich, fröhlich)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Hey! Lange nicht gesehen, wie ging es dir in letzter Zeit?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Bitte stelle dich kurz vor. Warum möchtest du in unserem Unternehmen arbeiten?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'Manager Liu';

  @override
  String get introduceYourProfessionalBackground =>
      'Stelle deinen beruflichen Hintergrund kurz vor.';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Erkläre, warum du für dieses Unternehmen arbeiten möchtest.';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Stelle eine höfliche Frage zur Unternehmenskultur.';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'Mikrofonzugriff erforderlich. Bitte aktiviere ihn in den Geräteeinstellungen.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Mikrofon konnte nicht gestartet werden. Bitte überprüfe deine Audioeinstellungen und versuche es erneut.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Das konnten wir leider nicht verstehen. Bitte halte die Mikrofontaste gedrückt und versuche es erneut!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'Die Aufnahme war zu kurz. Halte die Mikrofontaste gedrückt und sprich deutlich.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Audiopuffer war leer. Bitte überprüfe dein Mikrofon und versuche es erneut.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'Audiodatei ist stumm. Bitte sprich direkt in das Mikrofon.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Wir konnten deine Aussprache nicht verstehen. Bitte sprich deutlich und versuche es erneut.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'Der Server antwortet nicht rechtzeitig. Bitte versuche es erneut.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Keine Internetverbindung. Bitte überprüfe deine Netzwerkverbindung und versuche es erneut.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Audioverarbeitung fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get permission => 'Berechtigung';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Deine Aufnahme konnte nicht verarbeitet werden. Bitte versuche es erneut.';

  @override
  String get user => 'Benutzer';

  @override
  String get scholar => 'Gelehrter';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Unsere KI-Tutoren sind derzeit offline. Bitte versuche es später erneut.';

  @override
  String get hideTranslation => 'Übersetzung ausblenden';

  @override
  String get azureAssessment => 'Azure-Bewertung läuft...';

  @override
  String get microphonePermissionRequired =>
      'Mikrofonberechtigung erforderlich';

  @override
  String get connectedSpeakNow => 'Verbunden! Du kannst jetzt sprechen.';

  @override
  String get initializationErrorCheckPermissions =>
      'Initialisierungsfehler. Bitte Berechtigungen prüfen.';

  @override
  String get microphoneErrorTapToRetry =>
      'Mikrofonfehler. Zum Wiederholen tippen.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'Der Tutor hat eine leere Antwort zurückgegeben.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Verbindung unterbrochen. Bitte sprich erneut.';

  @override
  String get callPausedReviewingTones =>
      'Anruf pausiert (Überprüfung der Töne)';

  @override
  String get pausedTakeABreak => 'Pausiert – Kurze Pause';

  @override
  String get goodStartPracticing => 'Guter Einstieg in die Übung';

  @override
  String get studentCoach => 'Schüler / Coach';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Halte deinen 1. Ton hoch und gleichmäßig bei';

  @override
  String get noScenariosFound => 'Keine Szenarien gefunden.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Gestalte dein eigenes KI-Rollenspiel';

  @override
  String get generateFromDeck => 'Aus Deck generieren';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Übe Lernkarten-Vokabular in einem Live-Dialog';

  @override
  String get tapToRoleplay => 'Tippen für Rollenspiel';

  @override
  String get hsk2 => 'HSK 2';

  @override
  String get hsk3 => 'HSK 3';

  @override
  String get hsk4 => 'HSK 4';

  @override
  String get hsk5 => 'HSK 5';

  @override
  String get hsk6 => 'HSK 6';

  @override
  String get dinnerWithDad => 'Abendessen mit Papa';

  @override
  String get orderingAtAChengduTeahouse =>
      'Bestellung in einem Teehaus in Chengdu';

  @override
  String get buyingTeaAtTheMarket => 'Tee auf dem Markt kaufen';

  @override
  String get meetingAnOldClassmate => 'Einen alten Klassenkameraden treffen';

  @override
  String get readyToPractice => 'Bereit zum Üben?';

  @override
  String get letsPracticeChinese => 'Lass uns Chinesisch üben';

  @override
  String get areYouReady => 'Bist du bereit?';

  @override
  String get discussWhatToHaveForDinner =>
      'Besprechen, was es zum Abendessen geben soll';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Vorschlagen, danach einen Film anzuschauen';

  @override
  String get askIfTheyWouldLikeTea => 'Fragen, ob Tee gewünscht wird';

  @override
  String get helloVeryNiceToMeetYou =>
      'Hallo! Sehr erfreut, dich kennenzulernen.';

  @override
  String get deckPractice => 'Deck-Übung';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Vokabeln mit einem KI-Partner trainieren.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Individuelle KI-Rollenspiele & Dialoge gestalten';

  @override
  String get random => 'Zufällig';

  @override
  String get scenarioTopic => 'Szenario-Thema';

  @override
  String get contextSettingOptional => 'Kontext & Umgebung (optional)';

  @override
  String get aiCharacterPersonaOptional => 'KI-Charakter / Persona (optional)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Ein ruhiges Teehaus mit Bambushof in Chengdu, untermalt von sanfter Guzheng-Musik.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Ein geschäftiger, rauchiger Nachtmarkt voller Spieße, Baozi und Imbissständen.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Ein lebhaftes Hotpot-Restaurant in Chongqing mit kochend roter Brühe und duftendem Chili-Aroma.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Ein traditionelles kantonesisches Teehaus in Guangzhou voller dampfender Bambuskörbe.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Ein schickes, minimalistisches Café in der Französischen Konzession an einem regnerischen Sonntagnachmittag.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Eine gemütliche Wohnküche in Nordchina im Winter mit Mehl auf dem Tisch und dampfenden Jiaozi-Töpfen.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Eine lebhafte Gasse mit Streetfood, brutzelnden Lammspießen, gegrillten Auberginen und kühlem Bier.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Eine verschneite Straßenecke vor dem Lama-Tempel mit glänzend roten Tanghulu-Spießen auf Eis.';

  @override
  String get craftBeerBreweryInQingdao => 'Craft-Beer-Brauerei in Qingdao';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Ein lebhafter Schankraum an der Küste mit Holzfässern, Meeresbrise und frischen Weizenbierhähnen.';

  @override
  String get sichuanCookingMasterclass =>
      'Sichuan-Kochkurs für Fortgeschrittene';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Eine offene Küche mit lodernden Woks, brutzelndem Chiliöl und frischen Sichuan-Pfefferkörnern.';

  @override
  String get highspeedRailSeatMixup =>
      'Sitzplatzverwechslung im Hochgeschwindigkeitszug';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Sonnenaufgangswanderung auf der Großen Mauer bei Mutianyu';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'Die uralten Steinmauern der Großen Mauer im Morgengrauen, umgeben von nebelverhangenen grünen Bergen.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Bambusfloßfahrt auf dem Li-Fluss in Guilin';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Gleiten auf smaragdgrünem Karstwasser zwischen markanten, nebligen Kalksteingipfeln bei Yangshuo.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Kamelritt auf der Seidenstraße in Dunhuang';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Die sanft geschwungenen goldenen Sanddünen des Mingsha-Berges neben der Oase des Mondsichelsees.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Buchung einer traditionellen Hofunterkunft in Dali';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Ein friedvolles Boutique-Hofhotel im Stil der Bai-Kultur mit Blick auf den Erhai-See in Yunnan.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Pilgerreise zum Potala-Palast in Lhasa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Die majestätischen, sonnenbeschienenen Steinstufen vor dem Potala-Palast mit kreisenden Gebetsmühlen.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Ein Winterwunderland bei Minusgraden mit beleuchteten Eispalästen und riesigen Schneeskulpturen.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Seilbahn zu den Avatar-Bergen in Zhangjiajie';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Hoch oben in einer gläsernen Seilbahngondel schwebend über Tausenden von Sandsteinsäulen.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Sternebeobachtungscamp in der Wüste Gobi in Gansu';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Ein luxuriöses Jurten-Camp unter dem kristallklaren Sternenhimmel der Milchstraße nahe Jiayuguan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Flusskreuzfahrt durch die Drei Schluchten des Jangtsekiang';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'Auf dem Sonnendeck eines Flusskreuzfahrtschiffs bei der Fahrt durch die imposante Qutang-Schlucht.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Antiquitätenkauf auf dem Panjiayuan-Markt in Peking';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Ein historischer Brennofen voller zarter Porzellanvasen und kobaltblauer Glasuren.';

  @override
  String get suzhouSilkEmbroideryStudio => 'Seidenstickerei-Atelier in Suzhou';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Ein friedvolles Gartenatelier am Kanal in Suzhou mit feinen Seidenfäden und hölzernen Stickrahmen.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Hinter den Kulissen eines traditionellen Peking-Oper-Theaters mit bunten Kostümen und Masken.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Konsultation in Traditioneller Chinesischer Medizin (TCM)';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Morgendliches Tai-Chi im Park des Himmelstempels';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Unter alten Zypressen im Morgengrauen, begleitet von Vogelgezwitscher und synchron trainierenden Senioren.';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'Einen Hanfu für ein Fotoshooting ausleihen';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Eine traditionelle Kostümboutique am Westsee mit Gewändern aus der Tang- und Song-Dynastie.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Guqin-Workshop (Klassische chinesische Zither)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Ein ruhiges Kiefernholz-Studio in Hangzhou mit Instrumenten aus Paulownia-Holz und Seidensaiten.';

  @override
  String get shaanxiShadowPuppetTheater => 'Schattenpuppentheater aus Shaanxi';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Hinter einer beleuchteten weißen Seidenleinwand mit kunstvoll geschnittenen Lederschattenfiguren.';

  @override
  String get chineseCalligraphyWorkshop => 'Chinesischer Kalligrafie-Workshop';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Ein ruhiges Atelier, erfüllt vom Duft feiner Tusche, Reispapierrollen und zartem Tee-Aroma.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Eine Katze aus dem Tierheim adoptieren';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Ein gemütliches Tierrettungszentrum in Hangzhou mit verspielten Kätzchen und Tee für Besucher.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Jubensha-Krimi-Rollenspiel (Script Murder Mystery)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Eine stimmungsvolle Detektiv-Lounge in Shanghai mit verkleideten Spielern und Kerzenschein.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Vintage-Schallplattenladen in Shanghai';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Ein versteckter Plattenladen in einem traditionellen Shikumen-Gassenhaus mit Cantopop- und Jazz-Klassikern.';

  @override
  String get ktvKaraokePartyWithFriends => 'KTV-Karaoke-Party mit Freunden';

  @override
  String get joiningACityBikeCyclingClub =>
      'Einem städtischen Radfahr-Club beitreten';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Treffen von Radfahrern an der Uferpromenade vor einer nächtlichen Tour entlang der Skyline.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Tauschtreffen für Blind-Box-Sammelfiguren';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Ein bunter Popkultur-Laden in Chaoyang mit vollen Regalen und ungeöffneten Designer-Sammelboxen.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Drohnenaufnahmen der Skyline am Bund';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'Die Bund-Promenade in der Abenddämmerung mit Blick auf die beleuchteten Wolkenkratzer von Pudong.';

  @override
  String get goldenRetrieverCafeInNanjing => 'Golden-Retriever-Café in Nanjing';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Ein sonniges Tiercafé mit freundlichen, verschmusten Hunden, die Gäste begrüßen.';

  @override
  String get boulderingClimbingGymInChengdu => 'Boulderhalle in Chengdu';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Eine moderne Kletterhalle mit abwechslungsreichen Routen und motivierender Musik.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Eine riesige Messehalle voller bunter Gaming-Stände, Fotowände und Cosplayer.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Nach dem Weg in einem Pekinger Hutong fragen';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Ein Labyrinth historischer Gassen aus grauen Ziegeln mit Fahrrädern, Innenhöfen und Granatapfelbäumen.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Frisches Obst auf dem traditionellen Frischemarkt kaufen';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Ein lebhafter Straßenmarkt am Morgen mit Bergen von frischen Litschis, Mangos und Drachenfrüchten.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Blumenstrauß auf dem Blumenmarkt in Kunming';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'Der berühmte Dounan-Blumenmarkt, umgeben von Tausenden frischen Rosen, Lilien und Eukalyptuszweigen.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Änderungsschneiderei in einem traditionellen Gassenhaus';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Eine traditionelle Schneiderei voller Nähmaschinen, Stoffballen und Maßbändern.';

  @override
  String get expressParcelLockerRetrieval =>
      'Paket aus der Packstation abholen';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'Unten am Eingang eines Wohnhauses neben einem intelligenten Hive-Paketbox-System.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Platten Fahrradreifen am Campus-Tor reparieren';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Ein kleiner Werkzeugstand am Straßenrand unter einem großen, belaubten Banyanbaum.';

  @override
  String get techCompanyProductDemo =>
      'Produktvorführung eines Tech-Unternehmens';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Ein futuristischer Tech-Konferenzstand in Shenzhen, der hochmoderne KI-Hardware präsentiert.';

  @override
  String get ecommerceLivestreamStudio => 'E-Commerce-Livestream-Studio';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Ein energiegeladenes Broadcast-Studio mit Ringlichtern, Produktständern und Live-Kommentar-Monitoren.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Internationaler Handelsmarkt Yiwu';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Ein riesiges, mehrstöckiges Handels- und Ausstellungszentrum voller Großhandelswaren und Kunsthandwerk.';

  @override
  String get universityCampusExchangeProgram =>
      'Austauschprogramm auf dem Universitätscampus';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Eine sonnige Wiese vor der Universitätsbibliothek mit Studierenden, die lernen und Milchtee trinken.';

  @override
  String get pleaseEnterAScenarioTopic => 'Bitte gib ein Szenario-Thema ein.';

  @override
  String get nameTitle => 'Name (Titel)';

  @override
  String get aiCharacter => 'KI-Charakter';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Hallo! Herzlich willkommen, worüber wollen wir heute sprechen?';

  @override
  String get greetYourConversationPartner => 'Begrüße deinen Gesprächspartner';

  @override
  String get askAQuestionInChinese => 'Stelle eine Frage auf Chinesisch';

  @override
  String get pinyinWithToneMarks => 'Pinyin mit Tonzeichen';

  @override
  String get goal1InEnglish => 'Ziel 1 auf Deutsch';

  @override
  String get goal2InEnglish => 'Ziel 2 auf Deutsch';

  @override
  String get goal3InEnglish => 'Ziel 3 auf Deutsch';

  @override
  String get beginner => 'Anfänger';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Meister';

  @override
  String get azurePronunciationAssessment => 'AZURE-AUSSPRACHEBEWERTUNG';

  @override
  String get tapToReview => 'Zum Überprüfen tippen';

  @override
  String get overallScore => 'Gesamtpunktzahl';

  @override
  String get toneAccuracy => 'Ton-Genauigkeit';

  @override
  String get fluency => 'Flüssigkeit';

  @override
  String get report => 'Bericht';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Gute Aussprache, aber es geht noch besser!';

  @override
  String get didYouMeanToSay => 'Meintest du...?';

  @override
  String get greatKeepTrying => 'Großartig! Versuche es weiter!';

  @override
  String get completeness => 'Vollständigkeit';

  @override
  String get targetTone => 'Zielton';

  @override
  String get k4toneComparisonTapToListen =>
      '4-Töne-Vergleich (Zum Anhören tippen):';

  @override
  String get youSpokeMatch => 'Du hast gesprochen (Übereinstimmung!)';

  @override
  String get youSpoke => 'Du hast gesprochen';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Deine primäre Zeichensammlung.';

  @override
  String get deckNotFound => 'Deck nicht gefunden';

  @override
  String get cannotDeleteTheDefaultDeck =>
      'Das Standard-Deck kann nicht gelöscht werden';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Obere Mittelstufe';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'Die ersten 150 Zeichen, um deine Reise zu beginnen.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Erweitere deinen Wortschatz auf 300 essentielle Wörter.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Meistere die Konversationsflüssigkeit mit 600 Wörtern.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Lies Texte und unterhalte dich fließend mit 1200 Wörtern.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Lies Zeitungen und schau Filme mit 2500 Wörtern.';

  @override
  String get databaseBoxNotOpen => 'Datenbank nicht geöffnet';

  @override
  String get hsk1DataFileIsEmpty => 'HSK1-Datendatei ist leer';

  @override
  String get gold => 'Gold';

  @override
  String get globalDictionaryNotInitialized =>
      'Globales Wörterbuch nicht initialisiert';

  @override
  String get reading => 'Lesen';

  @override
  String get recall => 'Abrufen';

  @override
  String get speaking => 'Sprechen';

  @override
  String get listening1 => 'Hören';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Übe die Strichfolge mit visuellen Hilfen.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Sieh das Zeichen, erinnere dich an Pinyin und Bedeutung.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Lies die Bedeutung, zeichne das Zeichen aus dem Gedächtnis.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Lies laut vor, um deine Aussprache und Töne zu testen.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Höre die Audioaufnahme und erkenne das Zeichen.';

  @override
  String get contract => 'Vertrag';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Wer mich implementiert, MUSS diese Dinge tun können.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck oder lokal';

  @override
  String get manageDecks => 'Decks verwalten';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Beim Laden der Bibliothek ist ein Problem aufgetreten. Bitte versuche es erneut.';

  @override
  String get noCharactersInLexicon1 => 'Keine Zeichen im Lexikon';

  @override
  String get masterTheBuildingBlocks => 'Meistere die Bausteine';

  @override
  String get other => 'Sonstiges';

  @override
  String get requiredLabel => 'Erforderlich';

  @override
  String get library1 => 'Bibliothek';

  @override
  String get youAreAPremiumMember => 'Du bist ein Premium-Mitglied';

  @override
  String get createAccountToSyncProgress =>
      'Konto erstellen, um den Fortschritt zu synchronisieren';

  @override
  String get signOut => 'Abmelden';

  @override
  String get account => 'Konto';

  @override
  String get guestScholar => 'Gastgelehrter';

  @override
  String get localAccount => 'Lokales Konto';

  @override
  String get unknownRadical => 'Unbekanntes Radikal';

  @override
  String get followTheGuideStroke => 'Folge der Strichführung';

  @override
  String get strokeAnimationSpeed => 'Strich-Animationsgeschwindigkeit';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get deutsch => 'Deutsch';

  @override
  String get bahasaIndonesia => 'Indonesisch';

  @override
  String get italiano => 'Italienisch';

  @override
  String get today1d2d3d4d5d6d => 'Heute, 1T, 2T, 3T, 4T, 5T, 6T';

  @override
  String get targetDeck => 'Ziel-Deck';

  @override
  String get mixed => 'Gemischt';

  @override
  String get topicForContext => 'Thema (für den Kontext)';

  @override
  String get nounsOnly => 'Nur Nomen';

  @override
  String get verbsOnly => 'Nur Verben';

  @override
  String get idiomsChengyu => 'Redewendungen (Chengyu)';

  @override
  String get fullSentences => 'Ganze Sätze';

  @override
  String get beginnerHsk12 => 'Anfänger (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Mittelstufe (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Fortgeschritten (HSK 5-6)';

  @override
  String get generatedByAi => 'Von KI generiert';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Kannst du mir zwei weitere Beispiele mit diesem Wort geben?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Welche Wörter sind ähnlich und wie unterscheiden sie sich?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Wird dieses Wort eher im gesprochenen oder geschriebenen Chinesisch verwendet?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Gibt es andere Möglichkeiten, dieses Wort zu übersetzen?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'Welche Wörter werden häufig mit diesem Wort kombiniert?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Welche häufigen Fehler machen Lernende bei diesem Wort?';

  @override
  String get emptyResponse => 'Leere Antwort';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Was ist der Ursprung dieses Zeichens in der Orakelknochenschrift?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Wie hat sich die historische Form dieses Zeichens im Laufe der Zeit entwickelt?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Nenne mir 3 gebräuchliche Wörter, die dieses Zeichen enthalten.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'Welche anderen Zeichen teilen sich dasselbe Radikal?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Gibt es ein chinesisches Sprichwort oder eine Redewendung mit diesem Zeichen?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Erkläre die Regeln der Strichfolge für dieses Zeichen.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Gib mir einen Kalligrafie-Tipp, um dieses Zeichen schön zu schreiben.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Gibt es bei der Verwendung grammatikalische Besonderheiten?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'Mit welchen Wörtern wird dieses oft verwechselt und warum?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Trägt dieses Zeichen eine besondere kulturelle Symbolik in China?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Kommt dieses Zeichen häufig in chinesischen Filmen, Liedern oder Texten vor?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Was bedeutet das Radikal dieses Zeichens?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Schlüssele jede Komponente und ihre Bedeutung auf.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Gib mir eine Eselsbrücke, um mir den richtigen Ton für dieses Zeichen zu merken.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Gibt es häufige Homophone, die oft mit diesem Zeichen verwechselt werden?';

  @override
  String get quotaExceeded => 'Kontingent überschritten';

  @override
  String get mustProvideEitherCardOrCards =>
      'Es muss entweder eine Karte oder mehrere Karten angegeben werden';

  @override
  String get deckSettings => 'Deck-Einstellungen';

  @override
  String get saveSettings => 'Einstellungen speichern';

  @override
  String get sealRed => 'Rotes Siegel';

  @override
  String get sealScript => 'Siegelschrift';

  @override
  String get startYourStreak => 'STREAK STARTEN';

  @override
  String get traditionalCharacter => 'Traditionelles Zeichen';

  @override
  String get inQueue => 'In Warteschlange';

  @override
  String get tapToListenAgain => 'Zum erneuten Anhören tippen';

  @override
  String get contextClue => 'Kontexthinweis';

  @override
  String get microphonePermissionRequired1 =>
      'Mikrofonberechtigung erforderlich.';

  @override
  String get recordingFailedNoFile => 'Aufnahme fehlgeschlagen (keine Datei).';

  @override
  String get holdToSpeakOptional => 'Zum Sprechen gedrückt halten (optional)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Mikrofonberechtigung verweigert. Aktiviere sie in den Einstellungen, um das Shadowing-Studio zu nutzen.';

  @override
  String get sessionSummary => 'Sitzungszusammenfassung';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Hier sind die Zeichen, bei denen du Schwierigkeiten hattest:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Sitzungsbewertungen auf Spaced Repetition anwenden (Sprechmodus)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Meistere deine Mandarin-Aussprache\nindem du Muttersprachler nachsprichst.';

  @override
  String get aiIsGradingYourPronunciation => 'KI bewertet deine Aussprache...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Mikrofon zum Aufnehmen gedrückt halten. Loslassen zum Bewerten.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Tippe auf eine Silbe, um alle 4 Töne anzuhören:';

  @override
  String get freeFlowConversationalPractice => 'Freie Konversationsübung.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Satz konnte nicht generiert werden. Bitte versuche es erneut.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Aufnahme zu kurz. Halte die Mikrofontaste länger gedrückt.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Aufnahmefehler. Bitte versuche es erneut.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Keine Aufnahme erfasst. Bitte versuche es erneut.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'Audioaufnahme ist stumm. Bitte versuche es erneut und sprich deutlich.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Azure Speech API-Schlüssel fehlen';

  @override
  String get azureError401 => 'Azure-Fehler 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Azure-Authentifizierung fehlgeschlagen. Überprüfe deinen Speech-API-Schlüssel und deine Region in .env';

  @override
  String get azureError429 => 'Azure-Fehler 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Azure-Kontingent überschritten. Bitte versuche es später erneut.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Zeitüberschreitung bei Azure-Bewertung. Bitte überprüfe deine Internetverbindung.';

  @override
  String get recognitionFailedNull => 'Erkennung fehlgeschlagen: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Wir konnten dich nicht deutlich verstehen. Bitte versuche es erneut.';

  @override
  String get singlePhrasePractice => 'Einzelphrasen-Übung';

  @override
  String get failedToGeneratePhrase => 'Satz konnte nicht generiert werden';

  @override
  String get omitted => 'Ausgelassen';

  @override
  String get partial => 'Teilweise';

  @override
  String get mispronounced => 'Falsch ausgesprochen';

  @override
  String get startSession1 => 'Sitzung starten';

  @override
  String get chinese => 'Chinesisch';

  @override
  String get paused => 'Pausiert';

  @override
  String get translationFailed => 'Übersetzung fehlgeschlagen';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Fesselnde makroökonomische und wirtschaftliche Analysen, lebendig erzählt.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Erforscht Weltwirtschaften, Bankengeschichte und globale Industriedynamiken.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Klares, verständliches Mandarin – ideal für fortgeschrittene Lernende.';

  @override
  String get chefWang => 'Chefkoch Wang';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Meistere die Kochkunst Sichuans, direkt vermittelt von einem professionellen Küchenchef.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Schritt-für-Schritt authentische chinesische Rezepte mit Wok- und Messerführung.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Prägnantes Küchenvokabular und klare Anleitungen in natürlichem Mandarin.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Kinematografie, modernste Kameratechnik und fundierte Medienbewertungen.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Hochwertiger Dokumentarstil über Videoproduktion und KI-Innovationen.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Facettenreiches technisches Mandarin mit glasklarer Aussprache und visuellen Untertiteln.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Tiefgehender investigativer Journalismus und Kommentare zum Zeitgeschehen.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Kritische Perspektiven auf soziale Phänomene, Weltnachrichten und Geschichte.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Formeller Diskurs, ideal für anspruchsvolles Hörverständnis.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Kurze animierte Wissenschaftsdokus, die alltägliche Fragen beantworten.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Erforscht Physik, Biologie und Alltagsphänomene mit anschaulichen Infografiken.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Standard-Pekinger Mandarin mit angenehmer Erzählgeschwindigkeit und klaren Untertiteln.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Herzerwärmende Streetfood-Abenteuer und authentische Gespräche quer durch China.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Erforscht regionale Lebensgeschichten, Familientraditionen und lokale Köstlichkeiten.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Natürliches Alltagsmandarin mit Umgangssprache und persönlicher Wärme.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Humorvolle und ehrliche Testberichte zu Unterhaltungselektronik aus der Praxis.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Praxistests von Smartphones, Smart-Home-Geräten und Tech-Lifestyle-Produkten.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Entspannte, humorvolle Dialoge mit modernen Redewendungen.';

  @override
  String get seanKitchen => 'Seans Küche';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Köstliche hausgemachte chinesische Gerichte und Streetfood-Klassiker.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Leicht verständliche Küchentipps zum Kochen authentischer asiatischer Gerichte.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Herzliche Kommentare mit praktischem Küchenvokabular.';

  @override
  String get chineseChannel => 'Chinesischer Kanal';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Strukturierte Chinesisch-Lektionen und Videos zur kulturellen Entdeckung.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Grammatikpunkte, HSK-Vokabelaufbau und Konversationsmuster.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Klares Lerntempo, optimal auf Chinesischlernende abgestimmt.';

  @override
  String get oneInABillion => 'Einer von einer Milliarde';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Persönliche Porträts und Geschichten außergewöhnlicher Menschen im modernen China.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Erforscht vielfältige Lebenswege, Jugendkultur und modernen gesellschaftlichen Wandel.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Tiefgründiges Storytelling mit reichhaltigem Wortschatz und authentischen Stimmen.';

  @override
  String get vickySoup => 'Vicky Soup';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Ästhetische Lifestyle-Vlogs, Modestyling und Alltagsroutinen.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Reisetagebücher und gemütliche Lebensmomente mit filmischer Wärme.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Natürliches, ungezwungenes Mandarin in angenehmem, ausdrucksstarkem Tempo.';

  @override
  String get tededMandarin => 'TED-Ed Mandarin';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Hochwertige animierte Bildungslektionen zu Wissenschaft, Philosophie und Geschichte.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Denkanstößige Rätsel, klassische Literatur und psychologische Geheimnisse.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Makellose Mandarin-Sprecherstimme mit synchronisierten zweisprachigen Untertiteln.';

  @override
  String get channel => 'Kanal';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Kuratierte Kulturdokumentationen und Einblicke in den chinesischen Lifestyle.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Erkundung traditioneller Handwerkskünste, des Kulturerbes und moderner Trends.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Hochwertige Audioqualität mit synchronisierten chinesischen Untertiteln.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Interessante Geschichten und kreative Videoprojekte aus dem chinesischen Web.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Fesselnde Interviews, Erzählungen und visuelle Erkundungen.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Hervorragendes Hörmaterial mit Standardaussprache.';

  @override
  String get xVsY => 'X gegen Y';

  @override
  String get untitled => 'Ohne Titel';

  @override
  String get contemporaryStories => 'Zeitgenössische Geschichten';

  @override
  String get history => 'Geschichte';

  @override
  String get advancedReading => 'Fortgeschrittenes Lesen';

  @override
  String get intermediateReading => 'Mittleres Lesen';

  @override
  String get beginnerReading => 'Anfänger-Lesen';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get localDb => 'Lokale Datenbank';

  @override
  String get emperorTaizong => 'Kaiser Taizong';

  @override
  String get emperorXuanzong => 'Kaiser Xuanzong';

  @override
  String get liBai => 'Li Bai';

  @override
  String get gradedReader => 'Gestufte Lesetexte';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Mandarin lernen mit TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'Alltagschinesisch';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinesisch';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi => 'Ting – Alltag in China';

  @override
  String get xinxin => 'Xinxin';

  @override
  String get sweetFamilyDailyLife => 'Harmonisches Familienleben';

  @override
  String get chinsunDailyLife => 'Chin-Sun Alltagsleben';

  @override
  String get tasteChina => 'Geschmack Chinas';

  @override
  String get dawenFoodQuest => 'DaWens kulinarische Entdeckungsreise';

  @override
  String get chinaTravelWithCangbao => 'China-Reise mit Cangbao';

  @override
  String get alinFoodWalk => 'Alins kulinarischer Spaziergang';

  @override
  String get videoOfTheDay => 'VIDEO DES TAGES';

  @override
  String get noValidVideoFound => 'Kein passendes Video gefunden.';

  @override
  String get listeningPractice => 'HÖRÜBUNG';

  @override
  String get socialSkills => 'SOZIALE KOMPETENZEN';

  @override
  String get culturalContext => 'KULTURELLER KONTEXT';

  @override
  String get realLife => 'ECHTES LEBEN';

  @override
  String get realWorld => 'REALE WELT';

  @override
  String get articleOfTheDay => 'ARTIKEL DES TAGES';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Fehler beim Laden oder Verarbeiten des RSS-Feeds.';

  @override
  String get drama => 'Drama';

  @override
  String get youkugetAppNow => 'YOUKU – Jetzt App holen';

  @override
  String get romanceTrailer => 'Romantik / Trailer';

  @override
  String get romance => 'Romantik';

  @override
  String get action => 'Aktion';

  @override
  String get mystery => 'Mysterium';

  @override
  String get historical => 'Historisch';

  @override
  String get historicalAction => 'Historisch / Action';

  @override
  String get historicalRomance => 'Historisch / Romantik';

  @override
  String get anYouth => 'Jugend';

  @override
  String get historicalSliceOfLife => 'Historisch / Slice of Life';

  @override
  String get historicalHighlight => 'Historisch / Highlight';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU Englisch – Jetzt App holen';

  @override
  String get theDouble => 'The Double';

  @override
  String get updatesByOshin => 'Updates von Oshin';

  @override
  String get backFromTheBrink => 'Zurück vom Abgrund';

  @override
  String get fallingIntoYourSmile => 'In dein Lächeln verliebt';

  @override
  String get everyoneLovesMe => 'Jeder liebt mich';

  @override
  String get tillTheEndOfTheMoon => 'Bis ans Ende des Mondes';

  @override
  String get theBestDayOfMyLife => 'Der beste Tag meines Lebens';

  @override
  String get gikkiChineseDrama => 'GIKKI Chinesisches Drama';

  @override
  String get dashingYouth => 'Schwungvolle Jugend';

  @override
  String get rebornChineseDramaEngSub =>
      'Wiedergeboren: Chinesisches Drama mit Untertiteln';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'Wenn ich zu dir fliege';

  @override
  String get mztvExclusiveChineseDrama => 'MZTV Exklusives Chinesisches Drama';

  @override
  String get theStarryLove => 'Die sternenklare Liebe';

  @override
  String get comedy => 'Komödie';

  @override
  String get backFromTheBrink1 => 'Zurück vom Abgrund';

  @override
  String get dashingYouth1 => 'Schwungvolle Jugend';

  @override
  String get beReborn => 'Wiedergeboren werden';

  @override
  String get beautyStrategy => 'Schönheitsstrategie';

  @override
  String get myDivineEmissary => 'Mein göttlicher Gesandter';

  @override
  String get theHope => 'Die Hoffnung';

  @override
  String get ep16In => 'Folge 16';

  @override
  String get everyoneLovesMe1 => 'Jeder liebt mich';

  @override
  String get fallingIntoYourSmile1 => 'In dein Lächeln verliebt';

  @override
  String get hiddenLove => 'Verborgene Liebe';

  @override
  String get loveBetweenFairyAndDevil => 'Liebe zwischen Fee und Teufel';

  @override
  String get loveLikeTheGalaxy => 'Liebe wie die Galaxie';

  @override
  String get membersPremiere => 'Mitglieder-Premiere';

  @override
  String get moonlight => 'Mondlicht';

  @override
  String get myJourneyToYou => 'Meine Reise zu dir';

  @override
  String get mysteriousLotusCasebook => 'Das geheimnisvolle Lotus-Fallbuch';

  @override
  String get rebornChineseDramaEngSub1 =>
      'Wiedergeboren: Chinesisches Drama mit Untertiteln';

  @override
  String get reborn => 'Wiedergeboren';

  @override
  String get theBestDayOfMyLife1 => 'Der beste Tag meines Lebens';

  @override
  String get theDouble1 => 'The Double';

  @override
  String get theLongBallad => 'Die lange Ballade';

  @override
  String get theStarryLove1 => 'Die sternenklare Liebe';

  @override
  String get theUntamed => 'Der Ungezähmte';

  @override
  String get tillTheEndOfTheMoon1 => 'Bis ans Ende des Mondes';

  @override
  String get whenIFlyTowardsYou1 => 'Wenn ich zu dir fliege';

  @override
  String get wordOfHonor => 'Wort der Ehre';

  @override
  String get blossom => 'Blüte';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'Von Generation zu Generation';

  @override
  String get brocadeOdyssey => 'Brokat-Odyssee';

  @override
  String get circleOfLove => 'Kreis der Liebe';

  @override
  String get dawnIsBreaking => 'Die Dämmerung bricht an';

  @override
  String get firstRomance => 'Erste Romanze';

  @override
  String get loveInTheClouds => 'Liebe in den Wolken';

  @override
  String get secondChanceRomance => 'Zweite Chance für die Liebe';

  @override
  String get mrBad => 'Mr. Bad';

  @override
  String get pursuitOfJade => 'Jagd nach Jade';

  @override
  String get fatedHearts => 'Schicksalhafte Herzen';

  @override
  String get roadHome => 'Heimweg';

  @override
  String get myDearGuardian => 'Mein lieber Wächter';

  @override
  String get brightEyesInTheDark => 'Helle Augen in der Dunkelheit';

  @override
  String get theIngeniousOne => 'Der Scharfsinnige';

  @override
  String get herPhoenixMajesty => 'Ihre Phönix-Majestät';

  @override
  String get dreamsNeverEnd => 'Träume enden nie';

  @override
  String get theUltimateVowUnknownToYou =>
      'Das ultimative Gelübde, dir unbekannt';

  @override
  String get the300LoyalGhosts => 'Die 300 loyalen Geister';

  @override
  String get homelandGuardian => 'Heimatwächter';

  @override
  String get loveIsAlwaysOnline => 'Liebe ist immer online';

  @override
  String get thePrincessDecree => 'Das Prinzessinnen-Dekret';

  @override
  String get aVowInTheDark => 'Ein Gelübde im Dunkeln';

  @override
  String get aGirlLikeMe => 'Ein Mädchen wie ich';

  @override
  String get iAmNobody => 'Ich bin niemand';

  @override
  String get myMamaGo => 'Meine Mama geht!';

  @override
  String get myWesternRegionPrincess => 'Meine Prinzessin der Westregion';

  @override
  String get aFlowerOnTheContinent => 'Eine Blume auf dem Kontinent';

  @override
  String get thePrincess => 'Die Prinzessin';

  @override
  String get sweetLoveVersion => 'Süße Liebesversion';

  @override
  String get hilariousFamily2 => 'Urkomische Familie 2';

  @override
  String get guYuanMountainHasASchool => 'Der Gu-Yuan-Berg hat eine Schule';

  @override
  String get foreverYoung => 'Für immer jung';

  @override
  String get theHiddenHeirYeChen => 'Der verborgene Erbe Ye Chen';

  @override
  String get extraordinary => 'Außergewöhnlich';

  @override
  String get sideStoryOfFoxVolant => 'Nebengeschichte des fliegenden Fuchses';

  @override
  String get loveOfTheDivineTree => 'Liebe des göttlichen Baumes';

  @override
  String get rebirth => 'Wiedergeburt';

  @override
  String get moonlitReunion => 'Wiedersehen im Mondlicht';

  @override
  String get videoCountsCannotBeNegative =>
      'Die Anzahl der Videos darf nicht negativ sein.';

  @override
  String get publicDomainClassic => 'Gemeinfreier Klassiker';

  @override
  String get idioms => 'Redewendungen';

  @override
  String get news => 'Nachrichten';

  @override
  String get fairyTales => 'Märchen';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Hier ist eine faszinierende kulturelle Erklärung';

  @override
  String get videoFetchTimedOut => 'Zeitüberschreitung beim Videoabruf';

  @override
  String get aboutChannel => 'ÜBER DEN KANAL';

  @override
  String get noVideosFound => 'Keine Videos gefunden';

  @override
  String get failedToLoadVideos => 'Videos konnten nicht geladen werden';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Hochwertige, kuratierte Mandarin-Inhalte mit natürlichem Vokabular.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Authentisches gesprochenes Chinesisch zu realen Themen und Sachverhalten.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Fesselndes Videomaterial mit interaktiven synchronisierten Untertiteln.';

  @override
  String get watchVideo => 'Video ansehen';

  @override
  String get culturalInsight => 'Kultureller Einblick';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'KI analysiert den kulturellen Kontext...';

  @override
  String get diveIntoFullContent => 'Zum vollständigen Inhalt';

  @override
  String get savedArticles => 'Gespeicherte Artikel';

  @override
  String get liveOverlay => 'ECHTZEIT-LESEHILFE';

  @override
  String get webExplorer => 'WEB-EXPLORER';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Durchstöbere jede chinesische Website mit Echtzeit-Wörterbuch, Pinyin-Annotationen und Sofortübersetzungen.';

  @override
  String get startExploring => 'ERKUNDUNG STARTEN';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Chinesische TV-Serien mit interaktiven Untertiteln';

  @override
  String get failedToLoadContent => 'Inhalt konnte nicht geladen werden';

  @override
  String get searchingYoutube => 'YouTube wird durchsucht...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'Keine Videos gefunden. Versuche einen anderen Suchbegriff.';

  @override
  String get searching => 'Wird gesucht';

  @override
  String get noShowsFound => 'Keine Sendungen gefunden';

  @override
  String get bookmarked => 'Gespeichert';

  @override
  String get trailer1 => 'Trailer';

  @override
  String get highlight1 => 'Highlight';

  @override
  String get noCaptionsAvailable => 'Keine Untertitel verfügbar';

  @override
  String get fetchingSubtitles => 'Untertitel werden abgerufen...';

  @override
  String get generatingAiBriefing => 'KI-Zusammenfassung wird generiert...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Für dieses Video wurden keine Untertitel (CC) gefunden.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Videos mit fest eingebrannten Untertiteln verfügen auf YouTube über keine digitalen Textspuren.';

  @override
  String get translatingSubtitles => 'Untertitel werden übersetzt...';

  @override
  String get processingYourPronunciation =>
      'Deine Aussprache wird analysiert...';

  @override
  String get couldntIdentifyLine => 'Zeile konnte nicht identifiziert werden.';

  @override
  String get listeningSpeakNow => 'Höre zu... sprich jetzt.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Dieses Video verfügt auf YouTube über keine digitale Untertitelspur (CC).';

  @override
  String get perfect1 => 'Perfekt';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Dieses Video wurde entfernt oder ist nicht mehr verfügbar.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Dieses Video kann in der App nicht abgespielt werden. Du kannst es weiterhin auf YouTube ansehen.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Dein Gerät kann dieses Video nicht abspielen. Bitte versuche ein anderes.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Ungültige Videoreferenz. Bitte versuche es erneut.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Dieses Video konnte nicht geladen werden. Bitte versuche ein anderes.';

  @override
  String get startReading => 'Lesen starten';

  @override
  String get analyzingCulturalContext =>
      'Kultureller Kontext wird analysiert...';

  @override
  String get failedToLoadCulturalInsight =>
      'Kultureller Einblick konnte nicht geladen werden.';

  @override
  String get historicalContext => 'Historischer Kontext';

  @override
  String get culturalSignificance => 'Kulturelle Bedeutung';

  @override
  String get authorBackground => 'Hintergrund des Autors';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'Über 80 vollständige klassische Romane & Weltepen';

  @override
  String get storyOfTheDay => 'GESCHICHTE DES TAGES';

  @override
  String get tangDynasty => 'Tang-Dynastie';

  @override
  String get poetryClassicalVerse => 'Klassische Poesie und Verse';

  @override
  String get allHsk => 'Alle HSK';

  @override
  String get allStories => 'Alle Geschichten';

  @override
  String get keyWords => 'Schlüsselwörter';

  @override
  String get openOriginalWebsite => 'Original-Website öffnen';

  @override
  String get aiReadingTools => 'KI-Lesewerkzeuge';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Verbessere dein Leseerlebnis mit KI-gestützten Werkzeugen';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Wähle den Zielschwierigkeitsgrad für die Vereinfachung';

  @override
  String get chooseDifficultyForSimplification =>
      'Wähle den Schwierigkeitsgrad für die Vereinfachung';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Alle unbekannten Wörter in ein neues Lernkarten-Deck extrahieren';

  @override
  String get length => 'Länge';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Web-Extraktion';

  @override
  String get aiTools => 'KI-Tools';

  @override
  String get stop => 'Stopp';

  @override
  String get keepPracticing1 => 'Weiter üben';

  @override
  String get aiPrepRoom => 'KI-Vorbereitungsraum';

  @override
  String get lessonSummary => 'LEKTIONSÜBERSICHT';

  @override
  String get unlockSinosparkPremium => 'SinoSpark Premium freischalten';

  @override
  String get monthYear => 'Monat / Jahr';

  @override
  String get enableNotifications => 'Benachrichtigungen aktivieren';

  @override
  String get notificationsConfigured => 'Benachrichtigungen konfiguriert';

  @override
  String get neverMissAStroke2 => 'Verpasse nie wieder einen Strich';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Deine täglichen Lern- und Streak-Benachrichtigungen sind bereit.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Bleibe am Ball mit täglichen Lektionen und rechtzeitigen Test-Erinnerungen.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Ein neues Wort und eine Geschichte warten auf dein tägliches Ritual.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Sanfte Erinnerungen, bevor Zeichen aus deinem Gedächtnis verblassen.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Erhalte eine Erinnerung 2 Tage vor Ablauf deiner kostenlosen Testphase.';

  @override
  String get yourPathTonchineseFluency =>
      'Dein Weg zu\nchinesischer Sprachkompetenz';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Beantworte 3 kurze Fragen, damit unsere KI\neinen Lehrplan erstellen kann, der zu deinem Leben passt.';

  @override
  String get whatIsYourLevelnwithChinese =>
      'Wie ist dein Niveau\nin Chinesisch?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Wähle den Weg, der deinem Kenntnisstand entspricht.';

  @override
  String get whatDrivesYourStudy => 'Was motiviert dich zum Lernen?';

  @override
  String get purposeFuelsTheBrush => 'Das Ziel leitet den Pinsel';

  @override
  String get setYourDailyRitual => 'Lege dein tägliches Ritual fest.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Du kannst dein Ritual jederzeit anpassen.';

  @override
  String get letsBegin => 'Lass uns beginnen';

  @override
  String get brandNew => 'Kompletter Anfänger';

  @override
  String get iveNeverStudiedChineseBefore =>
      'Ich habe noch nie Chinesisch gelernt.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Ich kenne grundlegende Zeichen und Sätze.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Ich kann einfache Gespräche führen und lesen.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Ich möchte meine Fähigkeiten verfeinern und perfektionieren.';

  @override
  String get confirmSelection => 'Auswahl bestätigen';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'Das Ziel leitet die Bewegung des Pinsels.';

  @override
  String get buildMyPath => 'Meinen Pfad erstellen';

  @override
  String get hskCertification => 'HSK-Zertifizierung';

  @override
  String get culturalAppreciation => 'Kulturelle Wertschätzung';

  @override
  String get yourPlanIsReady => 'Dein Lernplan ist bereit';

  @override
  String get craftingYourCurriculum => 'Erstellung deines Lehrplans...';

  @override
  String get personalizedPathInitialized =>
      'PERSONALISIERTER PFAD INITIALISIERT';

  @override
  String get calibratingAiNeuralMasters => 'KALIBRIERE NEURONALE KI-MEISTER...';

  @override
  String get calibrationComplete => 'Kalibrierung abgeschlossen';

  @override
  String get synthesizingModules => 'Module werden zusammengestellt...';

  @override
  String get oneAndWater => '„Eins“ und „Wasser“';

  @override
  String get theHorizontalStroke => 'DER HORIZONTALE STRICH (HÉNG)';

  @override
  String get theRadical => 'DAS RADIKAL';

  @override
  String get water => 'Wasser';

  @override
  String get river => 'Fluss';

  @override
  String get day5Reminder => 'Erinnerung an Tag 5';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Wir haben versprochen, dich 2 Tage vor Ablauf deiner Testphase zu erinnern, damit du in Ruhe entscheiden kannst.';

  @override
  String get continueWithoutReminder => 'Ohne Erinnerung fortfahren';

  @override
  String get masterChineseWithnsinospark =>
      'Meistere Chinesisch mit\nSinoSpark';

  @override
  String get start7dayFreeTrial => '7 Tage kostenlos testen';

  @override
  String get precisionStrokes => 'Präzise Strichführung';

  @override
  String get aiPronunciation => 'KI-Aussprache';

  @override
  String get today => 'Heute';

  @override
  String get fullAccess => 'Voller Zugriff';

  @override
  String get day5 => 'Tag 5';

  @override
  String get reminder => 'Erinnerung';

  @override
  String get day7 => 'Tag 7';

  @override
  String get trialBegins => 'Testphase beginnt';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat fehlt ein aktuelles Angebot oder Pakete. Bitte konfiguriere dein Dashboard.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Kameraberechtigung für Live-Scan erforderlich.';

  @override
  String get cameraAccessRequired => 'Kamerazugriff erforderlich';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Bitte aktiviere den Kamerazugriff in deinen Geräteeinstellungen, um diese Funktion zu nutzen.';

  @override
  String get alignChineseTextWithinFrame =>
      'Richte den chinesischen Text im Rahmen aus';

  @override
  String get inLibrary => 'In der Bibliothek';

  @override
  String get novice => 'Anfänger';

  @override
  String get apprentice => 'Lehrling';

  @override
  String get artisan => 'Handwerker';

  @override
  String get grandmaster => 'Großmeister';

  @override
  String get poem => 'Gedicht';

  @override
  String get theNarrative => 'Die Erzählung';

  @override
  String get classicMasterpiece => 'Klassisches Meisterwerk';

  @override
  String get classicAuthor => 'Klassischer Autor';

  @override
  String get classical => 'Klassisch';

  @override
  String get classicLiterature => 'Klassische Literatur';

  @override
  String inThisChapterOf(Object title) {
    return 'In diesem Kapitel von $title';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'Während sich die Erzählung entfaltet, offenbart sie zeitlose Weisheit und dauerhafte Inspiration.';

  @override
  String get general => 'Allgemein';

  @override
  String get mythology => 'Mythologie';

  @override
  String get dailyLife => 'Alltag';

  @override
  String get tangPoetry => 'Tang-Poesie';

  @override
  String get classicalLiterature => 'Klassische Literatur';

  @override
  String get justNow => 'Gerade eben';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'Die Terrakotta-Armee von Qin Shihuang';

  @override
  String get lifeInsideTheForbiddenCity => 'Das Leben in der Verbotenen Stadt';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Ein Ticket kaufen und mit dem Hochgeschwindigkeitszug in China fahren';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Wegen einer Erkältung zum Arzt gehen';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'In einem traditionellen Restaurant Jiaozi (Teigtaschen) bestellen';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'Die traditionelle Gongfu-Teezeremonie';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'Die Kunst, chinesische Schriftzeichen mit dem Pinsel zu schreiben';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'Das Leben und der Schutz von Riesenpandas';

  @override
  String get storyNotFoundInDatabase =>
      'Geschichte nicht in der Datenbank gefunden';

  @override
  String get storyTextIsEmpty => 'Text der Geschichte ist leer';

  @override
  String get myCustomStories => 'Meine eigenen Geschichten';

  @override
  String get userProvidedText => 'Vom Nutzer bereitgestellter Text';

  @override
  String get local => 'Lokal';

  @override
  String get voiceEngineAllowance => 'Sprach-Engine & Guthaben';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD vs. unbegrenzte Standardstimme';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'Standardstimme ist zu 100 % unbegrenzt und kostenlos';

  @override
  String get read => 'Lesen';

  @override
  String get koreKoreFemaleWarm => 'Kore (weiblich, warm)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (weiblich, fröhlich)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (männlich, optimistisch)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (männlich, sachlich)';

  @override
  String get puckPuckMaleSporty => 'Puck (männlich, sportlich)';

  @override
  String get localOndevice => 'Lokal (integrierte Gerätestimme)';

  @override
  String get localOndeviceTts => 'Lokale geräteinterne Sprachausgabe (TTS)';

  @override
  String get off => 'Aus';

  @override
  String get endOfCurrentChapter => 'Ende des aktuellen Kapitels';

  @override
  String get standardVoice => 'Standardstimme';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Keine Romane gefunden, die deinem Filter entsprechen.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Keine Mikro-Lektüren gefunden, die deinem Filter entsprechen.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Keine Gedichte gefunden, die deinem Filter entsprechen.';

  @override
  String get audiobook => 'Hörbuch';

  @override
  String get audio => 'Audio';

  @override
  String get continueReading => 'Weiterlesen';

  @override
  String get search96FullNovelsAuthorsEpics =>
      '96 vollständige Romane, Autoren und Epen durchsuchen...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Klassische Gedichte, Autoren und Verse durchsuchen...';

  @override
  String get allLevelsVal => 'Alle Niveaus';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Anfänger)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Grundstufe)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Mittelstufe)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Obere Mittelstufe)';

  @override
  String get listenToAudiobook => 'Hörbuch anhören';

  @override
  String get synopsis => 'Zusammenfassung';

  @override
  String get peoplesArtist => 'Volkskünstler';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '„Kafkaesk“ für bürokratische Absurdität, Entfremdung und existenzielle Angst.';

  @override
  String get bigBrotherAndNewspeak => '„Big Brother“ und „Neusprech“.';

  @override
  String get audiobookIncluded => 'Hörbuch enthalten';

  @override
  String get readPoem => 'Gedicht lesen';

  @override
  String get studioVoiceAllowance => 'Studio-Stimmen-Guthaben';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Wöchentliche hochauflösende KI-Rezitation';

  @override
  String get resetsEveryMondayAt0000 =>
      'Wird jeden Montag um 00:00 Uhr zurückgesetzt';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Wenn dein wöchentliches 4-Stunden-Studio-Guthaben aufgebraucht ist, wechselt die App automatisch zur integrierten Gerätestimme für unbegrenztes, kostenloses Hören ohne Unterbrechung.';

  @override
  String get localDeviceVoice => 'Integrierte Gerätestimme';

  @override
  String get classicalVerse => 'Klassischer Vers';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Gerätestimme (4 Std. wöchentlich genutzt)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Erstelle eine individuelle KI-Geschichte basierend auf deinen Interessen';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Anstelle eines starren HSK-Niveaus analysiert die Flow-State-Engine deine persönliche Kartensammlung.';

  @override
  String get we => 'Wir';

  @override
  String get howCanWeHelpYou => 'Wie können wir dir helfen?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Alles, was du über SinoSpark, seine Funktionen und deinen Datenschutz wissen musst.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Wer sind die Sprecher in der App?';

  @override
  String get howDoesTheWebExplorerWork => 'Wie funktioniert der Web-Explorer?';

  @override
  String get whatIsZenMode => 'Was ist der Zen-Modus?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Wie funktioniert die Spaced Repetition der Lernkarten?';

  @override
  String get traceComplete => 'Nachzeichnen abgeschlossen!';

  @override
  String get traceCharacter => 'Zeichen nachzeichnen';

  @override
  String get analyzingWordRelationships =>
      'Wortbeziehungen werden analysiert...';

  @override
  String get identifyingUsageContexts =>
      'Nutzungskontexte werden identifiziert...';

  @override
  String get comparingFormalityLevels =>
      'Formalitätsgrade werden verglichen...';

  @override
  String get findingCommonCollocations =>
      'Häufige Wortverbindungen werden gesucht...';

  @override
  String get generatingComparison => 'Vergleich wird erstellt...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'Die Erstellung dauert länger als erwartet. Die KI ist möglicherweise stark ausgelastet.';

  @override
  String get generationInterruptedShowingPartial =>
      'Erstellung unterbrochen. Teilergebnis wird angezeigt.';

  @override
  String get sorrySomethingWentWrong =>
      'Entschuldigung, etwas ist schiefgelaufen.';

  @override
  String get usage => 'Verwendung:';

  @override
  String get alsoSeenIn => 'Kommt auch vor in';

  @override
  String get quickLook => 'Schnellansicht';

  @override
  String get notFound => 'Nicht gefunden';

  @override
  String get errorLoadingFromAi => 'Fehler beim Laden von der KI.';

  @override
  String get analyzingImage => 'Bild wird analysiert...';

  @override
  String get extractingChineseText => 'Chinesischer Text wird extrahiert...';

  @override
  String get lookingUpVocabulary => 'Vokabeln werden nachgeschlagen...';

  @override
  String get dreamOfTheRedChamber => 'Der Traum der Roten Kammer';

  @override
  String get journeyToTheWest => 'Die Reise nach Westen';

  @override
  String get romanceOfTheThreeKingdoms => 'Die Geschichte der Drei Reiche';

  @override
  String get mingDynasty => 'Ming-Dynastie';

  @override
  String get wuChengEn => 'Wu Cheng\'en';

  @override
  String get hundredChapters => '100 Kapitel';

  @override
  String get volume1 => 'Band 1';

  @override
  String bookmarksCount(Object count) {
    return 'Lesezeichen ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Noch keine Lesezeichen vorhanden. Tippe auf das Lesezeichensymbol, um eine Textstelle zu speichern.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark reagiert nicht';

  @override
  String get closeApp => 'App schließen';

  @override
  String get wait => 'Warten';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours Std.';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Buch zu $percent % gelesen';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Kap. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count Bücher & Hörbücher';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Satz $current von $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Kapitel $current von $total';
  }

  @override
  String get allLevels => 'Alle Stufen';

  @override
  String get searchGradedMicroStories =>
      'Gestufte Kurzgeschichten & Fabeln durchsuchen...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count gestufte Geschichten & tägliche Mikro-Lektüren';
  }

  @override
  String get searchClassicalPoems =>
      'Klassische Gedichte, Autoren und Verse durchsuchen...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count klassische Gedichte & Verse';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Durchstöbere jede chinesische Website mit Sofortwörterbuch, Pinyin-Anzeige und Echtzeit-Übersetzungen.';

  @override
  String get completed => 'ABGESCHLOSSEN';

  @override
  String get aiIsReading => 'KI liest vor...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Fortgeschritten)';

  @override
  String get hsk1Beginner => 'HSK 1 (Anfänger)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Obere Mittelstufe)';

  @override
  String get extractAllUnknownWords =>
      'Alle unbekannten Wörter in ein neues Lernkarten-Deck extrahieren';

  @override
  String get designCustomAiRoleplay =>
      'Individuelles KI-Rollenspiel & Gespräch entwerfen';

  @override
  String get practiceFlashcardVocabulary =>
      'Lernkarten-Vokabular im Live-Dialog trainieren';

  @override
  String get surpriseMe => 'Überrasch mich';

  @override
  String get rollCharacter => 'Zufälligen Charakter wählen';

  @override
  String get historicalCostume => 'Historisch / Kostümdrama';

  @override
  String get modernYouth => 'Modern & Jugend';

  @override
  String get fantasyMythology => 'Fantasy & Mythologie';

  @override
  String get familyDrama => 'Familie & Drama';

  @override
  String get fullVersion => 'Vollversion';

  @override
  String episodesCount(Object count) {
    return '$count Folgen';
  }

  @override
  String episodeLabel(Object number) {
    return 'Folge $number';
  }

  @override
  String get translating => '[ Übersetzung läuft... ]';

  @override
  String get engSub => '[DE UT]';

  @override
  String get standardVocabulary => 'Standardvokabular';

  @override
  String get characters => 'Zeichen';

  @override
  String get todayDashboard => 'Heute';

  @override
  String get studyToday => 'Heutige Karten lernen';

  @override
  String get studyAhead => 'Vorauslernen';

  @override
  String get studyAheadDescription =>
      'Übe die nächsten anstehenden Wiederholungen, ohne dein heutiges Kontingent zu verbrauchen. Es werden keine neuen Karten eingeführt.';

  @override
  String get studyAheadComplete => 'Vorauslernen abgeschlossen';

  @override
  String get dueNow => 'Jetzt fällig';

  @override
  String get scheduled => 'Geplant';

  @override
  String get sevenDayForecast => '7-Tage-Vorschau';

  @override
  String get reviews => 'Wiederholungen';

  @override
  String get newCardsLabel => 'Neue Karten';

  @override
  String get attempts => 'Versuche';

  @override
  String get duration => 'Dauer';

  @override
  String get answerBreakdown => 'Antwortübersicht';

  @override
  String get reviewCards => 'Wiederholungskarten';

  @override
  String get retries => 'Erneute Versuche';

  @override
  String get needsPractice => 'Übung nötig';

  @override
  String get uniqueCardsStudied => 'Karten';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'In die andere Richtung zeichnen ➔';

  @override
  String get fastClean => 'Schnell & sauber!';

  @override
  String get good2 => 'Gut!';

  @override
  String get followTheFlow => 'Folge dem Fluss.';

  @override
  String get masterful => 'Meisterhaft!';

  @override
  String get missingTheHookEnd => 'Haken/Ende fehlt.';

  @override
  String get thai => 'Thailändisch';

  @override
  String get dartIo => 'dart:io';

  @override
  String get dartAsync => 'dart:async';

  @override
  String get asset => 'asset:';

  @override
  String get ocpApimSubscriptionKey => 'Ocp-Apim-Subscription-Key';

  @override
  String get xMicrosoftOutputFormat => 'X-Microsoft-OutputFormat';

  @override
  String get audio24khz48kbitrateMonoMp3 => 'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get googleGemini25Flash => 'google/gemini-2.5-flash';

  @override
  String get ink => 'Tusche,';

  @override
  String get stroke => 'Strich,';

  @override
  String get breath => 'Atem.';

  @override
  String get deepseekDeepseekChat => 'deepseek/deepseek-chat';

  @override
  String get hTTPReferer => 'HTTP-Referer';

  @override
  String get xTitle => 'X-Title';

  @override
  String get data => 'data:';

  @override
  String get shadowingModeCustomSentence => 'ShadowingMode.customSentence';

  @override
  String get theExactSentenceProvided => 'genau der angegebene Satz';

  @override
  String get pinyinWithToneMarks2 => 'Pinyin mit Tonzeichen';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Extrahiere alle chinesischen Zeichen aus diesem Bild. Gib NUR den extrahierten Text zurück – keine Kommentare, keine Formatierung, keine Übersetzungen. Behalte Zeilenumbrüche bei. Wenn keine chinesischen Zeichen vorhanden sind, gib eine leere Zeichenkette zurück.';

  @override
  String get householdObject => 'Haushaltsgegenstand';

  @override
  String get genericLabelFromTheList => 'allgemeines Label aus der Liste';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'Zählwort';

  @override
  String get zenInk => 'Zen & Tusche';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'WICHTIG: Füge die englische Übersetzung in den JSON-Schlüssel „english“ ein!';

  @override
  String get definitionInEnglish => 'Definition auf Englisch';

  @override
  String get simplifiedLine0 => 'Vereinfachte Zeile 0';

  @override
  String get simplifiedLine1 => 'Vereinfachte Zeile 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'WICHTIGE REGEL: Sprechen Sie den Benutzer nicht mit Namen an. Verwenden Sie niemals Platzhalternamen wie „John“. Sprechen Sie ihn direkt ohne Namen an.';

  @override
  String get rULESAnswerIn23 =>
      'REGELN: Antworte in max. 2–3 Sätzen. Bevorzuge Aufzählungspunkte für Listen.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Schreibe keine Einleitungen, Verabschiedungen oder Füllfloskeln wie „Gute Frage!“ oder „Sicher!“.';

  @override
  String get useBoldForChineseCharacters =>
      'Verwende **Fettgedruckt** für chinesische Schriftzeichen und Schlüsselbegriffe.';

  @override
  String get rULESAnswerIn232 => 'REGELN: Antworte in max. 2–3 Sätzen.';

  @override
  String get accept => 'Akzeptieren';

  @override
  String get pronunciationAssessment => 'Aussprachebewertung';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'Keine';

  @override
  String get theCorrectedChineseText => 'der korrigierte chinesische Text';

  @override
  String get thePinyinForTheCorrected => 'das Pinyin für den korrigierten Text';

  @override
  String get theEnglishMeaningOfThe =>
      'die englische Bedeutung des korrigierten Textes';

  @override
  String get pNyNWithTone => 'Pīnyīn mit Tonzeichen';

  @override
  String get englishTranslation2 => 'Englische Übersetzung';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Du bist ein Experte für klassische chinesische Literatur und bietest detaillierte, zugängliche Zusammenfassungen klassischer chinesischer Poesie.';

  @override
  String get youAreAChineseCulture =>
      'Du bist ein Experte für chinesische Kultur und Literatur. Biete äußerst ansprechende, schön geschriebene kulturelle Einblicke.';

  @override
  String get english2 => 'Englisch:';

  @override
  String get remindersWhenYouHavenT =>
      'Erinnerungen, wenn Sie die App einige Tage nicht genutzt haben';

  @override
  String get itSBeenAFew =>
      'Es ist schon ein paar Tage her! Nimm dir heute 5 Minuten Zeit, um ein neues Hanzi zu lernen.';

  @override
  String get abbreviationFor => 'Abkürzung für';

  @override
  String get cL => 'ZW:';

  @override
  String get measureWord2 => 'Zählwort:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'kein-benutzer';

  @override
  String get passwordRequired => 'passwort-erforderlich';

  @override
  String get unsupportedProvider => 'nicht-unterstützter-anbieter';

  @override
  String get appleRevocationUnavailable => 'apple-widerruf-nicht-verfügbar';

  @override
  String get appleCredentialMissing => 'apple-anmeldedaten-fehlen';

  @override
  String get authenticationDidNotReturnA =>
      'Authentifizierung lieferte keinen Benutzer.';

  @override
  String get viewSubscriptionPlans => 'Abonnements anzeigen';

  @override
  String get wrongPassword => 'falsches-passwort';

  @override
  String get invalidCredential => 'ungültige-anmeldedaten';

  @override
  String get networkRequestFailed => 'netzwerkanfrage-fehlgeschlagen';

  @override
  String get requiresRecentLogin => 'erfordert-kürzliche-anmeldung';

  @override
  String get userMismatch => 'benutzer-nicht-übereinstimmend';

  @override
  String get deleteAccountPassword => 'konto-löschen-passwort';

  @override
  String get deleteAccountError => 'konto-löschen-fehler';

  @override
  String get deleteAccountSubmit => 'konto-löschen-bestätigen';

  @override
  String get theSimplestShapesTheBeginning =>
      'Die einfachsten Formen. Der Anfang aller Dinge.';

  @override
  String get sunMoonWaterAndFire => 'Sonne, Mond, Wasser und Feuer. Die Natur.';

  @override
  String get theBodyTheHeartAnd => 'Der Körper, das Herz und die Familie.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Felder, Dächer und Werkzeuge. Die Fundamente der Gesellschaft.';

  @override
  String get movementSpeechAndSustenance => 'Bewegung, Sprache und Nahrung.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Handel, Kleidung und komplexe Artefakte.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Schnellspur! Einfaches Zeichen gemeistert.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Ausgezeichnete Präzision! Hilfslinie übersprungen.';

  @override
  String get sample => 'Beispiel:';

  @override
  String get itsThat => 'Sein/Jenes';

  @override
  String get iMe => 'Ich/Mich';

  @override
  String get stillTough => 'Noch/Schwer';

  @override
  String get partDecide => 'Teil/Entscheiden';

  @override
  String get selectTheCharacterFor => 'Wähle das Zeichen für:';

  @override
  String get selectThePinyinFor => 'Wähle das Pinyin für:';

  @override
  String get whereAreYouGoingThe =>
      'Wohin gehst du? Zum Flughafen? Das ist eine weite Reise!';

  @override
  String get youAreAuntieChenA =>
      'Du bist Tante Chen, eine geschäftstüchtige Marktverkäuferin für Seide und Stoffe. Deine EINZIGE Rolle ist die einer Marktverkäuferin. Verhandele die Preise bestimmt, aber fair auf Chinesisch. Verlasse NIEMALS deine Rolle und stelle dich nicht als etwas anderes als eine Verkäuferin vor. Starte mit hohen Preisen und sei verhandlungsbereit.';

  @override
  String get youAreDrZhangA =>
      'Du bist Dr. Zhang, ein ruhiger und professioneller Arzt in einer Klinik. Deine EINZIGE Rolle ist die eines Arztes. Erkundige dich nach Symptomen und gib medizinische Ratschläge auf Chinesisch. Verlasse NIEMALS deine Rolle und stelle dich nicht als etwas anderes als ein Arzt vor. Sei beruhigend, aber gründlich.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Wo fühlst du dich unwohl? Hast du Fieber?';

  @override
  String get youAreACloseFriend =>
      'Du bist ein enger Freund, der sich nach langer Zeit wieder meldet. Deine EINZIGE Rolle ist die eines Freundes. Halte deine Antworten locker, warmherzig und kurz auf Chinesisch. Verlasse NIEMALS deine Rolle und stelle dich nicht als etwas anderes als ein Freund vor. Nutze eine lockere Umgangssprache für gute Freunde.';

  @override
  String get noNbest => 'Kein N-Best';

  @override
  String get timedOut => 'Zeitüberschreitung';

  @override
  String get grading => 'Bewertung...';

  @override
  String get label1st => '1. ˉ';

  @override
  String get label2nd => '2. ˊ';

  @override
  String get label3rd => '3. ˇ';

  @override
  String get label4th => '4. ˋ';

  @override
  String get speaking2 => 'Spricht...';

  @override
  String get sessionCompletedInYourNext =>
      'Sitzung beendet. Sprich in deiner nächsten Übung in ganzen Sätzen, um detaillierte Aussprache- und Tondiagnosen zu erhalten.';

  @override
  String get craneSoaring => 'Schwebender Kranich';

  @override
  String get gentleStream => 'Sanfter Bach';

  @override
  String get brushAndInk => 'Pinsel und Tusche';

  @override
  String get myStudent => 'Mein Schüler';

  @override
  String get honoredDisciple => 'Ehrwürdiger Jünger';

  @override
  String get notEnoughInformation => 'Nicht genügend Informationen';

  @override
  String get asAnAi => 'Als KI';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Gute Übungseinheit. Achte weiterhin auf klare Tonhöhenkontraste und ein natürliches Gesprächstempo.';

  @override
  String get insideASleekFuxingBullet =>
      'In einem schnittigen Fuxing-Hochgeschwindigkeitszug mit 350 km/h von Peking nach Shanghai.';

  @override
  String get harbinIceSnowWorldWonder => 'Wunder der Harbin Eis- & Schneewelt';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'Der berühmte Panjiayuan-Wochenendflohmarkt voller Kalligrafie-Rollen, Jade und Vintage-Trödel.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Jingdezhen-Studio für blau-weißes Porzellan';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Peking-Oper: Garderobe & Make-up';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Eine historische Tongrentang-Apotheke, duftend nach Ginseng, Goji-Beeren und hunderten Kräuterschubladen aus Holz.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Ein lebendiger, neonbeleuchteter Karaoke-Raum in Shenzhen mit Mikrofonen, Obstplatten und Bildschirmsteuerung.';

  @override
  String get animeCosplayExpoInGuangzhou =>
      'Anime- & Cosplay-Messe in Guangzhou';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Überrasche mich';

  @override
  String get eGALivelyBanquet => 'z. B. Ein lebhaftes Festmahl in Shanghai ...';

  @override
  String get rollCharacter2 => '🎲 Charakter würfeln';

  @override
  String get eGACuriousCousin =>
      'z. B. Ein neugieriger Cousin, der nach deiner Karriere fragt ...';

  @override
  String get keepTrying => 'Weiter versuchen!';

  @override
  String get pending => 'Ausstehend ...';

  @override
  String get expected => '🎯 Erwartet';

  @override
  String get hSK2Elementary => 'HSK 2: Grundstufe';

  @override
  String get hSK3Intermediate => 'HSK 3: Mittelstufe';

  @override
  String get hSK5Advanced => 'HSK 5: Fortgeschritten';

  @override
  String get expressYourselfFullyWith5000 =>
      'Drücke dich umfassend mit über 5000 Wörtern aus.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Unbegrenzt';

  @override
  String get dueToday => 'Heute fällig';

  @override
  String get newAvailable => 'Neu verfügbar';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Gib einen einzelnen, kurzen und praktischen Tipp, wie die Form, Position oder Länge der ungenau gezeichneten Striche verbessert werden kann. Sei direkt und hilfreich, nicht zu poetisch oder metaphorisch. Verwende kein Markdown.';

  @override
  String get localOnDeviceTTS => 'Lokal — On-Device-TTS';

  @override
  String get espaOl => 'Spanisch';

  @override
  String get franAis => 'Französisch';

  @override
  String get portuguS => 'Portugiesisch';

  @override
  String get tiNgViT => 'Vietnamesisch';

  @override
  String get koreFemaleWarm => 'Kore — Weiblich, warm';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Weiblich, heiter';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Männlich, schwungvoll';

  @override
  String get charonMaleNewsStyle => 'Charon — Männlich, Nachrichtenstil';

  @override
  String get puckMaleSporty => 'Puck — Männlich, sportlich';

  @override
  String get systemVoice => 'Systemstimme';

  @override
  String get generateAdd => 'Generieren & Hinzufügen';

  @override
  String get moreExamples => '📝 Mehr Beispiele';

  @override
  String get usage2 => '❓ Verwendung';

  @override
  String get translation => '💬 Übersetzung';

  @override
  String get collocations => '📚 Kollokationen';

  @override
  String get mistakes => '❌ Fehler';

  @override
  String get decrease => 'Verringern';

  @override
  String get increase => 'Erhöhen';

  @override
  String get label0MeansThisCardType =>
      '0 bedeutet, dass dieser Kartentyp deaktiviert ist.';

  @override
  String get tapTheValueToEnter =>
      'Tippe auf den Wert, um ein genaues Limit einzugeben.';

  @override
  String get exactDailyLimit => 'Genaues Tageslimit';

  @override
  String get enter0ToDisable => 'Gib 0 ein, um zu deaktivieren.';

  @override
  String get apply => 'Anwenden';

  @override
  String get selectDeck => 'Deck auswählen';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Azure Speech-Schlüssel nicht konfiguriert. Füge AZURE_SPEECH_KEY und AZURE_SPEECH_REGION zur .env hinzu.';

  @override
  String get sTARTING => 'WIRD GESTARTET…';

  @override
  String get sTARTSESSION => 'SITZUNG STARTEN';

  @override
  String get translating2 => 'Wird übersetzt...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'Wirtschaft & Ökonomie';

  @override
  String get hskPreparation => 'HSK-Vorbereitung';

  @override
  String get liveInChina => 'Leben in China';

  @override
  String get comprehensiveExercise => 'Umfassende Übung';

  @override
  String get howToUse => 'Anwendung';

  @override
  String get usesOf => 'Verwendung von';

  @override
  String get appearedFirstOnMandarinBean =>
      'Zuerst erschienen auf Mandarin Bean';

  @override
  String get news2 => 'Nachrichten:';

  @override
  String get joke => 'Witz:';

  @override
  String get jokes => 'Witze:';

  @override
  String get academicScience => 'Akademie / Wissenschaft';

  @override
  String get politicsCommunism => 'Politik & Kommunismus';

  @override
  String get foodDining => 'Essen & Gastronomie';

  @override
  String get sciFi => 'Sci-Fi';

  @override
  String get scienceFictionTech => 'Science-Fiction & Tech';

  @override
  String get travelPlaces => 'Reisen & Orte';

  @override
  String get mythologyFantasy => 'Mythologie & Fantasy';

  @override
  String get cultureTraditions => 'Kultur & Traditionen';

  @override
  String get businessEconomy => 'Wirtschaft & Finanzen';

  @override
  String get natureAnimals => 'Natur & Tiere';

  @override
  String get articleImg => 'Artikel-Bild';

  @override
  String get entryContentImg => '.entry-content img';

  @override
  String get zhHans => 'zh-Hans';

  @override
  String get zhHant => 'zh-Hant';

  @override
  String get pLDpUVcjhvJisQCVw4YJVNTxTDrVQUgbr =>
      'PLDpUVcjhvJisQCVw4YJVNTxT-DrVQUgbr';

  @override
  String get siJin => '【似锦 Si Jin】正片 | #张晚意 #景甜';

  @override
  String get xiXiPicturesOfficialChannel =>
      '西嘻影业官方频道 XiXi Pictures Offizieller Kanal';

  @override
  String get pLDpUVcjhvJitpknWzhJbWevf7VSVWXk2 =>
      'PLDpUVcjhvJitpknWzhJb-wevf7VSVWXk2';

  @override
  String get sIXSISTERS => '【六姊妹 SIX SISTERS】正片 | #梅婷 #陆毅 #邬君梅 #奚美娟';

  @override
  String get shineOnMeENGSUB => '【骄阳似我 Shine On Me】ENG SUB | #宋威龙 #赵今麦';

  @override
  String get eNGSUBThoseDays => 'ENG SUB【四喜 Those Days】| 童瑶 蒋欣 黄明昊 许娣';

  @override
  String get getTheWeTVAPP => '腾讯视频 - WeTV App holen';

  @override
  String get liziqi2 => '李子柒 Liziqi';

  @override
  String get uCQRJN2yW42jqXIGK2VKIPw => 'UCQ_RJN2yW42jqXIGK2VKIPw';

  @override
  String get uCt4t3iY8hL5sF5pV6qW2xRg => 'UCt4t3iY8hL5sF5pV6qW2xRg';

  @override
  String get uCp8q9rL2jG5hV7xW3mR5bNQ => 'UCp8q9rL2jG5hV7xW3mR5bNQ';

  @override
  String get uCvZ9W7u3T6a5YJS0VT28oA => 'UCvZ9W7u3T6a5YJS0VT-28oA';

  @override
  String get uCm7yM8rL5jG5pV6qW3xR2bQ => 'UCm7yM8rL5jG5pV6qW3xR2bQ';

  @override
  String get uCJ10R97LkwGdTqBT6xzV8g => 'UCJ10R97LkwGdTqBT6xz-v8g';

  @override
  String get learnMandarinWithTaiwanPlus => 'Mandarin lernen mit TaiwanPlus';

  @override
  String get everydayChinese => 'Alltagschinesisch';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting – Alltagsleben in China';

  @override
  String get tFTFOODTRAVEL => 'TFT – ESSEN & REISEN';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: Das Leben von Knoblauch';

  @override
  String get label2MINCULTURALCONTEXT => '2 MIN. KULTURELLER KONTEXT';

  @override
  String get liziqi4 => '李子柒 Liziqi: Bambusmöbel';

  @override
  String get peppaPigChinese2 => 'Peppa Pig Chinesisch: 泥坑';

  @override
  String get noBBCLeadArticleIs =>
      'Derzeit ist kein BBC-Hauptartikel verfügbar.';

  @override
  String get mediaThumbnail => 'media:thumbnail';

  @override
  String get bBC => 'BBC 中文';

  @override
  String get siJin2 => '似锦 Si Jin';

  @override
  String get n9Yh6jSqjg => 'n9Yh-6jSqjg';

  @override
  String get eV4j0RDXDVU => 'EV4j0RDXDVU';

  @override
  String get eY3hnHAmSg => 'e-Y3hnHAmSg';

  @override
  String get cD0Q81FnaY => 'CD0Q81-fnaY';

  @override
  String get label0UEwtWyW5s => '0UEwtWy-W5s';

  @override
  String get label8PNkm5Mxxk => '8PNkm5-Mxxk';

  @override
  String get iWNYkjEle8 => 'IWNYkj-ele8';

  @override
  String get rGrzq5WtBE => 'r-grzq5WtBE';

  @override
  String get tBo7q3wafw => 't-bo7q3wafw';

  @override
  String get iJkbO5H6E => 'I_jkbO5-h6E';

  @override
  String get oMM5UD0T2w => 'OMM5_UD0T2w';

  @override
  String get sIXSISTERS2 => '六姊妹 SIX SISTERS';

  @override
  String get cNylns5HiA => 'c-nylns5HiA';

  @override
  String get mEUH5U8EZa4 => 'MEUH5U8EZa4';

  @override
  String get label3Wx8JnjWZc => '3Wx8JnjW-Zc';

  @override
  String get qj17RJVE5B0 => 'Qj17RJVE5B0';

  @override
  String get vO4nggZ6Grs => 'VO4nggZ6Grs';

  @override
  String get zNR4WLEcJ4 => 'Z-NR4WLEcJ4';

  @override
  String get mA08u68O7Q => 'MA08u68O7_Q';

  @override
  String get ig8tnI0c9xM => 'Ig8tnI0c9xM';

  @override
  String get gIBYzq4lFtw => 'GIBYzq4lFtw';

  @override
  String get qDOf4OCZgd0 => 'QDOf4OCZgd0';

  @override
  String get shineOnMe => '骄阳似我 Shine on Me';

  @override
  String get zx7pUK2J1Uc => 'Zx7pUK2J1Uc';

  @override
  String get zdgymrBo9Y => 'zdgymr-bo9Y';

  @override
  String get label7yMAZEUBs => '7yMAZ_e-uBs';

  @override
  String get l9AqUHU14 => '_l9AqU-hU14';

  @override
  String get label1elnMxr0A0 => '1elnMxr0-A0';

  @override
  String get ozsUxgd7sk => 'OzsUxgd-7sk';

  @override
  String get label4czDUfmwv8 => '4cz-dUfmwv8';

  @override
  String get iuiTM37MII => 'iuiTM37M-II';

  @override
  String get xgXf9j96yM => 'XgXf-9j96yM';

  @override
  String get thoseDays => '四喜 Damals';

  @override
  String get a5nhDbkkCU => 'a5nhDbkkC-U';

  @override
  String get jb8unABN00 => '-jb8unABN00';

  @override
  String get label78OX9HXqKA => '78OX-9HXqKA';

  @override
  String get oDw77ocPGXg => 'ODw77ocPGXg';

  @override
  String get tt28uayZ7U => '-tt28uayZ7U';

  @override
  String get sOl3U7rPEPc => 'SOl3U7rPEPc';

  @override
  String get sffGZZpJ48 => 'sffGZZp-j48';

  @override
  String get v2UNvBajdY => 'v2UNv-BajdY';

  @override
  String get noFunnyNoMoney => '不好笑就露宿街头 Nicht lustig, kein Geld';

  @override
  String get dob3yGGLHIg => 'Dob3yGGLHIg';

  @override
  String get q5vqCQ6P9Pk => 'Q5vqCQ6P9Pk';

  @override
  String get label9Nc40rZ3b8 => '-9Nc40rZ3b8';

  @override
  String get d3zEt3pV8 => '_D3z-Et3pV8';

  @override
  String get label5S3yHQ10 => '5_S3yHQ--10';

  @override
  String get jQbyRRCa5U => 'JQbyR-rCa5U';

  @override
  String get x5WFTXq2FW0 => 'X5WFTXq2FW0';

  @override
  String get getTheWeTVAPP2 => '腾讯视频 - 动漫 - WeTV-App herunterladen';

  @override
  String get y4TWL0m2i4c => 'Y4TWL0m2i4c';

  @override
  String get uVZdKZcAXU => 'UV-ZdKZcAXU';

  @override
  String get mR8VUhHc => '-__MR8VUhHc';

  @override
  String get jrTInzf1Kc => 'Jr_tInzf1Kc';

  @override
  String get xfjz857p3w => 'Xfjz_857p3w';

  @override
  String get mI1Wl3V5WBE => 'MI1Wl3V5WBE';

  @override
  String get lordOfMysteriesVlog =>
      '„Lord of Mysteries“ Cuttlefish Synchron-Vlog Finale – Tencent Video - Anime';

  @override
  String get lordOfMysteries =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 8 – Tencent Video - Anime';

  @override
  String get lordOfMysteries2 =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 7 – Tencent Video - Anime';

  @override
  String get lordOfMysteries3 =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 6 – Tencent Video - Anime';

  @override
  String get lordOfMysteries4 =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 5 – Tencent Video - Anime';

  @override
  String get lordOfMysteries5 =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 4 – Tencent Video - Anime';

  @override
  String get lordOfMysteries6 =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 3 – Tencent Video - Anime';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 2 – Tencent Video - Anime';

  @override
  String get lordOfMysteries8 =>
      '„Lord of Mysteries“ Okkultismus-Unterricht Folge 1 – Tencent Video - Anime';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '[OST] „Lord of Mysteries“ Abspannlied „Vergissmeinnicht“ – Tencent Video - Anime';

  @override
  String get membersPremiere2 => 'Premiere für Mitglieder';

  @override
  String get dOtFXu1Vw => '_dOt-fXu1Vw';

  @override
  String get eA13aHY8jw => 'EA13aH_Y8jw';

  @override
  String get jVfwogmt8JM => 'JVfwogmt8JM';

  @override
  String get sfj9727Xu4 => 'Sfj9727-Xu4';

  @override
  String get tnv6Me0FI4s => 'Tnv6Me0FI4s';

  @override
  String get wEY80ZpZ8 => 'wEY80-_ZpZ8';

  @override
  String get pNRv9ncKDq4 => 'PNRv9ncKDq4';

  @override
  String get yZI6rr4wR1I => 'YZI6rr4wR1I';

  @override
  String get bDzKpcxWto => 'B-DzKpcxWto';

  @override
  String get dy9QDPpZBk => 'dy9QDPpZ-bk';

  @override
  String get tZ53akmpvyc => 'TZ53akmpvyc';

  @override
  String get label4Ip1rJO4gE => '4-Ip1rJO4gE';

  @override
  String get label5VKww8pjFA => '5-vKww8pjFA';

  @override
  String get label60SpwYfgUU => '60Spw-yfgUU';

  @override
  String get v8AG9HnmFA => 'V8AG9_hnmFA';

  @override
  String get vY6ao4ktdo => '-vY6ao4ktdo';

  @override
  String get htxVeakvE => '-htx-veakvE';

  @override
  String get fO7muIAr9dA => 'FO7muIAr9dA';

  @override
  String get s4O9Nk3Q4 => 'S4_O9Nk-3Q4';

  @override
  String get lMDHc55prI => 'LM_dHc55prI';

  @override
  String get lGpl7G7850 => '-LGpl7G7850';

  @override
  String get xJ2dwZ2xCw0 => 'XJ2dwZ2xCw0';

  @override
  String get qo47iejJOQ => 'Qo_47iejJOQ';

  @override
  String get gbnoj9WUP5Y => 'Gbnoj9WUP5Y';

  @override
  String get qCHKUuwF0 => 'QCHKUuw_f_0';

  @override
  String get qyh4kU263OA => 'Qyh4kU263OA';

  @override
  String get vnTQZY6QM => 'Vn-TQZ_Y6QM';

  @override
  String get vwk9yx7WL0c => 'Vwk9yx7WL0c';

  @override
  String get uLa6Qw2aL0 => 'u-La6Qw2aL0';

  @override
  String get kQJ5gjZwU0 => 'k-QJ5gjZwU0';

  @override
  String get mQH5jhyqPHc => 'MQH5jhyqPHc';

  @override
  String get h6rjzyquxA => 'h6rjzyqux-A';

  @override
  String get pLMX26aiIvX5phl8n87NqTbaeXK2HHm =>
      'PLMX26aiIvX5phl8n8-7-nqTbaeXK2HHm-';

  @override
  String get eightHundred => '方圆八百米 Achteinhundert';

  @override
  String get l1Xmsbo6RE => 'L1Xmsbo6_rE';

  @override
  String get dq1IgosbLQ => 'Dq1Igosb_lQ';

  @override
  String get i8e9E1bZR7I => 'I8e9E1bZR7I';

  @override
  String get iqRK2KUN0I => 'IqRK2KUN-0I';

  @override
  String get c3wWSQPFc0 => 'C3w-WSQPFc0';

  @override
  String get loveBeyondTheGrave => '白日提灯 Love Beyond the Grave';

  @override
  String get rPWA2OHxlaw => 'RPWA2OHxlaw';

  @override
  String get label8NShMGCGZk => '8NShMG-cGZk';

  @override
  String get q2TPc3EOYl4 => 'Q2TPc3EOYl4';

  @override
  String get pmPPM7YT5M => 'PmPP-M7YT5M';

  @override
  String get azFL5ujNQ0 => '-AzFL5ujNQ0';

  @override
  String get kpD2a0Z9yE => 'kpD-2a0Z9yE';

  @override
  String get dMAm1i8Ylb8 => 'DMAm1i8Ylb8';

  @override
  String get ppk0MGKF8Y => 'Ppk_0MGKF8Y';

  @override
  String get label1ZEKWcipU => '1_zEK-WcipU';

  @override
  String get dcOLJI4L5A => 'dcO-LJI4L5A';

  @override
  String get loveBeyondTheGrave2 =>
      'Set-Extra: He Simu & Duan Xu – Echte Namen gesucht, Spitznamen gefunden【白日提灯 Love Beyond the Grave】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'BTS｜【Drama-Party】Dilraba & Chen Feiyu mit dem Cast beim 5-Sinne-Fotoshooting!【白日提灯 Love Beyond the Grave】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'BTS｜【Drama-Party】Dilraba & Chen Feiyu begeistern mit umwerfenden Blicken!【白日提灯 Love Beyond the Grave】';

  @override
  String get herBlaze => 'Her Blaze';

  @override
  String get opOIDzw8Vo => 'Op_OIDzw8Vo';

  @override
  String get rv9nnIn4wxQ => 'Rv9nnIn4wxQ';

  @override
  String get c5e9V1GRnn8 => 'C5e9V1GRnn8';

  @override
  String get xAjvi1fmrrQ => 'XAjvi1fmrrQ';

  @override
  String get yIkxweh5A0 => 'yIkxweh5-A0';

  @override
  String get label9CM48di86g => '9-CM48di86g';

  @override
  String get dAwbSEDikg => 'D-AwbSEDikg';

  @override
  String get ecXCXc5EUg => 'Ec_xCXc5EUg';

  @override
  String get lKBf8Y0Qfqg => 'LKBf8Y0Qfqg';

  @override
  String get qnc5caQJITA => 'Qnc5caQJITA';

  @override
  String get xmLEreDeoU => 'xmLEreDeo-U';

  @override
  String get aboutLove => '玫瑰丛生 Über die Liebe';

  @override
  String get i4cZFlj8Fw => 'I4cZ-Flj8Fw';

  @override
  String get v8m00Hcam0 => 'V8m0-0Hcam0';

  @override
  String get aVPsfT4c4 => 'a-_vPsfT4c4';

  @override
  String get cJ9KNnY2cc => 'CJ9K-NnY2cc';

  @override
  String get j078HAJbI => 'J-078H-aJbI';

  @override
  String get byLJulMrNs => 'by-lJulMrNs';

  @override
  String get hj663skfypU => 'Hj663skfypU';

  @override
  String get lVOj0dkxDQ => 'LVOj0dkx-DQ';

  @override
  String get hKCVYT0J0 => 'hK-CVYT0J_0';

  @override
  String get v9czXRh5oUc => 'V9czXRh5oUc';

  @override
  String get af4fVhhPVg => 'af4fVhhP-Vg';

  @override
  String get tA =>
      '《玫瑰丛生》– Alle im Nebel der Liebe gefangen. Wie wird der Ausweg gelingen? | Hauptrollen: Wang Ziwen, Liu Yuning';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 Von Generation zu Generation';

  @override
  String get wCfp3YN9mPs => 'WCfp3YN9mPs';

  @override
  String get label0Sus6s0HWM => '0Sus6s0-hWM';

  @override
  String get zjcGjE54zU => 'Zjc-GjE54zU';

  @override
  String get g1q8I4lZ5mU => 'G1q8I4lZ5mU';

  @override
  String get y2IWPq6jFCE => 'Y2IWPq6jFCE';

  @override
  String get wz9oy74X8 => 'Wz9oy_74_x8';

  @override
  String get ztz3CXfrQE => '-ztz3CXfrQE';

  @override
  String get loveStoryInThe1970s => '纯真年代的爱情 Liebesgeschichte in den 1970ern';

  @override
  String get eGYAJh8Z8Pc => 'EGYAJh8Z8Pc';

  @override
  String get aBXZma9Mqc => 'A-bXZma9Mqc';

  @override
  String get wSHZC7Yb5s => 'WSHZC_7Yb5s';

  @override
  String get aK8Fl3m9W7I => 'AK8Fl3m9W7I';

  @override
  String get label0jw5TGzM0s => '0jw5T-gzM0s';

  @override
  String get xIbV4LmjNk => 'XIbV4-lmjNk';

  @override
  String get hkpSEzLKLg => 'HkpSEzLK-Lg';

  @override
  String get pLMX26aiIvX5q5kRTszb0kZqKc2TJWnf =>
      'PLMX26aiIvX5q5kR_Tszb0kZqKc2T-JWnf';

  @override
  String get whyIsHeStillSingle => '他为什么依然单身 Warum ist er noch Single';

  @override
  String get okB86OjCI => 'okB_86OjC-I';

  @override
  String get m8eZwl6rA4 => 'm8eZwl6rA-4';

  @override
  String get label3ub1XXXYI => '3ub-1-xXXYI';

  @override
  String get label4dW228WSVk => '4dW228-wSVk';

  @override
  String get wCAK3UFi5M => 'WCAK3_uFi5M';

  @override
  String get eZzak3C73nI => 'EZzak3C73nI';

  @override
  String get theGlamorousNight => '夜色正浓 Die glamouröse Nacht';

  @override
  String get theGlamorousNightE03 =>
      '【夜色正浓 Die glamouröse Nacht】E03 霸气出招！赵玫绝地反击（江疏影，佟大为）';

  @override
  String get zaalDLrc => '--Zaal-DLrc';

  @override
  String get label26Lkp84WD0 => '2-6Lkp84WD0';

  @override
  String get jD9iPkDDqC => 'jD9iPkDDq-c';

  @override
  String get jIyk18uXB7Q => 'JIyk18uXB7Q';

  @override
  String get h3XEsv0mgA => 'h3-xEsv0mgA';

  @override
  String get vClRnlEUTQ => 'VClRnlEUT-Q';

  @override
  String get myPageInThe90s => 'Plötzliche Liebe – My Page in the 90s';

  @override
  String get m7XBiuw1TU => 'm7XBiuw1-tU';

  @override
  String get a25pD4FCQio => 'A25pD4FCQio';

  @override
  String get muCj0GdNdw => 'muCj-0GdNdw';

  @override
  String get aQ4hlmkOv3A => 'AQ4hlmkOv3A';

  @override
  String get nEiRnIHDg => 'NEiRn_IH-Dg';

  @override
  String get label04MyPageInThe =>
      'Highlights 04: Verrücktes System drängt sich auf! Papiertuch wird zur Binde? Wie peinlich! 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Highlights 03: Blind Date für die beste Freundin – und plötzlich trifft sie den Hauptdarsteller? 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'Behind the Scenes | „Out of Character × Chen Xingxu × Wang Yuwen“ Wer von den beiden ist noch verrückter? 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Highlights 02: Wollte den Hauptdarsteller erobern, aber die falsche Person erwischt? 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Highlights 01: Verrückt! Plötzlich in ein Buch reingeraten? Wie soll ich diese Rolle spielen? 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'Behind the Scenes | Chen Xingxu und Wang Yuwen prallen beim Schlittschuhlaufen aufeinander 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'Behind the Scenes | Chen Xingxu und Wang Yuwen feiern süß ins neue Jahr 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'Behind the Scenes | Chen Xingxu und Wang Yuwen halten süße Qixi-Momente fest 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'Behind the Scenes | Chen Xingxu und Wang Yuwen mit viel Spaß im Freizeitpark 【Plötzliche Liebe – My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '„Plötzliche Liebe – My Page in the 90s“ feiert heute Premiere: Chen Xingxu und Wang Yuwen erleben eine süße Romanze';

  @override
  String get myPageInThe90s3 =>
      '„Plötzliche Liebe – My Page in the 90s“ startet am 22. Januar: Chen Xingxu und Wang Yuwen in einer erfrischenden Liebesgeschichte';

  @override
  String get myPageInThe90s4 =>
      '„Plötzliche Liebe – My Page in the 90s“ ab 22.01.! Chen Xingxu und Wang Yuwen in einer epochenübergreifenden Romanze';

  @override
  String get pLMX26aiIvX5qxr2ZxGgBQKRNVGydd =>
      'PLMX26aiIvX5qxr2ZxGgBQKR-n-V_Gydd-';

  @override
  String get uDFuWJvE1M => 'uDFuWJv-e1M';

  @override
  String get bNKH0V8G => 'bN-kH-0V8-g';

  @override
  String get l4tkACioRc => 'L4tkACio-Rc';

  @override
  String get label2TheImperialCoronerS2 => 'The Imperial Coroner Staffel 2';

  @override
  String get hNa1FW55Q5s => 'HNa1FW55Q5s';

  @override
  String get yyn06Ql7ADg => 'Yyn06Ql7ADg';

  @override
  String get h0LBmMzQBc => 'h0LBmMz-qBc';

  @override
  String get label25FI49I6Sk => '25FI49I6-Sk';

  @override
  String get aAY7eaH3jw => 'aAY7ea-H3jw';

  @override
  String get ukcZXSZhOc => 'UkcZX-SZhOc';

  @override
  String get pLMX26aiIvX5o7sdz290MeDHgSqCHsIS =>
      'PLMX26aiIvX5o7sdz290MeD-HgSqCHsI_s';

  @override
  String get theDreamMaker => 'Der Traumschöpfer The Dream Maker';

  @override
  String get fLcyGh4lXM => 'FLcy_gh4lXM';

  @override
  String get zvaRoKDtG0 => 'ZvaRoKDtG-0';

  @override
  String get x1CkUlPzUc => 'x1CkUl-pzUc';

  @override
  String get axn5uV9sXSw => 'Axn5uV9sXSw';

  @override
  String get hj11XBTF4hQ => 'Hj11XBTF4hQ';

  @override
  String get kzB7eE7CFc => 'Kz_B7eE7CFc';

  @override
  String get m5bbHdJrE => '-m5bb_HdJrE';

  @override
  String get vl9SPb3Hs => 'Vl9_s-Pb3Hs';

  @override
  String get y1y6xz0xM2I => 'Y1y6xz0xM2I';

  @override
  String get label8HxijD19OI => '8HxijD19O-I';

  @override
  String get nj33Wy40VXU => 'Nj33Wy40VXU';

  @override
  String get eDGFBue80s => 'EDGF_Bue80s';

  @override
  String get label19zBynsjTk => '19z-BynsjTk';

  @override
  String get oJmIfnNd8s => 'oJmIfnNd-8s';

  @override
  String get yVp1Ms3ZE8 => 'YVp1_Ms3ZE8';

  @override
  String get foreverYoungE23 =>
      '【轻年 Forever Young】E23 Martin kehrt in die Hutong zurück und wird von Brüdern kontrolliert (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 Präzise, stabil und gnadenlos! Martin lehrt die Schwägerin, ihren Mann zu manipulieren (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 Gibt es einen Rivalen? Martin wird von einem Grünschnabel Onkel genannt (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get fEYoHxyxzQ => 'FEYo_hxyxzQ';

  @override
  String get zF8OR9onddY => 'ZF8OR9onddY';

  @override
  String get b1FJGDAKV8 => 'B1FJ-GDAKV8';

  @override
  String get pLL3q9saUp1GZjNkX3Zxfr4y8rZhaZ0jV =>
      'PLL3q9saUp1GZj-nkX3Zxfr4y8rZhaZ0jV';

  @override
  String get hOMELANDGUARDIAN => '守诚者|HOMELAND GUARDIAN🚔';

  @override
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - Hole dir die iQIYI-App';

  @override
  String get label8QBlaWEtbw => '8Q-blaWEtbw';

  @override
  String get label0XrMBoHTsY => '0XrMBoH-TsY';

  @override
  String get zBzbg0Nu84 => 'zBzbg0-Nu84';

  @override
  String get label7ItX7Vt8Qc => '7ItX7Vt8-qc';

  @override
  String get zx5XvNKhXo => 'zx5Xv-NKhXo';

  @override
  String get nigVK5Ing => '-Nig_vK5Ing';

  @override
  String get loveHasFireworks => '爱情有烟火 Love Has Fireworks';

  @override
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - Hole dir die WeTV-App';

  @override
  String get oMOcpoXhYw => 'OMOcpoXh-yw';

  @override
  String get xwTcCP8TsU => 'XwTc-CP8TsU';

  @override
  String get t4dBHQH9F0I => 'T4dBHQH9F0I';

  @override
  String get jZP3R3khZMk => 'JZP3R3khZMk';

  @override
  String get cLBYyAU0AU => '-CLBYyAU0AU';

  @override
  String get x1F7qp1cZo => 'X-1F7qp1cZo';

  @override
  String get jJ5X6yEpiI => 'J-j5X6yEpiI';

  @override
  String get label8JmxrnwT0 => '8-jmxrnwT-0';

  @override
  String get gWvOJODRXU => 'gWvOJO-dRXU';

  @override
  String get t1VyWJTB2A => 't1VyWJT-b2A';

  @override
  String get e00xfXWql4Q => 'E00xfXWql4Q';

  @override
  String get theHiddenHeirYeChen2 => '进击的叶辰 Der verborgene Erbe Ye Chen';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => '去听旷野的风 Träume enden nie';

  @override
  String get mamaGo => '我的妈妈是校花 Mama Go!';

  @override
  String get o4rwrV9yv0 => 'O4rwr_v9yv0';

  @override
  String get x5Cm37j3g0 => 'X5Cm37j_3g0';

  @override
  String get jTqQ3t6gg => '_jTqQ3t-6gg';

  @override
  String get cNIRYF7Ig4 => 'cNIR-yF7Ig4';

  @override
  String get hr2GfDJNGg => 'Hr2GfD-JNGg';

  @override
  String get yXXjFZcZw => 'Y-X-xjFZcZw';

  @override
  String get xrBNQazEsk => 'xrBN-qazEsk';

  @override
  String get fJDN8r3rcRw => 'FJDN8r3rcRw';

  @override
  String get jEXB1NMkHs => 'JEXB1N-MkHs';

  @override
  String get d3dl69d81pQ => 'D3dl69d81pQ';

  @override
  String get xGZPKLBH8Q => 'XGZPK-LBH8Q';

  @override
  String get x59A8sSoGs => 'x59A8s-SoGs';

  @override
  String get lo6iApMzI => '_lo6iAp-mzI';

  @override
  String get d4a9aQ7h18 => 'D4a9aQ7h1_8';

  @override
  String get zCt0on2nA9s => 'ZCt0on2nA9s';

  @override
  String get b6BykN3fT4 => 'b6BykN3f-t4';

  @override
  String get eMZrxHTajM => 'EM-zrxHTajM';

  @override
  String get t1RJnvl2RA => 'T1RJnvl2R_A';

  @override
  String get hOE347NBAc => 'hOE-347NBAc';

  @override
  String get loveStoryInThe1970s2 =>
      '《纯真年代的爱情 Love Story in the 1970s》Der Kurzfilm mit zwei Handlungssträngen ist da~';

  @override
  String get loveStoryInThe1970s3 =>
      '《纯真年代的爱情 Love Story in the 1970s》Der Duo-Kurzfilm ist da~ Lasst uns mit unseren Sinnen einen Liebesbrief schreiben';

  @override
  String get bTSLoveStoryInThe =>
      'Hinter den Kulissen｜Dreharbeiten abgeschlossen, freuen uns auf das nächste Wiedersehen【Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《Love Story in the 1970s》Liebe ist ein Gedicht im Alltag~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《Love Story in the 1970s》Startet offiziell am 21. Februar~';

  @override
  String get dEZKlJqTo => 'DE_ZKl_jqTo';

  @override
  String get sc8aQLBntwk => 'Sc8aQLBntwk';

  @override
  String get aDa3c9hGZA => 'ADa_3c9hGZA';

  @override
  String get yj9xkfkxmpQ => 'Yj9xkfkxmpQ';

  @override
  String get idjCqdRyYG => 'idjCqdRyY-g';

  @override
  String get sqwEl8o75U => 'Sqw-El8o75U';

  @override
  String get wbF6Wgzai4 => 'WbF-6Wgzai4';

  @override
  String get pLyX50Z72L2xpkH5SEO0XjQxJPO1sC =>
      'PLyX_50Z72L2xpk_h5SEO0Xj_qx-jPO1sC';

  @override
  String get theTruth => 'Spuren im Wind – The Truth';

  @override
  String get q4im6PPfcw => 'Q4im6P_Pfcw';

  @override
  String get tsyfcT6RG8 => 'Tsyfc-t6RG8';

  @override
  String get pHOAi3EJ6Cg => 'PHOAi3EJ6Cg';

  @override
  String get l2EHE50Bhlw => 'L2EHE50Bhlw';

  @override
  String get pVgnsUnNXw => 'PVgnsUnN-Xw';

  @override
  String get pLyX50Z72L2wsEVLZsclrIke3z7FY8n =>
      'PLyX_50Z72L2wsEVL-zsclrIke3z7F-Y8n';

  @override
  String get ugNrNd0OM8 => 'Ug_nrNd0OM8';

  @override
  String get b4hADbXtGo => 'b4hADb-xtGo';

  @override
  String get rQXFQTj6XY => 'RQ_XFQTj6XY';

  @override
  String get a6TSVxp9x0 => 'A6TS_Vxp9x0';

  @override
  String get gwt9Y2ESIOA => 'Gwt9Y2ESIOA';

  @override
  String get c2tVD8rhVMM => 'C2tVD8rhVMM';

  @override
  String get pLyX50Z72L2wshCDZ4cWBwWHjigU7av =>
      'PLyX_50Z72L2wshCDZ4cW-BwWHjigU7av-';

  @override
  String get tW5f69bxL0 => 'TW_5f69bxL0';

  @override
  String get l8T7Lz5VN44 => 'L8T7Lz5VN44';

  @override
  String get cVLZ3AmkTE => '-cVLZ3AmkTE';

  @override
  String get t4E2lf096yM => 'T4E2lf096yM';

  @override
  String get wHENTJCl9M => 'WHENTJCl9-M';

  @override
  String get bTSOutOfCharacterDuo =>
      'BTS｜„Out of Character Duo-Interview“ Extras – Wer von Herr Gao und Huan\'er ist noch absurder? 《My Page in the 90s》 Tencent Video – Jugendtheater';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Highlight 04: Absurdes System drängt Extraszenen auf! Papiertuch wird zur Binde? Wie unangenehm! 《My Page in the 90s》 Tencent Video – Jugendtheater';

  @override
  String get label03MyPageInThe2 =>
      'Highlight 03: Zum Blind-Date statt der besten Freundin – und dort trifft sie den Hauptdarsteller? 《My Page in the 90s》 Tencent Video – Jugendtheater';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Highlight 02: Wollte den Hauptdarsteller erobern, hat aber die falsche Person erwischt? 《My Page in the 90s》 Tencent Video – Jugendtheater';

  @override
  String get label01MyPageInThe2 =>
      'Highlight 01: Verrückt! Plötzlich in ein Buch versetzt? Wie soll ich diese Rolle spielen? 《My Page in the 90s》 Tencent Video – Jugendtheater';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《My Page in the 90s》BTS｜Chen Xingxu und Wang Yuwen stoßen beim Schlittschuhlaufen zusammen';

  @override
  String get myPageInThe90s6 =>
      '《My Page in the 90s》Heute Premiere! Chen Xingxu und Wang Yuwen erleben eine süße Romanze im System';

  @override
  String get bTSMyPageInThe5 =>
      'BTS｜Lustige Interaktionen und knisternde Chemie zwischen Chen Xingxu und Wang Yuwen 【My Page in the 90s】';

  @override
  String get aYyrt0eGYw => 'AYyrt0e-gYw';

  @override
  String get qM5S5tiCI0 => 'QM_5S5tiCI0';

  @override
  String get w1mYTU1AGkg => 'W1mYTU1AGkg';

  @override
  String get pLyX50Z72L2zuddUfGdIXCxO1jAzTlPd =>
      'PLyX_50Z72L2zudd-ufGdIXCxO1jAzTlPd';

  @override
  String get jWEK0M59Ysk => 'JWEK0M59Ysk';

  @override
  String get p6l7C0ovRFM => 'P6l7C0ovRFM';

  @override
  String get vRYp5JmLwc => '-vRYp5JmLwc';

  @override
  String get dearSecretary => 'Meine liebe Sekretärin Dear Secretary';

  @override
  String get pAoESWUjrI => 'PAoES-wUjrI';

  @override
  String get pLyX50Z72L2yOG39wBXIFJlA2GtbWheA =>
      'PLyX_50Z72L2yOG39wBXIFJlA-2GtbWheA';

  @override
  String get label0JQ43Tt8D4 => '0J-q43Tt8D4';

  @override
  String get lIJJXYywPM => 'LIJ-jXYywPM';

  @override
  String get xLc3qBC5k => 'XLc3qB_c-5k';

  @override
  String get mKLZpubV04 => 'MKL_zpubV04';

  @override
  String get wXevXICxAQ => 'wXevXICx-AQ';

  @override
  String get xRRUT4fbgQ => 'xRR-uT4fbgQ';

  @override
  String get q5WMmVzsGQ => 'q5-wMmVzsGQ';

  @override
  String get dOFDys0lAJ0 => 'DOFDys0lAJ0';

  @override
  String get wadaICY1qo => 'WadaIC-Y1qo';

  @override
  String get label44PA4p4dXY => '44P-a4p4dXY';

  @override
  String get pLyX50Z72L2xbAikt1CHmEyvZrQv1XJu =>
      'PLyX_50Z72L2xbAikt1CHmEyvZrQv1X-ju';

  @override
  String get foreverYoung2 => '轻年 Ewig jung';

  @override
  String get omVSnG9O8g => 'omVSn-G9O8g';

  @override
  String get label2qKWcz2zU0 => '2qKWcz2z-u0';

  @override
  String get label1WMYcdS8oE => '1WMYcdS8o-E';

  @override
  String get u0fCO4W9LHg => 'U0fCO4W9LHg';

  @override
  String get m9xLRZlwO => 'M9xL-rZlw-o';

  @override
  String get vo5jCUWPNAo => 'Vo5jCUWPNAo';

  @override
  String get vb1N5r3zZFo => 'Vb1N5r3zZFo';

  @override
  String get lightOfDawn => '人之初 Licht der Morgenröte';

  @override
  String get teDx70IJcw => 'Te_dx70IJcw';

  @override
  String get mF2299T610 => 'mF2299T-610';

  @override
  String get yLNGIsWlU => 'YL_-NGIsWlU';

  @override
  String get mUZMDrFnNw => 'MUZMDrFn-Nw';

  @override
  String get pi2b8VYkM8 => 'Pi2b8VYk-m8';

  @override
  String get pLyX50Z72L2xDQ9d02geVDYSbkol6u9Z =>
      'PLyX_50Z72L2xDQ9d02geVDYSbkol-6u9Z';

  @override
  String get wWy3IO1E9cw => 'WWy3IO1E9cw';

  @override
  String get wW9DI00Rx3w => 'WW9DI00Rx3w';

  @override
  String get a6Y3wzD0I => 'A_6Y3wzD-0I';

  @override
  String get wXEkwsviSA => '-WXEkwsviSA';

  @override
  String get uq15J34lYB0 => 'Uq15J34lYB0';

  @override
  String get sc7Fg23kmUM => 'Sc7Fg23kmUM';

  @override
  String get kaJ2rw9Aqk => 'ka-j2rw9Aqk';

  @override
  String get uLnBQ3TFuc => 'ULnBQ3-TFuc';

  @override
  String get t2Iwb6RA1A => 'T2Iwb6-RA1A';

  @override
  String get mug6zYTLTlc => 'Mug6zYTLTlc';

  @override
  String get n2FDS8D8uu4 => 'N2FDS8D8uu4';

  @override
  String get s8lCa09LCr8 => 'S8lCa09LCr8';

  @override
  String get cU6u6WUM => 'C-u6u_6-WUM';

  @override
  String get oNNJqZYydM => 'ONN-JqZYydM';

  @override
  String get sniperButterfly => 'Sniper Butterfly';

  @override
  String get zExesh1IRe4 => 'ZExesh1IRe4';

  @override
  String get ygyiJvBu0 => 'ygyi-JvBu-0';

  @override
  String get label8lAlJTtlQw => '8lAlJ-ttlQw';

  @override
  String get oi4cSib0SMU => 'Oi4cSib0SMU';

  @override
  String get gBZIZ1syhRw => 'GBZIZ1syhRw';

  @override
  String get yOIsab02PVs => 'YOIsab02PVs';

  @override
  String get y3OhRM7dJg => 'Y3Oh_RM7dJg';

  @override
  String get bqvORbC4cY => 'BqvORbC4c-Y';

  @override
  String get iE8MjgoaPY => 'IE8Mjgoa-pY';

  @override
  String get sniperButterfly1204 =>
      '《狙击蝴蝶 Sniper Butterfly》ab 04.12.! Für die Liebe Grenzen überschreiten';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》Vollversion 1–15｜Hauptdarsteller: Chen Yanxi, Zhou Keyu Tencent Video - Jugendtheater';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》Vollversion 16–30｜Hauptdarsteller: Chen Yanxi, Zhou Keyu Tencent Video - Jugendtheater';

  @override
  String get imr0DFA4mNA => 'Imr0DFA4mNA';

  @override
  String get iVGn2RlvnG => 'IVGn2Rlvn_g';

  @override
  String get dIhValICo => 'dIh-Val_ICo';

  @override
  String get u3CEzhnlaM => 'U3C-EzhnlaM';

  @override
  String get bJ3HUIXyu04 => 'BJ3HUIXyu04';

  @override
  String get g9lIyw6LKr8 => 'G9lIyw6LKr8';

  @override
  String get xQhtl58Mg0 => 'x-qhtl58Mg0';

  @override
  String get emRj53N7q0 => 'emRj53N7q-0';

  @override
  String get g4LSe3sjJ1I => 'G4LSe3sjJ1I';

  @override
  String get label7PpYIVmyaU => '7PpYI-vmyaU';

  @override
  String get allRise => '即刻上场 All Rise';

  @override
  String get label9AaKDIWNK8 => '-9AaKDIWNK8';

  @override
  String get cIY8AALMGA => 'cIY8AAL-MGA';

  @override
  String get mwHNJlgj0M => '-MwHNJlgj0M';

  @override
  String get lM6Siyziyfg => 'LM6Siyziyfg';

  @override
  String get yUgNvqLkHo => 'Y-ugNvqLkHo';

  @override
  String get loveIsAlwaysOnline2 =>
      'Zur richtigen Zeit die richtige Person – Love is Always Online';

  @override
  String get bbu8Ct33WGY => 'Bbu8Ct33WGY';

  @override
  String get iW8gQdPQE => 'iW-8g-qdPQE';

  @override
  String get zKjqrbqqc74 => 'ZKjqrbqqc74';

  @override
  String get label1UbEkGEXNs => '1UbEkGE-xNs';

  @override
  String get w8eDA1UJ5OY => 'W8eDA1UJ5OY';

  @override
  String get hydT2kHzno => '-hydT2kHzno';

  @override
  String get fONOKBq7bLo => 'FONOKBq7bLo';

  @override
  String get s4zCx2IlFE => 's4zCx2Il-fE';

  @override
  String get bA13fouCls => 'BA_13fouCls';

  @override
  String get pLyX50Z72L2xw1E6HhmF968YkX7BlZ9 =>
      'PLyX_50Z72L2xw1-e6HhmF968YkX7Bl_Z9';

  @override
  String get loveOnTheTurquoiseLand => '枭起青壤 Liebe auf türkisem Land';

  @override
  String get we5ry5kxdHE => 'We5ry5kxdHE';

  @override
  String get emIUEma8Hg => 'EmIUEma-8Hg';

  @override
  String get wu6k5Xa3MM => 'Wu-6k5Xa3MM';

  @override
  String get label80SA571cW0 => '80-SA571cW0';

  @override
  String get label4PdR5JPhcY => '4Pd-R5JPhcY';

  @override
  String get fyB12Rr0V8 => 'fyB12-Rr0V8';

  @override
  String get ldKl7dOoRs => 'ld-Kl7dOoRs';

  @override
  String get label3xjBMrz6iC => '3xjBMrz6i-c';

  @override
  String get vt0403FhEU => 'Vt0403Fh-eU';

  @override
  String get eCcqo2QsOI => 'ECcqo2Qs-OI';

  @override
  String get syI7F7W2c8 => 'Sy-i7F7W2c8';

  @override
  String get vxTWyvL1Ms => 'VxTWyvL-1Ms';

  @override
  String get yw8QK3SuW => 'yw8QK-3Su-w';

  @override
  String get o16uHD0kTS => 'O16uHD0kT-s';

  @override
  String get nHx9DZl4Q => 'nHx9-D-Zl4Q';

  @override
  String get wMJrWKUN7w => '-WMJrWKUN7w';

  @override
  String get s9JU0L2RS4o => 'S9JU0L2RS4o';

  @override
  String get uJC6xna2PBM => 'UJC6xna2PBM';

  @override
  String get rbvdnADd18 => 'Rbvdn-ADd18';

  @override
  String get iHHlxN0Swo => 'i-HHlxN0Swo';

  @override
  String get zd8EBbfqs => 'Zd8_-EBbfqs';

  @override
  String get xUG53k1B4 => 'XUG_53k1-b4';

  @override
  String get whyIsHeStillSingle2 =>
      '《他为什么依然单身 Why Is He Still Single》 Ab 16.11.! Wallace Huo und Zhu Zhu in einem Liebesmärchen für Erwachsene!';

  @override
  String get whyIsHeStillSingle3 =>
      '《他为什么依然单身 Why Is He Still Single》 Vollversion｜Hauptdarsteller: Wallace Huo, Zhu Zhu | Tencent Video - Jugendtheater';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《他为什么依然单身 Why Is He Still Single》 Vollversion 1｜Hauptdarsteller: Wallace Huo, Zhu Zhu | Tencent Video - Jugendtheater';

  @override
  String get whyIsHeStillSingle5 =>
      '《他为什么依然单身 Why Is He Still Single》 Vollversion 2｜Hauptdarsteller: Wallace Huo, Zhu Zhu | Tencent Video - Jugendtheater';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => 'Shanhe Zhen: Fight for Love';

  @override
  String get lGP6TCHM => 'l_g-p6TC_hM';

  @override
  String get wXKMI7kmY3Y => 'WXKMI7kmY3Y';

  @override
  String get v0wqy1HUJJE => 'V0wqy1HUJJE';

  @override
  String get j24dJWDtyps => 'J24dJWDtyps';

  @override
  String get v937gFLg7QU => 'V937gFLg7QU';

  @override
  String get x4R4W9wwzY => 'x4R-4W9wwzY';

  @override
  String get jV9KYnyvsg => 'jV9-kYnyvsg';

  @override
  String get hQPFMP7zQO0 => 'HQPFMP7zQO0';

  @override
  String get pLyX50Z72L2wHtPGkazV4LCGl20kRY4 =>
      'PLyX_50Z72L2w_HtPGkazV4-lCGl20kRY4';

  @override
  String get iMNobody => 'Ich bin niemand  I\'m Nobody';

  @override
  String get persona => '重影 Persona';

  @override
  String get d5CPVc0EIY => 'D5CPVc0E-IY';

  @override
  String get pJsHXm9ZsC => 'pJsHXm9Zs-c';

  @override
  String get vYRvNE7Yk => '-VYRvNE-7Yk';

  @override
  String get lightBeyondTheReed => '余生有涯 Light Beyond the Reed';

  @override
  String get kqfhRrmmG => 'Kqfh_Rrmm_g';

  @override
  String get iKEYUsv14 => 'I-kE-YUsv14';

  @override
  String get hOC9mu9HVs => 'HOC9mu_9HVs';

  @override
  String get x8jqt87WIuo => 'X8jqt87WIuo';

  @override
  String get gb0Bk564EQ => 'gb0Bk564-EQ';

  @override
  String get thePrisonerOfBeauty => 'The Prisoner of Beauty (Gekürzte Version)';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '„The Prisoner of Beauty“: Xiao Qiao heiratet den Erzfeind statt ihrer Schwester und gerät am ersten Hochzeitstag mit ihrem Mann aneinander | Darsteller: Song Zuer, Liu Yuning';

  @override
  String get thePrisonerOfBeauty3 =>
      '《The Prisoner of Beauty (Kompaktversion)》: Xiao Qiao vereitelt Liu Yans Komplott und Wei Shao und sie verwandeln Feindschaft in gegenseitigen Schutz | Hauptrollen: Song祖儿, Liu Yuning - Tencent Video Youth Theater';

  @override
  String get thePrisonerOfBeauty4 =>
      '《The Prisoner of Beauty (Kompaktversion)》: Xiao Qiao stellt sich krank, und Wei Shao beschützt seine Frau öffentlich und lehnt Konkubinen ab | Hauptrollen: Song Zu\'er, Liu Yuning - Tencent Video Youth Theater';

  @override
  String get thePrisonerOfBeauty5 =>
      '《The Prisoner of Beauty (Kompaktversion)》: Xiao Qiao durchschaut das Komplott mit der Holzkiste, und Wei Shao erkennt sie als seine Herrin an | Hauptrollen: Song Zu\'er, Liu Yuning - Tencent Video Youth Theater';

  @override
  String get thePrisonerOfBeauty6 =>
      '《The Prisoner of Beauty (Kompaktversion)》: Xiao Qiao löst das Komplott geschickt, Wei Shao erkennt und beschützt seine Frau und die Schwiegermutter mischt sich ein | Hauptrollen: Song Zu\'er, Liu Yuning - Tencent Video';

  @override
  String get thePrisonerOfBeauty7 =>
      '《The Prisoner of Beauty (Kompaktversion)》: Wei Yan stiftet Unruhe mit einem gefälschten Brief, und Xiao Qiao und Wei Shao geraten wegen eines Jad Anhängers in eine Vertrauenskrise | Hauptrollen: Song Zu\'er, Liu Yuning - Tencent Video';

  @override
  String get thePrisonerOfBeauty8 =>
      '《The Prisoner of Beauty (Kompaktversion)》: Su Ehuang legt Xiao Qiao mit reifem Weizen rein, Wei Shao beschützt seine Frau, klärt den Fall und beide kommen sich näher | Hauptrollen: Song Zu\'er, Liu Yuning - Tencent Video';

  @override
  String get thePrisonerOfBeauty9 =>
      '《The Prisoner of Beauty (Kompaktversion)》: Xiao Qiao und Wei Shao werden vergiftet, Xiao Qiao vereitelt das Komplott, rettet ihren Mann und sie kommen sich näher | Hauptrollen: Song Zu\'er, Liu Yuning - Tencent Video';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '„The Prisoner of Beauty“: Wei Shao schenkt Kriegspferde, schickt Haarnadel nach, gerät in Panik beim Schutz seiner Frau | Darsteller: Song Zuer, Liu Yuning';

  @override
  String get thePrisonerOfBeauty11 =>
      '„The Prisoner of Beauty“: Wei Shao hat Angst, dass Xiao Qiao wegläuft, ist eifersüchtig und bereut es, sie zu vermissen | Darsteller: Song Zuer, Liu Yuning';

  @override
  String get thePrisonerOfBeauty12 =>
      '„The Prisoner of Beauty“: Wei Shao trägt Xiao Qiao huckepack aus Eifersucht, das Rätsel um die Holzbox klärt sich und sie kommen sich näher | Darsteller: Song Zuer, Liu Yuning';

  @override
  String get thePrisonerOfBeauty13 =>
      '„The Prisoner of Beauty“: Qiao Cis Besuch bei seiner Schwester weckt Wei Shaos Eifersucht, das Paar öffnet sich füreinander | Darsteller: Song Zuer, Liu Yuning';

  @override
  String get thePrisonerOfBeauty14 =>
      '《The Prisoner of Beauty (Kompaktversion)》Wei Yan verlässt für Xiao Qiao die Heimat, Shao und Qiao versöhnen sich nach einem Streit | Hauptdarsteller: Song Zuer, Liu Yuning – Tencent Video Jugend-Theater';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《The Prisoner of Beauty (Kompaktversion)》Meuterei in der Hochzeitsnacht entzweit Schwestern; Xiao Qiao schlägt den Feind klug zurück, Wei Shao gesteht Fehler ein | Hauptdarsteller: Song Zuer, Liu Yuning – Tencent Video Jugend-Theater';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《The Prisoner of Beauty (Kompaktversion)》Wei Shao begleitet Xiao Qiao nach Kangjun; Vater Qiao akzeptiert den Schwiegersohn, das Paar vollzieht die Ehe | Hauptdarsteller: Song Zuer, Liu Yuning – Tencent Video Jugend-Theater';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《The Prisoner of Beauty (Kompaktversion)》Qiao Yue begeht Verrat, Wei Liang stirbt; Da Qiao wird entführt, Bi Zhi kämpft verzweifelt zurück | Hauptdarsteller: Song Zuer, Liu Yuning – Tencent Video Jugend-Theater';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《The Prisoner of Beauty (Kompaktversion)》Wei Liang fällt im Kampf, Wei Qu verliert einen Arm; Da Qiao stürzt ab, Liu Yan geht unter | Hauptdarsteller: Song Zuer, Liu Yuning – Tencent Video Jugend-Theater';

  @override
  String get pLyX50Z72L2zD8aIumtBOoc0OWrwUUSe =>
      'PLyX_50Z72L2zD-8aIumtBOoc0OWrwUUSe';

  @override
  String get ahjr3KPEXv4 => 'Ahjr3KPEXv4';

  @override
  String get igijfp2Q8BY => 'Igijfp2Q8BY';

  @override
  String get kIy3O9LyJQ => 'kIy3-o9LyJQ';

  @override
  String get g40pz8IOI => 'G-40pz8I_oI';

  @override
  String get label4LTdKzOI54 => '4LTdKzO-I54';

  @override
  String get pPT =>
      'Zu langsam bei der Gruppenarbeit? Der Boss klettert nachts durchs Fenster mit der Präsentation, der Sicherheitsdienst jagt ihn | Tencent Video Jugend-Theater';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour => 'A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video – Kostümdrama – Hol dir die WeTV-App';

  @override
  String get jnz1S8Qb5xE => 'Jnz1S8Qb5xE';

  @override
  String get nf5tvYU1W5A => 'Nf5tvYU1W5A';

  @override
  String get jRzsIK84C0 => 'jRzsIK84C-0';

  @override
  String get label9TcXQyaUAC => '9TcXQyaUA-c';

  @override
  String get mG6d7wN6fg => 'M-g6d7wN6fg';

  @override
  String get theInescapable => 'The Inescapable';

  @override
  String get label2TF7nb09WM => '2TF7nb09W-M';

  @override
  String get xG7qBdDRn0 => '-XG7qBdDRn0';

  @override
  String get zeFO2XDbA4 => 'zeFO2XDb-A4';

  @override
  String get pLs3DOuT3JlGR2nMcuGW2139rVVeHcWIs =>
      'PLs3DOuT3JlGR2nMcuGW2139rV-veHcWIs';

  @override
  String get pursuitOfJade2 => '逐玉 Pursuit of Jade';

  @override
  String get tBj7OHjb2tI => 'TBj7OHjb2tI';

  @override
  String get vWOECNVUlQ => 'VWOE-cNVUlQ';

  @override
  String get label5NKgOE5DPQ => '5NKgOE5D-pQ';

  @override
  String get ipim7l2LZg => 'ipim7l2L-Zg';

  @override
  String get vmuf05J8Vc => '-Vmuf05J8Vc';

  @override
  String get label2M3Ls74gZY => '2M3Ls74gZ-Y';

  @override
  String get p8DW4Gef70o => 'P8DW4Gef70o';

  @override
  String get d4duxTP0FDE => 'D4duxTP0FDE';

  @override
  String get b1T03rs9WGI => 'B1T03rs9WGI';

  @override
  String get ruBRX68XPg => 'Ru-BRX68XPg';

  @override
  String get aX5eShfmFk => 'AX5eShfm_fk';

  @override
  String get fCsjHXbBlE => 'f-CsjHXbBlE';

  @override
  String get m9xKlm95oc => 'M9xKlm-95oc';

  @override
  String get xh0z4YV9v2s => 'Xh0z4YV9v2s';

  @override
  String get iufzj2MLPs => 'iufzj2M-LPs';

  @override
  String get x6uXEQgWuM => '-X6uXEQgWuM';

  @override
  String get wlz3IhZptM => 'Wlz3Ih-ZptM';

  @override
  String get p10GCq30oNI => 'P10GCq30oNI';

  @override
  String get b65UYuRtpE => 'B65-uYuRtpE';

  @override
  String get generationToGeneration222 =>
      '《江湖夜雨十年灯 Generation to Generation》Startet am 22. Februar! Erlebe, wie Mumu und Zhaozhao, die stärkste neue Generation, gemeinsam das Jianghu erobern!';

  @override
  String get label6yOPycBAyU => '6y-oPycBAyU';

  @override
  String get lIAUBGNQM => 'LI-AUBGN-QM';

  @override
  String get sU12uaTtBg => 'SU-12uaTtBg';

  @override
  String get label05nLbIKPkQ => '05nLb-iKPkQ';

  @override
  String get rKGFPIzgpO => 'rKGFPIzgp-o';

  @override
  String get shO2wXA6U => 'Sh-o2w-xA6U';

  @override
  String get dNsDNXcJgM => 'd-nsDNXcJgM';

  @override
  String get w0NMLE9Hw => 'W_0N-mLE9Hw';

  @override
  String get lTtwLNkDHY => 'LTtwLNkD-HY';

  @override
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 Die 300 treuen Geister';

  @override
  String get zj1Mh0bRE => 'zj1Mh_0b-rE';

  @override
  String get kj6122rOzW => 'kj6122rOz-w';

  @override
  String get ftgF1Hu9Ko => 'Ftg-f1Hu9Ko';

  @override
  String get cnFIQ9QT4M => '-CnFIQ9QT4M';

  @override
  String get ajdFKQ4uq8 => 'AjdF-kQ4uq8';

  @override
  String get danceOfThePhoenix => '且听凤鸣 Tanz des Phönix';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Außergewöhnlich';

  @override
  String get mIOS6JeeMU => 'mIOS6Jee-mU';

  @override
  String get d8CsUqEy4 => 'd8CsUq-ey_4';

  @override
  String get oZpINX3A => '-o_zpI-NX3A';

  @override
  String get hyKy6aEDmo => 'HyKy6aE-Dmo';

  @override
  String get nkAYc4ZSW8 => 'NkAYc4Z-sW8';

  @override
  String get ovTXZjh2M => 'ov-T_XZjh2M';

  @override
  String get label2TheImperialCoronerS22 =>
      '《御赐小仵作2 The Imperial Coroner S2》Start am 15.01., das Ehepaar Chu Yu kehrt herzerwärmend zurück!';

  @override
  String get kvFDYYmg => 'KvF__d-YYmg';

  @override
  String get llaTO7muek => 'llaT-O7muek';

  @override
  String get label3r4Qw60AhM => '3r4Qw60Ah-M';

  @override
  String get nwb6rTXjAs => 'Nwb6rTXj-As';

  @override
  String get label87A7F8yq94 => '87A7F-8yq94';

  @override
  String get yJPJ6RWgyg => 'yJP-j6RWgyg';

  @override
  String get rebirthForYou => '嘉南传 Rebirth For You';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => '恋恋风陵渡 A Vow in the Dark';

  @override
  String get theUltimateVowUnknownTo => 'The Ultimate Vow, Unknown to You';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => 'Die Jugend von Chang\'An The Chang\'An Youth';

  @override
  String get jg0aX6eEK4 => 'Jg0aX6e_EK4';

  @override
  String get adbjo5emA => 'Adbjo5em__A';

  @override
  String get label2QO1c7aWBE => '2QO1c7aW-bE';

  @override
  String get x75eul0gjYM => 'X75eul0gjYM';

  @override
  String get dN6c2uB2cF4 => 'DN6c2uB2cF4';

  @override
  String get label1xqkI5jRsc => '1xqkI5j-rsc';

  @override
  String get jRRXVJblrk => 'JRR-XVJblrk';

  @override
  String get thePrincessDecree2 => 'The Princess Decree';

  @override
  String get ppiNYsUwOA => 'PpiNYs-uwOA';

  @override
  String get label83tIjIiqM => '-_83tIjIiqM';

  @override
  String get p4cKjzSHFw => 'P4cKjz-sHFw';

  @override
  String get babysitter => '我在冷宫做月嫂 Babysitter';

  @override
  String get label0MjfIXHKOM => '0MjfIXHKO-M';

  @override
  String get zEOhv9GVlao => 'ZEOhv9GVlao';

  @override
  String get pLs3DOuT3JlGRa8QmAVS9qfbbZS7afa0x =>
      'PLs3DOuT3JlGRa8Qm-AVS9qfbbZS7afa0x';

  @override
  String get xUjdpB74DU => 'XUjdp_B74DU';

  @override
  String get ddcGbI27AE => 'DdcGbI-27AE';

  @override
  String get herPhoenixMajesty2 => 'Her Phoenix Majesty 2';

  @override
  String get pzXvIZTfw => 'Pz_xvIZ-Tfw';

  @override
  String get lXojyPTBzS => 'lXojyPTBz-s';

  @override
  String get pLs3DOuT3JlGQtL9S4u2QaRJty8BDrUk6 =>
      'PLs3DOuT3JlGQtL9S4u2QaRJty8BDrUk6-';

  @override
  String get ntuwtDMChw => 'ntuwtD-MChw';

  @override
  String get bGXUzqodupo => 'BGXUzqodupo';

  @override
  String get plePvm344k => 'plePvm-344k';

  @override
  String get f0OIk6BUbo => 'F0OIk6-BUbo';

  @override
  String get kZZnmxJGHw => 'KZZnmx_jGHw';

  @override
  String get eIuk7EPq2hg => 'EIuk7EPq2hg';

  @override
  String get label2H0pqyiPdk => '2H0pqyi-Pdk';

  @override
  String get j6Xs9w4Elw => 'J6_Xs9w4Elw';

  @override
  String get xMtNosSw0 => 'X_-mtNosSw0';

  @override
  String get bienjpo0UFM => 'Bienjpo0UFM';

  @override
  String get oJOso5tVBek => 'OJOso5tVBek';

  @override
  String get eRxWzG9p7U => 'eRxWzG9p7-U';

  @override
  String get iusgk4UlU => 'iusgk-4Ul-U';

  @override
  String get pUV3TRgebig => 'PUV3TRgebig';

  @override
  String get lr4EpeONCw => 'Lr4Epe-oNCw';

  @override
  String get o3jzt2IlGU => 'o3jzt2IlG-U';

  @override
  String get kKJPm6qb54A => 'KKJPm6qb54A';

  @override
  String get qlWNAIqlvw => 'Ql_WNAIqlvw';

  @override
  String get label0miWUBl3ZA => '0miWUBl3-zA';

  @override
  String get jQMZbtl7b2w => 'JQMZbtl7b2w';

  @override
  String get qAw54adzTQ => 'QAw5_4adzTQ';

  @override
  String get eSL64O0EfI => 'eSL-64O0EfI';

  @override
  String get eYC4j7ky8pg => 'EYC4j7ky8pg';

  @override
  String get hGDl1nDeqE => 'h-gDl1nDeqE';

  @override
  String get oAHE5vyYQg => '-oAHE5vyYQg';

  @override
  String get gbFQy8CqEo => 'GbFQy8Cq-Eo';

  @override
  String get izi1KFUxPk => 'Izi1KFUx-Pk';

  @override
  String get i3qxA2cr8kA => 'I3qxA2cr8kA';

  @override
  String get oFI5pek3lvY => 'OFI5pek3lvY';

  @override
  String get obuu6ZaIA8 => 'obuu6ZaIA-8';

  @override
  String get xIf4aL45npQ => 'XIf4aL45npQ';

  @override
  String get aGirlLikeMe2 => '我就是这般女子 A Girl Like Me';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 => '飞狐外传 Side Story of Fox Volant';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 => '有花在洲 A Flower On The Continent';

  @override
  String get aFlowerOnTheContinent3 =>
      '【有花在洲 A Flower On The Continent】 Ein junger Prinz als Geisel wird von einem Blumenmädchen fälschlicherweise als Prinzessin behandelt, und sie müssen zusammenleben';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】 Die Verkleidung des Blumenmädchens fliegt auf, und der junge Prinz riskiert sein Leben, um sie zu schützen, wird aber fälschlicherweise beschuldigt';

  @override
  String get aFlowerOnTheContinent5 =>
      '【有花在洲 A Flower On The Continent】 Hua Xiyu erfährt, dass Ning Xuanzhous Vater ihren Vater getötet hat, und bricht sofort mit ihm';

  @override
  String get aFlowerOnTheContinent6 =>
      '【有花在洲 A Flower On The Continent】 Hua Xiyu stürmt im Hochzeitskleid das Feindeslager und rettet Ning Xuanzhou knapp unter Einsatz ihres Lebens';

  @override
  String get aFlowerOnTheContinent7 =>
      '【有花在洲 A Flower On The Continent】 Als die zwei Reiche Frieden schließen, zerreißt Ning Xuanzhou das Dekret, um Hua Xiyu zu heiraten';

  @override
  String get aFlowerOnTheContinent8 =>
      '【有花在洲 A Flower On The Continent】 Hua Xiyu opfert ihr Blut für Medizin; Ning Xuanzhou klagt seinen Vater wegen des Mordes an ihrem Vater an';

  @override
  String get aFlowerOnTheContinent9 =>
      '【有花在洲 A Flower On The Continent】 Hua Xiyu erfährt die Wahrheit und trennt im Blumenmeer das Zweiglein ihrer Liebe entzwei';

  @override
  String get pLs3DOuT3JlGS2bplCB41Z0150Kb9oQdn =>
      'PLs3DOuT3JlGS2bplCB41Z0150-Kb9oQdn';

  @override
  String get t1D3w33qTG8 => 'T1D3w33qTG8';

  @override
  String get fLoEBicAD0 => 'fLoEBicA-D0';

  @override
  String get pLs3DOuT3JlGTeaxmA97G31cUKERfzNgN =>
      'PLs3DOuT3JlGTeaxmA97G31cUK-eRfzNgN';

  @override
  String get d3UOh8aqKE => 'D3UOh_8aqKE';

  @override
  String get hcEA13KgnE => 'hcEA13Kgn-E';

  @override
  String get pbC7hP30zU => 'PbC7h-P30zU';

  @override
  String get hilariousFamily22 => 'Hilarious Family 2';

  @override
  String get sliceOfLife => 'Slice of Life';

  @override
  String get p6Og4b7SEiw => 'P6Og4b7SEiw';

  @override
  String get label6TOkoVJcus => '6-tOkoVJcus';

  @override
  String get xKUz23x2pOo => 'XKUz23x2pOo';

  @override
  String get fTuSIxeFUY => 'FTuSIxe-fUY';

  @override
  String get kdow9dKN0 => '_Kdow9dKN-0';

  @override
  String get y4eB2fuCNs => 'Y4e_b2fuCNs';

  @override
  String get sVClNTSRcQ => 'SV-clNTSRcQ';

  @override
  String get xQtiANGe8 => 'x-qtiA-NGe8';

  @override
  String get obESRYh3NU => 'obESRYh3-NU';

  @override
  String get pLs3DOuT3JlGShdDzo52tfDOSU1UkUcHX =>
      'PLs3DOuT3JlGShdDzo52tfDOSU1UkUc-hX';

  @override
  String get legendOfTheFemaleGeneral => '锦月如歌 Legend of The Female General';

  @override
  String get highlightLegendOfTheFemale =>
      'Highlights 【Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'BTS: Zhou Yes Geburtstags-Special 🎂! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'BTS: Cheng Leis Geburtstags-Special 🎂! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'BTS: Cooles Duo-Kampftraining auf dem Schlachtfeld 【Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'BTS: Süßer 520-Date-Plan 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'BTS: Betrunkene Zhou Ye tanzt mit Schwert & Cheng Lei schmunzelt 【Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'Highlights 【The Princess\'s Gambit】';

  @override
  String get qJRbuw2hJ3s => 'QJRbuw2hJ3s';

  @override
  String get cGtKgr7X4o => 'cGt-Kgr7X4o';

  @override
  String get iZe4HBUZQ => 'IZe4_HBU_ZQ';

  @override
  String get zGgyp0sbyDM => 'ZGgyp0sbyDM';

  @override
  String get label2BI4oU8Rwo => '2BI4o-u8Rwo';

  @override
  String get zNZAQZZQ => '-ZN-zAQZZ-Q';

  @override
  String get uma3ppi4wiM => 'Uma3ppi4wiM';

  @override
  String get clipThePrincessSGambit =>
      'Ausschnitt: Im roten Kleid durch den Schnee – Jiang Taohuas Abschied 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'Ausschnitt: Intrigen am Hochzeitstag im Shen-Anwesen 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'Ausschnitt: Taohuas vorgetäuschte Ohnmacht wird enttarnt 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'Ausschnitt: Kanzler Shen greift hart gegen Korruption durch 【The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Ausschnitt: Maskierter Attentäter kann Detektivin Taohua nicht täuschen 【The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'Ausschnitt: Verhör mit der Haarnadel – Shen Zaiye stellt Taohua 【The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Clip: Das erste Treffen und gleich so mutig! Shen Zaiye ist vom Huanhuan-Gift betroffen, Blicke kreuzen sich 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get pLIPiKkSFpK8B6r2izKyYYiYdbkYSBbd =>
      'PLIPiKkS-FpK8B6r2izKyY-yiYdbkYSBbd';

  @override
  String get reqdatIdS => 'Reqdat_id-s';

  @override
  String get label72zyHSuRDM => '72zyHSuR-dM';

  @override
  String get zQDc6PfC0 => 'z-q_Dc6PfC0';

  @override
  String get hfcLvnUQqA => '-hfcLvnUQqA';

  @override
  String get y5CHMfB8dw => 'Y5C-HMfB8dw';

  @override
  String get p28HP1H4Vc => 'P28HP_1H4Vc';

  @override
  String get yBclY6CaTw => 'yBclY6-caTw';

  @override
  String get bGIAtDEdlk => 'B-gIAtDEdlk';

  @override
  String get mWKB6zDZwc => 'mWKB6zD-zwc';

  @override
  String get q8N3LJ0A9Bk => 'Q8N3LJ0A9Bk';

  @override
  String get yR6T2qwwRJ0 => 'YR6T2qwwRJ0';

  @override
  String get oOgqhGuLE => '-o_ogqhGuLE';

  @override
  String get sk2MR0LGf0E => 'Sk2MR0LGf0E';

  @override
  String get rodBx023QQ => 'rodBx023-qQ';

  @override
  String get zPVcOAzByY => 'z-pVcOAzByY';

  @override
  String get nWM1Ceq5oyE => 'NWM1Ceq5oyE';

  @override
  String get pLIPiKkSFpKIRCE5jKV6WuMHd3ba79JP =>
      'PLIPiKkS-FpK_IRCE5jKV6WuMHd3ba79JP';

  @override
  String get label7yLGOh2ABg => '7y-lGOh2ABg';

  @override
  String get yr5pUONS3c => '-Yr5pUONS3c';

  @override
  String get svE0DPJGYA => 'SvE0DPJ-gYA';

  @override
  String get i709WD0cVs => 'I_709WD0cVs';

  @override
  String get mgWNgw9MQ => 'MgWNgw_9-MQ';

  @override
  String get xs2k2nlJYYc => 'Xs2k2nlJYYc';

  @override
  String get fdXXdYB6Vo => 'FdXXd-YB6Vo';

  @override
  String get pKG6QKF6Og => 'p-KG6QKF6Og';

  @override
  String get limitedFULLTheIngeniousOne =>
      '【Limitierte Vollversion】云襄传 | The Ingenious One | iQIYI 👑Jetzt Mitglied werden und alle Folgen genießen!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 – Hol dir die iQIYI-App';

  @override
  String get aky3021PW => '_Aky3021P-w';

  @override
  String get hMaBvO3nkM => 'hMaBv-O3nkM';

  @override
  String get r2YEAXZFxp4 => 'R2YEAXZFxp4';

  @override
  String get iTLYG63GDc => 'ITLYG-63GDc';

  @override
  String get label1TyTz8z1vK => '1TyTz8z1v-k';

  @override
  String get jIq5a7yEd8c => 'JIq5a7yEd8c';

  @override
  String get tDMpSBCf5k => 'tDMp-sBCf5k';

  @override
  String get iPWSYbG6s4 => 'IPW-sYbG6s4';

  @override
  String get label6GjFP04aw => '6Gj-FP-04aw';

  @override
  String get pL6xVgUZ4UP2Ps7N0b2CUMkQ49aAX3xlw =>
      'PL6xVgUZ4UP2Ps7N0b2-cUMkQ49aAX3xlw';

  @override
  String get f8ilmFb30 => 'f8ilm_Fb-30';

  @override
  String get dQt4Zorb4gE => 'DQt4Zorb4gE';

  @override
  String get t9XDOuWLc => 't9XD-OuW-Lc';

  @override
  String get vcEgRd08 => '-vc_egRd_08';

  @override
  String get b0b1dFL9Nc => 'B0b1dF-l9Nc';

  @override
  String get pLIPiKkSFpK8VhfSNo7Vsx4lCMTKbcOm =>
      'PLIPiKkS-FpK8_VhfSNo7Vsx4lCMTKbcOm';

  @override
  String get aMeUFNq1m8 => 'AMe-uFNq1m8';

  @override
  String get dJUpKoPRtg => 'DJ-UpKoPRtg';

  @override
  String get oQMLDVlb7g => 'OQML_DVlb7g';

  @override
  String get aUeypfRL24 => 'aUeypfRL-24';

  @override
  String get uB9ycPhk1mg => 'UB9ycPhk1mg';

  @override
  String get pLIPiKkSFpK8Pesmyu9gzK2jXpplqUn9d =>
      'PLIPiKkS-FpK8Pesmyu9gzK2jXpplqUn9d';

  @override
  String get i5TQ4zJDUs => 'I5TQ4z_jDUs';

  @override
  String get goft2N911yE => 'Goft2N911yE';

  @override
  String get sraEP5hG98 => 'sraEP5hG-98';

  @override
  String get axhDRyKII => '_AxhDRy-kII';

  @override
  String get j1z4azTG40 => 'J-1z4azTG40';

  @override
  String get m87V7kOvg => '-m_87V7kOvg';

  @override
  String get g2ASv4fOuc => 'G2-aSv4fOuc';

  @override
  String get tONKwUFYQ => '-TONKwU_FYQ';

  @override
  String get mw7OlvkWDg => '-Mw7OlvkWDg';

  @override
  String get pLIPiKkSFpK8KCCeSQTpodI0VqMejybr9 =>
      'PLIPiKkS-FpK8KCCeSQTpodI0VqMejybr9';

  @override
  String get label4GJqLnsV6c => '4G-jqLnsV6c';

  @override
  String get b36gveSPqI => 'B36gveS-pqI';

  @override
  String get da6GLS11sDg => 'Da6GLS11sDg';

  @override
  String get r7Jzgv6XuM => '-r7Jzgv6XuM';

  @override
  String get fULLROADHOMEBoranJingSeven =>
      '【FULL】👮ROAD HOME💕 | BoranJing, Seven Tan | iQIYI Philippines';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI Philippines – Hol dir die iQIYI-App';

  @override
  String get lKuff6Nfwp8 => 'LKuff6Nfwp8';

  @override
  String get n3oPG8EusI => 'N3oPG8Eus-I';

  @override
  String get jEq6lPG1rus => 'JEq6lPG1rus';

  @override
  String get uwhhmc98HX8 => 'Uwhhmc98HX8';

  @override
  String get k3KVVNRjgw => 'K3KVV-NRjgw';

  @override
  String get aIEnglishDubMrBAD =>
      '【KI-Englisch-Synchro】Mr. BAD | Chen Zheyuan, Yue Shen | iQIYI Philippinen';

  @override
  String get h7d38oiW4 => '-h7d38oi_w4';

  @override
  String get tIjEEDlLPY => '-TIjEEDlLPY';

  @override
  String get label6P746xQE1E => '6P746xQE1-E';

  @override
  String get wJo20fh1ovU => 'WJo20fh1ovU';

  @override
  String get aUci4B6qoIY => 'AUci4B6qoIY';

  @override
  String get loveOfTheDivineTree2 =>
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | FULL正片 | iQIYI 👑Jetzt Mitglied werden und alle Folgen genießen!';

  @override
  String get uFSyFzIASM => 'UFSyFzIA-sM';

  @override
  String get c8THRSSU6M => 'c8-tHRSSU6M';

  @override
  String get cxx0rl8JJnc => 'Cxx0rl8JJnc';

  @override
  String get o5Mn9URF3uE => 'O5Mn9URF3uE';

  @override
  String get eE1jl4dzrg8 => 'EE1jl4dzrg8';

  @override
  String get label6GeLMiukHC => '6GeLMiukH-c';

  @override
  String get eAhVaQ2RA => 'e_ahVaQ2-rA';

  @override
  String get h9VQfSPUzs => 'H9VQfS-pUzs';

  @override
  String get pLIPiKkSFpKUBrffjChZ310g2OtsQfLf =>
      'PLIPiKkS-FpK-uBrffjChZ310g2OtsQfLf';

  @override
  String get k8DtfAAU4U => 'K8-DtfAAU4U';

  @override
  String get pLIPiKkSFpK9TcBapXhwwF9nCt2DZu9k =>
      'PLIPiKkS-FpK9-TcBapXhwwF9nCt2DZu9k';

  @override
  String get vP12XNOv5eM => 'VP12XNOv5eM';

  @override
  String get yTp22S1oA5Q => 'YTp22S1oA5Q';

  @override
  String get rxgy49XHTbs => 'Rxgy49XHTbs';

  @override
  String get hHw9RaWByc => 'hHw9-RaWByc';

  @override
  String get wwoz6JPu2Yg => 'Wwoz6JPu2Yg';

  @override
  String get lW32xQCoqs => 'LW32x_QCoqs';

  @override
  String get gb414C2O3w => 'Gb414C2_O3w';

  @override
  String get k7iTvKzZyQ => 'K7iTv-KzZyQ';

  @override
  String get npbhgWJePE => 'npbhgWJe-PE';

  @override
  String get knWpROE9xU => 'kn-WpROE9xU';

  @override
  String get eT8okyktVok => 'ET8okyktVok';

  @override
  String get pLIPiKkSFpK8Q5DyWQXPpAdGsyH8BPUYA =>
      'PLIPiKkS-FpK8Q5DyWQXPpAdGsyH8BPUYA';

  @override
  String get rD40VQSYnjo => 'RD40VQSYnjo';

  @override
  String get bmdZBo8HoE => 'BmdZ-Bo8HoE';

  @override
  String get pLIPiKkSFpK9MiE3quPZjNnu7RgviYDy =>
      'PLIPiKkS-FpK9MiE3quPZjNnu7-RgviYDy';

  @override
  String get fYFcg3qNJE => 'fYFcg3qN-jE';

  @override
  String get uWRVG89Kn8M => 'UWRVG89Kn8M';

  @override
  String get iBUh0B2XAMQ => 'IBUh0B2XAMQ';

  @override
  String get wQlTnSp5s => 'W-ql-tnSp5s';

  @override
  String get edAqyr6ieU => '-EdAqyr6ieU';

  @override
  String get pLIPiKkSFpK8wb8Yzzh4eptkOEn2LPtDf =>
      'PLIPiKkS-FpK8wb8Yzzh4eptkOEn2LPtDf';

  @override
  String get label93ckJe0R6c => '-93ckJe0R6c';

  @override
  String get vzb1BHRshM => 'Vzb1B-hRshM';

  @override
  String get yC69yjVyOo => 'y-C69yjVyOo';

  @override
  String get pLIPiKkSFpK8MdPQg72ceDNUGjf0mhENz =>
      'PLIPiKkS-FpK8MdPQg72ceDNUGjf0mhENz';

  @override
  String get iEC4DBbzBI => 'iEC4DBbzB-I';

  @override
  String get yf7VWSAbOU => 'yf7VW-sAbOU';

  @override
  String get sF0QfbuHtQ => 'S-F0QfbuHtQ';

  @override
  String get yPcsflr52s => 'yPcsflr-52s';

  @override
  String get md04meyJlA => 'md0-4meyJlA';

  @override
  String get iof4jeN6LG4 => 'Iof4jeN6LG4';

  @override
  String get label8FjmZttLM => '-8_fjmZttLM';

  @override
  String get cCnli0HQ3IE => 'CCnli0HQ3IE';

  @override
  String get label8EXPB74Dyc => '8-EXPB74Dyc';

  @override
  String get fULLMyDearGuardianJohnny =>
      '【VOLLSTÄNDIG】🕊️My Dear Guardian |  Johnny Huang, Li Qin | iQIYI Philippines';

  @override
  String get fN0lxPL4Qa0 => 'FN0lxPL4Qa0';

  @override
  String get bjlqxe76Cc => 'bjlqxe76-cc';

  @override
  String get pLIPiKkSFpKHKjDQgjOj98MaZq0gm =>
      'PLIPiKkS-FpK-_h-KjD_qgjOj98MaZq0gm';

  @override
  String get tcWqflGCUY => 'TcWqflG-CUY';

  @override
  String get rZfxh4rSg => '--rZfxh4rSg';

  @override
  String get label1ORyfeHBGG => '1ORyfeHBG-g';

  @override
  String get pLIPiKkSFpK9cwfQqamjvymbElQlrV6do =>
      'PLIPiKkS-FpK9cwfQqamjvymbElQlrV6do';

  @override
  String get vKvu1urDSps => 'VKvu1urDSps';

  @override
  String get dB2fAHAIw30 => 'DB2fAHAIw30';

  @override
  String get pLlCrV9TCfzMYJebfwvzDDQzDFbY9XqvE =>
      'PLlCrV9TCfzMYJebfwvzDDQzDFbY-9XqvE';

  @override
  String get theBestThingZhangLinghe =>
      '🌸【治愈爱情】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | VOLLSTÄNDIG正片 | iQIYI 👑Werde Mitglied und genieße jetzt alle Folgen!';

  @override
  String get h22R4lYT0QQ => 'H22R4lYT0QQ';

  @override
  String get a4CMqC9Hg => 'A-4C-mqC9Hg';

  @override
  String get jJvSIEUsWY => 'jJvSI-EUsWY';

  @override
  String get label94M1y8ivG => '94M1y8iv--g';

  @override
  String get k50lO8uGHM => 'K_50lO8uGHM';

  @override
  String get eP012026RebirthChineseDrama =>
      '📽️【EP01 2026】Rebirth Chinesisches Drama ENGSUB | Li Yunrui / Huangyang Tiantian / Zhang Kangle ⛵😍 Historisches Drama 2026 #冰湖重生';

  @override
  String get soRNQqVHiE => 'SoRN-qqVHiE';

  @override
  String get label0WKj11GO1k => '0WKj11G-O1k';

  @override
  String get mckn8scIT9M => 'Mckn8scIT9M';

  @override
  String get label3ouJb1XcvO => '3ouJb1Xcv-o';

  @override
  String get oGOi5zR5GE => 'OGOi5z-R5GE';

  @override
  String get oSCmrPPTm8 => 'oSCmrPPTm-8';

  @override
  String get fSBy5hig8pk => 'FSBy5hig8pk';

  @override
  String get sC1tGve5Nr0 => 'SC1tGve5Nr0';

  @override
  String get lYWUkqJk2E => 'LYW-ukqJk2E';

  @override
  String get iXwhs66r7C => 'IXwhs66r7_c';

  @override
  String get hJ1qGBGVF14 => 'HJ1qGBGVF14';

  @override
  String get xz1ZaLRTo => 'xz1-Za_LRTo';

  @override
  String get pL6xVgUZ4UP2OaE8yjLqTIxq2XKePI7m7 =>
      'PL6xVgUZ4UP2OaE8yjLqTIxq2XKe-PI7m7';

  @override
  String get xi7IXdkzYg => 'Xi7IXdkz-yg';

  @override
  String get xMUzyFFGBS => 'xMUzyFFGB-s';

  @override
  String get cAPUf0NVjfg => 'CAPUf0NVjfg';

  @override
  String get jObgd77gRVI => 'JObgd77gRVI';

  @override
  String get zAh5l4TSL44 => 'ZAh5l4TSL44';

  @override
  String get iH5Dhymb50 => 'IH-5Dhymb50';

  @override
  String get pLIPiKkSFpKBxGpxeLaoE3RK1B27J2K =>
      'PLIPiKkS-FpK-BxGpxeLaoE3RK1-B27J2K';

  @override
  String get label5iTVfTFX1c => '5i-tVfTFX1c';

  @override
  String get label2jKJSKqQlI => '2jKJSKq-qlI';

  @override
  String get xTqeH63puw => 'xTqe-h63puw';

  @override
  String get oazvgr9cyow => 'Oazvgr9cyow';

  @override
  String get fULLFatedHeartsLiQin =>
      '【FULL】🏹Fated Hearts | Li Qin, Chen Zheyuan | iQIYI Philippines';

  @override
  String get kCYYUs6wGOY => 'KCYYUs6wGOY';

  @override
  String get tm2SyrqoQg => 'tm2-SyrqoQg';

  @override
  String get qZ5uUGk9gmg => 'QZ5uUGk9gmg';

  @override
  String get xETV6qEPY => 'XETV6qE-P_Y';

  @override
  String get label8rWW83nQVE => '-8rWW83nQVE';

  @override
  String get zd4MuxKNDE => 'zd-4MuxKNDE';

  @override
  String get s2pk7pn3go4 => 'S2pk7pn3go4';

  @override
  String get hQvrj4X9Frg => 'HQvrj4X9Frg';

  @override
  String get fc8AWtgpGY => 'fc-8AWtgpGY';

  @override
  String get zPgeg1zFU1s => 'ZPgeg1zFU1s';

  @override
  String get iYjOKBPzxE => 'iYjOK-bPzxE';

  @override
  String get label6DmBfkWs4I => '-6DmBfkWs4I';

  @override
  String get label3JUCW6WIY => '-3JUC-w6WIY';

  @override
  String get sJ22yMn4qfY => 'SJ22yMn4qfY';

  @override
  String get ono7fMWcfcg => 'Ono7fMWcfcg';

  @override
  String get txW0Ss7D50 => 'txW-0Ss7D50';

  @override
  String get pLIPiKkSFpK9dJRiyjRahGpG8woGS9Sl2 =>
      'PLIPiKkS-FpK9dJRiyjRahGpG8woGS9Sl2';

  @override
  String get mVab12IKYMA => 'MVab12IKYMA';

  @override
  String get zLABLPu8ik => 'Z-lABLPu8ik';

  @override
  String get hCoJMcrjQ => 'hCoJ_-McrjQ';

  @override
  String get eRyFDWPR4 => 'e_ry-fDWPR4';

  @override
  String get mAvoRUd3wU => 'MAvoRUd-3wU';

  @override
  String get dWExvMyVU => 'dW-ExvMyV-U';

  @override
  String get bPKuepfUA => '-bPKuepf_UA';

  @override
  String get fBj8DL4EF0 => 'fBj8D-L4EF0';

  @override
  String get pLIPiKkSFpK87slgXbMjH686D5Y9P0EuG =>
      'PLIPiKkS-FpK87slgXbMjH686D5Y9P0EuG';

  @override
  String get k0Gl3FEW4s => 'K0Gl-3FEW4s';

  @override
  String get shHZmbjrqI => '-shHZmbjrqI';

  @override
  String get label7X5IzmrLCw => '7-X5IzmrLCw';

  @override
  String get nI1kp3v97O => 'nI1kp3v97-o';

  @override
  String get ea8enhWKTo0 => 'Ea8enhWKTo0';

  @override
  String get yL0RBWIo2iw => 'YL0RBWIo2iw';

  @override
  String get hX1u0R19FY => 'H_x1u0R19FY';

  @override
  String get cEGtoc5chDc => 'CEGtoc5chDc';

  @override
  String get qXKk36teGLc => 'QXKk36teGLc';

  @override
  String get pLIPiKkSFpKZTWsxZO5xUAlAsUEFOl3K =>
      'PLIPiKkS-FpK-zTWsxZO5xUAlAsUEFOl3K';

  @override
  String get mtO6K9Y59Q => 'Mt_o6K9Y59Q';

  @override
  String get kVop5QZCM => 'kVop_5QZ-cM';

  @override
  String get lX8cA1yLAg => 'l-X8cA1yLAg';

  @override
  String get v7m8WNX1gxE => 'V7m8WNX1gxE';

  @override
  String get bGf1clBUq0 => 'BGf1clB_uq0';

  @override
  String get lPA6cWd9vqA => 'LPA6cWd9vqA';

  @override
  String get pfckLVY64 => '-Pfck_LVY64';

  @override
  String get pLIPiKkSFpKN3T51FbkSIbF5IQ0RxhVm =>
      'PLIPiKkS-FpK_n3T51FbkSIbF5IQ0RxhVm';

  @override
  String get aH80GizsvY => 'AH8-0GizsvY';

  @override
  String get jI2ISWehQ => 'jI2IS-Weh_Q';

  @override
  String get label7rwGdyAl0g => '7rw-gdyAl0g';

  @override
  String get kF4rfnm9qdo => 'KF4rfnm9qdo';

  @override
  String get v1ae2rgrl70 => 'V1ae2rgrl70';

  @override
  String get c9D8kCt3k => 'C9D8k_-Ct3k';

  @override
  String get zY4ALWb5lw => 'ZY4AL-wb5lw';

  @override
  String get qUvwUdI73Y => 'q-UvwUdI73Y';

  @override
  String get iT670fTpFQ => 'iT-670fTpFQ';

  @override
  String get b6t7LGBPK => 'b6t_7LGBP-k';

  @override
  String get w9QYDN3nxTc => 'W9QYDN3nxTc';

  @override
  String get w9NPQe4Z5kE => 'W9NPQe4Z5kE';

  @override
  String get tQSHAlsaxqw => 'TQSHAlsaxqw';

  @override
  String get tN0ATkrc2zw => 'TN0ATkrc2zw';

  @override
  String get label7tsZeZfLtI => '7tsZeZfLt-I';

  @override
  String get w59SaAa6Ck => 'W59Sa_Aa6Ck';

  @override
  String get lSBiko45p8U => 'LSBiko45p8U';

  @override
  String get t2PwfV1JIE => 'T2PwfV1J-iE';

  @override
  String get bz75CXZ3c => 'Bz75CX-z_3c';

  @override
  String get nEEt9D9uR4g => 'NEEt9D9uR4g';

  @override
  String get dFv86C0wEg8 => 'DFv86C0wEg8';

  @override
  String get nWijSsYBUI => 'nWijSsYBU-I';

  @override
  String get ui2O9fffvWM => 'Ui2O9fffvWM';

  @override
  String get kMK9ZIL5vIE => 'KMK9ZIL5vIE';

  @override
  String get pZxPXGSNk => 'pZx_pXG-sNk';

  @override
  String get lGe1BEo7wL8 => 'LGe1BEo7wL8';

  @override
  String get wtVVEt4NxI => 'WtVVEt4Nx-I';

  @override
  String get ggXL7dEPA => 'Gg-xL7d-ePA';

  @override
  String get mPO0drxj4XI => 'MPO0drxj4XI';

  @override
  String get qYkUzAJo => '--q_ykUzAJo';

  @override
  String get mU4PJGdOxg => 'mU4PJGd-oxg';

  @override
  String get hOWSRDXSjb4 => 'HOWSRDXSjb4';

  @override
  String get nttqxJL3ES => 'nttqxJL3E-s';

  @override
  String get tJCmewUT4O => 'tJCmewUT4-o';

  @override
  String get sp7QFdPm3o => 'Sp7Q-FdPm3o';

  @override
  String get qI7c50Jcxbk => 'QI7c50Jcxbk';

  @override
  String get tM0RxsWCms => 'tM0Rxs-wCms';

  @override
  String get pLIPiKkSFpK6Iyv3Gsa1hZqwSLQ4z34u =>
      'PLIPiKkS-FpK_6Iyv3Gsa1hZqwSLQ4z34u';

  @override
  String get p1c9AW9VNY => 'p1c9-aW9VNY';

  @override
  String get eTwGAe5RiM => 'e-TwGAe5RiM';

  @override
  String get vSDFc4ivKU => 'VSD-Fc4ivKU';

  @override
  String get label2UNAa30mF0 => '2U-nAa30mF0';

  @override
  String get iLP6X3nSYE => 'I-LP6X3nSYE';

  @override
  String get mo4kd8rg3yU => 'Mo4kd8rg3yU';

  @override
  String get xt8m39rI9o => 'Xt8m_39rI9o';

  @override
  String get oFLWTHOJJo => 'OFLWTHO-jJo';

  @override
  String get pLlRMBKO6RkY69nj6AJ051lj7vSGrkNxZ =>
      'PLlRMBK-O6RkY69nj6AJ051lj7vSGrkNxZ';

  @override
  String get label3gTpyQenT0 => '3gTpy-qenT0';

  @override
  String get nM3BDMI4YS => 'nM3BDMI4Y-s';

  @override
  String get hudgy0oFTz4 => 'Hudgy0oFTz4';

  @override
  String get lVc0U1sJIBU => 'LVc0U1sJIBU';

  @override
  String get gBTqOwTPTU => 'G-BTqOwTPTU';

  @override
  String get tN0iGRSk => '_T-N-0iGRSk';

  @override
  String get gkEBMyB9TM => 'gkEBMy-B9TM';

  @override
  String get bw3XWYzoI => '-bw3XWYzo-I';

  @override
  String get fullBrightEyesInThe =>
      '【Komplett】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Philippines';

  @override
  String get jalmOqeImY => 'JalmOqeIm-Y';

  @override
  String get vUuzPUBkas => 'V-UuzPUBkas';

  @override
  String get ni1jN2ECMY => 'Ni1j-N2ECMY';

  @override
  String get v5qeq2caORg => 'V5qeq2caORg';

  @override
  String get cB64rYJ2tX4 => 'CB64rYJ2tX4';

  @override
  String get qwyz2k6oymc => 'Qwyz2k6oymc';

  @override
  String get gQYaqUf4 => 'GQ_-_YaqUf4';

  @override
  String get tqHC6KtyoI => 'tqHC6-ktyoI';

  @override
  String get hvsJOV10Q => 'hvsJOV-_10Q';

  @override
  String get label9LFPEXffyQ => '-9LFPEXffyQ';

  @override
  String get bMbhR77eps => 'b-MbhR77eps';

  @override
  String get olkxX4m0m4 => 'OlkxX-4m0m4';

  @override
  String get vE8nY1UC2zo => 'VE8nY1UC2zo';

  @override
  String get pLIPiKkSFpKZjc5dsVYfFD44oWYA1YZ =>
      'PLIPiKkS-FpK-Zjc5dsVYfFD44oWYA-1YZ';

  @override
  String get gZDlH6PN3M => 'gZDlH6P-n3M';

  @override
  String get iw4jJBB5z7A => 'Iw4jJBB5z7A';

  @override
  String get hOTu6yklewA => 'HOTu6yklewA';

  @override
  String get vJqSl1U6CE => '-VJqSl1U6CE';

  @override
  String get yF3ZBEnNaA => 'YF-3ZBEnNaA';

  @override
  String get at8v7Xp7XX4 => 'At8v7Xp7XX4';

  @override
  String get ctXWz6p3RI => '-CtXWz6p3RI';

  @override
  String get gsuEr3Rwo => 'GsuEr3--Rwo';

  @override
  String get cvkAplxMt0 => '-CvkAplxMt0';

  @override
  String get ssQiWv0MEA => 'SsQiWv0M-eA';

  @override
  String get aaDlYQswEc => 'aaDl-YQswEc';

  @override
  String get oaDLF7MQF0 => 'Oa_DLF7MQF0';

  @override
  String get pLIPiKkSFpK9jSaLiXXKZUvwfh7ROuLy =>
      'PLIPiKkS-FpK9jSaLiXX_KZUvwfh7ROuLy';

  @override
  String get g0nqbugnDI => 'G_0nqbugnDI';

  @override
  String get tnHgUzjPNQ => 'TnHgUzj-pNQ';

  @override
  String get nM7ZeWM1g => 'n-m7ZeW-m1g';

  @override
  String get sUqbEIap2M => '-sUqbEIap2M';

  @override
  String get x0qW6MwABw => 'X0qW6Mw-ABw';

  @override
  String get lANXfM0Hmc => 'L-aNXfM0Hmc';

  @override
  String get y84UUFKMZf4 => 'Y84UUFKMZf4';

  @override
  String get mGPFI2bfKPE => 'MGPFI2bfKPE';

  @override
  String get f3wSwhf0z8 => 'F3w_swhf0z8';

  @override
  String get qFITVBXVj2g => 'QFITVBXVj2g';

  @override
  String get pLyT8L9yeLXCR7t2xuK0L7L4qIRBTnA2n =>
      'PLyT8L9yeLXCR7t2xuK0-L7L4qIRBTnA2n';

  @override
  String get aY1Wv805lUw => 'AY1Wv805lUw';

  @override
  String get w44Q3K2QJY => 'W44-q3K2QJY';

  @override
  String get kJn1gifAmok => 'KJn1gifAmok';

  @override
  String get xwEsWU6WI => 'xwEs-WU6_wI';

  @override
  String get gt93TaUaco => 'gt9-3TaUaco';

  @override
  String get label0C62qBO6o => '0_c62q-bO6o';

  @override
  String get label7DqIz7YqcA => '7Dq-iz7YqcA';

  @override
  String get xh5K9iCMoo => 'xh5K9iC-Moo';

  @override
  String get aKGp1lOCRTI => 'AKGp1lOCRTI';

  @override
  String get jWYI2dtDE0 => 'JWY_i2dtDE0';

  @override
  String get yWHZCsskuvo => 'YWHZCsskuvo';

  @override
  String get label76Z43cwXKQ => '76Z43cw-xKQ';

  @override
  String get cINtsiKIx4 => 'CINtsi-kIx4';

  @override
  String get eNGSUBChineseFantasyMovie =>
      '🎥✨【DEU UNT】Chinesischer Fantasy-Film | Fantasy, Abenteuer【 iQIYI MOVIE THEATER - Jetzt abonnieren】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 iQIYI MOVIE THEATER - Hol dir die iQIYI-App';

  @override
  String get oNi1Mh97lYo => 'ONi1Mh97lYo';

  @override
  String get sF74vcQwZE => 'sF74vc-qwZE';

  @override
  String get qBQ1xvkvQHw => 'QBQ1xvkvQHw';

  @override
  String get s2HdHtZAU => 'S2HdHtZ_A-U';

  @override
  String get pyt8OISpH0 => 'Pyt8O-ISpH0';

  @override
  String get x5oUtpXWQ => 'X5oUtp_X_wQ';

  @override
  String get miniDramaENGSUBFull =>
      '🎀【微短剧 Mini-Drama】ENG SUB | Vollständige Sammlung | Lade die WeTV / Tencent Video App herunter, um mehr zu sehen';

  @override
  String get vZysxG7Jdg => 'V-zysxG7Jdg';

  @override
  String get aLCm1V4uj8 => 'aL-Cm1V4uj8';

  @override
  String get xk8guI5XC7I => 'Xk8guI5XC7I';

  @override
  String get woIZMiblY => 'Wo--IZMiblY';

  @override
  String get e0Z1n9lVyg => 'E0Z1n-9lVyg';

  @override
  String get rakZAuY6Xc => 'RakZ-auY6Xc';

  @override
  String get rW5f3p84 => 'RW_5f-_3p84';

  @override
  String get wMtyXWrQRY => 'wMtyXWrQ-rY';

  @override
  String get bQj9Q1GRnrk => 'BQj9Q1GRnrk';

  @override
  String get ezD9rGwMk => '-EzD9r_GwMk';

  @override
  String get pLIPiKkSFpK8hfRCOdc3tpxnj6JmGAZoc =>
      'PLIPiKkS-FpK8hfRCOdc3tpxnj6JmGAZoc';

  @override
  String get bSt0NgJemE => '-bSt0NgJemE';

  @override
  String get zwSSFibKM => 'zwSSFib-_kM';

  @override
  String get rFPkjQgdwQ => 'rFPkjQgdw-Q';

  @override
  String get label0BgIjnISU => '0BgIjnIS-_U';

  @override
  String get o1mRObiOog => 'O-1mRObiOog';

  @override
  String get yHkKXeRbbk => 'YHk-KXeRbbk';

  @override
  String get label0E4CVmwEv0 => '0E4-CVmwEv0';

  @override
  String get n220nwxfsgY => 'N220nwxfsgY';

  @override
  String get rZQc0wk8Y4c => 'RZQc0wk8Y4c';

  @override
  String get uIV6jneTw => 'U_i-v6jneTw';

  @override
  String get fullBeautyOfResilienceJu =>
      '【Vollständig】Beauty of Resilience | Ju Jing Yi, Fiktion | iQIYI Philippinen';

  @override
  String get tT8V4eOewkc => 'TT8V4eOewkc';

  @override
  String get a6D40BKYc9Y => 'A6D40BKYc9Y';

  @override
  String get gd5lvL1Y3UI => 'Gd5lvL1Y3UI';

  @override
  String get bhrmf6kUnc => 'Bhrmf6k_Unc';

  @override
  String get zajsQ18HyM => 'Zajs-Q18HyM';

  @override
  String get za9iO7xrdhU => 'Za9iO7xrdhU';

  @override
  String get cCi69c44BTY => 'CCi69c44BTY';

  @override
  String get c5Lnqm4FI5s => 'C5Lnqm4FI5s';

  @override
  String get bXr6Zu7EH3g => 'BXr6Zu7EH3g';

  @override
  String get pLIPiKkSFpK85Ldm2HSl0Xwj2hN7T59g =>
      'PLIPiKkS-FpK85Ldm2HSl-0Xwj2hN7T59g';

  @override
  String get pLWIh6wofY4 => 'PLWIh6wofY4';

  @override
  String get label3YVDQD5Onc => '3-yVDQD5Onc';

  @override
  String get iPxGP1UGnM => 'IPx-GP1UGnM';

  @override
  String get hotTrendingMoonlitReunionFull =>
      '🔥Angesagt【子夜归 Moonlit Reunion】Alle Folgen | Mensch und Dämon verlieben sich beim Lösen von Rätseln | Xu Kai, Tian Xiwei | ENGL. UNTERTITEL';

  @override
  String get v7niIXnWWM => 'v7ni-iXnWWM';

  @override
  String get vQ5PKKJSVHc => 'VQ5PKKJSVHc';

  @override
  String get hWuKG1vJe0 => 'hWu-kG1vJe0';

  @override
  String get ydHHEma2Q => '-ydHH-ema2Q';

  @override
  String get w6SB0R7W1U => 'W6-SB0R7W1U';

  @override
  String get kwjhz1XOLhs => 'Kwjhz1XOLhs';

  @override
  String get cmyjS5zTQ => '-cmyjS-5zTQ';

  @override
  String get label8DzphxFJPI => '8-DzphxFJPI';

  @override
  String get gzjc1eGV22g => 'Gzjc1eGV22g';

  @override
  String get y9ZHRA9lxcg => 'Y9ZHRA9lxcg';

  @override
  String get mnfa5S7KO8 => 'Mnfa5_S7KO8';

  @override
  String get gNiRWpeMws => 'gNiRWpe-mws';

  @override
  String get cVO0hA3P8O => 'CVO0hA3P8-o';

  @override
  String get label9afZnkZaPs => '9afZnk-zaPs';

  @override
  String get pLIPiKkSFpK9cUoS9l5spDGFvN2Crmdn =>
      'PLIPiKkS-FpK9cUoS9l_5spDGFvN2Crmdn';

  @override
  String get nLMKI6PT3o => 'NL_MKI6PT3o';

  @override
  String get zR7i5LASYI => 'ZR7i5_lASYI';

  @override
  String get keKMrR1Yss => 'KeK-mrR1Yss';

  @override
  String get juRTPVpVXA => 'juRTPVp-VXA';

  @override
  String get yzSy3klEQU => 'yzSy3kl-eQU';

  @override
  String get label8A7WTDaaGs => '8A7W-tDaaGs';

  @override
  String get pLIPiKkSFpK8hIu32ZhKKsO2wlADWaCBU =>
      'PLIPiKkS-FpK8hIu32ZhKKsO2wlADWaCBU';

  @override
  String get oVN1y6LPWD4 => 'OVN1y6LPWD4';

  @override
  String get qU7t6C4Gc => 'qU7t6-c4_gc';

  @override
  String get fk9JXDCOG4 => 'Fk9_JXDCOG4';

  @override
  String get uC7Mnd3qJc => 'UC7Mnd3q_Jc';

  @override
  String get glHm8Zs8Ac => 'glHm8Zs8-Ac';

  @override
  String get l2w4TUDxmsg => 'L2w4TUDxmsg';

  @override
  String get cPLU864rP14 => 'CPLU864rP14';

  @override
  String get a4mUs48UAU => 'a4mUs4-8UAU';

  @override
  String get bVmda5m2mN4 => 'BVmda5m2mN4';

  @override
  String get mZUf8J2gZA4 => 'MZUf8J2gZA4';

  @override
  String get tQiZtftwY => 'TQi--ZtftwY';

  @override
  String get bR38d9KJoos => 'BR38d9KJoos';

  @override
  String get pLIPiKkSFpKOHffjOp4RqWHtE2OYq =>
      'PLIPiKkS-FpK-oHffjOp4-rq__WHtE2OYq';

  @override
  String get fyuHVqsXMI => 'fyuHVqs-XMI';

  @override
  String get yJB0nFJNw0 => 'YJB0nFJNw_0';

  @override
  String get label21RxwDPr8k => '21Rxw-DPr8k';

  @override
  String get zZTZ149pQ => 'ZZ-_tZ149pQ';

  @override
  String get o5qvwYEyQ0 => 'o5qvwY-EyQ0';

  @override
  String get bGGDIBw4TIw => 'BGGDIBw4TIw';

  @override
  String get gU0lbFUBwg8 => 'GU0lbFUBwg8';

  @override
  String get yTfshUkXmG => 'yTfshUkXm-g';

  @override
  String get yOUTUBEAPIKEY => 'YOUTUBE_API_KEY=';

  @override
  String get partContentDetails => '?part=contentDetails';

  @override
  String get fallInLove => 'sich verlieben';

  @override
  String get myGirl => 'My Girl';

  @override
  String get firstRomance2 => 'Erste Romanze';

  @override
  String get fallFor => 'sich verlieben in';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Versteckte Liebe';

  @override
  String get loveBetweenFairyAndDevil2 => 'Love Between Fairy and Devil';

  @override
  String get loveLikeTheGalaxy2 => 'Love Like The Galaxy';

  @override
  String get myJourneyToYou2 => 'My Journey to You';

  @override
  String get mysteriousLotusCasebook2 => 'Mysterious Lotus Casebook';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get theLongBallad2 => 'The Long Ballad';

  @override
  String get theUntamed2 => 'The Untamed';

  @override
  String get wordOfHonor2 => 'Word of Honor';

  @override
  String get lightOfDawn2 => '人之初 Licht des Morgenrots';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|BESCHÜTZER DER HEIMAT';

  @override
  String get searching2 => 'Suchen...';

  @override
  String get verse => 'Vers';

  @override
  String get allStories2 => 'Alle Geschichten';

  @override
  String get bbcComZhongwenTrad => 'bbc.com/zhongwen/trad';

  @override
  String get hanziClickable => '.hanzi-clickable';

  @override
  String get sentenceText => 'sentence-text';

  @override
  String get sentenceWrapper => 'sentence-wrapper';

  @override
  String get hanziClickable2 => 'hanzi-clickable';

  @override
  String get char2 => '+ Zeichen +';

  @override
  String get sentenceText2 => '.sentence-text';

  @override
  String get ttsBtn => 'tts-btn';

  @override
  String get hanziTranslateBtn => 'hanzi-translate-btn';

  @override
  String get label10px16px => '10px 16px';

  @override
  String get articleArticlePostContentMain =>
      'Artikel, .article, .post, .content, main';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'Obere Mittelstufe';

  @override
  String get hanziDarkModeStyle => 'hanzi-dark-mode-style';

  @override
  String get sharedaddyJpPostFlairEntry =>
      '.sharedaddy, #jp-post-flair, .entry-meta, .wpcnt, .author-info, #comments, .comments, .post-footer, footer, .related-posts, .share-buttons';

  @override
  String get aiInsightBanner => 'ai-insight-banner';

  @override
  String get summaryToggleBtn => 'summary-toggle-btn';

  @override
  String get toggleChevron => 'toggle-chevron';

  @override
  String get summaryText => 'summary-text';

  @override
  String get documentBodyInnerText => 'document.body.innerText';

  @override
  String get documentTitle => 'document.title';

  @override
  String get processing => 'Wird verarbeitet…';

  @override
  String get keepItUp => '好！Weiter so';

  @override
  String get minutesDay => 'Minuten / Tag';

  @override
  String get consistencyIsTheInkThat =>
      '„Beständigkeit ist die Tinte, die das Zeichen formt.“';

  @override
  String get businessCareer => 'Business & Karriere';

  @override
  String get travelSurvival => 'Reisen & Alltag';

  @override
  String get label05MinDay => '05 Min. / Tag';

  @override
  String get label10MinDay => '10 Min. / Tag';

  @override
  String get label20MinDay => '20 Min. / Tag';

  @override
  String get label30MinDay => '30 Min. / Tag';

  @override
  String get dynamicDecksStrokeAnalysis => 'Dynamische Decks & Strichanalyse';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Abonnements sind vorübergehend nicht verfügbar. Bitte versuche es erneut.';

  @override
  String get trialReminder => 'Erinnerung an Testphase';

  @override
  String get turnOnNotificationsIfYou =>
      'Aktiviere Benachrichtigungen, wenn du vor Ablauf deiner Testphase erinnert werden möchtest. Deine App Store-Abo-Einstellungen bleiben maßgeblich.';

  @override
  String get label2Months => '2 Monate';

  @override
  String get label3Months => '3 Monate';

  @override
  String get label6Months => '6 Monate';

  @override
  String get billingPeriod => 'Abrechnungszeitraum';

  @override
  String get chooseASubscription => 'Abonnement auswählen';

  @override
  String get startFreeTrial => 'Kostenlose Testphase starten';

  @override
  String get smartNewsDict => 'Smart News & Wörterbuch';

  @override
  String get hSK16AIDecks => 'HSK 1-6 & KI-Decks';

  @override
  String get continueWithTemporaryPremium =>
      'Mit vorübergehendem Premium fortfahren';

  @override
  String get testProductUnavailable => 'Testprodukt nicht verfügbar';

  @override
  String get paymentIsChargedToYour =>
      'Die Zahlung wird deinem App Store-Konto belastet.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'Abonnements verlängern sich automatisch, sofern sie nicht gekündigt werden';

  @override
  String get atLeast24HoursBefore =>
      'mindestens 24 Stunden vor Ende des aktuellen Zeitraums.';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get closePurchaseOffer => 'Kaufangebot schließen';

  @override
  String get loading => 'Wird geladen…';

  @override
  String get analyzingImage2 => 'Bild wird analysiert…';

  @override
  String get extractingChineseText2 => 'Chinesischer Text wird extrahiert…';

  @override
  String get lookingUpVocabulary2 => 'Vokabeln werden nachgeschlagen…';

  @override
  String get deselectAll => 'Alle abwählen';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Meisterwerk der Welt- und chinesischen Literatur.';

  @override
  String get classic => 'Klassiker';

  @override
  String get literature => 'Literatur';

  @override
  String get theOriginAwakening => 'Ursprung & Erwachen';

  @override
  String get turbulentHorizonsTheJourney => 'Stürmische Horizonte & Die Reise';

  @override
  String get trialsTribulationsDevotion => 'Prüfungen, Entbehrungen & Hingabe';

  @override
  String get theClashOfWitsBravery => 'Wettstreit von Verstand & Mut';

  @override
  String get theGrandClimaxResolution => 'Großer Höhepunkt & Auflösung';

  @override
  String get everlastingLegacyEpilogue => 'Ewiges Erbe & Epilog';

  @override
  String get acrossTheVastExpanseOf =>
      'Über die Weiten von Himmel und Erde hinweg folgen Gestalten durch tiefe Prüfungen ihrer Bestimmung und ihren Überzeugungen.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Jeder Dialog und jede Begegnung in der Erzählung trägt den Glanz des menschlichen Geistes und die Prägung ihrer Zeit in sich.';

  @override
  String get followingTheFlowOfProse =>
      'Dem Fluss der Prosa folgend durchqueren Leser Jahrhunderte, um an den Triumphen und Leiden legendärer Figuren teilzuhaben.';

  @override
  String get preQin => 'Vor-Qin';

  @override
  String get theGoddessNWaRepairing => 'Die Göttin Nüwa repariert den Himmel';

  @override
  String get artsTraditions => 'Kunst & Traditionen';

  @override
  String get femaleWarm => 'Weiblich, warm';

  @override
  String get femaleCheerful => 'Weiblich, fröhlich';

  @override
  String get maleUpbeat => 'Männlich, schwungvoll';

  @override
  String get maleNewsStyle => 'Männlich, Nachrichten-Stil';

  @override
  String get maleSporty => 'Männlich, sportlich';

  @override
  String get onDevice => 'Auf dem Gerät';

  @override
  String get label15Minutes => '15 Minuten';

  @override
  String get label30Minutes => '30 Minuten';

  @override
  String get label45Minutes => '45 Minuten';

  @override
  String get selectChapter => 'Kapitel auswählen';

  @override
  String get andContinuesToBeStudied =>
      'und wird weiterhin von Generationen von Lesern studiert und geschätzt.';

  @override
  String get label1Poem => '1 Gedicht';

  @override
  String get label1Chapter => '1 Kapitel';

  @override
  String get localDeviceVoice2 => 'Lokale Gerätestimme';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Wöchentliches Azure-Kontingent erreicht – Wechsel zur lokalen Stimme';

  @override
  String get sleepTimer2 => '定时关闭 · Sleep-Timer';

  @override
  String get tableOfContents2 => '目录 · Inhaltsverzeichnis';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Spanische, italienische & russische Klassiker';

  @override
  String get englishAmericanGlobalClassics =>
      'Englische, amerikanische & weltweite Klassiker';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'während gezielt Wörter eingebettet werden, mit denen du gerade Schwierigkeiten hast, damit du sie im Kontext lernen kannst.';

  @override
  String get poetryPainting => 'Poesie-Malerei';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Das Shadowing Studio ist ein spezieller Bereich zum Nachsprechen von Muttersprachlern. Du hörst einen Satz, nimmst dich beim Wiederholen auf und vergleichst Wellenformen sowie Aussprachebewertungen, um deinen Akzent zu verfeinern.';

  @override
  String get theVoicesInAIStories =>
      'KI-Geschichten und Rollenspiel verwenden synthetische Stimmen aus fortschrittlichen Text-zu-Sprache-Modellen, die auf eine klare, natürliche chinesische Aussprache abgestimmt sind. In einigen Funktionen kann auch die lokale Gerätestimme verfügbar sein.';

  @override
  String get theWebExplorerAllowsYou =>
      'Mit dem Web-Explorer kannst du jede chinesische Website durchstöbern. Wenn du auf ein schwieriges Wort stößt, tippe es einfach an, um die Schnellansicht mit Pinyin, Übersetzung und HSK-Stufe zu öffnen.';

  @override
  String get zenModeStripsAwayDistracting =>
      'Der Zen-Modus entfernt störende Webelemente, Werbung und komplexe Layouts aus Artikeln und bietet eine aufgeräumte, kalligrafische Leseumgebung, die sich ganz auf den Text konzentriert.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Wir nutzen einen intelligenten Algorithmus, der vorhersagt, wann du ein Wort kurz vor dem Vergessen bist. Wörter, die dir schwerfallen, erscheinen häufiger, während gut gelernte Wörter später eingeplant werden.';

  @override
  String get usage3 => 'Verwendung:';

  @override
  String get tutorialOneExplanation =>
      'Das ist EINS (Yī). Zeichne immer von links nach rechts.';

  @override
  String get tutorialWaterExplanation =>
      'Das ist das vollständige Zeichen WASSER (Shuǐ). Als linke Komponente verwandelt es sich in „氵“ (Drei Punkte)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Hanzi bestehen aus Bausteinen, die RADIKALE genannt werden. Sie verleihen dem Zeichen seine Kernbedeutung oder sein Thema.';

  @override
  String get tutorialLettersExplanation =>
      'Hanzi sind nicht nur Buchstaben. Sie sind erstarrte Bilder. Um sie zu meistern, musst du lernen, ihrem Fluss zu folgen.';

  @override
  String get tutorialGalaxyExplanation =>
      'Die Galaxie-Karte wartet. Meistere die Sonnen (Radikale), um die Planeten (Zeichen) freizuschalten.';

  @override
  String get onboardingDailyLifeTravel => 'Alltag & Reisen';

  @override
  String get onboardingPhilosophyIdioms => 'Philosophie & Redewendungen';

  @override
  String get onboardingBusinessCareerMulti => 'Geschäft &\nKarriere';

  @override
  String get onboardingTravelSurvivalMulti => 'Reisen &\nÜberleben';

  @override
  String get onboardingHskCertificationMulti => 'HSK-\nZertifizierung';

  @override
  String get onboardingCulturalAppreciationMulti => 'Kulturelles\nVerständnis';

  @override
  String get practiceReminders => 'Übungserinnerungen';

  @override
  String get oneOptionalDailyReminderTo =>
      'Eine optionale tägliche Erinnerung zum Chinesischlernen';

  @override
  String get aFewMinutesOfChinese => 'Ein paar Minuten Chinesisch? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Bleibe am Ball mit einer kurzen Übungseinheit.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'lernen · studieren';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'entdecken';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'durchhalten';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'wachsen';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'ruhig · friedlich';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'verstehen';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'Wärme · warm';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'fokussieren';

  @override
  String get definitionExpansionButton => 'definition-expansion-button';

  @override
  String get wenigerAnzeigen => 'Weniger anzeigen';

  @override
  String get mostrarMenos => 'Weniger anzeigen';

  @override
  String get afficherMoins => 'Weniger anzeigen';

  @override
  String get mostraMeno => 'Weniger anzeigen';

  @override
  String get showFewer => 'Weniger anzeigen';

  @override
  String get masterLin => 'Meister Lin';

  @override
  String get xiaoMei => 'Xiao Mei';

  @override
  String get thePoet => 'Der Dichter';

  @override
  String get aQiang => 'A-Qiang';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Förmlich & weise';

  @override
  String get casualFriendly => 'Locker & freundlich';

  @override
  String get poeticAncient => 'Poetisch & klassisch';

  @override
  String get slangInternet => 'Slang & Internet';

  @override
  String get trendyModern => 'Trendig & modern';

  @override
  String get designYourOwn => 'Selbst gestalten';

  @override
  String get theBambooSwaysAndThe =>
      'Der Bambus wiegt sich, und der Gelehrte wartet auf deine Worte wie auf Morgenregen...';

  @override
  String get yourCustomPersonaIsActive =>
      'Deine eigene Persona ist aktiv. Tippe, um das Gespräch zu beginnen.';

  @override
  String get hHMm => 'HH:mm';

  @override
  String get fROMLocalizedDefinitionQualityWHERE =>
      'FROM localized_definition_quality WHERE language_code = ?';

  @override
  String get gemini25Flash => 'gemini-2.5-flash';

  @override
  String get dictionaryExpansionV1 => 'dictionary-expansion-v1';

  @override
  String get staleDictionaryExpansionResponse =>
      'Veraltete Wörterbucherweiterungs-Antwort';

  @override
  String get dictionaryExpansionWasEmpty => 'Wörterbucherweiterung war leer';

  @override
  String get explicationDTaillEDisponible => 'Ausführliche Erklärung verfügbar';

  @override
  String get ausfHrlicheErklRungVerf => 'Ausführliche Erklärung verfügbar';

  @override
  String get explicaciNDetalladaDisponible =>
      'Ausführliche Erklärung verfügbar';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Ausführliche Erklärung verfügbar';

  @override
  String get explicaODetalhadaDisponVel => 'Ausführliche Erklärung verfügbar';

  @override
  String get detailedExplanationAvailable => 'Ausführliche Erklärung verfügbar';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Eine optionale tägliche Übungserinnerung';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Wähle eine optionale tägliche Übungserinnerung.';

  @override
  String get practiceReminder => 'Übungserinnerung';

  @override
  String get oneGentleReminderADay =>
      'Eine sanfte Erinnerung pro Tag, nur wenn du sie brauchst';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Das Abschließen der Übung deaktiviert die heutige Erinnerung. Wiederholungs- und';

  @override
  String get reEngagementAlertsAreCombined =>
      'Reaktivierungs-Hinweise werden kombiniert, damit sie sich nicht stapeln.';

  @override
  String get processing2 => 'Wird verarbeitet…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Anhören';

  @override
  String get notice => 'Beachten';

  @override
  String get fourTones => 'Vier Töne';

  @override
  String get write => 'Schreiben';

  @override
  String get recap => 'Zusammenfassung';

  @override
  String get playbackDidNotStart => 'Wiedergabe wurde nicht gestartet';

  @override
  String get audioIsUnavailableYouCan =>
      'Audio ist nicht verfügbar. Du kannst trotzdem lesen und fortfahren.';

  @override
  String get microphoneAccessWasNotGranted =>
      'Mikrofonzugriff wurde nicht gewährt. Du kannst ihn in den Einstellungen aktivieren.';

  @override
  String get recordingIsUnavailableRightNow =>
      'Aufnahme ist momentan nicht verfügbar.';

  @override
  String get listeningToYourTones => 'Höre auf deine Töne…';

  @override
  String get noRecording => 'Keine Aufnahme';

  @override
  String get weCouldNotScoreThat =>
      'Wir konnten diese Aufnahme nicht bewerten, daher siehst du hier einen Beispiel-Tonvergleich.';

  @override
  String get listenForTheLowDipping =>
      'Achte auf den tiefen, fallend-steigenden dritten Ton.';

  @override
  String get firstHearATinyMoment =>
      'Höre zuerst einen kurzen Ausschnitt auf Mandarin. Noch nicht auswendig lernen.';

  @override
  String get loadingAudio => 'Audio wird geladen…';

  @override
  String get listenToThePassage => 'Höre dir die Passage an';

  @override
  String get continueAction => 'Weiter';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Sieh, wie Bedeutung, Klang und Schriftzeichen zusammenhängen.';

  @override
  String get shadowOneSentence => 'Sprich einen Satz nach';

  @override
  String get listenOnceThenHoldThe =>
      'Einmal zuhören, dann das Mikrofon gedrückt halten und den Satz sprechen.';

  @override
  String get hearItAgain => 'Noch einmal hören';

  @override
  String get stopAndCheckMyTones => 'Stoppen und Töne prüfen';

  @override
  String get useMicrophone => 'Mikrofon verwenden';

  @override
  String get iCanTSpeakRight => 'Ich kann gerade nicht sprechen';

  @override
  String get tapACharacterToCompare =>
      'Tippe auf ein Zeichen, um deinen Ton mit dem Zielton zu vergleichen, und höre dir die Töne 1–4 an.';

  @override
  String get tryHandwriting => 'Handschrift ausprobieren';

  @override
  String get seeWhatYouLearned => 'Sieh, was du gelernt hast';

  @override
  String get inAFewMinutesYou =>
      'In wenigen Minuten hast du denselben Lernkreislauf genutzt, der auch deine Lektionen antreibt.';

  @override
  String get listenedToChineseInContext => 'Chinesisch im Kontext gehört';

  @override
  String get shadowedASentence => 'Einen Satz nachgesprochen';

  @override
  String get comparedMandarinTones => 'Mandarin-Töne verglichen';

  @override
  String get practicedARealCharacter => 'Ein echtes Schriftzeichen geübt';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'Am Morgen hörte der leichte Regen auf. Ich öffnete das Fenster und hörte Vögel in den Bäumen singen. Ein neuer Tag begann.';

  @override
  String get learnThroughRealVideos => 'Lerne mit echten Videos';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Folge interaktiven Untertiteln, schlage Wörter sofort nach und verwandle jedes Video in eine Lektion.';

  @override
  String get videoLearningScreenshot => 'Video-Lernen Screenshot';

  @override
  String get turnAnyBookIntoA =>
      'Verwandle jedes Buch in eine Lektion und ein Hörbuch';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Lies ganz natürlich mit Aussprache, Definitionen und Übersetzungen, wann immer du sie brauchst.';

  @override
  String get bookReaderScreenshot => 'Buchleser Screenshot';

  @override
  String get speakWithTheRightRhythm => 'Sprich frei mit KI und Live-Tönen';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Spreche Muttersprachlern nach und visualisiere alle vier Töne, während sich deine Aussprache verbessert.';

  @override
  String get shadowingAndTonesScreenshot => 'Shadowing und Töne Screenshot';

  @override
  String get understandEveryCharacter => 'Verstehe jedes Schriftzeichen';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Entdecke Bedeutung, Aussprache, Komponenten, Strichfolge und nützliches Vokabular an einem Ort.';

  @override
  String get characterDictionaryScreenshot =>
      'Screenshot des Schriftzeichenwörterbuchs';

  @override
  String get learnChineseWithoutLimits => 'Chinesisch ohne Grenzen lernen';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Schauen, lesen, sprechen und verstehen mit einem vollständigen Lernbegleiter.';

  @override
  String get seeWhatPremiumUnlocks => 'Sieh, was Premium freischaltet';

  @override
  String get scrollToExploreTheComplete =>
      'Scrolle, um das gesamte Lernerlebnis zu entdecken';

  @override
  String get cOMINGSOON => 'DEMNÄCHST';

  @override
  String get guidedHandwritingPractice => 'Geführtes Schreibtraining';

  @override
  String get scannerAndLiveTranslation => 'Scanner und Live-Übersetzung';

  @override
  String get hSK16AndAI => 'HSK 1–6 und KI-Decks';

  @override
  String get smartSpacedRepetition2 => 'Intelligente verteilte Wiederholung';

  @override
  String get progressAndStreakTracking => 'Fortschritts- und Serien-Tracking';

  @override
  String get learningToolsInOnePlace => 'Lernwerkzeuge an einem Ort';

  @override
  String get everythingIncluded => 'Alles inklusive';

  @override
  String get paymentIsChargedToYour2 =>
      'Die Zahlung wird deinem App Store-Konto belastet. Abonnements verlängern sich automatisch, es sei denn, sie werden mindestens 24 Stunden vor Ablauf des aktuellen Zeitraums gekündigt.';

  @override
  String get yourFirstWeekOfTracked => 'Deine erste Woche mit erfasster Übung';

  @override
  String get sameNumberOfCardsAs => 'Gleiche Kartenanzahl wie letzte Woche';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change Karten gegenüber letzter Woche';
  }

  @override
  String get todaySPractice => 'Heutiges Training';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Ziel erreicht – alles Weitere ist ein Bonus.';

  @override
  String get aSmallAchievableTargetNo =>
      'Ein kleines, erreichbares Ziel. Keine Strafe für einen Ruhetag.';

  @override
  String get thisWeek => 'Diese Woche';

  @override
  String get minutes => 'Minuten';

  @override
  String get activeDays => 'Aktive Tage';

  @override
  String dayStreakCount(int count) {
    return '$count Tage in Folge';
  }

  @override
  String get masterChineseOneStrokeAt =>
      'Meistere Chinesisch, Strich für Strich';

  @override
  String get dictionaryExpansionButton => 'Wörterbuch-Erweiterungs-Button';

  @override
  String get kIErweiterterWRterbucheintrag =>
      'KI-erweiterter Wörterbucheintrag';

  @override
  String get detalleAmpliadoPorIA => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get dTailEnrichiParL => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get aI => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get detailKamusYangDiperluasAI => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'KI-erweiterte Wörterbuch-Details';

  @override
  String get aI2 => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get aI3 => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get detalheDeDicionRioExpandido => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get aI4 => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get chiTiTTI => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get aI5 => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get aIExpandedDictionaryDetail => 'KI-erweiterte Wörterbuch-Details';

  @override
  String get cetteEntrEEstBr =>
      'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.';

  @override
  String get dieserEintragIstKurzEine =>
      'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.';

  @override
  String get estaEntradaEsBreveHay =>
      'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.';

  @override
  String get dVelopperEnFranAis => 'Auf Französisch erweitern';

  @override
  String get aufDeutschErweitern => 'Auf Deutsch erweitern';

  @override
  String get ampliarEnEspaOl => 'Auf Spanisch erweitern';

  @override
  String get approfondisciInItaliano => 'Auf Italienisch erweitern';

  @override
  String get expandirEmPortuguS => 'Auf Portugiesisch erweitern';

  @override
  String get expandDefinition => 'Definition erweitern';

  @override
  String get impossibleDeChargerLExplication =>
      'Die Erklärung konnte nicht geladen werden.';

  @override
  String get dieErklRungKonnteNicht =>
      'Die Erklärung konnte nicht geladen werden.';

  @override
  String get noSePudoCargarLa => 'Die Erklärung konnte nicht geladen werden.';

  @override
  String get impossibileCaricareLaSpiegazione =>
      'Die Erklärung konnte nicht geladen werden.';

  @override
  String get nOFoiPossVel => 'Die Erklärung konnte nicht geladen werden.';

  @override
  String get unableToLoadTheExplanation =>
      'Die Erklärung konnte nicht geladen werden.';

  @override
  String get failedToGenerateStoryN =>
      'Fehler beim Generieren der Story:\\n\$e';

  @override
  String get thematic => 'Thematisch';

  @override
  String get deckFlashcards => 'Stapel (Karteikarten)';

  @override
  String get searchLibraryOrTypeCustom =>
      'Bibliothek durchsuchen oder benutzerdefiniert eingeben';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Analyse fehlgeschlagen: \$e';

  @override
  String get extractionFailedE => 'Extraktion fehlgeschlagen: \$e';

  @override
  String get simplifyFailedE => 'Vereinfachung fehlgeschlagen: \$e';

  @override
  String get translationFailedE => 'Übersetzung fehlgeschlagen: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Fehler beim Speichern der extrahierten Wörter: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'Du: $actual  ·  Ziel: $expected';
  }

  @override
  String get improveTheLocalVoice => 'Lokale Stimme verbessern';

  @override
  String get higherQualityOfflineMandarin =>
      'Mandarin in höherer Qualität offline';

  @override
  String get removeDownload => 'Download entfernen?';

  @override
  String get removeDownload2 => 'Download entfernen';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Weiblich, warm';

  @override
  String get voiceFemaleCheerful => 'Weiblich, heiter';

  @override
  String get voiceMaleUpbeat => 'Männlich, dynamisch';

  @override
  String get voiceMaleNewsStyle => 'Männlich, nachrichtenstil';

  @override
  String get voiceMaleSporty => 'Männlich, sportlich';

  @override
  String get voiceOnDeviceTts => 'Sprachsynthese auf dem Gerät';

  @override
  String get voiceSystemVoice => 'Systemstimme';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Sitzungsbewertungen auf Spaced Repetition anwenden (Sprechmodus)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Dieser Abschnitt konnte nicht geladen werden. Bitte versuche es erneut.';

  @override
  String get removeDownloadQuestion => 'Download entfernen?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'Download entfernen';

  @override
  String get removeDownloadButton => 'Download entfernen';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'KI-Zusammenfassung';

  @override
  String get readability => 'Lesbarkeit';

  @override
  String get translateAction => 'Übersetzen';

  @override
  String get checkingDownload => 'Download wird gepr?ft';

  @override
  String downloadingBook(int percent) {
    return 'Download l?uft: $percent %';
  }

  @override
  String get retryDownload => 'Download wiederholen';

  @override
  String get downloadBook => 'Buch herunterladen';

  @override
  String continueChapter(int chapter) {
    return 'Bei Kapitel $chapter weiterlesen';
  }

  @override
  String get downloadBookError =>
      'Dieses Buch konnte nicht heruntergeladen werden. Pr?fe deine Verbindung und versuche es erneut.';

  @override
  String downloadBookOffline(int count) {
    return 'Lade das Buch herunter, um seine $count Kapitel offline zu lesen.';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Gedichte',
      one: '1 Gedicht',
    );
    return '$_temp0';
  }

  @override
  String get americanLiterature => 'Amerikanische Literatur';

  @override
  String get ancientChina => 'Altes China';

  @override
  String get britishLiterature => 'Britische Literatur';

  @override
  String get frenchLiterature => 'Franz?sische Literatur';

  @override
  String get germanLiterature => 'Deutsche Literatur';

  @override
  String get italianLiterature => 'Italienische Literatur';

  @override
  String get jinDynasty => 'Jin-Dynastie';

  @override
  String get preQinEra => 'Vor-Qin-Zeit';

  @override
  String get qingDynasty => 'Qing-Dynastie';

  @override
  String get republicOfChinaEra => 'Republik China';

  @override
  String get russianLiterature => 'Russische Literatur';

  @override
  String get spanishLiterature => 'Spanische Literatur';

  @override
  String get springAndAutumn => 'Zeit der Fr?hlings- und Herbstannalen';

  @override
  String get westernHan => 'Westliche Han-Dynastie';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'z. B. ein lebhaftes Festbankett in Shanghai...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'z. B. ein neugieriger Cousin, der nach deiner Karriere fragt...';

  @override
  String get beginFirstLesson => 'Erste Lektion beginnen';

  @override
  String get exploreLibraryDirectly => 'Bibliothek direkt erkunden';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'DEINE ERSTE LEKTION  •  $current VON $total';
  }

  @override
  String get onboardingListenInstruction =>
      'Höre zuerst eine der berühmtesten Zeilen der chinesischen Literatur. Noch kein Auswendiglernen.';

  @override
  String get onboardingFromGrandLibrary => 'Aus der Großen Bibliothek';

  @override
  String get onboardingArtOfWarTitleAuthor => 'Die Kunst des Krieges · Sunzi';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · Kapitel 3';

  @override
  String get onboardingClassicLineLabel => 'EIN KLASSISCHER VERS';

  @override
  String get onboardingArtOfWarTranslation =>
      '„Kenne den Feind und kenne dich selbst, und du brauchst den Ausgang von hundert Schlachten nicht zu fürchten.“';

  @override
  String get onboardingNoticeMeaning =>
      'Kenne den Feind und kenne dich selbst,';

  @override
  String get onboardingShadowMeaning =>
      'So wirst du in hundert Schlachten nie in Gefahr geraten.';

  @override
  String get onboardingPracticeThisLabel => 'DAS WIRST DU ÜBEN';

  @override
  String get onboardingFromArtOfWarLabel => 'AUS DER KUNST DES KRIEGES';

  @override
  String get onboardingYourPronunciationLabel => 'DEINE AUSSPRACHE';

  @override
  String get onboardingTapACharacter => 'Tippe auf ein Zeichen';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'Übereinstimmung';

  @override
  String get onboardingCompareTones => 'Töne vergleichen';

  @override
  String get onboardingToneOneHigh => '1. Ton · hoch';

  @override
  String get onboardingToneTwoRising => '2. Ton · steigend';

  @override
  String get onboardingToneThreeDipping => '3. Ton · fallend-steigend';

  @override
  String get onboardingToneFourFalling => '4. Ton · fallend';

  @override
  String get onboardingToneNotDetected => 'nicht erkannt';

  @override
  String get onboardingFeedbackGreatThirdTone =>
      'Wunderschön gezogener dritter Ton.';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'Lass den vierten Ton rasch und bestimmt abfallen.';

  @override
  String get onboardingFeedbackClearFourthTone =>
      'Klarer fallender vierter Ton.';

  @override
  String get onboardingFeedbackStrongFourthTone =>
      'Kraftvoller fallender vierter Ton.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return 'Spure $character nach ($pinyin, „$meaning“). Folge der feinen Strichführung.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wochen',
      one: '1 Woche',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Monate',
      one: '1 Monat',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Jahre',
      one: '1 Jahr',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return '$period kostenlose Testphase starten';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return 'Abonnieren für $price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'Dein ausgewähltes Produkt enthält eine kostenlose Testphase. Nach Ablauf der Testphase verlängert es sich automatisch um $price pro $period, sofern es nicht vorher gekündigt wird.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'Lernen';

  @override
  String get booksAndStudioQualityAudiobooks =>
      '86 klassische Bücher und Hörbücher in Studioqualität';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'KI-Konversationen und Live-Ton-Feedback';

  @override
  String get interactiveVideoAndWebImmersion =>
      'Interaktive Videos und Web-Immersion';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'Einblicke in Schriftzeichen und Handschrifttraining';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'HSK-Decks und intelligente Spaced Repetition';

  @override
  String get termsOfUseEula => 'Nutzungsbedingungen (EULA)';

  @override
  String get masterEveryStroke => 'Meistere jeden Strich';

  @override
  String get exploreTheChineseWeb => 'Erkunde das chinesische Web';

  @override
  String get tone1Description =>
      'Halten Sie Ihre Tonhöhe hoch und gleichmäßig, wie beim Singen einer Note.';

  @override
  String get tone2Description =>
      'Beginnen Sie in der Mitte und lassen Sie Ihre Tonhöhe nach oben gleiten, wie beim Fragen \'Was?\'';

  @override
  String get tone3Description =>
      'Senken Sie Ihre Stimme tief, dann steigen Sie sanft wieder an.';

  @override
  String get tone4Description =>
      'Senken Sie Ihre Tonhöhe scharf und entschieden, wie bei einem festen \'Nein!\'';

  @override
  String get toneNeutralDescription =>
      'Sanft, kurz und ohne Betonung aussprechen.';

  @override
  String get toneDiagMatch1 =>
      'Volltreffer! Die Tonhöhe war hoch, flach und stabil.';

  @override
  String get toneDiagMatch2 => 'Volltreffer! Der Tonhöhenanstieg war klar.';

  @override
  String get toneDiagMatch3 =>
      'Volltreffer! Die tiefe, abfallende Kurve war präzise.';

  @override
  String get toneDiagMatch4 =>
      'Volltreffer! Der scharfe Abfall war entscheidend.';

  @override
  String get toneDiagMatchDefault =>
      'Volltreffer! Der Ton wurde präzise ausgesprochen.';

  @override
  String get toneDiag1vs2 =>
      'Du hast deine Tonhöhe angehoben (2. Ton /). Halte deine Stimme über die gesamte Silbe flach und hoch (1. Ton ˉ).';

  @override
  String get toneDiag1vs3 =>
      'Du hast deine Stimme gesenkt (3. Ton ˇ). Halte deine Tonhöhe stabil und hoch, ohne sie zu senken (1. Ton ˉ).';

  @override
  String get toneDiag1vs4 =>
      'Du hast deine Tonhöhe gesenkt (4. Ton \\). Halte eine hohe, gleichmäßige Tonhöhe, wie beim Singen einer Note (1. Ton ˉ).';

  @override
  String get toneDiag2vs1 =>
      'Du bist flach geblieben (1. Ton ˉ). Lass deine Tonhöhe nach oben gleiten, als würdest du \'Was?\' fragen (2. Ton /).';

  @override
  String get toneDiag2vs3 =>
      'Du bist zu tief gesunken (3. Ton ˇ). Beginne auf mittlerem Niveau und steige sanft an, ohne ganz nach unten zu gehen (2. Ton /).';

  @override
  String get toneDiag2vs4 =>
      'Du hast deine Tonhöhe gesenkt (4. Ton \\). Steige nach oben, als würdest du eine Frage stellen (2. Ton /).';

  @override
  String get toneDiag3vs1 =>
      'Du bist hoch und flach geblieben (1. Ton ˉ). Lass deine Tonhöhe tief in dein Brustregister fallen, bevor sie wieder ansteigt (3. Ton ˇ).';

  @override
  String get toneDiag3vs2 =>
      'Du bist sofort angestiegen (2. Ton /). Achte darauf, zuerst tief zu fallen, bevor du wieder aufsteigst (3. Ton ˇ).';

  @override
  String get toneDiag3vs4 =>
      'Du bist scharf gefallen, ohne anzusteigen (4. Ton \\). Lass deine Tonhöhe am Ende sanft wieder nach oben federn (3. Ton ˇ).';

  @override
  String get toneDiag4vs1 =>
      'Du bist flach geblieben (1. Ton ˉ). Lass deine Tonhöhe scharf und entschieden fallen, wie ein festes \'Nein!\' (4. Ton \\).';

  @override
  String get toneDiag4vs2 =>
      'Du hast deine Tonhöhe angehoben (2. Ton /). Beginne hoch und falle scharf nach unten (4. Ton \\).';

  @override
  String get toneDiag4vs3 =>
      'Du bist gesunken und wieder gestiegen (3. Ton ˇ). Fällt direkt nach unten, ohne wieder anzusteigen (4. Ton \\).';

  @override
  String get toneDiagListenDiff =>
      'Höre dir die 4 Töne unten an, um den Unterschied zu hören.';

  @override
  String get liveCallSpeaking => 'Spricht...';

  @override
  String get toneAccurate => 'Ton korrekt';

  @override
  String get toneNeedsWork => 'Ton verbesserungswürdig';

  @override
  String get liveCallSessionCompletedFallback =>
      'Sitzung abgeschlossen. Sprechen Sie bei der nächsten Übung ganze Sätze, um detaillierte Aussprache- und Tondiagnosen zu erhalten.';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return 'Guter Einstieg mit der Übung von „$word“. Versuche bei der nächsten Sitzung, ganze Sätze aneinanderzureihen, um Tonübergänge und natürlichen Redefluss zu üben.';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'Guter Gesprächseinsatz. Achte darauf, den 1. Ton hoch und gleichmäßig (55) und den 4. Ton scharf und fallend (51) zu halten, um die Klarheit zu verbessern.';

  @override
  String get liveCallGoodPracticeFallback =>
      'Gute Übungseinheit. Achte weiterhin auf klare Tonkontraste und ein natürliches Gesprächstempo.';

  @override
  String sentenceNumber(Object number) {
    return 'Satz $number';
  }

  @override
  String endlessAiStreamSentence(Object count) {
    return 'Endloser KI-Stream • Satz $count';
  }

  @override
  String get aiConsentTitle => 'KI-Übungen & Datenschutz';

  @override
  String get aiConsentSubtitle =>
      'SinoSpark nutzt sichere KI-Dienste von Drittanbietern für Aussprachebewertung, Dialog-Rollenspiele und Lernwerkzeuge.';

  @override
  String get aiConsentDataSentTitle => 'Übertragene Daten';

  @override
  String get aiConsentDataSentBody =>
      'Sprachaufnahmen, gesprochene Transkripte und Textanfragen.';

  @override
  String get aiConsentProvidersTitle => 'KI-Dienste von Drittanbietern';

  @override
  String get aiConsentProvidersBody =>
      '• Microsoft Azure AI Speech (Aussprachebewertung & Sprachsynthese)\n• Google Gemini & DeepSeek (Konversationsdialoge & Deck-Generierung)';

  @override
  String get aiConsentGuaranteesTitle => 'Datenschutzgarantien';

  @override
  String get aiConsentGuaranteesBody =>
      'Ihre Daten werden während der Übertragung verschlüsselt, flüchtig verarbeitet, niemals verkauft und niemals zum Trainieren öffentlicher KI-Modelle verwendet.';

  @override
  String get aiConsentAgree => 'KI zustimmen & verwenden';

  @override
  String get aiConsentLearnMore => 'Mehr erfahren';

  @override
  String get viewPlans => 'Pläne ansehen';

  @override
  String get authInvalidCredentials =>
      'Falsche E-Mail oder falsches Passwort. Wenn Sie noch kein Konto haben, registrieren Sie sich bitte.';

  @override
  String get authInvalidEmail =>
      'Bitte geben Sie eine gültige E-Mail-Adresse ein.';

  @override
  String get authEmailAlreadyInUse =>
      'Ein Konto mit dieser E-Mail-Adresse existiert bereits.';

  @override
  String get authWeakPassword =>
      'Das Passwort muss mindestens 6 Zeichen lang sein.';

  @override
  String get authTooManyRequests =>
      'Zu viele fehlgeschlagene Versuche. Bitte versuchen Sie es später erneut.';

  @override
  String get authNetworkError =>
      'Netzwerkfehler. Bitte überprüfen Sie Ihre Verbindung.';

  @override
  String get subscriptionRequired => 'Abonnement erforderlich';

  @override
  String get subscriptionRequiredDesc =>
      'Ein aktives SinoSpark-Abonnement ist erforderlich, um auf alle Lektionen, Bücher und KI-Sprachwerkzeuge zuzugreifen.';

  @override
  String signedInAs(String email) {
    return 'Angemeldet als $email';
  }

  @override
  String get battle => 'Schlacht';

  @override
  String addedWordsAndUpdatedWords(
      int addedCount, int updatedCount, String deckName) {
    return '$addedCount neue Wörter hinzugefügt, $updatedCount bestehende Wörter in „$deckName“ aktualisiert';
  }

  @override
  String addedWordsToDeck(int count, String deckName) {
    return '$count Wörter zu „$deckName“ hinzugefügt';
  }

  @override
  String updatedWordsInDeck(int count, String deckName) {
    return '$count bestehende Wörter in „$deckName“ aktualisiert';
  }

  @override
  String addedCardToDeck(String hanzi, String deckName) {
    return '„$hanzi“ wurde zu „$deckName“ hinzugefügt';
  }

  @override
  String get callCategory => 'LIVE-ANRUF';

  @override
  String get aiCallFluencyTitle => 'KI-Anrufe für mehr Sprachgewandtheit';

  @override
  String get aiCallFluencyDesc =>
      'Führe realistische Sprachgespräche mit KI-Tutoren, erhalte sofortige Tonbewertungen und verbessere deine Sprechfertigkeit.';

  @override
  String get decksCategory => 'KARTENDECKS';

  @override
  String get decksSpacedRepetitionTitle =>
      'Decks mit automatischer Wiederholung';

  @override
  String get decksSpacedRepetitionDesc =>
      'Meistere HSK 1–6 und eigene Decks mit wissenschaftlich fundierten Algorithmen zur verteilten Wiederholung.';

  @override
  String get booksCategory => 'BÜCHER';

  @override
  String get classicalBooksPoemsTitle =>
      '86 klassische Bücher und 100 Gedichte';

  @override
  String get classicalBooksPoemsDesc =>
      'Tauche ein in zeitlose Literatur und Poesie mit synchronisiertem Audio und zweisprachigen Anmerkungen.';

  @override
  String get scanCategory => 'SCANNER';

  @override
  String get scannerScanCardsTitle =>
      'Bilder scannen und Karten zum Deck hinzufügen';

  @override
  String get scannerScanCardsDesc =>
      'Richte deine Kamera auf chinesische Texte, Speisekarten oder Schilder, um Wörter sofort zu erfassen und in deinen Decks zu speichern.';

  @override
  String get smartDictionaryStrokeOrderTitle =>
      'Intelligentes Wörterbuch mit Strichfolge';

  @override
  String get liveAiVoiceCallsAndToneGrading =>
      'Live-KI-Sprachanrufe und sofortige Tonbewertung';

  @override
  String get shadowingStudioAndToneAnalysis =>
      'Shadowing-Studio und visuelle Tonhöhenanalyse';

  @override
  String get startMy7DaysFreeTrial => 'Meine 7 kostenlosen Tage starten';

  @override
  String trialSubtextUnderCta(String price, String period) {
    return 'Danach $price / $period. Jederzeit in den Einstellungen kündbar.';
  }

  @override
  String get deckLibraryTitle => 'Deck-Bibliothek';

  @override
  String get deckLibrarySubtitle =>
      'Kuratierte Sammlungen zu HSK, Kultur, Sport und Wissenschaft';

  @override
  String get downloadOfficialDecks =>
      'Offizielle HSK- und Themen-Decks herunterladen';

  @override
  String wordsSelectedCount(int selected, int total) {
    return '$selected von $total Wörtern ausgewählt';
  }

  @override
  String get comparisonLabel => 'VERGLEICH';

  @override
  String get ambientSoundscape => 'Klanglandschaft';

  @override
  String get ambientSoundscapeDesc =>
      'Beruhigende Hintergrundatmosphäre zum Lesen & Hören';

  @override
  String get ambientSoundscapeOff => 'Aus (Lautlos)';

  @override
  String get soundscapeCourtyardRain => 'Hofregen';

  @override
  String get soundscapeGuqinWind => 'Guqin & Bambuswind';

  @override
  String get soundscapeMidnightZen => 'Mitternachts-Zen';

  @override
  String get ambientVolume => 'Hintergrundlautstärke';

  @override
  String get rateSinoSpark => 'SinoSpark bewerten';

  @override
  String get rateSinoSparkDesc => 'Teilen Sie Ihre Meinung im App Store';

  @override
  String get sendFeedback => 'Feedback senden';

  @override
  String get sendFeedbackDesc =>
      'Helfen Sie uns, besser zu werden oder melden Sie einen Fehler';

  @override
  String get enjoyingAppTitle => 'Gefällt Ihnen SinoSpark?';

  @override
  String get enjoyingAppSubtitle =>
      'Wie gefällt Ihnen Ihre Chinesisch-Lernreise bisher?';

  @override
  String get ratingLovingIt => 'Ja, ich liebe es!';

  @override
  String get ratingCouldBeBetter => 'Könnte besser sein';

  @override
  String get dictionarySearchFailed =>
      'Die Wörterbuchsuche ist fehlgeschlagen. Bitte erneut versuchen.';

  @override
  String get tapToHearVoiceSample => 'Tippe auf ▶ für eine Hörprobe';

  @override
  String get soundEffects => 'Soundeffekte';

  @override
  String get soundEffectsDesc =>
      'Sanftes Papier, Holzsiegel und Kalligrafie-Klänge';

  @override
  String get generatingYourScenario => 'Dein Szenario wird erstellt…';

  @override
  String get failedToGenerateScenario =>
      'Wir konnten dieses Szenario nicht erstellen. Bitte versuche es erneut.';

  @override
  String get trickyCharacters => 'Knifflige Zeichen';

  @override
  String get strongestCharacters => 'Sicherste Zeichen';

  @override
  String get newThisWeek => 'Neu in den letzten 7 Tagen';

  @override
  String get averageAttemptsPerWord => 'Durchschnittliche Versuche pro Wort';

  @override
  String get noCardsYet => 'Noch keine Karten in diesem Deck';
}
