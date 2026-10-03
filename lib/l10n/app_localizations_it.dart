// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get originStoryChip => '📜 Storia dell\'origine';

  @override
  String get ancientFormChip => '🏺 Forma antica';

  @override
  String get threeMoreWordsChip => '📖 Altre 3 parole';

  @override
  String get wordFamilyChip => '🔗 Famiglia di parole';

  @override
  String get idiomChip => '🀄 Modo di dire';

  @override
  String get proverbChip => '💬 Proverbio';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'Esiste un\'espressione idiomatica cinese (成语) che contiene questo carattere?';

  @override
  String get strokeOrderChip => '✏️ Ordine dei tratti';

  @override
  String get calligraphyTipChip => '🎨 Consiglio calligrafico';

  @override
  String get grammarNoteChip => '📝 Nota grammaticale';

  @override
  String get similarWordsChip => '🔄 Parole simili';

  @override
  String get culturalNoteChip => '🏮 Nota culturale';

  @override
  String get inMediaChip => '🀄 Nei media';

  @override
  String get radicalMeaningChip => '🧩 Significato del radicale';

  @override
  String get componentBreakdownChip => '🔍 Analisi dei componenti';

  @override
  String get toneTipChip => '🎵 Consiglio sul tono';

  @override
  String get homophonesChip => '👯 Omofoni';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Chiedimi qualsiasi cosa su $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'Errore del tutor AI: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'Il tutor AI è occupato al momento. Attendi un istante e riprova.';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountSubtitle => 'Elimina definitivamente il tuo account';

  @override
  String get deleteAccountTitle => 'Eliminare definitivamente il tuo account?';

  @override
  String get accountDataDeletedTitle =>
      'I dati dell\'account verranno eliminati';

  @override
  String get accountDataDeletedBody =>
      'Il tuo account di accesso e le informazioni sull\'account conservate da SinoSpark verranno eliminate definitivamente. Questa azione non può essere annullata.';

  @override
  String get localDataKeptTitle => 'I dati su questo dispositivo rimarranno';

  @override
  String get localDataKeptBody =>
      'I progressi di studio, i contenuti scaricati e le preferenze salvate solo su questo dispositivo non verranno rimossi.';

  @override
  String get subscriptionNotCanceledTitle =>
      'Gli abbonamenti non vengono annullati';

  @override
  String get subscriptionNotCanceledBody =>
      'L\'eliminazione dell\'account non annulla l\'abbonamento su App Store. Potrebbe continuare a rinnovarsi finché non lo annulli con Apple.';

  @override
  String get manageSubscription => 'Gestisci abbonamento App Store';

  @override
  String get subscriptionManagementFailed =>
      'Impossibile aprire la gestione degli abbonamenti Apple. Apri Impostazioni, tocca il tuo nome, quindi tocca Abbonamenti.';

  @override
  String get confirmPassword => 'Password attuale';

  @override
  String get confirmPasswordToDelete =>
      'Inserisci la tua password per confermare la tua identità.';

  @override
  String get deleteAccountPermanently => 'Elimina account definitivamente';

  @override
  String get deleteAccountFinalTitle => 'Conferma finale';

  @override
  String get deleteAccountFinalWarning =>
      'Questo eliminerà definitivamente il tuo account e l\'azione non può essere annullata. I dati salvati solo su questo dispositivo rimarranno. Vuoi continuare?';

  @override
  String get deletingAccount => 'Eliminazione account in corso...';

  @override
  String get accountPasswordRequired =>
      'Inserisci la tua password attuale per continuare.';

  @override
  String get accountPasswordIncorrect => 'La password non è corretta. Riprova.';

  @override
  String get accountReauthenticationCanceled =>
      'La conferma dell\'identità è stata annullata. Il tuo account non è stato eliminato.';

  @override
  String get accountReauthenticationFailed =>
      'Impossibile confermare la tua identità. Riprova e completa la procedura di accesso.';

  @override
  String get accountAlreadySignedOut =>
      'Hai già effettuato la disconnessione. Nessun account connesso è stato eliminato.';

  @override
  String get accountProviderUnsupported =>
      'Questo metodo di accesso non può essere verificato nell\'app. Contatta l\'assistenza per ricevere aiuto nell\'eliminazione dell\'account.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'Per motivi di sicurezza, un account collegato ad Apple deve essere eliminato su un dispositivo Apple.';

  @override
  String get accountDeletionNetworkError =>
      'Verifica la tua connessione Internet e prova a eliminare nuovamente l\'account.';

  @override
  String get accountDeletionFailed =>
      'Impossibile eliminare l\'account. Il tuo account rimane attivo. Riprova.';

  @override
  String get accountDeletedSuccessfully =>
      'Il tuo account è stato eliminato definitivamente.';

  @override
  String get globalMastery => 'PADRONANZA GLOBALE';

  @override
  String get masteredCards => 'Padroneggiate';

  @override
  String get hsk1Candidate => 'Candidato HSK 1';

  @override
  String get hsk2Candidate => 'Candidato HSK 2';

  @override
  String get hsk3Candidate => 'Candidato HSK 3';

  @override
  String get hsk4Candidate => 'Candidato HSK 4';

  @override
  String get hsk5Candidate => 'Candidato HSK 5';

  @override
  String get hsk6Candidate => 'Candidato HSK 6';

  @override
  String get hsk6Master => 'Maestro HSK 6';

  @override
  String get currentRank => 'RANGO ATTUALE';

  @override
  String get next => 'Avanti';

  @override
  String get searchHanziOrPinyin => 'Cerca Hanzi o Pinyin...';

  @override
  String get dailyReview => 'Ripasso quotidiano';

  @override
  String get upcomingForecast => 'Previsioni';

  @override
  String get laterToday => 'Più tardi';

  @override
  String get tomorrow => 'Domani';

  @override
  String get next7Days => 'Prossimi 7 giorni';

  @override
  String get theScholarWay => 'La Via dello Studioso';

  @override
  String get beginJourney => 'Inizia';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get darkModeDesc => 'Rilassante per gli occhi';

  @override
  String get voiceSpeed => 'Velocità voce';

  @override
  String get artAndIntellect => 'ARTE E INTELLETTO';

  @override
  String get theDigitalScholar => 'Lo Studioso Digitale';

  @override
  String get refineBrushVoice =>
      'Perfeziona il tuo pennello e la tua voce con l\'IA.';

  @override
  String get liveVoiceCall => 'Chiamata vocale dal vivo';

  @override
  String get immersiveRoleplay => 'Gioco di ruolo immersivo con avatar IA';

  @override
  String get readingRoom => 'Sala di lettura';

  @override
  String get shadowingStudio => 'Studio di Shadowing';

  @override
  String get errorPrefix => 'Errore: ';

  @override
  String get initializingLibrary => 'Inizializzazione libreria in corso...';

  @override
  String get unlockCharactersToQuiz => 'Sblocca 4 caratteri per un quiz!';

  @override
  String get practiceQuiz => 'QUIZ';

  @override
  String get curriculumPaths => 'PERCORSI DI STUDIO';

  @override
  String get noDecksFound => 'Nessun mazzo trovato. Aggiungine qualcuno!';

  @override
  String get addCardsFirst => 'Aggiungi prima delle carte!';

  @override
  String get aiDraftingPath => 'L\'IA sta preparando il tuo percorso...';

  @override
  String get pathReady => 'Percorso pronto!';

  @override
  String get errorGeneratingPath => 'Errore nella generazione del percorso';

  @override
  String get brushingCurriculum => 'Creazione del percorso in corso...';

  @override
  String get warmUp => 'RISCALDAMENTO';

  @override
  String get lessonComplete => 'Lezione completata! +10 Punti Inchiostro';

  @override
  String get step1Origin => 'FASE 1: L\'ORIGINE';

  @override
  String get traceRadical => 'Traccia il radicale';

  @override
  String get step2Forge => 'FASE 2: LA FORGIA';

  @override
  String get chooseEssence => 'Scegli l\'essenza';

  @override
  String get wrongEssence => 'Sbagliato! Riprova.';

  @override
  String get step3Hunt => 'FASE 3: LA CACCIA';

  @override
  String get findCharacters => 'Trova i caratteri';

  @override
  String get notThatOne => 'Non questo!';

  @override
  String get successfullyInstalled => 'Installato con successo:';

  @override
  String get failedToDownload => 'Download fallito.';

  @override
  String get rescindTitle => 'Revocare?';

  @override
  String get removeCharactersWarning => 'Questo rimuoverà questi caratteri.';

  @override
  String get cancel => 'Annulla';

  @override
  String get uninstall => 'Disinstalla';

  @override
  String get removedLibrary => 'Rimosso:';

  @override
  String get tomeLibrary => 'Biblioteca dei tomi';

  @override
  String get libraryError => 'Errore biblioteca';

  @override
  String get installTome => 'INSTALLA';

  @override
  String get unitIntro => 'INTRO UNITÀ';

  @override
  String get constellationCluster => 'Ammasso di costellazioni';

  @override
  String get ok => 'OK';

  @override
  String get divingInto => 'Immersione in corso...';

  @override
  String get keyRadicals => 'RADICALI CHIAVE';

  @override
  String get noRadicalData => 'Nessun dato disponibile.';

  @override
  String get discovery => 'SCOPERTA';

  @override
  String get startLearning => 'INIZIA A IMPARARE';

  @override
  String get selectPersona => 'Scegli personaggio';

  @override
  String get customPersona => 'Personaggio personalizzato';

  @override
  String get geminiLiveCall => 'CHIAMATA DAL VIVO';

  @override
  String get returnToMenu => 'Torna al menu';

  @override
  String get strokeAnalysis => 'Analisi dell\'ordine dei tratti';

  @override
  String get excellentWork => 'Ottimo lavoro!';

  @override
  String get keepPracticing => 'Continua a esercitarti!';

  @override
  String get drawingSubmitted => 'Disegno inviato';

  @override
  String get customPersonaHint => 'Definisci un personaggio personalizzato...';

  @override
  String get stepOneOrigin => 'FASE 1: L\'ORIGINE';

  @override
  String get stepTwoForge => 'FASE 2: LA FORGIA';

  @override
  String get toForge => 'Per forgiare';

  @override
  String get whatEssenceDoesNeed => 'di quale essenza ha bisogno';

  @override
  String get need => 'necessita';

  @override
  String get forged => 'FORGIATO';

  @override
  String get stepThreeHunt => 'FASE 3: LA CACCIA';

  @override
  String get findCharactersWith => 'Trova i caratteri con';

  @override
  String get uninstallButton => 'DISINSTALLA';

  @override
  String get gradedAiStories => 'Storie graduate IA';

  @override
  String get calligraphy => 'Calligrafia';

  @override
  String get theScrollOfOrigin => 'La Pergamena dell\'Origine';

  @override
  String get galaxyOf => 'Galassia di';

  @override
  String get constellationDescription => 'Descrizione della costellazione';

  @override
  String get noRadicalDataAvailable => 'Nessun dato sui radicali disponibile';

  @override
  String get learningPreferences => 'Preferenze di apprendimento';

  @override
  String get hardMode => 'Modalità difficile';

  @override
  String get hardModeDesc => 'Richiede tratti precisi senza guide visive.';

  @override
  String get adaptiveGuidance => 'Guida adattiva';

  @override
  String get dailyGoal => 'Obiettivo giornaliero';

  @override
  String get audioAndHaptics => 'Audio e feedback aptico';

  @override
  String get autoPlayAudio => 'Riproduzione audio automatica';

  @override
  String get autoPlayDesc =>
      'Riproduce automaticamente la pronuncia quando la carta viene mostrata.';

  @override
  String get haptics => 'Feedback aptico';

  @override
  String get displayAndContent => 'Schermo e contenuti';

  @override
  String get useEnglishDefinitions => 'Usa definizioni in inglese';

  @override
  String get useEnglishDefinitionsDesc =>
      'Le definizioni in inglese sono generalmente più accurate e dettagliate';

  @override
  String get animationSpeed => 'Velocità animazione';

  @override
  String get manageTomes => 'Gestisci tomi';

  @override
  String get manageTomesDesc => 'Gestisci i tomi di studio installati.';

  @override
  String get dangerZone => 'Zona di pericolo';

  @override
  String get resetAllData => 'Reimposta tutti i dati';

  @override
  String get resetDataDesc =>
      'Questo eliminerà definitivamente tutti i tuoi progressi, le statistiche e le impostazioni. Questa azione non può essere annullata.';

  @override
  String get areYouSure => 'Sei sicuro?';

  @override
  String get cannotBeUndone => 'Non può essere annullato';

  @override
  String get deleteEverything => 'Elimina tutto';

  @override
  String get appLanguage => 'Lingua dell\'app';

  @override
  String get howDidYouDo => 'Come ti è andata?';

  @override
  String get missedItEntirely => 'Dimenticato completamente';

  @override
  String get gotItButStruggled => 'Ricordato con difficoltà';

  @override
  String get gotItClearly => 'Ricordato chiaramente';

  @override
  String get perfectAndImmediate => 'Perfetto e immediato';

  @override
  String get again => 'Di nuovo';

  @override
  String get hard => 'Difficile';

  @override
  String get good => 'Bene';

  @override
  String get easy => 'Facile';

  @override
  String get tapToReveal => 'Tocca per rivelare';

  @override
  String get howWellDidYouRemember => 'Quanto bene hai ricordato?';

  @override
  String get completelyForgot => 'Dimenticato completamente';

  @override
  String get gotItWithDifficulty => 'Ricordato con difficoltà';

  @override
  String get recalledCorrectly => 'Ricordato correttamente';

  @override
  String get perfectRecall => 'Ricordo perfetto';

  @override
  String get practiceWriting => 'Esercitati a scrivere';

  @override
  String get hideScratchpad => 'Nascondi blocco per appunti';

  @override
  String get whatCharacterMeans => 'Significato del carattere:';

  @override
  String get tapCardToReveal => 'Tocca la carta per rivelare';

  @override
  String get ratePronunciationConfidence =>
      'Valuta la tua sicurezza nella pronuncia';

  @override
  String get botchedIt => 'Poco accurato';

  @override
  String get struggledWithTones => 'Ho faticato con i toni';

  @override
  String get acceptable => 'Accettabile';

  @override
  String get perfectlyNatural => 'Perfettamente naturale';

  @override
  String get sessionComplete => 'Sessione completata!';

  @override
  String get accuracy => 'Precisione';

  @override
  String get reviewed => 'Ripassati';

  @override
  String get correct => 'Corretto';

  @override
  String get backToLibrary => 'Torna alla biblioteca';

  @override
  String get revealAnswer => 'Rivela risposta';

  @override
  String get aiHubTitle => 'Hub IA';

  @override
  String get textChat => 'Chat di testo';

  @override
  String get scholarlyPersonas => 'Personaggi eruditi';

  @override
  String get shadowing => 'Shadowing';

  @override
  String get liveTranslation => 'Traduzione dal vivo';

  @override
  String get scholarsLibrary => 'La Biblioteca dell\'Erudito';

  @override
  String get generate => 'Genera';

  @override
  String get searchPinyinHanziEnglish => 'Cerca Pinyin, Hanzi o significato...';

  @override
  String get liveTranslate => 'Traduci dal vivo';

  @override
  String get travelInterpreter => 'Interprete di viaggio';

  @override
  String get realTimeSplitScreen =>
      'Conversazione a schermo diviso in tempo reale con un madrelingua per superare subito ogni barriera linguistica.';

  @override
  String get whisperEarpiece => 'Auricolare Whisper';

  @override
  String get listenToChineseAudio =>
      'Ascolta l\'audio in cinese e ottieni sottotitoli in italiano in tempo reale direttamente sul tuo schermo.';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get yourMindIsClear => 'La tua mente è lucida e pronta.';

  @override
  String get noReviewsDueToday => 'Nessun ripasso programmato per oggi.';

  @override
  String get done => 'Fatto';

  @override
  String get hskLevel1 => 'Livello HSK 1';

  @override
  String get hskLevel2 => 'Livello HSK 2';

  @override
  String get hskLevel3 => 'Livello HSK 3';

  @override
  String get hskLevel4 => 'Livello HSK 4';

  @override
  String get hskLevel5 => 'Livello HSK 5';

  @override
  String get hskLevel6 => 'Livello HSK 6';

  @override
  String get generalVocabulary => 'Vocabolario generale';

  @override
  String cardsRequireAttention(Object count) {
    return '$count carte richiedono attenzione.';
  }

  @override
  String get begin => 'Inizia';

  @override
  String get poweredByAi =>
      'Alimentato da IA avanzata per una traduzione fluida in tempo reale in ogni situazione.';

  @override
  String get downloadingModel => 'Download del modello in corso...';

  @override
  String get soon => 'PROSSIMAMENTE';

  @override
  String get installed => 'INSTALLATO';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'MODULO PRINCIPALE';

  @override
  String get step6Context => 'FASE 6: CONTESTO';

  @override
  String get tapBuildingBlocksTo =>
      'Tocca i componenti costitutivi per esplorarne l\'origine.';

  @override
  String get initiateRadicalSequence => 'AVVIA SEQUENZA DEI RADICALI';

  @override
  String get holdToTalk => 'Tieni premuto per parlare';

  @override
  String get customScenario => 'Scenario personalizzato';

  @override
  String get voiceCall => 'Chiamata vocale';

  @override
  String get pronunciation => 'Pronuncia';

  @override
  String get selectAScenarioTo =>
      'Seleziona uno scenario per esercitare il tuo cinese parlato. L\'Erudito valuterà i tuoi toni e la tua chiarezza.';

  @override
  String get create => 'Crea';

  @override
  String get createYourScenario => 'Crea il tuo scenario';

  @override
  String get difficulty => 'Difficoltà';

  @override
  String get scholarsVerdict => 'VERDETTO DELL\'ERUDITO';

  @override
  String get completeReview => 'Ripasso completo';

  @override
  String get conversationReview => 'REVISIONE DELLA CONVERSAZIONE';

  @override
  String get linguisticAnalysis => 'Analisi linguistica';

  @override
  String get examplesInHsk1 => 'ESEMPI IN HSK 1';

  @override
  String get characterReference => 'Riferimento del carattere';

  @override
  String get askTutor => 'Chiedi al tutor';

  @override
  String get addToStudyDeck => 'Aggiungi al mazzo di studio';

  @override
  String get startPractice => 'INIZIA LA PRATICA';

  @override
  String get noOtherHsk1 =>
      'Nessun altro carattere HSK 1 utilizza questo radicale.';

  @override
  String get couldNotLoadAi =>
      'Impossibile caricare il contesto IA (limite di richieste o errore di rete).\nTocca il pulsante di aggiornamento in basso per riprovare più tardi.';

  @override
  String get noAvailableCardsFound => 'Nessuna carta disponibile trovata.';

  @override
  String get addCards => 'Aggiungi carte';

  @override
  String get removeCard => 'Rimuovi carta';

  @override
  String get remove => 'Rimuovi';

  @override
  String get review => 'Ripassa';

  @override
  String get story => 'Storia';

  @override
  String get thisDeckIsEmpty => 'Questo mazzo è vuoto.';

  @override
  String get tapTheAddCards => 'Tocca il pulsante «Aggiungi carte»!';

  @override
  String get noCardsFound => 'Nessuna carta trovata.';

  @override
  String get addCardsToSee => 'Aggiungi carte per visualizzare le statistiche.';

  @override
  String get aiGenerated => 'Generato da IA';

  @override
  String get allCardsCaughtUp =>
      'Tutte le carte sono state ripassate! Ottimo lavoro.';

  @override
  String get latestDiscoveries => 'Ultime scoperte';

  @override
  String get noCharactersInLexicon =>
      'Nessun carattere presente nel lessico al momento.';

  @override
  String get yourBookshelf => 'La tua libreria';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Cerca nel tuo dizionario...';

  @override
  String get saveCard => 'Salva carta';

  @override
  String get noCharactersFound => 'Nessun carattere trovato.';

  @override
  String get radicalsIndex => 'Indice dei radicali';

  @override
  String get masteringRadicalsIsThe =>
      'Padroneggiare i radicali è la chiave per sbloccare migliaia di Hanzi. Seleziona un radicale per vedere tutti i caratteri correlati.';

  @override
  String get noRadicalsFound => 'Nessun radicale trovato.';

  @override
  String get yourDrawing => 'Il tuo tratto';

  @override
  String get reference => 'Riferimento';

  @override
  String get rateYourRecall => 'Valuta la tua capacità di ricordo';

  @override
  String get contactUs => 'Contattaci';

  @override
  String get reportBugsOrRequest => 'Segnala errori o richiedi funzionalità';

  @override
  String get allDataHasBeen => 'Tutti i dati sono stati cancellati.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'I miei progressi';

  @override
  String get overview => 'Panoramica';

  @override
  String get aiStory => 'Storia IA';

  @override
  String get usingYourDecksVocabulary => 'Con il vocabolario del tuo mazzo';

  @override
  String get tryAgain => 'Riprova';

  @override
  String get translate => 'Traduci';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Traduzione completa';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash sta strutturando la tua storia...';

  @override
  String get aiDeckGenerator => 'Generatore di mazzi IA';

  @override
  String get whatDoYouWant => 'Cosa desideri imparare?';

  @override
  String get targetDifficulty => 'Difficoltà desiderata';

  @override
  String get focusArea => 'Area tematica';

  @override
  String get specificContextOrTone => 'Contesto o tono specifico (opzionale)';

  @override
  String get numberOfCards => 'Numero di carte';

  @override
  String get generateDeck => 'Genera mazzo';

  @override
  String get aiGrammarExplanation => 'Spiegazione grammaticale IA';

  @override
  String get scholarsDesk => 'Scrittoio dell\'Erudito';

  @override
  String get chooseADeck => 'Scegli un mazzo';

  @override
  String get whereWouldYouLike => 'Dove vorresti salvare questo carattere?';

  @override
  String whereWouldYouLikeWords(int count) {
    return 'Dove vuoi salvare queste $count parole?';
  }

  @override
  String deckItemsCount(int count) {
    return '$count elementi';
  }

  @override
  String get addToDefaultStudy => 'Aggiungi al mazzo di studio predefinito';

  @override
  String get ifOffItsOnly =>
      'Se disattivato, verrà salvato solo nel dizionario globale';

  @override
  String get saveToLibrary => 'Salva nella biblioteca';

  @override
  String get pleaseEnterValidChinese => 'Inserisci caratteri cinesi validi';

  @override
  String get reviewAiCard => 'Revisiona carta IA';

  @override
  String get pleaseDoublecheckTheAis =>
      'Controlla l\'output dell\'IA di seguito. Puoi modificare il pinyin o la definizione prima di salvare nella tua biblioteca permanente.';

  @override
  String get alreadyInYourLibrary => 'Già presente nella tua biblioteca!';

  @override
  String get meaningInContext => 'Significato nel contesto';

  @override
  String get explainGrammar => 'Spiega grammatica';

  @override
  String get addToLibrary => 'Aggiungi alla biblioteca';

  @override
  String get masterYourMandarinPronunciation =>
      'Perfeziona la tua pronuncia in mandarino imitando i madrelingua in tempo reale.';

  @override
  String get startSession => 'INIZIA SESSIONE';

  @override
  String get sessionHistory => 'Cronologia sessioni';

  @override
  String get noSavedSessions => 'Nessuna sessione salvata.';

  @override
  String get aiBreakdown => 'Analisi IA';

  @override
  String get sessionDetails => 'Dettagli della sessione';

  @override
  String partner(Object lang) {
    return 'Interlocutore ($lang)';
  }

  @override
  String get youEnglish => 'Tu (Italiano)';

  @override
  String get noTranscriptToSave => 'Nessuna trascrizione da salvare!';

  @override
  String get sessionSaved => 'Sessione salvata!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Traduzione bidirezionale in tempo reale. Parla in italiano o mandarino e verrà tradotto all\'istante per te e il tuo interlocutore.';

  @override
  String get text_1782026184665 => 'Registrazione';

  @override
  String get recording => 'Registrazione in corso';

  @override
  String get yourSilentCompanionListen =>
      'Il tuo assistente discreto. Ascolta il mandarino e ricevi la traduzione in tempo reale.';

  @override
  String get startListening => 'INIZIA AD ASCOLTARE';

  @override
  String get skip => 'Salta';

  @override
  String get independentStars => 'STELLE INDIPENDENTI';

  @override
  String get notEveryCharacterHas =>
      'Non tutti i caratteri derivano da un radicale padre. Alcuni sono pittogrammi unici o autonomi.';

  @override
  String get onTheMapWe =>
      'Sulla mappa, raggruppiamo questi caratteri indipendenti in COSTELLAZIONI (✨).';

  @override
  String get iUnderstand => 'HO CAPITO';

  @override
  String get whatAreRadicals => 'COSA SONO I RADICALI?';

  @override
  String get hanziAreBuiltFrom =>
      'Gli Hanzi sono composti da elementi fondamentali chiamati RADICALI.\n\nEssi attribuiscono al carattere il suo significato o tema principale.';

  @override
  String get continueText => 'CONTINUA';

  @override
  String get hanziAreNotJust =>
      'Gli Hanzi non sono semplici lettere, ma immagini impresse nel tempo.\n\nPer padroneggiarli, devi imparare a seguire il flusso dei loro tratti.';

  @override
  String get iAmReady => 'SONO PRONTO';

  @override
  String get youAreAScholar => 'SEI UN ERUDITO';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'La Mappa della Galassia ti attende.\nPadroneggia i Soli (Radicali) per sbloccare i Pianeti (Caratteri).';

  @override
  String get enterTheScroll => 'APRI LA PERGAMENA';

  @override
  String get openingTheOriginScroll =>
      'Apertura della Pergamena dell\'Origine in corso...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Edizione dell\'Erudito';

  @override
  String get weArePreparingThe =>
      'Stiamo preparando il lancio dell\'Edizione dell\'Erudito.';

  @override
  String get devBypassUnlockNow => 'BYPASS SVILUPPATORE: SBLOCCA ORA';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get welcomeScholarTheScroll =>
      'Benvenuto, Erudito. La pergamena è completamente a tua disposizione.';

  @override
  String get purchasesRestoredSuccessfully =>
      'Acquisti ripristinati con successo.';

  @override
  String get noPreviousPurchasesFound =>
      'Nessun acquisto precedente trovato per questo account.';

  @override
  String get unlockTheFullPotential =>
      'Sblocca il pieno potenziale del tuo percorso di studio. Acquisto unico, tuo per sempre.';

  @override
  String get universalScanner => 'Scanner universale';

  @override
  String get noChineseCharactersFound =>
      'Nessun carattere cinese trovato nell\'immagine.';

  @override
  String get addedNewCharactersTo =>
      'Nuovi caratteri aggiunti alla tua biblioteca!';

  @override
  String get extractingTextAndObjects =>
      'Estrazione di testo e oggetti in corso...';

  @override
  String get scanATextbookSign =>
      'Scansiona un libro di testo, un\'insegna o un oggetto per estrarre caratteri cinesi.';

  @override
  String get extractedText => 'Testo estratto';

  @override
  String get useText => 'Usa testo';

  @override
  String get noMatchingDictionaryEntries =>
      'Nessuna voce corrispondente trovata nel dizionario.';

  @override
  String get quizComplete => 'Quiz completato!';

  @override
  String get returnToCourse => 'Torna al corso';

  @override
  String get notEnoughCardsFor =>
      'Carte insufficienti per un quiz! Ne servono almeno 4.';

  @override
  String get creatorMode => 'Modalità creatore';

  @override
  String get noStoriesFoundMatching =>
      'Nessuna storia trovata corrispondente alla ricerca.';

  @override
  String get discard => 'Scarta';

  @override
  String get save => 'Salva';

  @override
  String get generatingStoryViaDeepseek =>
      'Generazione della storia tramite DeepSeek in corso...';

  @override
  String get storySavedToLibrary => 'Storia salvata nella biblioteca!';

  @override
  String get storyNotFound => 'Storia non trovata.';

  @override
  String get targetHskLevel => 'Livello HSK desiderato';

  @override
  String get wedLoveToHear => 'Ci piacerebbe conoscere la tua opinione!';

  @override
  String get whetherYouveFoundA =>
      'Che tu abbia trovato un bug, abbia una proposta o voglia semplicemente salutarci, il tuo feedback ci aiuta a migliorare SinoSpark.';

  @override
  String get pointYourCameraAt => 'Inquadra gli oggetti con la fotocamera';

  @override
  String get reviewAddToLibrary => 'Revisiona e aggiungi alla biblioteca';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Nascondi guida dei tratti alla serie di: $streak';
  }

  @override
  String inkPoints(Object points) {
    return '$points Punti Inchiostro';
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
  String get supportAndFeedback => 'Supporto e feedback';

  @override
  String get reportBug => 'Segnala un errore';

  @override
  String get suggestFeature => 'Suggerisci una funzionalità';

  @override
  String get generalFeedback => 'Feedback generale';

  @override
  String get pleaseDrawSomethingFirst => 'Disegna prima qualcosa';

  @override
  String get drawThisCharacter => 'Traccia questo carattere:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Segui la guida blu per tracciare il tratto $current di $total';
  }

  @override
  String get skipCurrentStroke => 'Salta tratto attuale';

  @override
  String get submitDrawing => 'Invia disegno';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '«$hanzi» aggiunto a «$deckName»';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '«$hanzi» rimosso dal mazzo';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'Saltato «$hanzi»: nessun dato sui tratti disponibile per questo carattere.';
  }

  @override
  String get startingSession => 'Avvio della sessione in corso...';

  @override
  String get studySession => 'Sessione di studio';

  @override
  String get readyToStudy => 'Pronto a studiare';

  @override
  String get studyQueuePreviewDescription =>
      'La tua sessione si basa sul programma di oggi e sui limiti del mazzo.';

  @override
  String get notNow => 'Non ora';

  @override
  String get newLabel => 'Nuovo';

  @override
  String get studyDeckEmpty => 'Questo mazzo è vuoto';

  @override
  String get studyDeckEmptyDescription =>
      'Aggiungi delle carte prima di iniziare una sessione di studio.';

  @override
  String get studyDailyLimitReached => 'Limite giornaliero raggiunto';

  @override
  String get studyDailyLimitReachedDescription =>
      'Hai raggiunto il limite giornaliero di nuove carte o ripassi per questo mazzo.';

  @override
  String get studyCaughtUpDescription =>
      'Nessun\'altra attività prevista per oggi. Torna per il prossimo ripasso.';

  @override
  String get noCardsAvailable => 'Nessuna carta disponibile';

  @override
  String get studyNoEligibleCardsDescription =>
      'Al momento nessuna carta è idonea per questa modalità di studio.';

  @override
  String get studySessionLoadFailed =>
      'Impossibile caricare questa sessione di studio. Riprova.';

  @override
  String get retryLimitReached =>
      'Questa carta tornerà nella tua prossima sessione.';

  @override
  String get masterBuildingBlocks =>
      'Padroneggia gli elementi costitutivi degli Hanzi';

  @override
  String get totalWords => 'Parole totali';

  @override
  String get newInk => 'Nuovo inchiostro';

  @override
  String get learningStatus => 'In apprendimento';

  @override
  String get masteredStatus => 'Padroneggiato';

  @override
  String get libraryMastery => 'Padronanza della biblioteca';

  @override
  String get accuracyByMode => 'Precisione per modalità';

  @override
  String get upcomingReviews => 'Prossimi ripassi (prossimi 7 giorni)';

  @override
  String get culturalReadingRoom => 'Sala di lettura culturale (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Inserisci un argomento';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'Creato «$name» con $count carte!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Valutazione: $grade';
  }

  @override
  String get listeningMode => 'Modalità ascolto';

  @override
  String get readingMode => 'Modalità lettura';

  @override
  String get recallMode => 'Modalità rievocazione';

  @override
  String get speakingMode => 'Modalità parlato';

  @override
  String get aiMemoryHook => 'Gancio mnemonico IA';

  @override
  String get exampleSentences => 'Frasi di esempio';

  @override
  String get ghostCharacters => 'Caratteri guida (trasparenza)';

  @override
  String get commonWords => 'Parole comuni';

  @override
  String get personalNotes => 'Note personali';

  @override
  String get addPersonalNotes =>
      'Aggiungi qui le tue regole mnemoniche o annotazioni...';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get gallery => 'Galleria';

  @override
  String get arLens => 'Lente AR';

  @override
  String addedCharToLibrary(Object char) {
    return '«$char» aggiunto alla biblioteca';
  }

  @override
  String get scoreText => 'Punteggio';

  @override
  String get searchDictionaryHint => 'Cerca carattere, pinyin o significato...';

  @override
  String get searchDeckHint => 'Cerca carattere o pinyin...';

  @override
  String get localRestaurant => 'Ristorante locale';

  @override
  String get taxiToAirport => 'Taxi per l\'aeroporto';

  @override
  String get silkMarketHaggling => 'Contrattazione al Mercato della Seta';

  @override
  String get medicalClinic => 'Clinica medica';

  @override
  String get meetingAFriend => 'Incontrare un amico';

  @override
  String get jobInterview => 'Colloquio di lavoro';

  @override
  String get searchRadicalsHint => 'Cerca radicali (es. Acqua, 氵)';

  @override
  String get definition => 'Definizione';

  @override
  String get undo => 'ANNULLA';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Sblocca per sempre - 9,99 €';

  @override
  String get clear => 'Cancella';

  @override
  String get clearChat => 'Cancella chat';

  @override
  String get typeMessage => 'Scrivi il tuo messaggio...';

  @override
  String addedToLibrary(Object hanzi) {
    return '«$hanzi» aggiunto alla tua biblioteca';
  }

  @override
  String get generateNewStory => 'Genera nuova storia';

  @override
  String failedToGenerateStory(Object error) {
    return 'Impossibile generare la storia:\n$error';
  }

  @override
  String get detail => 'Dettaglio';

  @override
  String get scanText => 'Scansiona testo';

  @override
  String get createMagic => 'Crea magia';

  @override
  String get learning => 'In apprendimento';

  @override
  String get upcomingReviews7Days => 'Prossimi ripassi (prossimi 7 giorni)';

  @override
  String get askFollowUpQuestion => 'Fai una domanda di approfondimento...';

  @override
  String get pasteScanToSimplify =>
      'Incolla o scansiona testo in cinese per semplificarlo';

  @override
  String get searchStoriesHint =>
      'Cerca storie per titolo o tag (es. mitologia, viaggi)';

  @override
  String get importAll => 'Importa tutto';

  @override
  String get ascendAll => 'Avanza tutto';

  @override
  String get startAscension => 'Inizia l\'avanzamento';

  @override
  String get scenarioLocalRestaurant => 'Ristorante locale';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Esercitati a ordinare piatti e chiedere consigli sul menu.';

  @override
  String get scenarioTaxiAirport => 'Taxi per l\'aeroporto';

  @override
  String get scenarioTaxiAirportDesc =>
      'Indica all\'autista la tua destinazione e commenta il traffico.';

  @override
  String get scenarioSilkMarket => 'Contrattazione al Mercato della Seta';

  @override
  String get scenarioSilkMarketDesc =>
      'Prova a ottenere un prezzo migliore per un souvenir.';

  @override
  String get scenarioMedicalClinic => 'Clinica medica';

  @override
  String get scenarioMedicalClinicDesc =>
      'Descrivi i tuoi sintomi a un medico tradizionale.';

  @override
  String get scenarioMeetingFriend => 'Incontrare un amico';

  @override
  String get scenarioMeetingFriendDesc =>
      'Presentati e fai un po\' di conversazione informale.';

  @override
  String get scenarioJobInterview => 'Colloquio di lavoro';

  @override
  String get scenarioJobInterviewDesc =>
      'Candidati per una posizione in un\'azienda tecnologica a Shanghai.';

  @override
  String get createCustomScenario => 'Crea scenario personalizzato';

  @override
  String get customScenarioTitleHint => 'Titolo (es. Ricevimento di nozze)';

  @override
  String get customScenarioDescHint => 'Descrizione (Contesto)';

  @override
  String get customScenarioPersonaHint => 'Ruolo IA (es. Un collega curioso)';

  @override
  String get customScenarioDifficulty => 'Difficoltà';

  @override
  String get createAction => 'Crea';

  @override
  String get cancelAction => 'Annulla';

  @override
  String get mythsAndLegends => 'Miti e leggende';

  @override
  String get historyAndCulture => 'Storia e cultura';

  @override
  String get idiomsTitle => 'Modi di dire (成语)';

  @override
  String get theMonkeyKing => 'Il Re Scimmia';

  @override
  String get theMonkeyKingDesc => 'Sun Wukong (Il viaggio in Occidente)';

  @override
  String get huaMulan => 'Hua Mulan';

  @override
  String get huaMulanDesc =>
      'Hua Mulan si arruola nell\'esercito al posto del padre';

  @override
  String get confuciusTitle => 'Confucio';

  @override
  String get confuciusDesc => 'La vita e gli insegnamenti di Confucio';

  @override
  String get theGreatWall => 'La Grande Muraglia';

  @override
  String get theGreatWallDesc => 'La costruzione della Grande Muraglia Cinese';

  @override
  String get generateTopic => 'Genera argomento';

  @override
  String get simplifyText => 'Semplifica testo';

  @override
  String get topicHint => 'Argomento (es. Alieni a Pechino)';

  @override
  String get tagsHint => 'Tag (separati da virgola, opzionali)';

  @override
  String get speakWithMasterLin => 'Parla con il Maestro Lin';

  @override
  String get masterLinGreeting =>
      'Saluti, allievo. L\'inchiostro è pronto. Quale carattere o frase esamineremo oggi?';

  @override
  String get typeYourMessage => 'Scrivi il tuo messaggio...';

  @override
  String get theMainLibrary => 'Biblioteca principale';

  @override
  String get hsk1Foundation => 'HSK 1: Fondamenta';

  @override
  String get hsk2Elementary => 'HSK 2: Elementare';

  @override
  String get hsk3Intermediate => 'HSK 3: Intermedio';

  @override
  String get inDeckCheck => 'Nel mazzo ✓';

  @override
  String get addToDeckPlus => '+ Aggiungi al mazzo';

  @override
  String get openCardArrow => 'Apri carta →';

  @override
  String get pronunciationPartial => 'Tono impreciso';

  @override
  String get pronunciationWrong => 'Non corretto';

  @override
  String get toneExpected => 'Tono atteso';

  @override
  String get toneYouSaid => 'Tono pronunciato';

  @override
  String get gotIt => 'Ho capito!';

  @override
  String foundNCharacters(int count) {
    return '$count caratteri trovati';
  }

  @override
  String get lookingUpCharacters => 'Ricerca caratteri in corso…';

  @override
  String get practiceAll => 'Esercitati su tutto';

  @override
  String get arLensObjects => 'Oggetti';

  @override
  String get arLensText => 'Testo';

  @override
  String get arLensDetectedText => 'Testo rilevato';

  @override
  String get duration12Min => '1-2 min';

  @override
  String get aClassicTangDynastyPoem =>
      'Una poesia classica della dinastia Tang';

  @override
  String get aClassicTangDynastyPoemBy =>
      'Una poesia classica della dinastia Tang di';

  @override
  String get aStructuralComponent => 'Un componente strutturale.';

  @override
  String get addSelectedToDeck => 'Aggiungi selezionati al mazzo';

  @override
  String addTo(Object target) {
    return 'Aggiungi a $target';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '«$hanzi» è stato aggiunto alla tua biblioteca';
  }

  @override
  String get adjustFontSize => 'Regola dimensione carattere';

  @override
  String get againGoodEasyHard =>
      '⬅️ Ripeti    ➡️ Bene    ⬆️ Facile    ⬇️ Difficile';

  @override
  String get aiAnalysisFailed => 'Analisi IA fallita';

  @override
  String get aiIsThinking => 'L\'IA sta pensando...';

  @override
  String get aiSceneAnalysisFailed => 'Analisi della scena IA fallita';

  @override
  String get allLabel => 'Tutto';

  @override
  String get allPinyin => 'Tutto il Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Hai già un account? Accedi';

  @override
  String get analysisFailed => 'Analisi fallita:';

  @override
  String get analyzingClassicalCharacters =>
      'Analisi dei caratteri classici in corso...';

  @override
  String get anatomy => 'Anatomia';

  @override
  String get ancientPhilosophy => 'Filosofia antica';

  @override
  String get warringStates => 'Stati Combattenti';

  @override
  String get hanFeiLegalism =>
      'Han Fei (c. 280–233 a.C.) era un principe dello Stato di Han e il principale pensatore del Legalismo cinese. Riunendo i concetti di legge, tecnica amministrativa e autorità, i suoi scritti nell\'Han Feizi influenzarono profondamente la filosofia politica e le istituzioni della Cina imperiale.';

  @override
  String get articleSavedToMediaHub => 'Articolo salvato nel Media Hub!';

  @override
  String get askAFollowUp => 'Fai una domanda di approfondimento...';

  @override
  String get audioPrivacyAndHowThingsWork => 'Audio, privacy e funzionamento';

  @override
  String get audiobookPlayer => 'Lettore audiolibri';

  @override
  String get audiobookVoice => 'Voce audiolibro';

  @override
  String get auntieMaTown =>
      'Zia Ma (马阿姨), un\'energica ed esuberante proprietaria di bancarella che prepara i Roujiamo e Liangpi più croccanti della città.';

  @override
  String get back => 'Indietro';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯), un giovane e appassionato torrefattore di caffè che ama parlare dei chicchi dello Yunnan e delle note aromatiche.';

  @override
  String get bbc => 'BBC Cinese Online';

  @override
  String get beginYourJourney => 'Inizia il tuo percorso';

  @override
  String get bestValue => 'Miglior valore';

  @override
  String get bookLinkCopiedToClipboard =>
      'Link del libro copiato negli appunti!';

  @override
  String get bookmarkChapter => 'Aggiungi capitolo ai segnalibri';

  @override
  String get bookmarks => 'Segnalibri';

  @override
  String get books => 'Libri';

  @override
  String get briefing => 'Riepilogo';

  @override
  String get bugReport => 'Segnalazione bug';

  @override
  String get caoXueqinDecline =>
      'Cao Xueqin (ca. 1715–1763) fu un romanziere della dinastia Qing, nato in una nobile famiglia un tempo illustre la cui fortuna crollò sotto l\'imperatore Yongzheng. Il sogno della camera rossa, scritto negli ultimi anni trascorsi in povertà, è considerato l\'apice della narrativa classica cinese: un vasto e profondo affresco psicologico del declino aristocratico.';

  @override
  String get cardsTitle => 'CARTE';

  @override
  String get cc => 'Sottotitoli (CC)';

  @override
  String get characterOrWord => 'Carattere / Parola';

  @override
  String get chatMore => 'Continua a chattare';

  @override
  String get chefChenShumai =>
      'Chef Chen (陈师傅), un allegro chef cantonese di dim sum che consiglia ravioli di gamberi Har Gow freschi e Shumai.';

  @override
  String get chineseEpics => 'Epiche cinesi';

  @override
  String get chinesePoetry => 'Poesia cinese';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast =>
      'Banchetto di hotpot piccante di Chongqing';

  @override
  String get chooseAudiobookVoice => 'Scegli la voce dell\'audiolibro';

  @override
  String get chooseVoice => 'Scegli la voce';

  @override
  String get compare => 'Confronta';

  @override
  String get compare4Tones => 'Confronta i 4 toni';

  @override
  String get configuration => 'Configurazione';

  @override
  String get contemporary => 'Contemporaneo';

  @override
  String get context => 'Contesto';

  @override
  String get couldNotLoadLibrary => 'Impossibile caricare la biblioteca';

  @override
  String get couldNotLoadVocabulary => 'Impossibile caricare il vocabolario.';

  @override
  String get couldNotOpenEmailApp =>
      'Impossibile aprire l\'app di posta elettronica.';

  @override
  String get createAccount => 'Crea account';

  @override
  String get createNewDeck => 'Crea nuovo mazzo';

  @override
  String get createScenario => 'Crea scenario';

  @override
  String get createStory => 'Crea storia';

  @override
  String get customLabel => 'Personalizzato';

  @override
  String get customWord => 'Parola personalizzata';

  @override
  String get days => 'giorni';

  @override
  String get deck => 'Mazzo';

  @override
  String get deckName => 'Nome del mazzo';

  @override
  String get renameDeck => 'Rinomina mazzo';

  @override
  String get deckRenamed => 'Mazzo rinominato con successo';

  @override
  String get deckNameCannotBeEmpty => 'Il nome del mazzo non può essere vuoto';

  @override
  String get deckStory => 'Storia del mazzo';

  @override
  String get deepAnalysis => 'Analisi approfondita';

  @override
  String get defaultDeck => 'Mazzo predefinito';

  @override
  String get deleteLabel => 'Elimina';

  @override
  String get deleteScenario => 'Elimina scenario';

  @override
  String get deletesAllProgressPermanently =>
      'Elimina tutti i progressi in modo permanente';

  @override
  String get developerBackdoorUnlocked => 'Accesso sviluppatore sbloccato!';

  @override
  String get doesNotExistInChinese => 'Non esiste in cinese';

  @override
  String get dontHaveAccountSignUp => 'Non hai un account? Registrati';

  @override
  String get draftingStoryOutline =>
      'Elaborazione della struttura della storia...';

  @override
  String get dynamicFlowState => 'Stato di flusso dinamico';

  @override
  String get dynamicFlowStateParenthetical => 'Dinamico (Stato di flusso)';

  @override
  String get editCard => 'Modifica carta';

  @override
  String get egAnimeVocab => 'Es. Vocabolario anime';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'Es. linguaggio commerciale formale, slang per messaggi...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'Es. Ordinare al ristorante, vocabolario d\'affari...';

  @override
  String get egWeddingReceptionTechInterview =>
      'Es. Ricevimento di nozze, colloquio tecnico...';

  @override
  String get emailLabel => 'Email';

  @override
  String get english => 'Inglese';

  @override
  String get englishAndWorld => 'Inglese e Mondo';

  @override
  String get episodes => 'episodi';

  @override
  String get erase => 'Cancella';

  @override
  String get eraseDeckQuestion => 'Cancellare il mazzo?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Errore nel recupero della traduzione per $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Errore nel caricamento delle micro-letture: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Errore nel caricamento dei romanzi: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Errore nel caricamento delle poesie: $e';
  }

  @override
  String get exitFocus => 'Esci dalla modalità Focus';

  @override
  String get explore => 'Esplora';

  @override
  String get exportToThisDeck => 'Esporta in questo mazzo';

  @override
  String get extractAndSimplify => 'Estrai e semplifica';

  @override
  String get failedToCreateDeck => 'Creazione del mazzo non riuscita';

  @override
  String get failedToLoadDailyContent =>
      'Caricamento dei contenuti giornalieri non riuscito';

  @override
  String get failedToLoadEpisodes => 'Caricamento degli episodi non riuscito';

  @override
  String get failedToLoadShows => 'Caricamento dei programmi non riuscito';

  @override
  String get finalizingDetails => 'Finalizzazione dei dettagli in corso...';

  @override
  String get finalizingStoryDetails =>
      'Finalizzazione dei dettagli della storia...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth non è abilitato. Abilita il metodo di accesso richiesto nella tua console Firebase.';

  @override
  String get flashcardDeckTitle => 'MAZZO DI FLASHCARD';

  @override
  String get focus => 'Focus';

  @override
  String get foodAndCooking => 'Cibo e cucina';

  @override
  String get forward => 'Avanti';

  @override
  String get freeFlow => 'Flusso libero';

  @override
  String get frenchClassics => 'Classici francesi';

  @override
  String get full => 'Completo';

  @override
  String get gamingAndEsports => 'Gaming ed eSport';

  @override
  String get germanClassics => 'Classici tedeschi';

  @override
  String get ghostPinyin => 'Pinyin guida';

  @override
  String get goodAttempt => 'Buon tentativo';

  @override
  String get gotItSimple => 'Capito';

  @override
  String get grammar => 'Grammatica';

  @override
  String get grandmaLiuFilling =>
      'Nonna Liu (刘奶奶), un\'affettuosa nonna del nord che ti insegna a chiudere le pieghe dei jiaozi e a preparare il ripieno di maiale e cipollotto.';

  @override
  String get great => 'Ottimo!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Banchetto di jiaozi fatti a mano ad Harbin';

  @override
  String get hanziCharacter => 'Hanzi (Carattere)';

  @override
  String get hapticFeedback => 'Feedback tattile';

  @override
  String get helpAndSupport => 'Aiuto e supporto';

  @override
  String get hidden => 'Nascosto';

  @override
  String get hideEnglishTranslations => 'Nascondi traduzioni in inglese';

  @override
  String get hidePinyin => 'Nascondi Pinyin';

  @override
  String get highlight => 'IN EVIDENZA';

  @override
  String get howWouldYouLikeToStudy => 'Come desideri studiare?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Intermedio superiore';

  @override
  String get hsk5Advanced => 'HSK 5: Avanzato';

  @override
  String get hsk6Mastery => 'HSK 6: Padronanza';

  @override
  String get hskCollections => 'Collezioni HSK';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'Semplifica sottotitoli HSK';

  @override
  String get hskVocabularyCollections => 'Collezioni di vocaboli HSK';

  @override
  String get i => 'Io';

  @override
  String get ifTheAgain =>
      'Se la trascrizione non corrisponde a ciò che hai detto, seleziona la frase desiderata e tocca “Sì, rivalutami!” per valutare di nuovo la registrazione originale senza dover ripetere.';

  @override
  String get install => 'Installa';

  @override
  String get just => 'Solo \$';

  @override
  String get keyword => 'parola chiave';

  @override
  String get knowledgeBase => 'Base di conoscenza';

  @override
  String get liRuzhenSubjects =>
      'Li Ruzhen (ca. 1763–1830) fu uno studioso della dinastia Qing con profondi interessi in fonologia, scacchi e cosmologia. I fiori nello specchio (Flowers in the Mirror), il suo romanzo fantastico incentrato sul viaggio di un mercante attraverso regni straordinari, è celebre per i temi femministi e la vastità enciclopedica.';

  @override
  String get libraryLabel => 'Biblioteca';

  @override
  String get lifestyleAndVlog => 'Stile di vita e vlog';

  @override
  String get listenInAudiobookMode => 'Ascolta in modalità audiolibro';

  @override
  String get listenToThisWord => 'Ascolta questa parola';

  @override
  String get listening => 'In ascolto...';

  @override
  String get liuEEncroachment =>
      'Liu E (1857–1909) fu un poliedrico intellettuale del tardo periodo Qing — ingegnere, medico e romanziere — il cui unico romanzo, I viaggi di Lao Can, è un lirico resoconto di viaggio intriso di riflessioni politiche su un medico errante nella Cina travolta dalla crisi dinastica e dalle ingerenze straniere.';

  @override
  String get loadingTranslations => 'Caricamento traduzioni in corso...';

  @override
  String get luXunVernacular =>
      'Lu Xun (1881–1936), pseudonimo di Zhou Shuren, è il padre della letteratura cinese moderna. Medico votatosi alla scrittura per risvegliare la coscienza del popolo, impiegò la lingua volgare (Baihua) nelle sue celebri raccolte, tra cui Diario di un pazzo e La vera storia di Ah Q.';

  @override
  String get luoGuanzhongEpic =>
      'Luo Guanzhong (ca. 1330–1400) fu un drammaturgo e romanziere vissuto durante la transizione Yuan-Ming, allievo di Shi Nai\'an. Il suo capolavoro, Il romanzo dei Tre Regni, fuse cronache storiche, tradizione orale e narrazione drammatica nell\'epopea storica per eccellenza della tradizione cinese.';

  @override
  String get makeACustomCollection => 'Crea una collezione personalizzata';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Gestisci le Uscite Giornaliere e i promemoria di ripasso';

  @override
  String get managerYuOptions =>
      'Manager Yu (余店长), una vivace direttrice di ristorante hotpot che consiglia la trippa speciale della casa, sangue d\'anatra e brodi leggeri.';

  @override
  String get masterGaoRubs =>
      'Maestro Gao (高师傅), un carismatico maestro del barbecue a carbonella che scherza con i clienti sui livelli di piccantezza e sulla miscela segreta di spezie al cumino.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Padroneggia questo elemento per sbloccare la sua galassia.';

  @override
  String get masterZhaoBrewing =>
      'Maestro Zhao (赵师傅), un paziente ed esperto sommelier del tè che ama illustrare l\'arte della preparazione del tè Gongfu.';

  @override
  String get mastery => 'Padronanza';

  @override
  String get maybeLater => 'Forse più tardi';

  @override
  String get memes => 'Meme';

  @override
  String get midnightBbqSkewersInWuhan => 'Spiedini BBQ di mezzanotte a Wuhan';

  @override
  String get mo => '/mese';

  @override
  String get modernChinese => 'Cinese moderno';

  @override
  String get monthly => 'Mensile';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Carrello del dim sum mattutino a Guangzhou';

  @override
  String get nameLabel => 'Nome';

  @override
  String get native => 'Madrelingua';

  @override
  String get newCard => 'Nuova carta';

  @override
  String get newDeck => 'Nuovo mazzo';

  @override
  String get newDeckName => 'Nome del nuovo mazzo';

  @override
  String get noActiveSubscriptionFound => 'Nessun abbonamento attivo trovato.';

  @override
  String get noEpisodesFound => 'Nessun episodio trovato';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Nessuna parola chiave trovata per questa storia.';

  @override
  String get noLabel => 'No';

  @override
  String get noNewWordsFound => 'Nessuna nuova parola trovata!';

  @override
  String get noPinyin => 'Nessun Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'Nessun pacchetto premium disponibile al momento.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'Nessun risultato trovato per «$searchQuery»';
  }

  @override
  String get noSavedArticlesYet => 'Nessun articolo ancora salvato.';

  @override
  String get noShowsAvailable => 'Nessun programma disponibile';

  @override
  String get noStoriesFound => 'Nessuna storia trovata.';

  @override
  String get noWordsSelected => 'Nessuna parola selezionata';

  @override
  String get notes => 'Note';

  @override
  String get objectivesTitle => 'OBIETTIVI';

  @override
  String get openInYoutube => 'Apri su YouTube';

  @override
  String get tutorialsTab => 'Tutorial';

  @override
  String get youtubeHostedNotice =>
      'Questi video sono ospitati e riprodotti da YouTube. Non li scarichiamo né li modifichiamo.';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Ordinare caffè filtro pour-over a Shanghai';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Ordinare Tanghulu (spiedini di biancospino caramellati) nell\'inverno di Pechino';

  @override
  String partnerLang(String lang) {
    return 'Interlocutore ($lang)';
  }

  @override
  String get partnerListening => 'L\'interlocutore sta ascoltando...';

  @override
  String get partnerSpeaking => 'L\'interlocutore sta parlando...';

  @override
  String get passwordLabel => 'Password';

  @override
  String get pause => 'Pausa';

  @override
  String get perfect => 'Perfetto!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Un percorso personalizzato basato sul tuo mazzo.';

  @override
  String get play => 'Riproduci )';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Inserisci un messaggio prima di inviare.';

  @override
  String get practiceInRoleplay => 'Esercitati nel gioco di ruolo';

  @override
  String get practiceModes => 'Modalità di pratica';

  @override
  String get practicePronouncingWithAiGrading =>
      'Esercitati a pronunciare questa parola con valutazione IA';

  @override
  String get preparingReadingInterface =>
      'Preparazione dell\'interfaccia di lettura in corso...';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyAndAudio => 'Privacy e audio';

  @override
  String get aiDataPrivacyTitle => 'Dati e privacy dell\'IA';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Scopri quali dati inviano le funzionalità IA, perché e a chi';

  @override
  String get aiDataPrivacyOverviewTitle => 'Quando viene usata l\'IA';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark utilizza l\'IA cloud solo quando scegli una funzione che la richiede, come chat IA, spiegazioni, traduzioni, analisi di immagini, riconoscimento vocale, valutazione della pronuncia o voci cloud. I risultati dell\'IA possono essere imprecisi, quindi verifica le informazioni importanti.';

  @override
  String get aiDataPrivacyProvidersTitle => 'Fornitori di servizi IA';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini elabora le richieste generative di testo e immagini. OpenRouter smista alcune richieste generative a Google Gemini o DeepSeek. Microsoft Azure AI Speech gestisce il riconoscimento vocale, la valutazione della pronuncia e il testo inviato per la sintesi vocale cloud.';

  @override
  String get aiDataPrivacySentTitle => 'Dati che potrebbero essere inviati';

  @override
  String get aiDataPrivacySentBody =>
      'A seconda della funzione, inviamo il testo inserito o selezionato, il contesto della lezione o della conversazione, le immagini per l\'analisi IA, le registrazioni vocali e i dati tecnici della richiesta (come indirizzo IP e metadati di dispositivo/rete). Non includiamo intenzionalmente il tuo nome o la tua email nei prompt per l\'IA.';

  @override
  String get aiDataPrivacyControlsTitle => 'Le tue scelte';

  @override
  String get aiDataPrivacyControlsBody =>
      'Non usare una funzione IA se non desideri che i dati vengano inviati al rispettivo fornitore. Puoi revocare le autorizzazioni per fotocamera, foto o microfono nelle Impostazioni del dispositivo. Scegli la voce locale per mantenere la sintesi vocale sul dispositivo. Evita di inviare informazioni sensibili o riservate.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Archiviazione e conservazione';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark non conserva intenzionalmente i prompt grezzi dell\'IA, le immagini o le registrazioni vocali sui propri server dopo l\'elaborazione. I risultati generati possono essere salvati sul tuo dispositivo o sul tuo account se decidi di salvarli. I fornitori elaborano i dati in base ai propri termini e alle impostazioni di conservazione; consulta l\'informativa completa per i dettagli.';

  @override
  String get readFullPrivacyPolicy =>
      'Leggi l\'informativa sulla privacy completa';

  @override
  String get linkOpenFailed => 'Impossibile aprire il link. Riprova.';

  @override
  String get puSonglingLiterature =>
      'Pu Songling (1640–1715) fu uno scrittore della dinastia Qing che dedicò decenni alla stesura dei Racconti straordinari dello studio di Liao (Strange Tales from a Chinese Studio) dopo ripetuti insuccessi agli esami imperiali. Le sue storie sovrannaturali di spiriti volpe, fantasmi e dotti studiosi rappresentano l\'archetipo della letteratura fantastica cinese.';

  @override
  String get qaFaq => 'Domande e risposte / FAQ';

  @override
  String get questsTitle => 'MISSIONI';

  @override
  String get quickBookmarks => 'Segnalibri rapidi';

  @override
  String get radical => 'Radicale';

  @override
  String get ready => 'Pronto';

  @override
  String get readyToInterpret => 'Pronto per interpretare';

  @override
  String get readyToStart => 'Pronto per iniziare.';

  @override
  String get recentBookmarks => 'Segnalibri recenti';

  @override
  String get refiningGrammar => 'Perfezionamento della grammatica in corso...';

  @override
  String get refresh => 'Aggiorna';

  @override
  String get removeFromSaved => 'Rimuovi dai salvati';

  @override
  String get removeFromSavedScenarios => 'Rimuovi dagli scenari salvati';

  @override
  String get removed => 'Rimosso';

  @override
  String get requestPermissions => 'Richiedi autorizzazioni';

  @override
  String get rescind => 'Revoca';

  @override
  String get restore => 'Ripristina';

  @override
  String get results => 'Risultati';

  @override
  String get resume => 'Riprendi';

  @override
  String get retry => 'Riprova';

  @override
  String get revenuecatError => 'Errore RevenueCat:';

  @override
  String revenuecatErrorE(String e) {
    return 'Errore RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'Rivedi il mazzo estratto';

  @override
  String get reviewIn => 'Ripassa in';

  @override
  String get reviewingYourTones => 'Valutazione dei tuoi toni in corso...';

  @override
  String get saveAll => 'Salva tutto';

  @override
  String get saveScenario => 'Salva scenario';

  @override
  String get saveThisScenario => 'Salva questo scenario';

  @override
  String get saved => 'Salvato';

  @override
  String get scanAnother => 'Scansiona un altro';

  @override
  String get scenarioRemoved => 'Scenario rimosso';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Scenario salvato! Lo trovi nella scheda «Personalizzato».';

  @override
  String score(Object score, Object total) {
    return 'Punteggio: $score / $total';
  }

  @override
  String scoreValue(Object value) {
    return 'Punteggio: $value';
  }

  @override
  String get searchByPinyinOrMeaning => 'Cerca per pinyin o significato...';

  @override
  String get searchByTitleOrTag => 'Cerca per titolo o tag...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Cerca nel dizionario o inserisci manualmente';

  @override
  String get searchHint => 'Cerca...';

  @override
  String get searchOrEnterUrl => 'Cerca o inserisci URL';

  @override
  String get searchScenariosHint => 'Cerca scenari...';

  @override
  String get searchStoriesIdiomsNews =>
      'Cerca storie, modi di dire, notizie...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Cerca argomenti (es. Cucina, Storia)';

  @override
  String get seeAll => 'Vedi tutto';

  @override
  String get selectADeck => 'Seleziona un mazzo';

  @override
  String get selectPracticeMode => 'Seleziona modalità di pratica';

  @override
  String get selectingHskVocabulary => 'Selezione dei vocaboli HSK in corso...';

  @override
  String get send => 'Invia';

  @override
  String get sendMessage => 'Invia messaggio';

  @override
  String get serif => 'Con grazie (Serif)';

  @override
  String get shadow => 'Shadowing';

  @override
  String get shiNaianEpic =>
      'Shi Nai\'an (ca. 1296–1372) fu un letterato della dinastia Yuan che, pur avendo superato gli esami imperiali, scelse una vita appartata da studioso. I briganti (Water Margin), il suo capolavoro sui nobili fuorilegge e sulla rivolta per la giustizia, definì i canoni dell\'epica marziale cinese.';

  @override
  String get showEnglish => 'Mostra inglese';

  @override
  String get showEnglishTranslations => 'Mostra traduzioni in inglese';

  @override
  String get showHanzi => 'Mostra Hanzi';

  @override
  String get showPinyin => 'Mostra Pinyin';

  @override
  String get showTranslation => 'Mostra traduzione';

  @override
  String get shows => 'Programmi';

  @override
  String get signIn => 'Accedi';

  @override
  String get simplifiedArticle => 'Articolo semplificato';

  @override
  String get simplifyingSubtitles =>
      'Semplificazione dei sottotitoli in corso...';

  @override
  String get sincereHonest => 'sincero e onesto';

  @override
  String get sleepTimer => 'Timer di spegnimento';

  @override
  String get smartDeck => 'Mazzo intelligente';

  @override
  String get spanishAndWorld => 'Spagnolo e Mondo';

  @override
  String get speaker => 'Altoparlante';

  @override
  String get spotifyStylePlayer => 'Lettore in stile Spotify';

  @override
  String get storyBookmarkedInLibrary =>
      'Storia aggiunta ai segnalibri nella biblioteca!';

  @override
  String get streetFoodNightMarketInXian =>
      'Mercato notturno dello street food a Xi\'an';

  @override
  String get strokes => 'Tratti';

  @override
  String get studyCharacter => 'Studia carattere';

  @override
  String get subtitleOpacity => 'Opacità dei sottotitoli';

  @override
  String get suggestion => 'Suggerimento';

  @override
  String get summary => 'Riepilogo';

  @override
  String get supernaturalAndFolklore => 'Sovrannaturale e folclore';

  @override
  String get swipeToGrade => 'Scorri per valutare:';

  @override
  String get tableOfContents => 'Indice';

  @override
  String get tapToRetry => 'Tocca per riprovare';

  @override
  String get teaTastingInChengdu => 'Degustazione di tè a Chengdu';

  @override
  String get techAndGadgets => 'Tecnologia e gadget';

  @override
  String get terms => 'Termini di servizio';

  @override
  String get theGalaxyCharacters =>
      'La Mappa della Galassia ti attende.\nPadroneggia i Soli (Radicali) per sbloccare i Pianeti (Caratteri).';

  @override
  String get theme => 'Tema';

  @override
  String get thinking => 'Elaborazione in corso...';

  @override
  String get thisArticleCharacters =>
      'Questo articolo contiene caratteri cinesi tradizionali.';

  @override
  String get todaysWord => 'PAROLA DEL GIORNO';

  @override
  String get togglePinyin => 'Attiva/disattiva Pinyin';

  @override
  String get toggleTranslation => 'Attiva/disattiva traduzione';

  @override
  String get toneDoesNotExistInMandarin =>
      'Questo tono non esiste nel mandarino standard.';

  @override
  String get toneGraph => 'Grafico dei toni';

  @override
  String get toneGraphYourVoice => 'La tua voce';

  @override
  String get toneGraphTarget => 'Obiettivo';

  @override
  String get toneGraphNoPitchMeasured =>
      'Non è stata misurata alcuna intonazione in questa prova, quindi non c\'è nulla da disegnare per la tua voce. Il tratto tratteggiato è comunque la forma a cui puntavi.';

  @override
  String get toneGraphHowToReadPhraseNote =>
      'Qui il tratto tratteggiato è la forma dei toni della frase, spaziati in modo uniforme.\nNon sappiamo dove inizia ogni sillaba nella tua registrazione: confronta le forme, non le posizioni.';

  @override
  String get toneGraphHowToReadTitle => 'Come leggere questo grafico';

  @override
  String get toneGraphHowToReadTooltip => 'Come leggere questo grafico';

  @override
  String get toneGraphHowToReadBody =>
      'Da sinistra a destra c’è il tempo. In alto e in basso c’è l’altezza: quanto è acuta la tua voce, non quanto è forte.\nLeggi la direzione del tratto, non la sua altezza: 1 alto e stabile · 2 sale · 3 scende in basso · 4 cade dall’alto.\nIl primo tratto è il tono che volevi; il secondo compare solo quando è stato sentito un tono diverso.\nUn solo tratto significa che hai centrato il bersaglio o che il tono non è stato misurato — mai che hai sbagliato.';

  @override
  String get traceLabel => 'Traccia';

  @override
  String get trailer => 'TRAILER';

  @override
  String get translatingAndAddingPinyin =>
      'Traduzione e inserimento Pinyin in corso...';

  @override
  String get translatingText => 'Traduzione del testo in corso...';

  @override
  String get turnOn => 'Attiva';

  @override
  String get typeHanziPinyinOrEnglish =>
      'Scrivi Hanzi, Pinyin o significato...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Apertura della pergamena in corso...';

  @override
  String get upperIntermediate => 'Intermedio superiore';

  @override
  String get vibrationsForInteractions => 'Vibrazione per le interazioni';

  @override
  String get video => 'Video';

  @override
  String get viewAnswer => 'Visualizza risposta';

  @override
  String get viewAsList => 'Visualizza come elenco';

  @override
  String get viewBookmarks => 'Visualizza segnalibri';

  @override
  String get viewMyDrawing => 'Visualizza il mio disegno';

  @override
  String get vlog => 'Vlog quotidiano cinese';

  @override
  String get voice => 'Voce:';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou =>
      'Ci farebbe molto piacere\nricevere un tuo riscontro.';

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String get whatDoesThisMean => 'Cosa significa?';

  @override
  String get whatHappensToMyChatHistory =>
      'Cosa succede alla mia cronologia chat?';

  @override
  String get whatIfAiMishears =>
      'Cosa posso fare se l’IA interpreta male ciò che ho detto?';

  @override
  String get whichCharacterIs => 'Quale carattere corrisponde a:';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Parole salvate e programmate nel sistema SRS!';

  @override
  String get writeYourMessageHere => 'Scrivi qui il tuo messaggio...';

  @override
  String get wuChengenLiterature =>
      'Wu Cheng\'en (ca. 1500–1582) fu un romanziere della dinastia Ming originario di Huai\'an, Jiangsu. Attingendo al folclore secolare, all\'allegoria buddhista e a una brillante vena satirica, compose Il viaggio in Occidente (Journey to the West), una delle opere più creative e amate della letteratura mondiale.';

  @override
  String get wuJingziClass =>
      'Wu Jingzi (1701–1754) fu un romanziere della dinastia Qing originario dell\'Anhui che rinunciò al proprio patrimonio per dedicarsi alla stesura de I letterati (The Scholars - Rulin Waishi), un tagliente romanzo satirico che mise a nudo la vanità, la corruzione e le ipocrisie del sistema degli esami imperiali e della classe burocratica.';

  @override
  String get xuZhonglinWarfare =>
      'Xu Zhonglin (attivo nel XVI–XVII secolo) fu un autore della dinastia Ming a cui è attribuita la stesura de L\'investitura degli dei (Investiture of the Gods - Fengshen Yanyi), monumentale opera di narrativa mitologica che fonde la storia della dinastia Shang-Zhou con la cosmologia taoista, gerarchie celesti e battaglie leggendarie.';

  @override
  String get yearly => 'Annuale';

  @override
  String get yesReGradeMe => 'Sì, rivalutami!';

  @override
  String you(Object lang) {
    return 'Tu ($lang)';
  }

  @override
  String get youAreSpeaking => 'Stai parlando';

  @override
  String get youLabel => 'Tu';

  @override
  String youLang(String lang) {
    return 'Tu ($lang)';
  }

  @override
  String get youMustAccount =>
      'Per creare un account è necessario accettare i Termini di servizio e l\'Informativa sulla privacy.';

  @override
  String get yourEchoModels =>
      'La cronologia delle conversazioni di Gioco di ruolo che salvi rimane localmente sul dispositivo, così puoi rivederla. Non usiamo le tue conversazioni personali per addestrare i nostri modelli di IA.';

  @override
  String get zhOnly => 'Solo Cinese (ZH)';

  @override
  String get hsk_1300_cards => '1300 carte';

  @override
  String get hsk_154_cards => '154 carte';

  @override
  String get hsk_162_cards => '162 carte';

  @override
  String get hsk_2500_cards => '2500 carte';

  @override
  String get hsk_299_cards => '299 carte';

  @override
  String get hsk_602_cards => '602 carte';

  @override
  String get added_to_review_queue => 'Aggiunto alla coda di ripasso';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'Aggiunte $cardCount carte a «$deckName».';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '«$hanzi» è stato aggiunto alla tua biblioteca';
  }

  @override
  String get advanced => 'Avanzato';

  @override
  String get ai_stories => 'Storie IA';

  @override
  String analysis_failed(Object error) {
    return 'Analisi non riuscita: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Analisi della pronuncia con Gemini AI in corso...';

  @override
  String get analyzing_your_pronunciation =>
      'Analisi della tua pronuncia in corso...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Sei sicuro di voler eliminare definitivamente «$deckName»? L\'azione non può essere annullata e cancellerà tutte le carte contenute.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Chiedi informazioni su $hanzi...';
  }

  @override
  String get audio_haptics => 'Audio e feedback tattile';

  @override
  String get audio_could_not_start_check_your =>
      'Impossibile avviare l\'audio. Controlla la connessione e le impostazioni vocali del dispositivo.';

  @override
  String get calligraphy_trace => 'Traccia calligrafica';

  @override
  String chapters(Object count) {
    return '$count Capitoli';
  }

  @override
  String get char => 'Carattere';

  @override
  String get chinese_character => 'CARATTERE CINESE';

  @override
  String get contact_us_and_report_issues => 'Contattaci e segnala problemi';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Creato mazzo intelligente: «$deckName» con $wordCount parole!';
  }

  @override
  String get custom_ai_generated_story =>
      'Storia personalizzata creata dall\'IA.';

  @override
  String get display_content => 'Schermo e contenuti';

  @override
  String get do_you_keep_or_store_my =>
      'Conservate o registrate i miei campioni vocali?';

  @override
  String get elementary => 'Elementare';

  @override
  String error_creating_scenario(Object error) {
    return 'Errore durante la creazione dello scenario: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Errore nel recupero della traduzione: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Errore durante il caricamento dei capitoli: $error';
  }

  @override
  String get error_loading_decks => 'Errore durante il caricamento dei mazzi';

  @override
  String error_loading_microreads(Object error) {
    return 'Errore durante il caricamento delle micro-letture: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Errore durante il caricamento dei romanzi: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Errore durante il caricamento delle poesie: $error';
  }

  @override
  String get etymology => 'Etimologia: ';

  @override
  String get explanation => 'Spiegazione';

  @override
  String get extracted_text_tap_to_lookup =>
      'Testo estratto (Tocca per cercare)';

  @override
  String extraction_failed(Object error) {
    return 'Estrazione non riuscita: $error';
  }

  @override
  String get failed_to_download => 'Download non riuscito.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Impossibile generare lo scenario: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Impossibile generare la storia:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Impossibile caricare il contesto: $error';
  }

  @override
  String get feature_request => 'Richiesta funzionalità';

  @override
  String get foundation => 'Fondamenta';

  @override
  String get how_is_my_pronunciation_scored =>
      'Come viene calcolato il punteggio della mia pronuncia?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'Vocabolario HSK $hskLevel';
  }

  @override
  String get hsk_level => 'LIVELLO HSK';

  @override
  String get intermediate => 'Intermedio';

  @override
  String get learning_stats => 'Statistiche di apprendimento';

  @override
  String get mandarin => 'Mandarino';

  @override
  String get meaning => 'Significato';

  @override
  String get no_decks_found => 'Nessun mazzo trovato.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'Nessun risultato trovato per «$searchQuery»';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'Le registrazioni inviate per la valutazione della pronuncia vengono elaborate in modo sicuro e SinoSpark non le conserva al termine dell’elaborazione. La cronologia di Gioco di ruolo che scegli di salvare può rimanere sul dispositivo ed essere eliminata nell’app.';

  @override
  String get notification_settings => 'Impostazioni notifiche';

  @override
  String get open_settings => 'Apri Impostazioni';

  @override
  String get phoneme => 'Fonema';

  @override
  String get play_reference_pronunciation =>
      'Riproduci pronuncia di riferimento';

  @override
  String get please_select_a_deck_to_add =>
      'Seleziona un mazzo in cui inserire le carte.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Inquadra il testo in cinese per tradurlo';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Esercitati a tracciare i tratti a mano libera';

  @override
  String get preferences_audio_and_display => 'Preferenze, audio e schermo';

  @override
  String get preparing_your_scholars_verdict =>
      'Preparazione del Verdetto dell\'Erudito...';

  @override
  String get previous => 'Precedente';

  @override
  String question(Object current, Object total) {
    return 'Domanda $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Rimuovere «$hanzi» da questo mazzo?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'Errore RevenueCat: $error';
  }

  @override
  String get review_tomorrow => 'Ripassa domani';

  @override
  String get roleplay => 'Gioco di ruolo';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Salvataggio di $wordCount parole in «$deckName»...';
  }

  @override
  String get search_radicals_eg_water => 'Cerca radicali (es. Acqua, 氵)';

  @override
  String get select_target_hsk_level => 'Seleziona livello HSK desiderato';

  @override
  String get sentence => 'Frase';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Lo Studio di Shadowing è un ambiente dedicato a perfezionare la pronuncia imitando la voce di parlanti madrelingua in tempo reale.';

  @override
  String simplify_failed(Object error) {
    return 'Semplificazione non riuscita: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Parlato e pronuncia';

  @override
  String get statistics => 'Statistiche';

  @override
  String get table_of_contents => 'Indice dei contenuti · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'L\'IA valuta la tua pronuncia su tre parametri fondamentali:\n• Precisione: hai articolato correttamente le sillabe?\n• Completezza: hai omesso o saltato delle parole?\n• Fluidità: hai fatto pause naturali e applicato i toni corretti?\nIl sistema confronta la tua voce con modelli madrelingua per generare un punteggio su 100.';

  @override
  String get this_cannot_be_undone => 'Questa azione non può essere annullata.';

  @override
  String get title => 'Titolo';

  @override
  String get to_be_reviewed => 'Da ripassare';

  @override
  String get traditional => 'Tradizionale';

  @override
  String translation_failed(Object error) {
    return 'Traduzione non riuscita: $error';
  }

  @override
  String get type_in => 'Scrivi...';

  @override
  String get type_your_message_in => 'Scrivi il tuo messaggio in...';

  @override
  String get unable_to_open_this_video_please =>
      'Impossibile aprire questo video. Riprova più tardi.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Visualizza la cronologia di apprendimento e la serie di giorni consecutivi';

  @override
  String get what_is_shadowing_studio => 'Cos\'è lo Studio di Shadowing?';

  @override
  String get words => 'parole';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Il tuo percorso per «$deckName» è pronto!';
  }

  @override
  String get you_said => '🗣️ Hai detto';

  @override
  String vocabularyBatch(Object index) {
    return 'Gruppo di vocaboli $index';
  }

  @override
  String get yourDailyDropIsHere => 'La tua Uscita Giornaliera è pronta! ✨';

  @override
  String get timeToReview => 'È ora di ripassare! 📚';

  @override
  String get neverMissAStroke => 'Non perdere neanche un tratto! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'La tua prova gratuita termina domani! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Livelli ufficiali del vocabolario standard';

  @override
  String get failedToLoadCollections => 'Impossibile caricare le collezioni.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Errore: $error';
  }

  @override
  String get aiSmartContext => 'Contesto intelligente IA';

  @override
  String get aiSmartContextError => 'Errore contesto intelligente IA';

  @override
  String get downloadOfficialHskCollections =>
      'Scarica le collezioni HSK ufficiali';

  @override
  String get unableToLoadThisSection =>
      'Impossibile caricare questa sezione. Riprova.';

  @override
  String get translationLanguage => 'Lingua di traduzione';

  @override
  String get dailyDrops => 'Uscite Giornaliere';

  @override
  String get wordOfTheDayNews => 'Parola del giorno e notizie';

  @override
  String get reviewReminders => 'Promemoria di ripasso';

  @override
  String get flashcardsDueForReview => 'Flashcard pronte per il ripasso';

  @override
  String get dailyNewCards => 'Nuove carte giornaliere';

  @override
  String get dailyReviewLimit => 'Limite di ripasso giornaliero';

  @override
  String get practiceMode => 'Modalità di pratica';

  @override
  String get liziqi => 'Li Ziqi (李子柒): Fiori di seta';

  @override
  String get theLifeOfGarlicTraditional =>
      'La vita dell\'aglio: tradizioni rurali cinesi';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 frasi';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Frasi essenziali in cinese per principianti';

  @override
  String get makingBambooFurniture => 'Costruire mobili in bambù';

  @override
  String get peppaPigChinese => 'Peppa Pig in cinese: Nascondino (躲猫猫)';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'Pozzanghere di fango (livello principiante)';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 verbi';

  @override
  String get mostCommonChineseVerbs => 'I verbi più comuni in cinese';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Ordinare cibo';

  @override
  String get howToOrderFoodIn => 'Come ordinare cibo in un ristorante cinese';

  @override
  String get silkFlowersTraditionalCraft =>
      'Fiori di seta: artigianato tradizionale';

  @override
  String get mandarinCorner =>
      'Mandarin Corner: Impara il cinese - Andare dal medico';

  @override
  String get goingToTheDoctorReal => 'Andare dal medico: conversazione reale';

  @override
  String get hideAndSeekBeginnerFriendly => 'Nascondino (livello principiante)';

  @override
  String get linGdp6 => 'Xiao Lin spiega: Perché il PIL cresce del 6%?';

  @override
  String get why6GdpGrowthEasy =>
      'Perché il PIL cresce del 6%: economia cinese spiegata semplicemente';

  @override
  String get bbcWorldNews => 'BBC 中文 (Notizie dal mondo)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Attualità in cinese semplificato';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'POSTAZIONE YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'Trascrizioni interattive e shadowing';

  @override
  String get showsDramas => 'SERIE E DRAMA';

  @override
  String get extractToDeck => 'Estrai nel mazzo';

  @override
  String get autoSimplify => 'Semplifica automaticamente';

  @override
  String get rewriteThisArticleToMatch =>
      'Riscrivi questo articolo per adattarlo al tuo livello HSK';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Impossibile salvare le parole estratte: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Aggiungi al mazzo ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Uscita di scoperta quotidiana';

  @override
  String get smartSpacedRepetition => 'Ripetizione spaziata intelligente (SRS)';

  @override
  String get trialProtectionAlert => 'Avviso di protezione della prova';

  @override
  String get masteryLevel => 'Livello di padronanza';

  @override
  String get targetObjective => 'Obiettivo di studio';

  @override
  String get dailyPractice => 'Pratica quotidiana';

  @override
  String get aiSpacedRepetition => 'Ripetizione spaziata IA';

  @override
  String get iVeGrantedAccess => 'Ho concesso l\'accesso';

  @override
  String get scanner => 'Scanner';

  @override
  String get interpreter => 'Interprete';

  @override
  String cards(Object count) {
    return '$count carte';
  }

  @override
  String get nWaMendsTheHeavens => 'Nüwa ripara il cielo';

  @override
  String get terracottaArmy => 'Esercito di terracotta';

  @override
  String get forbiddenCity => 'Città Proibita';

  @override
  String get aBlessingInDisguise =>
      'Non tutto il male viene per nuocere (塞翁失马)';

  @override
  String get drawingASnake => 'Dipingere i piedi a un serpente (画蛇添足)';

  @override
  String get takingTheBulletTrain => 'Prendere il treno ad alta velocità';

  @override
  String get visitingTheDoctor => 'Andare dal medico';

  @override
  String get orderingDumplings => 'Ordinare i jiaozi (ravioli)';

  @override
  String get theTeaCeremony => 'La cerimonia tradizionale del tè';

  @override
  String get chineseCalligraphy => 'Calligrafia cinese';

  @override
  String get theGiantPanda => 'Il panda gigante';

  @override
  String get simplifiedText => 'Testo semplificato';

  @override
  String get novels96 => 'Romanzi (96)';

  @override
  String get microReads => 'Micro-letture';

  @override
  String get poetry => 'Poesia';

  @override
  String get bookmarkRemoved => 'Segnalibro rimosso';

  @override
  String bookmarkAdded(Object chapter) {
    return 'Segnalibro aggiunto: Capitolo $chapter';
  }

  @override
  String get readingVocabulary => 'Lettura e vocabolario';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Gruppo di vocaboli $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'La tua Uscita Giornaliera è pronta! ✨';

  @override
  String get timeToReview1 => 'È ora di ripassare! 📚';

  @override
  String get neverMissAStroke1 => 'Non perdere neanche un tratto! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 =>
      'La tua prova gratuita termina domani! ⏳';

  @override
  String get hskCollections1 => 'Collezioni HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Livelli ufficiali del vocabolario standard';

  @override
  String get failedToLoadCollections1 => 'Impossibile caricare le collezioni.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Riproduci $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Errore: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'Contesto intelligente IA';

  @override
  String get aiSmartContextError1 => 'Errore contesto intelligente IA';

  @override
  String errorErr(Object err, Object error) {
    return 'Errore: $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Scarica le collezioni HSK ufficiali';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Impossibile caricare questa sezione. Riprova.';

  @override
  String get searchRadicalsEgWater => 'Cerca radicali (es. Acqua, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Lingua di traduzione';

  @override
  String get appLanguage1 => 'Lingua dell\'app';

  @override
  String get dailyDrops1 => 'Uscite Giornaliere';

  @override
  String get wordOfTheDayNews1 => 'Parola del giorno e notizie';

  @override
  String get reviewReminders1 => 'Promemoria di ripasso';

  @override
  String get flashcardsDueForReview1 => 'Flashcard pronte per il ripasso';

  @override
  String get accuracyByMode1 => 'Precisione per modalità';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => 'Prossimi ripassi (prossimi 7 giorni)';

  @override
  String get explaining => 'Spiegazione:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Nuove carte giornaliere';

  @override
  String get dailyReviewLimit1 => 'Limite di ripasso giornaliero';

  @override
  String get listeningMode1 => 'Modalità ascolto';

  @override
  String get readingMode1 => 'Modalità lettura';

  @override
  String get recallMode1 => 'Modalità rievocazione';

  @override
  String get speakingMode1 => 'Modalità parlato';

  @override
  String get practiceMode1 => 'Modalità di pratica';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'Interlocutore';

  @override
  String get partnerSpeaking1 => 'L\'interlocutore sta parlando…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'La vita dell\'aglio: tradizioni rurali cinesi';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 frasi';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Frasi essenziali in cinese per principianti';

  @override
  String get makingBambooFurniture1 => 'Costruire mobili in bambù';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Pozzanghere di fango (livello principiante)';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 verbi';

  @override
  String get mostCommonChineseVerbs1 => 'I verbi più comuni in cinese';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Ordinare cibo';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Come ordinare cibo in un ristorante cinese';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Fiori di seta: artigianato tradizionale';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Andare dal medico: conversazione reale';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'Nascondino (livello principiante)';

  @override
  String get lingdp6 => 'Xiao Lin spiega: Perché il PIL cresce del 6%?';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Perché il PIL cresce del 6%: economia cinese spiegata semplicemente';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Attualità in cinese semplificato';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'POSTAZIONE YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Trascrizioni interattive e shadowing';

  @override
  String get showsDramas1 => 'SERIE E DRAMA';

  @override
  String error_error(Object error) {
    return 'Errore: $error';
  }

  @override
  String get extractToDeck1 => 'Estrai nel mazzo';

  @override
  String get autosimplify => 'Semplifica automaticamente';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Riscrivi questo articolo per adattarlo al tuo livello HSK';

  @override
  String get addToDeck1 => 'Aggiungi al mazzo';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Uscita di scoperta quotidiana';

  @override
  String get smartSpacedRepetition1 => 'Ripetizione spaziata intelligente';

  @override
  String get trialProtectionAlert1 => 'Avviso di protezione della prova';

  @override
  String get masteryLevel1 => 'Livello di padronanza';

  @override
  String get targetObjective1 => 'Obiettivo di studio';

  @override
  String get dailyPractice1 => 'Pratica quotidiana';

  @override
  String get aiSpacedRepetition1 => 'Ripetizione spaziata IA';

  @override
  String get iveGrantedAccess => 'Ho concesso l\'accesso';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Aggiungi al mazzo ($count)';
  }

  @override
  String get scanner1 => 'Scanner';

  @override
  String get interpreter1 => 'Interprete';

  @override
  String entryvalueCards(Object count) {
    return '$count carte';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Punteggio: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'Il Re Scimmia';

  @override
  String get huaMulan1 => 'Hua Mulan';

  @override
  String get nwaMendsTheHeavens => 'Nüwa ripara il cielo';

  @override
  String get confucius => 'Confucio';

  @override
  String get theGreatWall1 => 'La Grande Muraglia';

  @override
  String get terracottaArmy1 => 'Esercito di terracotta';

  @override
  String get forbiddenCity1 => 'Città Proibita';

  @override
  String get aBlessingInDisguise1 => 'Non tutto il male viene per nuocere';

  @override
  String get drawingASnake1 => 'Dipingere i piedi a un serpente';

  @override
  String get takingTheBulletTrain1 => 'Prendere il treno ad alta velocità';

  @override
  String get visitingTheDoctor1 => 'Andare dal medico';

  @override
  String get orderingDumplings1 => 'Ordinare i ravioli';

  @override
  String get theTeaCeremony1 => 'La cerimonia del tè';

  @override
  String get chineseCalligraphy1 => 'Calligrafia cinese';

  @override
  String get theGiantPanda1 => 'Il panda gigante';

  @override
  String get simplifiedText1 => 'Testo semplificato';

  @override
  String get novels961 => 'Romanzi (96)';

  @override
  String get microreads => 'Micro-letture';

  @override
  String get poetry1 => 'Poesia';

  @override
  String get readingVocabulary1 => 'Lettura e vocabolario';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions non sono stati configurati per Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions non sono supportati per questa piattaforma.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'I tratti non possono essere vuoti.';

  @override
  String get wrongStartPoint => 'Punto di partenza errato.';

  @override
  String get rightShapeButWrongPlace => 'Forma corretta, ma posizione errata!';

  @override
  String get goodFollowTheFlow =>
      'Ottimo! Segui il flusso naturale del tratto.';

  @override
  String get aBitShaky => 'Tratto un po\' tremolante!';

  @override
  String get aBitHesitant => 'Un po\' esitante...';

  @override
  String get shapeIsOff => 'La forma del tratto non è corretta.';

  @override
  String get arabic => 'Arabo';

  @override
  String get german => 'Tedesco';

  @override
  String get spanish => 'Spagnolo';

  @override
  String get french => 'Francese';

  @override
  String get hindi => 'Hindi';

  @override
  String get indonesian => 'Indonesiano';

  @override
  String get italian => 'Italiano';

  @override
  String get japanese => 'Giapponese';

  @override
  String get korean => 'Coreano';

  @override
  String get portuguese => 'Portoghese';

  @override
  String get russian => 'Russo';

  @override
  String get vietnamese => 'Vietnamita';

  @override
  String get microphonePermissionDenied =>
      'Autorizzazione per il microfono negata';

  @override
  String get offset => 'Scostamento';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService è stato rilasciato';

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
  String get kore => 'Kore (femminile, accogliente)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Parola chiave';

  @override
  String get creativeThematicTitle => 'Titolo tematico creativo';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Breve spiegazione pedagogica o semantica';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'Il carattere più rilevante della lista';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Un insieme equilibrato di caratteri dalla tua biblioteca.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'La tua risposta conversazionale naturale in caratteri cinesi.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'La traduzione italiana della tua risposta.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'Il pinyin con i segni di tono per la tua risposta.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Una risposta suggerita che l\'utente potrebbe darti.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin per il suggerimento.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Traduzione italiana per il suggerimento.';

  @override
  String get scholarsCritique => 'Critica dell\'Erudito';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'La Sala dell\'Eco rimane in silenzio. Fai un respiro e riprova.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'Nessuno al momento.';

  @override
  String get exactSentence => 'Frase esatta:';

  @override
  String get englishTranslation => 'Traduzione italiana';

  @override
  String get previouslyGeneratedPhrases => 'Frasi generate in precedenza';

  @override
  String get iLikeDrinkingAppleJuice => 'Mi piace bere il succo di mela.';

  @override
  String get theEnglishMeaningHere => 'Il significato in italiano qui...';

  @override
  String get failedToFetchDefinition =>
      'Impossibile recuperare la definizione.';

  @override
  String get failedToLoadExplanation => 'Impossibile caricare la spiegazione.';

  @override
  String get failedToLoadComparison => 'Impossibile caricare il confronto.';

  @override
  String get emptyResponseFromOpenrouter => 'Risposta vuota da OpenRouter';

  @override
  String get emptyResponseFromVisionModel =>
      'Risposta vuota dal modello Vision';

  @override
  String get standard => 'Standard';

  @override
  String get theFullSentenceInChinese => 'La frase completa in cinese...';

  @override
  String get theWordOrCharacterInChinese =>
      'La parola o il carattere in cinese';

  @override
  String get thePinyinForThisSpecificWord =>
      'Il pinyin per questa parola specifica';

  @override
  String get emptyResponseFromDeepseekApi =>
      'Risposta vuota dall\'API DeepSeek';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'IMPORTANTE: inserisci la traduzione italiana in';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Traduzione italiana dell\'intera frase';

  @override
  String get hanziWord => 'Parola Hanzi';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'La frase completa in caratteri cinesi semplificati...';

  @override
  String get lyingFlatACulturalMovement =>
      'Tang Ping (Lying Flat): un fenomeno culturale...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'L\'utente con cui stai parlando si chiama';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'REGOLA IMPORTANTE: non rivolgerti all\'utente per nome. Non utilizzare mai nomi segnaposto come';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Sei un tutor conciso ed esperto di calligrafia ed etimologia cinese all\'interno di un\'app mobile di flashcard.';

  @override
  String get theStudentIsStudyingTheCharacter =>
      'Lo studente sta imparando il carattere';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Non scrivere mai introduzioni, saluti o frasi di riempimento come';

  @override
  String get beDirectAndInformative => 'Sii diretto e informativo.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'REGOLA FONDAMENTALE: devi rispondere INTERAMENTE nella lingua corrispondente al codice ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Sei un tutor conciso ed esperto di grammatica cinese all\'interno di un\'app mobile.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'Lo studente ha dubbi sulla parola';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Non scrivere mai introduzioni, saluti o frasi di riempimento.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Le chiavi dell\'API Azure Speech sono mancanti.';

  @override
  String get success => 'Operazione completata';

  @override
  String get granularity => 'Granularità';

  @override
  String get phoneme1 => 'Fonema';

  @override
  String get dimension => 'Dimensione';

  @override
  String get comprehensive => 'Completo';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Non siamo riusciti a sentirti chiaramente. Riprova.';

  @override
  String get noNbestResultFound =>
      'Nessun risultato di riconoscimento ottimale trovato.';

  @override
  String get words1 => 'Parole';

  @override
  String get word => 'Parola';

  @override
  String get phonemes => 'Fonemi';

  @override
  String get syllables => 'Sillabe';

  @override
  String get syllable => 'Sillaba';

  @override
  String get omission => 'Omissione';

  @override
  String get insertion => 'Inserimento';

  @override
  String get youMissedThisWord => 'Hai saltato questa parola.';

  @override
  String get extraWordAddedHere => 'Parola aggiuntiva rilevata qui.';

  @override
  String get mispronunciation => 'Pronuncia non corretta';

  @override
  String get pronunciationWasInaccurate => 'La pronuncia non era accurata.';

  @override
  String get goodEffortKeepPracticing =>
      'Buon impegno! Continua a fare pratica.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Pronuncia perfetta! Sembri un madrelingua.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Ottimo lavoro! Solo qualche piccola imprecisione sui toni.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Non male, ma i toni richiedono ancora un po\' di esercizio.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Continua a esercitarti! Ascolta l\'audio madrelingua e riprova.';

  @override
  String get lexical => 'Lessicale';

  @override
  String get chineseHanziHere => 'Hanzi cinese qui';

  @override
  String get aShortSummaryInEnglish => 'Un breve riassunto in italiano';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'Nessun testo cinese riconoscibile trovato nella scansione.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'La traduzione italiana completa del testo scansionato... OPPURE \'Nessun testo cinese riconoscibile trovato.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Un titolo breve di 2-4 parole per questa scansione (es. \'Menu del ristorante\', \'Cartello stradale\')';

  @override
  String get china => 'Cina';

  @override
  String get noTranslationAvailable => 'Nessuna traduzione disponibile.';

  @override
  String get scanResults => 'Risultati della scansione';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Quando è stato scritto e quale contesto storico caratterizzava la Cina in quel periodo?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Perché quest\'opera è celebre? Quali tematiche filosofiche o culturali affronta?';

  @override
  String get aBriefBioOfTheAuthor => 'Una breve biografia dell\'autore.';

  @override
  String get informationUnavailable => 'Informazioni non disponibili.';

  @override
  String get noSummaryAvailable => 'Nessun riassunto disponibile.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'Prova, Normale, Intro';

  @override
  String get dailyDrop => 'Uscita Giornaliera';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Notifiche giornaliere per la Parola del Giorno e le notizie';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Una nuova Parola e Storia del Giorno ti aspettano!';

  @override
  String get spacedRepetition => 'Ripetizione spaziata (SRS)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Promemoria per le flashcard pronte per il ripasso';

  @override
  String get engagementReminders => 'Promemoria di attività';

  @override
  String get trialReminders => 'Promemoria periodo di prova';

  @override
  String get notificationsForYourTrialStatus =>
      'Notifiche sullo stato della tua prova gratuita';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Vieni a ripassare i tuoi Hanzi e prova una chiamata dal vivo prima che termini il tuo accesso gratuito!';

  @override
  String get scholarsEye => 'Occhio dell\'Erudito';

  @override
  String get clMeasureWord => 'Classificatore (CL):';

  @override
  String get surnameShi => 'Cognome Shi';

  @override
  String get chineseFamilyNameShi => 'Cognome cinese (Shi)';

  @override
  String get neutralToneLight => 'Tono neutro (leggero)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Mantieni il tono alto e costante come se stessi sostenendo una nota musicale.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Inizia da un registro medio e fai scivolare il tono verso l\'alto come quando chiedi: «Cosa?»';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Abbassa la voce verso il basso, quindi falla risalire dolcemente.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Fai scendere il tono in modo rapido e deciso, come se pronunciassi un fermo «No!»';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Pronuncia in modo lieve, breve e senza enfasi.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'Perfetto! Il tono era alto, piatto e stabile.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'Perfetto! L\'innalzamento del tono era chiaro e distinto.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'Perfetto! La flessione del tono verso il basso e la risalita erano precise.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'Perfetto! La discesa rapida e decisa del tono era impeccabile.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'Perfetto! Il tono è stato pronunciato con assoluta precisione.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Accetto i Termini di servizio e l\'Informativa sulla privacy.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Inviami aggiornamenti periodici, consigli e offerte speciali.';

  @override
  String get signInToSyncYourProgress =>
      'Accedi per sincronizzare i tuoi progressi di studio.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Crea un account per salvare le tue statistiche.';

  @override
  String get smartSpiral => 'SPIRALE INTELLIGENTE';

  @override
  String get origin => 'Origine';

  @override
  String get elements => 'Elementi naturali';

  @override
  String get humanity => 'Umanità e società';

  @override
  String get village => 'Vita di villaggio';

  @override
  String get journey => 'Viaggio';

  @override
  String get city => 'Città e commercio';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Le forme più semplici. L\'inizio di ogni cosa.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Sole, Luna, Acqua e Fuoco. Il mondo naturale.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Il corpo, il cuore e la famiglia.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Campi coltivati, tetti e attrezzi. Le fondamenta della società.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Movimento, parola e nutrimento.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Commercio, abiti e civiltà avanzata.';

  @override
  String get equilibriumAlgorithm => 'Algoritmo di equilibrio';

  @override
  String get misc => 'Varie';

  @override
  String get cityOrOriginAs => '«Città» o «Origine» come';

  @override
  String get miscToOrigin => 'Da «Varie» a «Origine»';

  @override
  String get constellation => 'Costellazione';

  @override
  String get whichOneIsWater => 'Quale di questi significa \'Acqua\'?';

  @override
  String get whatIsThePinyin => 'Qual è il pinyin corretto?';

  @override
  String get nature => 'Natura';

  @override
  String get whatEssenceDoes => 'Quale essenza racchiude';

  @override
  String get allTiers => 'Tutti i livelli';

  @override
  String get active => 'Attivo';

  @override
  String get theScrollOfOrigin1 => 'LA PERGAMENA DELL\'ORIGINE';

  @override
  String galaxyOf1(Object name) {
    return 'GALASSIA DI $name';
  }

  @override
  String get also => 'Anche';

  @override
  String get work => 'Lavoro';

  @override
  String get cloud => 'Nuvola';

  @override
  String get youArchaic => 'Tu (arcaico)';

  @override
  String get suddenly => 'Improvvisamente';

  @override
  String get owner => 'Proprietario';

  @override
  String get door => 'Porta';

  @override
  String get occupy => 'Occupare';

  @override
  String get nail => 'Chiodo';

  @override
  String get and => 'E';

  @override
  String get buddhistNun => 'Monaca buddhista';

  @override
  String get anxious => 'Ansioso';

  @override
  String get sprout => 'Germoglio';

  @override
  String get exchange => 'Scambiare';

  @override
  String get sheep => 'Pecora';

  @override
  String get strange => 'Strano';

  @override
  String get opposite => 'Opposto';

  @override
  String get shorttailedBird => 'Uccello dalla coda corta';

  @override
  String get shoot => 'Germoglio / Germoglio di bambù';

  @override
  String get small => 'Piccolo';

  @override
  String get gather => 'Raccogliere';

  @override
  String get order => 'Ordine';

  @override
  String get flat => 'Piatto';

  @override
  String get thePersonWho => 'La persona che...';

  @override
  String get nobleman => 'Gentiluomo / Nobile';

  @override
  String get cause => 'Causa';

  @override
  String get pig => 'Maiale';

  @override
  String get bright => 'Luminoso';

  @override
  String get slowly => 'Lentamente';

  @override
  String get give => 'Dare';

  @override
  String get arrow => 'Freccia';

  @override
  String get dry => 'Secco';

  @override
  String get obstacle => 'Ostacolo';

  @override
  String get beg => 'Chiedere / Pregare';

  @override
  String get window => 'Finestra';

  @override
  String get fear => 'Paura';

  @override
  String get drum => 'Tamburo';

  @override
  String get why => 'Perché';

  @override
  String get talent => 'Talento';

  @override
  String get follow => 'Seguire';

  @override
  String get desert => 'Deserto';

  @override
  String get component => 'Componente';

  @override
  String divingInto1(Object topic) {
    return 'Immersione in $topic';
  }

  @override
  String get unitIntro1 => 'Introduzione all\'unità';

  @override
  String get theBlueprint => 'IL PROGETTO';

  @override
  String get theOrigin => 'L\'ORIGINE';

  @override
  String get theGalaxy => 'LA GALASSIA';

  @override
  String get theScholarListens => 'L\'Erudito ascolta...';

  @override
  String get consultingTheScrolls => 'Consultazione delle antiche pergamene...';

  @override
  String get traceWithTheGuide => 'Traccia seguendo la guida';

  @override
  String get traceTheGhost => 'Traccia sulla linea guida semitrasparente';

  @override
  String get connectTheDots => 'Unisci i punti';

  @override
  String get drawFromMemory => 'Disegna a memoria';

  @override
  String get assistant => 'Assistente';

  @override
  String get puck => 'Puck (maschile, sportivo)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Ciao! Benvenuto/a. Cosa desideri ordinare oggi?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'Cameriere Li';

  @override
  String get askForTheMenu => 'Chiedi il menu';

  @override
  String get orderOneDishAndOneDrink => 'Ordina un piatto e una bevanda';

  @override
  String get askForTheBill => 'Chiedi il conto';

  @override
  String get fenrir => 'Fenrir (maschile, vivace)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'Autista Wang';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Di\' all\'autista che sei diretto all\'aeroporto';

  @override
  String get askHowLongTheTripWillTake =>
      'Chiedi quanto tempo richiederà il tragitto';

  @override
  String get complainAboutTheTraffic =>
      'Commenta le condizioni del traffico intenso';

  @override
  String get charon => 'Charon (maschile, stile notiziario)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'La qualità di questo capo è eccellente, costa solo 200 kuai.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'Zia Chen';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'Chiedi il prezzo della camicia di seta';

  @override
  String get sayItIsTooExpensive => 'Di\' che è troppo costosa';

  @override
  String get bargainThePriceDownTo100Rmb =>
      'Contratta il prezzo fino a 100 RMB';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'Dott. Zhang';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Spiega di avere mal di testa da due giorni';

  @override
  String get sayYouHaveASlightFever => 'Di\' di avere qualche linea di febbre';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Chiedi se è necessario assumere farmaci';

  @override
  String get aoede => 'Aoede (femminile, solare)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Ciao! Da quanto tempo non ci vediamo, come stai ultimamente?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Presentati brevemente. Perché desideri lavorare nella nostra azienda?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'Manager Liu';

  @override
  String get introduceYourProfessionalBackground =>
      'Presenta in sintesi il tuo profilo professionale';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Spiega le ragioni per cui desideri entrare in questa azienda';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Poni una domanda cortese sulla cultura aziendale';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'L\'accesso al microfono è necessario. Abilitalo nelle Impostazioni del tuo dispositivo.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Impossibile avviare il microfono. Controlla le impostazioni audio e riprova.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Non abbiamo percepito chiaramente la voce. Tieni premuto il microfono e riprova!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'La registrazione è risultata troppo breve. Tieni premuto il microfono e parla scandendo le parole.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Il buffer audio è vuoto. Controlla il microfono e riprova.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'Il file audio risulta silenzioso. Parla direttamente nel microfono.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Non siamo riusciti a comprendere la tua pronuncia. Parla chiaramente e riprova.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'Il server impiega troppo tempo per rispondere. Riprova.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Nessuna connessione Internet disponibile. Controlla la tua rete e riprova.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Elaborazione audio non riuscita. Riprova.';

  @override
  String get permission => 'Autorizzazione';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Impossibile elaborare la tua registrazione vocale. Riprova.';

  @override
  String get user => 'Utente';

  @override
  String get scholar => 'Erudito';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'I nostri tutor IA sono al momento offline. Ti invitiamo a riprovare più tardi.';

  @override
  String get hideTranslation => 'Nascondi traduzione';

  @override
  String get azureAssessment => 'Valutazione Azure in corso...';

  @override
  String get microphonePermissionRequired =>
      'Autorizzazione per il microfono richiesta';

  @override
  String get connectedSpeakNow => 'Connessione stabilita! Puoi parlare adesso.';

  @override
  String get initializationErrorCheckPermissions =>
      'Errore di inizializzazione. Verifica le autorizzazioni concesse.';

  @override
  String get microphoneErrorTapToRetry =>
      'Errore del microfono. Tocca per riprovare.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'Il tutor ha restituito una risposta vuota.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Connessione interrotta. Per favore parla di nuovo.';

  @override
  String get callPausedReviewingTones =>
      'Chiamata in pausa (revisione dei toni)';

  @override
  String get pausedTakeABreak => 'In pausa - Fai un breve momento di pausa';

  @override
  String get goodStartPracticing => 'Ottimo inizio di pratica';

  @override
  String get studentCoach => 'Allievo / Coach';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Mantieni il 1° tono alto e costante su';

  @override
  String get noScenariosFound => 'Nessuno scenario trovato.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Progetta la tua esperienza di gioco di ruolo con l\'IA';

  @override
  String get generateFromDeck => 'Genera dal mazzo';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Esercitati con il vocabolario delle flashcard in un dialogo dal vivo';

  @override
  String get tapToRoleplay => 'Tocca per avviare il gioco di ruolo';

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
  String get dinnerWithDad => 'Cena con papà';

  @override
  String get orderingAtAChengduTeahouse =>
      'Ordinare in una casa da tè a Chengdu';

  @override
  String get buyingTeaAtTheMarket => 'Acquistare tè al mercato tradizionale';

  @override
  String get meetingAnOldClassmate =>
      'Incontrare un vecchio compagno di classe';

  @override
  String get readyToPractice => 'Sei pronto per esercitarti?';

  @override
  String get letsPracticeChinese => 'Facciamo pratica di cinese';

  @override
  String get areYouReady => 'Sei pronto?';

  @override
  String get discussWhatToHaveForDinner =>
      'Discutere su cosa mangiare per cena';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Proporre di guardare un film dopo cena';

  @override
  String get askIfTheyWouldLikeTea => 'Chiedere se gradiscono una tazza di tè';

  @override
  String get helloVeryNiceToMeetYou =>
      'Ciao! È un vero piacere fare la tua conoscenza.';

  @override
  String get deckPractice => 'Pratica con il mazzo';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Esercitati sui vocaboli con un partner IA.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Progetta giochi di ruolo e dialoghi personalizzati con l\'IA';

  @override
  String get random => 'Casuale';

  @override
  String get scenarioTopic => 'Argomento dello scenario';

  @override
  String get contextSettingOptional => 'Contesto e ambientazione (opzionale)';

  @override
  String get aiCharacterPersonaOptional =>
      'Personaggio / Ruolo dell\'IA (opzionale)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Una tranquilla casa da tè con cortile di bambù a Chengdu, accompagnata dal suono delicato del guzheng.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Un vivace mercato notturno avvolto da aromi invitanti, ricco di spiedini alla griglia, baozi e street food.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Un vivace ristorante di hotpot a Chongqing con brodo rosso fiammante e profumo speziato di peperoncino.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Una tradizionale casa da tè cantonese a Guangzhou, animata e colma di cestelli di bambù fumanti.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Un raffinato caffè minimalista nella Concessione Francese in un piovoso pomeriggio domenicale.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Un\'accogliente cucina domestica del nord in inverno, con farina sul tavolo e pentole di ravioli fumanti.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Un vicolo all\'aperto di street food notturno con spiedini d\'agnello sfrigolanti, melanzane arrostite e birra fresca.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Un angolo di strada innevato all\'esterno del Tempio dei Lama, con spiedini di tanghulu rosso lucido esposti sul ghiaccio.';

  @override
  String get craftBeerBreweryInQingdao => 'Birrificio artigianale a Qingdao';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Una vivace taproom costiera con botti di legno, brezza marina e birra di frumento appena spillata.';

  @override
  String get sichuanCookingMasterclass => 'Masterclass di cucina del Sichuan';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Una vivace cucina a vista con wok fiammeggianti, olio al peperoncino sfrigolante e grani di pepe fresco del Sichuan.';

  @override
  String get highspeedRailSeatMixup =>
      'Scambio di posti sul treno ad alta velocità';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Trekking all\'alba sulla Grande Muraglia a Mutianyu';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'I bastioni in pietra antica della Grande Muraglia all\'alba, circondati da montagne verdeggianti e nebbiose.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Escursione in zattera di bambù sul fiume Li a Guilin';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Scivolare lungo le acque carsiche color smeraldo tra le spettacolari vette calcaree nebbiose vicino a Yangshuo.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Trekking in cammello lungo la Via della Seta a Dunhuang';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Le ondulate dune di sabbia dorata del Monte Mingsha accanto all\'oasi del Lago della Mezzaluna.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Prenotare un alloggio tradizionale con cortile a Dali';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Un tranquillo boutique hotel con cortile in stile Bai con vista sul lago Erhai nello Yunnan.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Pellegrinaggio al Palazzo del Potala a Lhasa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'I maestosi gradini in pietra baciati dal sole all\'esterno del Palazzo del Potala con le ruote di preghiera in movimento.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Un regno incantato sotto zero tra scintillanti palazzi di ghiaccio illuminati e maestose sculture di neve.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Funivia delle Montagne di Avatar a Zhangjiajie';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Sospesi in alto in una funivia panoramica in vetro che si libra sopra migliaia di pilastri di arenaria.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Campo per l\'osservazione delle stelle nel deserto del Gobi nel Gansu';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Un lussuoso accampamento di iurte sotto la volta cristallina della Via Lattea nel deserto vicino a Jiayuguan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Crociera delle Tre Gole sul Fiume Azzurro (Yangtze)';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'Sul ponte solarium di una nave da crociera fluviale che attraversa la maestosa e scenografica Gola di Qutang.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Acquistare antiquariato a Panjiayuan, Pechino';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Una storica fornace per ceramica colma di delicati vasi di porcellana grezza e smalti blu cobalto.';

  @override
  String get suzhouSilkEmbroideryStudio => 'Studio di ricamo in seta di Suzhou';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Un tranquillo studio con giardino lungo i canali di Suzhou, con preziosi fili di seta e telai da ricamo in legno.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Dietro le quinte di un teatro tradizionale dell\'Opera di Pechino, tra costumi variopinti, specchi e copricapi sfarzosi.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Consulto di Medicina Tradizionale Cinese (MTC)';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Tai Chi mattutino nel parco del Tempio del Cielo';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Sotto antichi cipressi all\'alba, in armonia con il canto degli uccelli e gli anziani che si esercitano all\'unisono.';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'Noleggiare un Hanfu per un servizio fotografico';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Una boutique di abiti tradizionali vicino al Lago dell\'Ovest con rassegne di vesti delle dinastie Tang e Song.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Laboratorio di Guqin (antica cetra cinese)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Uno studio tranquillo in legno di pino a Hangzhou, colmo di antichi strumenti in paulonia e corde di seta.';

  @override
  String get shaanxiShadowPuppetTheater =>
      'Teatro delle ombre cinesi dello Shaanxi';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Dietro uno schermo di seta bianca illuminato, con delicate sagome in cuoio traslucido per il teatro delle ombre.';

  @override
  String get chineseCalligraphyWorkshop => 'Laboratorio di calligrafia cinese';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Uno studio sereno che profuma di inchiostro di fuliggine di pino, rotoli di carta di riso e delicati aromi di tè.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Adottare un gatto in un rifugio per animali';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Un accogliente centro di accoglienza per animali a Hangzhou con vivaci gattini e tè offerto ai visitatori.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Gioco di ruolo con delitto (Jubensha)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Un lounge investigativo a tema a Shanghai, tra giocatori in costume d\'epoca e luce di candela.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Negozio di dischi in vinile vintage a Shanghai';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Un negozio di vinili nascosto in una tipica shikumen di Shanghai, colmo di classici Cantopop e dischi jazz anni \'80.';

  @override
  String get ktvKaraokePartyWithFriends =>
      'Festa karaoke in un KTV con gli amici';

  @override
  String get joiningACityBikeCyclingClub =>
      'Iscriversi a un club ciclistico urbano';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Un ritrovo di ciclisti sul lungofiume pronti per una pedalata serale con vista sullo skyline urbano.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Raduno di scambio per collezionisti di Blind Box';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Un colorato negozio di collezionismo e cultura pop a Chaoyang, tra scaffali espositivi e mystery box sigillate.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Riprese aeree con drone sullo skyline del Bund';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'La passeggiata del Bund al crepuscolo con vista sui futuristici grattacieli illuminati di Pudong.';

  @override
  String get goldenRetrieverCafeInNanjing => 'Golden Retriever Café a Nanchino';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Un solare e allegro pet café con decine di affettuosi cani pronti ad accogliere i clienti.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Palestra di arrampicata bouldering a Chengdu';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Una moderna palestra di arrampicata indoor con pareti colorate e musica energica.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Un immenso padiglione fieristico gremito di stand di videogiochi, photo booth e cosplayer.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Chiedere indicazioni stradali in un hutong di Pechino';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Un labirinto di storici vicoli in mattoni grigi, tra biciclette, cortili interni e alberi di melograno.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Acquistare frutta fresca in un mercato tradizionale';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Un vivace mercato rionale del mattino con banchi stracolmi di litchi, mango e dragon fruit freschi.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Un mazzo di fiori dal mercato dei fiori di Kunming';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'Il celebre mercato dei fiori di Dounan, immerso tra milioni di rose fresche, gigli ed eucalipto.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Riparazioni sartoriali in un vicolo tradizionale';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Una sartoria tradizionale colma di macchine da cucire, scampoli di stoffa e metri a nastro.';

  @override
  String get expressParcelLockerRetrieval =>
      'Ritiro pacchi dall\'armadietto smart (Locker)';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'Al piano terra, accanto all\'ingresso del condominio, presso l\'armadietto smart Hive Box.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Riparare una gomma a terra all\'ingresso del campus';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Una piccola postazione di riparazione all\'aperto all\'ombra di un grande albero di baniano.';

  @override
  String get techCompanyProductDemo =>
      'Dimostrazione di prodotto aziendale hi-tech';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Uno stand avveniristico a una conferenza tecnologica a Shenzhen con dimostrazioni di hardware IA d\'avanguardia.';

  @override
  String get ecommerceLivestreamStudio =>
      'Studio di live streaming per l\'e-commerce';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Uno studio di trasmissione iperdinamico con ring light, espositori di prodotti e schermi per i commenti in tempo reale.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Mercato del Commercio Internazionale di Yiwu';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Un immenso centro commerciale ed espositivo su più piani, colmo di milioni di merci all\'ingrosso e oggetti d\'artigianato.';

  @override
  String get universityCampusExchangeProgram =>
      'Programma di scambio universitario';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Un prato soleggiato fuori dalla biblioteca universitaria con studenti intenti a studiare e bere milk tea.';

  @override
  String get pleaseEnterAScenarioTopic =>
      'Inserisci un argomento per lo scenario.';

  @override
  String get nameTitle => 'Nome (Titolo)';

  @override
  String get aiCharacter => 'Personaggio IA';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Ciao! Benvenuto/a, di cosa vorresti parlare oggi?';

  @override
  String get greetYourConversationPartner => 'Saluta il tuo interlocutore';

  @override
  String get askAQuestionInChinese => 'Fai una domanda in cinese';

  @override
  String get pinyinWithToneMarks => 'Pinyin con segni dei toni';

  @override
  String get goal1InEnglish => 'Obiettivo 1 (in italiano)';

  @override
  String get goal2InEnglish => 'Obiettivo 2 (in italiano)';

  @override
  String get goal3InEnglish => 'Obiettivo 3 (in italiano)';

  @override
  String get beginner => 'Principiante';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Padronanza';

  @override
  String get azurePronunciationAssessment => 'VALUTAZIONE PRONUNCIA AZURE';

  @override
  String get tapToReview => 'Tocca per ripassare';

  @override
  String get overallScore => 'Punteggio complessivo';

  @override
  String get toneAccuracy => 'Precisione del tono';

  @override
  String get fluency => 'Fluidità';

  @override
  String get report => 'Segnala';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Buona pronuncia, ma puoi fare ancora meglio!';

  @override
  String get didYouMeanToSay => 'Intendevi dire...?';

  @override
  String get greatKeepTrying => 'Ottimo! Continua così!';

  @override
  String get completeness => 'Completezza';

  @override
  String get targetTone => 'Tono atteso';

  @override
  String get k4toneComparisonTapToListen =>
      'Confronto dei 4 toni (Tocca per ascoltare):';

  @override
  String get youSpokeMatch => 'Hai detto (Corrisponde!)';

  @override
  String get youSpoke => 'Hai detto';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'La tua collezione principale di caratteri.';

  @override
  String get deckNotFound => 'Mazzo non trovato';

  @override
  String get cannotDeleteTheDefaultDeck =>
      'Impossibile eliminare il mazzo predefinito';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Intermedio superiore';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'I primi 150 caratteri per iniziare il tuo viaggio.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Amplia il tuo vocabolario fino a 300 parole fondamentali.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Raggiungi fluidità nella conversazione con 600 parole.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Leggi testi e conversa fluentemente con 1200 parole.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Leggi quotidiani e guarda film con 2500 parole.';

  @override
  String get databaseBoxNotOpen => 'Database non aperto';

  @override
  String get hsk1DataFileIsEmpty => 'Il file dati HSK 1 è vuoto';

  @override
  String get gold => 'Oro';

  @override
  String get globalDictionaryNotInitialized =>
      'Dizionario globale non inizializzato';

  @override
  String get reading => 'Lettura';

  @override
  String get recall => 'Rievocazione';

  @override
  String get speaking => 'Parlato';

  @override
  String get listening1 => 'Ascolto';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Esercitati sull\'ordine dei tratti con le guide visive.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Guarda il carattere, ricorda il Pinyin e il significato.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Guarda il significato, traccia il carattere a memoria.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Leggi ad alta voce per verificare la correttezza dei toni.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Ascolta l\'audio e individua il carattere corrispondente.';

  @override
  String get contract => 'Contratto';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Chi implementa questa interfaccia DEVE supportare queste operazioni.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck o locale';

  @override
  String get manageDecks => 'Gestisci mazzi';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Si è verificato un problema nel caricamento della biblioteca. Riprova.';

  @override
  String get noCharactersInLexicon1 => 'Nessun carattere nel lessico';

  @override
  String get masterTheBuildingBlocks => 'Padroneggia gli elementi fondamentali';

  @override
  String get other => 'Altro';

  @override
  String get requiredLabel => 'Obbligatorio';

  @override
  String get library1 => 'Biblioteca';

  @override
  String get youAreAPremiumMember => 'Sei un membro Premium';

  @override
  String get createAccountToSyncProgress =>
      'Crea un account per sincronizzare i progressi';

  @override
  String get signOut => 'Esci';

  @override
  String get account => 'Account';

  @override
  String get guestScholar => 'Studioso ospite';

  @override
  String get localAccount => 'Account locale';

  @override
  String get unknownRadical => 'Radicale sconosciuto';

  @override
  String get followTheGuideStroke => 'Segui la traccia guida';

  @override
  String get strokeAnimationSpeed => 'Velocità animazione del tratto';

  @override
  String get notifications => 'Notifiche';

  @override
  String get deutsch => 'Tedesco';

  @override
  String get bahasaIndonesia => 'Indonesiano';

  @override
  String get italiano => 'Italiano';

  @override
  String get today1d2d3d4d5d6d => 'Oggi, 1 g, 2 g, 3 g, 4 g, 5 g, 6 g';

  @override
  String get targetDeck => 'Mazzo di destinazione';

  @override
  String get mixed => 'Misto';

  @override
  String get topicForContext => 'Argomento (per il contesto)';

  @override
  String get nounsOnly => 'Solo sostantivi';

  @override
  String get verbsOnly => 'Solo verbi';

  @override
  String get idiomsChengyu => 'Modi di dire (Chengyu)';

  @override
  String get fullSentences => 'Frasi complete';

  @override
  String get beginnerHsk12 => 'Principiante (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Intermedio (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Avanzato (HSK 5-6)';

  @override
  String get generatedByAi => 'Generato dall\'IA';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Puoi farmi altri due esempi con questa parola?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Quali sono alcune parole simili e in cosa si differenziano?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Questa parola viene usata più nel cinese parlato o scritto?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Esistono altri modi per tradurre questa parola?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'Quali sono le combinazioni di parole (collocazioni) più comuni con questo termine?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Quali sono gli errori più comuni commessi dagli studenti con questa parola?';

  @override
  String get emptyResponse => 'Risposta vuota';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Qual è l\'origine di questo carattere nella scrittura su ossa oracolari?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Come si è evoluta nel tempo la forma antica di questo carattere?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Indicami 3 parole comuni che contengono questo carattere.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'Quali altri caratteri condividono questo stesso radicale?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'C\'è un proverbio o detto cinese che include questo carattere?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Spiega le regole dell\'ordine dei tratti per questo carattere.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Dammi un consiglio calligrafico per tracciare questo carattere con eleganza.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'C\'è qualche particolarità nell\'uso grammaticale di questa parola?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'Quali parole vengono spesso confuse con questa e perché?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Questo carattere ha un valore simbolico o culturale particolare in Cina?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Questo carattere compare spesso in film, canzoni o testi contemporanei cinesi?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Qual è il significato del radicale di questo carattere?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Scomponi ogni singolo componente spiegandone il significato.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Dammi un trucco mnemonico per ricordare il tono esatto di questo carattere.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Ci sono omofoni comuni che possono creare confusione?';

  @override
  String get quotaExceeded => 'Limite di quota superato';

  @override
  String get mustProvideEitherCardOrCards =>
      'È necessario specificare una carta o un elenco di carte';

  @override
  String get deckSettings => 'Impostazioni mazzo';

  @override
  String get saveSettings => 'Salva impostazioni';

  @override
  String get sealRed => 'Sigillo rosso';

  @override
  String get sealScript => 'Stile del sigillo (Zhuan)';

  @override
  String get startYourStreak => 'INIZIA LA TUA SERIE';

  @override
  String get traditionalCharacter => 'Carattere tradizionale';

  @override
  String get inQueue => 'In coda';

  @override
  String get tapToListenAgain => 'Tocca per ascoltare di nuovo';

  @override
  String get contextClue => 'Indizio di contesto';

  @override
  String get microphonePermissionRequired1 =>
      'È richiesta l\'autorizzazione per il microfono.';

  @override
  String get recordingFailedNoFile =>
      'Registrazione non riuscita (nessun file generato).';

  @override
  String get holdToSpeakOptional => 'Tieni premuto per parlare (opzionale)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Autorizzazione microfono negata. Abilitala nelle Impostazioni per utilizzare lo Studio di Shadowing.';

  @override
  String get sessionSummary => 'Riepilogo della sessione';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Ecco i caratteri con cui hai riscontrato maggiori difficoltà:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Applica le valutazioni della sessione alla Ripetizione Spaziata (modalità Parlato)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Perfeziona la tua pronuncia in mandarino\nmimando la parlata madrelingua.';

  @override
  String get aiIsGradingYourPronunciation =>
      'L\'IA sta valutando la tua pronuncia...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Tieni premuto per registrare. Rilascia per valutare.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Tocca una sillaba per ascoltare tutti e 4 i toni:';

  @override
  String get freeFlowConversationalPractice =>
      'Pratica di conversazione a flusso libero.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Impossibile generare la frase. Riprova.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Registrazione troppo breve. Tieni premuto il pulsante del microfono più a lungo.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Errore durante la registrazione. Riprova.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Nessuna traccia audio rilevata. Riprova.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'L\'audio registrato è muto. Riprova parlando chiaramente.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Chiavi dell\'API Azure Speech mancanti';

  @override
  String get azureError401 => 'Errore Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Autenticazione Azure non riuscita. Verifica la chiave Speech API e l\'area geografica nel file .env.';

  @override
  String get azureError429 => 'Errore Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Quota Azure esaurita. Riprova più tardi.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Tempo per la valutazione Azure scaduto. Verifica la connessione Internet.';

  @override
  String get recognitionFailedNull =>
      'Riconoscimento non riuscito: valore nullo';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Non siamo riusciti a sentire chiaramente la tua voce. Riprova.';

  @override
  String get singlePhrasePractice => 'Pratica su frase singola';

  @override
  String get failedToGeneratePhrase => 'Impossibile generare la frase';

  @override
  String get omitted => 'Omesso';

  @override
  String get partial => 'Parziale';

  @override
  String get mispronounced => 'Pronuncia non corretta';

  @override
  String get startSession1 => 'Inizia sessione';

  @override
  String get chinese => 'Cinese';

  @override
  String get paused => 'In pausa';

  @override
  String get translationFailed => 'Traduzione non riuscita';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Coinvolgenti analisi macroeconomiche e di business raccontate attraverso una narrazione vivace.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Esplora le economie globali, la storia bancaria e le dinamiche industriali internazionali.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Mandarino chiaro e scandito, ideale per studenti di livello intermedio e avanzato.';

  @override
  String get chefWang => 'Chef Wang';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Padroneggia l\'autentica arte culinaria del Sichuan insegnata direttamente da uno chef professionista.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Autentiche ricette cinesi spiegate passo dopo passo, con focus sul controllo del wok e sulle tecniche di taglio.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Vocabolario gastronomico essenziale e istruzioni chiare in mandarino naturale.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Cinematografia, tecnologie di ripresa all\'avanguardia e analisi approfondita dei media digitali.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Stile documentaristico di alto livello che esplora la produzione video e le innovazioni dell\'IA.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Linguaggio tecnico ricco con pronuncia cristallina e sottotitoli visivi.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Giornalismo d\'inchiesta approfondito e commenti puntuali sull\'attualità.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Sguardo critico su dinamiche sociali, notizie internazionali e storia.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Linguaggio formale e analitico, ideale per allenare la comprensione all\'ascolto avanzata.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Pillole di divulgazione scientifica animata per rispondere alle domande della vita quotidiana.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Esplora fisica, biologia e curiosità quotidiane con infografiche chiare e divertenti.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Mandarino standard di Pechino con narrazione dal ritmo equilibrato e sottotitoli precisi.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Emozionanti viaggi alla scoperta dello street food e conversazioni sincere in tutta la Cina.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Esplora storie umane autentiche, tradizioni familiari e specialità gastronomiche locali.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Mandarino parlato naturale arricchito da espressioni quotidiane e calore comunicativo.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Recensioni ironiche e sincere sui dispositivi elettronici basate sull\'esperienza diretta.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Test e prove sul campo di smartphone, gadget smart home e accessori tecnologici.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Dialoghi informali e divertenti ricchi di espressioni colloquiali moderne.';

  @override
  String get seanKitchen => 'La cucina di Sean';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Gustosi piatti casalinghi cinesi e ricreazione delle migliori ricette di street food.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Consigli di cucina pratici per preparare autentici piatti asiatici tradizionali.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Commento cordiale e coinvolgente accompagnato da vocaboli culinari pratici.';

  @override
  String get chineseChannel => 'Canale Cinese';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Lezioni strutturate di lingua cinese e percorsi di scoperta culturale.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Punti grammaticali, ampliamento del lessico HSK e strutture conversazionali.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Ritmo didattico chiaro e calibrato su misura per gli studenti di cinese.';

  @override
  String get oneInABillion => 'Uno su un miliardo';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Ritratti intimi e storie di vita di persone straordinarie nella Cina contemporanea.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Esplora percorsi di vita originali, cultura giovanile e le trasformazioni sociali della Cina moderna.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Narrazione profonda e coinvolgente con un lessico ricco e voci autentiche.';

  @override
  String get vickySoup => 'Vicky Soup';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Vlog di lifestyle ricercato, moda e routine quotidiane.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Diari di viaggio e momenti intimi raccontati con sensibilità cinematografica.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Mandarino informale e spontaneo parlato a un ritmo naturale ed espressivo.';

  @override
  String get tededMandarin => 'TED-Ed Mandarino';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Lezioni animate di alto profilo dedicate a scienza, filosofia e storia.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Enigmi stimolanti, capolavori letterari e misteri psicologici.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Doppiaggio in mandarino impeccabile con sottotitoli bilingue sincronizzati.';

  @override
  String get channel => 'Canale';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Documentari culturali d\'autore e approfondimenti sullo stile di vita cinese.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Alla scoperta di arti tradizionali, antichi mestieri e tendenze moderne.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Audio ad alta fedeltà con sottotitoli in cinese sincronizzati in tempo reale.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Storie curiose e progetti video creativi provenienti dal web cinese.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Interviste appassionanti, storytelling ed esplorazioni visive.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Eccellente materiale di ascolto con pronuncia standard.';

  @override
  String get xVsY => 'X contro Y';

  @override
  String get untitled => 'Senza titolo';

  @override
  String get contemporaryStories => 'Storie contemporanee';

  @override
  String get history => 'Storia';

  @override
  String get advancedReading => 'Lettura avanzata';

  @override
  String get intermediateReading => 'Lettura intermedia';

  @override
  String get beginnerReading => 'Lettura per principianti';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get localDb => 'Database locale';

  @override
  String get emperorTaizong => 'Imperatore Taizong';

  @override
  String get emperorXuanzong => 'Imperatore Xuanzong';

  @override
  String get liBai => 'Li Bai';

  @override
  String get gradedReader => 'Letture graduate';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Impara il mandarino con TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'Cinese quotidiano';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'Ting: Vita quotidiana in Cina';

  @override
  String get xinxin => 'Xinxin';

  @override
  String get sweetFamilyDailyLife => 'Dolce vita quotidiana in famiglia';

  @override
  String get chinsunDailyLife => 'La vita quotidiana di Chin-Sun';

  @override
  String get tasteChina => 'I sapori della Cina';

  @override
  String get dawenFoodQuest => 'L\'avventura gastronomica di DaWen';

  @override
  String get chinaTravelWithCangbao => 'In viaggio in Cina con Cangbao';

  @override
  String get alinFoodWalk => 'Passeggiata culinaria con Alin';

  @override
  String get videoOfTheDay => 'VIDEO DEL GIORNO';

  @override
  String get noValidVideoFound => 'Nessun video valido trovato.';

  @override
  String get listeningPractice => 'PRATICA DI ASCOLTO';

  @override
  String get socialSkills => 'COMPETENZE SOCIALI';

  @override
  String get culturalContext => 'CONTESTO CULTURALE';

  @override
  String get realLife => 'VITA REALE';

  @override
  String get realWorld => 'MONDO REALE';

  @override
  String get articleOfTheDay => 'ARTICOLO DEL GIORNO';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Impossibile caricare o analizzare il feed RSS.';

  @override
  String get drama => 'Dramma';

  @override
  String get youkugetAppNow => 'YOUKU: Scarica subito l\'app';

  @override
  String get romanceTrailer => 'Romantico / Trailer';

  @override
  String get romance => 'Romantico';

  @override
  String get action => 'Azione';

  @override
  String get mystery => 'Mistero';

  @override
  String get historical => 'Storico';

  @override
  String get historicalAction => 'Storico / Azione';

  @override
  String get historicalRomance => 'Storico / Romantico';

  @override
  String get anYouth => 'Gioventù';

  @override
  String get historicalSliceOfLife =>
      'Storico / Spaccato di vita (Slice of Life)';

  @override
  String get historicalHighlight => 'Storico / Momenti salienti';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: Scarica subito l\'app';

  @override
  String get theDouble => 'The Double';

  @override
  String get updatesByOshin => 'Aggiornamenti a cura di Oshin';

  @override
  String get backFromTheBrink => 'Ritorno dall\'abisso';

  @override
  String get fallingIntoYourSmile => 'Innamorarsi del tuo sorriso';

  @override
  String get everyoneLovesMe => 'Tutti mi amano';

  @override
  String get tillTheEndOfTheMoon => 'Fino alla fine della luna';

  @override
  String get theBestDayOfMyLife => 'Il giorno più bello della mia vita';

  @override
  String get gikkiChineseDrama => 'Drama cinese GIKKI';

  @override
  String get dashingYouth => 'Gioventù impavida';

  @override
  String get rebornChineseDramaEngSub => 'Drama cinese Reborn (Sottotitoli)';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'Quando volo verso di te';

  @override
  String get mztvExclusiveChineseDrama => 'Drama cinese in esclusiva MZTV';

  @override
  String get theStarryLove => 'Amore tra le stelle';

  @override
  String get comedy => 'Commedia';

  @override
  String get backFromTheBrink1 => 'Ritorno dall\'abisso';

  @override
  String get dashingYouth1 => 'Gioventù impavida';

  @override
  String get beReborn => 'Rinascere';

  @override
  String get beautyStrategy => 'Strategia di bellezza';

  @override
  String get myDivineEmissary => 'Il mio emissario divino';

  @override
  String get theHope => 'La speranza';

  @override
  String get ep16In => 'Episodio 16';

  @override
  String get everyoneLovesMe1 => 'Tutti mi amano';

  @override
  String get fallingIntoYourSmile1 => 'Innamorarsi del tuo sorriso';

  @override
  String get hiddenLove => 'Amore segreto';

  @override
  String get loveBetweenFairyAndDevil => 'L\'amore tra la fata e il demone';

  @override
  String get loveLikeTheGalaxy => 'Amore come la galassia';

  @override
  String get membersPremiere => 'Anteprima per abbonati';

  @override
  String get moonlight => 'Chiaro di luna';

  @override
  String get myJourneyToYou => 'Il mio viaggio verso di te';

  @override
  String get mysteriousLotusCasebook => 'I casi del loto misterioso';

  @override
  String get rebornChineseDramaEngSub1 => 'Drama cinese Reborn (Sottotitoli)';

  @override
  String get reborn => 'Rinascita';

  @override
  String get theBestDayOfMyLife1 => 'Il giorno più bello della mia vita';

  @override
  String get theDouble1 => 'The Double';

  @override
  String get theLongBallad => 'La lunga ballata';

  @override
  String get theStarryLove1 => 'Amore tra le stelle';

  @override
  String get theUntamed => 'The Untamed (L\'indomabile)';

  @override
  String get tillTheEndOfTheMoon1 => 'Fino alla fine della luna';

  @override
  String get whenIFlyTowardsYou1 => 'Quando volo verso di te';

  @override
  String get wordOfHonor => 'Parola d\'onore (Word of Honor)';

  @override
  String get blossom => 'Fioritura';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'Di generazione in generazione';

  @override
  String get brocadeOdyssey => 'L\'odissea del broccato';

  @override
  String get circleOfLove => 'Il cerchio dell\'amore';

  @override
  String get dawnIsBreaking => 'Sorge l\'aurora';

  @override
  String get firstRomance => 'Primo amore';

  @override
  String get loveInTheClouds => 'Amore tra le nuvole';

  @override
  String get secondChanceRomance => 'Una seconda occasione per amare';

  @override
  String get mrBad => 'Mr. Bad';

  @override
  String get pursuitOfJade => 'Alla ricerca della giada';

  @override
  String get fatedHearts => 'Cuori predestinati';

  @override
  String get roadHome => 'La via verso casa';

  @override
  String get myDearGuardian => 'Mio caro guardiano';

  @override
  String get brightEyesInTheDark => 'Occhi luminosi nel buio';

  @override
  String get theIngeniousOne => 'La mente ingegnosa';

  @override
  String get herPhoenixMajesty => 'Sua Maestà la Fenice';

  @override
  String get dreamsNeverEnd => 'I sogni non finiscono mai';

  @override
  String get theUltimateVowUnknownToYou => 'La promessa segreta';

  @override
  String get the300LoyalGhosts => 'I 300 spiriti leali';

  @override
  String get homelandGuardian => 'I guardiani della patria';

  @override
  String get loveIsAlwaysOnline => 'L\'amore è sempre connesso';

  @override
  String get thePrincessDecree => 'Il decreto della principessa';

  @override
  String get aVowInTheDark => 'Un giuramento nell\'ombra';

  @override
  String get aGirlLikeMe => 'Una ragazza come me';

  @override
  String get iAmNobody => 'Non sono nessuno (I Am Nobody)';

  @override
  String get myMamaGo => 'Forza, mamma!';

  @override
  String get myWesternRegionPrincess =>
      'La mia principessa delle terre d\'occidente';

  @override
  String get aFlowerOnTheContinent => 'Un fiore nel continente';

  @override
  String get thePrincess => 'La principessa';

  @override
  String get sweetLoveVersion => 'Versione storia d\'amore dolce';

  @override
  String get hilariousFamily2 => 'Famiglia esilarante 2';

  @override
  String get guYuanMountainHasASchool => 'La scuola del monte Gu Yuan';

  @override
  String get foreverYoung => 'Sempre giovani';

  @override
  String get theHiddenHeirYeChen => 'Ye Chen, l\'erede segreto';

  @override
  String get extraordinary => 'Straordinario';

  @override
  String get sideStoryOfFoxVolant => 'La storia parallela della Volpe Volante';

  @override
  String get loveOfTheDivineTree => 'L\'amore dell\'albero sacro';

  @override
  String get rebirth => 'Rinascita';

  @override
  String get moonlitReunion => 'Ricongiungimento al chiaro di luna';

  @override
  String get videoCountsCannotBeNegative =>
      'Il numero di video non può essere negativo.';

  @override
  String get publicDomainClassic => 'Classico di pubblico dominio';

  @override
  String get idioms => 'Modi di dire';

  @override
  String get news => 'Notizie';

  @override
  String get fairyTales => 'Fiabe e favole';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Ecco un affascinante approfondimento culturale';

  @override
  String get videoFetchTimedOut => 'Tempo per il recupero del video scaduto';

  @override
  String get aboutChannel => 'INFORMAZIONI SUL CANALE';

  @override
  String get noVideosFound => 'Nessun video trovato';

  @override
  String get failedToLoadVideos => 'Impossibile caricare i video';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Contenuti in mandarino curati e di alta qualità con lessico naturale.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Cinese parlato autentico su temi e contesti reali.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Video coinvolgenti con sottotitoli interattivi e sincronizzati.';

  @override
  String get watchVideo => 'Guarda il video';

  @override
  String get culturalInsight => 'Approfondimento culturale';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'L\'IA sta analizzando il contesto culturale...';

  @override
  String get diveIntoFullContent => 'Esplora il contenuto completo';

  @override
  String get savedArticles => 'Articoli salvati';

  @override
  String get liveOverlay => 'LETTURA INTERATTIVA';

  @override
  String get webExplorer => 'ESPLORATORE WEB';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Naviga su qualsiasi sito web cinese con dizionario istantaneo al tocco, annotazioni pinyin e traduzione in tempo reale.';

  @override
  String get startExploring => 'INIZIA A ESPLORARE';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Serie TV cinesi con sottotitoli interattivi';

  @override
  String get failedToLoadContent => 'Impossibile caricare i contenuti';

  @override
  String get searchingYoutube => 'Ricerca su YouTube in corso...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'Nessun video trovato. Prova con un altro termine di ricerca.';

  @override
  String get searching => 'Ricerca in corso...';

  @override
  String get noShowsFound => 'Nessun programma trovato';

  @override
  String get bookmarked => 'Salvato nei preferiti';

  @override
  String get trailer1 => 'Trailer';

  @override
  String get highlight1 => 'Momenti salienti';

  @override
  String get noCaptionsAvailable => 'Nessun sottotitolo disponibile';

  @override
  String get fetchingSubtitles => 'Recupero dei sottotitoli in corso...';

  @override
  String get generatingAiBriefing => 'Generazione del riepilogo IA in corso...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Nessun sottotitolo digitale (CC) trovato per questo video.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'I video con sottotitoli impressi direttamente nel video non dispongono di tracce di testo digitali su YouTube.';

  @override
  String get translatingSubtitles => 'Traduzione dei sottotitoli in corso...';

  @override
  String get processingYourPronunciation =>
      'Elaborazione della tua pronuncia in corso...';

  @override
  String get couldntIdentifyLine => 'Impossibile riconoscere la frase.';

  @override
  String get listeningSpeakNow => 'In ascolto... parla ora.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Questo video non include una traccia di sottotitoli digitali (CC) su YouTube.';

  @override
  String get perfect1 => 'Perfetto';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Questo video è stato rimosso o non è più disponibile.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Questo video non può essere riprodotto all\'interno dell\'app. Puoi comunque guardarlo su YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Il tuo dispositivo non supporta la riproduzione di questo video. Provane un altro.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Riferimento video non valido. Riprova.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Impossibile caricare questo video. Provane un altro.';

  @override
  String get startReading => 'Inizia a leggere';

  @override
  String get analyzingCulturalContext =>
      'Analisi del contesto culturale in corso...';

  @override
  String get failedToLoadCulturalInsight =>
      'Impossibile caricare l\'approfondimento culturale.';

  @override
  String get historicalContext => 'Contesto storico';

  @override
  String get culturalSignificance => 'Significato culturale';

  @override
  String get authorBackground => 'Biografia dell\'autore';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'Oltre 80 romanzi classici integrali ed epopee mondiali';

  @override
  String get storyOfTheDay => 'STORIA DEL GIORNO';

  @override
  String get tangDynasty => 'Dinastia Tang';

  @override
  String get poetryClassicalVerse => 'Poesia classica e componimenti in versi';

  @override
  String get allHsk => 'Tutti i livelli HSK';

  @override
  String get allStories => 'Tutte le storie';

  @override
  String get keyWords => 'Parole chiave';

  @override
  String get openOriginalWebsite => 'Apri sito web originale';

  @override
  String get aiReadingTools => 'Strumenti di lettura IA';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Migliora la tua comprensione del testo con gli strumenti basati sull\'IA';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Scegli il livello di difficoltà desiderato per la semplificazione';

  @override
  String get chooseDifficultyForSimplification =>
      'Scegli la difficoltà di semplificazione';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Estrai tutti i vocaboli sconosciuti in un nuovo mazzo di flashcard';

  @override
  String get length => 'Lunghezza';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Estrazione da pagina web';

  @override
  String get aiTools => 'Strumenti IA';

  @override
  String get stop => 'Interrompi';

  @override
  String get keepPracticing1 => 'Continua a esercitarti';

  @override
  String get aiPrepRoom => 'Stanza di preparazione IA';

  @override
  String get lessonSummary => 'RIEPILOGO DELLA LEZIONE';

  @override
  String get unlockSinosparkPremium => 'Sblocca SinoSpark Premium';

  @override
  String get monthYear => 'Mese / Anno';

  @override
  String get enableNotifications => 'Attiva notifiche';

  @override
  String get notificationsConfigured => 'Notifiche configurate';

  @override
  String get neverMissAStroke2 => 'Non perdere neanche un tratto';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'I promemoria per le uscite giornaliere e le serie di studio sono pronti.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Mantieni la costanza con i contenuti quotidiani e gli avvisi tempestivi sul periodo di prova.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Una nuova parola e una storia ti attendono per il tuo momento di studio quotidiano.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Promemoria tempestivi prima che i caratteri svaniscano dalla memoria.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Ricevi un promemoria 2 giorni prima del termine della prova gratuita.';

  @override
  String get yourPathTonchineseFluency =>
      'Il tuo percorso verso la\npadronanza del cinese';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Rispondi a 3 brevi domande: la nostra IA creerà\nun percorso di studio su misura per le tue esigenze.';

  @override
  String get whatIsYourLevelnwithChinese => 'Qual è il tuo livello\ndi cinese?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Scegli il percorso più adatto alle tue conoscenze attuali.';

  @override
  String get whatDrivesYourStudy => 'Cosa ti spinge a studiare il cinese?';

  @override
  String get purposeFuelsTheBrush => 'L\'intento guida il pennello';

  @override
  String get setYourDailyRitual =>
      'Imposta la tua routine di studio quotidiana.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Puoi modificare le tue abitudini di studio in qualsiasi momento.';

  @override
  String get letsBegin => 'Iniziamo';

  @override
  String get brandNew => 'Principiante assoluto';

  @override
  String get iveNeverStudiedChineseBefore =>
      'Non ho mai studiato il cinese prima d\'ora.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Conosco i caratteri e le frasi di base.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Riesco a sostenere conversazioni semplici e a leggere.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Desidero perfezionare le mie competenze fino a raggiungere la piena padronanza.';

  @override
  String get confirmSelection => 'Conferma selezione';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'L\'intenzione dà vita al movimento del pennello.';

  @override
  String get buildMyPath => 'Crea il mio percorso';

  @override
  String get hskCertification => 'Certificazione HSK';

  @override
  String get culturalAppreciation => 'Interesse per l\'arte e la cultura';

  @override
  String get yourPlanIsReady => 'Il tuo piano è pronto';

  @override
  String get craftingYourCurriculum =>
      'Creazione del tuo piano di studi in corso...';

  @override
  String get personalizedPathInitialized => 'PERCORSO PERSONALIZZATO AVVIATO';

  @override
  String get calibratingAiNeuralMasters =>
      'CALIBRAZIONE DEI TUTOR NEURALI IA IN CORSO...';

  @override
  String get calibrationComplete => 'Calibrazione completata';

  @override
  String get synthesizingModules => 'Sintesi dei moduli didattici in corso...';

  @override
  String get oneAndWater => '«Uno» e «Acqua»';

  @override
  String get theHorizontalStroke => 'IL TRATTO ORIZZONTALE (HÉNG)';

  @override
  String get theRadical => 'IL RADICALE';

  @override
  String get water => 'Acqua';

  @override
  String get river => 'Fiume';

  @override
  String get day5Reminder => 'Promemoria 5° giorno';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Come promesso, ti avvisiamo 2 giorni prima della scadenza della prova gratuita.';

  @override
  String get continueWithoutReminder => 'Continua senza promemoria';

  @override
  String get masterChineseWithnsinospark =>
      'Padroneggia il cinese con\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Inizia la prova gratuita di 7 giorni';

  @override
  String get precisionStrokes => 'Tratti precisi';

  @override
  String get aiPronunciation => 'Pronuncia guidata dall\'IA';

  @override
  String get today => 'Oggi';

  @override
  String get fullAccess => 'Accesso completo';

  @override
  String get day5 => 'Giorno 5';

  @override
  String get reminder => 'Promemoria';

  @override
  String get day7 => 'Giorno 7';

  @override
  String get trialBegins => 'Inizio periodo di prova';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat non ha pacchetti attivi. Configura la tua dashboard.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'L\'accesso alla fotocamera è necessario per la scansione in tempo reale.';

  @override
  String get cameraAccessRequired => 'Accesso alla fotocamera richiesto';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Abilita l\'accesso alla fotocamera nelle impostazioni del dispositivo per utilizzare questa funzionalità.';

  @override
  String get alignChineseTextWithinFrame =>
      'Allinea il testo in cinese all\'interno dell\'inquadratura';

  @override
  String get inLibrary => 'Nella biblioteca';

  @override
  String get novice => 'Principiante';

  @override
  String get apprentice => 'Apprendista';

  @override
  String get artisan => 'Artigiano';

  @override
  String get grandmaster => 'Gran Maestro';

  @override
  String get poem => 'Poesia';

  @override
  String get theNarrative => 'La narrazione';

  @override
  String get classicMasterpiece => 'Capolavoro classico';

  @override
  String get classicAuthor => 'Autore classico';

  @override
  String get classical => 'Classico';

  @override
  String get classicLiterature => 'Letteratura classica';

  @override
  String inThisChapterOf(Object title) {
    return 'In questo capitolo di $title';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'Mentre la narrazione si sviluppa, emergono la profonda saggezza della vita e una fonte inesauribile di ispirazione.';

  @override
  String get general => 'Generale';

  @override
  String get mythology => 'Mitologia';

  @override
  String get dailyLife => 'Vita quotidiana';

  @override
  String get tangPoetry => 'Poesia Tang';

  @override
  String get classicalLiterature => 'Letteratura classica';

  @override
  String get justNow => 'Proprio adesso';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'L\'esercito di terracotta di Qin Shi Huang';

  @override
  String get lifeInsideTheForbiddenCity =>
      'La vita all\'interno della Città Proibita';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Acquistare un biglietto e viaggiare sui treni ad alta velocità in Cina';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Andare in ospedale per un\'influenza e farsi visitare da un medico';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Andare in un ristorante tipico per ordinare i jiaozi (ravioli)';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'La tradizionale cerimonia del tè Gongfu';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'L\'arte di tracciare i caratteri cinesi con il pennello';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'La vita e la tutela del panda gigante';

  @override
  String get storyNotFoundInDatabase => 'Storia non trovata nel database';

  @override
  String get storyTextIsEmpty => 'Il testo della storia è vuoto';

  @override
  String get myCustomStories => 'Le mie storie personalizzate';

  @override
  String get userProvidedText => 'Testo inserito dall\'utente';

  @override
  String get local => 'Locale';

  @override
  String get voiceEngineAllowance => 'Motore vocale e quota di utilizzo';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Voci Studio HD vs. Voci standard illimitate';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'La voce standard è gratuita e illimitata al 100%';

  @override
  String get read => 'Leggi';

  @override
  String get koreKoreFemaleWarm => 'Kore (femminile, accogliente)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (femminile, solare)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (maschile, vivace)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (maschile, stile notiziario)';

  @override
  String get puckPuckMaleSporty => 'Puck (maschile, sportivo)';

  @override
  String get localOndevice => 'Voce del dispositivo';

  @override
  String get localOndeviceTts => 'TTS locale del dispositivo';

  @override
  String get off => 'Disattivato';

  @override
  String get endOfCurrentChapter => 'Fine del capitolo';

  @override
  String get standardVoice => 'Voce standard';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Nessun romanzo trovato con i filtri selezionati.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Nessuna micro-lettura trovata con i filtri selezionati.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Nessuna poesia trovata con i filtri selezionati.';

  @override
  String get audiobook => 'Audiolibro';

  @override
  String get audio => 'Audio';

  @override
  String get continueReading => 'Continua a leggere';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Cerca tra 96 romanzi integrali, autori ed epopee...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Cerca poesie classiche, autori e versi...';

  @override
  String get allLevelsVal => 'Tutti i livelli';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Principiante)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Elementare)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Intermedio)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Intermedio superiore)';

  @override
  String get listenToAudiobook => 'Ascolta l\'audiolibro';

  @override
  String get synopsis => 'Sinossi';

  @override
  String get peoplesArtist => 'Artista del Popolo';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«Tono kafkiano» per descrivere l\'assurdità burocratica, l\'alienazione e l\'angoscia esistenziale.';

  @override
  String get bigBrotherAndNewspeak => '«Grande Fratello» e «Neolingua».';

  @override
  String get audiobookIncluded => 'Audiolibro incluso';

  @override
  String get readPoem => 'Leggi poesia';

  @override
  String get studioVoiceAllowance => 'Quota voci Studio HD';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Recitazione settimanale con IA in alta definizione';

  @override
  String get resetsEveryMondayAt0000 => 'Si ripristina ogni lunedì alle 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Esaurite le 4 ore settimanali di voci Studio, l\'app passa automaticamente alle voci del dispositivo per consentirti un ascolto gratuito e senza limiti.';

  @override
  String get localDeviceVoice => 'Voce del dispositivo';

  @override
  String get classicalVerse => 'Versi classici';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Voce del dispositivo (4 ore settimanali utilizzate)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Genera una storia IA personalizzata in base ai tuoi interessi';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Anziché limitarsi a un livello HSK rigido, il motore dinamico analizza i vocaboli presenti nella tua collezione di flashcard.';

  @override
  String get we => 'Noi';

  @override
  String get howCanWeHelpYou => 'Come possiamo aiutarti?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Tutto quello che c\'è da sapere su SinoSpark, le funzionalità disponibili e la tutela della privacy.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Quali sono le voci narranti presenti nell\'app?';

  @override
  String get howDoesTheWebExplorerWork => 'Come funziona l\'Esploratore Web?';

  @override
  String get whatIsZenMode => 'Cos\'è la modalità Zen?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Come funziona la ripetizione spaziata delle flashcard?';

  @override
  String get traceComplete => 'Tracciamento completato!';

  @override
  String get traceCharacter => 'Traccia il carattere';

  @override
  String get analyzingWordRelationships =>
      'Analisi delle relazioni lessicali in corso...';

  @override
  String get identifyingUsageContexts =>
      'Identificazione dei contesti d\'uso in corso...';

  @override
  String get comparingFormalityLevels =>
      'Confronto dei registri di formalità in corso...';

  @override
  String get findingCommonCollocations =>
      'Ricerca delle combinazioni di parole più frequenti...';

  @override
  String get generatingComparison =>
      'Generazione dell\'analisi comparativa in corso...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'L\'elaborazione richiede più tempo del previsto. Il server IA potrebbe essere momentaneamente sovraccarico.';

  @override
  String get generationInterruptedShowingPartial =>
      'Elaborazione interrotta. Mostro i risultati parziali disponibili.';

  @override
  String get sorrySomethingWentWrong =>
      'Ci scusiamo, si è verificato un errore imprevisto.';

  @override
  String get usage => 'Uso:';

  @override
  String get alsoSeenIn => 'Presente anche in';

  @override
  String get quickLook => 'Panoramica veloce';

  @override
  String get notFound => 'Non trovato';

  @override
  String get errorLoadingFromAi => 'Errore nel caricamento dei dati dall\'IA.';

  @override
  String get analyzingImage => 'Analisi dell\'immagine in corso...';

  @override
  String get extractingChineseText =>
      'Estrazione del testo in cinese in corso...';

  @override
  String get lookingUpVocabulary => 'Consultazione del dizionario in corso...';

  @override
  String get dreamOfTheRedChamber =>
      'Il sogno della camera rossa (Dream of the Red Chamber)';

  @override
  String get journeyToTheWest =>
      'Il viaggio in Occidente (Journey to the West)';

  @override
  String get romanceOfTheThreeKingdoms =>
      'Il romanzo dei Tre Regni (Romance of the Three Kingdoms)';

  @override
  String get mingDynasty => 'Dinastia Ming';

  @override
  String get wuChengEn => 'Wu Cheng\'en';

  @override
  String get hundredChapters => '100 capitoli';

  @override
  String get volume1 => 'Volume 1';

  @override
  String bookmarksCount(Object count) {
    return 'Segnalibri ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Ancora nessun segnalibro salvato. Tocca l\'icona del segnalibro per salvare un brano.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark non risponde';

  @override
  String get closeApp => 'Chiudi app';

  @override
  String get wait => 'Attendi';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours h';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Libro completato al $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Cap. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count libri e audiolibri';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Frase $current di $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Capitolo $current di $total';
  }

  @override
  String get allLevels => 'Tutti i livelli';

  @override
  String get searchGradedMicroStories =>
      'Cerca micro-storie graduate e favole...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count storie graduate e micro-letture quotidiane';
  }

  @override
  String get searchClassicalPoems =>
      'Cerca poesie classiche, autori e versi...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count poesie classiche e componimenti';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Naviga su qualsiasi sito web cinese con dizionario istantaneo al tocco, annotazioni pinyin e traduzione in tempo reale.';

  @override
  String get completed => 'COMPLETATO';

  @override
  String get aiIsReading => 'L\'IA sta leggendo...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Avanzato)';

  @override
  String get hsk1Beginner => 'HSK 1 (Principiante)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Intermedio superiore)';

  @override
  String get extractAllUnknownWords =>
      'Estrai tutti i vocaboli sconosciuti in un nuovo mazzo di flashcard';

  @override
  String get designCustomAiRoleplay =>
      'Progetta giochi di ruolo e conversazioni personalizzate con l\'IA';

  @override
  String get practiceFlashcardVocabulary =>
      'Esercitati con i vocaboli delle flashcard in un dialogo dal vivo';

  @override
  String get surpriseMe => 'Sorprendimi';

  @override
  String get rollCharacter => 'Scegli un personaggio casuale';

  @override
  String get historicalCostume => 'Drama storico / In costume';

  @override
  String get modernYouth => 'Moderno e giovanile';

  @override
  String get fantasyMythology => 'Fantasy e mitologia';

  @override
  String get familyDrama => 'Dramma familiare';

  @override
  String get fullVersion => 'Versione integrale';

  @override
  String episodesCount(Object count) {
    return '$count episodi';
  }

  @override
  String episodeLabel(Object number) {
    return 'Episodio $number';
  }

  @override
  String get translating => '[ Traduzione in corso... ]';

  @override
  String get engSub => '[Sottotitoli: Italiano]';

  @override
  String get standardVocabulary => 'Vocabolario standard';

  @override
  String get characters => 'caratteri';

  @override
  String get todayDashboard => 'Oggi';

  @override
  String get studyToday => 'Studia le carte di oggi';

  @override
  String get studyAhead => 'Studia in anticipo';

  @override
  String get studyAheadDescription =>
      'Esercitati sui ripassi imminenti senza consumare la quota di oggi. Non verranno introdotte nuove carte.';

  @override
  String get studyAheadComplete => 'Studio in anticipo completato';

  @override
  String get dueNow => 'Da fare ora';

  @override
  String get scheduled => 'Programmati';

  @override
  String get sevenDayForecast => 'Previsioni ripassi a 7 giorni';

  @override
  String get reviews => 'Ripassi';

  @override
  String get newCardsLabel => 'Nuove carte';

  @override
  String get attempts => 'Tentativi';

  @override
  String get duration => 'Tempo';

  @override
  String get answerBreakdown => 'Analisi risposte';

  @override
  String get reviewCards => 'Ripassa carte';

  @override
  String get retries => 'Ritentativi';

  @override
  String get needsPractice => 'Da esercitare';

  @override
  String get uniqueCardsStudied => 'Carte';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Disegna nell\'altra direzione ➔';

  @override
  String get fastClean => 'Veloce e preciso!';

  @override
  String get good2 => 'Bene!';

  @override
  String get followTheFlow => 'Segui il flusso.';

  @override
  String get masterful => 'Magistrale!';

  @override
  String get missingTheHookEnd => 'Manca l\'uncino/la fine.';

  @override
  String get thai => 'Tailandese';

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
  String get ink => 'inchiostro,';

  @override
  String get stroke => 'tratto,';

  @override
  String get breath => 'respiro.';

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
  String get theExactSentenceProvided => 'la frase esatta fornita';

  @override
  String get pinyinWithToneMarks2 => 'pinyin con segni tonali';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Estrai tutti i caratteri cinesi da questa immagine. Restituisci SOLO il testo estratto — nessun commento, nessuna formattazione, nessuna traduzione. Mantieni le interruzioni di riga. Se non ci sono caratteri cinesi, restituisci una stringa vuota.';

  @override
  String get householdObject => 'oggetto domestico';

  @override
  String get genericLabelFromTheList => 'etichetta generica dall\'elenco';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'classificatore';

  @override
  String get zenInk => 'Zen & Inchiostro';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'CRITICO: Inserisci la traduzione in inglese nella chiave JSON \"english\"!';

  @override
  String get definitionInEnglish => 'definizione in inglese';

  @override
  String get simplifiedLine0 => 'riga semplificata 0';

  @override
  String get simplifiedLine1 => 'riga semplificata 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'REGOLA IMPORTANTE: Non rivolgerti all\'utente usando alcun nome. Non usare mai nomi di esempio come \"John\". Parlagli direttamente senza usare nomi.';

  @override
  String get rULESAnswerIn23 =>
      'REGOLE: Rispondi al massimo in 2-3 frasi. Prediligi gli elenchi puntati per le liste.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Non scrivere mai introduzioni, saluti o frasi riempitive come \"Ottima domanda!\" o \"Certamente!\".';

  @override
  String get useBoldForChineseCharacters =>
      'Usa il **grassetto** per i caratteri cinesi e i termini chiave.';

  @override
  String get rULESAnswerIn232 => 'REGOLE: Rispondi al massimo in 2-3 frasi.';

  @override
  String get accept => 'Accetta';

  @override
  String get pronunciationAssessment => 'Valutazione della pronuncia';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'Nessuno';

  @override
  String get theCorrectedChineseText => 'il testo cinese corretto';

  @override
  String get thePinyinForTheCorrected => 'il pinyin per il testo corretto';

  @override
  String get theEnglishMeaningOfThe =>
      'il significato in inglese del testo corretto';

  @override
  String get pNyNWithTone => 'pīnyīn con segni di tono';

  @override
  String get englishTranslation2 => 'traduzione in inglese';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Sei un esperto di letteratura classica cinese che fornisce riassunti dettagliati e accessibili della poesia classica cinese.';

  @override
  String get youAreAChineseCulture =>
      'Sei un esperto di cultura e letteratura cinese. Fornisci approfondimenti culturali coinvolgenti e ben scritti.';

  @override
  String get english2 => 'Inglese:';

  @override
  String get remindersWhenYouHavenT =>
      'Promemoria quando non usi l\'app da qualche giorno';

  @override
  String get itSBeenAFew =>
      'Sono passati alcuni giorni! Prenditi 5 minuti per imparare un nuovo Hanzi oggi.';

  @override
  String get abbreviationFor => 'abbreviazione di';

  @override
  String get cL => 'CL:';

  @override
  String get measureWord2 => 'Classificatore:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'nessun-utente';

  @override
  String get passwordRequired => 'password-richiesta';

  @override
  String get unsupportedProvider => 'provider-non-supportato';

  @override
  String get appleRevocationUnavailable => 'revoca-apple-non-disponibile';

  @override
  String get appleCredentialMissing => 'credenziali-apple-mancanti';

  @override
  String get authenticationDidNotReturnA =>
      'L\'autenticazione non ha restituito un utente.';

  @override
  String get viewSubscriptionPlans => 'Vedi i piani di abbonamento';

  @override
  String get wrongPassword => 'password-errata';

  @override
  String get invalidCredential => 'credenziali-non-valide';

  @override
  String get networkRequestFailed => 'richiesta-di-rete-fallita';

  @override
  String get requiresRecentLogin => 'richiede-accesso-recente';

  @override
  String get userMismatch => 'mancata-corrispondenza-utente';

  @override
  String get deleteAccountPassword => 'password-eliminazione-account';

  @override
  String get deleteAccountError => 'errore-eliminazione-account';

  @override
  String get deleteAccountSubmit => 'conferma-eliminazione-account';

  @override
  String get theSimplestShapesTheBeginning =>
      'Le forme più semplici. L\'inizio di ogni cosa.';

  @override
  String get sunMoonWaterAndFire =>
      'Sole, Luna, Acqua e Fuoco. Il mondo naturale.';

  @override
  String get theBodyTheHeartAnd => 'Il corpo, il cuore e la famiglia.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Campi, tetti e utensili. Le fondamenta della società.';

  @override
  String get movementSpeechAndSustenance =>
      'Movimento, parola e sostentamento.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Commercio, abbigliamento e manufatti complessi.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Percorso rapido! Carattere semplice assimilato.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Eccellente precisione! Traccia guida saltata.';

  @override
  String get sample => 'Esempio:';

  @override
  String get itsThat => 'Suo/Quello';

  @override
  String get iMe => 'Io/Me';

  @override
  String get stillTough => 'Ancora/Duro';

  @override
  String get partDecide => 'Parte/Decidere';

  @override
  String get selectTheCharacterFor => 'Seleziona il carattere per:';

  @override
  String get selectThePinyinFor => 'Seleziona il Pinyin per:';

  @override
  String get whereAreYouGoingThe =>
      'Dove stai andando? All\'aeroporto? È un bel viaggio!';

  @override
  String get youAreAuntieChenA =>
      'Sei la zia Chen, un\'astuta venditrice al mercato di seta e tessuti. Il tuo UNICO ruolo è venditrice al mercato. Negozia i prezzi con fermezza ma in modo equo in mandarino. Non uscire MAI dal personaggio e non presentarti mai come qualcosa di diverso da una venditrice. Inizia con prezzi alti e sii disposta a trattare.';

  @override
  String get youAreDrZhangA =>
      'Sei il Dottor Zhang, un medico calmo e professionale di una clinica medica. Il tuo UNICO ruolo è quello di medico. Chiedi dei sintomi e fornisci consigli medici in mandarino. Non uscire MAI dal personaggio e non presentarti mai come qualcosa di diverso da un medico. Sii rassicurante ma scrupoloso.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Dove ti senti male? Hai la febbre?';

  @override
  String get youAreACloseFriend =>
      'Sei un caro amico che si ritrova dopo molto tempo. Il tuo UNICO ruolo è di amico. Mantieni le risposte informali, calorose e brevi in mandarino. Non uscire MAI dal personaggio e non presentarti mai come qualcosa di diverso da un amico. Usa un tono informale adatto a cari amici.';

  @override
  String get noNbest => 'nessun nbest';

  @override
  String get timedOut => 'tempo scaduto';

  @override
  String get grading => 'Valutazione...';

  @override
  String get label1st => '1° ˉ';

  @override
  String get label2nd => '2° ˊ';

  @override
  String get label3rd => '3° ˇ';

  @override
  String get label4th => '4° ˋ';

  @override
  String get speaking2 => 'Parlando...';

  @override
  String get sessionCompletedInYourNext =>
      'Sessione completata. Nella prossima esercitazione, pronuncia frasi complete per ricevere una diagnosi dettagliata di pronuncia e toni.';

  @override
  String get craneSoaring => 'gru in volo';

  @override
  String get gentleStream => 'ruscello calmo';

  @override
  String get brushAndInk => 'pennello e inchiostro';

  @override
  String get myStudent => 'mio studente';

  @override
  String get honoredDisciple => 'onorato discepolo';

  @override
  String get notEnoughInformation => 'informazioni insufficienti';

  @override
  String get asAnAi => 'come IA';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Ottima sessione di esercitazione. Continua a concentrarti sui contrasti di tono chiari e su un ritmo di conversazione naturale.';

  @override
  String get insideASleekFuxingBullet =>
      'All\'interno di un elegante treno proiettile Fuxing che viaggia a 350 km/h da Pechino a Shanghai.';

  @override
  String get harbinIceSnowWorldWonder =>
      'Meraviglioso mondo di ghiaccio e neve di Harbin';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'Il famoso mercato delle pulci del fine settimana di Panjiayuan, affollato di rotoli di calligrafia, giada e ninnoli d\'epoca.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Laboratorio di porcellana bianca e blu di Jingdezhen';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Camerino e trucco dell\'Opera di Pechino';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Una storica farmacia Tongrentang profumata di ginseng, bacche di goji e centinaia di cassetti in legno per erbe medicinali.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Una vivace sala karaoke privata al neon a Shenzhen con microfoni, piatti di frutta e comandi sullo schermo.';

  @override
  String get animeCosplayExpoInGuangzhou => 'Expo Anime & Cosplay a Guangzhou';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Sorprendimi';

  @override
  String get eGALivelyBanquet =>
      'ad es., Un vivace banchetto festoso a Shanghai...';

  @override
  String get rollCharacter2 => '🎲 Estrai personaggio';

  @override
  String get eGACuriousCousin =>
      'ad es., Un cugino curioso che ti chiede della tua carriera...';

  @override
  String get keepTrying => 'Continua a provare!';

  @override
  String get pending => 'In attesa...';

  @override
  String get expected => '🎯 Previsto';

  @override
  String get hSK2Elementary => 'HSK 2: Elementare';

  @override
  String get hSK3Intermediate => 'HSK 3: Intermedio';

  @override
  String get hSK5Advanced => 'HSK 5: Avanzato';

  @override
  String get expressYourselfFullyWith5000 =>
      'Esprimiti al meglio con oltre 5000 parole.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Illimitato';

  @override
  String get dueToday => 'Da ripassare oggi';

  @override
  String get newAvailable => 'Nuove disponibili';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Fornisci un unico consiglio breve e pratico su come migliorare la forma, la posizione o la lunghezza dei tratti disegnati male. Sii diretto e utile, senza essere troppo poetico o metaforico. Non usare il markdown.';

  @override
  String get localOnDeviceTTS => 'Locale — TTS sul dispositivo';

  @override
  String get espaOl => 'Spagnolo';

  @override
  String get franAis => 'Francese';

  @override
  String get portuguS => 'Portoghese';

  @override
  String get tiNgViT => 'Vietnamita';

  @override
  String get koreFemaleWarm => 'Kore — Femminile, calda';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Femminile, allegra';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Maschile, dinamico';

  @override
  String get charonMaleNewsStyle => 'Charon — Maschile, stile notizie';

  @override
  String get puckMaleSporty => 'Puck — Maschile, sportivo';

  @override
  String get systemVoice => 'Voce di sistema';

  @override
  String get generateAdd => 'Genera e aggiungi';

  @override
  String get moreExamples => '📝 Altri esempi';

  @override
  String get usage2 => '❓ Uso';

  @override
  String get translation => '💬 Traduzione';

  @override
  String get collocations => '📚 Collocazioni';

  @override
  String get mistakes => '❌ Errori';

  @override
  String get decrease => 'Diminuisci';

  @override
  String get increase => 'Aumenta';

  @override
  String get label0MeansThisCardType =>
      '0 significa che questo tipo di carta è disabilitato.';

  @override
  String get tapTheValueToEnter =>
      'Tocca il valore per inserire un limite esatto.';

  @override
  String get exactDailyLimit => 'Limite giornaliero esatto';

  @override
  String get enter0ToDisable => 'Inserisci 0 per disabilitare.';

  @override
  String get apply => 'Applica';

  @override
  String get selectDeck => 'Seleziona mazzo';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Chiavi Azure Speech non configurate. Aggiungi AZURE_SPEECH_KEY e AZURE_SPEECH_REGION a .env';

  @override
  String get sTARTING => 'INIZIO…';

  @override
  String get sTARTSESSION => 'INIZIA SESSIONE';

  @override
  String get translating2 => 'Traduzione in corso...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'business ed economia';

  @override
  String get hskPreparation => 'preparazione HSK';

  @override
  String get liveInChina => 'vivere in Cina';

  @override
  String get comprehensiveExercise => 'esercizio completo';

  @override
  String get howToUse => 'come usare';

  @override
  String get usesOf => 'usi di';

  @override
  String get appearedFirstOnMandarinBean => 'pubblicato prima su Mandarin Bean';

  @override
  String get news2 => 'notizie:';

  @override
  String get joke => 'barzelletta:';

  @override
  String get jokes => 'barzellette:';

  @override
  String get academicScience => 'accademico / scienza';

  @override
  String get politicsCommunism => 'politica e comunismo';

  @override
  String get foodDining => 'Cibo e ristorazione';

  @override
  String get sciFi => 'fantascienza';

  @override
  String get scienceFictionTech => 'Fantascienza e tecnologia';

  @override
  String get travelPlaces => 'Viaggi e luoghi';

  @override
  String get mythologyFantasy => 'Mitologia e fantasy';

  @override
  String get cultureTraditions => 'Cultura e tradizioni';

  @override
  String get businessEconomy => 'Business ed economia';

  @override
  String get natureAnimals => 'Natura e animali';

  @override
  String get articleImg => 'img articolo';

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
  String get xiXiPicturesOfficialChannel => 'Canale ufficiale di XiXi Pictures';

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
  String get getTheWeTVAPP => '腾讯视频 - Scarica l\'app WeTV';

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
  String get learnMandarinWithTaiwanPlus =>
      'Impara il mandarino con TaiwanPlus';

  @override
  String get everydayChinese => 'Cinese quotidiano';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting - Vita quotidiana in Cina';

  @override
  String get tFTFOODTRAVEL => 'TFT - CIBO E VIAGGI';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: La vita dell\'aglio';

  @override
  String get label2MINCULTURALCONTEXT => 'CONTESTO CULTURALE DI 2 MIN';

  @override
  String get liziqi4 => '李子柒 Liziqi: Mobili in bambù';

  @override
  String get peppaPigChinese2 => 'Peppa Pig in cinese: Pozzanghere di fango';

  @override
  String get noBBCLeadArticleIs =>
      'Nessun articolo principale della BBC è al momento disponibile.';

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
  String get thoseDays => '四喜 Quei giorni';

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
  String get noFunnyNoMoney =>
      'Se non fa ridere dormi per strada - No Funny No Money';

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
  String get getTheWeTVAPP2 => 'Tencent Video - Anime - Scarica l\'app WeTV';

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
      'Lord of Mysteries: Vlog doppiaggio di Cuttlefish (versione finale) - Tencent Video - Anime';

  @override
  String get lordOfMysteries =>
      'Lord of Mysteries: Lezione di occultismo Ep. 8 - Tencent Video - Anime';

  @override
  String get lordOfMysteries2 =>
      'Lord of Mysteries: Lezione di occultismo Ep. 7 - Tencent Video - Anime';

  @override
  String get lordOfMysteries3 =>
      'Lord of Mysteries: Lezione di occultismo Ep. 6 - Tencent Video - Anime';

  @override
  String get lordOfMysteries4 =>
      'Lord of Mysteries: Lezione di occultismo Ep. 5 - Tencent Video - Anime';

  @override
  String get lordOfMysteries5 =>
      'Lord of Mysteries: Lezione di occultismo Ep. 4 - Tencent Video - Anime';

  @override
  String get lordOfMysteries6 =>
      'Lord of Mysteries: Lezione di occultismo Ep. 3 - Tencent Video - Anime';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      'Lord of Mysteries: Lezione di occultismo Ep. 2 - Tencent Video - Anime';

  @override
  String get lordOfMysteries8 =>
      'Lord of Mysteries: Lezione di occultismo Ep. 1 - Tencent Video - Anime';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '[OST] Lord of Mysteries - Brano finale \"Non ti scordar di me\" - Tencent Video - Anime';

  @override
  String get membersPremiere2 => 'Anteprima per i membri';

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
  String get eightHundred => '方圆八百米 Ottocento';

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
      '片场彩蛋：贺思慕段胥本名难觅花名纷至【白日提灯 Love Beyond the Grave】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'BTS｜【鹅剧派对】迪丽热巴陈飞宇携众主创默契五感五连拍！【白日提灯 Love Beyond the Grave】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'BTS｜【鹅剧派对】迪丽热巴陈飞宇亮相，眼神杀直接封神！【白日提灯 Love Beyond the Grave】';

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
  String get aboutLove => '玫瑰丛生 Sull\'amore';

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
      'In «玫瑰丛生», tutti i personaggi sono immersi nella nebbia dell\'amore: come ne usciranno? | Con: Wang Ziwen, Liu Yuning';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 Di generazione in generazione';

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
  String get loveStoryInThe1970s => 'Storia d\'amore negli anni \'70';

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
  String get whyIsHeStillSingle => 'Perché è ancora single';

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
  String get theGlamorousNight => 'Notte affascinante';

  @override
  String get theGlamorousNightE03 =>
      '【Notte affascinante】E03 Mossa audace! Il contrattacco di Zhao Mei (Jiang Shuying, Tong Dawei)';

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
  String get myPageInThe90s => '突然的喜欢 My Page in the 90s';

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
      'Estratto 04: Il sistema assurdo esagera! Un fazzoletto diventa un assorbente? Che imbarazzo!【突然的喜欢 My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Estratto 03: Va all\'appuntamento al buio per l\'amica e incontra il protagonista?【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'BTS | 「Fuori dal personaggio X Chen Xingxu X Wang Yuwen」 Chi è più stravagante tra il Signor Gao e Huan\'er?【突然的喜欢 My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Estratto 02: Voleva conquistare il protagonista, ma ha sbagliato persona?【突然的喜欢 My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Estratto 01: Assurdo! Trasportata all\'improvviso in un libro? Come recito questa parte?【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'BTS | Chen Xingxu e Wang Yuwen si scontrano sui pattini【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'BTS | Chen Xingxu e Wang Yuwen festeggiano un dolce Capodanno【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'BTS | Chen Xingxu e Wang Yuwen immortalano un dolce momento per Qixi【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'BTS | Chen Xingxu e Wang Yuwen si divertono al parco giochi【突然的喜欢 My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '《My Page in the 90s》in onda da oggi: dolce storia d\'amore per Chen Xingxu e Wang Yuwen';

  @override
  String get myPageInThe90s3 =>
      '《My Page in the 90s》dal 22 gennaio: l\'amore fuori dagli schemi di Chen Xingxu e Wang Yuwen';

  @override
  String get myPageInThe90s4 =>
      '《My Page in the 90s》in arrivo il 22/01! Amore transgenerazionale per Chen Xingxu e Wang Yuwen';

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
  String get label2TheImperialCoronerS2 => '御赐小仵作2 The Imperial Coroner S2';

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
  String get theDreamMaker => 'Il costruttore di sogni The Dream Maker';

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
      '【轻年 Forever Young】E23 Martin torna nell\'hutong e viene controllato dai fratelli (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 Preciso, stabile e spietato! Martin insegna alla cognata a gestire il marito (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 C\'è un rivale in amore? Martin viene chiamato zio da un moccioso (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

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
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - Scarica l\'app iQIYI';

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
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - Scarica l\'app WeTV';

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
  String get theHiddenHeirYeChen2 => '进击的叶辰 L\'erede nascosto Ye Chen';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => '去听旷野的风 I sogni non finiscono mai';

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
      'Ecco il toccante cortometraggio a doppia trama 《Love Story negli anni \'70》~';

  @override
  String get loveStoryInThe1970s3 =>
      'Rilasciato ufficialmente il cortometraggio a due 《Love Story negli anni \'70》~ Scriviamo una lettera d\'amore con i nostri sensi';

  @override
  String get bTSLoveStoryInThe =>
      'Retroscena | Riprese concluse per il cast, al prossimo incontro 【Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《Love Story in the 1970s》L\'amore è una poesia nascosta nella quotidianità~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《Love Story in the 1970s》In onda dal 21 febbraio~';

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
  String get theTruth => 'The Truth - Tracce nel vento';

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
      'Dietro le quinte | Intervista \"Fuori dal personaggio\" — Chi è più bizzarro tra il Sig. Gao e Huan\'er? 《My Page in the 90s》 Tencent Video';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Clip 04 | Un sistema assurdo forza la trama! Fazzoletti trasformati in assorbenti? Che imbarazzo! 《My Page in the 90s》 Tencent Video';

  @override
  String get label03MyPageInThe2 =>
      'Clip 03 | Vado a un appuntamento al buio al posto della mia amica e incontro il protagonista? 《My Page in the 90s》 Tencent Video';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Clip 02 | Volevo conquistare il protagonista, ma ho sbagliato persona? 《My Page in the 90s》 Tencent Video';

  @override
  String get label01MyPageInThe2 =>
      'Clip 01 | Assurdo! Catapultata in un libro all\'improvviso? Come dovrei recitare? 《My Page in the 90s》 Tencent Video';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《My Page in the 90s》Dietro le quinte | Chen Xingxu e Wang Yuwen si scontrano sui pattini';

  @override
  String get myPageInThe90s6 =>
      '《My Page in the 90s》In onda da oggi! Chen Xingxu e Wang Yuwen dominano il sistema in una dolce storia d\'amore';

  @override
  String get bTSMyPageInThe5 =>
      'Dietro le quinte | Interazioni divertenti e intesa alle stelle tra Chen Xingxu e Wang Yuwen 【My Page in the 90s】';

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
  String get dearSecretary => 'Mia cara segretaria Dear Secretary';

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
  String get foreverYoung2 => '轻年 Per sempre giovani';

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
  String get lightOfDawn => '人之初 Luce dell\'alba';

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
  String get sniperButterfly => 'Farfalla Cecchino Sniper Butterfly';

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
      '《狙击蝴蝶 Sniper Butterfly》 In uscita il 04/12! Oltre i confini per amore';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versione completa 1-15｜Con: Chen Yanxi, Zhou Keyu | Tencent Video - Drama giovanili';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versione completa 16-30｜Con: Chen Yanxi, Zhou Keyu | Tencent Video - Drama giovanili';

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
  String get allRise => 'Subito in campo | All Rise';

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
      'La persona giusta al momento giusto | Love is Always Online';

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
  String get loveOnTheTurquoiseLand => '枭起青壤 Love on the Turquoise Land';

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
      '«Why Is He Still Single» dal 16/11! La fiaba d\'amore maturo con Wallace Huo e Zhu Zhu!';

  @override
  String get whyIsHeStillSingle3 =>
      '«Why Is He Still Single» Versione completa｜Con: Wallace Huo, Zhu Zhu - Tencent Video - Youth Theater';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '«Why Is He Still Single» Versione completa 1｜Con: Wallace Huo, Zhu Zhu - Tencent Video - Youth Theater';

  @override
  String get whyIsHeStillSingle5 =>
      '«Why Is He Still Single» Versione completa 2｜Con: Wallace Huo, Zhu Zhu - Tencent Video - Youth Theater';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => 'Fight for Love (山河枕)';

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
  String get iMNobody => 'I\'m Nobody (我本无名)';

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
  String get thePrisonerOfBeauty => 'The Prisoner of Beauty (Versione ridotta)';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '《折腰精简版 The Prisoner of Beauty》Xiao Qiao sposa il nemico al posto della sorella e si scontra con il marito fin dal primo giorno | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty3 =>
      '《折腰精简版 The Prisoner of Beauty》Xiao Qiao sventa il complotto di Liu Yan e passa con Wei Shao dallo scontrarsi al proteggersi | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty4 =>
      '《折腰精简版 The Prisoner of Beauty》Xiao Qiao finge di essere malata, Wei Shao la difende in pubblico e rifiuta concubine | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty5 =>
      '《折腰精简版 The Prisoner of Beauty》Xiao Qiao svela l\'inganno del cofanetto e Wei Shao la riconosce come padrona di casa | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty6 =>
      '《折腰精简版 The Prisoner of Beauty》Xiao Qiao smaschera con ingegno la trappola, Wei Shao difende la moglie | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty7 =>
      '《折腰精简版 The Prisoner of Beauty》Wei Yan invia una falsa lettera e nasce una crisi di fiducia per un pendente di giada | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty8 =>
      '《折腰精简版 The Prisoner of Beauty》Su Ehuang inganna Xiao Qiao, Wei Shao risolve il caso e i due si avvicinano | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty9 =>
      '《折腰精简版 The Prisoner of Beauty》Xiao Qiao e Wei Shao subiscono un attentato, lei sventa il complotto e lo salva | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '《折腰精简版 The Prisoner of Beauty》Wei Shao regala un cavallo e un fermaglio, poi va in ansia quando la moglie scompare | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty11 =>
      '《折腰精简版 The Prisoner of Beauty》Wei Shao teme che Xiao Qiao scappi, è geloso e se ne rammarica dopo essersi trasferito | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty12 =>
      '《折腰精简版 The Prisoner of Beauty》Wei Shao è geloso ma porta Xiao Qiao sulle spalle, svelando il mistero del cofanetto | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty13 =>
      '《折腰精简版 The Prisoner of Beauty》Qiao Ci fa visita alla sorella scatenando la gelosia di Wei Shao; i due si giurano amore eterno | Con: Song Zuer, Liu Yuning | Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty14 =>
      '《The Prisoner of Beauty (Versione ridotta)》Wei Yan lascia il paese per Xiao Qiao; Shao e Qiao fanno pace dopo un litigio | Con: Song Zuer, Liu Yuning | Tencent Video - Drama Giovani';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《The Prisoner of Beauty (Versione ridotta)》Ammutinamento la notte di nozze e sorelle nemiche; Xiao Qiao respinge il nemico, Wei Shao ammette l\'errore | Con: Song Zuer, Liu Yuning | Tencent Video - Drama Giovani';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《The Prisoner of Beauty (Versione ridotta)》Wei Shao accompagna Xiao Qiao a Kang County per chiarirsi; il padre di Qiao accetta il genero e la coppia consuma il matrimonio | Con: Song Zuer, Liu Yuning | Tencent Video - Drama Giovani';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《The Prisoner of Beauty (Versione ridotta)》Qiao Yue tradisce e Wei Liang muore; Da Qiao viene rapita, Bi Zhi reagisce con forza | Con: Song Zuer, Liu Yuning | Tencent Video - Drama Giovani';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《The Prisoner of Beauty (Versione ridotta)》Wei Liang muore in battaglia, Wei Qu perde un braccio; Da Qiao cade dal palazzo, Liu Yan viene distrutto | Con: Song Zuer, Liu Yuning | Tencent Video - Drama Giovani';

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
      'Troppo lenta nel lavoro di gruppo? Il CEO entra dalla finestra a mezzanotte per consegnare la presentazione, inseguito dalla sicurezza | Tencent Video - Drama Giovani';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      'Oltre mille città per incontrarti - A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video - Drama d\'epoca - Scarica l\'app WeTV';

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
  String get theInescapable => '锁簪 - The Inescapable';

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
  String get pursuitOfJade2 => '逐玉 Alla ricerca della giada';

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
      '《江湖夜雨十年灯 Generation to Generation》in uscita il 22 febbraio! Guarda la nuova generazione più forte del Jianghu, Mumu e Zhaozhao, avventurarsi insieme nel Jianghu';

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
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 I 300 spettri leali';

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
  String get danceOfThePhoenix => '且听凤鸣 La danza della fenice';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Straordinario';

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
      '《御赐小仵作2 The Imperial Coroner S2》 in uscita il 15/01, il caloroso ritorno della coppia Chu-Yu!';

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
  String get theChangAnYouth =>
      'La giovinezza di Chang\'An The Chang\'An Youth';

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
      '【有花在洲 A Flower On The Continent】 Il giovane principe in ostaggio viene scambiato per una principessa dalla ragazza Hua e costretto a vivere con lei';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】 L\'identità femminile della ragazza Hua viene svelata, il giovane principe la protegge a rischio della vita ma viene incastrato';

  @override
  String get aFlowerOnTheContinent5 =>
      '【A Flower On The Continent】 Hua Xiyu scopre che l\'assassino di suo padre è il padre di Ning Xuanzhou e rompe subito con lui';

  @override
  String get aFlowerOnTheContinent6 =>
      '【A Flower On The Continent】 Hua Xiyu indossa l\'abito da sposa, irrompe nel campo nemico e rischia la vita per salvare Ning Xuanzhou';

  @override
  String get aFlowerOnTheContinent7 =>
      '【A Flower On The Continent】 I due paesi firmano il trattato di pace, ma Ning Xuanzhou strappa l\'editto pur di sposare Hua Xiyu';

  @override
  String get aFlowerOnTheContinent8 =>
      '【A Flower On The Continent】 Hua Xiyu si taglia le vene per creare la medicina; Ning Xuanzhou denuncia il padre imperatore per l\'omicidio del padre di lei';

  @override
  String get aFlowerOnTheContinent9 =>
      '【A Flower On The Continent】 Hua Xiyu scopre che suo padre è stato ucciso dal padre di Ning Xuanzhou e spezza il ramo del loro amore nel mare di fiori';

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
  String get sliceOfLife => 'Spaccato di vita';

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
      'Raccolta highlight 【锦月如歌 Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'BTS Speciale compleanno di Zhou Ye 🎂! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'BTS Speciale compleanno di Cheng Lei 🎂! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'BTS Combattimento epico sul campo di battaglia con le due stelle di Wei 【锦月如歌 Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'BTS Programma per l\'appuntamento del 520 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'BTS Zhou Ye ubriaca e adorabile che danza con la spada, e Cheng Lei non riesce a trattenere il sorriso! 【锦月如歌 Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'Raccolta highlight 【桃花映江山 The Princess\'s Gambit】';

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
      'Clip Abito rosso sulla neve! Jiang Taohua lascia la patria per proteggere il fratellino 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'Clip Caos alla residenza Shen il giorno delle nozze? Taohua reagisce con calma e astuzia 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'Clip Taohua finge di svenire ma viene scoperta; Shen Zaiye la sveglia: \"Continua a recitare!\" 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'Clip Il Ministro Shen pugno di ferro nelle indagini! I funzionari corrotti tremano 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Clip L\'assassino mascherato non sfugge al giudizio, l\'investigatrice Taohua: \"I tuoi piedi ti hanno tradito!\" 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'Clip Interrogatorio con lo spillo! Shen Zaiye solleva il mento di Taohua e la interroga a freddo 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Clip: Primo incontro e già così audace! Shen Zaiye colpito dal veleno Huanhuan, sguardi che si incrociano 【桃花映江山 The Princess\'s Gambit】';

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
      '【COMPLETO Limitato】云襄传 | The Ingenious One | iQIYI 👑Abbonati ora e goditi tutti gli episodi!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - Scarica l\'app iQIYI';

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
      '【COMPLETO】👮ROAD HOME💕 | BoranJing, Seven Tan | iQIYI Philippines';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI Philippines - Scarica l\'app iQIYI';

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
      '【Doppiaggio AI in inglese】Mr. BAD | Chen Zheyuan, Yue Shen | iQIYI Philippines';

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
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | FULL正片 | iQIYI 👑Abbonati per guardare subito tutti gli episodi!';

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
      '【COMPLETO】🕊️My Dear Guardian |  Johnny Huang, Li Qin | iQIYI Philippines';

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
      '🌸【治愈爱情】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | COMPLETO正片 | iQIYI 👑Diventa membro e goditi tutti gli episodi ora!';

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
      '📽️【EP01 2026】Rebirth Drama Cinese  SUB ENG | Li Yunrui / Huangyang Tiantian /Zhang Kangle ⛵😍 Drama Storico 2026 #冰湖重生';

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
      '【COMPLETO】🏹Fated Hearts | Li Qin, Chen Zheyuan | iQIYI Philippines';

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
      '【Completo】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Philippines';

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
      '🎥✨【SUB ENG】Film fantasy cinese | Fantasy, Avventura【 iQIYI MOVIE THEATER - Iscriviti】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 iQIYI MOVIE THEATER - Scarica l\'app iQIYI';

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
      '🎀【Mini Drama】SUB ITA | Raccolta versione completa | Scarica l\'app WeTV / Tencent Video per guardare altro';

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
      '【Completo】Beauty of Resilience | Ju Jing Yi, Fiction | iQIYI Filippine';

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
      '🔥 In tendenza【子夜归 Moonlit Reunion】Episodi completi | Umani e demoni si innamorano mentre risolvono misteri | Xu Kai, Tian Xiwei | SUB ENG';

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
  String get fallInLove => 'innamorarsi';

  @override
  String get myGirl => 'la mia ragazza';

  @override
  String get firstRomance2 => 'primo amore';

  @override
  String get fallFor => 'invaghirsi';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Amore nascosto';

  @override
  String get loveBetweenFairyAndDevil2 => 'Love Between Fairy and Devil';

  @override
  String get loveLikeTheGalaxy2 => 'Love Like The Galaxy';

  @override
  String get myJourneyToYou2 => 'My Journey to You';

  @override
  String get mysteriousLotusCasebook2 => 'Mysterious Lotus Casebook';

  @override
  String get reset => 'Reimposta';

  @override
  String get theLongBallad2 => 'The Long Ballad';

  @override
  String get theUntamed2 => 'The Untamed';

  @override
  String get wordOfHonor2 => 'Word of Honor';

  @override
  String get lightOfDawn2 => '人之初 Luce dell\'alba';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|GUARDIANO DELLA PATRIA';

  @override
  String get searching2 => 'Ricerca in corso...';

  @override
  String get verse => 'Verso';

  @override
  String get allStories2 => 'Tutte le storie';

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
  String get char2 => '+ carattere +';

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
      'articolo, .article, .post, .content, principale';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'Intermedio superiore';

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
  String get processing => 'Elaborazione…';

  @override
  String get keepItUp => '好！Continua così';

  @override
  String get minutesDay => 'Minuti / giorno';

  @override
  String get consistencyIsTheInkThat =>
      '\"La costanza è l\'inchiostro che costruisce il carattere.\"';

  @override
  String get businessCareer => 'Lavoro e carriera';

  @override
  String get travelSurvival => 'Viaggi e sopravvivenza';

  @override
  String get label05MinDay => '05 min / giorno';

  @override
  String get label10MinDay => '10 min / giorno';

  @override
  String get label20MinDay => '20 min / giorno';

  @override
  String get label30MinDay => '30 min / giorno';

  @override
  String get dynamicDecksStrokeAnalysis =>
      'Mazzi dinamici e analisi dei tratti';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Gli abbonamenti non sono al momento disponibili. Riprova.';

  @override
  String get trialReminder => 'Promemoria della prova';

  @override
  String get turnOnNotificationsIfYou =>
      'Attiva le notifiche se desideri un promemoria prima della scadenza della prova gratuita. Le impostazioni dell\'abbonamento sull\'App Store rimangono il riferimento principale.';

  @override
  String get label2Months => '2 mesi';

  @override
  String get label3Months => '3 mesi';

  @override
  String get label6Months => '6 mesi';

  @override
  String get billingPeriod => 'periodo di fatturazione';

  @override
  String get chooseASubscription => 'Scegli un abbonamento';

  @override
  String get startFreeTrial => 'Inizia la prova gratuita';

  @override
  String get smartNewsDict => 'Notizie smart e dizionario';

  @override
  String get hSK16AIDecks => 'Mazzi HSK 1-6 e IA';

  @override
  String get continueWithTemporaryPremium => 'Continua con Premium temporaneo';

  @override
  String get testProductUnavailable => 'Prodotto di prova non disponibile';

  @override
  String get paymentIsChargedToYour =>
      'Il pagamento verrà addebitato sul tuo account App Store.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'Gli abbonamenti si rinnovano automaticamente se non annullati';

  @override
  String get atLeast24HoursBefore =>
      'almeno 24 ore prima della fine del periodo corrente.';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get closePurchaseOffer => 'Chiudi offerta';

  @override
  String get loading => 'Caricamento...';

  @override
  String get analyzingImage2 => 'Analisi dell\'immagine…';

  @override
  String get extractingChineseText2 => 'Estrazione del testo cinese…';

  @override
  String get lookingUpVocabulary2 => 'Ricerca nel vocabolario…';

  @override
  String get deselectAll => 'Deseleziona tutto';

  @override
  String get selectAll => 'Seleziona tutto';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Capolavoro della letteratura cinese e mondiale.';

  @override
  String get classic => 'Classico';

  @override
  String get literature => 'Letteratura';

  @override
  String get theOriginAwakening => 'L\'origine e il risveglio';

  @override
  String get turbulentHorizonsTheJourney => 'Orizzonti turbolenti e il viaggio';

  @override
  String get trialsTribulationsDevotion => 'Prove, tribolazioni e devozione';

  @override
  String get theClashOfWitsBravery => 'Scontro d\'ingegno e coraggio';

  @override
  String get theGrandClimaxResolution => 'Il grande climax e la risoluzione';

  @override
  String get everlastingLegacyEpilogue => 'Eredità eterna ed epilogo';

  @override
  String get acrossTheVastExpanseOf =>
      'Attraverso la vasta distesa tra cielo e terra, i personaggi perseguono il proprio destino e le proprie convinzioni tra profonde difficoltà.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Ogni dialogo e incontro racchiude la brillantezza dello spirito umano e l\'impronta della sua epoca.';

  @override
  String get followingTheFlowOfProse =>
      'Seguendo il flusso della prosa, i lettori attraversano i secoli per condividere trionfi e dolori di figure leggendarie.';

  @override
  String get preQin => 'pre-qin';

  @override
  String get theGoddessNWaRepairing => 'La dea Nüwa ripara il cielo';

  @override
  String get artsTraditions => 'Arti e tradizioni';

  @override
  String get femaleWarm => 'Femminile, calda';

  @override
  String get femaleCheerful => 'Femminile, allegra';

  @override
  String get maleUpbeat => 'Maschile, vivace';

  @override
  String get maleNewsStyle => 'Maschile, stile telegiornale';

  @override
  String get maleSporty => 'Maschile, sportivo';

  @override
  String get onDevice => 'Sul dispositivo';

  @override
  String get label15Minutes => '15 minuti';

  @override
  String get label30Minutes => '30 minuti';

  @override
  String get label45Minutes => '45 minuti';

  @override
  String get selectChapter => 'Seleziona capitolo';

  @override
  String get andContinuesToBeStudied =>
      'e continua a essere studiato e celebrato da lettori di ogni generazione.';

  @override
  String get label1Poem => '1 poesia';

  @override
  String get label1Chapter => '1 capitolo';

  @override
  String get localDeviceVoice2 => 'Voce locale del dispositivo';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Quota settimanale Azure raggiunta — passaggio alla voce locale';

  @override
  String get sleepTimer2 => '定时关闭 · Timer spegnimento';

  @override
  String get tableOfContents2 => '目录 · Indice';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Classici spagnoli, italiani e russi';

  @override
  String get englishAmericanGlobalClassics =>
      'Classici inglesi, americani e globali';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'inserendo strategicamente le parole con cui hai più difficoltà, per permetterti di impararle nel contesto.';

  @override
  String get poetryPainting => 'poesia e pittura';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Shadowing Studio è uno spazio dedicato alla pratica dell\'imitazione dei madrelingua. Ascolti una frase, ti registri mentre la ripeti e confronti le forme d\'onda e i punteggi di pronuncia per perfezionare il tuo accento.';

  @override
  String get theVoicesInAIStories =>
      'Storie IA e Gioco di ruolo usano voci sintetiche generate da modelli avanzati di sintesi vocale, ottimizzati per una pronuncia cinese chiara e naturale. In alcune funzioni può essere disponibile anche la voce locale del dispositivo.';

  @override
  String get theWebExplorerAllowsYou =>
      'Web Explorer ti permette di navigare su qualsiasi sito web cinese. Quando trovi una parola difficile, toccala per aprire la scheda di consultazione rapida, con pinyin, traduzione e livello HSK istantanei.';

  @override
  String get zenModeStripsAwayDistracting =>
      'La modalità Zen rimuove elementi di disturbo, pubblicità e layout complessi dagli articoli, offrendoti un ambiente di lettura pulito e calligrafico incentrato solo sul testo.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Utilizziamo un algoritmo intelligente che calcola quando stai per dimenticare una parola. Le parole più difficili appariranno più spesso, mentre quelle che conosci bene verranno programmate più avanti nel tempo.';

  @override
  String get usage3 => 'Uso:';

  @override
  String get tutorialOneExplanation =>
      'Questo è UNO (Yī). Traccialo sempre da sinistra a destra.';

  @override
  String get tutorialWaterExplanation =>
      'Questo è il carattere completo ACQUA (Shuǐ). Quando viene usato come componente a sinistra, si trasforma in \'氵\' (Tre Gocce)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Gli Hanzi sono composti da elementi base chiamati RADICALI, che danno al carattere il suo significato principale o tema.';

  @override
  String get tutorialLettersExplanation =>
      'Gli Hanzi non sono semplici lettere, ma immagini impresse nel tempo. Per padroneggiarli, devi imparare a seguirne il flusso.';

  @override
  String get tutorialGalaxyExplanation =>
      'La Mappa della Galassia ti aspetta. Padroneggia i Soli (Radicali) per sbloccare i Pianeti (Caratteri).';

  @override
  String get onboardingDailyLifeTravel => 'Vita quotidiana e viaggi';

  @override
  String get onboardingPhilosophyIdioms => 'Filosofia e modi di dire';

  @override
  String get onboardingBusinessCareerMulti => 'Affari e\ncarriera';

  @override
  String get onboardingTravelSurvivalMulti => 'Viaggi e\nsopravvivenza';

  @override
  String get onboardingHskCertificationMulti => 'Certificazione\nHSK';

  @override
  String get onboardingCulturalAppreciationMulti => 'Cultura e\ntradizione';

  @override
  String get practiceReminders => 'Promemoria di pratica';

  @override
  String get oneOptionalDailyReminderTo =>
      'Un promemoria giornaliero facoltativo per esercitarsi col cinese';

  @override
  String get aFewMinutesOfChinese => 'Qualche minuto di cinese? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Continua a progredire con una breve sessione di esercizio.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'studiare · imparare';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'scoprire';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'persistere';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'crescere';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'calmo · sereno';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'comprendere';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'calore · caldo';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'concentrarsi';

  @override
  String get definitionExpansionButton => 'pulsante-espansione-definizione';

  @override
  String get wenigerAnzeigen => 'Mostra meno';

  @override
  String get mostrarMenos => 'Mostra meno';

  @override
  String get afficherMoins => 'Mostra meno';

  @override
  String get mostraMeno => 'Mostra meno';

  @override
  String get showFewer => 'Mostra meno';

  @override
  String get masterLin => 'Maestro Lin';

  @override
  String get xiaoMei => 'Xiao Mei';

  @override
  String get thePoet => 'Il Poeta';

  @override
  String get aQiang => 'A-Qiang';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Formale e saggio';

  @override
  String get casualFriendly => 'Informale e amichevole';

  @override
  String get poeticAncient => 'Poetico e antico';

  @override
  String get slangInternet => 'Slang e internet';

  @override
  String get trendyModern => 'Di tendenza e moderno';

  @override
  String get designYourOwn => 'Crea il tuo';

  @override
  String get theBambooSwaysAndThe =>
      'Il bambù ondeggia e lo studioso attende le tue parole come pioggia mattutina...';

  @override
  String get yourCustomPersonaIsActive =>
      'Il tuo personaggio personalizzato è attivo. Scrivi per iniziare la conversazione.';

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
      'Risposta di espansione del dizionario obsoleta';

  @override
  String get dictionaryExpansionWasEmpty =>
      'L\'espansione del dizionario era vuota';

  @override
  String get explicationDTaillEDisponible =>
      'Spiegazione dettagliata disponibile';

  @override
  String get ausfHrlicheErklRungVerf => 'Spiegazione dettagliata disponibile';

  @override
  String get explicaciNDetalladaDisponible =>
      'Spiegazione dettagliata disponibile';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Spiegazione dettagliata disponibile';

  @override
  String get explicaODetalhadaDisponVel =>
      'Spiegazione dettagliata disponibile';

  @override
  String get detailedExplanationAvailable =>
      'Spiegazione dettagliata disponibile';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Un promemoria di esercizio giornaliero opzionale';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Scegli un promemoria di esercizio giornaliero opzionale.';

  @override
  String get practiceReminder => 'Promemoria di esercizio';

  @override
  String get oneGentleReminderADay =>
      'Un promemoria discreto al giorno, solo se ne hai bisogno';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Completare l\'esercizio disattiva il promemoria di oggi. Ripassi e';

  @override
  String get reEngagementAlertsAreCombined =>
      'avvisi di rientro sono combinati per non accumularsi mai.';

  @override
  String get processing2 => 'Elaborazione…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Ascolta';

  @override
  String get notice => 'Osserva';

  @override
  String get fourTones => 'Quattro toni';

  @override
  String get write => 'Scrivi';

  @override
  String get recap => 'Riepilogo';

  @override
  String get playbackDidNotStart => 'La riproduzione non si è avviata';

  @override
  String get audioIsUnavailableYouCan =>
      'L\'audio non è disponibile. Puoi comunque leggere e continuare.';

  @override
  String get microphoneAccessWasNotGranted =>
      'L\'accesso al microfono non è stato consentito. Puoi abilitarlo in Impostazioni.';

  @override
  String get recordingIsUnavailableRightNow =>
      'La registrazione non è disponibile al momento.';

  @override
  String get listeningToYourTones => 'Ascolto dei tuoi toni…';

  @override
  String get noRecording => 'Nessuna registrazione';

  @override
  String get weCouldNotScoreThat =>
      'Non è stato possibile valutare la registrazione, ecco un confronto dei toni di esempio.';

  @override
  String get listenForTheLowDipping => 'Ascolta il terzo tono, basso e flesso.';

  @override
  String get firstHearATinyMoment =>
      'Per prima cosa, ascolta un breve frammento in mandarino. Per ora non memorizzare.';

  @override
  String get loadingAudio => 'Caricamento audio…';

  @override
  String get listenToThePassage => 'Ascolta il brano';

  @override
  String get continueAction => 'Continua';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Osserva come significato, suono e caratteri vadano di pari passo.';

  @override
  String get shadowOneSentence => 'Fai lo shadowing di una frase';

  @override
  String get listenOnceThenHoldThe =>
      'Ascolta una volta, poi tieni premuto il microfono e pronuncia la frase.';

  @override
  String get hearItAgain => 'Riascolta';

  @override
  String get stopAndCheckMyTones => 'Interrompi e verifica i toni';

  @override
  String get useMicrophone => 'Usa il microfono';

  @override
  String get iCanTSpeakRight => 'Non posso parlare ora';

  @override
  String get tapACharacterToCompare =>
      'Tocca un carattere per confrontare il tuo tono con quello di destinazione, poi ascolta i toni 1–4.';

  @override
  String get tryHandwriting => 'Prova a scrivere a mano';

  @override
  String get seeWhatYouLearned => 'Vedi cosa hai imparato';

  @override
  String get inAFewMinutesYou =>
      'In pochi minuti hai usato lo stesso metodo alla base delle tue lezioni.';

  @override
  String get listenedToChineseInContext => 'Ascoltato il cinese nel contesto';

  @override
  String get shadowedASentence => 'Ripetuto una frase';

  @override
  String get comparedMandarinTones => 'Confrontato i toni del mandarino';

  @override
  String get practicedARealCharacter => 'Esercitato un carattere reale';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'All\'alba la pioggia leggera si è fermata. Ho aperto la finestra e ho sentito gli uccelli cantare sugli alberi. È iniziato un nuovo giorno.';

  @override
  String get learnThroughRealVideos => 'Impara con video reali';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Segui i sottotitoli interattivi, cerca le parole all\'istante e trasforma ogni video in una lezione.';

  @override
  String get videoLearningScreenshot => 'Screenshot dell\'apprendimento video';

  @override
  String get turnAnyBookIntoA =>
      'Trasforma qualsiasi libro in una lezione e audiolibro';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Leggi in modo naturale con pronuncia, definizioni e traduzione sempre a disposizione.';

  @override
  String get bookReaderScreenshot => 'Screenshot del lettore di libri';

  @override
  String get speakWithTheRightRhythm =>
      'Parla liberamente con l\'IA e toni dal vivo';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Esegui lo shadowing dell\'audio madrelingua e visualizza tutti e quattro i toni mentre la tua pronuncia migliora.';

  @override
  String get shadowingAndTonesScreenshot => 'Screenshot di shadowing e toni';

  @override
  String get understandEveryCharacter => 'Comprendi ogni carattere';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Esplora significato, pronuncia, componenti, ordine dei tratti e vocabolario utile in un solo posto.';

  @override
  String get characterDictionaryScreenshot =>
      'Schermata del dizionario dei caratteri';

  @override
  String get learnChineseWithoutLimits => 'Impara il cinese senza limiti';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Guarda, leggi, parla e comprendi il cinese con un unico compagno di studio completo.';

  @override
  String get seeWhatPremiumUnlocks => 'Scopri cosa sblocca Premium';

  @override
  String get scrollToExploreTheComplete =>
      'Scorri per esplorare l\'esperienza di apprendimento completa';

  @override
  String get cOMINGSOON => 'IN ARRIVO';

  @override
  String get guidedHandwritingPractice => 'Pratica di scrittura guidata';

  @override
  String get scannerAndLiveTranslation => 'Scanner e traduzione in tempo reale';

  @override
  String get hSK16AndAI => 'HSK 1–6 e mazzi IA';

  @override
  String get smartSpacedRepetition2 => 'Ripetizione dilazionata intelligente';

  @override
  String get progressAndStreakTracking =>
      'Monitoraggio dei progressi e della serie';

  @override
  String get learningToolsInOnePlace => 'Strumenti di studio in un unico posto';

  @override
  String get everythingIncluded => 'Tutto incluso';

  @override
  String get paymentIsChargedToYour2 =>
      'Il pagamento verrà addebitato sul tuo account App Store. L\'abbonamento si rinnova automaticamente a meno che non venga annullato almeno 24 ore prima della fine del periodo corrente.';

  @override
  String get yourFirstWeekOfTracked =>
      'La tua prima settimana di pratica monitorata';

  @override
  String get sameNumberOfCardsAs =>
      'Stesso numero di carte della settimana scorsa';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change carte rispetto alla scorsa settimana';
  }

  @override
  String get todaySPractice => 'Pratica di oggi';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Obiettivo completato: tutto il resto è un bonus.';

  @override
  String get aSmallAchievableTargetNo =>
      'Un piccolo obiettivo raggiungibile. Nessuna penalizzazione per i giorni di riposo.';

  @override
  String get thisWeek => 'Questa settimana';

  @override
  String get minutes => 'Minuti';

  @override
  String get activeDays => 'Giorni attivi';

  @override
  String dayStreakCount(int count) {
    return 'Serie di $count giorni';
  }

  @override
  String get masterChineseOneStrokeAt =>
      'Padroneggia il cinese, un tratto alla volta';

  @override
  String get dictionaryExpansionButton => 'Pulsante espansione dizionario';

  @override
  String get kIErweiterterWRterbucheintrag =>
      'Voce del dizionario ampliata dall\'IA';

  @override
  String get detalleAmpliadoPorIA => 'Dettaglio ampliato dall\'IA';

  @override
  String get dTailEnrichiParL => 'Dettaglio arricchito dall\'IA';

  @override
  String get aI => 'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get detailKamusYangDiperluasAI =>
      'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get aI2 => 'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get aI3 => 'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get detalheDeDicionRioExpandido =>
      'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get aI4 => 'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get chiTiTTI => 'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get aI5 => 'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get aIExpandedDictionaryDetail =>
      'Dettaglio del dizionario ampliato dall\'IA';

  @override
  String get cetteEntrEEstBr =>
      'Questa voce è breve. È disponibile una spiegazione dettagliata.';

  @override
  String get dieserEintragIstKurzEine =>
      'Questa voce è breve. È disponibile una spiegazione dettagliata.';

  @override
  String get estaEntradaEsBreveHay =>
      'Questa voce è breve. È disponibile una spiegazione dettagliata.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Questa voce è breve. È disponibile una spiegazione dettagliata.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Questa voce è breve. È disponibile una spiegazione dettagliata.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Questa voce del dizionario è breve. È disponibile una spiegazione dettagliata.';

  @override
  String get dVelopperEnFranAis => 'Espandi in francese';

  @override
  String get aufDeutschErweitern => 'Espandi in tedesco';

  @override
  String get ampliarEnEspaOl => 'Espandi in spagnolo';

  @override
  String get approfondisciInItaliano => 'Approfondisci in italiano';

  @override
  String get expandirEmPortuguS => 'Espandi in portoghese';

  @override
  String get expandDefinition => 'Espandi definizione';

  @override
  String get impossibleDeChargerLExplication =>
      'Impossibile caricare la spiegazione.';

  @override
  String get dieErklRungKonnteNicht => 'Impossibile caricare la spiegazione.';

  @override
  String get noSePudoCargarLa => 'Impossibile caricare la spiegazione.';

  @override
  String get impossibileCaricareLaSpiegazione =>
      'Impossibile caricare la spiegazione.';

  @override
  String get nOFoiPossVel => 'Impossibile caricare la spiegazione.';

  @override
  String get unableToLoadTheExplanation =>
      'Impossibile caricare la spiegazione.';

  @override
  String get failedToGenerateStoryN => 'Impossibile generare la storia:\\n\$e';

  @override
  String get thematic => 'Tematico';

  @override
  String get deckFlashcards => 'Mazzo (Flashcard)';

  @override
  String get searchLibraryOrTypeCustom =>
      'Cerca nella libreria o digita personalizzato';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Analisi fallita: \$e';

  @override
  String get extractionFailedE => 'Estrazione non riuscita: \$e';

  @override
  String get simplifyFailedE => 'Semplificazione fallita: \$e';

  @override
  String get translationFailedE => 'Traduzione non riuscita: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Impossibile salvare le parole estratte: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'Tu: $actual  ·  Obiettivo: $expected';
  }

  @override
  String get improveTheLocalVoice => 'Migliora la voce locale';

  @override
  String get higherQualityOfflineMandarin =>
      'Mandarino offline di qualità superiore';

  @override
  String get removeDownload => 'Rimuovi download?';

  @override
  String get removeDownload2 => 'Rimuovi download';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Femminile, calda';

  @override
  String get voiceFemaleCheerful => 'Femminile, allegra';

  @override
  String get voiceMaleUpbeat => 'Maschile, vivace';

  @override
  String get voiceMaleNewsStyle => 'Maschile, stile notiziario';

  @override
  String get voiceMaleSporty => 'Maschile, sportivo';

  @override
  String get voiceOnDeviceTts => 'Sintesi vocale sul dispositivo';

  @override
  String get voiceSystemVoice => 'Voce di sistema';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Applica le valutazioni della sessione alla Ripetizione Spaziata (modalità Parlato)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Impossibile caricare questa sezione. Riprova.';

  @override
  String get removeDownloadQuestion => 'Rimuovi download?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'Rimuovi download';

  @override
  String get removeDownloadButton => 'Rimuovi download';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'Riepilogo IA';

  @override
  String get readability => 'Leggibilità';

  @override
  String get translateAction => 'Traduci';

  @override
  String get checkingDownload => 'Verifica del download';

  @override
  String downloadingBook(int percent) {
    return 'Download: $percent%';
  }

  @override
  String get retryDownload => 'Riprova il download';

  @override
  String get downloadBook => 'Scarica libro';

  @override
  String continueChapter(int chapter) {
    return 'Continua dal capitolo $chapter';
  }

  @override
  String get downloadBookError =>
      'Impossibile scaricare questo libro. Controlla la connessione e riprova.';

  @override
  String downloadBookOffline(int count) {
    return 'Scarica il libro per leggere i suoi $count capitoli offline.';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poesie',
      one: '1 poesia',
    );
    return '$_temp0';
  }

  @override
  String get americanLiterature => 'Letteratura americana';

  @override
  String get ancientChina => 'Cina antica';

  @override
  String get britishLiterature => 'Letteratura britannica';

  @override
  String get frenchLiterature => 'Letteratura francese';

  @override
  String get germanLiterature => 'Letteratura tedesca';

  @override
  String get italianLiterature => 'Letteratura italiana';

  @override
  String get jinDynasty => 'Dinastia Jin';

  @override
  String get preQinEra => 'Epoca pre-Qin';

  @override
  String get qingDynasty => 'Dinastia Qing';

  @override
  String get republicOfChinaEra => 'Repubblica di Cina';

  @override
  String get russianLiterature => 'Letteratura russa';

  @override
  String get spanishLiterature => 'Letteratura spagnola';

  @override
  String get springAndAutumn => 'Periodo delle Primavere e degli Autunni';

  @override
  String get westernHan => 'Han occidentali';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'ad es., Un vivace banchetto di festa a Shanghai...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'ad es., Un cugino curioso che ti chiede della tua carriera...';

  @override
  String get beginFirstLesson => 'Inizia la prima lezione';

  @override
  String get exploreLibraryDirectly => 'Esplora direttamente la libreria';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'LA TUA PRIMA LEZIONE  •  $current DI $total';
  }

  @override
  String get onboardingListenInstruction =>
      'Per prima cosa, ascolta uno dei versi più celebri della letteratura cinese. Per ora non serve memorizzare.';

  @override
  String get onboardingFromGrandLibrary => 'Dalla Grande Biblioteca';

  @override
  String get onboardingArtOfWarTitleAuthor => 'L\'Arte della Guerra · Sun Tzu';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · Capitolo 3';

  @override
  String get onboardingClassicLineLabel => 'UN VERSO CLASSICO';

  @override
  String get onboardingArtOfWarTranslation =>
      '«Conosci il nemico e conosci te stesso; in cento battaglie non sarai mai in pericolo.»';

  @override
  String get onboardingNoticeMeaning =>
      'Conosci il nemico e conosci te stesso,';

  @override
  String get onboardingShadowMeaning =>
      'In cento battaglie non sarai mai in pericolo.';

  @override
  String get onboardingPracticeThisLabel => 'TI ESERCITERAI SU QUESTO';

  @override
  String get onboardingFromArtOfWarLabel => 'DALL\'ARTE DELLA GUERRA';

  @override
  String get onboardingYourPronunciationLabel => 'LA TUA PRONUNCIA';

  @override
  String get onboardingTapACharacter => 'Tocca un carattere';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'Corrisponde';

  @override
  String get onboardingCompareTones => 'Confronta i toni';

  @override
  String get onboardingToneOneHigh => 'tono 1 · alto';

  @override
  String get onboardingToneTwoRising => 'tono 2 · crescente';

  @override
  String get onboardingToneThreeDipping => 'tono 3 · modulato';

  @override
  String get onboardingToneFourFalling => 'tono 4 · decrescente';

  @override
  String get onboardingToneNotDetected => 'non rilevato';

  @override
  String get onboardingFeedbackGreatThirdTone => 'Ottimo terzo tono modulato.';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'Lascia cadere il quarto tono con decisione e rapidità.';

  @override
  String get onboardingFeedbackClearFourthTone =>
      'Quarto tono decrescente chiaro.';

  @override
  String get onboardingFeedbackStrongFourthTone =>
      'Quarto tono decrescente deciso.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return 'Traccia $character ($pinyin, «$meaning»). Segui la traccia leggera dei tratti.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count settimane',
      one: '1 settimana',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesi',
      one: '1 mese',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anni',
      one: '1 anno',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return 'Inizia la prova gratuita di $period';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return 'Abbonati a $price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'Il prodotto StoreKit selezionato include una prova gratuita idonea. Al termine della prova, si rinnoverà a $price per $period salvo annullamento.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'Impara';

  @override
  String get booksAndStudioQualityAudiobooks =>
      '86 libri classici e audiolibri con qualità da studio';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'Conversazioni con l\'IA e feedback del tono in tempo reale';

  @override
  String get interactiveVideoAndWebImmersion =>
      'Video interattivi e immersione web';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'Approfondimenti sui caratteri e pratica della scrittura a mano';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'Mazzi HSK e ripetizione dilazionata intelligente';

  @override
  String get termsOfUseEula => 'Condizioni d\'uso (EULA)';

  @override
  String get masterEveryStroke => 'Padroneggia ogni tratto';

  @override
  String get exploreTheChineseWeb => 'Esplora il web cinese';

  @override
  String get tone1Description =>
      'Mantieni il tono alto e costante come quando canti una nota.';

  @override
  String get tone2Description =>
      'Inizia a metà e fai scivolare il tono verso l\'alto come quando chiedi \'Cosa?\'';

  @override
  String get tone3Description => 'Abbassa la voce, poi risali dolcemente.';

  @override
  String get tone4Description =>
      'Abbassa il tono in modo netto e deciso, come un \'No!\' fermo.';

  @override
  String get toneNeutralDescription =>
      'Pronuncia dolcemente, brevemente e senza enfasi.';

  @override
  String get toneDiagMatch1 =>
      'Perfetto! L\'intonazione era alta, piatta e costante.';

  @override
  String get toneDiagMatch2 =>
      'Perfetto! L\'aumento dell\'intonazione era chiaro.';

  @override
  String get toneDiagMatch3 =>
      'Perfetto! La curva discendente bassa era precisa.';

  @override
  String get toneDiagMatch4 =>
      'Perfetto! La caduta netta e discendente è stata decisiva.';

  @override
  String get toneDiagMatchDefault =>
      'Perfetto! Il tono è stato pronunciato accuratamente.';

  @override
  String get toneDiag1vs2 =>
      'Hai alzato l\'intonazione (2° tono /). Mantieni la voce piatta e alta per tutta la sillaba (1° tono ˉ).';

  @override
  String get toneDiag1vs3 =>
      'Hai abbassato la voce (3° tono ˇ). Mantieni l\'intonazione stabile e alta senza abbassarla (1° tono ˉ).';

  @override
  String get toneDiag1vs4 =>
      'Hai abbassato l\'intonazione (4° tono \\). Mantieni un\'intonazione alta e costante come se cantassi una nota (1° tono ˉ).';

  @override
  String get toneDiag2vs1 =>
      'Sei rimasto piatto (1° tono ˉ). Fai scivolare l\'intonazione verso l\'alto come per chiedere \'Cosa?\' (2° tono /).';

  @override
  String get toneDiag2vs3 =>
      'Sei sceso troppo in basso (3° tono ˇ). Inizia a metà livello e sali dolcemente senza toccare il fondo (2° tono /).';

  @override
  String get toneDiag2vs4 =>
      'Hai abbassato l\'intonazione (4° tono \\). Sali verso l\'alto come se facessi una domanda (2° tono /).';

  @override
  String get toneDiag3vs1 =>
      'Sei rimasto alto e piatto (1° tono ˉ). Lascia che l\'intonazione scenda in basso nel tuo registro di petto prima di risalire (3° tono ˇ).';

  @override
  String get toneDiag3vs2 =>
      'Sei salito immediatamente (2° tono /). Assicurati di scendere prima in basso prima di risalire (3° tono ˇ).';

  @override
  String get toneDiag3vs4 =>
      'Sei sceso bruscamente senza risalire (4° tono \\). Lascia che l\'intonazione rimbalzi delicatamente alla fine (3° tono ˇ).';

  @override
  String get toneDiag4vs1 =>
      'Sei rimasto piatto (1° tono ˉ). Abbassa l\'intonazione in modo netto e deciso come un fermo \'No!\' (4° tono \\).';

  @override
  String get toneDiag4vs2 =>
      'Hai alzato l\'intonazione (2° tono /). Inizia in alto e scendi bruscamente (4° tono \\).';

  @override
  String get toneDiag4vs3 =>
      'Hai abbassato e alzato (3° tono ˇ). Scendi dritto senza risalire (4° tono \\).';

  @override
  String get toneDiagListenDiff =>
      'Ascolta i 4 toni qui sotto per sentire la differenza.';

  @override
  String get liveCallSpeaking => 'Sta parlando...';

  @override
  String get toneAccurate => 'Tono corretto';

  @override
  String get toneNeedsWork => 'Tono da migliorare';

  @override
  String get liveCallSessionCompletedFallback =>
      'Sessione completata. Nella tua prossima pratica, pronuncia frasi complete per ricevere una diagnosi dettagliata di pronuncia e toni.';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return 'Ottimo inizio con la pratica di \'$word\'. Nella prossima sessione, prova a comporre frasi complete per allenare il passaggio tra i toni e la naturalezza del parlato.';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'Ottimo impegno nella conversazione. Concentrati sul mantenere il 1° tono alto e costante (55) e il 4° tono netto e deciso (51) per migliorare la chiarezza naturale.';

  @override
  String get liveCallGoodPracticeFallback =>
      'Buona sessione di pratica. Continua a concentrarti sul contrasto chiaro tra i toni e sul ritmo naturale della conversazione.';

  @override
  String sentenceNumber(Object number) {
    return 'Frase $number';
  }

  @override
  String endlessAiStreamSentence(Object count) {
    return 'Flusso continuo di IA • Frase $count';
  }

  @override
  String get aiConsentTitle => 'Esercizi IA e Privacy';

  @override
  String get aiConsentSubtitle =>
      'SinoSpark utilizza servizi di IA di terze parti sicuri per la valutazione della pronuncia, i giochi di ruolo e gli strumenti di studio.';

  @override
  String get aiConsentDataSentTitle => 'Dati trasmessi';

  @override
  String get aiConsentDataSentBody =>
      'Registrazioni vocali, trascrizioni del parlato e richieste di studio.';

  @override
  String get aiConsentProvidersTitle => 'Servizi di IA di terze parti';

  @override
  String get aiConsentProvidersBody =>
      '• Microsoft Azure AI Speech (valutazione della pronuncia e sintesi vocale)\n• Google Gemini e DeepSeek (dialoghi di conversazione e generazione di mazzi)';

  @override
  String get aiConsentGuaranteesTitle => 'Garanzie sulla privacy';

  @override
  String get aiConsentGuaranteesBody =>
      'I tuoi dati sono crittografati in transito, elaborati in modo effimero, mai venduti e mai utilizzati per addestrare modelli IA pubblici.';

  @override
  String get aiConsentAgree => 'Accetta e usa l\'IA';

  @override
  String get aiConsentLearnMore => 'Scopri di più';

  @override
  String get viewPlans => 'Visualizza piani';

  @override
  String get authInvalidCredentials =>
      'Email o password non corretti. Se non hai un account, registrati.';

  @override
  String get authInvalidEmail => 'Inserisci un indirizzo email valido.';

  @override
  String get authEmailAlreadyInUse =>
      'Un account esiste già con questo indirizzo email.';

  @override
  String get authWeakPassword =>
      'La password deve contenere almeno 6 caratteri.';

  @override
  String get authTooManyRequests =>
      'Troppi tentativi falliti. Riprova più tardi.';

  @override
  String get authNetworkError =>
      'Errore di rete. Controlla la tua connessione.';

  @override
  String get subscriptionRequired => 'Abbonamento richiesto';

  @override
  String get subscriptionRequiredDesc =>
      'È richiesto un abbonamento attivo a SinoSpark per accedere a tutte le lezioni, ai libri e agli strumenti vocali IA.';

  @override
  String signedInAs(String email) {
    return 'Connesso come $email';
  }

  @override
  String get battle => 'Battaglia';

  @override
  String addedWordsAndUpdatedWords(
      int addedCount, int updatedCount, String deckName) {
    return 'Aggiunte $addedCount nuove parole, aggiornate $updatedCount parole esistenti in «$deckName»';
  }

  @override
  String addedWordsToDeck(int count, String deckName) {
    return 'Aggiunte $count parole a «$deckName»';
  }

  @override
  String updatedWordsInDeck(int count, String deckName) {
    return 'Aggiornate $count parole esistenti in «$deckName»';
  }

  @override
  String addedCardToDeck(String hanzi, String deckName) {
    return '«$hanzi» aggiunto a «$deckName»';
  }

  @override
  String get callCategory => 'CHIAMATA DAL VIVO';

  @override
  String get aiCallFluencyTitle => 'Chiamate IA per migliorare la fluidità';

  @override
  String get aiCallFluencyDesc =>
      'Partecipa a conversazioni vocali realistiche con tutor IA, ricevi una valutazione istantanea dei toni e sviluppa scioltezza nel parlato.';

  @override
  String get decksCategory => 'MAZZI';

  @override
  String get decksSpacedRepetitionTitle => 'Mazzi con ripetizione spaziata';

  @override
  String get decksSpacedRepetitionDesc =>
      'Padroneggia l\'HSK 1–6 e mazzi personalizzati con algoritmi di ripetizione spaziata scientificamente provati.';

  @override
  String get booksCategory => 'LIBRI';

  @override
  String get classicalBooksPoemsTitle => '86 libri classici e 100 poesie';

  @override
  String get classicalBooksPoemsDesc =>
      'Immergiti nella letteratura e nella poesia senza tempo con audio sincronizzato e annotazioni bilingui.';

  @override
  String get scanCategory => 'SCANNER';

  @override
  String get scannerScanCardsTitle =>
      'Scansiona immagini e aggiungi carte al mazzo';

  @override
  String get scannerScanCardsDesc =>
      'Punta la fotocamera su testi in cinese, menu o cartelli per estrarre istantaneamente parole e salvarle nei tuoi mazzi.';

  @override
  String get smartDictionaryStrokeOrderTitle =>
      'Dizionario intelligente con ordine dei tratti';

  @override
  String get liveAiVoiceCallsAndToneGrading =>
      'Chiamate vocali con IA dal vivo e valutazione istantanea dei toni';

  @override
  String get shadowingStudioAndToneAnalysis =>
      'Studio di shadowing e analisi visiva dei toni';

  @override
  String get startMy7DaysFreeTrial => 'Inizia i miei 7 giorni gratuiti';

  @override
  String trialSubtextUnderCta(String price, String period) {
    return 'Poi $price / $period. Annulla in qualsiasi momento in Impostazioni.';
  }

  @override
  String get deckLibraryTitle => 'Libreria dei mazzi';

  @override
  String get deckLibrarySubtitle =>
      'Collezioni curate su HSK, cultura, sport e studio';

  @override
  String get downloadOfficialDecks =>
      'Scarica i mazzi ufficiali HSK e tematici';

  @override
  String wordsSelectedCount(int selected, int total) {
    return '$selected di $total parole selezionate';
  }

  @override
  String get comparisonLabel => 'CONFRONTO';

  @override
  String get ambientSoundscape => 'Paesaggio sonoro';

  @override
  String get ambientSoundscapeDesc =>
      'Atmosfera rilassante per leggere e ascoltare';

  @override
  String get ambientSoundscapeOff => 'Disattivato (Silenzioso)';

  @override
  String get soundscapeCourtyardRain => 'Pioggia nel cortile';

  @override
  String get soundscapeGuqinWind => 'Guqin e vento di bambù';

  @override
  String get soundscapeMidnightZen => 'Meditazione notturna';

  @override
  String get ambientVolume => 'Volume di sottofondo';

  @override
  String get rateSinoSpark => 'Valuta SinoSpark';

  @override
  String get rateSinoSparkDesc => 'Condividi la tua opinione su App Store';

  @override
  String get sendFeedback => 'Invia feedback';

  @override
  String get sendFeedbackDesc => 'Aiutaci a migliorare o segnala un problema';

  @override
  String get enjoyingAppTitle => 'Ti piace SinoSpark?';

  @override
  String get enjoyingAppSubtitle =>
      'Come sta andando il tuo percorso di apprendimento del cinese?';

  @override
  String get ratingLovingIt => 'Sì, lo adoro!';

  @override
  String get ratingCouldBeBetter => 'Potrebbe essere migliore';

  @override
  String get dictionarySearchFailed =>
      'La ricerca nel dizionario non è riuscita. Riprova.';

  @override
  String get tapToHearVoiceSample => 'Tocca ▶ per ascoltare un esempio';

  @override
  String get soundEffects => 'Effetti sonori';

  @override
  String get soundEffectsDesc =>
      'Carta morbida, sigillo di legno e suoni di calligrafia';

  @override
  String get generatingYourScenario => 'Creazione del tuo scenario…';

  @override
  String get failedToGenerateScenario =>
      'Non siamo riusciti a creare questo scenario. Riprova.';

  @override
  String get trickyCharacters => 'Caratteri difficili';

  @override
  String get strongestCharacters => 'Caratteri più solidi';

  @override
  String get newThisWeek => 'Nuovi negli ultimi 7 giorni';

  @override
  String get averageAttemptsPerWord => 'Tentativi medi per parola';

  @override
  String get noCardsYet => 'Ancora nessuna carta in questo mazzo';

  @override
  String get libraryFilterOfficialHsk => 'HSK ufficiale';

  @override
  String get libraryFilterCulture => 'Cultura';

  @override
  String get libraryFilterSports => 'Sport';

  @override
  String get libraryFilterEducation => 'Istruzione';

  @override
  String get libraryFilterTravel => 'Viaggi';

  @override
  String get libraryFilterBusiness => 'Affari';

  @override
  String get librarySearchHint => 'Cerca mazzi, argomenti o parole hanzi...';

  @override
  String libraryNoMatch(String query) {
    return 'Nessun mazzo trovato per “$query”';
  }

  @override
  String get libraryResetFilters => 'Reimposta filtri';

  @override
  String get shelfHskTitle => 'Programma ufficiale HSK';

  @override
  String get shelfHskSubtitle => 'Standard ufficiali di cinese (HSK 1 - 6)';

  @override
  String get shelfCultureTitle => 'Cultura e patrimonio';

  @override
  String get shelfCultureSubtitle =>
      'Arti tradizionali, benessere MTC, tè e festività';

  @override
  String get shelfSportsTitle => 'Sport e arti marziali';

  @override
  String get shelfSportsSubtitle =>
      'Wushu kung fu, sport con la palla, palestra e atletica';

  @override
  String get shelfEducationTitle => 'Istruzione e accademia';

  @override
  String get shelfEducationSubtitle =>
      'Ricerca, scienza, tecnologia e linguistica';

  @override
  String get shelfTravelTitle => 'Viaggi e vita urbana';

  @override
  String get shelfTravelSubtitle =>
      'Cinese di sopravvivenza, ristoranti, shopping e metro';

  @override
  String get shelfBusinessTitle => 'Affari e professionale';

  @override
  String get shelfBusinessSubtitle =>
      'Contratti, negoziazione, lavoro e finanza globale';

  @override
  String get shelfInstalled => 'Installato in libreria';

  @override
  String get shelfAvailable => 'Disponibile per il download';

  @override
  String shelfSampleVocabulary(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Vocabolario di esempio ($countString parole)';
  }

  @override
  String get shelfRemoveFromBookshelf => 'Rimuovi dalla libreria';

  @override
  String get shelfDownloadInstall => 'Scarica e installa mazzo';

  @override
  String get shelfGetButton => 'Ottieni';

  @override
  String shelfDeckCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString mazzi';
  }

  @override
  String shelfAddedThematic(String title) {
    return '“$title” è stato aggiunto alla libreria.';
  }

  @override
  String shelfRemovedThematic(String title) {
    return '“$title” rimosso.';
  }

  @override
  String get hskDescription1 =>
      'Impara 154 hanzi di base, saluti quotidiani, numeri e frasi semplici.';

  @override
  String get hskDescription2 =>
      'Impara 162 parole elementari per la comunicazione quotidiana.';

  @override
  String get hskDescription3 =>
      'Impara 299 parole intermedie per conversare con disinvoltura.';

  @override
  String get hskDescription4 =>
      'Impara 602 parole di livello intermedio-alto per discutere con madrelingua.';

  @override
  String get hskDescription5 =>
      'Impara 1.300 parole avanzate per leggere giornali, riviste e film.';

  @override
  String get hskDescription6 =>
      'Impara 2.500 parole per capire qualsiasi cinese ed esprimere sfumature.';

  @override
  String get storyCategoryIdiomStories => 'Storie di modi di dire';

  @override
  String get storyCategoryContemporaryStories => 'Storie contemporanee';

  @override
  String get storyCategoryClassicalLiterature => 'Letteratura classica';

  @override
  String get storyCategoryEnglishWorld => 'Inglese e mondo';

  @override
  String get storyCategoryFrenchClassics => 'Classici francesi';

  @override
  String get storyCategoryAncientPhilosophy => 'Filosofia antica';

  @override
  String get storyCategoryModernChinese => 'Cinese moderno';

  @override
  String get storyCategoryGermanClassics => 'Classici tedeschi';

  @override
  String get storyCategorySpanishWorld => 'Spagnolo e mondo';

  @override
  String get storyCategoryChineseEpics => 'Epiche cinesi';

  @override
  String get storyCategorySupernaturalFolklore => 'Soprannaturale e folclore';

  @override
  String get storyCategoryChinesePoetry => 'Poesia cinese';

  @override
  String get tutorChooseDeck =>
      'Da quale mazzo deve prendere le domande il quiz?';

  @override
  String tutorQuizProposal(int count, String deck) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Posso creare un quiz di $count elementi da $deck.',
      one: 'Posso creare un quiz con un solo elemento da $deck.',
    );
    return '$_temp0 Ogni elemento proviene da quel mazzo, nulla è inventato.';
  }

  @override
  String tutorCharacterIntro(String hanzi) {
    return 'Ecco come è costruito $hanzi e come si scrive.';
  }

  @override
  String get tutorFallbackIntro =>
      'Chiedimi di un carattere: ti mostrerò come è costruito e come si scrive, oppure chiedimi un quiz su uno dei tuoi mazzi.';

  @override
  String tutorComponentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count componenti',
      one: '1 componente',
    );
    return '$_temp0';
  }

  @override
  String tutorQuizFolderName(String deck) {
    return '$deck — Quiz';
  }

  @override
  String get tutorAnsweredLocally => 'Risposta dai tuoi dati.';

  @override
  String get tutorOpenQuiz => 'Apri quiz';

  @override
  String get tutorSavedToLibrary => 'Salvato nella tua Libreria dei mazzi.';

  @override
  String examTitle(int level) {
    return 'Test di pratica HSK $level';
  }

  @override
  String examNotOfficial(int level) {
    return 'Un test di pratica nell\'ambito HSK $level. Non è un test HSK ufficiale né un punteggio HSK.';
  }

  @override
  String get examStart => 'Inizia il test';

  @override
  String get examSectionListening => 'Comprensione orale';

  @override
  String get examSectionWriting => 'Produzione scritta';

  @override
  String examPassMark(int percent) {
    return 'Soglia di superamento: $percent %';
  }

  @override
  String examQuestionProgress(int index, int total) {
    return 'Domanda $index di $total';
  }

  @override
  String get examTimeUp => 'Il tempo per questa sezione è scaduto.';

  @override
  String get examChooseAnAnswer => 'Scegli prima una risposta.';

  @override
  String get examPromptAudio => 'Quale carattere hai sentito?';

  @override
  String get examPromptMeaning => 'Che cosa significa?';

  @override
  String get examPromptPinyin => 'Come si pronuncia?';

  @override
  String get examPromptFill => 'Quale parola completa la frase?';

  @override
  String get examPromptTone => 'Quale tono hai sentito?';

  @override
  String get examPromptDictation => 'Ascolta e digita il pinyin.';

  @override
  String get examHintPinyin => 'es. hao3 o hǎo';

  @override
  String get examPromptOrder => 'Metti le parole nell\'ordine giusto.';

  @override
  String get examPromptGrammar => 'Quale frase contiene un errore?';

  @override
  String get examReplay => 'Riproduci di nuovo';

  @override
  String get examPassed => 'Superato';

  @override
  String get examNotPassed => 'Non superato';

  @override
  String tutorReadingPack(int level) {
    return 'Pacchetto di lettura HSK $level';
  }

  @override
  String get tutorInUse => 'In uso';

  @override
  String get tutorFromYourCards => 'Dalle tue carte';

  @override
  String get tutorReviewSprint => 'Ripasso di oggi';

  @override
  String get tutorOpenStory => 'Leggi la storia';

  @override
  String tutorStoryQuestions(int count) {
    return 'Domande sul testo ($count)';
  }

  @override
  String get tutorNothingDue => 'Al momento non c\'è nulla da ripassare.';

  @override
  String get tutorMakeFailed =>
      'Non è stato possibile crearlo. Riprova tra poco.';

  @override
  String get examHistory => 'I tuoi esami';

  @override
  String examPracticeMissed(int count) {
    return 'Rispondi di nuovo a queste $count';
  }

  @override
  String examPracticeWriting(int count) {
    return 'Scrivi i $count caratteri';
  }

  @override
  String examPreviousScore(int score, int total) {
    return 'Il tuo miglior risultato: $score/$total';
  }

  @override
  String examDropped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi non sono stati creati e sono stati omessi.',
      one: '1 elemento non è stato creato ed è stato omesso.',
    );
    return '$_temp0';
  }

  @override
  String examStudyMissed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Studia i $count elementi sbagliati',
      one: 'Studia l\'elemento sbagliato',
    );
    return '$_temp0';
  }

  @override
  String get examAllCorrect => 'Tutto corretto.';

  @override
  String examMissedDeckName(int level) {
    return 'HSK $level — da ripassare';
  }

  @override
  String examTitleDeck(String deck) {
    return '$deck — test di pratica';
  }

  @override
  String examFromDeck(String deck) {
    return 'Un test di pratica creato dal tuo mazzo $deck. Non è un test HSK ufficiale né un punteggio HSK.';
  }

  @override
  String get storyCategoryTangPoetry => 'Poesia Tang';
}
