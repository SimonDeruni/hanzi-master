// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get originStoryChip => '📜 Histoire d\'origine';

  @override
  String get ancientFormChip => '🏺 Forme ancienne';

  @override
  String get threeMoreWordsChip => '📖 3 autres mots';

  @override
  String get wordFamilyChip => '🔗 Famille de mots';

  @override
  String get idiomChip => '🀄 Expression';

  @override
  String get proverbChip => '💬 Proverbe';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'Existe-t-il un idiome chinois (成语) contenant ce caractère ?';

  @override
  String get strokeOrderChip => '✏️ Ordre des traits';

  @override
  String get calligraphyTipChip => '🎨 Conseil calligraphie';

  @override
  String get grammarNoteChip => '📝 Note de grammaire';

  @override
  String get similarWordsChip => '🔄 Mots similaires';

  @override
  String get culturalNoteChip => '🏮 Note culturelle';

  @override
  String get inMediaChip => '🀄 Dans les médias';

  @override
  String get radicalMeaningChip => '🧩 Sens du radical';

  @override
  String get componentBreakdownChip => '🔍 Décomposition';

  @override
  String get toneTipChip => '🎵 Conseil de ton';

  @override
  String get homophonesChip => '👯 Homophones';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Posez-moi vos questions sur $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'Erreur du tuteur IA : $error';
  }

  @override
  String get aiTutorRateLimit =>
      'Le tuteur IA est occupé pour le moment. Veuillez patienter un instant et réessayer.';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountSubtitle => 'Supprimer définitivement votre compte';

  @override
  String get deleteAccountTitle => 'Supprimer définitivement votre compte ?';

  @override
  String get accountDataDeletedTitle =>
      'Les données du compte seront supprimées';

  @override
  String get accountDataDeletedBody =>
      'Votre compte de connexion et les informations détenues par SinoSpark seront définitivement supprimés. Cette action est irréversible.';

  @override
  String get localDataKeptTitle =>
      'Les données de cet appareil seront conservées';

  @override
  String get localDataKeptBody =>
      'La progression, les téléchargements et les préférences stockés uniquement sur cet appareil ne seront pas supprimés.';

  @override
  String get subscriptionNotCanceledTitle =>
      'Les abonnements ne sont pas annulés';

  @override
  String get subscriptionNotCanceledBody =>
      'Supprimer votre compte n\'annule pas un abonnement App Store. Il peut continuer à se renouveler jusqu\'à son annulation auprès d\'Apple.';

  @override
  String get manageSubscription => 'Gérer l\'abonnement App Store';

  @override
  String get subscriptionManagementFailed =>
      'Impossible d\'ouvrir la gestion des abonnements Apple. Ouvrez Réglages, touchez votre nom, puis Abonnements.';

  @override
  String get confirmPassword => 'Mot de passe actuel';

  @override
  String get confirmPasswordToDelete =>
      'Saisissez votre mot de passe pour confirmer votre identité.';

  @override
  String get deleteAccountPermanently => 'Supprimer définitivement le compte';

  @override
  String get deleteAccountFinalTitle => 'Confirmation finale';

  @override
  String get deleteAccountFinalWarning =>
      'Votre compte sera définitivement supprimé. Cette action est irréversible. Les données stockées uniquement sur cet appareil resteront. Continuer ?';

  @override
  String get deletingAccount => 'Suppression du compte...';

  @override
  String get accountPasswordRequired =>
      'Saisissez votre mot de passe actuel pour continuer.';

  @override
  String get accountPasswordIncorrect =>
      'Le mot de passe est incorrect. Réessayez.';

  @override
  String get accountReauthenticationCanceled =>
      'La confirmation d\'identité a été annulée. Votre compte n\'a pas été supprimé.';

  @override
  String get accountReauthenticationFailed =>
      'Impossible de confirmer votre identité. Réessayez et terminez la connexion.';

  @override
  String get accountAlreadySignedOut =>
      'Vous êtes déjà déconnecté. Aucun compte n\'a été supprimé.';

  @override
  String get accountProviderUnsupported =>
      'Cette méthode de connexion ne peut pas être vérifiée dans l\'app. Contactez l\'assistance.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'Pour des raisons de sécurité, un compte lié à Apple doit être supprimé sur un appareil Apple.';

  @override
  String get accountDeletionNetworkError =>
      'Vérifiez votre connexion Internet et réessayez de supprimer le compte.';

  @override
  String get accountDeletionFailed =>
      'Le compte n\'a pas pu être supprimé et reste actif. Réessayez.';

  @override
  String get accountDeletedSuccessfully =>
      'Votre compte a été définitivement supprimé.';

  @override
  String get globalMastery => 'MAÎTRISE GLOBALE';

  @override
  String get masteredCards => 'Maîtrisées';

  @override
  String get hsk1Candidate => 'Candidat HSK 1';

  @override
  String get hsk2Candidate => 'Candidat HSK 2';

  @override
  String get hsk3Candidate => 'Candidat HSK 3';

  @override
  String get hsk4Candidate => 'Candidat HSK 4';

  @override
  String get hsk5Candidate => 'Candidat HSK 5';

  @override
  String get hsk6Candidate => 'Candidat HSK 6';

  @override
  String get hsk6Master => 'Maître HSK 6';

  @override
  String get currentRank => 'RANG ACTUEL';

  @override
  String get next => 'Suivant';

  @override
  String get searchHanziOrPinyin => 'Rechercher Hanzi ou Pinyin...';

  @override
  String get dailyReview => 'Révision Quotidienne';

  @override
  String get upcomingForecast => 'Prochaines sessions';

  @override
  String get laterToday => 'Plus tard';

  @override
  String get tomorrow => 'Demain';

  @override
  String get next7Days => '7 Prochains Jours';

  @override
  String get theScholarWay => 'La Voie du savant';

  @override
  String get beginJourney => 'Commencer';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get darkModeDesc => 'Doux pour les yeux';

  @override
  String get voiceSpeed => 'Vitesse Vocale';

  @override
  String get artAndIntellect => 'ART ET INTELLIGENCE';

  @override
  String get theDigitalScholar => 'L\'Érudit Numérique';

  @override
  String get refineBrushVoice =>
      'Perfectionnez votre pinceau et votre voix avec l\'IA.';

  @override
  String get liveVoiceCall => 'Appel Vocal Direct';

  @override
  String get immersiveRoleplay => 'Jeu de rôle avec avatars IA';

  @override
  String get readingRoom => 'Salle de Lecture';

  @override
  String get shadowingStudio => 'Studio de Répétition';

  @override
  String get errorPrefix => 'Erreur: ';

  @override
  String get initializingLibrary => 'Initialisation...';

  @override
  String get unlockCharactersToQuiz => 'Débloquez 4 caractères pour un quiz!';

  @override
  String get practiceQuiz => 'QUIZ';

  @override
  String get curriculumPaths => 'PARCOURS';

  @override
  String get noDecksFound => 'Aucun deck. Ajoutez-en!';

  @override
  String get addCardsFirst => 'Ajoutez des cartes!';

  @override
  String get aiDraftingPath => 'L\'IA prépare votre parcours...';

  @override
  String get pathReady => 'Parcours prêt!';

  @override
  String get errorGeneratingPath => 'Erreur';

  @override
  String get brushingCurriculum => 'Création du parcours...';

  @override
  String get warmUp => 'ÉCHAUFFEMENT';

  @override
  String get lessonComplete => 'Leçon Terminée! +10 Points d\'Encre';

  @override
  String get step1Origin => 'ÉTAPE 1: L\'ORIGINE';

  @override
  String get traceRadical => 'Tracez le Radical';

  @override
  String get step2Forge => 'ÉTAPE 2: LA FORGE';

  @override
  String get chooseEssence => 'Choisissez l\'Essence';

  @override
  String get wrongEssence => 'Faux! Réessayez.';

  @override
  String get step3Hunt => 'ÉTAPE 3: LA CHASSE';

  @override
  String get findCharacters => 'Trouvez les caractères';

  @override
  String get notThatOne => 'Pas celui-là!';

  @override
  String get successfullyInstalled => 'Installé:';

  @override
  String get failedToDownload => 'Échec du téléchargement.';

  @override
  String get rescindTitle => 'Révoquer?';

  @override
  String get removeCharactersWarning => 'Cela supprimera ces caractères.';

  @override
  String get cancel => 'Annuler';

  @override
  String get uninstall => 'Désinstaller';

  @override
  String get removedLibrary => 'Supprimé:';

  @override
  String get tomeLibrary => 'Bibliothèque';

  @override
  String get libraryError => 'Erreur Bibliothèque';

  @override
  String get installTome => 'INSTALLER';

  @override
  String get unitIntro => 'INTRO UNITÉ';

  @override
  String get constellationCluster => 'Amas Constellation';

  @override
  String get ok => 'OK';

  @override
  String get divingInto => 'Plongée dans...';

  @override
  String get keyRadicals => 'RADICAUX';

  @override
  String get noRadicalData => 'Aucune donnée.';

  @override
  String get discovery => 'DÉCOUVERTE';

  @override
  String get startLearning => 'COMMENCER';

  @override
  String get selectPersona => 'Choisir Persona';

  @override
  String get customPersona => 'Persona Personnalisé';

  @override
  String get geminiLiveCall => 'APPEL EN DIRECT';

  @override
  String get returnToMenu => 'Retour';

  @override
  String get strokeAnalysis => 'Analyse des traits';

  @override
  String get excellentWork => 'Excellent travail !';

  @override
  String get keepPracticing => 'Continuez à vous entraîner !';

  @override
  String get drawingSubmitted => 'Dessin soumis';

  @override
  String get customPersonaHint => 'Définissez un persona personnalisé...';

  @override
  String get stepOneOrigin => 'ÉTAPE 1 : L\'ORIGINE';

  @override
  String get stepTwoForge => 'ÉTAPE 2 : LA FORGE';

  @override
  String get toForge => 'Forger';

  @override
  String get whatEssenceDoesNeed => 'quelle essence';

  @override
  String get need => 'a besoin';

  @override
  String get forged => 'FORGÉ';

  @override
  String get stepThreeHunt => 'ÉTAPE 3 : LA CHASSE';

  @override
  String get findCharactersWith => 'Trouvez les caractères avec';

  @override
  String get uninstallButton => 'DÉSINSTALLER';

  @override
  String get gradedAiStories => 'Histoires IA par niveau';

  @override
  String get calligraphy => 'Calligraphie';

  @override
  String get theScrollOfOrigin => 'Le Parchemin d\'Origine';

  @override
  String get galaxyOf => 'Galaxie de';

  @override
  String get constellationDescription => 'Description de la constellation';

  @override
  String get noRadicalDataAvailable => 'Aucune donnée de radical disponible';

  @override
  String get learningPreferences => 'Préférences d\'apprentissage';

  @override
  String get hardMode => 'Mode difficile';

  @override
  String get hardModeDesc => 'Description du mode difficile';

  @override
  String get adaptiveGuidance => 'Guidage adaptatif';

  @override
  String get dailyGoal => 'Objectif quotidien';

  @override
  String get audioAndHaptics => 'Audio et haptique';

  @override
  String get autoPlayAudio => 'Lecture audio automatique';

  @override
  String get autoPlayDesc => 'Description de la lecture automatique';

  @override
  String get haptics => 'Haptique';

  @override
  String get displayAndContent => 'Affichage et contenu';

  @override
  String get useEnglishDefinitions => 'Utiliser les définitions anglaises';

  @override
  String get useEnglishDefinitionsDesc =>
      'Les définitions anglaises sont généralement plus précises et détaillées';

  @override
  String get animationSpeed => 'Vitesse d\'animation';

  @override
  String get manageTomes => 'Gérer les tomes';

  @override
  String get manageTomesDesc => 'Description de la gestion des tomes';

  @override
  String get dangerZone => 'Zone dangereuse';

  @override
  String get resetAllData => 'Réinitialiser toutes les données';

  @override
  String get resetDataDesc =>
      'Cela supprimera définitivement toutes vos données de progression, statistiques et paramètres. Cette action est irréversible.';

  @override
  String get areYouSure => 'Êtes-vous sûr ?';

  @override
  String get cannotBeUndone => 'Ne peut pas être annulé';

  @override
  String get deleteEverything => 'Tout supprimer';

  @override
  String get appLanguage => 'Langue de l\'application';

  @override
  String get howDidYouDo => 'Auto-évaluation';

  @override
  String get missedItEntirely => 'Complètement raté';

  @override
  String get gotItButStruggled => 'Réussi, mais avec difficulté';

  @override
  String get gotItClearly => 'Facile';

  @override
  String get perfectAndImmediate => 'Parfait et immédiat';

  @override
  String get again => 'Encore';

  @override
  String get hard => 'Difficile';

  @override
  String get good => 'Bien';

  @override
  String get easy => 'Facile';

  @override
  String get tapToReveal => 'Appuyez pour révéler';

  @override
  String get howWellDidYouRemember => 'À quel point vous en souvenez-vous ?';

  @override
  String get completelyForgot => 'Complètement oublié';

  @override
  String get gotItWithDifficulty => 'Réussi avec difficulté';

  @override
  String get recalledCorrectly => 'Bien mémorisé';

  @override
  String get perfectRecall => 'Mémorisation parfaite';

  @override
  String get practiceWriting => 'Pratiquer l\'écriture';

  @override
  String get hideScratchpad => 'Masquer le bloc-notes';

  @override
  String get whatCharacterMeans => 'Ce que signifie le caractère :';

  @override
  String get tapCardToReveal => 'Appuyez sur la carte pour révéler';

  @override
  String get ratePronunciationConfidence =>
      'Évaluez votre confiance en prononciation';

  @override
  String get botchedIt => 'Totalement raté';

  @override
  String get struggledWithTones => 'J\'ai eu du mal avec les tons';

  @override
  String get acceptable => 'Acceptable';

  @override
  String get perfectlyNatural => 'Parfaitement naturel';

  @override
  String get sessionComplete => 'Session terminée !';

  @override
  String get accuracy => 'Précision';

  @override
  String get reviewed => 'Révisé';

  @override
  String get correct => 'Correct';

  @override
  String get backToLibrary => 'Retour à la bibliothèque';

  @override
  String get revealAnswer => 'Révéler la réponse';

  @override
  String get aiHubTitle => 'Centre IA';

  @override
  String get textChat => 'Chat textuel';

  @override
  String get scholarlyPersonas => 'Personnages érudits';

  @override
  String get shadowing => 'Technique de Répétition';

  @override
  String get liveTranslation => 'Traduction en direct';

  @override
  String get scholarsLibrary => 'La Bibliothèque du Savant';

  @override
  String get generate => 'Générer';

  @override
  String get searchPinyinHanziEnglish =>
      'Rechercher Pinyin, Hanzi une définition...';

  @override
  String get liveTranslate => 'Traduire en direct';

  @override
  String get travelInterpreter => 'Interprète de voyage';

  @override
  String get realTimeSplitScreen =>
      'Conversation en temps réel en écran partagé avec un locuteur natif. Élimine instantanément les barrières linguistiques.';

  @override
  String get whisperEarpiece => 'Écouteur Traducteur';

  @override
  String get listenToChineseAudio =>
      'Écoutez l\'audio chinois et obtenez des sous-titres en français en temps réel directement sur votre écran.';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get yourMindIsClear => 'Votre esprit est serein.';

  @override
  String get noReviewsDueToday => 'Aucune révision prévue aujourd\'hui.';

  @override
  String get done => 'Terminé';

  @override
  String get hskLevel1 => 'Niveau HSK 1';

  @override
  String get hskLevel2 => 'Niveau HSK 2';

  @override
  String get hskLevel3 => 'Niveau HSK 3';

  @override
  String get hskLevel4 => 'Niveau HSK 4';

  @override
  String get hskLevel5 => 'Niveau HSK 5';

  @override
  String get hskLevel6 => 'Niveau HSK 6';

  @override
  String get generalVocabulary => 'Vocabulaire général';

  @override
  String cardsRequireAttention(Object count) {
    return 'cartes nécessitent une attention.';
  }

  @override
  String get begin => 'Commencer';

  @override
  String get poweredByAi =>
      'Propulsé par une IA avancée. Traduction fluide en temps réel pour toutes les situations.';

  @override
  String get downloadingModel => 'Téléchargement du modèle...';

  @override
  String get soon => 'BIENTÔT';

  @override
  String get installed => 'INSTALLÉ';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'MODULE PRINCIPAL';

  @override
  String get step6Context => 'ÉTAPE 6: CONTEXTE';

  @override
  String get tapBuildingBlocksTo =>
      'Touchez les blocs de construction pour explorer leur origine.';

  @override
  String get initiateRadicalSequence => 'INITIER LA SÉQUENCE RADICALE';

  @override
  String get holdToTalk => 'Maintenir pour parler';

  @override
  String get customScenario => 'Scénario personnalisé';

  @override
  String get voiceCall => 'Appel vocal';

  @override
  String get pronunciation => 'Prononciation';

  @override
  String get selectAScenarioTo =>
      'Sélectionnez un scénario pour pratiquer votre mandarin parlé. Le savant évaluera vos tons et votre clarté.';

  @override
  String get create => 'Créer';

  @override
  String get createYourScenario => 'Créez votre scénario';

  @override
  String get difficulty => 'Difficulté';

  @override
  String get scholarsVerdict => 'VERDICT DU SAVANT';

  @override
  String get completeReview => 'Revoir entièrement';

  @override
  String get conversationReview => 'RÉVISION DE LA CONVERSATION';

  @override
  String get linguisticAnalysis => 'Analyse linguistique';

  @override
  String get examplesInHsk1 => 'EXEMPLES EN HSK 1';

  @override
  String get characterReference => 'Référence de caractère';

  @override
  String get askTutor => 'Demander au tuteur';

  @override
  String get addToStudyDeck => 'Ajouter au deck d\'étude';

  @override
  String get startPractice => 'COMMENCER LA PRATIQUE';

  @override
  String get noOtherHsk1 =>
      'Aucun autre caractère HSK 1 n\'utilise ce radical.';

  @override
  String get couldNotLoadAi =>
      'Impossible de charger le contexte de l\'IA. (Limite de requêtes atteinte ou erreur réseau)\nTouchez le bouton d\'actualisation ci-dessous pour réessayer plus tard.';

  @override
  String get noAvailableCardsFound => 'Aucune carte disponible';

  @override
  String get addCards => 'Ajouter des cartes';

  @override
  String get removeCard => 'Supprimer la carte';

  @override
  String get remove => 'Supprimer';

  @override
  String get review => 'Réviser';

  @override
  String get story => 'Histoire';

  @override
  String get thisDeckIsEmpty => 'Ce paquet est vide.';

  @override
  String get tapTheAddCards => 'Appuyez sur le bouton Ajouter des cartes!';

  @override
  String get noCardsFound => 'Aucune carte trouvée.';

  @override
  String get addCardsToSee => 'Ajoutez des cartes pour voir les statistiques.';

  @override
  String get aiGenerated => 'Généré par l\'IA';

  @override
  String get allCardsCaughtUp =>
      'Toutes les cartes sont à jour! Excellent travail.';

  @override
  String get latestDiscoveries => 'Dernières découvertes';

  @override
  String get noCharactersInLexicon =>
      'Aucun caractère dans le lexique pour l\'instant.';

  @override
  String get yourBookshelf => 'Votre bibliothèque';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Recherchez dans votre dictionnaire...';

  @override
  String get saveCard => 'Enregistrer la carte';

  @override
  String get noCharactersFound => 'Aucun caractère trouvé.';

  @override
  String get radicalsIndex => 'Index des radicaux';

  @override
  String get masteringRadicalsIsThe =>
      'Maîtriser les radicaux est la clé pour déverrouiller des milliers de Hanzi. Sélectionnez un radical pour voir tous les caractères qui l\'utilisent.';

  @override
  String get noRadicalsFound => 'Aucun radical trouvé.';

  @override
  String get yourDrawing => 'Votre dessin';

  @override
  String get reference => 'Référence';

  @override
  String get rateYourRecall => 'Évaluez votre mémorisation';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String get reportBugsOrRequest =>
      'Signaler des bugs ou demander des fonctionnalités';

  @override
  String get allDataHasBeen => 'Toutes les données ont été effacées.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Ma progression';

  @override
  String get overview => 'Aperçu';

  @override
  String get aiStory => 'Histoire IA';

  @override
  String get usingYourDecksVocabulary =>
      'En utilisant le vocabulaire de votre paquet';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get translate => 'Traduire';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Traduction complète';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash structure votre histoire...';

  @override
  String get aiDeckGenerator => 'Générateur de paquets IA';

  @override
  String get whatDoYouWant => 'Que voulez-vous apprendre?';

  @override
  String get targetDifficulty => 'Difficulté cible';

  @override
  String get focusArea => 'Domaine d\'intérêt';

  @override
  String get specificContextOrTone => 'Contexte ou ton spécifique (Facultatif)';

  @override
  String get numberOfCards => 'Nombre de cartes';

  @override
  String get generateDeck => 'Générer le deck';

  @override
  String get aiGrammarExplanation => 'Explication grammaticale IA';

  @override
  String get scholarsDesk => 'Bureau du savant';

  @override
  String get chooseADeck => 'Choisissez un paquet';

  @override
  String get whereWouldYouLike =>
      'Où souhaitez-vous enregistrer ce caractère ?';

  @override
  String get addToDefaultStudy => 'Ajouter au paquet d\'étude par défaut';

  @override
  String get ifOffItsOnly =>
      'Si désactivé, il est uniquement enregistré dans le dictionnaire global';

  @override
  String get saveToLibrary => 'Enregistrer dans la bibliothèque';

  @override
  String get pleaseEnterValidChinese =>
      'Veuillez entrer des caractères chinois valides';

  @override
  String get reviewAiCard => 'Examiner la carte IA';

  @override
  String get pleaseDoublecheckTheAis =>
      'Veuillez revérifier le résultat de l\'IA ci-dessous. N\'hésitez pas à ajuster le pinyin ou la définition avant de l\'enregistrer dans votre bibliothèque permanente.';

  @override
  String get alreadyInYourLibrary => 'Déjà dans votre bibliothèque!';

  @override
  String get meaningInContext => 'Sens en contexte';

  @override
  String get explainGrammar => 'Expliquer la grammaire';

  @override
  String get addToLibrary => 'Ajouter à la bibliothèque';

  @override
  String get masterYourMandarinPronunciation =>
      'Maîtrisez votre prononciation du mandarin en imitant le discours natif en temps réel.';

  @override
  String get startSession => 'COMMENCER LA SESSION';

  @override
  String get sessionHistory => 'Historique des sessions';

  @override
  String get noSavedSessions => 'Aucune session enregistrée.';

  @override
  String get aiBreakdown => 'Analyse IA';

  @override
  String get sessionDetails => 'Détails de la session';

  @override
  String partner(Object lang) {
    return 'Partenaire ((lang))';
  }

  @override
  String get youEnglish => 'Vous (Français)';

  @override
  String get noTranscriptToSave => 'Aucune transcription à enregistrer!';

  @override
  String get sessionSaved => 'Session enregistrée!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Traduction bidirectionnelle en temps réel. Parlez français ou mandarin, et il traduira instantanément pour vous et votre partenaire.';

  @override
  String get text_1782026184665 => 'Enregistrement';

  @override
  String get recording => 'Enregistrement';

  @override
  String get yourSilentCompanionListen =>
      'Votre compagnon silencieux. Écoutez le mandarin et entendez la traduction instantanément.';

  @override
  String get startListening => 'COMMENCER L\'ÉCOUTE';

  @override
  String get skip => 'Passer';

  @override
  String get independentStars => 'ÉTOILES INDÉPENDANTES';

  @override
  String get notEveryCharacterHas =>
      'Tous les caractères n\'ont pas de radical parent. Certains sont des pictogrammes uniques ou autonomes.';

  @override
  String get onTheMapWe =>
      'Sur la carte, nous regroupons ces caractères indépendants en CONSTELLATIONS (✨).';

  @override
  String get iUnderstand => 'JE COMPRENDS';

  @override
  String get whatAreRadicals => 'QUE SONT LES RADICAUX?';

  @override
  String get hanziAreBuiltFrom =>
      'Les Hanzi sont construits à partir de blocs de construction appelés RADICAUX.\n\nIls donnent au caractère son sens ou son thème principal.';

  @override
  String get continueText => 'CONTINUER';

  @override
  String get hanziAreNotJust =>
      'Les Hanzi ne sont pas seulement des lettres. Ce sont des images figées dans le temps.\n\nPour les maîtriser, vous devez apprendre à tracer leur flux.';

  @override
  String get iAmReady => 'JE SUIS PRÊT';

  @override
  String get youAreAScholar => 'VOUS ÊTES UN SAVANT';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'La carte galactique vous attend.\nMaîtrisez les Soleils (Radicaux) pour débloquer les Planètes (Caractères).';

  @override
  String get enterTheScroll => 'ENTRER DANS LE PARCHEMIN';

  @override
  String get openingTheOriginScroll => 'Ouverture du Parchemin d\'Origine...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'L\'édition du savant';

  @override
  String get weArePreparingThe =>
      'Nous préparons l\'édition du savant pour le lancement.';

  @override
  String get devBypassUnlockNow => 'DÉVERROUILLAGE DEV: DÉBLOQUER MAINTENANT';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get welcomeScholarTheScroll =>
      'Bienvenue, Savant. Le parchemin est entièrement ouvert à vous.';

  @override
  String get purchasesRestoredSuccessfully => 'Achats restaurés avec succès.';

  @override
  String get noPreviousPurchasesFound =>
      'Aucun achat précédent n\'a été trouvé sur ce compte.';

  @override
  String get unlockTheFullPotential =>
      'Débloquez tout le potentiel de votre voyage. Un achat unique, accessible à vie.';

  @override
  String get universalScanner => 'Scanner Universel';

  @override
  String get noChineseCharactersFound =>
      'Aucun caractère chinois trouvé dans l\'image.';

  @override
  String get addedNewCharactersTo =>
      'Nouveaux caractères ajoutés à votre bibliothèque!';

  @override
  String get extractingTextAndObjects => 'Extraction de texte et d\'objets...';

  @override
  String get scanATextbookSign =>
      'Scannez un manuel, un panneau ou un objet pour extraire des caractères chinois.';

  @override
  String get extractedText => 'Texte extrait';

  @override
  String get useText => 'Utiliser le texte';

  @override
  String get noMatchingDictionaryEntries =>
      'Aucune entrée de dictionnaire correspondante trouvée.';

  @override
  String get quizComplete => 'Quiz terminé!';

  @override
  String get returnToCourse => 'Retour au cours';

  @override
  String get notEnoughCardsFor =>
      'Pas assez de cartes pour un quiz! Il en faut au moins 4.';

  @override
  String get creatorMode => 'Mode Créateur';

  @override
  String get noStoriesFoundMatching =>
      'Aucune histoire trouvée correspondant à votre recherche.';

  @override
  String get discard => 'Abandonner';

  @override
  String get save => 'Enregistrer';

  @override
  String get generatingStoryViaDeepseek =>
      'Génération de l\'histoire via DeepSeek...';

  @override
  String get storySavedToLibrary =>
      'Histoire enregistrée dans la bibliothèque!';

  @override
  String get storyNotFound => 'Histoire non trouvée.';

  @override
  String get targetHskLevel => 'Niveau HSK cible';

  @override
  String get wedLoveToHear => 'Nous aimerions avoir de vos nouvelles!';

  @override
  String get whetherYouveFoundA =>
      'Que ce soit pour signaler un bug, suggérer une fonctionnalité ou simplement nous passer le bonjour, vos commentaires nous aident à améliorer SinoSpark.';

  @override
  String get pointYourCameraAt =>
      'Dirigez votre appareil photo vers des objets';

  @override
  String get reviewAddToLibrary => 'Revoir et Ajouter à la bibliothèque';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Masquer le guide de traits à la série: (streak)';
  }

  @override
  String inkPoints(Object points) {
    return '(points) Points d\'Encre';
  }

  @override
  String speechRateMultiplier(Object rate) {
    return '(rate)x';
  }

  @override
  String animationSpeedMultiplier(Object rate) {
    return '(rate)x';
  }

  @override
  String get supportAndFeedback => 'Support et commentaires';

  @override
  String get reportBug => 'Signaler un bug';

  @override
  String get suggestFeature => 'Suggérer une fonctionnalité';

  @override
  String get generalFeedback => 'Commentaires généraux';

  @override
  String get pleaseDrawSomethingFirst =>
      'Veuillez d\'abord dessiner quelque chose';

  @override
  String get drawThisCharacter => 'Dessinez ce caractère :';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Suivez le guide bleu pour dessiner le trait (current) sur (total)';
  }

  @override
  String get skipCurrentStroke => 'Passer le trait actuel';

  @override
  String get submitDrawing => 'Valider le dessin';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '(hanzi) ajouté à (deckName)';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '(hanzi) retiré du paquet';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'Ignoré \"(hanzi)\" - Aucune donnée de trait disponible pour ce caractère d\'IA.';
  }

  @override
  String get startingSession => 'Démarrage de la session...';

  @override
  String get studySession => 'Session d\'étude';

  @override
  String get readyToStudy => 'Prêt à étudier';

  @override
  String get studyQueuePreviewDescription =>
      'Votre session est basée sur le programme du jour et les limites du paquet.';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String get newLabel => 'Nouveau';

  @override
  String get studyDeckEmpty => 'Ce paquet est vide';

  @override
  String get studyDeckEmptyDescription =>
      'Ajoutez des cartes avant de commencer une session d\'étude.';

  @override
  String get studyDailyLimitReached => 'Limite quotidienne atteinte';

  @override
  String get studyDailyLimitReachedDescription =>
      'Vous avez utilisé votre quota de nouvelles cartes ou de révisions pour ce paquet aujourd\'hui.';

  @override
  String get studyCaughtUpDescription =>
      'Rien d\'autre n\'est prévu aujourd\'hui. Revenez pour la prochaine session de révision.';

  @override
  String get noCardsAvailable => 'Aucune carte disponible';

  @override
  String get studyNoEligibleCardsDescription =>
      'Aucune carte n\'est éligible pour ce mode d\'étude pour le moment.';

  @override
  String get studySessionLoadFailed =>
      'Impossible de charger cette session d\'étude. Veuillez réessayer.';

  @override
  String get retryLimitReached =>
      'Cette carte reviendra lors de votre prochaine session.';

  @override
  String get masterBuildingBlocks =>
      'Maîtrisez les éléments constitutifs des Hanzi';

  @override
  String get totalWords => 'Total de mots';

  @override
  String get newInk => 'Nouvelle encre';

  @override
  String get learningStatus => 'En cours';

  @override
  String get masteredStatus => 'Maîtrisé';

  @override
  String get libraryMastery => 'Maîtrise de la bibliothèque';

  @override
  String get accuracyByMode => 'Précision par mode';

  @override
  String get upcomingReviews => 'Révisions à venir (7 prochains jours)';

  @override
  String get culturalReadingRoom => '文化书房 (Salle de lecture culturelle)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '(title) (HSK (level))';
  }

  @override
  String get pleaseEnterTopic => 'Veuillez entrer un sujet';

  @override
  String createdDeckCards(Object count, Object name) {
    return '(name) créé avec (count) cartes !';
  }

  @override
  String gradeResult(Object grade) {
    return 'Note : (grade)';
  }

  @override
  String get listeningMode => 'Mode Écoute';

  @override
  String get readingMode => 'Mode Lecture';

  @override
  String get recallMode => 'Mode Rappel';

  @override
  String get speakingMode => 'Mode Oral';

  @override
  String get aiMemoryHook => 'Ancrage Mémoriel IA';

  @override
  String get exampleSentences => 'Phrases d\'Exemple';

  @override
  String get ghostCharacters => 'Caractères Fantômes';

  @override
  String get commonWords => 'Mots Courants';

  @override
  String get personalNotes => 'Notes Personnelles';

  @override
  String get addPersonalNotes =>
      'Ajoutez vos moyens mnémotechniques ou notes ici...';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get gallery => 'Galerie';

  @override
  String get arLens => 'Mode RA';

  @override
  String addedCharToLibrary(Object char) {
    return '(char) ajouté à la bibliothèque';
  }

  @override
  String get scoreText => 'score';

  @override
  String get searchDictionaryHint =>
      'Rechercher caractère, pinyin ou signification...';

  @override
  String get searchDeckHint => 'Rechercher caractère, pinyin...';

  @override
  String get localRestaurant => 'Restaurant local';

  @override
  String get taxiToAirport => 'Taxi pour l\'aéroport';

  @override
  String get silkMarketHaggling => 'Marchandage au marché de la soie';

  @override
  String get medicalClinic => 'Clinique médicale';

  @override
  String get meetingAFriend => 'Rencontrer un ami';

  @override
  String get jobInterview => 'Entretien d\'embauche';

  @override
  String get searchRadicalsHint => 'Rechercher des radicaux (par ex. Eau, 氵)';

  @override
  String get definition => 'Définition';

  @override
  String get undo => 'ANNULER';

  @override
  String get hanziMaster => 'Maître Hanzi';

  @override
  String get unlockForever => 'Débloquer à vie - 9,99 \$';

  @override
  String get clear => 'Effacer';

  @override
  String get clearChat => 'Effacer la conversation';

  @override
  String get typeMessage => 'Tapez votre message...';

  @override
  String addedToLibrary(Object hanzi) {
    return '\'(hanzi)\' ajouté à votre bibliothèque';
  }

  @override
  String get generateNewStory => 'Générer une nouvelle histoire';

  @override
  String failedToGenerateStory(Object error) {
    return 'Échec de la génération de l\'histoire :\n(error)';
  }

  @override
  String get detail => 'Détail';

  @override
  String get scanText => 'Scanner du texte';

  @override
  String get createMagic => 'Créer de la magie';

  @override
  String get learning => 'Apprentissage';

  @override
  String get upcomingReviews7Days => 'Révisions à venir (7 prochains jours)';

  @override
  String get askFollowUpQuestion => 'Poser une question complémentaire...';

  @override
  String get pasteScanToSimplify =>
      'Coller ou scanner le texte chinois pour le simplifier';

  @override
  String get searchStoriesHint =>
      'Rechercher des histoires par titre ou tags (ex. mythologie, voyage)';

  @override
  String get importAll => 'Tout importer';

  @override
  String get ascendAll => 'Tout faire monter de niveau';

  @override
  String get startAscension => 'Démarrer l\'ascension';

  @override
  String get scenarioLocalRestaurant => 'Restaurant local';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Entraînez-vous à commander des plats et à demander des recommandations.';

  @override
  String get scenarioTaxiAirport => 'Taxi à l\'aéroport';

  @override
  String get scenarioTaxiAirportDesc =>
      'Indiquez votre destination au chauffeur et discutez du trafic.';

  @override
  String get scenarioSilkMarket => 'Négociation au marché de la soie';

  @override
  String get scenarioSilkMarketDesc =>
      'Essayez d\'obtenir un meilleur prix pour un souvenir.';

  @override
  String get scenarioMedicalClinic => 'Clinique médicale';

  @override
  String get scenarioMedicalClinicDesc =>
      'Expliquez vos symptômes à un médecin traditionnel.';

  @override
  String get scenarioMeetingFriend => 'Rencontrer un ami';

  @override
  String get scenarioMeetingFriendDesc =>
      'Présentez-vous et faites la conversation.';

  @override
  String get scenarioJobInterview => 'Entretien d\'embauche';

  @override
  String get scenarioJobInterviewDesc =>
      'Postulez à un poste dans une entreprise technologique à Shanghai.';

  @override
  String get createCustomScenario => 'Créer un scénario personnalisé';

  @override
  String get customScenarioTitleHint => 'Titre (ex: Réception de mariage)';

  @override
  String get customScenarioDescHint => 'Description (Contexte)';

  @override
  String get customScenarioPersonaHint =>
      'Persona IA (ex: Un collègue curieux)';

  @override
  String get customScenarioDifficulty => 'Difficulté';

  @override
  String get createAction => 'Créer';

  @override
  String get cancelAction => 'Annuler';

  @override
  String get mythsAndLegends => 'Mythes et légendes';

  @override
  String get historyAndCulture => 'Histoire et culture';

  @override
  String get idiomsTitle => 'Idiomes (成语)';

  @override
  String get theMonkeyKing => 'Le roi singe';

  @override
  String get theMonkeyKingDesc => 'Sun Wukong (La Pérégrination vers l\'Ouest)';

  @override
  String get huaMulan => 'Hua Mulan';

  @override
  String get huaMulanDesc =>
      'Hua Mulan rejoignant l\'armée à la place de son père';

  @override
  String get confuciusTitle => 'Confucius';

  @override
  String get confuciusDesc => 'La vie et les enseignements de Confucius';

  @override
  String get theGreatWall => 'La Grande Muraille';

  @override
  String get theGreatWallDesc =>
      'La construction de la Grande Muraille de Chine';

  @override
  String get generateTopic => 'Générer un sujet';

  @override
  String get simplifyText => 'Simplifier le texte';

  @override
  String get topicHint => 'Sujet (ex: Les extraterrestres à Pékin)';

  @override
  String get tagsHint => 'Mots-clés (séparés par des virgules, facultatif)';

  @override
  String get speakWithMasterLin => 'Parler avec Maître Lin';

  @override
  String get masterLinGreeting =>
      'Salutations, élève. L\'encre est prête. Quel caractère ou quelle phrase allons-nous examiner aujourd\'hui?';

  @override
  String get typeYourMessage => 'Tapez votre message...';

  @override
  String get theMainLibrary => 'La bibliothèque principale';

  @override
  String get hsk1Foundation => 'HSK 1 : Bases';

  @override
  String get hsk2Elementary => 'HSK 2 : Élémentaire';

  @override
  String get hsk3Intermediate => 'HSK 3 : Intermédiaire';

  @override
  String get inDeckCheck => 'Dans le deck ✓';

  @override
  String get addToDeckPlus => '+ Ajouter au deck';

  @override
  String get openCardArrow => 'Ouvrir la carte →';

  @override
  String get pronunciationPartial => 'Ton imprécis';

  @override
  String get pronunciationWrong => 'Incorrect';

  @override
  String get toneExpected => 'Attendu';

  @override
  String get toneYouSaid => 'Vous avez dit';

  @override
  String get gotIt => 'Compris !';

  @override
  String foundNCharacters(int count) {
    return '(count) caractères trouvés';
  }

  @override
  String get lookingUpCharacters => 'Recherche des caractères…';

  @override
  String get practiceAll => 'Tout pratiquer';

  @override
  String get arLensObjects => 'Objets';

  @override
  String get arLensText => 'Texte';

  @override
  String get arLensDetectedText => 'Texte détecté';

  @override
  String get duration12Min => '1-2 min';

  @override
  String get aClassicTangDynastyPoem =>
      'Un poème classique de la dynastie Tang';

  @override
  String get aClassicTangDynastyPoemBy =>
      'Un poème classique de la dynastie Tang de';

  @override
  String get aStructuralComponent => 'Un composant structurel.';

  @override
  String get addSelectedToDeck => 'Ajouter la selection au paquet';

  @override
  String addTo(Object target) {
    return 'Ajouter à $target';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '\'$hanzi\' ajouté à votre bibliothèque';
  }

  @override
  String get adjustFontSize => 'Ajuster la taille de police';

  @override
  String get againGoodEasyHard =>
      '⬅️ Réviser    ➡️ Bon    ⬆️ Facile    ⬇️ Difficile';

  @override
  String get aiAnalysisFailed => 'L\'analyse IA a échoué';

  @override
  String get aiIsThinking => 'L\'IA réfléchit...';

  @override
  String get aiSceneAnalysisFailed => 'L\'analyse de scène IA a échoué';

  @override
  String get allLabel => 'Tout';

  @override
  String get allPinyin => 'Tout Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Déjà un compte ? Connectez-vous';

  @override
  String get analysisFailed => 'Analyse échouée :';

  @override
  String get analyzingClassicalCharacters =>
      'Analyse des caractères classiques...';

  @override
  String get anatomy => 'Anatomie';

  @override
  String get ancientPhilosophy => 'Philosophie antique';

  @override
  String get warringStates => 'Royaumes combattants';

  @override
  String get hanFeiLegalism =>
      'Han Fei (v. 280-233 av. J.-C.) était un prince de l\'État de Han et le principal penseur du légisme chinois. En réunissant les notions de loi, de technique administrative et d\'autorité, ses écrits dans le Han Feizi ont profondément influencé la philosophie politique et les institutions de la Chine impériale.';

  @override
  String get articleSavedToMediaHub => 'Article enregistré dans Media Hub !';

  @override
  String get askAFollowUp => 'Posez une question complémentaire...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Audio, confidentialité et fonctionnement';

  @override
  String get audiobookPlayer => 'Lecteur de livre audio';

  @override
  String get audiobookVoice => 'Voix du livre audio';

  @override
  String get auntieMaTown =>
      'Tante Ma (马阿姨), une propriétaire de stand énergétique et bruyante qui prépare les meilleurs Roujiamo et Liangpi de la ville.';

  @override
  String get back => 'Retour';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯), un jeune torréfacteur passionné qui adore parler des grains de café du Yunnan et des notes de saveur.';

  @override
  String get bbc => 'BBC Chinois';

  @override
  String get beginYourJourney => 'Commencez votre voyage';

  @override
  String get bestValue => 'Meilleur rapport qualité-prix';

  @override
  String get bookLinkCopiedToClipboard =>
      'Lien du livre copié dans le presse-papiers !';

  @override
  String get bookmarkChapter => 'Marquer le chapitre';

  @override
  String get bookmarks => 'Signets';

  @override
  String get books => 'Livres';

  @override
  String get briefing => 'Briefing';

  @override
  String get bugReport => 'Signalement de bug';

  @override
  String get caoXueqinDecline =>
      'Cao Xueqin (v. 1715-1763) était un romancier de la dynastie Qing né dans une famille de Bannerman autrefois riche dont la fortune s\'effondra sous l\'empereur Yongzheng. Le Rêve dans le Pavillon Rouge, écrit dans ses dernières années de pauvreté, est largement considéré comme le summum de la fiction chinoise -- une vaste et psychologiquement riche tapisserie du déclin aristocratique.';

  @override
  String get cardsTitle => 'CARTES';

  @override
  String get cc => 'ST';

  @override
  String get characterOrWord => 'Caractère / Mot';

  @override
  String get chatMore => 'Continuer la discussion';

  @override
  String get chefChenShumai =>
      'Chef Chen (陈师傅), un joyeux chef de dim sum cantonais recommandant des raviolis aux crevettes Har Gow frais et des Shumai.';

  @override
  String get chineseEpics => 'Épopées chinoises';

  @override
  String get chinesePoetry => 'Poésie chinoise';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast =>
      'Festin de fondue épicée de Chongqing';

  @override
  String get chooseAudiobookVoice => 'Choisir la voix du livre audio';

  @override
  String get chooseVoice => 'Choisir la voix';

  @override
  String get compare => 'Comparer';

  @override
  String get compare4Tones => 'Comparer 4 tons';

  @override
  String get configuration => 'Configuration';

  @override
  String get contemporary => 'Contemporain';

  @override
  String get context => 'Contexte';

  @override
  String get couldNotLoadLibrary => 'Impossible de charger la bibliothèque';

  @override
  String get couldNotLoadVocabulary => 'Impossible de charger le vocabulaire.';

  @override
  String get couldNotOpenEmailApp =>
      'Impossible d\'ouvrir l\'application de messagerie.';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get createNewDeck => 'Créer un nouveau deck';

  @override
  String get createScenario => 'Créer un scénario';

  @override
  String get createStory => 'Créer une histoire';

  @override
  String get customLabel => 'Personnalisé';

  @override
  String get customWord => 'Mot personnalisé';

  @override
  String get days => 'jours';

  @override
  String get deck => 'Paquet';

  @override
  String get deckName => 'Nom du deck';

  @override
  String get deckStory => 'Histoire du deck';

  @override
  String get deepAnalysis => 'Analyse approfondie';

  @override
  String get defaultDeck => 'Deck par défaut';

  @override
  String get deleteLabel => 'Supprimer';

  @override
  String get deleteScenario => 'Supprimer le scénario';

  @override
  String get deletesAllProgressPermanently =>
      'Supprime tout le progrès définitivement';

  @override
  String get developerBackdoorUnlocked =>
      'Porte dérobée développeur déverrouillée !';

  @override
  String get doesNotExistInChinese => 'N\'existe pas en chinois';

  @override
  String get dontHaveAccountSignUp => 'Pas de compte ? Inscrivez-vous';

  @override
  String get draftingStoryOutline => 'Rédaction du plan de l\'histoire...';

  @override
  String get dynamicFlowState => 'État de flux dynamique';

  @override
  String get dynamicFlowStateParenthetical => 'Dynamique (État de flux)';

  @override
  String get editCard => 'Modifier la carte';

  @override
  String get egAnimeVocab => 'P. ex., Vocabulaire d\'anime';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'p. ex., langage formel des affaires, argot pour les textos...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'p. ex., Commander dans un restaurant, Vocabulaire professionnel...';

  @override
  String get egWeddingReceptionTechInterview =>
      'p. ex., Réception de mariage, Entretien technique...';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get english => 'Anglais';

  @override
  String get englishAndWorld => 'Anglais et Monde';

  @override
  String get episodes => 'épisodes';

  @override
  String get erase => 'Effacer';

  @override
  String get eraseDeckQuestion => 'Effacer le deck ?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Erreur lors de la récupération de la traduction pour $label : $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Erreur lors du chargement des micro-lectures : $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Erreur lors du chargement des romans : $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Erreur lors du chargement de la poésie : $e';
  }

  @override
  String get exitFocus => 'Quitter le mode concentration';

  @override
  String get explore => 'Explorer';

  @override
  String get exportToThisDeck => 'Exporter vers ce deck';

  @override
  String get extractAndSimplify => 'Extraire et simplifier';

  @override
  String get failedToCreateDeck => 'Échec de la création du deck';

  @override
  String get failedToLoadDailyContent =>
      'Échec du chargement du contenu quotidien';

  @override
  String get failedToLoadEpisodes => 'Échec du chargement des épisodes';

  @override
  String get failedToLoadShows => 'Échec du chargement des émissions';

  @override
  String get finalizingDetails => 'Finalisation des détails...';

  @override
  String get finalizingStoryDetails =>
      'Finalisation des détails de l\'histoire...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth n\'est pas activé. Veuillez activer la méthode de connexion requise dans votre console Firebase.';

  @override
  String get flashcardDeckTitle => 'DECK DE FLASHCARDS';

  @override
  String get focus => 'Focus';

  @override
  String get foodAndCooking => 'Cuisine et gastronomie';

  @override
  String get forward => 'Avancer';

  @override
  String get freeFlow => 'Flux libre';

  @override
  String get frenchClassics => 'Classiques français';

  @override
  String get full => 'Complet';

  @override
  String get gamingAndEsports => 'Jeux vidéo et esports';

  @override
  String get germanClassics => 'Classiques allemands';

  @override
  String get ghostPinyin => 'Pinyin fantôme';

  @override
  String get goodAttempt => 'Bonne tentative';

  @override
  String get gotItSimple => 'Compris';

  @override
  String get grammar => 'Grammaire';

  @override
  String get grandmaLiuFilling =>
      'Grand-mère Liu (刘奶奶), une grand-mère du nord de la Chine chaleureuse qui vous apprend à plier les raviolis et à préparer la farce au porc et à la ciboule.';

  @override
  String get great => 'Génial !';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Festin de raviolis faits maison à Harbin';

  @override
  String get hanziCharacter => 'Hanzi (Caractère)';

  @override
  String get hapticFeedback => 'Retour haptique';

  @override
  String get helpAndSupport => 'Aide et support';

  @override
  String get hidden => 'Caché';

  @override
  String get hideEnglishTranslations => 'Masquer les traductions anglaises';

  @override
  String get hidePinyin => 'Masquer le Pinyin';

  @override
  String get highlight => 'SURLIGNER';

  @override
  String get howWouldYouLikeToStudy => 'Comment souhaitez-vous étudier ?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4 : Intermédiaire sup.';

  @override
  String get hsk5Advanced => 'HSK 5 : Avancé';

  @override
  String get hsk6Mastery => 'HSK 6 : Maîtrise';

  @override
  String get hskCollections => 'Collections HSK';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'Simplification des sous-titres (HSK)';

  @override
  String get hskVocabularyCollections => 'Collections de vocabulaire HSK';

  @override
  String get i => 'Je';

  @override
  String get ifTheAgain =>
      'Si la transcription ne correspond pas à vos propos, sélectionnez la phrase voulue, puis touchez « Oui, réévaluez-moi ! » pour réévaluer l’enregistrement initial sans avoir à parler de nouveau.';

  @override
  String get install => 'Installer';

  @override
  String get just => 'Seulement \$';

  @override
  String get keyword => 'mot-clé';

  @override
  String get knowledgeBase => 'Base de connaissances';

  @override
  String get liRuzhenSubjects =>
      'Li Ruzhen (v. 1763-1830) était un érudit de la dynastie Qing avec de profonds intérêts en phonologie, échecs et cosmologie. Les Fleurs dans le Miroir, son roman fantastique d\'un marchand voyageant à travers des royaumes impossibles, est remarquable pour ses thèmes féministes et sa gamme encyclopédique de sujets.';

  @override
  String get libraryLabel => 'Bibliothèque';

  @override
  String get lifestyleAndVlog => 'Mode de vie et vlog';

  @override
  String get listenInAudiobookMode => 'Écouter en mode livre audio';

  @override
  String get listenToThisWord => 'Écouter ce mot';

  @override
  String get listening => 'Écoute...';

  @override
  String get liuEEncroachment =>
      'Liu E (1857-1909) était un polymathe de la fin des Qing -- ingénieur, médecin et romancier -- dont l\'unique roman Les Voyages de Lao Can est un récit de voyage lyrique mais politiquement chargé d\'un guérisseur errant naviguant dans une Chine en proie à l\'effondrement dynastique et à l\'empiètement étranger.';

  @override
  String get loadingTranslations => 'Chargement des traductions...';

  @override
  String get luXunVernacular =>
      'Lu Xun (1881-1936), nom de plume de Zhou Shuren, est le père de la littérature chinoise moderne. Médecin devenu écrivain pour guérir l\'esprit chinois, ses recueils de nouvelles -- Le Journal d\'un fou et La Véritable Histoire d\'Ah Q -- utilisaient la langue vernaculaire pour critiquer la société féodale.';

  @override
  String get luoGuanzhongEpic =>
      'Luo Guanzhong (v. 1330-1400) était un dramaturge et romancier de la transition Yuan-Ming, qui aurait étudié sous Shi Naian. Son Roman des Trois Royaumes a synthétisé chroniques historiques, tradition orale et narration dramatique en l\'épopée historique chinoise définitive.';

  @override
  String get makeACustomCollection => 'Créer une collection personnalisée';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Gérer les sélections quotidiennes et les rappels de révision';

  @override
  String get managerYuOptions =>
      'Gérante Yu (余店长), une directrice fougueuse de restaurant de fondue qui recommande sa spécialité de tripes, son sang de canard et ses options de bouillon non pimenté.';

  @override
  String get masterGaoRubs =>
      'Maître Gao (高师傅), un maître du barbecue au charbon de bois charismatique qui plaisante avec les clients sur les niveaux d\'épices et ses mélanges d\'épices secrets au cumin.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Maîtrisez ceci pour déverrouiller sa galaxie.';

  @override
  String get masterZhaoBrewing =>
      'Maître Zhao (赵师傅), un sommelier de thé patient et compétent qui adore expliquer l\'infusion du thé Gongfu.';

  @override
  String get mastery => 'Maîtrise';

  @override
  String get maybeLater => 'Peut-être plus tard';

  @override
  String get memes => 'Mèmes';

  @override
  String get midnightBbqSkewersInWuhan =>
      'Brochettes de barbecue de minuit à Wuhan';

  @override
  String get mo => '/mois';

  @override
  String get modernChinese => 'Chinois moderne';

  @override
  String get monthly => 'Mensuel';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Chariot de dim sum matinal à Guangzhou';

  @override
  String get nameLabel => 'Nom';

  @override
  String get native => 'Natif';

  @override
  String get newCard => 'Nouvelle carte';

  @override
  String get newDeck => 'Nouveau deck';

  @override
  String get newDeckName => 'Nom du nouveau deck';

  @override
  String get noActiveSubscriptionFound => 'Aucun abonnement actif trouvé.';

  @override
  String get noEpisodesFound => 'Aucun épisode trouvé';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Aucun mot-clé trouvé pour cette histoire.';

  @override
  String get noLabel => 'Non';

  @override
  String get noNewWordsFound => 'Aucun nouveau mot trouvé !';

  @override
  String get noPinyin => 'Pas de Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'Aucun forfait premium disponible pour le moment.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'Aucun résultat trouvé pour \'$searchQuery\'';
  }

  @override
  String get noSavedArticlesYet => 'Aucun article enregistré pour l\'instant.';

  @override
  String get noShowsAvailable => 'Aucune émission disponible';

  @override
  String get noStoriesFound => 'Aucune histoire trouvée.';

  @override
  String get noWordsSelected => 'Aucun mot sélectionné';

  @override
  String get notes => 'Notes';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'OBJECTIFS';

  @override
  String get openInYoutube => 'Ouvrir dans YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Commander un café filtre à Shanghai';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Commander des brochettes de Tanghulu (baies d\'aubépine confites) à Pékin en hiver';

  @override
  String partnerLang(String lang) {
    return 'Partenaire ($lang)';
  }

  @override
  String get partnerListening => 'Partenaire écoute...';

  @override
  String get partnerSpeaking => 'Partenaire parle...';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get pause => 'Pause';

  @override
  String get perfect => 'Parfait !';

  @override
  String get personalizedPathBasedOnDeck =>
      'Un chemin personnalisé basé sur votre deck.';

  @override
  String get play => 'Écouter';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Veuillez entrer un message avant de l\'envoyer.';

  @override
  String get practiceInRoleplay => 'Pratiquer en jeu de rôle';

  @override
  String get practiceModes => 'Modes d\'entraînement';

  @override
  String get practicePronouncingWithAiGrading =>
      'Pratiquer la prononciation de ce mot avec notation IA';

  @override
  String get preparingReadingInterface =>
      'Préparation de l\'interface de lecture...';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get privacyAndAudio => 'Confidentialité et audio';

  @override
  String get aiDataPrivacyTitle => 'Données IA et confidentialité';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Découvrez ce que les fonctionnalités IA envoient, pourquoi et à qui';

  @override
  String get aiDataPrivacyOverviewTitle => 'Utilisation de l\'IA';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark utilise l\'IA dans le cloud uniquement lorsque vous choisissez une fonctionnalité qui la nécessite, comme le chat IA, les explications, la traduction, l\'analyse d\'images, la reconnaissance vocale, l\'évaluation de la prononciation ou les voix cloud. Les résultats générés par l\'IA peuvent être inexacts ; vérifiez les informations importantes.';

  @override
  String get aiDataPrivacyProvidersTitle => 'Fournisseurs de services IA';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini traite les requêtes génératives de texte et d\'images. OpenRouter redirige certaines requêtes génératives vers Google Gemini ou DeepSeek. Microsoft Azure AI Speech traite la reconnaissance vocale, l\'évaluation de la prononciation et les textes envoyés pour la synthèse vocale cloud.';

  @override
  String get aiDataPrivacySentTitle => 'Données susceptibles d\'être envoyées';

  @override
  String get aiDataPrivacySentBody =>
      'Selon la fonctionnalité, nous envoyons le texte que vous saisissez ou sélectionnez, le contexte de la conversation ou de la leçon, les images choisies pour l\'analyse IA, vos enregistrements vocaux, ainsi que des données techniques (adresse IP, métadonnées d\'appareil/réseau). Nous n\'incluons pas intentionnellement votre nom ou e-mail dans les requêtes IA.';

  @override
  String get aiDataPrivacyControlsTitle => 'Vos choix';

  @override
  String get aiDataPrivacyControlsBody =>
      'N\'utilisez pas une fonctionnalité IA si vous ne souhaitez pas que ses données soient envoyées au fournisseur indiqué. Vous pouvez refuser l\'accès à la caméra, aux photos ou au micro dans les Réglages de votre appareil. Choisissez la voix locale pour conserver la synthèse vocale sur votre appareil. Évitez de transmettre des informations sensibles ou confidentielles.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Stockage et conservation';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark ne conserve pas intentionnellement les requêtes IA brutes, les images soumises ou les enregistrements vocaux sur ses propres serveurs après traitement. Les résultats générés peuvent être enregistrés sur votre appareil ou sur votre compte si vous choisissez de les sauvegarder. Les fournisseurs traitent les données selon leurs propres conditions ; consultez la politique complète pour plus de détails.';

  @override
  String get readFullPrivacyPolicy =>
      'Lire la politique de confidentialité complète';

  @override
  String get linkOpenFailed =>
      'Impossible d\'ouvrir le lien. Veuillez réessayer.';

  @override
  String get puSonglingLiterature =>
      'Pu Songling (1640-1715) était un écrivain de la dynastie Qing qui a passé des décennies à compiler Contes étranges du studio du lettré après avoir échoué à plusieurs reprises aux examens impériaux. Ses histoires surnaturelles d\'esprits renards, fantômes et lettrés restent la référence de la littérature gothique chinoise.';

  @override
  String get qaFaq => 'Q et R / FAQ';

  @override
  String get questsTitle => 'QUÊTES';

  @override
  String get quickBookmarks => 'Signets rapides';

  @override
  String get radical => 'Radical';

  @override
  String get ready => 'Prêt';

  @override
  String get readyToInterpret => 'Prêt à interpréter';

  @override
  String get readyToStart => 'Prêt à commencer.';

  @override
  String get recentBookmarks => 'Signets récents';

  @override
  String get refiningGrammar => 'Ajustement de la grammaire...';

  @override
  String get refresh => 'Actualiser';

  @override
  String get removeFromSaved => 'Retirer des enregistrés';

  @override
  String get removeFromSavedScenarios => 'Retirer des scénarios enregistrés';

  @override
  String get removed => 'Retiré';

  @override
  String get requestPermissions => 'Demander les autorisations';

  @override
  String get rescind => 'Annuler ?';

  @override
  String get restore => 'Restaurer';

  @override
  String get results => 'Résultats';

  @override
  String get resume => 'Reprendre';

  @override
  String get retry => 'Réessayer';

  @override
  String get revenuecatError => 'Erreur RevenueCat :';

  @override
  String revenuecatErrorE(String e) {
    return 'Erreur RevenueCat : $e';
  }

  @override
  String get reviewExtractedDeck => 'Réviser le deck extrait';

  @override
  String get reviewIn => 'Réviser dans';

  @override
  String get reviewingYourTones => 'Révision de vos tons...';

  @override
  String get saveAll => 'Tout enregistrer';

  @override
  String get saveScenario => 'Enregistrer le scénario';

  @override
  String get saveThisScenario => 'Enregistrer ce scénario';

  @override
  String get saved => 'Enregistré';

  @override
  String get scanAnother => 'En scanner un autre';

  @override
  String get scenarioRemoved => 'Scénario retiré';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Scénario enregistré ! Trouvez-le dans l\'onglet Personnalisé.';

  @override
  String score(Object score, Object total) {
    return 'Score : $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning =>
      'Rechercher par pinyin ou signification...';

  @override
  String get searchByTitleOrTag => 'Rechercher par titre ou étiquette...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Chercher dans le dictionnaire ou saisir un mot personnalisé';

  @override
  String get searchHint => 'Rechercher...';

  @override
  String get searchOrEnterUrl => 'Rechercher ou entrer une URL';

  @override
  String get searchScenariosHint => 'Rechercher des scénarios...';

  @override
  String get searchStoriesIdiomsNews =>
      'Rechercher histoires, expressions, actualités...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Rechercher des sujets (p. ex., Cuisine, Histoire)';

  @override
  String get seeAll => 'Voir tout';

  @override
  String get selectADeck => 'Sélectionner un deck';

  @override
  String get selectPracticeMode => 'Sélectionner le mode d\'entraînement';

  @override
  String get selectingHskVocabulary => 'Sélection du vocabulaire HSK...';

  @override
  String get send => 'Envoyer';

  @override
  String get sendMessage => 'Envoyer le message';

  @override
  String get serif => 'Empattement';

  @override
  String get shadow => 'Ombre';

  @override
  String get shiNaianEpic =>
      'Shi Naian (v. 1296-1372) était un lettré de la dynastie Yuan qui aurait réussi l\'examen impérial mais a choisi la vie d\'un érudit reclus. Au bord de l\'eau, son chef-d\'œuvre de hors-la-loi héroïques et de rébellion juste, a établi l\'archétype de l\'épopée martiale chinoise.';

  @override
  String get showEnglish => 'Afficher l\'anglais';

  @override
  String get showEnglishTranslations => 'Afficher les traductions anglaises';

  @override
  String get showHanzi => 'Afficher Hanzi';

  @override
  String get showPinyin => 'Afficher le Pinyin';

  @override
  String get showTranslation => 'Afficher la traduction';

  @override
  String get shows => 'Émissions';

  @override
  String get signIn => 'Se connecter';

  @override
  String get simplifiedArticle => 'Article simplifié';

  @override
  String get simplifyingSubtitles => 'Simplification des sous-titres...';

  @override
  String get sincereHonest => 'sincère ; honnête';

  @override
  String get sleepTimer => 'Minuteur de sommeil';

  @override
  String get smartDeck => 'Deck intelligent';

  @override
  String get spanishAndWorld => 'Espagnol et Monde';

  @override
  String get speaker => 'Haut-parleur';

  @override
  String get spotifyStylePlayer => 'Lecteur style Spotify';

  @override
  String get storyBookmarkedInLibrary =>
      'Histoire mise en signet dans la Bibliothèque !';

  @override
  String get streetFoodNightMarketInXian =>
      'Marché nocturne de street food à Xi\'an';

  @override
  String get strokes => 'Traits';

  @override
  String get studyCharacter => 'Étudier le caractère';

  @override
  String get subtitleOpacity => 'Opacité des sous-titres';

  @override
  String get suggestion => 'Suggestion';

  @override
  String get summary => 'Résumé';

  @override
  String get supernaturalAndFolklore => 'Surnaturel et folklore';

  @override
  String get swipeToGrade => 'Balayez pour noter :';

  @override
  String get tableOfContents => 'Table des matières';

  @override
  String get tapToRetry => 'Appuyez pour réessayer';

  @override
  String get teaTastingInChengdu => 'Dégustation de thé à Chengdu';

  @override
  String get techAndGadgets => 'Tech et gadgets';

  @override
  String get terms => 'Conditions';

  @override
  String get theGalaxyCharacters =>
      'La carte galactique vous attend.\nMaîtrisez les Soleils (Radicaux) pour déverrouiller les Planètes (Caractères).';

  @override
  String get theme => 'Thème';

  @override
  String get thinking => 'Réflexion...';

  @override
  String get thisArticleCharacters =>
      'Cet article contient des caractères chinois traditionnels.';

  @override
  String get todaysWord => 'MOT DU JOUR';

  @override
  String get togglePinyin => 'Activer/désactiver le Pinyin';

  @override
  String get toggleTranslation => 'Activer/désactiver la traduction';

  @override
  String get toneDoesNotExistInMandarin =>
      'Ce ton n\'existe pas en mandarin standard.';

  @override
  String get toneGraph => 'Graphique des tons';

  @override
  String get traceLabel => 'Tracer';

  @override
  String get trailer => 'BANDE-ANNONCE';

  @override
  String get translatingAndAddingPinyin => 'Traduction et ajout du Pinyin...';

  @override
  String get translatingText => 'Traduction du texte...';

  @override
  String get turnOn => 'Activer';

  @override
  String get typeHanziPinyinOrEnglish => 'Tapez Hanzi, Pinyin ou anglais...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Déroulement du parchemin...';

  @override
  String get upperIntermediate => 'Inter. sup.';

  @override
  String get vibrationsForInteractions => 'Vibrations pour les interactions';

  @override
  String get video => 'Vidéo';

  @override
  String get viewAnswer => 'Voir la réponse';

  @override
  String get viewAsList => 'Afficher sous forme de liste';

  @override
  String get viewBookmarks => 'Voir les signets';

  @override
  String get viewMyDrawing => 'Voir mon dessin';

  @override
  String get vlog => 'Vlog quotidien chinois';

  @override
  String get voice => 'Voix :';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou =>
      'Nous aimerions\nsavoir ce que vous pensez.';

  @override
  String get welcomeBack => 'Ravi de vous revoir';

  @override
  String get whatDoesThisMean => 'Qu\'est-ce que cela signifie ?';

  @override
  String get whatHappensToMyChatHistory =>
      'Qu\'advient-il de mon historique de discussion ?';

  @override
  String get whatIfAiMishears =>
      'Que faire si l’IA interprète mal mes propos ?';

  @override
  String get whichCharacterIs => 'Quel caractère est :';

  @override
  String get wikipedia => 'Wikipédia';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Mots enregistrés et révision planifiée !';

  @override
  String get writeYourMessageHere => 'Écrivez votre message ici...';

  @override
  String get wuChengenLiterature =>
      'Wu Cheng\'en (v. 1500-1582) était un romancier de la dynastie Ming originaire de Huai\'an, Jiangsu. S\'appuyant sur des décennies de folklore, d\'allégorie bouddhiste et d\'esprit satirique, il a tissé la mythologie du pèlerinage Tang dans La Pérégrination vers l\'Ouest -- l\'une des œuvres les plus inventives et appréciées de la littérature mondiale.';

  @override
  String get wuJingziClass =>
      'Wu Jingzi (1701-1754) était un romancier de la dynastie Qing originaire d\'Anhui qui abandonna sa fortune héritée et passa sa vie à écrire Les Lettrés -- un roman satirique mordant dénonçant la vanité, la corruption et l\'absurdité du système d\'examens impériaux et de la classe érudite-fonctionnaire.';

  @override
  String get xuZhonglinWarfare =>
      'Xu Zhonglin (fl. XVIe-XVIIe siècle) était un auteur de la dynastie Ming crédité de la compilation de L\'Investiture des Dieux (封神演义), une œuvre monumentale de fiction mythologique mêlant l\'histoire Shang-Zhou à la cosmologie taoïste, la bureaucratie céleste et la guerre héroïque.';

  @override
  String get yearly => 'Annuel';

  @override
  String get yesReGradeMe => 'Oui, réévaluez-moi !';

  @override
  String you(Object lang) {
    return 'Vous ($lang)';
  }

  @override
  String get youAreSpeaking => 'Vous parlez';

  @override
  String get youLabel => 'Vous';

  @override
  String youLang(String lang) {
    return 'Vous ($lang)';
  }

  @override
  String get youMustAccount =>
      'Vous devez accepter les Conditions d\'utilisation et la Politique de confidentialité pour créer un compte.';

  @override
  String get yourEchoModels =>
      'L’historique des conversations de Jeu de rôle que vous enregistrez reste stocké localement sur votre appareil pour que vous puissiez le consulter. Nous n’utilisons pas vos conversations personnelles pour entraîner nos modèles d’IA.';

  @override
  String get zhOnly => 'ZH uniquement';

  @override
  String get hsk_1300_cards => '1300 cartes';

  @override
  String get hsk_154_cards => '154 cartes';

  @override
  String get hsk_162_cards => '162 cartes';

  @override
  String get hsk_2500_cards => '2500 cartes';

  @override
  String get hsk_299_cards => '299 cartes';

  @override
  String get hsk_602_cards => '602 cartes';

  @override
  String get added_to_review_queue => 'Ajouté à la file de révision';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return '$cardCount cartes ajoutées à « $deckName ».';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '« $hanzi » ajouté à votre bibliothèque';
  }

  @override
  String get advanced => 'Avancé';

  @override
  String get ai_stories => 'Histoires IA';

  @override
  String analysis_failed(Object error) {
    return 'Échec de l\'analyse : $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Analyse de la prononciation avec Gemini IA...';

  @override
  String get analyzing_your_pronunciation =>
      'Analyse de votre prononciation...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Voulez-vous vraiment supprimer définitivement « $deckName » ? Cette action est irréversible et supprimera toutes les cartes de ce deck.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Poser une question sur $hanzi...';
  }

  @override
  String get audio_haptics => 'Audio et haptique';

  @override
  String get audio_could_not_start_check_your =>
      'Impossible de démarrer l\'audio. Vérifiez votre connexion et les paramètres vocaux de votre appareil.';

  @override
  String get calligraphy_trace => 'Tracé calligraphique';

  @override
  String chapters(Object count) {
    return '$count chapitres';
  }

  @override
  String get char => 'Caractère';

  @override
  String get chinese_character => 'CARACTÈRE CHINOIS';

  @override
  String get contact_us_and_report_issues =>
      'Contactez-nous et signalez un problème';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Deck intelligent créé : « $deckName » avec $wordCount mots !';
  }

  @override
  String get custom_ai_generated_story =>
      'Histoire personnalisée générée par l\'IA.';

  @override
  String get display_content => 'Affichage et contenu';

  @override
  String get do_you_keep_or_store_my =>
      'Conservez-vous ou enregistrez-vous mes données vocales ?';

  @override
  String get elementary => 'Élémentaire';

  @override
  String error_creating_scenario(Object error) {
    return 'Erreur lors de la création du scénario : $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Erreur lors de la récupération de la traduction : $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Erreur lors du chargement des chapitres : $error';
  }

  @override
  String get error_loading_decks => 'Erreur lors du chargement des decks';

  @override
  String error_loading_microreads(Object error) {
    return 'Erreur lors du chargement des micro-lectures : $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Erreur lors du chargement des romans : $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Erreur lors du chargement de la poésie : $error';
  }

  @override
  String get etymology => 'Étymologie :';

  @override
  String get explanation => 'Explication';

  @override
  String get extracted_text_tap_to_lookup =>
      'Texte extrait (Touchez pour chercher)';

  @override
  String extraction_failed(Object error) {
    return 'Échec de l\'extraction : $error';
  }

  @override
  String get failed_to_download => 'Échec du téléchargement.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Échec de la génération du scénario : $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Échec de la génération de l\'histoire :\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Échec du chargement du contexte : $error';
  }

  @override
  String get feature_request => 'Demande de fonctionnalité';

  @override
  String get foundation => 'Bases';

  @override
  String get how_is_my_pronunciation_scored =>
      'Comment ma prononciation est-elle notée ?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'Vocabulaire HSK $hskLevel';
  }

  @override
  String get hsk_level => 'NIVEAU HSK';

  @override
  String get intermediate => 'Intermédiaire';

  @override
  String get learning_stats => 'Statistiques d\'apprentissage';

  @override
  String get mandarin => 'Mandarin';

  @override
  String get meaning => 'Signification';

  @override
  String get no_decks_found => 'Aucun deck trouvé.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'Aucun résultat trouvé pour « $searchQuery »';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'Les enregistrements envoyés pour l’évaluation de la prononciation sont traités de manière sécurisée et ne sont pas conservés par SinoSpark une fois le traitement terminé. L’historique de Jeu de rôle que vous choisissez d’enregistrer peut rester sur votre appareil et être supprimé dans l’app.';

  @override
  String get notification_settings => 'Paramètres de notification';

  @override
  String get open_settings => 'Ouvrir les réglages';

  @override
  String get phoneme => 'Phonème';

  @override
  String get play_reference_pronunciation =>
      'Écouter la prononciation de référence';

  @override
  String get please_select_a_deck_to_add =>
      'Veuillez sélectionner un deck auquel ajouter des cartes.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Pointez vers du texte chinois pour le traduire';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Entraînez-vous à tracer les traits à la main';

  @override
  String get preferences_audio_and_display => 'Préférences, audio et affichage';

  @override
  String get preparing_your_scholars_verdict =>
      'Préparation de l\'évaluation de l\'érudit...';

  @override
  String get previous => 'Précédent';

  @override
  String question(Object current, Object total) {
    return 'Question $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Retirer $hanzi de ce deck ?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'Erreur RevenueCat : $error';
  }

  @override
  String get review_tomorrow => 'À réviser demain';

  @override
  String get roleplay => 'Jeu de rôle';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Enregistrement de $wordCount mots dans $deckName...';
  }

  @override
  String get search_radicals_eg_water => 'Rechercher des radicaux (ex. Eau, 氵)';

  @override
  String get select_target_hsk_level => 'Sélectionnez le niveau HSK cible';

  @override
  String get sentence => 'Phrase';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Le Studio de Shadowing est un espace dédié pour vous entraîner à imiter des locuteurs natifs en temps réel.';

  @override
  String simplify_failed(Object error) {
    return 'Échec de la simplification : $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Expression orale et prononciation';

  @override
  String get statistics => 'Statistiques';

  @override
  String get table_of_contents => 'Table des matières · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'L\'IA évalue votre élocution selon trois critères :\n• Précision : Avez-vous articulé les bonnes syllabes ?\n• Exhaustivité : Avez-vous sauté ou manqué des mots ?\n• Fluidité : Avez-vous fait des pauses naturelles et utilisé les bons tons ?\nElle compare votre enregistrement à des locuteurs natifs pour générer une note sur 100.';

  @override
  String get this_cannot_be_undone => 'Cette action est irréversible.';

  @override
  String get title => 'Titre';

  @override
  String get to_be_reviewed => 'À réviser';

  @override
  String get traditional => 'Traditionnel';

  @override
  String translation_failed(Object error) {
    return 'Échec de la traduction : $error';
  }

  @override
  String get type_in => 'Saisir...';

  @override
  String get type_your_message_in => 'Saisissez votre message en...';

  @override
  String get unable_to_open_this_video_please =>
      'Impossible d\'ouvrir cette vidéo. Veuillez réessayer plus tard.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Consultez votre historique d\'apprentissage et vos séries';

  @override
  String get what_is_shadowing_studio =>
      'Qu\'est-ce que le Studio de Shadowing ?';

  @override
  String get words => 'mots';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Votre parcours pour « $deckName » est prêt !';
  }

  @override
  String get you_said => '🗣️ Vous avez dit';

  @override
  String vocabularyBatch(Object index) {
    return 'Lot de vocabulaire $index';
  }

  @override
  String get yourDailyDropIsHere => 'Votre dose quotidienne est arrivée ! ✨';

  @override
  String get timeToReview => 'C\'est l\'heure de réviser ! 📚';

  @override
  String get neverMissAStroke => 'Ne manquez jamais un trait ! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'Votre essai se termine demain ! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Niveaux de vocabulaire officiels standard';

  @override
  String get failedToLoadCollections => 'Échec du chargement des collections.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get aiSmartContext => 'Contexte intelligent IA';

  @override
  String get aiSmartContextError => 'Erreur de Contexte intelligent IA';

  @override
  String get downloadOfficialHskCollections =>
      'Télécharger les collections officielles HSK';

  @override
  String get unableToLoadThisSection =>
      'Impossible de charger cette section. Veuillez réessayer.';

  @override
  String get translationLanguage => 'Langue de traduction';

  @override
  String get dailyDrops => 'Doses quotidiennes';

  @override
  String get wordOfTheDayNews => 'Mot du jour et actualités';

  @override
  String get reviewReminders => 'Rappels de révision';

  @override
  String get flashcardsDueForReview => 'Flashcards à réviser';

  @override
  String get dailyNewCards => 'Nouvelles cartes quotidiennes';

  @override
  String get dailyReviewLimit => 'Limite de révision quotidienne';

  @override
  String get practiceMode => 'Mode Entraînement';

  @override
  String get liziqi => 'Li Ziqi : Fleurs de soie';

  @override
  String get theLifeOfGarlicTraditional =>
      'La Vie de l\'Ail - Vie Traditionnelle Chinoise';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin : 50 Phrases';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Phrases Chinoises Essentielles pour Débutants';

  @override
  String get makingBambooFurniture => 'Fabrication de Meubles en Bambou';

  @override
  String get peppaPigChinese => 'Peppa Pig Chinois : Cache-cache';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'Flaques de Boue - Adapté aux Débutants';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner : 300 Verbes';

  @override
  String get mostCommonChineseVerbs => 'Les Verbes Chinois les Plus Courants';

  @override
  String get graceMandarinOrderFood =>
      'Grace Mandarin : Commander de la nourriture';

  @override
  String get howToOrderFoodIn =>
      'Comment commander de la nourriture dans un restaurant chinois';

  @override
  String get silkFlowersTraditionalCraft =>
      'Fleurs de Soie - Artisanat Traditionnel';

  @override
  String get mandarinCorner =>
      'Mandarin Corner : Apprendre le chinois - Aller chez le médecin';

  @override
  String get goingToTheDoctorReal =>
      'Aller chez le médecin - Conversation de la vie réelle';

  @override
  String get hideAndSeekBeginnerFriendly =>
      'Cache-cache - Adapté aux Débutants';

  @override
  String get linGdp6 =>
      'Xiao Lin dit : Pourquoi la croissance du PIB est de 6 %';

  @override
  String get why6GdpGrowthEasy =>
      'Pourquoi 6 % de croissance du PIB - Économie chinoise facile';

  @override
  String get bbcWorldNews => 'BBC Chinois (Actualités mondiales)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Actualités en Chinois Simplifié';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'BUREAU YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'Transcriptions interactives & shadowing';

  @override
  String get showsDramas => 'ÉMISSIONS & DRAMES';

  @override
  String get extractToDeck => 'Extraire vers le deck';

  @override
  String get autoSimplify => 'Simplification automatique';

  @override
  String get rewriteThisArticleToMatch =>
      'Réécrire cet article pour correspondre à votre niveau HSK';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Échec de l\'enregistrement des mots extraits : $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Ajouter au deck ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Sélection quotidienne';

  @override
  String get smartSpacedRepetition => 'Répétition espacée intelligente';

  @override
  String get trialProtectionAlert => 'Alerte de protection de l\'essai';

  @override
  String get masteryLevel => 'Niveau de maîtrise';

  @override
  String get targetObjective => 'Objectif cible';

  @override
  String get dailyPractice => 'Pratique quotidienne';

  @override
  String get aiSpacedRepetition => 'Répétition espacée par IA';

  @override
  String get iVeGrantedAccess => 'J\'ai accordé l\'accès';

  @override
  String get scanner => 'Scanner';

  @override
  String get interpreter => 'Interprète';

  @override
  String cards(Object count) {
    return '$count cartes';
  }

  @override
  String get nWaMendsTheHeavens => 'Nüwa répare le ciel';

  @override
  String get terracottaArmy => 'Armée de terre cuite';

  @override
  String get forbiddenCity => 'Cité interdite';

  @override
  String get aBlessingInDisguise => 'Un mal pour un bien';

  @override
  String get drawingASnake => 'Dessiner un serpent';

  @override
  String get takingTheBulletTrain => 'Prendre le train à grande vitesse';

  @override
  String get visitingTheDoctor => 'Consulter le médecin';

  @override
  String get orderingDumplings => 'Commander des raviolis';

  @override
  String get theTeaCeremony => 'La cérémonie du thé';

  @override
  String get chineseCalligraphy => 'Calligraphie chinoise';

  @override
  String get theGiantPanda => 'Le panda géant';

  @override
  String get simplifiedText => 'Texte simplifié';

  @override
  String get novels96 => 'Romans (96)';

  @override
  String get microReads => 'Micro-lectures';

  @override
  String get poetry => 'Poésie';

  @override
  String get bookmarkRemoved => '书签已移除 · Marque-page supprimé';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Marque-page ajouté : Chapitre $chapter';
  }

  @override
  String get readingVocabulary => 'Lecture & Vocabulaire';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Lot de vocabulaire $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'Votre dose quotidienne est arrivée ! ✨';

  @override
  String get timeToReview1 => 'C\'est l\'heure de réviser ! 📚';

  @override
  String get neverMissAStroke1 => 'Ne manquez jamais un trait ! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'Votre essai se termine demain ! ⏳';

  @override
  String get hskCollections1 => 'Collections HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Niveaux de vocabulaire officiels standard';

  @override
  String get failedToLoadCollections1 => 'Échec du chargement des collections.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Écouter $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Erreur : $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'Contexte intelligent IA';

  @override
  String get aiSmartContextError1 => 'Erreur de Contexte intelligent IA';

  @override
  String errorErr(Object err, Object error) {
    return 'Erreur : $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Télécharger les collections officielles HSK';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Impossible de charger cette section. Veuillez réessayer.';

  @override
  String get searchRadicalsEgWater => 'Rechercher des radicaux (ex. Eau, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Langue de traduction';

  @override
  String get appLanguage1 => 'Langue de l\'application';

  @override
  String get dailyDrops1 => 'Doses quotidiennes';

  @override
  String get wordOfTheDayNews1 => 'Mot du jour et actualités';

  @override
  String get reviewReminders1 => 'Rappels de révision';

  @override
  String get flashcardsDueForReview1 => 'Flashcards à réviser';

  @override
  String get accuracyByMode1 => 'Précision par mode';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy %';
  }

  @override
  String get upcomingReviewsNext7Days =>
      'Révisions à venir (7 prochains jours)';

  @override
  String get explaining => 'Explication :';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Nouvelles cartes quotidiennes';

  @override
  String get dailyReviewLimit1 => 'Limite de révision quotidienne';

  @override
  String get listeningMode1 => 'Mode Écoute';

  @override
  String get readingMode1 => 'Mode Lecture';

  @override
  String get recallMode1 => 'Mode Rappel';

  @override
  String get speakingMode1 => 'Mode Expression orale';

  @override
  String get practiceMode1 => 'Mode de pratique';

  @override
  String acc(Object acc) {
    return '$acc %';
  }

  @override
  String get partner1 => 'Partenaire';

  @override
  String get partnerSpeaking1 => 'Le partenaire parle…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'La vie de l\'ail - Vie traditionnelle chinoise';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin : 50 phrases';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Phrases chinoises essentielles pour débutants';

  @override
  String get makingBambooFurniture1 => 'Fabrication de meubles en bambou';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Flaques de boue - Adapté aux débutants';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner : 300 verbes';

  @override
  String get mostCommonChineseVerbs1 => 'Verbes chinois les plus courants';

  @override
  String get graceMandarinOrderFood1 =>
      'Grace Mandarin : Commander de la nourriture';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Comment commander de la nourriture dans un restaurant chinois';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Fleurs de soie - Artisanat traditionnel';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Aller chez le médecin - Conversation de la vie réelle';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'Cache-cache - Adapté aux débutants';

  @override
  String get lingdp6 => 'Xiao Lin dit : Pourquoi une croissance du PIB de 6 %';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Pourquoi une croissance du PIB de 6 % - Économie chinoise facile';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Actualités en chinois simplifié';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Transcriptions interactives et shadowing';

  @override
  String get showsDramas1 => 'ÉMISSIONS ET DRAMAS';

  @override
  String error_error(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get extractToDeck1 => 'Extraire vers le deck';

  @override
  String get autosimplify => 'Simplification automatique';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Réécrire cet article pour correspondre à votre niveau HSK';

  @override
  String get addToDeck1 => 'Ajouter au deck';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Sélection quotidienne';

  @override
  String get smartSpacedRepetition1 => 'Répétition espacée intelligente';

  @override
  String get trialProtectionAlert1 => 'Alerte de protection de l\'essai';

  @override
  String get masteryLevel1 => 'Niveau de maîtrise';

  @override
  String get targetObjective1 => 'Objectif cible';

  @override
  String get dailyPractice1 => 'Pratique quotidienne';

  @override
  String get aiSpacedRepetition1 => 'Répétition espacée IA';

  @override
  String get iveGrantedAccess => 'J\'ai accordé l\'accès';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Ajouter au deck ($count)';
  }

  @override
  String get scanner1 => 'Scanner';

  @override
  String get interpreter1 => 'Interprète';

  @override
  String entryvalueCards(Object count) {
    return '$count cartes';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Score : $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'Le Roi Singe';

  @override
  String get huaMulan1 => 'Hua Mulan';

  @override
  String get nwaMendsTheHeavens => 'Nüwa répare le ciel';

  @override
  String get confucius => 'Confucius';

  @override
  String get theGreatWall1 => 'La Grande Muraille';

  @override
  String get terracottaArmy1 => 'L\'Armée de terre cuite';

  @override
  String get forbiddenCity1 => 'La Cité Interdite';

  @override
  String get aBlessingInDisguise1 => 'Un mal pour un bien';

  @override
  String get drawingASnake1 => 'Dessiner un serpent';

  @override
  String get takingTheBulletTrain1 => 'Prendre le train à grande vitesse';

  @override
  String get visitingTheDoctor1 => 'Consulter le médecin';

  @override
  String get orderingDumplings1 => 'Commander des raviolis';

  @override
  String get theTeaCeremony1 => 'La Cérémonie du Thé';

  @override
  String get chineseCalligraphy1 => 'La Calligraphie Chinoise';

  @override
  String get theGiantPanda1 => 'Le Panda Géant';

  @override
  String get simplifiedText1 => 'Texte simplifié';

  @override
  String get novels961 => 'Romans (96)';

  @override
  String get microreads => 'Micro-lectures';

  @override
  String get poetry1 => 'Poésie';

  @override
  String get readingVocabulary1 => 'Lecture et Vocabulaire';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions n\'a pas été configuré pour Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions n\'est pas pris en charge sur cette plateforme.';

  @override
  String get hanziMaster1 => 'Hanzi Master';

  @override
  String get strokesCannotBeEmpty => 'Les traits ne peuvent pas être vides.';

  @override
  String get wrongStartPoint => 'Point de départ incorrect.';

  @override
  String get rightShapeButWrongPlace =>
      'Bonne forme, mais mauvais emplacement !';

  @override
  String get goodFollowTheFlow => 'Bien ! Suivez le tracé.';

  @override
  String get aBitShaky => 'Un peu tremblant !';

  @override
  String get aBitHesitant => 'Un peu hésitant...';

  @override
  String get shapeIsOff => 'La forme est incorrecte.';

  @override
  String get arabic => 'Arabe';

  @override
  String get german => 'Allemand';

  @override
  String get spanish => 'Espagnol';

  @override
  String get french => 'Français';

  @override
  String get hindi => 'Hindi';

  @override
  String get indonesian => 'Indonésien';

  @override
  String get italian => 'Italien';

  @override
  String get japanese => 'Japonais';

  @override
  String get korean => 'Coréen';

  @override
  String get portuguese => 'Portugais';

  @override
  String get russian => 'Russe';

  @override
  String get vietnamese => 'Vietnamien';

  @override
  String get microphonePermissionDenied => 'Autorisation du microphone refusée';

  @override
  String get offset => 'Décalage';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService a été libéré';

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
  String get kore => 'Kore (féminin, chaleureux)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Mot d\'ancrage';

  @override
  String get creativeThematicTitle => 'Titre thématique créatif';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Brève justification pédagogique ou sémantique';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'Le caractère le plus central de la liste';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Un ensemble équilibré de caractères de votre bibliothèque.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Votre réponse conversationnelle naturelle en caractères chinois.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'La traduction française de votre réponse.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'Le Pinyin avec les tons pour votre réponse.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Une réponse suggérée que l\'utilisateur pourrait vous donner.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin pour la suggestion.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Traduction française pour la suggestion.';

  @override
  String get scholarsCritique => 'Critique de l\'érudit';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'La Salle de l\'Écho reste silencieuse. Reprenez votre souffle et réessayez.';

  @override
  String get xtitleHanziMaster => 'Hanzi Master';

  @override
  String get noneYet => 'Aucun pour l\'instant.';

  @override
  String get exactSentence => 'Phrase exacte :';

  @override
  String get englishTranslation => 'Traduction';

  @override
  String get previouslyGeneratedPhrases => 'Phrases générées précédemment';

  @override
  String get iLikeDrinkingAppleJuice => 'J\'aime boire du jus de pomme.';

  @override
  String get theEnglishMeaningHere => 'La signification ici...';

  @override
  String get failedToFetchDefinition =>
      'Échec de la récupération de la définition.';

  @override
  String get failedToLoadExplanation =>
      'Échec du chargement de l\'explication.';

  @override
  String get failedToLoadComparison => 'Échec du chargement de la comparaison.';

  @override
  String get emptyResponseFromOpenrouter => 'Réponse vide d\'OpenRouter';

  @override
  String get emptyResponseFromVisionModel => 'Réponse vide du modèle Vision';

  @override
  String get standard => 'Standard';

  @override
  String get theFullSentenceInChinese => 'La phrase complète en chinois...';

  @override
  String get theWordOrCharacterInChinese => 'Le mot ou caractère en chinois';

  @override
  String get thePinyinForThisSpecificWord => 'Le pinyin pour ce mot spécifique';

  @override
  String get emptyResponseFromDeepseekApi => 'Réponse vide de l\'API DeepSeek';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'CRITIQUE : Placez la traduction française dans le';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Traduction de la phrase entière';

  @override
  String get hanziWord => 'Mot Hanzi';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'La phrase simplifiée complète en chinois...';

  @override
  String get lyingFlatACulturalMovement =>
      'S\'allonger à plat : Un mouvement culturel...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'L\'utilisateur à qui vous parlez s\'appelle';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'RÈGLE IMPORTANTE : N\'adressez pas l\'utilisateur par son nom. N\'utilisez jamais de noms de substitution comme';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Vous êtes un tuteur concis de calligraphie et d\'étymologie chinoises au sein d\'une application mobile de flashcards.';

  @override
  String get theStudentIsStudyingTheCharacter => 'L\'élève étudie le caractère';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'N\'écrivez jamais d\'introductions, de salutations ou de phrases de remplissage comme';

  @override
  String get beDirectAndInformative => 'Soyez direct et informatif.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'RÈGLE CRITIQUE : Vous devez répondre ENTIÈREMENT dans la langue correspondant au code ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Vous êtes un tuteur concis de grammaire chinoise au sein d\'une application mobile.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'L\'élève a des doutes sur le mot';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'N\'écrivez jamais d\'introductions, de salutations ou de phrases de remplissage.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Les clés de l\'API Azure Speech sont manquantes.';

  @override
  String get success => 'Succès';

  @override
  String get granularity => 'Granularité';

  @override
  String get phoneme1 => 'Phonème';

  @override
  String get dimension => 'Dimension';

  @override
  String get comprehensive => 'Complet';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Nous n\'avons pas pu vous entendre clairement. Veuillez réessayer.';

  @override
  String get noNbestResultFound => 'Aucun résultat NBest trouvé.';

  @override
  String get words1 => 'Mots';

  @override
  String get word => 'Mot';

  @override
  String get phonemes => 'Phonèmes';

  @override
  String get syllables => 'Syllabes';

  @override
  String get syllable => 'Syllabe';

  @override
  String get omission => 'Omission';

  @override
  String get insertion => 'Insertion';

  @override
  String get youMissedThisWord => 'Vous avez manqué ce mot.';

  @override
  String get extraWordAddedHere => 'Mot supplémentaire ajouté ici.';

  @override
  String get mispronunciation => 'Mauvaise prononciation';

  @override
  String get pronunciationWasInaccurate => 'La prononciation était imprécise.';

  @override
  String get goodEffortKeepPracticing => 'Bon effort ! Continuez à pratiquer.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Prononciation parfaite ! On dirait un locuteur natif.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Excellent travail ! Quelques légères imprécisions de ton.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Pas mal, mais vos tons ont besoin d\'être travaillés.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Continuez à pratiquer ! Écoutez l\'audio natif et réessayez.';

  @override
  String get lexical => 'Lexical';

  @override
  String get chineseHanziHere => 'Caractère chinois (Hanzi) ici';

  @override
  String get aShortSummaryInEnglish => 'Un court résumé en français';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'Aucun texte chinois cohérent trouvé dans le scan.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'La traduction complète du texte scanné... OU \'Aucun texte chinois cohérent trouvé.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Un titre court de 2 à 4 mots pour ce scan (ex. \'Menu de restaurant\', \'Panneau de rue\')';

  @override
  String get china => 'Chine';

  @override
  String get noTranslationAvailable => 'Aucune traduction disponible.';

  @override
  String get scanResults => 'Résultats du scan';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Quand a-t-il été écrit et que se passait-il en Chine à cette époque ?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Pourquoi cette œuvre est-elle célèbre ? Quels thèmes philosophiques ou culturels explore-t-elle ?';

  @override
  String get aBriefBioOfTheAuthor => 'Une brève biographie de l\'auteur.';

  @override
  String get informationUnavailable => 'Informations non disponibles.';

  @override
  String get noSummaryAvailable => 'Aucun résumé disponible.';

  @override
  String get hanziAiPro => 'Hanzi AI Pro';

  @override
  String get trialNormalIntro => 'Essai, Normal, Intro';

  @override
  String get dailyDrop => 'Dose quotidienne';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Notifications quotidiennes pour le Mot du Jour et les actualités';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Un nouveau Mot et une Histoire du Jour vous attendent !';

  @override
  String get spacedRepetition => 'Répétition espacée';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Rappels pour les flashcards à réviser';

  @override
  String get engagementReminders => 'Rappels d\'engagement';

  @override
  String get trialReminders => 'Rappels d\'essai';

  @override
  String get notificationsForYourTrialStatus =>
      'Notifications concernant le statut de votre essai';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Venez réviser vos Hanzi et essayez un Appel en Direct avant la fin de votre accès gratuit !';

  @override
  String get scholarsEye => 'L\'Œil de l\'Érudit';

  @override
  String get clMeasureWord => 'Classificateur :';

  @override
  String get surnameShi => 'Nom de famille Shi';

  @override
  String get chineseFamilyNameShi => 'Nom de famille chinois (Shi)';

  @override
  String get neutralToneLight => 'Ton neutre (léger)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Maintenez votre hauteur de voix élevée et stable comme si vous chantiez une note.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Commencez au milieu et faites monter votre hauteur de voix comme si vous demandiez \'Quoi ?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Baissez votre voix, puis remontez-la doucement.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Baissez votre hauteur de voix de manière nette et décisive comme un \'Non !\' ferme.';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Prononcez doucement, brièvement et sans emphase.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'Parfait ! La hauteur était haute, stable et uniforme.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'Parfait ! La montée de la hauteur était claire.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'Parfait ! La courbe descendante était précise.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'Parfait ! Le ton descendant était net et précis.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'Parfait ! Le ton a été prononcé avec précision.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'J\'accepte les Conditions d\'utilisation et la Politique de confidentialité.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Envoyez-moi des mises à jour, des astuces et des offres occasionnelles.';

  @override
  String get signInToSyncYourProgress =>
      'Connectez-vous pour synchroniser votre progression.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Créez un compte pour sauvegarder vos statistiques.';

  @override
  String get smartSpiral => 'SPIRALE INTELLIGENTE';

  @override
  String get origin => 'Origine';

  @override
  String get elements => 'Éléments';

  @override
  String get humanity => 'Humanité';

  @override
  String get village => 'Village';

  @override
  String get journey => 'Voyage';

  @override
  String get city => 'Ville';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Les formes les plus simples. Le début de toutes choses.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Soleil, Lune, Eau et Feu. Le monde naturel.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Le corps, le cœur et la famille.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Champs, toits et outils. Les fondations de la société.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Mouvement, parole et subsistance.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Commerce, vêtements et artefacts complexes.';

  @override
  String get equilibriumAlgorithm => 'Algorithme d\'équilibre';

  @override
  String get misc => 'Divers';

  @override
  String get cityOrOriginAs => '« Ville » ou « Origine » comme';

  @override
  String get miscToOrigin => '« Divers » à « Origine »';

  @override
  String get constellation => 'Constellation';

  @override
  String get whichOneIsWater => 'Lequel correspond à « Eau » ?';

  @override
  String get whatIsThePinyin => 'Quel est le pinyin ?';

  @override
  String get nature => 'Nature';

  @override
  String get whatEssenceDoes => 'Quelle essence a';

  @override
  String get allTiers => 'Tous les niveaux';

  @override
  String get active => 'Actif';

  @override
  String get theScrollOfOrigin1 => 'LE PARCHEMIN DE L\'ORIGINE';

  @override
  String galaxyOf1(Object name) {
    return 'GALAXIE DE $name';
  }

  @override
  String get also => 'Aussi';

  @override
  String get work => 'Travail';

  @override
  String get cloud => 'Nuage';

  @override
  String get youArchaic => 'Vous (archaïque)';

  @override
  String get suddenly => 'Soudainement';

  @override
  String get owner => 'Propriétaire';

  @override
  String get door => 'Porte';

  @override
  String get occupy => 'Occuper';

  @override
  String get nail => 'Clou';

  @override
  String get and => 'Et';

  @override
  String get buddhistNun => 'Nonne bouddhiste';

  @override
  String get anxious => 'Anxieux';

  @override
  String get sprout => 'Pousse';

  @override
  String get exchange => 'Échange';

  @override
  String get sheep => 'Mouton';

  @override
  String get strange => 'Étrange';

  @override
  String get opposite => 'Opposé';

  @override
  String get shorttailedBird => 'Oiseau à queue courte';

  @override
  String get shoot => 'Pousse';

  @override
  String get small => 'Petit';

  @override
  String get gather => 'Rassembler';

  @override
  String get order => 'Ordre';

  @override
  String get flat => 'Plat';

  @override
  String get thePersonWho => 'La personne qui...';

  @override
  String get nobleman => 'Noble';

  @override
  String get cause => 'Cause';

  @override
  String get pig => 'Cochon';

  @override
  String get bright => 'Lumineux';

  @override
  String get slowly => 'Lentement';

  @override
  String get give => 'Donner';

  @override
  String get arrow => 'Flèche';

  @override
  String get dry => 'Sec';

  @override
  String get obstacle => 'Obstacle';

  @override
  String get beg => 'Mendier';

  @override
  String get window => 'Fenêtre';

  @override
  String get fear => 'Peur';

  @override
  String get drum => 'Tambour';

  @override
  String get why => 'Pourquoi';

  @override
  String get talent => 'Talent';

  @override
  String get follow => 'Suivre';

  @override
  String get desert => 'Désert';

  @override
  String get component => 'Composant';

  @override
  String divingInto1(Object topic) {
    return 'Plongée dans';
  }

  @override
  String get unitIntro1 => 'Introduction de l\'unité';

  @override
  String get theBlueprint => 'LE SCHÉMA';

  @override
  String get theOrigin => 'L\'ORIGINE';

  @override
  String get theGalaxy => 'LA GALAXIE';

  @override
  String get theScholarListens => 'L\'Érudit écoute...';

  @override
  String get consultingTheScrolls => 'Consultation des parchemins...';

  @override
  String get traceWithTheGuide => 'Tracer avec le Guide';

  @override
  String get traceTheGhost => 'Tracer le Fantôme';

  @override
  String get connectTheDots => 'Relier les points';

  @override
  String get drawFromMemory => 'Dessiner de mémoire';

  @override
  String get assistant => 'Assistant';

  @override
  String get puck => 'Puck (masculin, sportif)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Bonjour ! Bienvenue. Que souhaitez-vous commander ?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Ni3 hao3! Huan1ying2 guang1lin2. Qing3wen4 ni3 yao4 dian3 shen2me?';

  @override
  String get waiterLi => 'Serveur Li';

  @override
  String get askForTheMenu => 'Demander le menu';

  @override
  String get orderOneDishAndOneDrink => 'Commander un plat et une boisson';

  @override
  String get askForTheBill => 'Demander l\'addition';

  @override
  String get fenrir => 'Fenrir (masculin, dynamique)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Ni3 qu4 na3r a? Ji1chang3 ma? Ting3 yuan3 de!';

  @override
  String get driverWang => 'Chauffeur Wang';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Dire au chauffeur que vous allez à l\'aéroport';

  @override
  String get askHowLongTheTripWillTake => 'Demander la durée du trajet';

  @override
  String get complainAboutTheTraffic => 'Se plaindre des embouteillages';

  @override
  String get charon => 'Charon (masculin, style journal)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'La qualité de ce vêtement est particulièrement bonne, seulement 200 kuai.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhe4 jian4 yi1fu zhi4liang4 te4bie2 hao3, zhi3yao4 liang3 bai3 kuai4.';

  @override
  String get auntieChen => 'Tante Chen';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'Demander le prix de la chemise en soie';

  @override
  String get sayItIsTooExpensive => 'Dire que c\'est trop cher';

  @override
  String get bargainThePriceDownTo100Rmb => 'Négocier le prix à 100 RMB';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Ni3 na3li3 bu4 shu1fu? Fa1shao1 le ma?';

  @override
  String get drZhang => 'Dr Zhang';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Expliquer que vous avez mal à la tête depuis deux jours';

  @override
  String get sayYouHaveASlightFever => 'Dire que vous avez une légère fièvre';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Demander si vous devez prendre des médicaments';

  @override
  String get aoede => 'Aoede (féminin, joyeux)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Salut ! Ça fait longtemps, comment vas-tu ces derniers temps ?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Ni3 hao3! Hao3jiu3 bu4jian4, ni3 zui4jin4 zen3me yang4?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Veuillez vous présenter. Pourquoi souhaitez-vous travailler dans notre entreprise ?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qing3 xian1 zi4wo3 jie4shao4 yi1xia4. Ni3 wei4shen2me xiang3 lai2 wo3men gong1si1 gong1zuo4?';

  @override
  String get managerLiu => 'Directeur Liu';

  @override
  String get introduceYourProfessionalBackground =>
      'Présentez brièvement votre parcours professionnel';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Expliquez pourquoi vous souhaitez travailler dans cette entreprise';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Poser une question polie sur la culture d\'entreprise';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'L\'accès au microphone est requis. Veuillez l\'activer dans les réglages de votre appareil.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Impossible de démarrer le microphone. Veuillez vérifier vos réglages audio et réessayer.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Nous n\'avons pas bien compris. Veuillez tenir le micro et réessayer !';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'L\'enregistrement était trop court. Tenez le micro et parlez clairement.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Le tampon audio était vide. Veuillez vérifier votre microphone et réessayer.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'Le fichier audio est silencieux. Veuillez parler dans le microphone.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Nous n\'avons pas pu comprendre votre prononciation. Veuillez parler clairement et réessayer.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'Le serveur met trop de temps à répondre. Veuillez réessayer.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Pas de connexion internet. Veuillez vérifier votre réseau et réessayer.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Échec du traitement audio. Veuillez réessayer.';

  @override
  String get permission => 'Autorisation';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Impossible de traiter votre enregistrement. Veuillez réessayer.';

  @override
  String get user => 'Utilisateur';

  @override
  String get scholar => 'Érudit';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Nos tuteurs IA sont actuellement hors ligne, veuillez réessayer plus tard.';

  @override
  String get hideTranslation => 'Masquer la traduction';

  @override
  String get azureAssessment => 'Évaluation Azure...';

  @override
  String get microphonePermissionRequired =>
      'Autorisation du microphone requise';

  @override
  String get connectedSpeakNow => 'Connecté ! Parlez maintenant.';

  @override
  String get initializationErrorCheckPermissions =>
      'Erreur d\'initialisation. Vérifiez les autorisations.';

  @override
  String get microphoneErrorTapToRetry =>
      'Erreur micro. Touchez pour réessayer.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'Le tuteur a renvoyé une réponse vide.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Connexion interrompue. Veuillez parler à nouveau.';

  @override
  String get callPausedReviewingTones => 'Appel en pause (Révision des tons)';

  @override
  String get pausedTakeABreak => 'En pause - Faites une pause';

  @override
  String get goodStartPracticing => 'Bon début d\'entraînement';

  @override
  String get studentCoach => 'Étudiant / Coach';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Maintenez votre 1er ton haut et stable sur';

  @override
  String get noScenariosFound => 'Aucun scénario trouvé.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Créez votre propre expérience de jeu de rôle IA';

  @override
  String get generateFromDeck => 'Générer depuis le deck';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Pratiquez le vocabulaire des flashcards dans un dialogue en direct';

  @override
  String get tapToRoleplay => 'Touchez pour jouer un rôle';

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
  String get dinnerWithDad => 'Dîner avec papa';

  @override
  String get orderingAtAChengduTeahouse =>
      'Commander dans une maison de thé de Chengdu';

  @override
  String get buyingTeaAtTheMarket => 'Acheter du thé au marché';

  @override
  String get meetingAnOldClassmate => 'Rencontrer un ancien camarade de classe';

  @override
  String get readyToPractice => 'Prêt à pratiquer ?';

  @override
  String get letsPracticeChinese => 'Pratiquons le chinois';

  @override
  String get areYouReady => 'Êtes-vous prêt ?';

  @override
  String get discussWhatToHaveForDinner =>
      'Discuter de ce qu\'il faut manger pour le dîner';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Suggérer de regarder un film après';

  @override
  String get askIfTheyWouldLikeTea => 'Demander s\'ils aimeraient du thé';

  @override
  String get helloVeryNiceToMeetYou =>
      'Bonjour ! Très heureux de vous rencontrer.';

  @override
  String get deckPractice => 'Pratique du deck';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Pratiquez le vocabulaire avec un partenaire IA.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Concevez des conversations et jeux de rôle IA personnalisés';

  @override
  String get random => 'Aléatoire';

  @override
  String get scenarioTopic => 'Sujet du scénario';

  @override
  String get contextSettingOptional => 'Contexte et cadre (Facultatif)';

  @override
  String get aiCharacterPersonaOptional =>
      'Personnage / Persona IA (Facultatif)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Une paisible maison de thé à cour de bambou à Chengdu, avec une douce musique de guzheng.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Un marché de nuit animé et enfumé, rempli de brochettes, de petits pains vapeur et de stands de street food.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Un restaurant de hotpot animé à Chongqing, avec un bouillon cramoisi bouillonnant et un arôme de piment parfumé.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Une maison de thé cantonaise traditionnelle animée à Guangzhou, remplie de paniers en bambou fumants.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Un café chic et minimaliste dans la Concession française, un dimanche après-midi pluvieux.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Une cuisine chaleureuse du nord en hiver, avec de la farine sur la table et des marmites de raviolis fumants.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Une allée de street food nocturne en plein air, avec des brochettes d\'agneau grésillantes, des aubergines rôties et de la bière fraîche.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Un coin de rue enneigé devant le Temple des Lamas, avec des brochettes de Tanghulu (baies d\'aubépine confites) sur de la glace.';

  @override
  String get craftBeerBreweryInQingdao => 'Brasserie artisanale à Qingdao';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Un bar de dégustation côtier animé avec des fûts en bois, une brise marine et des tireuses de bière de blé fraîche.';

  @override
  String get sichuanCookingMasterclass => 'Masterclass de cuisine sichuanaise';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Une cuisine ouverte vibrante avec des woks flamboyants, de l\'huile de piment frémissante et des grains de poivre frais.';

  @override
  String get highspeedRailSeatMixup =>
      'Inversion de sièges dans le train à grande vitesse';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Randonnée au lever du soleil sur la Grande Muraille à Mutianyu';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'Les anciens remparts de pierre de la Grande Muraille à l\'aube, entourés de montagnes vertes et brumeuses.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Descente en radeau de bambou sur la rivière Li à Guilin';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Glisser sur les eaux karstiques émeraude entre des pics calcaires brumeux et spectaculaires près de Yangshuo.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Randonnée à dos de chameau sur la Route de la Soie à Dunhuang';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Les dunes de sable doré ondulantes de la montagne Mingsha, à côté de l\'oasis du lac du Croissant.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Réserver un séjour en maison d\'hôtes avec cour à Dali';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Un hôtel-boutique serein de style Bai avec cour, surplombant le lac Erhai au Yunnan.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Pèlerinage au Palais du Potala à Lhassa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Les majestueux escaliers de pierre baignés de soleil devant le Palais du Potala, avec des moulins à prières tournants.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Un pays des merveilles subarctique de palais de glace en cristal illuminés et de sculptures de neige imposantes.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Téléphérique de la montagne Avatar à Zhangjiajie';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Suspendu en hauteur dans une télécabine en verre, planant au-dessus de milliers de pics de grès en forme de piliers.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Camp d\'observation des étoiles dans le désert de Gobi au Gansu';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Un camp de yourtes de luxe sous un ciel de Voie lactée cristallin dans le désert, près de Jiayuguan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Croisière sur le fleuve Yangtsé et les Trois Gorges';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'Sur le pont soleil d\'un bateau de croisière fluviale, traversant les spectaculaires et imposantes Gorges de Qutang.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Acheter des antiquités à Panjiayuan, Pékin';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Un four de poterie historique rempli de délicats vases en porcelaine non cuite et d\'émaux bleu cobalt.';

  @override
  String get suzhouSilkEmbroideryStudio =>
      'Atelier de broderie sur soie de Suzhou';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Un paisible atelier de jardin au bord d\'un canal à Suzhou, avec de fins fils de soie et des cadres à broder en bois.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Dans les coulisses d\'un théâtre d\'opéra de Pékin traditionnel, avec des costumes colorés, des miroirs et des coiffes.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Consultation de médecine traditionnelle chinoise';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Tai-chi matinal au Parc du Temple du Ciel';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Sous d\'anciens cyprès à l\'aube, avec des oiseaux du parc et des seniors pratiquant des mouvements synchronisés.';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'Location d\'un Hanfu pour une séance photo';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Une boutique de costumes traditionnels près du Lac de l\'Ouest, avec des portants de robes des dynasties Tang et Song.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Atelier d\'instrument Guqin (cithare ancienne)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Un studio tranquille en bois de pin à Hangzhou, rempli d\'instruments en bois de paulownia vieilli et à cordes de soie.';

  @override
  String get shaanxiShadowPuppetTheater =>
      'Théâtre d\'ombres chinoises du Shaanxi';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Derrière un écran de soie blanc illuminé, avec de délicates figures d\'ombres en cuir translucide.';

  @override
  String get chineseCalligraphyWorkshop => 'Atelier de calligraphie chinoise';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Un studio tranquille parfumé à l\'encre de suie de pin, aux rouleaux de papier de riz et aux doux arômes de thé.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Adopter un chat dans un refuge pour animaux';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Un centre de sauvetage pour animaux douillet à Hangzhou, avec des chatons de sauvetage énergiques et du thé pour les visiteurs.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Jeu de rôle d\'enquête (Jubensha)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Un salon de détective à thème à Shanghai, avec des joueurs costumés et des bougies.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Magasin de disques vinyles vintage à Shanghai';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Un magasin de vinyles caché dans une vieille maison de ruelle, rempli de disques classiques de Cantopop des années 80 et de jazz.';

  @override
  String get ktvKaraokePartyWithFriends => 'Soirée karaoké KTV entre amis';

  @override
  String get joiningACityBikeCyclingClub =>
      'Rejoindre un club de cyclisme urbain';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Un rassemblement de cyclistes au bord de la rivière, se préparant pour une balade nocturne autour de la ligne d\'horizon de la ville.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Rencontre d\'échange de figurines « blind box »';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Un magasin de jouets pop-culture coloré à Chaoyang, avec des étagères d\'exposition et des boîtes de collection non ouvertes.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Vidéographie aérienne par drone au Bund';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'La promenade du Bund au crépuscule, surplombant les gratte-ciel futuristes illuminés de Pudong.';

  @override
  String get goldenRetrieverCafeInNanjing => 'Café Golden Retriever à Nankin';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Un café pour animaux ensoleillé et joyeux, avec des dizaines de chiens affectueux accueillant les visiteurs.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Salle d\'escalade de bloc à Chengdu';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Une salle d\'escalade intérieure moderne, avec des voies de prises aux couleurs vives et une musique entraînante.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Un immense hall de convention rempli de stands de jeux colorés, de murs photo et de créateurs costumés.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Demander son chemin dans un hutong de Pékin';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Un labyrinthe de ruelles historiques en briques grises, avec des vélos, des cours intérieures et des grenadiers.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Acheter des fruits frais au marché traditionnel';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Un marché de quartier matinal animé, avec des monticules de litchis frais, de mangues et de fruits du dragon.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Bouquet du marché aux fleurs à Kunming';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'Le célèbre marché aux fleurs de Dounan, entouré de milliers de roses fraîches, de lys et de tiges d\'eucalyptus.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Retouches de tailleur dans une vieille maison de ruelle';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Un atelier de tailleur traditionnel, rempli de machines à coudre, de tissus et de mètres-rubans.';

  @override
  String get expressParcelLockerRetrieval =>
      'Récupération de colis en consigne express';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'En bas, à l\'entrée d\'un immeuble résidentiel, à côté d\'un système de casiers intelligents Hive box.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Réparation de pneu de vélo crevé à l\'entrée du campus';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Un petit stand d\'outils en bord de route, sous un grand banian feuillu.';

  @override
  String get techCompanyProductDemo =>
      'Démonstration de produit d\'entreprise technologique';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Un stand de conférence technologique futuriste à Shenzhen, présentant du matériel d\'IA de pointe.';

  @override
  String get ecommerceLivestreamStudio =>
      'Studio de diffusion en direct e-commerce';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Un studio de diffusion à haute énergie, avec des anneaux lumineux, des présentoirs de produits et des moniteurs de commentaires en direct.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Marché international du commerce de Yiwu';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Un vaste centre commercial d\'exposition de plusieurs étages, rempli de millions de produits en gros et d\'artisanat.';

  @override
  String get universityCampusExchangeProgram =>
      'Programme d\'échange universitaire';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Une pelouse ensoleillée devant la bibliothèque universitaire, avec des étudiants qui étudient et boivent du thé au lait.';

  @override
  String get pleaseEnterAScenarioTopic =>
      'Veuillez saisir un sujet de scénario.';

  @override
  String get nameTitle => 'Nom (Titre)';

  @override
  String get aiCharacter => 'Personnage IA';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Bonjour ! Bienvenue, de quoi allons-nous discuter aujourd\'hui ?';

  @override
  String get greetYourConversationPartner => 'Saluez votre interlocuteur';

  @override
  String get askAQuestionInChinese => 'Posez une question en chinois';

  @override
  String get pinyinWithToneMarks => 'Pinyin avec tons';

  @override
  String get goal1InEnglish => 'Objectif 1 en français';

  @override
  String get goal2InEnglish => 'Objectif 2 en français';

  @override
  String get goal3InEnglish => 'Objectif 3 en français';

  @override
  String get beginner => 'Débutant';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Maître';

  @override
  String get azurePronunciationAssessment =>
      'ÉVALUATION DE LA PRONONCIATION AZURE';

  @override
  String get tapToReview => 'Appuyez pour réviser';

  @override
  String get overallScore => 'Score global';

  @override
  String get toneAccuracy => 'Précision des tons';

  @override
  String get fluency => 'Fluidité';

  @override
  String get report => 'Signaler';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Bonne prononciation, mais peut être améliorée !';

  @override
  String get didYouMeanToSay => 'Vouliez-vous dire... ?';

  @override
  String get greatKeepTrying => 'Excellent ! Continuez à vous entraîner !';

  @override
  String get completeness => 'Exhaustivité';

  @override
  String get targetTone => 'Ton cible';

  @override
  String get k4toneComparisonTapToListen =>
      'Comparaison des 4 tons (Touchez pour écouter) :';

  @override
  String get youSpokeMatch => 'Vous avez prononcé (Correspondance !)';

  @override
  String get youSpoke => 'Vous avez prononcé';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Votre collection principale de caractères.';

  @override
  String get deckNotFound => 'Deck introuvable';

  @override
  String get cannotDeleteTheDefaultDeck =>
      'Impossible de supprimer le deck par défaut';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4 : Intermédiaire supérieur';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'Les 150 premiers caractères pour commencer votre parcours.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Développez votre vocabulaire jusqu\'à 300 mots essentiels.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Maîtrisez la fluidité conversationnelle avec 600 mots.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Lisez des textes et conversez couramment avec 1200 mots.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Lisez les journaux et regardez des films avec 2500 mots.';

  @override
  String get databaseBoxNotOpen => 'La base de données n\'est pas ouverte';

  @override
  String get hsk1DataFileIsEmpty => 'Le fichier de données HSK1 est vide';

  @override
  String get gold => 'Or';

  @override
  String get globalDictionaryNotInitialized =>
      'Dictionnaire global non initialisé';

  @override
  String get reading => 'Lecture';

  @override
  String get recall => 'Mémorisation';

  @override
  String get speaking => 'Expression orale';

  @override
  String get listening1 => 'Écoute';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Pratiquez l\'ordre des traits avec des guides visuels.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Observez le caractère, retrouvez le pinyin et la signification.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Lisez la signification, tracez le caractère de mémoire.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Lisez à voix haute pour tester les tons de votre prononciation.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Écoutez l\'audio et identifiez le caractère.';

  @override
  String get contract => 'Contrat';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Quiconque m\'implémente DOIT être capable de faire ces choses.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck ou local';

  @override
  String get manageDecks => 'Gérer les decks';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Nous avons rencontré un problème lors du chargement de la bibliothèque. Veuillez réessayer.';

  @override
  String get noCharactersInLexicon1 => 'Aucun caractère dans le lexique';

  @override
  String get masterTheBuildingBlocks => 'Maîtrisez les bases';

  @override
  String get other => 'Autre';

  @override
  String get requiredLabel => 'Obligatoire';

  @override
  String get library1 => 'Bibliothèque';

  @override
  String get youAreAPremiumMember => 'Vous êtes un membre Premium';

  @override
  String get createAccountToSyncProgress =>
      'Créer un compte pour synchroniser la progression';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get account => 'Compte';

  @override
  String get guestScholar => 'Érudit invité';

  @override
  String get localAccount => 'Compte local';

  @override
  String get unknownRadical => 'Radical inconnu';

  @override
  String get followTheGuideStroke => 'Suivez le trait guide';

  @override
  String get strokeAnimationSpeed => 'Vitesse de l\'animation des traits';

  @override
  String get notifications => 'Notifications';

  @override
  String get deutsch => 'Allemand';

  @override
  String get bahasaIndonesia => 'Indonésien';

  @override
  String get italiano => 'Italien';

  @override
  String get today1d2d3d4d5d6d => 'Aujourd\'hui, 1j, 2j, 3j, 4j, 5j, 6j';

  @override
  String get targetDeck => 'Deck cible';

  @override
  String get mixed => 'Mixte';

  @override
  String get topicForContext => 'Sujet (pour le contexte)';

  @override
  String get nounsOnly => 'Noms uniquement';

  @override
  String get verbsOnly => 'Verbes uniquement';

  @override
  String get idiomsChengyu => 'Idiomes (Chengyu)';

  @override
  String get fullSentences => 'Phrases complètes';

  @override
  String get beginnerHsk12 => 'Débutant (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Intermédiaire (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Avancé (HSK 5-6)';

  @override
  String get generatedByAi => 'Généré par l\'IA';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Pouvez-vous me donner deux autres exemples utilisant ce mot ?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Quels sont des mots similaires et en quoi diffèrent-ils ?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Ce mot est-il plus utilisé en chinois parlé ou écrit ?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Y a-t-il d\'autres façons de traduire ce mot ?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'Quels sont les mots courants qui s\'associent à ce mot ?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Quelles sont les erreurs courantes que les apprenants font avec ce mot ?';

  @override
  String get emptyResponse => 'Réponse vide';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Quelle est l\'origine de ce caractère dans l\'écriture oraculaire (ossécaille) ?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Comment la forme ancienne de ce caractère a-t-elle évolué au fil du temps ?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Donnez-moi 3 mots courants contenant ce caractère.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'Quels autres caractères partagent le même radical ?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Existe-t-il un proverbe ou une expression chinoise comportant ce caractère ?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Expliquez les règles d\'ordre des traits pour ce caractère.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Donnez-moi un conseil de calligraphie pour écrire ce caractère avec élégance.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Y a-t-il une particularité grammaticale délicate à son utilisation ?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'Quels mots sont souvent confondus avec celui-ci et pourquoi ?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Ce caractère a-t-il une symbolique culturelle en Chine ?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Ce caractère est-il couramment rencontré dans les films, chansons ou textes chinois ?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Que signifie le radical de ce caractère ?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Détaillez chaque composant et sa signification.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Donnez-moi une astuce pour retenir le ton correct de ce caractère.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Existe-t-il des homophones courants souvent confondus avec celui-ci ?';

  @override
  String get quotaExceeded => 'Quota dépassé';

  @override
  String get mustProvideEitherCardOrCards =>
      'Vous devez fournir une carte ou des cartes';

  @override
  String get deckSettings => 'Paramètres du paquet';

  @override
  String get saveSettings => 'Enregistrer les paramètres';

  @override
  String get sealRed => 'Sceau rouge';

  @override
  String get sealScript => 'Écriture sigillaire';

  @override
  String get startYourStreak => 'COMMENCEZ VOTRE SÉRIE';

  @override
  String get traditionalCharacter => 'Caractère traditionnel';

  @override
  String get inQueue => 'En file d\'attente';

  @override
  String get tapToListenAgain => 'Touchez pour réécouter';

  @override
  String get contextClue => 'Indice contextuel';

  @override
  String get microphonePermissionRequired1 =>
      'Autorisation du microphone requise.';

  @override
  String get recordingFailedNoFile =>
      'Échec de l\'enregistrement (aucun fichier).';

  @override
  String get holdToSpeakOptional => 'Maintenez pour parler (Facultatif)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Autorisation du microphone refusée. Activez-la dans les Réglages pour utiliser le Studio de Shadowing.';

  @override
  String get sessionSummary => 'Résumé de la session';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Voici les caractères avec lesquels vous avez eu des difficultés :';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Appliquer les notes de session à la Répétition Espacée (Mode Oral)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Maîtrisez votre prononciation du mandarin\nen imitant des locuteurs natifs.';

  @override
  String get aiIsGradingYourPronunciation =>
      'L\'IA évalue votre prononciation...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Maintenez le micro pour enregistrer. Relâchez pour évaluer.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Touchez n\'importe quelle syllabe pour écouter les 4 tons :';

  @override
  String get freeFlowConversationalPractice =>
      'Pratique conversationnelle libre.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Échec de la génération de la phrase. Veuillez réessayer.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Enregistrement trop court. Maintenez le bouton du micro plus longtemps.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Erreur d\'enregistrement. Veuillez réessayer.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Aucun enregistrement capturé. Veuillez réessayer.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'L\'audio enregistré est vide. Veuillez réessayer et parler clairement.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Les clés API Azure Speech sont manquantes';

  @override
  String get azureError401 => 'Erreur Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Échec de l\'authentification Azure. Vérifiez votre clé API Speech et votre région dans .env';

  @override
  String get azureError429 => 'Erreur Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Quota Azure dépassé. Veuillez réessayer plus tard.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'L\'évaluation Azure a expiré. Vérifiez votre connexion internet.';

  @override
  String get recognitionFailedNull => 'Reconnaissance échouée : null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Impossible de vous entendre clairement. Veuillez réessayer.';

  @override
  String get singlePhrasePractice => 'Pratique d\'une seule phrase';

  @override
  String get failedToGeneratePhrase => 'Échec de la génération de la phrase';

  @override
  String get omitted => 'Omis';

  @override
  String get partial => 'Partiel';

  @override
  String get mispronounced => 'Mal prononcé';

  @override
  String get startSession1 => 'Démarrer la session';

  @override
  String get chinese => 'Chinois';

  @override
  String get paused => 'En pause';

  @override
  String get translationFailed => 'Traduction échouée';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Des analyses macroéconomiques et commerciales captivantes expliquées par une narration vivante.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Explore les économies mondiales, les histoires bancaires et les dynamiques industrielles globales.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Un mandarin clair et articulé, parfait pour les apprenants intermédiaires et avancés.';

  @override
  String get chefWang => 'Chef Wang';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Maîtrisez les techniques culinaires sichuanaises enseignées directement par un chef professionnel.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Recettes chinoises authentiques étape par étape avec maîtrise du wok et travail au couteau.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Vocabulaire culinaire concis et instructions claires en mandarin naturel.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Cinématographie, technologies de caméra de pointe et évaluations approfondies des médias numériques.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Style documentaire de haute production explorant la création vidéo et les innovations en IA.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Mandarin technique riche avec une prononciation cristalline et des sous-titres visuels.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Journalisme d\'investigation approfondi et commentaires sur l\'actualité.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Perspectives critiques sur les phénomènes sociaux, l\'actualité mondiale et l\'histoire.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Discours d\'investigation formel, idéal pour la compréhension orale avancée.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Documentaires scientifiques animés courts répondant aux questions quotidiennes.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Explore la physique, la biologie et les curiosités quotidiennes avec des infographies amusantes.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Mandarin pékinois standard avec une narration bien rythmée et des sous-titres clairs.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Aventures culinaires de rue réconfortantes et conversations authentiques à travers la Chine.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Explore des histoires humaines régionales, des traditions familiales et des délices locaux.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Mandarin conversationnel naturel avec l\'argot quotidien et une chaleur émotionnelle.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Critiques humoristiques et honnêtes d\'électronique grand public basées sur l\'expérience réelle.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Tests de smartphones, de gadgets pour la maison intelligente et d\'équipements technologiques lifestyle.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Dialogue conversationnel détendu et humoristique avec des expressions familières modernes.';

  @override
  String get seanKitchen => 'Cuisine de Sean';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Délicieux plats chinois faits maison et recréations de snacks de rue.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Conseils de cuisine faciles à suivre pour préparer des plats réconfortants asiatiques authentiques.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Commentaires chaleureux et accueillants avec un vocabulaire de cuisine pratique.';

  @override
  String get chineseChannel => 'Chaîne Chinoise';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Leçons de langue chinoise structurées et tutoriels de découverte culturelle.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Points de grammaire, développement du vocabulaire HSK et schémas de conversation.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Rythme pédagogique clair, spécialement adapté aux apprenants de chinois.';

  @override
  String get oneInABillion => 'Un sur un milliard';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Portraits intimes et histoires d\'individus uniques dans la Chine contemporaine.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Explore divers choix de vie, la culture jeune et les évolutions sociales modernes.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Narration profonde avec un vocabulaire riche et des voix authentiques.';

  @override
  String get vickySoup => 'Vicky Soup';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Vlogs de style de vie esthétique, stylisme de mode et routines quotidiennes.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Journaux de voyage et moments de vie douillets documentés avec une chaleur cinématographique.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Mandarin décontracté et naturel parlé à un rythme confortable et expressif.';

  @override
  String get tededMandarin => 'TED-Ed Mandarin';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Leçons éducatives animées de haute qualité sur la science, la philosophie et l\'histoire.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Énigmes stimulantes, littérature classique et mystères de la psychologie.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Mandarin en voix off impeccable avec sous-titres bilingues synchronisés.';

  @override
  String get channel => 'Chaîne';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Documentaires culturels sélectionnés et moments forts du style de vie chinois.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Exploration des arts traditionnels, de l\'artisanat patrimonial et des tendances modernes.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Audio de haute qualité avec sous-titres chinois synchronisés.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Histoires intéressantes et projets vidéo créatifs sur le web chinois.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Entretiens captivants, narration et explorations visuelles.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Excellent matériel d\'écoute avec une prononciation standard.';

  @override
  String get xVsY => 'X contre Y';

  @override
  String get untitled => 'Sans titre';

  @override
  String get contemporaryStories => 'Histoires contemporaines';

  @override
  String get history => 'Histoire';

  @override
  String get advancedReading => 'Lecture avancée';

  @override
  String get intermediateReading => 'Lecture intermédiaire';

  @override
  String get beginnerReading => 'Lecture débutant';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Inconnu';

  @override
  String get localDb => 'Base de données locale';

  @override
  String get emperorTaizong => 'Empereur Taizong';

  @override
  String get emperorXuanzong => 'Empereur Xuanzong';

  @override
  String get liBai => 'Li Bai';

  @override
  String get gradedReader => 'Lectures graduées';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Apprendre le mandarin avec TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'Chinois au quotidien';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'Ting - La vie quotidienne en Chine';

  @override
  String get xinxin => 'Xinxin';

  @override
  String get sweetFamilyDailyLife => 'Douce vie de famille au quotidien';

  @override
  String get chinsunDailyLife => 'La vie quotidienne de Chin-Sun';

  @override
  String get tasteChina => 'Goûtez la Chine';

  @override
  String get dawenFoodQuest => 'Quête culinaire de DaWen';

  @override
  String get chinaTravelWithCangbao => 'Voyage en Chine avec Cangbao';

  @override
  String get alinFoodWalk => 'Promenade culinaire d\'Alin';

  @override
  String get videoOfTheDay => 'VIDÉO DU JOUR';

  @override
  String get noValidVideoFound => 'Aucune vidéo valide trouvée.';

  @override
  String get listeningPractice => 'PRATIQUE D\'ÉCOUTE';

  @override
  String get socialSkills => 'COMPÉTENCES SOCIALES';

  @override
  String get culturalContext => 'CONTEXTE CULTUREL';

  @override
  String get realLife => 'VIE RÉELLE';

  @override
  String get realWorld => 'MONDE RÉEL';

  @override
  String get articleOfTheDay => 'ARTICLE DU JOUR';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Échec du chargement ou de l\'analyse du flux RSS.';

  @override
  String get drama => 'Drame';

  @override
  String get youkugetAppNow => 'YOUKU - Téléchargez l\'application maintenant';

  @override
  String get romanceTrailer => 'Romance / Bande-annonce';

  @override
  String get romance => 'Romance';

  @override
  String get action => 'Action';

  @override
  String get mystery => 'Mystère';

  @override
  String get historical => 'Historique';

  @override
  String get historicalAction => 'Historique / Action';

  @override
  String get historicalRomance => 'Historique / Romance';

  @override
  String get anYouth => 'Une Jeunesse';

  @override
  String get historicalSliceOfLife => 'Historique / Tranche de vie';

  @override
  String get historicalHighlight => 'Historique / Temps fort';

  @override
  String get youkuEnglishgetAppNow =>
      'YOUKU English - Téléchargez l\'application maintenant';

  @override
  String get theDouble => 'Le Double';

  @override
  String get updatesByOshin => 'Mises à jour par Oshin';

  @override
  String get backFromTheBrink => 'De retour de l\'abîme';

  @override
  String get fallingIntoYourSmile => 'Tomber dans ton sourire';

  @override
  String get everyoneLovesMe => 'Tout le monde m\'aime';

  @override
  String get tillTheEndOfTheMoon => 'Jusqu\'à la fin de la lune';

  @override
  String get theBestDayOfMyLife => 'Le plus beau jour de ma vie';

  @override
  String get gikkiChineseDrama => 'Drame chinois GIKKI';

  @override
  String get dashingYouth => 'Jeunesse fougueuse';

  @override
  String get rebornChineseDramaEngSub => 'Drame chinois Reborn (Sous-titres)';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'Quand je vole vers toi';

  @override
  String get mztvExclusiveChineseDrama => 'Drame chinois exclusif MZTV';

  @override
  String get theStarryLove => 'L\'amour étoilé';

  @override
  String get comedy => 'Comédie';

  @override
  String get backFromTheBrink1 => 'De retour de l\'abîme';

  @override
  String get dashingYouth1 => 'Jeunesse fougueuse';

  @override
  String get beReborn => 'Renaître';

  @override
  String get beautyStrategy => 'Stratégie de beauté';

  @override
  String get myDivineEmissary => 'Mon émissaire divin';

  @override
  String get theHope => 'L\'espoir';

  @override
  String get ep16In => 'Épisode 16';

  @override
  String get everyoneLovesMe1 => 'Tout le monde m\'aime';

  @override
  String get fallingIntoYourSmile1 => 'Tomber dans ton sourire';

  @override
  String get hiddenLove => 'Amour caché';

  @override
  String get loveBetweenFairyAndDevil => 'L\'amour entre la fée et le diable';

  @override
  String get loveLikeTheGalaxy => 'L\'amour comme la galaxie';

  @override
  String get membersPremiere => 'Avant-première pour les membres';

  @override
  String get moonlight => 'Clair de lune';

  @override
  String get myJourneyToYou => 'Mon voyage vers toi';

  @override
  String get mysteriousLotusCasebook => 'Le mystérieux carnet de lotus';

  @override
  String get rebornChineseDramaEngSub1 => 'Drame chinois Reborn (Sous-titres)';

  @override
  String get reborn => 'Renaissance';

  @override
  String get theBestDayOfMyLife1 => 'Le plus beau jour de ma vie';

  @override
  String get theDouble1 => 'Le Double';

  @override
  String get theLongBallad => 'La longue ballade';

  @override
  String get theStarryLove1 => 'L\'amour étoilé';

  @override
  String get theUntamed => 'L\'Indompté';

  @override
  String get tillTheEndOfTheMoon1 => 'Jusqu\'à la fin de la lune';

  @override
  String get whenIFlyTowardsYou1 => 'Quand je vole vers toi';

  @override
  String get wordOfHonor => 'Parole d\'honneur';

  @override
  String get blossom => 'Éclosion';

  @override
  String get gemini => 'Gémeaux';

  @override
  String get generationToGeneration => 'De génération en génération';

  @override
  String get brocadeOdyssey => 'Odyssée de brocart';

  @override
  String get circleOfLove => 'Cercle d\'amour';

  @override
  String get dawnIsBreaking => 'L\'aube se lève';

  @override
  String get firstRomance => 'Première romance';

  @override
  String get loveInTheClouds => 'L\'amour dans les nuages';

  @override
  String get secondChanceRomance => 'Romance de seconde chance';

  @override
  String get mrBad => 'M. BAD';

  @override
  String get pursuitOfJade => 'La Quête de Jade';

  @override
  String get fatedHearts => 'Cœurs Liés par le Destin';

  @override
  String get roadHome => 'Le Chemin du Retour';

  @override
  String get myDearGuardian => 'Mon Cher Gardien';

  @override
  String get brightEyesInTheDark => 'Yeux Brillants dans l\'Obscurité';

  @override
  String get theIngeniousOne => 'L\'Ingénieux';

  @override
  String get herPhoenixMajesty => 'Sa Majesté Phénix';

  @override
  String get dreamsNeverEnd => 'Les Rêves Ne Meurent Jamais';

  @override
  String get theUltimateVowUnknownToYou => 'Le Serment Ultime, Inconnu de Toi';

  @override
  String get the300LoyalGhosts => 'Les 300 Fantômes Loyaux';

  @override
  String get homelandGuardian => 'Gardien de la Patrie';

  @override
  String get loveIsAlwaysOnline => 'L\'Amour Est Toujours Connecté';

  @override
  String get thePrincessDecree => 'Le Décret de la Princesse';

  @override
  String get aVowInTheDark => 'Un Serment dans l\'Obscurité';

  @override
  String get aGirlLikeMe => 'Une Fille Comme Moi';

  @override
  String get iAmNobody => 'Je Ne Suis Personne';

  @override
  String get myMamaGo => 'Ma Maman Part !';

  @override
  String get myWesternRegionPrincess => 'Ma Princesse de la Région de l\'Ouest';

  @override
  String get aFlowerOnTheContinent => 'Une Fleur sur le Continent';

  @override
  String get thePrincess => 'La Princesse';

  @override
  String get sweetLoveVersion => 'Version Amour Doux';

  @override
  String get hilariousFamily2 => 'Famille Hilarante 2';

  @override
  String get guYuanMountainHasASchool => 'La Montagne Gu Yuan A une École';

  @override
  String get foreverYoung => 'Éternellement Jeune';

  @override
  String get theHiddenHeirYeChen => 'L\'Héritier Caché Ye Chen';

  @override
  String get extraordinary => 'Extraordinaire';

  @override
  String get sideStoryOfFoxVolant => 'Histoire Annexe du Renard Volant';

  @override
  String get loveOfTheDivineTree => 'L\'Amour de l\'Arbre Divin';

  @override
  String get rebirth => 'Renaissance';

  @override
  String get moonlitReunion => 'Retrouvailles au Clair de Lune';

  @override
  String get videoCountsCannotBeNegative =>
      'Le nombre de vidéos ne peut pas être négatif.';

  @override
  String get publicDomainClassic => 'Classique du Domaine Public';

  @override
  String get idioms => 'Expressions Idiomatiques';

  @override
  String get news => 'Actualités';

  @override
  String get fairyTales => 'Contes de Fées';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Voici une explication culturelle fascinante';

  @override
  String get videoFetchTimedOut => 'Le chargement de la vidéo a expiré';

  @override
  String get aboutChannel => 'À PROPOS DE LA CHAÎNE';

  @override
  String get noVideosFound => 'Aucune vidéo trouvée';

  @override
  String get failedToLoadVideos => 'Échec du chargement des vidéos';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Contenu mandarin de haute qualité, sélectionné avec un vocabulaire naturel.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Chinois parlé authentique sur des thèmes et sujets du monde réel.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Matériel vidéo captivant avec sous-titres interactifs synchronisés.';

  @override
  String get watchVideo => 'Regarder la Vidéo';

  @override
  String get culturalInsight => 'Aperçu Culturel';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'L\'IA analyse le contexte culturel...';

  @override
  String get diveIntoFullContent => 'Plonger dans le Contenu Complet';

  @override
  String get savedArticles => 'Articles Enregistrés';

  @override
  String get liveOverlay => 'LECTURE AUGMENTÉE';

  @override
  String get webExplorer => 'EXPLORATEUR WEB';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Naviguez sur n\'importe quel site web chinois avec dictionnaire instantané, annotations pinyin et traductions en temps réel.';

  @override
  String get startExploring => 'COMMENCER L\'EXPLORATION';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Séries TV chinoises avec sous-titres interactifs';

  @override
  String get failedToLoadContent => 'Échec du chargement du contenu';

  @override
  String get searchingYoutube => 'Recherche sur YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'Aucune vidéo trouvée. Essayez un autre terme de recherche.';

  @override
  String get searching => 'Recherche en cours';

  @override
  String get noShowsFound => 'Aucune émission trouvée';

  @override
  String get bookmarked => 'Mis en favori';

  @override
  String get trailer1 => 'Bande-annonce';

  @override
  String get highlight1 => 'Extrait';

  @override
  String get noCaptionsAvailable => 'Aucun sous-titre disponible';

  @override
  String get fetchingSubtitles => 'Récupération des sous-titres...';

  @override
  String get generatingAiBriefing => 'Génération du résumé par l\'IA...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Aucun sous-titre codé (CC) trouvé pour cette vidéo.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Les vidéos avec sous-titres incrustés ou gravés ne disposent pas de pistes de texte numériques sur YouTube.';

  @override
  String get translatingSubtitles => 'Traduction des sous-titres...';

  @override
  String get processingYourPronunciation =>
      'Traitement de votre prononciation...';

  @override
  String get couldntIdentifyLine => 'Impossible d\'identifier la ligne.';

  @override
  String get listeningSpeakNow => 'Écoute... parlez maintenant.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Cette vidéo ne dispose pas de sous-titres numériques (CC) sur YouTube.';

  @override
  String get perfect1 => 'Parfait';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Cette vidéo a été supprimée ou n\'est plus disponible.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Cette vidéo ne peut pas être lue dans l\'application. Vous pouvez toujours la regarder sur YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Votre appareil ne peut pas lire cette vidéo. Veuillez en essayer une autre.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Référence vidéo invalide. Veuillez réessayer.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Impossible de charger cette vidéo. Veuillez en essayer une autre.';

  @override
  String get startReading => 'Commencer la lecture';

  @override
  String get analyzingCulturalContext => 'Analyse du contexte culturel...';

  @override
  String get failedToLoadCulturalInsight =>
      'Échec du chargement de l\'aperçu culturel.';

  @override
  String get historicalContext => 'Contexte historique';

  @override
  String get culturalSignificance => 'Signification culturelle';

  @override
  String get authorBackground => 'Contexte de l\'auteur';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'Plus de 80 romans classiques complets et épopées mondiales';

  @override
  String get storyOfTheDay => 'HISTOIRE DU JOUR';

  @override
  String get tangDynasty => 'Dynastie Tang';

  @override
  String get poetryClassicalVerse => 'Poésie classique et vers';

  @override
  String get allHsk => 'Tous les HSK';

  @override
  String get allStories => 'Toutes les histoires';

  @override
  String get keyWords => 'Mots-clés';

  @override
  String get openOriginalWebsite => 'Ouvrir le site web original';

  @override
  String get aiReadingTools => 'Outils de lecture IA';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Améliorez votre lecture avec des outils basés sur l\'IA';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Choisissez la difficulté cible pour la simplification';

  @override
  String get chooseDifficultyForSimplification =>
      'Choisissez la difficulté pour la simplification';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Extraire tous les mots inconnus vers un nouveau deck de cartes mémoire';

  @override
  String get length => 'Longueur';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Extraction web';

  @override
  String get aiTools => 'Outils IA';

  @override
  String get stop => 'Arrêter';

  @override
  String get keepPracticing1 => 'Continuez à pratiquer';

  @override
  String get aiPrepRoom => 'Salle de préparation IA';

  @override
  String get lessonSummary => 'RÉSUMÉ DE LA LEÇON';

  @override
  String get unlockSinosparkPremium => 'Débloquez SinoSpark Premium';

  @override
  String get monthYear => 'Mois / Année';

  @override
  String get enableNotifications => 'Activer les notifications';

  @override
  String get notificationsConfigured => 'Notifications configurées';

  @override
  String get neverMissAStroke2 => 'Ne manquez jamais un trait';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Vos alertes de dose quotidienne et de série sont prêtes.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Restez constant avec vos rituels quotidiens et vos rappels d\'essai.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Un nouveau mot et une nouvelle histoire vous attendent pour votre rituel quotidien.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'De doux rappels avant que les caractères ne s\'estompent de votre mémoire.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Recevez un rappel 2 jours avant la fin de votre essai gratuit.';

  @override
  String get yourPathTonchineseFluency =>
      'Votre chemin vers\nla maîtrise du chinois';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Répondez à 3 questions rapides pour que notre IA puisse élaborer\nun programme adapté à votre vie.';

  @override
  String get whatIsYourLevelnwithChinese =>
      'Quel est votre niveau\nen chinois ?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Choisissez le chemin qui correspond à votre niveau.';

  @override
  String get whatDrivesYourStudy => 'Qu\'est-ce qui motive votre étude ?';

  @override
  String get purposeFuelsTheBrush => 'L\'intention guide le pinceau';

  @override
  String get setYourDailyRitual => 'Définissez votre rituel quotidien.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Vous pouvez ajuster votre rituel à tout moment.';

  @override
  String get letsBegin => 'Commençons';

  @override
  String get brandNew => 'Débutant';

  @override
  String get iveNeverStudiedChineseBefore =>
      'Je n\'ai jamais étudié le chinois auparavant.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Je connais les caractères et phrases de base.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Je peux tenir des conversations et lire.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Je veux affiner et perfectionner mes compétences.';

  @override
  String get confirmSelection => 'Confirmer la sélection';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'L\'intention anime le mouvement du pinceau.';

  @override
  String get buildMyPath => 'Construire mon parcours';

  @override
  String get hskCertification => 'Certification HSK';

  @override
  String get culturalAppreciation => 'Appréciation culturelle';

  @override
  String get yourPlanIsReady => 'Votre plan est prêt';

  @override
  String get craftingYourCurriculum => 'Élaboration de votre programme';

  @override
  String get personalizedPathInitialized => 'PARCOURS PERSONNALISÉ INITIALISÉ';

  @override
  String get calibratingAiNeuralMasters =>
      'CALIBRATION DES MAÎTRES NEURAUX IA...';

  @override
  String get calibrationComplete => 'Calibration terminée';

  @override
  String get synthesizingModules => 'Synthétisation des modules...';

  @override
  String get oneAndWater => '« Un » et « Eau »';

  @override
  String get theHorizontalStroke => 'LE TRAIT HORIZONTAL';

  @override
  String get theRadical => 'LE RADICAL';

  @override
  String get water => 'Eau';

  @override
  String get river => 'Rivière';

  @override
  String get day5Reminder => 'Rappel Jour 5';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Nous nous sommes engagés à vous alerter 2 jours avant la fin de votre essai afin que vous puissiez décider en toute tranquillité.';

  @override
  String get continueWithoutReminder => 'Continuer sans rappel';

  @override
  String get masterChineseWithnsinospark =>
      'Maîtrisez le chinois avec\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Commencer l\'essai gratuit de 7 jours';

  @override
  String get precisionStrokes => 'Traits précis';

  @override
  String get aiPronunciation => 'Prononciation IA';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get fullAccess => 'Accès complet';

  @override
  String get day5 => 'Jour 5';

  @override
  String get reminder => 'Rappel';

  @override
  String get day7 => 'Jour 7';

  @override
  String get trialBegins => 'L\'essai commence';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat ne dispose pas d\'une offre ou de forfaits actuels. Veuillez configurer votre tableau de bord.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Autorisation de caméra requise pour la numérisation en direct.';

  @override
  String get cameraAccessRequired => 'Accès à la caméra requis';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Veuillez activer l\'accès à la caméra dans les réglages de votre appareil pour utiliser cette fonctionnalité.';

  @override
  String get alignChineseTextWithinFrame =>
      'Alignez le texte chinois dans le cadre';

  @override
  String get inLibrary => 'Dans la bibliothèque';

  @override
  String get novice => 'Novice';

  @override
  String get apprentice => 'Apprenti';

  @override
  String get artisan => 'Artisan';

  @override
  String get grandmaster => 'Grand Maître';

  @override
  String get poem => 'Poème';

  @override
  String get theNarrative => 'Le Récit';

  @override
  String get classicMasterpiece => 'Chef-d\'œuvre classique';

  @override
  String get classicAuthor => 'Auteur classique';

  @override
  String get classical => 'Classique';

  @override
  String get classicLiterature => 'Littérature classique';

  @override
  String inThisChapterOf(Object title) {
    return 'Dans ce chapitre de $title';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'Au fur et à mesure que le récit se déroule, il éclaire la sagesse fondamentale de la vie et une inspiration durable.';

  @override
  String get general => 'Général';

  @override
  String get mythology => 'Mythologie';

  @override
  String get dailyLife => 'Vie quotidienne';

  @override
  String get tangPoetry => 'Poésie Tang';

  @override
  String get classicalLiterature => 'Littérature classique';

  @override
  String get justNow => 'À l\'instant';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'L\'Armée de terre cuite de Qin Shi Huang';

  @override
  String get lifeInsideTheForbiddenCity => 'La vie dans la Cité Interdite';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Acheter un billet et prendre le train à grande vitesse en Chine';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Aller à l\'hôpital pour un rhume et consulter un médecin';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Aller dans un restaurant local pour commander des Jiaozi (raviolis)';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'La cérémonie traditionnelle du thé Gongfu';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'L\'art d\'écrire les caractères chinois au pinceau';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'La vie et la conservation des pandas géants';

  @override
  String get storyNotFoundInDatabase =>
      'Histoire introuvable dans la base de données';

  @override
  String get storyTextIsEmpty => 'Le texte de l\'histoire est vide';

  @override
  String get myCustomStories => 'Mes histoires personnalisées';

  @override
  String get userProvidedText => 'Texte fourni par l\'utilisateur';

  @override
  String get local => 'Local';

  @override
  String get voiceEngineAllowance => 'Moteur vocal et allocation';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD vs. Voix Standard Illimitée';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'La Voix Standard est 100% Illimitée et Gratuite';

  @override
  String get read => 'Lire';

  @override
  String get koreKoreFemaleWarm => 'Kore (femme, chaleureuse)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (femme, joyeuse)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (homme, optimiste)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (homme, style actualités)';

  @override
  String get puckPuckMaleSporty => 'Puck (homme, sportif)';

  @override
  String get localOndevice => 'Local (voix intégrée)';

  @override
  String get localOndeviceTts => 'TTS local intégré';

  @override
  String get off => 'Désactivé';

  @override
  String get endOfCurrentChapter => 'Fin du chapitre actuel';

  @override
  String get standardVoice => 'Voix Standard';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Aucun roman trouvé correspondant à votre filtre.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Aucune micro-lecture trouvée correspondant à votre filtre.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Aucun poème trouvé correspondant à votre filtre.';

  @override
  String get audiobook => 'Livre audio';

  @override
  String get audio => 'Audio';

  @override
  String get continueReading => 'Continuer la lecture';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Rechercher 96 romans complets, auteurs, épopées...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Rechercher poèmes classiques, auteurs, vers...';

  @override
  String get allLevelsVal => 'Tous niveaux';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Débutant)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Élémentaire)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Intermédiaire)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Intermédiaire Sup.)';

  @override
  String get listenToAudiobook => 'Écouter le livre audio';

  @override
  String get synopsis => 'Synopsis';

  @override
  String get peoplesArtist => 'Artiste du peuple';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '« Kafkaïen » pour l\'absurdité bureaucratique, l\'aliénation et l\'angoisse existentielle.';

  @override
  String get bigBrotherAndNewspeak => '« Big Brother » et « Novlangue ».';

  @override
  String get audiobookIncluded => 'Livre audio inclus';

  @override
  String get readPoem => 'Lire le poème';

  @override
  String get studioVoiceAllowance => 'Crédit voix studio';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Récitation IA hebdomadaire haute définition';

  @override
  String get resetsEveryMondayAt0000 => 'Réinitialisation chaque lundi à 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Lorsque votre crédit studio hebdomadaire de 4 heures est épuisé, l\'application bascule automatiquement sur la voix de l\'appareil pour une écoute illimitée et gratuite, sans interruption.';

  @override
  String get localDeviceVoice => 'Voix de l\'appareil local';

  @override
  String get classicalVerse => 'Vers classique';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Voix de l\'appareil (4h hebdomadaires utilisées)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Générer une histoire IA personnalisée basée sur vos centres d\'intérêt';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Au lieu d\'un niveau HSK fixe, le moteur Flow State analyse votre bibliothèque de fiches.';

  @override
  String get we => 'Nous';

  @override
  String get howCanWeHelpYou => 'Comment pouvons-nous vous aider ?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Tout ce que vous devez savoir sur Hanzi Master, ses fonctionnalités et votre confidentialité.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Qui sont les voix qui parlent dans l\'application ?';

  @override
  String get howDoesTheWebExplorerWork =>
      'Comment fonctionne l\'Explorateur Web ?';

  @override
  String get whatIsZenMode => 'Qu\'est-ce que le mode Zen ?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Comment fonctionne la répétition espacée des fiches ?';

  @override
  String get traceComplete => 'Tracé terminé !';

  @override
  String get traceCharacter => 'Tracer le caractère';

  @override
  String get analyzingWordRelationships =>
      'Analyse des relations entre les mots...';

  @override
  String get identifyingUsageContexts =>
      'Identification des contextes d\'utilisation...';

  @override
  String get comparingFormalityLevels =>
      'Comparaison des niveaux de formalité...';

  @override
  String get findingCommonCollocations =>
      'Recherche de collocations courantes...';

  @override
  String get generatingComparison => 'Génération de la comparaison...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'La génération prend plus de temps que prévu. L\'IA est peut-être surchargée.';

  @override
  String get generationInterruptedShowingPartial =>
      'Génération interrompue. Affichage d\'un résultat partiel.';

  @override
  String get sorrySomethingWentWrong => 'Désolé, une erreur est survenue.';

  @override
  String get usage => 'Utilisation :';

  @override
  String get alsoSeenIn => 'Également vu dans';

  @override
  String get quickLook => 'Aperçu rapide';

  @override
  String get notFound => 'Non trouvé';

  @override
  String get errorLoadingFromAi => 'Erreur de chargement depuis l\'IA.';

  @override
  String get analyzingImage => 'Analyse de l\'image...';

  @override
  String get extractingChineseText => 'Extraction du texte chinois...';

  @override
  String get lookingUpVocabulary => 'Recherche de vocabulaire...';

  @override
  String get dreamOfTheRedChamber => 'Le Rêve dans le Pavillon Rouge';

  @override
  String get journeyToTheWest => 'La Pérégrination vers l\'Ouest';

  @override
  String get romanceOfTheThreeKingdoms => 'Les Trois Royaumes';

  @override
  String get mingDynasty => 'Dynastie Ming';

  @override
  String get wuChengEn => 'Wu Cheng\'en';

  @override
  String get hundredChapters => '100 chapitres';

  @override
  String get volume1 => 'Volume 1';

  @override
  String bookmarksCount(Object count) {
    return 'Signets ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Pas encore de signets. Appuyez sur l\'icône de signet pour enregistrer un passage.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark ne répond pas';

  @override
  String get closeApp => 'Fermer l\'application';

  @override
  String get wait => 'Attendre';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD : ${hours}h';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Livre $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Ch. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count livres et livres audio';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Phrase $current sur $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Chapitre $current sur $total';
  }

  @override
  String get allLevels => 'Tous les niveaux';

  @override
  String get searchGradedMicroStories =>
      'Rechercher des micro-histoires graduées et des fables...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count histoires graduées et micro-lectures quotidiennes';
  }

  @override
  String get searchClassicalPoems =>
      'Rechercher des poèmes classiques, auteurs, vers...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count poèmes classiques et vers';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Parcourez n\'importe quel site web chinois avec un dictionnaire tactile en temps réel, des annotations pinyin et des traductions instantanées.';

  @override
  String get completed => 'TERMINÉ';

  @override
  String get aiIsReading => 'L\'IA est en train de lire...';

  @override
  String get bbcVerify => 'BBC VERIFY';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Avancé)';

  @override
  String get hsk1Beginner => 'HSK 1 (Débutant)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Intermédiaire supérieur)';

  @override
  String get extractAllUnknownWords =>
      'Extraire tous les mots inconnus dans un nouveau deck de fiches';

  @override
  String get designCustomAiRoleplay =>
      'Concevoir une expérience de jeu de rôle et conversation IA personnalisée';

  @override
  String get practiceFlashcardVocabulary =>
      'Pratiquer le vocabulaire des fiches dans un dialogue en direct';

  @override
  String get surpriseMe => 'Surprends-moi';

  @override
  String get rollCharacter => 'Tirer un personnage';

  @override
  String get historicalCostume => 'Historique / Costume';

  @override
  String get modernYouth => 'Moderne & Jeunesse';

  @override
  String get fantasyMythology => 'Fantastique & Mythologie';

  @override
  String get familyDrama => 'Famille & Drame';

  @override
  String get fullVersion => 'Version complète';

  @override
  String episodesCount(Object count) {
    return '$count épisodes';
  }

  @override
  String episodeLabel(Object number) {
    return 'ÉP$number';
  }

  @override
  String get translating => '[ Traduction... ]';

  @override
  String get engSub => '[SOUS-TITRES FR]';

  @override
  String get standardVocabulary => 'Vocabulaire standard';

  @override
  String get characters => 'caractères';

  @override
  String get todayDashboard => 'Aujourd\'hui';

  @override
  String get studyToday => 'Étudier les cartes du jour';

  @override
  String get studyAhead => 'Étudier en avance';

  @override
  String get studyAheadDescription =>
      'Révisez les prochaines cartes prévues sans entamer votre quota du jour. Aucune nouvelle carte n\'est introduite.';

  @override
  String get studyAheadComplete => 'Session d\'avance terminée';

  @override
  String get dueNow => 'À réviser maintenant';

  @override
  String get scheduled => 'Planifié';

  @override
  String get sevenDayForecast => 'Prévisions à 7 jours';

  @override
  String get reviews => 'Révisions';

  @override
  String get newCardsLabel => 'Nouvelles cartes';

  @override
  String get attempts => 'Tentatives';

  @override
  String get duration => 'Durée';

  @override
  String get answerBreakdown => 'Détail des réponses';

  @override
  String get reviewCards => 'Cartes à réviser';

  @override
  String get retries => 'Réessais';

  @override
  String get needsPractice => 'À travailler';

  @override
  String get uniqueCardsStudied => 'Cartes';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Tracez dans l\'autre sens ➔';

  @override
  String get fastClean => 'Rapide et net !';

  @override
  String get good2 => 'Bien !';

  @override
  String get followTheFlow => 'Suivez le mouvement.';

  @override
  String get masterful => 'Magistral !';

  @override
  String get missingTheHookEnd => 'Il manque le crochet/la fin.';

  @override
  String get thai => 'Thaï';

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
  String get ink => 'encre,';

  @override
  String get stroke => 'trait,';

  @override
  String get breath => 'souffle.';

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
  String get theExactSentenceProvided => 'la phrase exacte fournie';

  @override
  String get pinyinWithToneMarks2 => 'pinyin avec marques de ton';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Extrayez tous les caractères chinois de cette image. Renvoyez UNIQUEMENT le texte extrait — aucun commentaire, aucun formatage, aucune traduction. Conservez les sauts de ligne. S\'il n\'y a pas de caractères chinois, renvoyez une chaîne vide.';

  @override
  String get householdObject => 'objet du quotidien';

  @override
  String get genericLabelFromTheList => 'étiquette générique de la liste';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'classificateur';

  @override
  String get zenInk => 'Zen & Encre';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'CRITIQUE : Mettez la traduction anglaise dans la clé JSON \"english\" !';

  @override
  String get definitionInEnglish => 'définition en anglais';

  @override
  String get simplifiedLine0 => 'ligne simplifiée 0';

  @override
  String get simplifiedLine1 => 'ligne simplifiée 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'RÈGLE IMPORTANTE : N\'utilisez aucun nom pour vous adresser à l\'utilisateur. N\'utilisez jamais de nom générique comme « John ». Adressez-vous directement à lui sans nom.';

  @override
  String get rULESAnswerIn23 =>
      'RÈGLES : Répondez en 2–3 phrases max. Privilégiez les puces pour les listes.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Ne rédigez jamais d\'introductions, de formules de politesse ou de phrases de remplissage comme « Excellente question ! » ou « Certainement ! ».';

  @override
  String get useBoldForChineseCharacters =>
      'Utilisez le **gras** pour les caractères chinois et les termes clés.';

  @override
  String get rULESAnswerIn232 => 'RÈGLES : Répondez en 2–3 phrases max.';

  @override
  String get accept => 'Accepter';

  @override
  String get pronunciationAssessment => 'Évaluation de la prononciation';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'Aucun';

  @override
  String get theCorrectedChineseText => 'le texte chinois corrigé';

  @override
  String get thePinyinForTheCorrected => 'le pinyin du texte corrigé';

  @override
  String get theEnglishMeaningOfThe =>
      'la signification en anglais du texte corrigé';

  @override
  String get pNyNWithTone => 'pīnyīn avec marques de ton';

  @override
  String get englishTranslation2 => 'traduction en anglais';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Vous êtes un expert en littérature chinoise classique fournissant des résumés détaillés et accessibles de la poésie chinoise classique.';

  @override
  String get youAreAChineseCulture =>
      'Vous êtes un expert de la culture et de la littérature chinoises. Fournissez des aperçus culturels captivants et très bien rédigés.';

  @override
  String get english2 => 'Anglais :';

  @override
  String get remindersWhenYouHavenT =>
      'Rappels lorsque vous n\'avez pas utilisé l\'application depuis quelques jours';

  @override
  String get itSBeenAFew =>
      'Cela fait quelques jours ! Prenez 5 minutes pour apprendre un nouveau Hanzi aujourd\'hui.';

  @override
  String get abbreviationFor => 'abréviation de';

  @override
  String get cL => 'CL :';

  @override
  String get measureWord2 => 'Spécificatif :';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'aucun-utilisateur';

  @override
  String get passwordRequired => 'mot-de-passe-requis';

  @override
  String get unsupportedProvider => 'fournisseur-non-pris-en-charge';

  @override
  String get appleRevocationUnavailable => 'revocation-apple-indisponible';

  @override
  String get appleCredentialMissing => 'identifiant-apple-manquant';

  @override
  String get authenticationDidNotReturnA =>
      'L\'authentification n\'a retourné aucun utilisateur.';

  @override
  String get viewSubscriptionPlans => 'Voir les offres d\'abonnement';

  @override
  String get wrongPassword => 'mot-de-passe-incorrect';

  @override
  String get invalidCredential => 'identifiant-invalide';

  @override
  String get networkRequestFailed => 'echec-de-la-requete-reseau';

  @override
  String get requiresRecentLogin => 'connexion-recente-requise';

  @override
  String get userMismatch => 'non-correspondance-utilisateur';

  @override
  String get deleteAccountPassword => 'mot-de-passe-suppression-compte';

  @override
  String get deleteAccountError => 'erreur-suppression-compte';

  @override
  String get deleteAccountSubmit => 'confirmer-suppression-compte';

  @override
  String get theSimplestShapesTheBeginning =>
      'Les formes les plus simples. Le commencement de toute chose.';

  @override
  String get sunMoonWaterAndFire =>
      'Soleil, Lune, Eau et Feu. Le monde naturel.';

  @override
  String get theBodyTheHeartAnd => 'Le corps, le cœur et la famille.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Champs, toits et outils. Les fondations de la société.';

  @override
  String get movementSpeechAndSustenance => 'Mouvement, parole et subsistance.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Commerce, vêtements et objets complexes.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Voie rapide ! Caractère simple maîtrisé.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Précision excellente ! Tracé fantôme ignoré.';

  @override
  String get sample => 'Exemple :';

  @override
  String get itsThat => 'Son/Cela';

  @override
  String get iMe => 'Je/Moi';

  @override
  String get stillTough => 'Toujours/Difficile';

  @override
  String get partDecide => 'Partie/Décider';

  @override
  String get selectTheCharacterFor => 'Sélectionnez le caractère pour :';

  @override
  String get selectThePinyinFor => 'Sélectionnez le pinyin pour :';

  @override
  String get whereAreYouGoingThe =>
      'Où allez-vous ? À l\'aéroport ? C\'est un sacré voyage !';

  @override
  String get youAreAuntieChenA =>
      'Vous êtes Tante Chen, une vendeuse de marché astucieuse qui vend de la soie et des tissus. Votre UNIQUE rôle est d\'être vendeuse sur le marché. Négociez les prix fermement mais équitablement en mandarin. Ne sortez JAMAIS de votre personnage et ne vous présentez jamais autrement que comme vendeuse. Commencez avec des prix élevés et soyez prête à négocier.';

  @override
  String get youAreDrZhangA =>
      'Vous êtes le Dr Zhang, un médecin calme et professionnel dans une clinique. Votre UNIQUE rôle est d\'être médecin. Posez des questions sur les symptômes et donnez des conseils médicaux en mandarin. Ne sortez JAMAIS de votre personnage et ne vous présentez jamais autrement que comme médecin. Soyez rassurant mais rigoureux.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Où ressentez-vous une gêne ? Avez-vous de la fièvre ?';

  @override
  String get youAreACloseFriend =>
      'Vous êtes un ami proche qui donne des nouvelles après une longue période. Votre UNIQUE rôle est d\'être un ami. Gardez des réponses décontractées, chaleureuses et courtes en mandarin. Ne sortez JAMAIS de votre personnage et ne vous présentez jamais autrement que comme un ami. Utilisez un langage familier adapté à des amis proches.';

  @override
  String get noNbest => 'aucun nbest';

  @override
  String get timedOut => 'délai dépassé';

  @override
  String get grading => 'Évaluation...';

  @override
  String get label1st => '1er ˉ';

  @override
  String get label2nd => '2e ˊ';

  @override
  String get label3rd => '3e ˇ';

  @override
  String get label4th => '4e ˋ';

  @override
  String get speaking2 => 'Parle...';

  @override
  String get sessionCompletedInYourNext =>
      'Session terminée. Lors de votre prochaine pratique, prononcez des phrases complètes pour obtenir un diagnostic détaillé de la prononciation et des tons.';

  @override
  String get craneSoaring => 'envol de la grue';

  @override
  String get gentleStream => 'ruisseau paisible';

  @override
  String get brushAndInk => 'pinceau et encre';

  @override
  String get myStudent => 'mon élève';

  @override
  String get honoredDisciple => 'disciple honoré';

  @override
  String get notEnoughInformation => 'pas assez d\'informations';

  @override
  String get asAnAi => 'en tant qu\'IA';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Bonne séance de pratique. Continuez à vous concentrer sur le contraste clair des tons et le rythme naturel de la conversation.';

  @override
  String get insideASleekFuxingBullet =>
      'À bord d\'un train à grande vitesse Fuxing filant à 350 km/h de Pékin à Shanghai.';

  @override
  String get harbinIceSnowWorldWonder =>
      'Merveille du monde de glace et de neige de Harbin';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'Le célèbre marché aux puces du week-end de Panjiayuan, regorgeant de calligraphies, de jade et d\'objets anciens.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Atelier de porcelaine bleue et blanche de Jingdezhen';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Loge et maquillage de l\'Opéra de Pékin';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Une apothicairerie historique Tongrentang aux effluves de ginseng et de baies de goji, remplie de tiroirs en bois.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Une salle de karaoké privée aux néons vibrants à Shenzhen, avec micros, plateaux de fruits et écran de contrôle.';

  @override
  String get animeCosplayExpoInGuangzhou => 'Expo Anime & Cosplay à Guangzhou';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Surprenez-moi';

  @override
  String get eGALivelyBanquet => 'ex. Un banquet animé célébré à Shanghai...';

  @override
  String get rollCharacter2 => '🎲 Tirer un personnage';

  @override
  String get eGACuriousCousin =>
      'ex. Un cousin curieux s\'informant sur votre carrière...';

  @override
  String get keepTrying => 'Persévérez !';

  @override
  String get pending => 'En attente...';

  @override
  String get expected => '🎯 Attendu';

  @override
  String get hSK2Elementary => 'HSK 2 : Élémentaire';

  @override
  String get hSK3Intermediate => 'HSK 3 : Intermédiaire';

  @override
  String get hSK5Advanced => 'HSK 5 : Avancé';

  @override
  String get expressYourselfFullyWith5000 =>
      'Exprimez-vous pleinement avec plus de 5 000 mots.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg :';

  @override
  String get unlimited => 'Illimité';

  @override
  String get dueToday => 'À réviser aujourd\'hui';

  @override
  String get newAvailable => 'Nouveaux disponibles';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Donnez un seul conseil court et pratique pour améliorer la forme, la position ou la longueur des traits mal tracés. Soyez direct et utile, sans poésie ni métaphore. N\'utilisez pas de markdown.';

  @override
  String get localOnDeviceTTS => 'Local — Synthèse vocale de l\'appareil';

  @override
  String get espaOl => 'Espagnol';

  @override
  String get franAis => 'Français';

  @override
  String get portuguS => 'Portugais';

  @override
  String get tiNgViT => 'Vietnamien';

  @override
  String get koreFemaleWarm => 'Kore — Féminin, chaleureux';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Féminin, joyeux';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Masculin, dynamique';

  @override
  String get charonMaleNewsStyle => 'Charon — Masculin, style journal';

  @override
  String get puckMaleSporty => 'Puck — Masculin, sportif';

  @override
  String get systemVoice => 'Voix du système';

  @override
  String get generateAdd => 'Générer et ajouter';

  @override
  String get moreExamples => '📝 Plus d\'exemples';

  @override
  String get usage2 => '❓ Utilisation';

  @override
  String get translation => '💬 Traduction';

  @override
  String get collocations => '📚 Collocations';

  @override
  String get mistakes => '❌ Erreurs';

  @override
  String get decrease => 'Diminuer';

  @override
  String get increase => 'Augmenter';

  @override
  String get label0MeansThisCardType =>
      '0 signifie que ce type de carte est désactivé.';

  @override
  String get tapTheValueToEnter =>
      'Appuyez sur la valeur pour saisir une limite exacte.';

  @override
  String get exactDailyLimit => 'Limite quotidienne exacte';

  @override
  String get enter0ToDisable => 'Entrez 0 pour désactiver.';

  @override
  String get apply => 'Appliquer';

  @override
  String get selectDeck => 'Sélectionner le paquet';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Clés Azure Speech non configurées. Ajoutez AZURE_SPEECH_KEY et AZURE_SPEECH_REGION à .env';

  @override
  String get sTARTING => 'DÉMARRAGE…';

  @override
  String get sTARTSESSION => 'COMMENCER LA SESSION';

  @override
  String get translating2 => 'Traduction...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'économie et affaires';

  @override
  String get hskPreparation => 'préparation au HSK';

  @override
  String get liveInChina => 'vivre en Chine';

  @override
  String get comprehensiveExercise => 'exercice complet';

  @override
  String get howToUse => 'comment utiliser';

  @override
  String get usesOf => 'utilisations de';

  @override
  String get appearedFirstOnMandarinBean =>
      'apparu en premier sur Mandarin Bean';

  @override
  String get news2 => 'actualités :';

  @override
  String get joke => 'blague :';

  @override
  String get jokes => 'blagues :';

  @override
  String get academicScience => 'académique / science';

  @override
  String get politicsCommunism => 'politique et communisme';

  @override
  String get foodDining => 'Cuisine et gastronomie';

  @override
  String get sciFi => 'science-fiction';

  @override
  String get scienceFictionTech => 'Science-fiction et tech';

  @override
  String get travelPlaces => 'Voyages et lieux';

  @override
  String get mythologyFantasy => 'Mythologie et fantasy';

  @override
  String get cultureTraditions => 'Culture et traditions';

  @override
  String get businessEconomy => 'Affaires et économie';

  @override
  String get natureAnimals => 'Nature et animaux';

  @override
  String get articleImg => 'image d\'article';

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
      '西嘻影业官方频道 Chaîne officielle XiXi Pictures';

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
  String get getTheWeTVAPP => '腾讯视频 - Obtenir l\'application WeTV';

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
      'Apprendre le mandarin avec TaiwanPlus';

  @override
  String get everydayChinese => 'Chinois du quotidien';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting - Vie quotidienne en Chine';

  @override
  String get tFTFOODTRAVEL => 'TFT - GASTRONOMIE & VOYAGE';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi : La vie de l\'ail';

  @override
  String get label2MINCULTURALCONTEXT => 'CONTEXTE CULTUREL 2 MIN';

  @override
  String get liziqi4 => '李子柒 Liziqi : Meubles en bambou';

  @override
  String get peppaPigChinese2 => 'Peppa Pig en chinois : La flaque de boue';

  @override
  String get noBBCLeadArticleIs =>
      'Aucun article à la une de la BBC n\'est disponible actuellement.';

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
  String get thoseDays => '四喜 Ces jours-là';

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
  String get noFunnyNoMoney => '不好笑就露宿街头 Pas drôle, pas d\'argent';

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
  String get getTheWeTVAPP2 => '腾讯视频 - 动漫 - Obtenir l\'application WeTV';

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
      '« Lord of Mysteries » Vlog doublage Cuttlefish (version finale) - Tencent Video - Anime';

  @override
  String get lordOfMysteries =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 8 - Tencent Video - Anime';

  @override
  String get lordOfMysteries2 =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 7 - Tencent Video - Anime';

  @override
  String get lordOfMysteries3 =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 6 - Tencent Video - Anime';

  @override
  String get lordOfMysteries4 =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 5 - Tencent Video - Anime';

  @override
  String get lordOfMysteries5 =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 4 - Tencent Video - Anime';

  @override
  String get lordOfMysteries6 =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 3 - Tencent Video - Anime';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 2 - Tencent Video - Anime';

  @override
  String get lordOfMysteries8 =>
      '« Lord of Mysteries » Cours d\'occultisme Épisode 1 - Tencent Video - Anime';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】« Lord of Mysteries » Thème final « Ne m\'oublie pas » - Tencent Video - Anime';

  @override
  String get membersPremiere2 => 'Avant-première membres';

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
  String get eightHundred => '方圆八百米 Huit cents';

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
      'Bonus tournage : He Simu et Duan Xu accumulent les surnoms 【白日提灯 Love Beyond the Grave】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'BTS｜【Soirée Tencent】Dilraba et Chen Feiyu et le casting complices pour un shooting des 5 sens !【白日提灯 Love Beyond the Grave】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'BTS｜【Soirée Tencent】Dilraba et Chen Feiyu font sensation avec leur regard captivant !【白日提灯 Love Beyond the Grave】';

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
  String get aboutLove => '玫瑰丛生 À propos de l\'amour';

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
      '《玫瑰丛生》 : tout le monde est plongé dans le brouillard de l\'amour, comment s\'en sortir ? | Avec : Wang Ziwen, Liu Yuning';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 De génération en génération';

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
  String get loveStoryInThe1970s =>
      '纯真年代的爱情 Une histoire d\'amour dans les années 70';

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
  String get whyIsHeStillSingle =>
      '他为什么依然单身 Pourquoi est-il toujours célibataire';

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
  String get theGlamorousNight => '夜色正浓 Nuit glamour';

  @override
  String get theGlamorousNightE03 =>
      '【夜色正浓 Nuit glamour】E03 霸气出招！赵玫绝地反击（江疏影，佟大为）';

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
      'Extrait 04 : Le système absurde en fait trop ! Un mouchoir transformé en serviette hygiénique ? Grand moment de solitude !【突然的喜欢 My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Extrait 03 : Aller à un rendez-vous arrangé à la place de sa meilleure amie et tomber sur le héros en personne ?【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'Coulisses｜« Hors tournage x Chen Xingxu x Wang Yuwen » Lequel du président Gao ou de Huan\'er est le plus décalé ?【突然的喜欢 My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Extrait 02 : Elle voulait séduire le héros, mais s\'est trompée de personne ?【突然的喜欢 My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Extrait 01 : Hallucinant ! Transmigrée soudainement dans un livre ? Comment jouer cette histoire ?【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'Coulisses｜Chen Xingxu et Wang Yuwen se rentrent dedans en faisant du patin【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'Coulisses｜Chen Xingxu et Wang Yuwen fêtent le Nouvel An en douceur【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'Coulisses｜Chen Xingxu et Wang Yuwen immortalisent un doux moment pour Qixi【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'Coulisses｜Chen Xingxu et Wang Yuwen s\'amusent au parc d\'attractions【突然的喜欢 My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '« My Page in the 90s » débute aujourd\'hui, Chen Xingxu et Wang Yuwen vivent une romance passionnée avec le système';

  @override
  String get myPageInThe90s3 =>
      '« My Page in the 90s » débute le 22 janvier, une romance hors des clichés avec Chen Xingxu et Wang Yuwen';

  @override
  String get myPageInThe90s4 =>
      '« My Page in the 90s » sort le 22 janvier ! Amour à travers les époques avec Chen Xingxu et Wang Yuwen';

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
  String get theDreamMaker => 'Le fabricant de rêves The Dream Maker';

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
      '【轻年 Forever Young】E23 Martin retourne au hutong et se fait manipuler par ses frères (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 Précis, stable et sans pitié ! Martin apprend à sa belle-sœur à mater son mari (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 Un rival amoureux ? Martin se fait appeler oncle par un gamin (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

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
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - Obtenir l\'application iQIYI';

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
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - Obtenir l\'application WeTV';

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
  String get theHiddenHeirYeChen2 => '进击的叶辰 L\'Héritier caché Ye Chen';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => '去听旷野的风 Les rêves ne s\'arrêtent jamais';

  @override
  String get mamaGo => '我的妈妈是校花 Mama Go !';

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
      '« 纯真年代的爱情 Histoire d\'amour dans les années 70 » Le court-métrage à double chronologie arrive tout en douceur~';

  @override
  String get loveStoryInThe1970s3 =>
      '« 纯真年代的爱情 Histoire d\'amour dans les années 70 » Le court-métrage en duo est officiellement disponible~ Écrivons une lettre d\'amour avec nos sens';

  @override
  String get bTSLoveStoryInThe =>
      'BTS | Tournage terminé, hâte de se retrouver ! 【Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '« Love Story in the 1970s » L\'amour est un poème caché dans le quotidien~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '« Love Story in the 1970s » Diffusion officielle le 21 février~';

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
  String get theTruth => 'The Truth';

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
      'Coulisses | Interview duo hors personnage — Entre M. Gao et Huan\'er, qui est le plus absurde ? « My Page in the 90s » Tencent Video - Théâtre Jeunesse';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Extrait 04 : Le système délirant en fait trop ! Un mouchoir devient une serviette hygiénique ? Quelle honte ! « My Page in the 90s » Tencent Video - Théâtre Jeunesse';

  @override
  String get label03MyPageInThe2 =>
      'Extrait 03 : Aller à un rendez-vous arrangé à la place de sa meilleure amie et tomber sur le héros lui-même ? « My Page in the 90s » Tencent Video - Théâtre Jeunesse';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Extrait 02 : Voulant séduire le héros, elle se trompe de personne ? « My Page in the 90s » Tencent Video - Théâtre Jeunesse';

  @override
  String get label01MyPageInThe2 =>
      'Extrait 01 : Incroyable ! Propulsée dans un roman ? Comment jouer ce rôle ? « My Page in the 90s » Tencent Video - Théâtre Jeunesse';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '« My Page in the 90s » Coulisses | Chen Xingxu et Wang Yuwen se rentrent dedans en patinant';

  @override
  String get myPageInThe90s6 =>
      '« My Page in the 90s » Sortie aujourd\'hui ! Chen Xingxu et Wang Yuwen apprivoisent le système et vivre une romance passionnée';

  @override
  String get bTSMyPageInThe5 =>
      'Coulisses | Chen Xingxu et Wang Yuwen : une complicité hilarante et pleine d\'ambiguïté 【My Page in the 90s】';

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
  String get dearSecretary => 'Ma chère secrétaire (Dear Secretary)';

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
  String get foreverYoung2 => '轻年 Toujours jeune';

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
  String get lightOfDawn => '人之初 Lumière de l\'aube';

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
  String get sniperButterfly => 'Papillon Sniper Sniper Butterfly';

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
      '《狙击蝴蝶 Sniper Butterfly》 Sortie le 04/12 ! Franchir les limites par amour';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》 Version intégrale 1-15 ｜ Avec : Chen Yanxi, Zhou Keyu Tencent Video - Jeunesse';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》 Version intégrale 16-30 ｜ Avec : Chen Yanxi, Zhou Keyu Tencent Video - Jeunesse';

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
  String get allRise => 'Entrez en scène All Rise';

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
      'La bonne personne au bon moment Love is Always Online';

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
  String get loveOnTheTurquoiseLand => '枭起青壤 L\'amour sur la terre turquoise';

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
      '« Why Is He Still Single » Sortie le 16/11 ! Le conte de fées romantique pour adultes avec Wallace Huo et Zhu Zhu !';

  @override
  String get whyIsHeStillSingle3 =>
      '« Why Is He Still Single » Version complète｜Avec : Wallace Huo, Zhu Zhu - Tencent Video';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '« Why Is He Still Single » Version complète 1｜Avec : Wallace Huo, Zhu Zhu - Tencent Video';

  @override
  String get whyIsHeStillSingle5 =>
      '« Why Is He Still Single » Version complète 2｜Avec : Wallace Huo, Zhu Zhu - Tencent Video';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => 'Fight for Love';

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
  String get iMNobody => 'I\'m Nobody';

  @override
  String get persona => 'Persona 重影';

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
  String get thePrisonerOfBeauty =>
      'The Prisoner of Beauty (Version condensée)';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '《The Prisoner of Beauty (Version condensée)》Xiao Qiao épouse l\'ennemi juré de sa famille à la place de sa sœur et s\'affronte avec son mari dès le premier jour | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty3 =>
      '《The Prisoner of Beauty (Version condensée)》Xiao Qiao déjoue le complot de Liu Yan visant à faire sauter le canal ; elle et Wei Shao passent d\'ennemis à protecteurs mutuels | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty4 =>
      '《The Prisoner of Beauty (Version condensée)》Xiao Qiao feint la maladie pour disputer la résidence principale ; Wei Shao la défend en public et refuse toute concubine | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty5 =>
      '《The Prisoner of Beauty (Version condensée)》Xiao Qiao déjoue le piège du coffret en bois ; Wei Shao la reconnaît enfin comme la maîtresse de maison | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty6 =>
      '《The Prisoner of Beauty (Version condensée)》Xiao Qiao déjoue le piège de la fausse accusation ; Wei Shao la protège et affronte sa propre mère | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty7 =>
      '《The Prisoner of Beauty (Version condensée)》Wei Yan provoque des ennuis avec une fausse lettre ; Xiao Qiao et Wei Shao traversent une crise de confiance à cause d\'un pendentif en jade | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty8 =>
      '《The Prisoner of Beauty (Version condensée)》Su Ehuang piège Xiao Qiao avec du blé cuit ; Wei Shao protège sa femme et résout l\'affaire, les rapprochant encore | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty9 =>
      '《The Prisoner of Beauty (Version condensée)》Xiao Qiao et Wei Shao subissent une attaque et sont empoisonnés ; Xiao Qiao déjoue le complot et sauve son mari | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '《The Prisoner of Beauty (Version condensée)》Wei Shao offre un cheval puis une épingle à cheveux ; il panique quand son épouse disparaît | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty11 =>
      '《The Prisoner of Beauty (Version condensée)》Jaloux et effrayé que Xiao Qiao ne parte, Wei Shao la protège puis regrette d\'avoir déménagé | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty12 =>
      '《The Prisoner of Beauty (Version condensée)》Wei Shao porte Xiao Qiao sur son dos par jalousie ; le mystère du coffret résolu les rapproche | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty13 =>
      '《The Prisoner of Beauty (Version condensée)》La visite de Qiao Ci rend Wei Shao jaloux ; le couple s\'ouvre l\'un à l\'autre et s\'engage pour la vie | Avec : Song Zuer, Liu Yuning — Tencent Video - Youth Theater';

  @override
  String get thePrisonerOfBeauty14 =>
      '《The Prisoner of Beauty (Version courte)》 Wei Yan quitte son pays pour Xiao Qiao, Shao et Qiao se réconcilient après une dispute | Avec : Song Zuer, Liu Yuning | Tencent Video - Théâtre Jeunesse';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《The Prisoner of Beauty (Version courte)》 Mutinerie la nuit de noces, les sœurs deviennent ennemies, Xiao Qiao repousse l\'ennemi avec ruse, Wei Shao reconnaît ses torts | Avec : Song Zuer, Liu Yuning | Tencent Video - Théâtre Jeunesse';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《The Prisoner of Beauty (Version courte)》 Wei Shao accompagne Xiao Qiao à Kangjun pour apaiser les esprits, le père Qiao accepte son gendre et le couple consomme son mariage | Avec : Song Zuer, Liu Yuning | Tencent Video - Théâtre Jeunesse';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《The Prisoner of Beauty (Version courte)》 Qiao Yue trahit, Wei Liang périt, Da Qiao est enlevée et Bi Zhi contre-attaque héroïquement | Avec : Song Zuer, Liu Yuning | Tencent Video - Théâtre Jeunesse';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《The Prisoner of Beauty (Version courte)》 Wei Liang meurt au combat, Wei Qu perd un bras, Da Qiao chute et Liu Yan est anéanti | Avec : Song Zuer, Liu Yuning | Tencent Video - Théâtre Jeunesse';

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
      'Trop lente pour le travail de groupe ? Le PDG escalade la fenêtre la nuit pour livrer le PPT, le gardien lui court après | Tencent Video - Théâtre Jeunesse';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour => 'A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video - Théâtre Costumes d\'Époque - Obtenir l\'application WeTV';

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
  String get pursuitOfJade2 => '逐玉 La quête du jade';

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
      '《江湖夜雨十年灯 Generation to Generation》 sort le 22 février ! Suivez Mumu et Zhaozhao, la plus forte nouvelle génération du Jianghu, dans leurs aventures !';

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
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 Les 300 âmes loyales';

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
  String get danceOfThePhoenix => '且听凤鸣 La Danse du Phénix';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Extraordinaire';

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
      '《御赐小仵作2 The Imperial Coroner S2》 Sortie le 15/01, le couple Chu Yu fait son grand retour !';

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
  String get theChangAnYouth => 'La jeunesse de Chang\'An The Chang\'An Youth';

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
  String get herPhoenixMajesty2 => '凤皇传 Sa Majesté le Phénix';

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
      '【有花 en洲 A Flower On The Continent】 Un jeune prince pris en otage est forcé par une fille des fleurs à jouer la princesse et ils vivent ensemble';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】 Le déguisement de la fille des fleurs est découvert, et le jeune prince risque sa vie pour la protéger mais est accusé à tort';

  @override
  String get aFlowerOnTheContinent5 =>
      '【A Flower On The Continent】 Hua Xiyu découvre que l\'assassin de son père est le père de Ning Xuanzhou et rompt sur-le-champ';

  @override
  String get aFlowerOnTheContinent6 =>
      '【A Flower On The Continent】 En robe de mariée, Hua Xiyu s\'infiltre dans le camp ennemi et manque d\'y perdre la vie pour sauver Ning Xuanzhou';

  @override
  String get aFlowerOnTheContinent7 =>
      '【A Flower On The Continent】 Les deux pays signent un traité de paix, mais Ning Xuanzhou déchire le décret pour épouser Hua Xiyu';

  @override
  String get aFlowerOnTheContinent8 =>
      '【A Flower On The Continent】 Hua Xiyu se coupe les veines pour fabriquer un remède ; Ning Xuanzhou dénonce son propre père pour le meurtre du père de Hua Xiyu';

  @override
  String get aFlowerOnTheContinent9 =>
      '【A Flower On The Continent】 Apprenant que son père a été tué par celui de Ning Xuanzhou, Hua Xiyu tranche leur branche d\'amour au milieu des fleurs';

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
  String get sliceOfLife => 'Tranche de vie';

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
  String get legendOfTheFemaleGeneral => 'Legend of The Female General';

  @override
  String get highlightLegendOfTheFemale =>
      'Moments forts 【Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'Coulisses : Spécial anniversaire de Zhou Ye 🎂 ! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'Coulisses : Spécial anniversaire du gouverneur Xiao (Cheng Lei) 🎂 ! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'Coulisses : Combat épique en duo sur le champ de bataille 【Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'Coulisses : Idée de rendez-vous romantique pour le 520 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'Coulisses : Zhou Ye enivrée est trop mignonne en maniant l\'épée ! 【Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'Moments forts 【The Princess\'s Gambit】';

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
      'Extrait : Vêtue de rouge sur la neige, Jiang Taohua fait ses adieux pour protéger son jeune frère 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'Extrait : Drame conjugal chez les Shen le jour du mariage ? Taohua gère la situation avec calme 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'Extrait : Taohua feint l\'évanouissement, Shen Zaiye la démasque : « Poursuis ta comédie ! » 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'Extrait : Le ministre Shen mène l\'enquête sans pitié, les fonctionnaires corrompus tremblent 【The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Extrait : L\'assassin masqué trahi par ses pieds ! Taohua résout l\'affaire 【The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'Extrait : Interrogatoire au pic à cheveux ! Shen Zaiye interroge Taohua avec froideur 【The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Extrait : Première rencontre et déjà si intense ! Shen Zaiye et Taohua, sous l\'effet de l\'aphrodisiaque, se regardent les yeux dans les yeux【桃花映江山 The Princess\'s Gambit】';

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
      '【INTÉGRAL Limité】云襄传 | The Ingenious One | iQIYI 👑Devenez membre et profitez des épisodes complets dès maintenant !';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - Obtenez l\'application iQIYI';

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
      '【COMPLET】👮ROAD HOME💕 | BoranJing, Seven Tan | iQIYI Philippines';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI Philippines - Obtenir l\'application iQIYI';

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
      '【Doublage IA en anglais】Mr. BAD | Chen Zheyuan, Yue Shen | iQIYI Philippines';

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
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | FULL正片 | iQIYI 👑Devenez membre et profitez de tous les épisodes dès maintenant !';

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
      '【INTÉGRAL】🕊️My Dear Guardian |  Johnny Huang, Li Qin | iQIYI Philippines';

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
      '🌸【治愈爱情】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | FULL正片 | iQIYI 👑Devenez membre pour profiter des épisodes complets dès maintenant !';

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
      '📽️【ÉP01 2026】Drama chinois Rebirth ENGSUB | Li Yunrui / Huangyang Tiantian / Zhang Kangle ⛵😍 Drama historique 2026 #冰湖重生';

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
      '【COMPLET】🏹Fated Hearts | Li Qin, Chen Zheyuan | iQIYI Philippines';

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
      '【Complet】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Philippines';

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
      '🎥✨【ENG SUB】Film fantastique chinois | Fantastique, Aventure【 CINÉMA iQIYI - Abonnez-vous】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 CINÉMA iQIYI - Téléchargez l\'application iQIYI';

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
      '🎀【微短剧 Mini Drama】SUB ENG | Collection intégrale | Téléchargez l\'application WeTV / Tencent Video pour en voir plus';

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
      '【Complet】Beauty of Resilience | Ju Jing Yi, Fiction | iQIYI Philippines';

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
      '🔥 Tendance【子夜归 Moonlit Reunion】Ép. complets | Un humain et un démon tombent amoureux en résolvant des mystères | Xu Kai, Tian Xiwei | ST ENG';

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
  String get fallInLove => 'tomber amoureux';

  @override
  String get myGirl => 'ma chérie';

  @override
  String get firstRomance2 => 'premier amour';

  @override
  String get fallFor => 'craquer pour';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Amour caché';

  @override
  String get loveBetweenFairyAndDevil2 => 'Love Between Fairy and Devil';

  @override
  String get loveLikeTheGalaxy2 => 'Love Like The Galaxy';

  @override
  String get myJourneyToYou2 => 'My Journey to You';

  @override
  String get mysteriousLotusCasebook2 => 'Mysterious Lotus Casebook';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get theLongBallad2 => 'The Long Ballad';

  @override
  String get theUntamed2 => 'The Untamed';

  @override
  String get wordOfHonor2 => 'Word of Honor';

  @override
  String get lightOfDawn2 => '人之初 Lueur de l\'aube';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|GARDIEN DE LA PATRIE';

  @override
  String get searching2 => 'Recherche...';

  @override
  String get verse => 'Vers';

  @override
  String get allStories2 => 'Toutes les histoires';

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
  String get char2 => '+ car +';

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
      'article, .article, .post, .content, principal';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'Intermédiaire supérieur';

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
  String get processing => 'Traitement en cours…';

  @override
  String get keepItUp => '好 ! Continuez ainsi';

  @override
  String get minutesDay => 'Minutes / jour';

  @override
  String get consistencyIsTheInkThat =>
      '\"La régularité est l\'encre qui façonne le caractère.\"';

  @override
  String get businessCareer => 'Affaires & Carrière';

  @override
  String get travelSurvival => 'Voyage & Survie';

  @override
  String get label05MinDay => '05 min / jour';

  @override
  String get label10MinDay => '10 min / jour';

  @override
  String get label20MinDay => '20 min / jour';

  @override
  String get label30MinDay => '30 min / jour';

  @override
  String get dynamicDecksStrokeAnalysis =>
      'Decks dynamiques & analyse des traits';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Les abonnements sont temporairement indisponibles. Veuillez réessayer.';

  @override
  String get trialReminder => 'Rappel de la période d\'essai';

  @override
  String get turnOnNotificationsIfYou =>
      'Activez les notifications si vous souhaitez recevoir un rappel avant l\'expiration de votre essai gratuit. Les paramètres d\'abonnement de votre App Store restent la référence.';

  @override
  String get label2Months => '2 mois';

  @override
  String get label3Months => '3 mois';

  @override
  String get label6Months => '6 mois';

  @override
  String get billingPeriod => 'Période de facturation';

  @override
  String get chooseASubscription => 'Choisir un abonnement';

  @override
  String get startFreeTrial => 'Démarrer l\'essai gratuit';

  @override
  String get smartNewsDict => 'Actualités & Dict. intelligents';

  @override
  String get hSK16AIDecks => 'Decks HSK 1-6 & IA';

  @override
  String get continueWithTemporaryPremium =>
      'Continuer avec le Premium temporaire';

  @override
  String get testProductUnavailable => 'Produit de test indisponible';

  @override
  String get paymentIsChargedToYour =>
      'Le paiement est débité de votre compte App Store.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'L\'abonnement se renouvelle automatiquement sauf annulation';

  @override
  String get atLeast24HoursBefore =>
      'au moins 24 heures avant la fin de la période en cours.';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get closePurchaseOffer => 'Fermer l\'offre d\'achat';

  @override
  String get loading => 'Chargement…';

  @override
  String get analyzingImage2 => 'Analyse de l\'image…';

  @override
  String get extractingChineseText2 => 'Extraction du texte chinois…';

  @override
  String get lookingUpVocabulary2 => 'Recherche du vocabulaire…';

  @override
  String get deselectAll => 'Tout désélectionner';

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Chef-d\'œuvre de la littérature chinoise et mondiale.';

  @override
  String get classic => 'Classique';

  @override
  String get literature => 'Littérature';

  @override
  String get theOriginAwakening => 'L\'Origine et l\'Éveil';

  @override
  String get turbulentHorizonsTheJourney => 'Horizons tumultueux et Le Voyage';

  @override
  String get trialsTribulationsDevotion =>
      'Épreuves, tribulations et dévouement';

  @override
  String get theClashOfWitsBravery => 'Affrontement d\'esprit et de courage';

  @override
  String get theGrandClimaxResolution => 'Le grand dénouement et la résolution';

  @override
  String get everlastingLegacyEpilogue => 'Héritage éternel et épilogue';

  @override
  String get acrossTheVastExpanseOf =>
      'À travers la vaste étendue du ciel et de la terre, les personnages poursuivent leur destin et leurs convictions au fil de profondes épreuves.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Chaque dialogue et rencontre au sein de l\'histoire porte l\'éclat de l\'esprit humain et l\'empreinte de son époque.';

  @override
  String get followingTheFlowOfProse =>
      'Au fil de la prose, le lecteur traverse les siècles pour partager les triomphes et les peines de figures légendaires.';

  @override
  String get preQin => 'Pré-Qin';

  @override
  String get theGoddessNWaRepairing => 'La déesse Nüwa réparant le ciel';

  @override
  String get artsTraditions => 'Arts et traditions';

  @override
  String get femaleWarm => 'Féminin, chaleureux';

  @override
  String get femaleCheerful => 'Féminin, joyeux';

  @override
  String get maleUpbeat => 'Masculin, dynamique';

  @override
  String get maleNewsStyle => 'Masculin, style journal';

  @override
  String get maleSporty => 'Masculin, sportif';

  @override
  String get onDevice => 'Sur l\'appareil';

  @override
  String get label15Minutes => '15 minutes';

  @override
  String get label30Minutes => '30 minutes';

  @override
  String get label45Minutes => '45 minutes';

  @override
  String get selectChapter => 'Sélectionner un chapitre';

  @override
  String get andContinuesToBeStudied =>
      'et continue d\'être étudié et célébré par des générations de lecteurs.';

  @override
  String get label1Poem => '1 poème';

  @override
  String get label1Chapter => '1 chapitre';

  @override
  String get localDeviceVoice2 => 'Voix locale de l\'appareil';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Quota Azure hebdomadaire atteint — passage à la voix locale';

  @override
  String get sleepTimer2 => '定时关闭 · Minuteur de mise en veille';

  @override
  String get tableOfContents2 => '目录 · Table des matières';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Classiques espagnols, italiens et russes';

  @override
  String get englishAmericanGlobalClassics =>
      'Classiques anglais, américains et mondiaux';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'tout en intégrant stratégiquement les mots qui vous posent problème afin de les apprendre en contexte.';

  @override
  String get poetryPainting => 'poésie-peinture';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Le Studio Shadowing est un espace dédié pour vous entraîner à imiter les locuteurs natifs. Écoutez une phrase, enregistrez-vous et comparez les formes d\'onde et les scores de prononciation pour perfectionner votre accent.';

  @override
  String get theVoicesInAIStories =>
      'Les Histoires IA et le Jeu de rôle utilisent des voix de synthèse générées par des modèles avancés de synthèse vocale, optimisés pour une prononciation chinoise claire et naturelle. Une voix locale de l’appareil peut aussi être proposée dans certaines fonctionnalités.';

  @override
  String get theWebExplorerAllowsYou =>
      'L\'Explorateur Web vous permet de naviguer sur n\'importe quel site chinois. Si vous croisez un mot difficile, appuyez dessus pour ouvrir la fiche Aperçu rapide, avec le pinyin, la traduction et le niveau HSK.';

  @override
  String get zenModeStripsAwayDistracting =>
      'Le Mode Zen élimine les éléments distrayants, les publicités et les mises en page complexes pour vous offrir un environnement de lecture épuré, axé uniquement sur le texte.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Nous utilisons un algorithme intelligent qui prédit le moment où vous allez oublier un mot. Les mots difficiles réapparaîtront plus souvent, tandis que ceux que vous maîtrisez seront espacés dans le temps.';

  @override
  String get usage3 => 'Usage :';

  @override
  String get tutorialOneExplanation =>
      'Voici UN (Yī). Tracez toujours de gauche à droite.';

  @override
  String get tutorialWaterExplanation =>
      'Voici le caractère complet EAU (Shuǐ). Utilisé comme composant à gauche, il se transforme en « 氵 » (les trois gouttes) !';

  @override
  String get tutorialRadicalsExplanation =>
      'Les hanzi sont composés de blocs appelés RADICAUX. Ils donnent au caractère son sens principal ou son thème.';

  @override
  String get tutorialLettersExplanation =>
      'Les hanzi ne sont pas de simples lettres. Ce sont des images figées dans le temps. Pour les maîtriser, apprenez à suivre leur tracé.';

  @override
  String get tutorialGalaxyExplanation =>
      'La Carte de la Galaxie vous attend. Maîtrisez les Soleils (Radicaux) pour débloquer les Planètes (Caractères).';

  @override
  String get onboardingDailyLifeTravel => 'Vie quotidienne et voyages';

  @override
  String get onboardingPhilosophyIdioms => 'Philosophie et expressions';

  @override
  String get onboardingBusinessCareerMulti => 'Affaires &\nCarrière';

  @override
  String get onboardingTravelSurvivalMulti => 'Voyage &\nSurvie';

  @override
  String get onboardingHskCertificationMulti => 'Certification\nHSK';

  @override
  String get onboardingCulturalAppreciationMulti => 'Découverte\nculturelle';

  @override
  String get practiceReminders => 'Rappels de pratique';

  @override
  String get oneOptionalDailyReminderTo =>
      'Un rappel quotidien facultatif pour pratiquer le chinois';

  @override
  String get aFewMinutesOfChinese => 'Quelques minutes de chinois ? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Maintenez vos progrès grâce à une courte session d\'entraînement.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'étudier · apprendre';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'découvrir';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'persévérer';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'grandir';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'calme · paisible';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'comprendre';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'chaleur · doux';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'se concentrer';

  @override
  String get definitionExpansionButton => 'bouton-extension-définition';

  @override
  String get wenigerAnzeigen => 'Afficher moins';

  @override
  String get mostrarMenos => 'Afficher moins';

  @override
  String get afficherMoins => 'Afficher moins';

  @override
  String get mostraMeno => 'Afficher moins';

  @override
  String get showFewer => 'Afficher moins';

  @override
  String get masterLin => 'Maître Lin';

  @override
  String get xiaoMei => 'Xiao Mei';

  @override
  String get thePoet => 'Le Poète';

  @override
  String get aQiang => 'A-Qiang';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Formel & sage';

  @override
  String get casualFriendly => 'Décontracté & amical';

  @override
  String get poeticAncient => 'Poétique & ancien';

  @override
  String get slangInternet => 'Argot & Internet';

  @override
  String get trendyModern => 'Tendance & moderne';

  @override
  String get designYourOwn => 'Créer le vôtre';

  @override
  String get theBambooSwaysAndThe =>
      'Le bambou oscille, et l\'érudit attend vos mots comme la pluie du matin...';

  @override
  String get yourCustomPersonaIsActive =>
      'Votre persona personnalisé est actif. Tapez pour démarrer la conversation.';

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
      'Réponse d\'extension de dictionnaire obsolète';

  @override
  String get dictionaryExpansionWasEmpty =>
      'L\'extension de dictionnaire était vide';

  @override
  String get explicationDTaillEDisponible => 'Explication détaillée disponible';

  @override
  String get ausfHrlicheErklRungVerf => 'Explication détaillée disponible';

  @override
  String get explicaciNDetalladaDisponible =>
      'Explication détaillée disponible';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Explication détaillée disponible';

  @override
  String get explicaODetalhadaDisponVel => 'Explication détaillée disponible';

  @override
  String get detailedExplanationAvailable => 'Explication détaillée disponible';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Un rappel d\'entraînement quotidien optionnel';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Choisissez un rappel d\'entraînement quotidien optionnel.';

  @override
  String get practiceReminder => 'Rappel d\'entraînement';

  @override
  String get oneGentleReminderADay =>
      'Un doux rappel par jour, uniquement si nécessaire';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Terminer l\'entraînement désactive le rappel du jour. Les alertes de révision et';

  @override
  String get reEngagementAlertsAreCombined =>
      'de relance sont combinées pour ne pas se cumuler.';

  @override
  String get processing2 => 'Traitement en cours…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Écouter';

  @override
  String get notice => 'Observer';

  @override
  String get fourTones => 'Quatre tons';

  @override
  String get write => 'Écrire';

  @override
  String get recap => 'Récap';

  @override
  String get playbackDidNotStart => 'La lecture n\'a pas démarré';

  @override
  String get audioIsUnavailableYouCan =>
      'L\'audio est indisponible. Vous pouvez toujours lire et continuer.';

  @override
  String get microphoneAccessWasNotGranted =>
      'L\'accès au microphone n\'a pas été autorisé. Vous pouvez utiliser l\'option silencieuse ci-dessous.';

  @override
  String get recordingIsUnavailableRightNow =>
      'L\'enregistrement est indisponible pour le moment.';

  @override
  String get listeningToYourTones => 'Écoute de vos tons…';

  @override
  String get noRecording => 'Aucun enregistrement';

  @override
  String get weCouldNotScoreThat =>
      'Nous n\'avons pas pu évaluer cet enregistrement, voici donc une comparaison modèle.';

  @override
  String get listenForTheLowDipping =>
      'Écoutez le troisième ton, bas et descendant-remontant.';

  @override
  String get firstHearATinyMoment =>
      'D\'abord, écoutez un court extrait en mandarin. Pas de mémorisation pour l\'instant.';

  @override
  String get loadingAudio => 'Chargement de l\'audio…';

  @override
  String get listenToThePassage => 'Écouter le passage';

  @override
  String get continueAction => 'Continuer';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Observez comment le sens, le son et les caractères voyagent ensemble.';

  @override
  String get shadowOneSentence => 'Répétez une phrase en écho';

  @override
  String get listenOnceThenHoldThe =>
      'Écoutez une fois, puis maintenez le micro pour dire la phrase.';

  @override
  String get hearItAgain => 'Réécouter';

  @override
  String get stopAndCheckMyTones => 'Arrêter et vérifier mes tons';

  @override
  String get useMicrophone => 'Utiliser le micro';

  @override
  String get iCanTSpeakRight => 'Je ne peux pas parler pour l\'instant';

  @override
  String get tapACharacterToCompare =>
      'Appuyez sur un caractère pour comparer votre ton au ton cible, puis écoutez les tons 1 à 4.';

  @override
  String get tryHandwriting => 'Essayer l\'écriture manuscrite';

  @override
  String get seeWhatYouLearned => 'Voir ce que vous avez appris';

  @override
  String get inAFewMinutesYou =>
      'En quelques minutes, vous avez utilisé la même méthode qui alimente vos leçons.';

  @override
  String get listenedToChineseInContext => 'Écouté du chinois en contexte';

  @override
  String get shadowedASentence => 'Répété une phrase en écho';

  @override
  String get comparedMandarinTones => 'Comparé les tons du mandarin';

  @override
  String get practicedARealCharacter => 'Pratiqué un vrai caractère';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'À l\'aube, la pluie fine s\'est arrêtée. J\'ai ouvert la fenêtre et j\'ai entendu les oiseaux chanter dans les arbres. Une nouvelle journée a commencé.';

  @override
  String get learnThroughRealVideos => 'Apprenez avec de vraies vidéos';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Suivez les sous-titres interactifs, cherchez les mots instantanément et transformez chaque vidéo en leçon.';

  @override
  String get videoLearningScreenshot =>
      'Capture d\'écran de l\'apprentissage vidéo';

  @override
  String get turnAnyBookIntoA => 'Transformez n\'importe quel livre en leçon';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Lisez naturellement avec la prononciation, les définitions et la traduction disponibles à tout moment.';

  @override
  String get bookReaderScreenshot => 'Capture d\'écran du lecteur de livres';

  @override
  String get speakWithTheRightRhythm => 'Parlez avec le bon rythme';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Pratiquez l\'écho sur l\'audio natif et visualisez les quatre tons à mesure que votre prononciation s\'améliore.';

  @override
  String get shadowingAndTonesScreenshot =>
      'Capture d\'écran de l\'écho et des tons';

  @override
  String get understandEveryCharacter => 'Comprenez chaque caractère';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Explorez le sens, la prononciation, les composants, l\'ordre des traits et le vocabulaire utile au même endroit.';

  @override
  String get characterDictionaryScreenshot =>
      'Capture d\'écran du dictionnaire de caractères';

  @override
  String get learnChineseWithoutLimits => 'Apprenez le chinois sans limites';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Regardez, lisez, parlez et comprenez le chinois avec un seul compagnon d\'apprentissage.';

  @override
  String get seeWhatPremiumUnlocks => 'Découvrez ce que débloque Premium';

  @override
  String get scrollToExploreTheComplete =>
      'Défilez pour explorer l\'expérience d\'apprentissage complète';

  @override
  String get cOMINGSOON => 'BIENTÔT DISPONIBLE';

  @override
  String get guidedHandwritingPractice =>
      'Pratique de l\'écriture manuscrite guidée';

  @override
  String get scannerAndLiveTranslation => 'Scanner et traduction en direct';

  @override
  String get hSK16AndAI => 'Decks HSK 1–6 et IA';

  @override
  String get smartSpacedRepetition2 => 'Répétition espacée intelligente';

  @override
  String get progressAndStreakTracking => 'Suivi des progrès et de la série';

  @override
  String get learningToolsInOnePlace =>
      'Outils d\'apprentissage au même endroit';

  @override
  String get everythingIncluded => 'Tout est inclus';

  @override
  String get paymentIsChargedToYour2 =>
      'Le paiement est débité de votre compte App Store. Les abonnements se renouvellent automatiquement, sauf annulation au moins 24 heures avant la fin de la période en cours.';

  @override
  String get yourFirstWeekOfTracked =>
      'Votre première semaine de pratique suivie';

  @override
  String get sameNumberOfCardsAs =>
      'Même nombre de cartes que la semaine dernière';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change de cartes par rapport à la semaine dernière';
  }

  @override
  String get todaySPractice => 'Pratique du jour';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Objectif atteint — tout le reste est un bonus.';

  @override
  String get aSmallAchievableTargetNo =>
      'Un objectif simple et atteignable. Aucune pénalité pour un jour de repos.';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get minutes => 'Minutes';

  @override
  String get activeDays => 'Jours actifs';

  @override
  String dayStreakCount(int count) {
    return 'Série de $count jours';
  }

  @override
  String get masterChineseOneStrokeAt =>
      'Maîtrisez le chinois, un trait à la fois';

  @override
  String get dictionaryExpansionButton => 'Bouton d\'extension du dictionnaire';

  @override
  String get kIErweiterterWRterbucheintrag => 'Détail enrichi par l\'IA';

  @override
  String get detalleAmpliadoPorIA => 'Détail enrichi par l\'IA';

  @override
  String get dTailEnrichiParL => 'Détail enrichi par l\'IA';

  @override
  String get aI => 'Détail enrichi par l\'IA';

  @override
  String get detailKamusYangDiperluasAI => 'Détail enrichi par l\'IA';

  @override
  String get dettaglioDelDizionarioAmpliatoDall => 'Détail enrichi par l\'IA';

  @override
  String get aI2 => 'Détail enrichi par l\'IA';

  @override
  String get aI3 => 'Détail enrichi par l\'IA';

  @override
  String get detalheDeDicionRioExpandido => 'Détail enrichi par l\'IA';

  @override
  String get aI4 => 'Détail enrichi par l\'IA';

  @override
  String get chiTiTTI => 'Détail enrichi par l\'IA';

  @override
  String get aI5 => 'Détail enrichi par l\'IA';

  @override
  String get aIExpandedDictionaryDetail => 'Détail enrichi par l\'IA';

  @override
  String get cetteEntrEEstBr =>
      'Cette entrée est brève. Une explication détaillée est disponible.';

  @override
  String get dieserEintragIstKurzEine =>
      'Cette entrée est brève. Une explication détaillée est disponible.';

  @override
  String get estaEntradaEsBreveHay =>
      'Cette entrée est brève. Une explication détaillée est disponible.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Cette entrée est brève. Une explication détaillée est disponible.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Cette entrée est brève. Une explication détaillée est disponible.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Cette entrée est brève. Une explication détaillée est disponible.';

  @override
  String get dVelopperEnFranAis => 'Développer en français';

  @override
  String get aufDeutschErweitern => 'Développer en allemand';

  @override
  String get ampliarEnEspaOl => 'Développer en espagnol';

  @override
  String get approfondisciInItaliano => 'Développer en italien';

  @override
  String get expandirEmPortuguS => 'Développer en portugais';

  @override
  String get expandDefinition => 'Développer la définition';

  @override
  String get impossibleDeChargerLExplication =>
      'Impossible de charger l\'explication.';

  @override
  String get dieErklRungKonnteNicht => 'Impossible de charger l\'explication.';

  @override
  String get noSePudoCargarLa => 'Impossible de charger l\'explication.';

  @override
  String get impossibileCaricareLaSpiegazione =>
      'Impossible de charger l\'explication.';

  @override
  String get nOFoiPossVel => 'Impossible de charger l\'explication.';

  @override
  String get unableToLoadTheExplanation =>
      'Impossible de charger l\'explication.';

  @override
  String get failedToGenerateStoryN =>
      'Échec de la génération de l\'histoire :\\n\$e';

  @override
  String get thematic => 'Thématique';

  @override
  String get deckFlashcards => 'Paquet (Cartes mémoire)';

  @override
  String get searchLibraryOrTypeCustom =>
      'Rechercher dans la bibliothèque ou saisir du texte personnalisé';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Échec de l\'analyse : \$e';

  @override
  String get extractionFailedE => 'Échec de l\'extraction : \$e';

  @override
  String get simplifyFailedE => 'Échec de la simplification : \$e';

  @override
  String get translationFailedE => 'Échec de la traduction : \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Échec de l\'enregistrement des mots extraits : \$error';

  @override
  String get youActualTargetExpected =>
      'Vous : \$actual  ·  Cible : \$expected';

  @override
  String get improveTheLocalVoice => 'Améliorer la voix locale';

  @override
  String get higherQualityOfflineMandarin =>
      'Mandarin hors-ligne de haute qualité';

  @override
  String get removeDownload => 'Supprimer le téléchargement ?';

  @override
  String get removeDownload2 => 'Supprimer le téléchargement';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Femme, chaleureuse';

  @override
  String get voiceFemaleCheerful => 'Femme, joyeuse';

  @override
  String get voiceMaleUpbeat => 'Homme, enjoué';

  @override
  String get voiceMaleNewsStyle => 'Homme, style informatif';

  @override
  String get voiceMaleSporty => 'Homme, dynamique';

  @override
  String get voiceOnDeviceTts => 'Synthèse vocale sur l\'appareil';

  @override
  String get voiceSystemVoice => 'Voix système';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Appliquer les notes de session à la Répétition Espacée (Mode Oral)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Impossible de charger cette section. Veuillez réessayer.';

  @override
  String get removeDownloadQuestion => 'Supprimer le téléchargement ?';

  @override
  String get removeDownloadContent => 'Supprimer le contenu téléchargé ?';

  @override
  String get removeDownloadAction => 'Supprimer le téléchargement';

  @override
  String get removeDownloadButton => 'Supprimer le téléchargement';

  @override
  String cardsCount(num count) {
    return '$count cartes';
  }

  @override
  String get aiSummary => 'Résumé IA';

  @override
  String get readability => 'Lisibilité';

  @override
  String get translateAction => 'Traduire';

  @override
  String get checkingDownload => 'Vérification du téléchargement';

  @override
  String downloadingBook(int percent) {
    return 'Téléchargement : $percent %';
  }

  @override
  String get retryDownload => 'Réessayer le téléchargement';

  @override
  String get downloadBook => 'Télécharger le livre';

  @override
  String continueChapter(int chapter) {
    return 'Continuer au chapitre $chapter';
  }

  @override
  String get downloadBookError =>
      'Impossible de télécharger ce livre. Vérifiez votre connexion et réessayez.';

  @override
  String downloadBookOffline(int count) {
    return 'Téléchargez le livre pour lire ses $count chapitres hors ligne.';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poèmes',
      one: '1 poème',
    );
    return '$_temp0';
  }

  @override
  String get americanLiterature => 'Littérature américaine';

  @override
  String get ancientChina => 'Chine antique';

  @override
  String get britishLiterature => 'Littérature britannique';

  @override
  String get frenchLiterature => 'Littérature française';

  @override
  String get germanLiterature => 'Littérature allemande';

  @override
  String get italianLiterature => 'Littérature italienne';

  @override
  String get jinDynasty => 'Dynastie Jin';

  @override
  String get preQinEra => 'Époque pré-Qin';

  @override
  String get qingDynasty => 'Dynastie Qing';

  @override
  String get republicOfChinaEra => 'République de Chine';

  @override
  String get russianLiterature => 'Littérature russe';

  @override
  String get spanishLiterature => 'Littérature espagnole';

  @override
  String get springAndAutumn => 'Période des Printemps et Automnes';

  @override
  String get westernHan => 'Han occidentaux';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'p. ex., Un banquet anim? pour c?l?brer ? Shanghai...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'p. ex., Un cousin curieux qui pose des questions sur votre carri?re...';
}
