// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get originStoryChip => '📜 Origin story';

  @override
  String get ancientFormChip => '🏺 Ancient form';

  @override
  String get threeMoreWordsChip => '📖 3 more words';

  @override
  String get wordFamilyChip => '🔗 Word family';

  @override
  String get idiomChip => '🀄 Idiom';

  @override
  String get proverbChip => '💬 Proverb';

  @override
  String get strokeOrderChip => '✏️ Stroke order';

  @override
  String get calligraphyTipChip => '🎨 Calligraphy tip';

  @override
  String get grammarNoteChip => '📝 Grammar note';

  @override
  String get similarWordsChip => '🔄 Similar words';

  @override
  String get culturalNoteChip => '🏮 Cultural note';

  @override
  String get inMediaChip => '🀄 In media';

  @override
  String get radicalMeaningChip => '🧩 Radical meaning';

  @override
  String get componentBreakdownChip => '🔍 Component breakdown';

  @override
  String get toneTipChip => '🎵 Tone tip';

  @override
  String get homophonesChip => '👯 Homophones';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Ask me anything about $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'AI tutor error: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'The AI tutor is busy right now. Please wait a moment and try again.';

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
  String get studySession => 'Study session';

  @override
  String get readyToStudy => 'Ready to study';

  @override
  String get studyQueuePreviewDescription =>
      'Your session is based on today\'s schedule and deck limits.';

  @override
  String get notNow => 'Not now';

  @override
  String get newLabel => 'Nuovo';

  @override
  String get studyDeckEmpty => 'This deck is empty';

  @override
  String get studyDeckEmptyDescription =>
      'Add cards before starting a study session.';

  @override
  String get studyDailyLimitReached => 'Today\'s limit is complete';

  @override
  String get studyDailyLimitReachedDescription =>
      'You\'ve used this deck\'s new-card or review allowance for today.';

  @override
  String get studyCaughtUpDescription =>
      'Nothing else is scheduled for today. Come back for the next review.';

  @override
  String get noCardsAvailable => 'No cards available';

  @override
  String get studyNoEligibleCardsDescription =>
      'No cards are eligible for this study mode right now.';

  @override
  String get studySessionLoadFailed =>
      'Unable to load this study session. Please try again.';

  @override
  String get retryLimitReached => 'This card will return in your next session.';

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
    return 'Aggiungi a ';
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
      'Se l\'IA rileva una discrepanza, ti chiederà: «Intendevi dire...?». Puoi toccare il pulsante «Sì, rivalutami!» per valutare nuovamente l\'audio originale senza dover parlare di nuovo.';

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
  String get library => 'Ruang Baca Budaya (文化书房)';

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
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'OBIETTIVI';

  @override
  String get openInYoutube => 'Apri su YouTube';

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
  String play(Object pinyin) {
    return 'Riproduci ($pinyin)';
  }

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
  String get aiDataPrivacyTitle => 'AI Data & Privacy';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'See what AI features send, why, and to whom';

  @override
  String get aiDataPrivacyOverviewTitle => 'When AI is used';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark uses cloud AI only when you choose a feature that needs it, such as AI chat, explanations, translation, image analysis, speech recognition, pronunciation grading, or cloud voices. AI output can be inaccurate, so review important results.';

  @override
  String get aiDataPrivacyProvidersTitle => 'AI service providers';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini processes generative text and image requests. OpenRouter routes some generative requests to Google Gemini or DeepSeek. Microsoft Azure AI Speech processes speech recognition, pronunciation assessment, and text sent for cloud voice synthesis.';

  @override
  String get aiDataPrivacySentTitle => 'Data that may be sent';

  @override
  String get aiDataPrivacySentBody =>
      'Depending on the feature, we send the text you enter or select, relevant conversation or lesson context, images you choose for AI analysis, voice recordings you submit, and technical request data such as IP address and device/network metadata. We do not intentionally include your name or email in AI prompts.';

  @override
  String get aiDataPrivacyControlsTitle => 'Your choices';

  @override
  String get aiDataPrivacyControlsBody =>
      'Do not use an AI feature if you do not want its input sent to the named provider. You can deny camera, photo, or microphone permission in device Settings. Choose the Local voice to keep text-to-speech on your device. Avoid submitting sensitive or confidential information.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Storage and retention';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark does not intentionally store raw AI prompts, submitted images, or voice recordings on its own servers after processing. Generated results may be saved on your device or with your account when you choose to save them. Providers process data under their own terms and configured retention controls; see the full policy for details.';

  @override
  String get readFullPrivacyPolicy => 'Read Full Privacy Policy';

  @override
  String get linkOpenFailed => 'Could not open the link. Please try again.';

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
  String get vlog => '中国 日常 vlog';

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
      'Cosa succede se l\'IA capisce male ciò che intendevo dire?';

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
      'Le tue conversazioni in Echo Hall sono salvate localmente sul dispositivo in modo da poterle riascoltare in qualsiasi momento. I tuoi dialoghi personali non vengono mai utilizzati per addestrare i nostri modelli di intelligenza artificiale.';

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
      'No. Quando utilizzi Echo Hall, il Verdetto dell\'Erudito o lo Studio di Shadowing, il tuo audio viene analizzato in modo sicuro in tempo reale per calcolare il punteggio di pronuncia e viene immediatamente eliminato. Conserviamo esclusivamente le metriche numeriche per monitorare i tuoi progressi.';

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
  String get roleplay => 'Gioco di ruolo (Roleplay)';

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
  String get bookmarkRemoved => '书签已移除 · Segnalibro rimosso';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Segnalibro aggiunto: Capitolo $chapter';
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
  String get report => 'Report';

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
  String get required => 'Obbligatorio';

  @override
  String get library1 => 'Biblioteca';

  @override
  String get youAreAPremiumMember => 'Sei un membro Premium';

  @override
  String get createAccountToSyncProgress =>
      'Crea un account per sincronizzare i progressi';

  @override
  String get signOut => 'Disconnetti';

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
  String get drama => 'Drama';

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
  String get liveOverlay => 'SCHERMATA LIVE';

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
  String get todayDashboard => 'Today';

  @override
  String get studyToday => 'Study today\'s cards';

  @override
  String get studyAhead => 'Study ahead';

  @override
  String get studyAheadDescription =>
      'Practice the nearest scheduled reviews without using today\'s quota. No new cards are introduced.';

  @override
  String get studyAheadComplete => 'Study-ahead practice complete';

  @override
  String get dueNow => 'Due now';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get sevenDayForecast => '7-day review forecast';

  @override
  String get reviews => 'Reviews';

  @override
  String get newCardsLabel => 'New cards';

  @override
  String get attempts => 'Attempts';

  @override
  String get duration => 'Time';

  @override
  String get answerBreakdown => 'Answer breakdown';

  @override
  String get reviewCards => 'Review cards';

  @override
  String get retries => 'Retries';

  @override
  String get needsPractice => 'Needs practice';

  @override
  String get uniqueCardsStudied => 'Cards';
}
