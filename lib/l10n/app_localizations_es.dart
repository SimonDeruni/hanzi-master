// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

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
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountSubtitle => 'Eliminar tu cuenta permanentemente';

  @override
  String get deleteAccountTitle => '¿Eliminar tu cuenta permanentemente?';

  @override
  String get accountDataDeletedTitle => 'Se eliminarán los datos de la cuenta';

  @override
  String get accountDataDeletedBody =>
      'Tu cuenta de acceso y la información de cuenta que conserva SinoSpark se eliminarán permanentemente. Esto no se puede deshacer.';

  @override
  String get localDataKeptTitle =>
      'Los datos de este dispositivo se conservarán';

  @override
  String get localDataKeptBody =>
      'El progreso de estudio, las descargas y las preferencias almacenadas solo en este dispositivo no se eliminarán.';

  @override
  String get subscriptionNotCanceledTitle => 'Las suscripciones no se cancelan';

  @override
  String get subscriptionNotCanceledBody =>
      'Eliminar tu cuenta no cancela una suscripción de App Store. Puede seguir renovándose hasta que la canceles con Apple.';

  @override
  String get manageSubscription => 'Gestionar suscripción de App Store';

  @override
  String get subscriptionManagementFailed =>
      'No se pudo abrir la gestión de suscripciones de Apple. Abre Ajustes, toca tu nombre y luego Suscripciones.';

  @override
  String get confirmPassword => 'Contraseña actual';

  @override
  String get confirmPasswordToDelete =>
      'Introduce tu contraseña para confirmar tu identidad.';

  @override
  String get deleteAccountPermanently => 'Eliminar cuenta permanentemente';

  @override
  String get deleteAccountFinalTitle => 'Confirmación final';

  @override
  String get deleteAccountFinalWarning =>
      'Esto eliminará tu cuenta permanentemente y no se puede deshacer. Los datos guardados solo en este dispositivo se conservarán. ¿Continuar?';

  @override
  String get deletingAccount => 'Eliminando cuenta...';

  @override
  String get accountPasswordRequired =>
      'Introduce tu contraseña actual para continuar.';

  @override
  String get accountPasswordIncorrect =>
      'La contraseña es incorrecta. Inténtalo de nuevo.';

  @override
  String get accountReauthenticationCanceled =>
      'Se canceló la confirmación de identidad. Tu cuenta no se eliminó.';

  @override
  String get accountReauthenticationFailed =>
      'No pudimos confirmar tu identidad. Inténtalo de nuevo y completa el inicio de sesión.';

  @override
  String get accountAlreadySignedOut =>
      'Ya cerraste sesión. No se eliminó ninguna cuenta.';

  @override
  String get accountProviderUnsupported =>
      'Este método de acceso no se puede verificar en la app. Contacta con soporte.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'Por seguridad, una cuenta vinculada con Apple debe eliminarse en un dispositivo Apple.';

  @override
  String get accountDeletionNetworkError =>
      'Comprueba tu conexión a internet e intenta eliminar la cuenta de nuevo.';

  @override
  String get accountDeletionFailed =>
      'No se pudo eliminar la cuenta. Tu cuenta sigue activa. Inténtalo de nuevo.';

  @override
  String get accountDeletedSuccessfully =>
      'Tu cuenta se eliminó permanentemente.';

  @override
  String get globalMastery => 'DOMINIO GLOBAL';

  @override
  String get masteredCards => 'Dominadas';

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
  String get currentRank => 'RANGO ACTUAL';

  @override
  String get next => 'Siguiente';

  @override
  String get searchHanziOrPinyin => 'Buscar Hanzi o Pinyin...';

  @override
  String get dailyReview => 'Repaso diario';

  @override
  String get upcomingForecast => 'Próximos días';

  @override
  String get laterToday => 'Más tarde';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get next7Days => 'Próximos 7 días';

  @override
  String get theScholarWay => 'El Camino del Erudito';

  @override
  String get beginJourney => 'Comenzar';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get darkModeDesc => 'Agradable a la vista';

  @override
  String get voiceSpeed => 'Velocidad de voz';

  @override
  String get artAndIntellect => 'ARTE E INTELECTO';

  @override
  String get theDigitalScholar => 'El Erudito Digital';

  @override
  String get refineBrushVoice =>
      'Perfecciona tu trazo y tu pronunciación con IA.';

  @override
  String get liveVoiceCall => 'Llamada de voz en directo';

  @override
  String get immersiveRoleplay => 'Juego de rol inmersivo con IA';

  @override
  String get readingRoom => 'Sala de lectura';

  @override
  String get shadowingStudio => 'Estudio de Shadowing';

  @override
  String get errorPrefix => 'Error: ';

  @override
  String get initializingLibrary => 'Inicializando...';

  @override
  String get unlockCharactersToQuiz =>
      '¡Desbloquea 4 caracteres para el cuestionario!';

  @override
  String get practiceQuiz => 'CUESTIONARIO';

  @override
  String get curriculumPaths => 'RUTAS DE ESTUDIO';

  @override
  String get noDecksFound => 'No hay mazos. ¡Añade algunos!';

  @override
  String get addCardsFirst => '¡Añade tarjetas primero!';

  @override
  String get aiDraftingPath => 'La IA está preparando tu ruta...';

  @override
  String get pathReady => '¡Ruta lista!';

  @override
  String get errorGeneratingPath => 'Error al generar la ruta';

  @override
  String get brushingCurriculum => 'Creando ruta...';

  @override
  String get warmUp => 'CALENTAMIENTO';

  @override
  String get lessonComplete => '¡Lección completada! +10 puntos de tinta';

  @override
  String get step1Origin => 'PASO 1: EL ORIGEN';

  @override
  String get traceRadical => 'Traza el radical';

  @override
  String get step2Forge => 'PASO 2: LA FORJA';

  @override
  String get chooseEssence => 'Elige la esencia';

  @override
  String get wrongEssence => '¡Incorrecto! Inténtalo de nuevo.';

  @override
  String get step3Hunt => 'PASO 3: LA BÚSQUEDA';

  @override
  String get findCharacters => 'Encuentra caracteres';

  @override
  String get notThatOne => '¡Ese no!';

  @override
  String get successfullyInstalled => 'Instalado con éxito:';

  @override
  String get failedToDownload => 'Error al descargar.';

  @override
  String get rescindTitle => '¿Revocar?';

  @override
  String get removeCharactersWarning => 'Esto eliminará estos caracteres.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get uninstall => 'Desinstalar';

  @override
  String get removedLibrary => 'Eliminado:';

  @override
  String get tomeLibrary => 'Biblioteca de tomos';

  @override
  String get libraryError => 'Error de biblioteca';

  @override
  String get installTome => 'INSTALAR';

  @override
  String get unitIntro => 'INTRODUCCIÓN DE LA UNIDAD';

  @override
  String get constellationCluster => 'Grupo de constelaciones';

  @override
  String get ok => 'Aceptar';

  @override
  String get divingInto => 'Sumergiéndose en...';

  @override
  String get keyRadicals => 'RADICALES CLAVE';

  @override
  String get noRadicalData => 'No hay datos disponibles.';

  @override
  String get discovery => 'DESCUBRIMIENTO';

  @override
  String get startLearning => 'EMPEZAR';

  @override
  String get selectPersona => 'Elegir personaje';

  @override
  String get customPersona => 'Personaje personalizado';

  @override
  String get geminiLiveCall => 'LLAMADA EN DIRECTO';

  @override
  String get returnToMenu => 'Volver al menú';

  @override
  String get strokeAnalysis => 'Análisis del orden de trazos';

  @override
  String get excellentWork => '¡Excelente trabajo!';

  @override
  String get keepPracticing => '¡Sigue practicando!';

  @override
  String get drawingSubmitted => 'Dibujo enviado';

  @override
  String get customPersonaHint => 'Define un personaje personalizado...';

  @override
  String get stepOneOrigin => 'PASO 1: EL ORIGEN';

  @override
  String get stepTwoForge => 'PASO 2: LA FORJA';

  @override
  String get toForge => 'Para forjar';

  @override
  String get whatEssenceDoesNeed => '¿Qué esencia necesita';

  @override
  String get need => 'necesita';

  @override
  String get forged => 'FORJADO';

  @override
  String get stepThreeHunt => 'PASO 3: LA BÚSQUEDA';

  @override
  String get findCharactersWith => 'Encuentra caracteres con';

  @override
  String get uninstallButton => 'DESINSTALAR';

  @override
  String get gradedAiStories => 'Historias graduadas por IA';

  @override
  String get calligraphy => 'Caligrafía';

  @override
  String get theScrollOfOrigin => 'El Pergamino del Origen';

  @override
  String get galaxyOf => 'Galaxia de';

  @override
  String get constellationDescription => 'Descripción de la constelación';

  @override
  String get noRadicalDataAvailable => 'No hay datos de radicales disponibles';

  @override
  String get learningPreferences => 'Preferencias de aprendizaje';

  @override
  String get hardMode => 'Modo difícil';

  @override
  String get hardModeDesc => 'Requiere entradas precisas sin guías visuales.';

  @override
  String get adaptiveGuidance => 'Guía adaptativa';

  @override
  String get dailyGoal => 'Objetivo diario';

  @override
  String get audioAndHaptics => 'Audio y vibración háptica';

  @override
  String get autoPlayAudio => 'Reproducir audio automáticamente';

  @override
  String get autoPlayDesc =>
      'Reproduce la pronunciación de forma automática al mostrar la tarjeta.';

  @override
  String get haptics => 'Respuesta háptica';

  @override
  String get displayAndContent => 'Pantalla y contenido';

  @override
  String get useEnglishDefinitions => 'Usar definiciones en inglés';

  @override
  String get useEnglishDefinitionsDesc =>
      'Las definiciones en inglés suelen ser más precisas y detalladas';

  @override
  String get animationSpeed => 'Velocidad de animación';

  @override
  String get manageTomes => 'Gestionar tomos';

  @override
  String get manageTomesDesc => 'Administra tus tomos de estudio instalados.';

  @override
  String get dangerZone => 'Zona de peligro';

  @override
  String get resetAllData => 'Restablecer todos los datos';

  @override
  String get resetDataDesc =>
      'Esto eliminará permanentemente todo tu progreso, estadísticas y ajustes. Esta acción no se puede deshacer.';

  @override
  String get areYouSure => '¿Estás seguro?';

  @override
  String get cannotBeUndone => 'No se puede deshacer';

  @override
  String get deleteEverything => 'Eliminar todo';

  @override
  String get appLanguage => 'Idioma de la app';

  @override
  String get howDidYouDo => '¿Cómo te fue?';

  @override
  String get missedItEntirely => 'Lo olvidé por completo';

  @override
  String get gotItButStruggled => 'Lo recordé con dificultad';

  @override
  String get gotItClearly => 'Lo recordé con claridad';

  @override
  String get perfectAndImmediate => 'Perfecto e instantáneo';

  @override
  String get again => 'Repetir';

  @override
  String get hard => 'Difícil';

  @override
  String get good => 'Bien';

  @override
  String get easy => 'Fácil';

  @override
  String get tapToReveal => 'Toca para revelar';

  @override
  String get howWellDidYouRemember => '¿Qué tan bien lo recordaste?';

  @override
  String get completelyForgot => 'Lo olvidé por completo';

  @override
  String get gotItWithDifficulty => 'Con dificultad';

  @override
  String get recalledCorrectly => 'Recordado correctamente';

  @override
  String get perfectRecall => 'Memoria perfecta';

  @override
  String get practiceWriting => 'Practicar escritura';

  @override
  String get hideScratchpad => 'Ocultar bloc de notas';

  @override
  String get whatCharacterMeans => 'Significado del carácter:';

  @override
  String get tapCardToReveal => 'Toca la tarjeta para revelar';

  @override
  String get ratePronunciationConfidence =>
      'Califica tu seguridad en la pronunciación';

  @override
  String get botchedIt => 'Muy impreciso';

  @override
  String get struggledWithTones => 'Dificultad con los tonos';

  @override
  String get acceptable => 'Aceptable';

  @override
  String get perfectlyNatural => 'Completamente natural';

  @override
  String get sessionComplete => '¡Sesión completada!';

  @override
  String get accuracy => 'Precisión';

  @override
  String get reviewed => 'Repasado';

  @override
  String get correct => 'Correcto';

  @override
  String get backToLibrary => 'Volver a la biblioteca';

  @override
  String get revealAnswer => 'Revelar respuesta';

  @override
  String get aiHubTitle => 'Centro de IA';

  @override
  String get textChat => 'Chat de texto';

  @override
  String get scholarlyPersonas => 'Personajes eruditos';

  @override
  String get shadowing => 'Shadowing (Imitación auditiva)';

  @override
  String get liveTranslation => 'Traducción en directo';

  @override
  String get scholarsLibrary => 'La Biblioteca del Erudito';

  @override
  String get generate => 'Generar';

  @override
  String get searchPinyinHanziEnglish =>
      'Buscar Pinyin, Hanzi o significado...';

  @override
  String get liveTranslate => 'Traducir en directo';

  @override
  String get travelInterpreter => 'Intérprete de viaje';

  @override
  String get realTimeSplitScreen =>
      'Conversación en pantalla dividida en tiempo real con un hablante nativo para eliminar barreras lingüísticas al instante.';

  @override
  String get whisperEarpiece => 'Auricular de traducción instantánea';

  @override
  String get listenToChineseAudio =>
      'Escucha audio en chino y obtén subtítulos en español en tiempo real directamente en tu pantalla.';

  @override
  String get dashboardTitle => 'Panel de control';

  @override
  String get yourMindIsClear => 'Tu mente está despejada.';

  @override
  String get noReviewsDueToday => 'No hay repasos pendientes para hoy.';

  @override
  String get done => 'Listo';

  @override
  String get hskLevel1 => 'Nivel HSK 1';

  @override
  String get hskLevel2 => 'Nivel HSK 2';

  @override
  String get hskLevel3 => 'Nivel HSK 3';

  @override
  String get hskLevel4 => 'Nivel HSK 4';

  @override
  String get hskLevel5 => 'Nivel HSK 5';

  @override
  String get hskLevel6 => 'Nivel HSK 6';

  @override
  String get generalVocabulary => 'Vocabulario general';

  @override
  String cardsRequireAttention(Object count) {
    return '$count tarjetas requieren atención.';
  }

  @override
  String get begin => 'Empezar';

  @override
  String get poweredByAi =>
      'Con tecnología de IA avanzada para una traducción fluida en tiempo real en cualquier situación.';

  @override
  String get downloadingModel => 'Descargando modelo...';

  @override
  String get soon => 'PRÓXIMAMENTE';

  @override
  String get installed => 'INSTALADO';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'MÓDULO PRINCIPAL';

  @override
  String get step6Context => 'PASO 6: CONTEXTO';

  @override
  String get tapBuildingBlocksTo =>
      'Toca los bloques de construcción para explorar su origen.';

  @override
  String get initiateRadicalSequence => 'INICIAR SECUENCIA DE RADICALES';

  @override
  String get holdToTalk => 'Mantén pulsado para hablar';

  @override
  String get customScenario => 'Escenario personalizado';

  @override
  String get voiceCall => 'Llamada de voz';

  @override
  String get pronunciation => 'Pronunciación';

  @override
  String get selectAScenarioTo =>
      'Selecciona un escenario para practicar tu mandarín hablado. El Erudito evaluará tus tonos y claridad.';

  @override
  String get create => 'Crear';

  @override
  String get createYourScenario => 'Crea tu escenario';

  @override
  String get difficulty => 'Dificultad';

  @override
  String get scholarsVerdict => 'VEREDICTO DEL ERUDITO';

  @override
  String get completeReview => 'Revisión completa';

  @override
  String get conversationReview => 'REVISIÓN DE LA CONVERSACIÓN';

  @override
  String get linguisticAnalysis => 'Análisis lingüístico';

  @override
  String get examplesInHsk1 => 'EJEMPLOS EN HSK 1';

  @override
  String get characterReference => 'Referencia del carácter';

  @override
  String get askTutor => 'Preguntar al tutor';

  @override
  String get addToStudyDeck => 'Añadir al mazo de estudio';

  @override
  String get startPractice => 'INICIAR PRÁCTICA';

  @override
  String get noOtherHsk1 => 'Ningún otro carácter HSK 1 usa este radical.';

  @override
  String get couldNotLoadAi =>
      'No se pudo cargar el contexto de IA (límite de peticiones o error de red).\nToca el botón de actualizar a continuación para intentarlo más tarde.';

  @override
  String get noAvailableCardsFound => 'No se encontraron tarjetas disponibles.';

  @override
  String get addCards => 'Añadir tarjetas';

  @override
  String get removeCard => 'Eliminar tarjeta';

  @override
  String get remove => 'Eliminar';

  @override
  String get review => 'Repasar';

  @override
  String get story => 'Historia';

  @override
  String get thisDeckIsEmpty => 'Este mazo está vacío.';

  @override
  String get tapTheAddCards => '¡Toca el botón «Añadir tarjetas»!';

  @override
  String get noCardsFound => 'No se encontraron tarjetas.';

  @override
  String get addCardsToSee => 'Añade tarjetas para ver estadísticas.';

  @override
  String get aiGenerated => 'Generado por IA';

  @override
  String get allCardsCaughtUp =>
      '¡Todas las tarjetas al día! Excelente trabajo.';

  @override
  String get latestDiscoveries => 'Últimos descubrimientos';

  @override
  String get noCharactersInLexicon => 'Todavía no hay caracteres en el léxico.';

  @override
  String get yourBookshelf => 'Tu estantería';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Busca en tu diccionario...';

  @override
  String get saveCard => 'Guardar tarjeta';

  @override
  String get noCharactersFound => 'No se encontraron caracteres.';

  @override
  String get radicalsIndex => 'Índice de radicales';

  @override
  String get masteringRadicalsIsThe =>
      'Dominar los radicales es la clave para descifrar miles de Hanzi. Selecciona un radical para ver todos los caracteres asociados.';

  @override
  String get noRadicalsFound => 'No se encontraron radicales.';

  @override
  String get yourDrawing => 'Tu trazo';

  @override
  String get reference => 'Referencia';

  @override
  String get rateYourRecall => 'Califica tu capacidad de recuerdo';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get reportBugsOrRequest => 'Reportar errores o solicitar funciones';

  @override
  String get allDataHasBeen => 'Todos los datos han sido eliminados.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Mi progreso';

  @override
  String get overview => 'Resumen';

  @override
  String get aiStory => 'Historia de IA';

  @override
  String get usingYourDecksVocabulary => 'Con el vocabulario de tu mazo';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get translate => 'Traducir';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Traducción completa';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash está estructurando tu historia...';

  @override
  String get aiDeckGenerator => 'Generador de mazos con IA';

  @override
  String get whatDoYouWant => '¿Qué quieres aprender?';

  @override
  String get targetDifficulty => 'Dificultad objetivo';

  @override
  String get focusArea => 'Área de enfoque';

  @override
  String get specificContextOrTone => 'Contexto o tono específico (opcional)';

  @override
  String get numberOfCards => 'Número de tarjetas';

  @override
  String get generateDeck => 'Generar mazo';

  @override
  String get aiGrammarExplanation => 'Explicación gramatical con IA';

  @override
  String get scholarsDesk => 'Escritorio del Erudito';

  @override
  String get chooseADeck => 'Elige un mazo';

  @override
  String get whereWouldYouLike => '¿Dónde te gustaría guardar este carácter?';

  @override
  String get addToDefaultStudy => 'Añadir al mazo de estudio predeterminado';

  @override
  String get ifOffItsOnly =>
      'Si está desactivado, solo se guardará en el diccionario global';

  @override
  String get saveToLibrary => 'Guardar en la biblioteca';

  @override
  String get pleaseEnterValidChinese => 'Introduce caracteres chinos válidos';

  @override
  String get reviewAiCard => 'Revisar tarjeta de IA';

  @override
  String get pleaseDoublecheckTheAis =>
      'Verifica el resultado de la IA a continuación. Puedes ajustar el pinyin o la definición antes de guardarlo en tu biblioteca permanente.';

  @override
  String get alreadyInYourLibrary => '¡Ya está en tu biblioteca!';

  @override
  String get meaningInContext => 'Significado en contexto';

  @override
  String get explainGrammar => 'Explicar gramática';

  @override
  String get addToLibrary => 'Añadir a la biblioteca';

  @override
  String get masterYourMandarinPronunciation =>
      'Domina tu pronunciación en mandarín imitando a hablantes nativos en tiempo real.';

  @override
  String get startSession => 'INICIAR SESIÓN';

  @override
  String get sessionHistory => 'Historial de sesiones';

  @override
  String get noSavedSessions => 'No hay sesiones guardadas.';

  @override
  String get aiBreakdown => 'Desglose por IA';

  @override
  String get sessionDetails => 'Detalles de la sesión';

  @override
  String partner(Object lang) {
    return 'Interlocutor ($lang)';
  }

  @override
  String get youEnglish => 'Tú (Español)';

  @override
  String get noTranscriptToSave => '¡No hay transcripción para guardar!';

  @override
  String get sessionSaved => '¡Sesión guardada!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Traducción bidireccional en tiempo real. Habla en español o mandarín y se traducirá al instante para ti y tu compañero.';

  @override
  String get text_1782026184665 => 'Grabando';

  @override
  String get recording => 'Grabando';

  @override
  String get yourSilentCompanionListen =>
      'Tu acompañante silencioso. Escucha en mandarín y recibe la traducción al español al instante.';

  @override
  String get startListening => 'COMENZAR A ESCUCHAR';

  @override
  String get skip => 'Omitir';

  @override
  String get independentStars => 'ESTRELLAS INDEPENDIENTES';

  @override
  String get notEveryCharacterHas =>
      'No todos los caracteres tienen un radical derivado. Algunos son pictogramas únicos o se sostienen por sí mismos.';

  @override
  String get onTheMapWe =>
      'En el mapa, agrupamos estos caracteres independientes en CONSTELACIONES (✨).';

  @override
  String get iUnderstand => 'ENTENDIDO';

  @override
  String get whatAreRadicals => '¿QUÉ SON LOS RADICALES?';

  @override
  String get hanziAreBuiltFrom =>
      'Los caracteres Hanzi se construyen a partir de componentes llamados RADICALES.\n\nLe otorgan al carácter su significado o tema principal.';

  @override
  String get continueText => 'CONTINUAR';

  @override
  String get hanziAreNotJust =>
      'Los caracteres Hanzi no son simples letras, sino imágenes congeladas en el tiempo.\n\nPara dominarlos, debes aprender a seguir el flujo de sus trazos.';

  @override
  String get iAmReady => 'ESTOY LISTO';

  @override
  String get youAreAScholar => 'ERES UN ERUDITO';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'El Mapa de la Galaxia te espera.\nDomina los Soles (Radicales) para desbloquear los Planetas (Caracteres).';

  @override
  String get enterTheScroll => 'ABRIR EL PERGAMINO';

  @override
  String get openingTheOriginScroll => 'Abriendo el Pergamino del Origen...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'La Edición del Erudito';

  @override
  String get weArePreparingThe =>
      'Estamos preparando la Edición del Erudito para su lanzamiento.';

  @override
  String get devBypassUnlockNow => 'ACCESO DE DESARROLLADOR: DESBLOQUEAR AHORA';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get welcomeScholarTheScroll =>
      'Bienvenido, Erudito. El pergamino está completamente a tu disposición.';

  @override
  String get purchasesRestoredSuccessfully => 'Compras restauradas con éxito.';

  @override
  String get noPreviousPurchasesFound =>
      'No se encontraron compras previas en esta cuenta.';

  @override
  String get unlockTheFullPotential =>
      'Desbloquea todo el potencial de tu aprendizaje. Compra única, tuya para siempre.';

  @override
  String get universalScanner => 'Escáner universal';

  @override
  String get noChineseCharactersFound =>
      'No se encontraron caracteres chinos en la imagen.';

  @override
  String get addedNewCharactersTo =>
      '¡Se han añadido nuevos caracteres a tu biblioteca!';

  @override
  String get extractingTextAndObjects => 'Extrayendo texto y objetos...';

  @override
  String get scanATextbookSign =>
      'Escanea un libro de texto, letrero u objeto para extraer caracteres chinos.';

  @override
  String get extractedText => 'Texto extraído';

  @override
  String get useText => 'Usar texto';

  @override
  String get noMatchingDictionaryEntries =>
      'No se encontraron entradas coincidentes en el diccionario.';

  @override
  String get quizComplete => '¡Cuestionario completado!';

  @override
  String get returnToCourse => 'Volver al curso';

  @override
  String get notEnoughCardsFor =>
      '¡No hay suficientes tarjetas para un cuestionario! Se necesitan al menos 4.';

  @override
  String get creatorMode => 'Modo creador';

  @override
  String get noStoriesFoundMatching =>
      'No se encontraron historias que coincidan con tu búsqueda.';

  @override
  String get discard => 'Descartar';

  @override
  String get save => 'Guardar';

  @override
  String get generatingStoryViaDeepseek => 'Generando historia con DeepSeek...';

  @override
  String get storySavedToLibrary => '¡Historia guardada en la biblioteca!';

  @override
  String get storyNotFound => 'Historia no encontrada.';

  @override
  String get targetHskLevel => 'Nivel HSK objetivo';

  @override
  String get wedLoveToHear => '¡Nos encantaría conocer tu opinión!';

  @override
  String get whetherYouveFoundA =>
      'Tanto si encontraste un error como si tienes una sugerencia o simplemente quieres saludar, tus comentarios nos ayudan a mejorar SinoSpark.';

  @override
  String get pointYourCameraAt => 'Apunta tu cámara a los objetos';

  @override
  String get reviewAddToLibrary => 'Revisar y añadir a la biblioteca';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Ocultar guía de trazos al alcanzar racha de: $streak';
  }

  @override
  String inkPoints(Object points) {
    return '$points puntos de tinta';
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
  String get supportAndFeedback => 'Soporte y comentarios';

  @override
  String get reportBug => 'Informar de un error';

  @override
  String get suggestFeature => 'Sugerir una función';

  @override
  String get generalFeedback => 'Comentarios generales';

  @override
  String get pleaseDrawSomethingFirst => 'Por favor, dibuja algo primero';

  @override
  String get drawThisCharacter => 'Dibuja este carácter:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Sigue la guía azul para dibujar el trazo $current de $total';
  }

  @override
  String get skipCurrentStroke => 'Saltar trazo actual';

  @override
  String get submitDrawing => 'Confirmar dibujo';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '«$hanzi» añadido a «$deckName»';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '«$hanzi» eliminado del mazo';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'Se omitió «$hanzi»: no hay datos de trazo disponibles para este carácter.';
  }

  @override
  String get startingSession => 'Iniciando sesión...';

  @override
  String get masterBuildingBlocks =>
      'Domina los componentes básicos de los Hanzi';

  @override
  String get totalWords => 'Total de palabras';

  @override
  String get newInk => 'Tinta nueva';

  @override
  String get learningStatus => 'En aprendizaje';

  @override
  String get masteredStatus => 'Dominado';

  @override
  String get libraryMastery => 'Dominio de la biblioteca';

  @override
  String get accuracyByMode => 'Precisión por modo';

  @override
  String get upcomingReviews => 'Próximos repasos (próximos 7 días)';

  @override
  String get culturalReadingRoom => 'Sala de lectura cultural (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Introduce un tema';

  @override
  String createdDeckCards(Object count, Object name) {
    return '¡Se creó «$name» con $count tarjetas!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Calificación: $grade';
  }

  @override
  String get listeningMode => 'Modo escucha';

  @override
  String get readingMode => 'Modo lectura';

  @override
  String get recallMode => 'Modo evocación mental';

  @override
  String get speakingMode => 'Modo habla';

  @override
  String get aiMemoryHook => 'Regla mnemotécnica por IA';

  @override
  String get exampleSentences => 'Frases de ejemplo';

  @override
  String get ghostCharacters => 'Caracteres guía (marca de agua)';

  @override
  String get commonWords => 'Palabras frecuentes';

  @override
  String get personalNotes => 'Notas personales';

  @override
  String get addPersonalNotes =>
      'Añade aquí tus propias reglas mnemotécnicas o notas...';

  @override
  String get takePhoto => 'Hacer foto';

  @override
  String get gallery => 'Galería';

  @override
  String get arLens => 'Lente RA';

  @override
  String addedCharToLibrary(Object char) {
    return 'Se añadió «$char» a la biblioteca';
  }

  @override
  String get scoreText => 'Puntuación';

  @override
  String get searchDictionaryHint =>
      'Busca el carácter, pinyin o significado...';

  @override
  String get searchDeckHint => 'Busca el carácter o pinyin...';

  @override
  String get localRestaurant => 'Restaurante local';

  @override
  String get taxiToAirport => 'Taxi al aeropuerto';

  @override
  String get silkMarketHaggling => 'Regateo en el Mercado de la Seda';

  @override
  String get medicalClinic => 'Consulta médica';

  @override
  String get meetingAFriend => 'Quedar con un amigo';

  @override
  String get jobInterview => 'Entrevista de trabajo';

  @override
  String get searchRadicalsHint => 'Buscar radicales (ej. Agua, 氵)';

  @override
  String get definition => 'Definición';

  @override
  String get undo => 'Deshacer';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Desbloquear para siempre - 9,99 \$';

  @override
  String get clear => 'Borrar';

  @override
  String get clearChat => 'Borrar chat';

  @override
  String get typeMessage => 'Escribe un mensaje...';

  @override
  String addedToLibrary(Object hanzi) {
    return 'Se añadió «$hanzi» a tu biblioteca';
  }

  @override
  String get generateNewStory => 'Generar nueva historia';

  @override
  String failedToGenerateStory(Object error) {
    return 'Error al generar la historia:\n$error';
  }

  @override
  String get detail => 'Detalle';

  @override
  String get scanText => 'Escanear texto';

  @override
  String get createMagic => 'Crear magia';

  @override
  String get learning => 'En aprendizaje';

  @override
  String get upcomingReviews7Days => 'Próximos repasos (próximos 7 días)';

  @override
  String get askFollowUpQuestion => 'Hacer una pregunta de seguimiento...';

  @override
  String get pasteScanToSimplify =>
      'Pega o escanea texto en chino para simplificarlo';

  @override
  String get searchStoriesHint =>
      'Buscar historias por título o etiquetas (ej. mitología, viajes)';

  @override
  String get importAll => 'Importar todo';

  @override
  String get ascendAll => 'Ascender todo';

  @override
  String get startAscension => 'Iniciar ascenso';

  @override
  String get scenarioLocalRestaurant => 'Restaurante local';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Practica cómo pedir platos y solicitar recomendaciones.';

  @override
  String get scenarioTaxiAirport => 'Taxi al aeropuerto';

  @override
  String get scenarioTaxiAirportDesc =>
      'Indica al conductor tu destino y comenta sobre el tráfico.';

  @override
  String get scenarioSilkMarket => 'Regateo en el Mercado de la Seda';

  @override
  String get scenarioSilkMarketDesc =>
      'Intenta conseguir un mejor precio para un recuerdo.';

  @override
  String get scenarioMedicalClinic => 'Consulta médica';

  @override
  String get scenarioMedicalClinicDesc =>
      'Explica tus síntomas a un médico tradicional.';

  @override
  String get scenarioMeetingFriend => 'Quedar con un amigo';

  @override
  String get scenarioMeetingFriendDesc =>
      'Preséntate y mantén una conversación informal.';

  @override
  String get scenarioJobInterview => 'Entrevista de trabajo';

  @override
  String get scenarioJobInterviewDesc =>
      'Postula a un puesto en una empresa tecnológica de Shanghái.';

  @override
  String get createCustomScenario => 'Crear escenario personalizado';

  @override
  String get customScenarioTitleHint => 'Título (ej. Banquete de bodas)';

  @override
  String get customScenarioDescHint => 'Descripción (Contexto)';

  @override
  String get customScenarioPersonaHint =>
      'Perfil del personaje IA (ej. Un colega curioso)';

  @override
  String get customScenarioDifficulty => 'Dificultad';

  @override
  String get createAction => 'Crear';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get mythsAndLegends => 'Mitos y leyendas';

  @override
  String get historyAndCulture => 'Historia y cultura';

  @override
  String get idiomsTitle => 'Modismos (成语)';

  @override
  String get theMonkeyKing => 'El Rey Mono';

  @override
  String get theMonkeyKingDesc => 'Sun Wukong (Viaje al Oeste)';

  @override
  String get huaMulan => 'Hua Mulan';

  @override
  String get huaMulanDesc =>
      'Hua Mulan alistándose en el ejército en lugar de su padre';

  @override
  String get confuciusTitle => 'Confucio';

  @override
  String get confuciusDesc => 'Vida y enseñanzas de Confucio';

  @override
  String get theGreatWall => 'La Gran Muralla';

  @override
  String get theGreatWallDesc => 'La construcción de la Gran Muralla China';

  @override
  String get generateTopic => 'Generar tema';

  @override
  String get simplifyText => 'Simplificar texto';

  @override
  String get topicHint => 'Tema (ej. Extraterrestres en Pekín)';

  @override
  String get tagsHint => 'Etiquetas (separadas por comas, opcional)';

  @override
  String get speakWithMasterLin => 'Habla con el Maestro Lin';

  @override
  String get masterLinGreeting =>
      'Saludos, estudiante. La tinta está lista. ¿Qué carácter o frase examinaremos hoy?';

  @override
  String get typeYourMessage => 'Escribe tu mensaje...';

  @override
  String get theMainLibrary => 'Biblioteca principal';

  @override
  String get hsk1Foundation => 'HSK 1: Fundamentos';

  @override
  String get hsk2Elementary => 'HSK 2: Elemental';

  @override
  String get hsk3Intermediate => 'HSK 3: Intermedio';

  @override
  String get inDeckCheck => 'En el mazo ✓';

  @override
  String get addToDeckPlus => '+ Añadir al mazo';

  @override
  String get openCardArrow => 'Abrir tarjeta →';

  @override
  String get pronunciationPartial => 'Tono impreciso';

  @override
  String get pronunciationWrong => 'Incorrecto';

  @override
  String get toneExpected => 'Esperado';

  @override
  String get toneYouSaid => 'Pronunciaste';

  @override
  String get gotIt => '¡Entendido!';

  @override
  String foundNCharacters(int count) {
    return '$count caracteres encontrados';
  }

  @override
  String get lookingUpCharacters => 'Buscando caracteres…';

  @override
  String get practiceAll => 'Practicar todo';

  @override
  String get arLensObjects => 'Objetos';

  @override
  String get arLensText => 'Texto';

  @override
  String get arLensDetectedText => 'Texto detectado';

  @override
  String get duration12Min => '1-2 min';

  @override
  String get aClassicTangDynastyPoem => 'Un poema clásico de la dinastía Tang';

  @override
  String get aClassicTangDynastyPoemBy =>
      'Un poema clásico de la dinastía Tang de';

  @override
  String get aStructuralComponent => 'Un componente estructural.';

  @override
  String get addSelectedToDeck => 'Añadir seleccionados al mazo';

  @override
  String addTo(Object target) {
    return 'Añadir a ';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '«$hanzi» añadido a tu biblioteca';
  }

  @override
  String get adjustFontSize => 'Ajustar tamaño de letra';

  @override
  String get againGoodEasyHard =>
      '⬅️ Repetir    ➡️ Bien    ⬆️ Fácil    ⬇️ Difícil';

  @override
  String get aiAnalysisFailed => 'El análisis de IA falló';

  @override
  String get aiIsThinking => 'La IA está pensando...';

  @override
  String get aiSceneAnalysisFailed => 'El análisis de escena de IA falló';

  @override
  String get allLabel => 'Todo';

  @override
  String get allPinyin => 'Todo el Pinyin';

  @override
  String get alreadyHaveAccountSignIn => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get analysisFailed => 'Análisis fallido:';

  @override
  String get analyzingClassicalCharacters =>
      'Analizando caracteres clásicos...';

  @override
  String get anatomy => 'Anatomía';

  @override
  String get ancientPhilosophy => 'Filosofía antigua';

  @override
  String get articleSavedToMediaHub =>
      '¡Artículo guardado en el centro de medios!';

  @override
  String get askAFollowUp => 'Haz una pregunta de seguimiento...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Audio, privacidad y funcionamiento';

  @override
  String get audiobookPlayer => 'Reproductor de audiolibros';

  @override
  String get audiobookVoice => 'Voz del audiolibro';

  @override
  String get auntieMaTown =>
      'Tía Ma (马阿姨), una dueña de puesto enérgica que prepara los mejores Roujiamo y Liangpi de la ciudad.';

  @override
  String get back => 'Atrás';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯), un joven tostador de café apasionado al que le encanta hablar sobre granos de café de Yunnan y notas de sabor.';

  @override
  String get bbc => 'BBC en chino';

  @override
  String get beginYourJourney => 'Comienza tu viaje';

  @override
  String get bestValue => 'Mejor relación calidad-precio';

  @override
  String get bookLinkCopiedToClipboard =>
      '¡Enlace del libro copiado al portapapeles!';

  @override
  String get bookmarkChapter => 'Marcar capítulo';

  @override
  String get bookmarks => 'Marcadores';

  @override
  String get books => 'Libros';

  @override
  String get briefing => 'Informe';

  @override
  String get bugReport => 'Informe de error';

  @override
  String get caoXueqinDecline =>
      'Cao Xueqin (c. 1715-1763) fue un novelista de la dinastía Qing nacido en una familia noble antaño adinerada. Sueño en el pabellón rojo, escrita en sus últimos años de pobreza, es ampliamente considerada la cumbre de la narrativa clásica china: un vasto tapiz psicológico sobre el declive aristocrático.';

  @override
  String get cardsTitle => 'TARJETAS';

  @override
  String get cc => 'Subtítulos (CC)';

  @override
  String get characterOrWord => 'Carácter / Palabra';

  @override
  String get chatMore => 'Chatear más';

  @override
  String get chefChenShumai =>
      'Chef Chen (陈师傅), un alegre chef cantonés de dim sum que recomienda dumplings Har Gow frescos y Shumai.';

  @override
  String get chineseEpics => 'Epopeyas chinas';

  @override
  String get chinesePoetry => 'Poesía china';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast =>
      'Festín de hotpot picante de Chongqing';

  @override
  String get chooseAudiobookVoice => 'Elegir voz del audiolibro';

  @override
  String get chooseVoice => 'Elegir voz';

  @override
  String get compare => 'Comparar';

  @override
  String get compare4Tones => 'Comparar los 4 tonos';

  @override
  String get configuration => 'Configuración';

  @override
  String get contemporary => 'Contemporáneo';

  @override
  String get context => 'Contexto';

  @override
  String get couldNotLoadLibrary => 'No se pudo cargar la biblioteca';

  @override
  String get couldNotLoadVocabulary => 'No se pudo cargar el vocabulario.';

  @override
  String get couldNotOpenEmailApp =>
      'No se pudo abrir la aplicación de correo.';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get createNewDeck => 'Crear nuevo mazo';

  @override
  String get createScenario => 'Crear escenario';

  @override
  String get createStory => 'Crear historia';

  @override
  String get customLabel => 'Personalizado';

  @override
  String get customWord => 'Palabra personalizada';

  @override
  String get days => 'días';

  @override
  String get deck => 'Mazo';

  @override
  String get deckName => 'Nombre del mazo';

  @override
  String get deckStory => 'Historia del mazo';

  @override
  String get deepAnalysis => 'Análisis profundo';

  @override
  String get defaultDeck => 'Mazo predeterminado';

  @override
  String get deleteLabel => 'Eliminar';

  @override
  String get deleteScenario => 'Eliminar escenario';

  @override
  String get deletesAllProgressPermanently =>
      'Elimina todo el progreso permanentemente';

  @override
  String get developerBackdoorUnlocked =>
      '¡Puerta trasera de desarrollador desbloqueada!';

  @override
  String get doesNotExistInChinese => 'No existe en chino';

  @override
  String get dontHaveAccountSignUp => '¿No tienes cuenta? Regístrate';

  @override
  String get draftingStoryOutline => 'Redactando el esquema de la historia...';

  @override
  String get dynamicFlowState => 'Estado de flujo dinámico';

  @override
  String get dynamicFlowStateParenthetical => 'Dinámico (Estado de flujo)';

  @override
  String get editCard => 'Editar tarjeta';

  @override
  String get egAnimeVocab => 'Ej.: Vocabulario de anime';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'Ej.: lenguaje formal de negocios, jerga de mensajería...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'Ej.: pedir en un restaurante, vocabulario de negocios...';

  @override
  String get egWeddingReceptionTechInterview =>
      'Ej.: banquete de bodas, entrevista técnica...';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get english => 'Inglés';

  @override
  String get englishAndWorld => 'Inglés y mundial';

  @override
  String get episodes => 'episodios';

  @override
  String get erase => 'Borrar';

  @override
  String get eraseDeckQuestion => '¿Borrar mazo?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Error al obtener traducción para $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Error al cargar microlecturas: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Error al cargar novelas: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Error al cargar poesía: $e';
  }

  @override
  String get exitFocus => 'Salir del modo concentración';

  @override
  String get explore => 'Explorar';

  @override
  String get exportToThisDeck => 'Exportar a este mazo';

  @override
  String get extractAndSimplify => 'Extraer y simplificar';

  @override
  String get failedToCreateDeck => 'Error al crear el mazo';

  @override
  String get failedToLoadDailyContent => 'Error al cargar el contenido diario';

  @override
  String get failedToLoadEpisodes => 'Error al cargar episodios';

  @override
  String get failedToLoadShows => 'Error al cargar programas';

  @override
  String get finalizingDetails => 'Finalizando detalles...';

  @override
  String get finalizingStoryDetails => 'Finalizando detalles de la historia...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth no está habilitado. Activa el método de inicio de sesión requerido en tu consola de Firebase.';

  @override
  String get flashcardDeckTitle => 'MAZO DE TARJETAS';

  @override
  String get focus => 'Concentración';

  @override
  String get foodAndCooking => 'Comida y cocina';

  @override
  String get forward => 'Adelantar';

  @override
  String get freeFlow => 'Flujo libre';

  @override
  String get frenchClassics => 'Clásicos franceses';

  @override
  String get full => 'Completo';

  @override
  String get gamingAndEsports => 'Juegos y eSports';

  @override
  String get germanClassics => 'Clásicos alemanes';

  @override
  String get ghostPinyin => 'Pinyin guía (fantasma)';

  @override
  String get goodAttempt => 'Buen intento';

  @override
  String get gotItSimple => 'Entendido';

  @override
  String get grammar => 'Gramática';

  @override
  String get grandmaLiuFilling =>
      'Abuela Liu (刘奶奶), una cariñosa abuela del norte que te enseña a cerrar los pliegues de los dumplings y preparar el relleno de cerdo y cebolleta.';

  @override
  String get great => '¡Genial!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Banquete de dumplings caseros en Harbin';

  @override
  String get hanziCharacter => 'Hanzi (Carácter)';

  @override
  String get hapticFeedback => 'Respuesta háptica';

  @override
  String get helpAndSupport => 'Ayuda y soporte';

  @override
  String get hidden => 'Oculto';

  @override
  String get hideEnglishTranslations => 'Ocultar traducciones al inglés';

  @override
  String get hidePinyin => 'Ocultar Pinyin';

  @override
  String get highlight => 'RESALTAR';

  @override
  String get howWouldYouLikeToStudy => '¿Cómo te gustaría estudiar?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Intermedio alto';

  @override
  String get hsk5Advanced => 'HSK 5: Avanzado';

  @override
  String get hsk6Mastery => 'HSK 6: Dominio';

  @override
  String get hskCollections => 'Colecciones HSK';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'Simplificar subtítulos con HSK';

  @override
  String get hskVocabularyCollections => 'Colecciones de vocabulario HSK';

  @override
  String get i => 'Yo';

  @override
  String get ifTheAgain =>
      'Si la IA detecta una discrepancia, preguntará \'¿Querías decir...?\'. Puedes tocar el botón \'¡Sí, recaliíficame!\' para reevaluar instantáneamente tu audio original según tu verdadera intención sin tener que hablar de nuevo.';

  @override
  String get install => 'Instalar';

  @override
  String get just => 'Solo \$';

  @override
  String get keyword => 'Palabra clave';

  @override
  String get knowledgeBase => 'Base de conocimiento';

  @override
  String get liRuzhenSubjects =>
      'Li Ruzhen (c. 1763-1830) fue un erudito de la dinastía Qing con profundos intereses en fonología, ajedrez y cosmología. Flores en el espejo, su novela fantástica sobre un comerciante que viaja por reinos imposibles, es notable por sus temas feministas y su alcance enciclopédico.';

  @override
  String get library => 'Biblioteca Cultural (文化书房)';

  @override
  String get lifestyleAndVlog => 'Estilo de vida y vlogs';

  @override
  String get listenInAudiobookMode => 'Escuchar en modo audiolibro';

  @override
  String get listenToThisWord => 'Escuchar esta palabra';

  @override
  String get listening => 'Escuchando...';

  @override
  String get liuEEncroachment =>
      'Liu E (1857-1909) fue un polímata de finales de la dinastía Qing —ingeniero, médico y novelista— cuya única novela, Los viajes de Lao Can, es un lírico y comprometido relato de viajes de un médico errante a través de una China en pleno colapso dinástico e intervención extranjera.';

  @override
  String get loadingTranslations => 'Cargando traducciones...';

  @override
  String get luXunVernacular =>
      'Lu Xun (1881-1936), seudónimo de Zhou Shuren, es el padre de la literatura china moderna. Médico que pasó a la escritura para sanar el espíritu de su pueblo, sus colecciones de relatos —Diario de un loco y La verdadera historia de Ah Q— utilizaron la lengua vernácula (Baihua) para criticar la sociedad tradicional.';

  @override
  String get luoGuanzhongEpic =>
      'Luo Guanzhong (c. 1330-1400) fue un dramaturgo y novelista de la transición de Yuan a Ming, que se cree estudió bajo Shi Nai\'an. Su Romance de los Tres Reinos sintetizó crónicas históricas, tradición oral y narración dramática en la epopeya histórica china definitiva.';

  @override
  String get makeACustomCollection => 'Crear una colección personalizada';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Gestionar entregas diarias y recordatorios de repaso';

  @override
  String get managerYuOptions =>
      'Gerente Yu (余店长), una enérgica encargada de restaurante de hotpot que recomienda los callos de la casa, la sangre de pato y las opciones de caldo suave.';

  @override
  String get masterGaoRubs =>
      'Maestro Gao (高师傅), un carismático parrillero de carbón que bromea con los clientes sobre niveles de picante y adobos secretos de comino.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Domina esto para desbloquear su galaxia.';

  @override
  String get masterZhaoBrewing =>
      'Maestro Zhao (赵师傅), un paciente y experto sumiller de té al que le encanta explicar la preparación del té Gongfu.';

  @override
  String get mastery => 'Dominio';

  @override
  String get maybeLater => 'Quizás después';

  @override
  String get memes => 'Memes';

  @override
  String get midnightBbqSkewersInWuhan => 'Brochetas nocturnas en Wuhan';

  @override
  String get mo => '/mes';

  @override
  String get modernChinese => 'Chino moderno';

  @override
  String get monthly => 'Mensual';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Carro matutino de dim sum en Guangzhou';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get native => 'Nativo';

  @override
  String get newCard => 'Nueva tarjeta';

  @override
  String get newDeck => 'Nuevo mazo';

  @override
  String get newDeckName => 'Nombre del nuevo mazo';

  @override
  String get noActiveSubscriptionFound =>
      'No se encontró ninguna suscripción activa.';

  @override
  String get noEpisodesFound => 'No se encontraron episodios';

  @override
  String get noKeyWordsFoundForThisStory =>
      'No se encontraron palabras clave para esta historia.';

  @override
  String get noLabel => 'No';

  @override
  String get noNewWordsFound => '¡No se encontraron palabras nuevas!';

  @override
  String get noPinyin => 'Sin Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'No hay paquetes premium disponibles en este momento.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'No se encontraron resultados para \'$searchQuery\'';
  }

  @override
  String get noSavedArticlesYet => 'Aún no hay artículos guardados.';

  @override
  String get noShowsAvailable => 'No hay programas disponibles';

  @override
  String get noStoriesFound => 'No se encontraron historias.';

  @override
  String get noWordsSelected => 'No hay palabras seleccionadas';

  @override
  String get notes => 'Notas';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'OBJETIVOS';

  @override
  String get openInYoutube => 'Abrir en YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Pidiendo café de filtro en Shanghái';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Pidiendo brochetas de espino confitado (Tanghulu) en el invierno de Pekín';

  @override
  String partnerLang(String lang) {
    return 'Compañero ($lang)';
  }

  @override
  String get partnerListening => 'El compañero está escuchando...';

  @override
  String get partnerSpeaking => 'El compañero está hablando...';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get pause => 'Pausa';

  @override
  String get perfect => '¡Perfecto!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Una ruta personalizada basada en tu mazo.';

  @override
  String play(Object pinyin) {
    return 'Reproducir ($pinyin)';
  }

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Por favor, introduce un mensaje antes de enviarlo.';

  @override
  String get practiceInRoleplay => 'Practicar en juego de rol';

  @override
  String get practiceModes => 'Modos de práctica';

  @override
  String get practicePronouncingWithAiGrading =>
      'Practica la pronunciación de esta palabra con evaluación de IA';

  @override
  String get preparingReadingInterface =>
      'Preparando la interfaz de lectura...';

  @override
  String get privacy => 'Privacidad';

  @override
  String get privacyAndAudio => 'Privacidad y audio';

  @override
  String get puSonglingLiterature =>
      'Pu Songling (1640-1715) fue un escritor de la dinastía Qing que pasó décadas recopilando Cuentos extraños de un estudio chino tras suspender repetidamente los exámenes imperiales. Sus relatos sobrenaturales de espíritus zorro, fantasmas y eruditos siguen siendo la cumbre de la literatura fantástica china.';

  @override
  String get qaFaq => 'Preguntas frecuentes';

  @override
  String get questsTitle => 'MISIONES';

  @override
  String get quickBookmarks => 'Marcadores rápidos';

  @override
  String get radical => 'Radical';

  @override
  String get ready => 'Listo';

  @override
  String get readyToInterpret => 'Listo para interpretar';

  @override
  String get readyToStart => 'Listo para comenzar.';

  @override
  String get recentBookmarks => 'Marcadores recientes';

  @override
  String get refiningGrammar => 'Refinando gramática...';

  @override
  String get refresh => 'Actualizar';

  @override
  String get removeFromSaved => 'Eliminar de guardados';

  @override
  String get removeFromSavedScenarios => 'Eliminar de escenarios guardados';

  @override
  String get removed => 'Eliminado';

  @override
  String get requestPermissions => 'Solicitar permisos';

  @override
  String get rescind => 'Revocar';

  @override
  String get restore => 'Restaurar';

  @override
  String get results => 'Resultados';

  @override
  String get resume => 'Reanudar';

  @override
  String get retry => 'Reintentar';

  @override
  String get revenuecatError => 'Error de RevenueCat:';

  @override
  String revenuecatErrorE(String e) {
    return 'Error de RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'Revisar mazo extraído';

  @override
  String get reviewIn => 'Repasar en';

  @override
  String get reviewingYourTones => 'Revisando tus tonos...';

  @override
  String get saveAll => 'Guardar todo';

  @override
  String get saveScenario => 'Guardar escenario';

  @override
  String get saveThisScenario => 'Guardar este escenario';

  @override
  String get saved => 'Guardado';

  @override
  String get scanAnother => 'Escanear otro';

  @override
  String get scenarioRemoved => 'Escenario eliminado';

  @override
  String get scenarioSavedFindInCustomTab =>
      '¡Escenario guardado! Encuéntralo en la pestaña Personalizado.';

  @override
  String score(Object score, Object total) {
    return 'Puntuación: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'Buscar por pinyin o significado...';

  @override
  String get searchByTitleOrTag => 'Buscar por título o etiqueta...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Buscar en el diccionario o escribir término personalizado';

  @override
  String get searchHint => 'Buscar...';

  @override
  String get searchOrEnterUrl => 'Buscar o introducir URL';

  @override
  String get searchScenariosHint => 'Buscar escenarios...';

  @override
  String get searchStoriesIdiomsNews =>
      'Buscar historias, modismos, noticias...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Buscar temas (ej.: Cocina, Historia)';

  @override
  String get seeAll => 'Ver todo';

  @override
  String get selectADeck => 'Seleccionar un mazo';

  @override
  String get selectPracticeMode => 'Seleccionar modo de práctica';

  @override
  String get selectingHskVocabulary => 'Seleccionando vocabulario HSK...';

  @override
  String get send => 'Enviar';

  @override
  String get sendMessage => 'Enviar mensaje';

  @override
  String get serif => 'Serifa';

  @override
  String get shadow => 'Shadowing';

  @override
  String get shiNaianEpic =>
      'Shi Nai\'an (c. 1296-1372) fue un literato de la dinastía Yuan que, según los registros, aprobó el examen imperial pero eligió una vida de retiro erudito. A la orilla del agua, su obra maestra sobre forajidos heroicos y rebelión justa, estableció el arquetipo de la épica marcial china.';

  @override
  String get showEnglish => 'Mostrar inglés';

  @override
  String get showEnglishTranslations => 'Mostrar traducciones al inglés';

  @override
  String get showHanzi => 'Mostrar Hanzi';

  @override
  String get showPinyin => 'Mostrar Pinyin';

  @override
  String get showTranslation => 'Mostrar traducción';

  @override
  String get shows => 'Programas';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get simplifiedArticle => 'Artículo simplificado';

  @override
  String get simplifyingSubtitles => 'Simplificando subtítulos...';

  @override
  String get sincereHonest => 'sincero; honesto';

  @override
  String get sleepTimer => 'Temporizador de apagado';

  @override
  String get smartDeck => 'Mazo inteligente';

  @override
  String get spanishAndWorld => 'Español y mundial';

  @override
  String get speaker => 'Altavoz';

  @override
  String get spotifyStylePlayer => 'Reproductor estilo Spotify';

  @override
  String get storyBookmarkedInLibrary => '¡Historia guardada en la biblioteca!';

  @override
  String get streetFoodNightMarketInXian =>
      'Mercado nocturno de comida callejera en Xi\'an';

  @override
  String get strokes => 'Trazos';

  @override
  String get studyCharacter => 'Estudiar carácter';

  @override
  String get subtitleOpacity => 'Opacidad de subtítulos';

  @override
  String get suggestion => 'Sugerencia';

  @override
  String get summary => 'Resumen';

  @override
  String get supernaturalAndFolklore => 'Sobrenatural y folclore';

  @override
  String get swipeToGrade => 'Desliza para calificar:';

  @override
  String get tableOfContents => 'Índice de contenidos';

  @override
  String get tapToRetry => 'Toca para reintentar';

  @override
  String get teaTastingInChengdu => 'Cata de té en Chengdu';

  @override
  String get techAndGadgets => 'Tecnología y dispositivos';

  @override
  String get terms => 'Términos de servicio';

  @override
  String get theGalaxyCharacters =>
      'El mapa galáctico te espera.\nDomina los Soles (Radicales) para desbloquear los Planetas (Caracteres).';

  @override
  String get theme => 'Tema';

  @override
  String get thinking => 'Pensando...';

  @override
  String get thisArticleCharacters =>
      'Este artículo contiene caracteres chinos tradicionales.';

  @override
  String get todaysWord => 'PALABRA DE HOY';

  @override
  String get togglePinyin => 'Alternar Pinyin';

  @override
  String get toggleTranslation => 'Alternar traducción';

  @override
  String get toneDoesNotExistInMandarin =>
      'Este tono no existe en mandarín estándar.';

  @override
  String get toneGraph => 'Gráfico de tonos';

  @override
  String get traceLabel => 'Trazar';

  @override
  String get trailer => 'TRAILER';

  @override
  String get translatingAndAddingPinyin => 'Traduciendo y añadiendo Pinyin...';

  @override
  String get translatingText => 'Traduciendo texto...';

  @override
  String get turnOn => 'Activar';

  @override
  String get typeHanziPinyinOrEnglish => 'Escribe Hanzi, Pinyin o español...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Desenrollando el pergamino...';

  @override
  String get upperIntermediate => 'Intermedio alto';

  @override
  String get vibrationsForInteractions => 'Vibraciones al interactuar';

  @override
  String get video => 'Vídeo';

  @override
  String get viewAnswer => 'Ver respuesta';

  @override
  String get viewAsList => 'Ver como lista';

  @override
  String get viewBookmarks => 'Ver marcadores';

  @override
  String get viewMyDrawing => 'Ver mi dibujo';

  @override
  String get vlog => '中国 日常 vlog';

  @override
  String get voice => 'Voz:';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou => 'Nos encantaría\nsaber de ti.';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get whatDoesThisMean => '¿Qué significa esto?';

  @override
  String get whatHappensToMyChatHistory =>
      '¿Qué pasa con mi historial de chat?';

  @override
  String get whatIfAiMishears =>
      '¿Qué pasa si la IA entiende mal lo que quise decir?';

  @override
  String get whichCharacterIs => '¿Qué carácter es:';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled =>
      '¡Palabras guardadas y repaso espaciado (SRS) programado!';

  @override
  String get writeYourMessageHere => 'Escribe tu mensaje aquí...';

  @override
  String get wuChengenLiterature =>
      'Wu Cheng\'en (c. 1500-1582) fue un novelista de la dinastía Ming de Huai\'an, Jiangsu. Basándose en décadas de folclore, alegoría budista e ingenio satírico, tejió la mitología de la peregrinación Tang en Viaje al Oeste, una de las obras más imaginativas y queridas de la literatura universal.';

  @override
  String get wuJingziClass =>
      'Wu Jingzi (1701-1754) fue un novelista de la dinastía Qing de Anhui que renunció a su fortuna heredada y dedicó su vida a escribir Los eruditos (Rulin Waishi), una mordaz novela satírica que expone la vanidad, corrupción y absurdidad del sistema de exámenes imperiales y la clase letrada.';

  @override
  String get xuZhonglinWarfare =>
      'Xu Zhonglin (fl. s. XVI-XVII) fue un autor de la dinastía Ming a quien se atribuye la compilación de La investidura de los dioses (Fengshen Yanyi), una obra monumental de ficción mitológica que combina la historia Shang-Zhou con la cosmología taoísta, la burocracia celestial y la épica heroica.';

  @override
  String get yearly => 'Anual';

  @override
  String get yesReGradeMe => '¡Sí, recaliíficame!';

  @override
  String you(Object lang) {
    return 'Tú ($lang)';
  }

  @override
  String get youAreSpeaking => 'Estás hablando';

  @override
  String get youLabel => 'Tú';

  @override
  String youLang(String lang) {
    return 'Tú ($lang)';
  }

  @override
  String get youMustAccount =>
      'Debes aceptar los Términos de servicio y la Política de privacidad para crear una cuenta.';

  @override
  String get yourEchoModels =>
      'Tus conversaciones de Echo Hall se almacenan localmente en tu dispositivo para que puedas revisarlas en cualquier momento. No usamos tus conversaciones personales para entrenar nuestros modelos de IA.';

  @override
  String get zhOnly => 'Solo chino (ZH)';

  @override
  String get hsk_1300_cards => '1300 tarjetas';

  @override
  String get hsk_154_cards => '154 tarjetas';

  @override
  String get hsk_162_cards => '162 tarjetas';

  @override
  String get hsk_2500_cards => '2500 tarjetas';

  @override
  String get hsk_299_cards => '299 tarjetas';

  @override
  String get hsk_602_cards => '602 tarjetas';

  @override
  String get added_to_review_queue => 'Añadido a la cola de repaso';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'Se añadieron $cardCount tarjetas a «$deckName».';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '«$hanzi» añadido a tu biblioteca';
  }

  @override
  String get advanced => 'Avanzado';

  @override
  String get ai_stories => 'Historias con IA';

  @override
  String analysis_failed(Object error) {
    return 'Análisis fallido: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Analizando pronunciación con IA Gemini...';

  @override
  String get analyzing_your_pronunciation => 'Analizando tu pronunciación...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return '¿Seguro que quieres borrar permanentemente «$deckName»? Esta acción no se puede deshacer y eliminará todas las tarjetas de su interior.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Preguntar sobre $hanzi...';
  }

  @override
  String get audio_haptics => 'Audio y respuesta háptica';

  @override
  String get audio_could_not_start_check_your =>
      'No se pudo iniciar el audio. Comprueba tu conexión y los ajustes de voz del dispositivo.';

  @override
  String get calligraphy_trace => 'Trazo de caligrafía';

  @override
  String chapters(Object count) {
    return '$count capítulos';
  }

  @override
  String get char => 'Carácter';

  @override
  String get chinese_character => 'CARÁCTER CHINO';

  @override
  String get contact_us_and_report_issues =>
      'Contáctanos e informa de problemas';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return '¡Mazo inteligente creado: «$deckName» con $wordCount palabras!';
  }

  @override
  String get custom_ai_generated_story =>
      'Historia personalizada generada por IA.';

  @override
  String get display_content => 'Pantalla y contenido';

  @override
  String get do_you_keep_or_store_my =>
      '¿Guardan o almacenan mis grabaciones de voz?';

  @override
  String get elementary => 'Elemental';

  @override
  String error_creating_scenario(Object error) {
    return 'Error al crear el escenario: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Error al obtener la traducción: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Error al cargar capítulos: $error';
  }

  @override
  String get error_loading_decks => 'Error al cargar los mazos';

  @override
  String error_loading_microreads(Object error) {
    return 'Error al cargar microlecturas: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Error al cargar novelas: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Error al cargar poesía: $error';
  }

  @override
  String get etymology => 'Etimología: ';

  @override
  String get explanation => 'Explicación';

  @override
  String get extracted_text_tap_to_lookup =>
      'Texto extraído (toca para consultar)';

  @override
  String extraction_failed(Object error) {
    return 'Extracción fallida: $error';
  }

  @override
  String get failed_to_download => 'Error al descargar.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Error al generar el escenario: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Error al generar la historia:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Error al cargar el contexto: $error';
  }

  @override
  String get feature_request => 'Sugerir función';

  @override
  String get foundation => 'Fundamentos';

  @override
  String get how_is_my_pronunciation_scored =>
      '¿Cómo se evalúa mi pronunciación?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'Vocabulario HSK $hskLevel';
  }

  @override
  String get hsk_level => 'NIVEL HSK';

  @override
  String get intermediate => 'Intermedio';

  @override
  String get learning_stats => 'Estadísticas de aprendizaje';

  @override
  String get mandarin => 'Mandarín';

  @override
  String get meaning => 'Significado';

  @override
  String get no_decks_found => 'No se encontraron mazos.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'No se encontraron resultados para «$searchQuery»';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'No. Cuando usas Echo Hall, Veredicto del Erudito o Estudio de Shadowing, tu audio se evalúa de forma segura en tiempo real para generar una puntuación de pronunciación y se descarta inmediatamente después. Solo almacenamos tus calificaciones numéricas para registrar tu progreso.';

  @override
  String get notification_settings => 'Configuración de notificaciones';

  @override
  String get open_settings => 'Abrir Ajustes';

  @override
  String get phoneme => 'Fonema';

  @override
  String get play_reference_pronunciation =>
      'Reproducir pronunciación de referencia';

  @override
  String get please_select_a_deck_to_add =>
      'Por favor, selecciona un mazo para añadir tarjetas.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Apunta al texto en chino para traducirlo';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Practica escribir los trazos a mano';

  @override
  String get preferences_audio_and_display => 'Preferencias, audio y pantalla';

  @override
  String get preparing_your_scholars_verdict =>
      'Preparando el veredicto del Erudito...';

  @override
  String get previous => 'Anterior';

  @override
  String question(Object current, Object total) {
    return 'Pregunta $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return '¿Eliminar «$hanzi» de este mazo?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'Error de RevenueCat: $error';
  }

  @override
  String get review_tomorrow => 'Repasar mañana';

  @override
  String get roleplay => 'Juego de rol';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Guardando $wordCount palabras en «$deckName»...';
  }

  @override
  String get search_radicals_eg_water => 'Buscar radicales (ej.: Agua, 氵)';

  @override
  String get select_target_hsk_level => 'Selecciona el nivel HSK objetivo';

  @override
  String get sentence => 'Frase';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'El Estudio de Shadowing es un espacio dedicado a practicar la imitación del habla nativa en tiempo real.';

  @override
  String simplify_failed(Object error) {
    return 'Error al simplificar: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Expresión oral y pronunciación';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get table_of_contents => 'Índice de contenidos · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'La IA evalúa tu habla en tres aspectos:\n• Precisión: ¿articulaste las sílabas correctas?\n• Integridad: ¿omitiste o pasaste por alto alguna palabra?\n• Fluidez: ¿hiciste pausas naturales y empleaste los tonos adecuados?\nCompara tu audio con modelos nativos para generar una puntuación sobre 100.';

  @override
  String get this_cannot_be_undone => 'Esta acción no se puede deshacer.';

  @override
  String get title => 'Título';

  @override
  String get to_be_reviewed => 'Pendientes de repaso';

  @override
  String get traditional => 'Tradicional';

  @override
  String translation_failed(Object error) {
    return 'Error de traducción: $error';
  }

  @override
  String get type_in => 'Escribir...';

  @override
  String get type_your_message_in => 'Escribe tu mensaje en...';

  @override
  String get unable_to_open_this_video_please =>
      'No se pudo abrir este vídeo. Por favor, inténtalo de nuevo más tarde.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Ver tu historial de aprendizaje y rachas';

  @override
  String get what_is_shadowing_studio => '¿Qué es el Estudio de Shadowing?';

  @override
  String get words => 'palabras';

  @override
  String your_path_for_is_ready(String deckName) {
    return '¡Tu ruta para «$deckName» está lista!';
  }

  @override
  String get you_said => '🗣️ Pronunciaste';

  @override
  String vocabularyBatch(Object index) {
    return 'Lote de vocabulario $index';
  }

  @override
  String get yourDailyDropIsHere => '¡Tu entrega diaria ya está aquí! ✨';

  @override
  String get timeToReview => '¡Hora de repasar! 📚';

  @override
  String get neverMissAStroke => '¡No te pierdas ningún trazo! 🖌️';

  @override
  String get yourTrialEndsTomorrow => '¡Tu periodo de prueba termina mañana! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Niveles oficiales de vocabulario estándar';

  @override
  String get failedToLoadCollections =>
      'No se pudieron cargar las colecciones.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Error: $error';
  }

  @override
  String get aiSmartContext => 'Contexto inteligente de IA';

  @override
  String get aiSmartContextError => 'Error del contexto inteligente de IA';

  @override
  String get downloadOfficialHskCollections =>
      'Descargar colecciones oficiales de HSK';

  @override
  String get unableToLoadThisSection =>
      'No se pudo cargar esta sección. Por favor, inténtalo de nuevo.';

  @override
  String get translationLanguage => 'Idioma de traducción';

  @override
  String get dailyDrops => 'Entregas diarias';

  @override
  String get wordOfTheDayNews => 'Palabra del día y noticias';

  @override
  String get reviewReminders => 'Recordatorios de repaso';

  @override
  String get flashcardsDueForReview => 'Tarjetas pendientes de repaso';

  @override
  String get dailyNewCards => 'Tarjetas nuevas diarias';

  @override
  String get dailyReviewLimit => 'Límite de repaso diario';

  @override
  String get practiceMode => 'Modo de práctica';

  @override
  String get liziqi => 'Li Ziqi (李子柒): Flores de seda';

  @override
  String get theLifeOfGarlicTraditional =>
      'La vida del ajo: vida tradicional china';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 frases';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Frases esenciales en chino para principiantes';

  @override
  String get makingBambooFurniture => 'Fabricación de muebles de bambú';

  @override
  String get peppaPigChinese => 'Peppa Pig en chino: El escondite';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'Charcos de barro (Nivel principiante)';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 verbos';

  @override
  String get mostCommonChineseVerbs => 'Los verbos chinos más comunes';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Pedir comida';

  @override
  String get howToOrderFoodIn => 'Cómo pedir comida en un restaurante chino';

  @override
  String get silkFlowersTraditionalCraft =>
      'Flores de seda: artesanía tradicional';

  @override
  String get mandarinCorner => 'Mandarin Corner: En el médico';

  @override
  String get goingToTheDoctorReal =>
      'Ir al médico: conversación de la vida real';

  @override
  String get hideAndSeekBeginnerFriendly => 'El escondite (Nivel principiante)';

  @override
  String get linGdp6 =>
      'Xiao Lin explica: ¿Por qué el crecimiento del PIB es del 6%?';

  @override
  String get why6GdpGrowthEasy =>
      '¿Por qué un crecimiento del PIB del 6%? - Economía china fácil';

  @override
  String get bbcWorldNews => 'BBC 中文 (Noticias mundiales)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Actualidad en chino simplificado';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'ESCRITORIO DE YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'Transcripciones interactivas y shadowing';

  @override
  String get showsDramas => 'SERIES Y DRAMAS';

  @override
  String get extractToDeck => 'Extraer al mazo';

  @override
  String get autoSimplify => 'Simplificación automática';

  @override
  String get rewriteThisArticleToMatch =>
      'Reescribe este artículo para adaptarlo a tu nivel HSK';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'No se pudieron guardar las palabras extraídas: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Añadir al mazo ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Entrega de descubrimiento diario';

  @override
  String get smartSpacedRepetition => 'Repetición espaciada inteligente';

  @override
  String get trialProtectionAlert => 'Alerta de protección de prueba';

  @override
  String get masteryLevel => 'Nivel de dominio';

  @override
  String get targetObjective => 'Objetivo';

  @override
  String get dailyPractice => 'Práctica diaria';

  @override
  String get aiSpacedRepetition => 'Repetición espaciada con IA';

  @override
  String get iVeGrantedAccess => 'He concedido acceso';

  @override
  String get scanner => 'Escáner';

  @override
  String get interpreter => 'Intérprete';

  @override
  String cards(Object count) {
    return '$count tarjetas';
  }

  @override
  String get nWaMendsTheHeavens => 'Nüwa repara los cielos';

  @override
  String get terracottaArmy => 'Guerreros de terracota';

  @override
  String get forbiddenCity => 'La Ciudad Prohibida';

  @override
  String get aBlessingInDisguise => 'No hay mal que por bien no venga';

  @override
  String get drawingASnake =>
      'Dibujar patas a una serpiente (Hacer algo superfluo)';

  @override
  String get takingTheBulletTrain => 'Viajar en el tren de alta velocidad';

  @override
  String get visitingTheDoctor => 'Ir al médico';

  @override
  String get orderingDumplings => 'Pedir jiaozi (dumplings)';

  @override
  String get theTeaCeremony => 'La ceremonia del té';

  @override
  String get chineseCalligraphy => 'Caligrafía china';

  @override
  String get theGiantPanda => 'El panda gigante';

  @override
  String get simplifiedText => 'Texto simplificado';

  @override
  String get novels96 => 'Novelas (96)';

  @override
  String get microReads => 'Microlecturas';

  @override
  String get poetry => 'Poesía';

  @override
  String get bookmarkRemoved => '书签已移除 · Marcador eliminado';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Marcador añadido: Capítulo $chapter';
  }

  @override
  String get readingVocabulary => 'Lectura y vocabulario';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Lote de vocabulario $index';
  }

  @override
  String get yourDailyDropIsHere1 => '¡Tu entrega diaria ya está aquí! ✨';

  @override
  String get timeToReview1 => '¡Hora de repasar! 📚';

  @override
  String get neverMissAStroke1 => '¡No te pierdas ningún trazo! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 =>
      '¡Tu periodo de prueba termina mañana! ⏳';

  @override
  String get hskCollections1 => 'Colecciones HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Niveles oficiales de vocabulario estándar';

  @override
  String get failedToLoadCollections1 =>
      'No se pudieron cargar las colecciones.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Reproducir $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Error: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'Contexto inteligente de IA';

  @override
  String get aiSmartContextError1 => 'Error del contexto inteligente de IA';

  @override
  String errorErr(Object err, Object error) {
    return 'Error: $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Descargar colecciones oficiales de HSK';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'No se pudo cargar esta sección. Por favor, inténtalo de nuevo.';

  @override
  String get searchRadicalsEgWater => 'Buscar radicales (ej.: Agua, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Idioma de traducción';

  @override
  String get appLanguage1 => 'Idioma de la aplicación';

  @override
  String get dailyDrops1 => 'Entregas diarias';

  @override
  String get wordOfTheDayNews1 => 'Palabra del día y noticias';

  @override
  String get reviewReminders1 => 'Recordatorios de repaso';

  @override
  String get flashcardsDueForReview1 => 'Tarjetas pendientes de repaso';

  @override
  String get accuracyByMode1 => 'Precisión por modo';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => 'Próximos repasos (próximos 7 días)';

  @override
  String get explaining => 'Explicación:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Tarjetas nuevas diarias';

  @override
  String get dailyReviewLimit1 => 'Límite de repaso diario';

  @override
  String get listeningMode1 => 'Modo escucha';

  @override
  String get readingMode1 => 'Modo lectura';

  @override
  String get recallMode1 => 'Modo evocación mental';

  @override
  String get speakingMode1 => 'Modo habla';

  @override
  String get practiceMode1 => 'Modo de práctica';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'Interlocutor';

  @override
  String get partnerSpeaking1 => 'El interlocutor está hablando…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'La vida del ajo: vida tradicional china';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 frases';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Frases esenciales en chino para principiantes';

  @override
  String get makingBambooFurniture1 => 'Fabricación de muebles de bambú';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Charcos de barro (Nivel principiante)';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 verbos';

  @override
  String get mostCommonChineseVerbs1 => 'Verbos chinos más comunes';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Pedir comida';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Cómo pedir comida en un restaurante chino';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Flores de seda: artesanía tradicional';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Ir al médico: conversación de la vida real';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'El escondite (Nivel principiante)';

  @override
  String get lingdp6 =>
      'Xiao Lin explica: ¿Por qué el crecimiento del PIB es del 6%?';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      '¿Por qué un crecimiento del PIB del 6%? - Economía china fácil';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Actualidad en chino simplificado';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'ESCRITORIO DE YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Transcripciones interactivas y shadowing';

  @override
  String get showsDramas1 => 'SERIES Y DRAMAS';

  @override
  String error_error(Object error) {
    return 'Error: $error';
  }

  @override
  String get extractToDeck1 => 'Extraer al mazo';

  @override
  String get autosimplify => 'Simplificación automática';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Reescribe este artículo para adaptarlo a tu nivel HSK';

  @override
  String get addToDeck1 => 'Añadir al mazo';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Entrega de descubrimiento diario';

  @override
  String get smartSpacedRepetition1 => 'Repetición espaciada inteligente';

  @override
  String get trialProtectionAlert1 => 'Alerta de protección de prueba';

  @override
  String get masteryLevel1 => 'Nivel de dominio';

  @override
  String get targetObjective1 => 'Objetivo';

  @override
  String get dailyPractice1 => 'Práctica diaria';

  @override
  String get aiSpacedRepetition1 => 'Repetición espaciada con IA';

  @override
  String get iveGrantedAccess => 'He concedido acceso';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Añadir al mazo ($count)';
  }

  @override
  String get scanner1 => 'Escáner';

  @override
  String get interpreter1 => 'Intérprete';

  @override
  String entryvalueCards(Object count) {
    return '$count tarjetas';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Puntuación: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'El Rey Mono';

  @override
  String get huaMulan1 => 'Hua Mulan';

  @override
  String get nwaMendsTheHeavens => 'Nüwa repara los cielos';

  @override
  String get confucius => 'Confucio';

  @override
  String get theGreatWall1 => 'La Gran Muralla';

  @override
  String get terracottaArmy1 => 'Guerreros de terracota';

  @override
  String get forbiddenCity1 => 'La Ciudad Prohibida';

  @override
  String get aBlessingInDisguise1 => 'No hay mal que por bien no venga';

  @override
  String get drawingASnake1 => 'Dibujar patas a una serpiente';

  @override
  String get takingTheBulletTrain1 => 'Viajar en el tren de alta velocidad';

  @override
  String get visitingTheDoctor1 => 'Ir al médico';

  @override
  String get orderingDumplings1 => 'Pedir jiaozi (dumplings)';

  @override
  String get theTeaCeremony1 => 'La ceremonia del té';

  @override
  String get chineseCalligraphy1 => 'Caligrafía china';

  @override
  String get theGiantPanda1 => 'El panda gigante';

  @override
  String get simplifiedText1 => 'Texto simplificado';

  @override
  String get novels961 => 'Novelas (96)';

  @override
  String get microreads => 'Microlecturas';

  @override
  String get poetry1 => 'Poesía';

  @override
  String get readingVocabulary1 => 'Lectura y vocabulario';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions no se han configurado para Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions no son compatibles con esta plataforma.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'Los trazos no pueden estar vacíos.';

  @override
  String get wrongStartPoint => 'Punto de inicio incorrecto.';

  @override
  String get rightShapeButWrongPlace =>
      '¡Forma correcta, pero posición equivocada!';

  @override
  String get goodFollowTheFlow => '¡Bien! Sigue el flujo del trazo.';

  @override
  String get aBitShaky => '¡Un poco tembloroso!';

  @override
  String get aBitHesitant => 'Un poco dubitativo...';

  @override
  String get shapeIsOff => 'La forma no es del todo correcta.';

  @override
  String get arabic => 'Árabe';

  @override
  String get german => 'Alemán';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Francés';

  @override
  String get hindi => 'Hindi';

  @override
  String get indonesian => 'Indonesio';

  @override
  String get italian => 'Italiano';

  @override
  String get japanese => 'Japonés';

  @override
  String get korean => 'Coreano';

  @override
  String get portuguese => 'Portugués';

  @override
  String get russian => 'Ruso';

  @override
  String get vietnamese => 'Vietnamita';

  @override
  String get microphonePermissionDenied => 'Permiso de micrófono denegado';

  @override
  String get offset => 'Desplazamiento';

  @override
  String get audioserviceHasBeenDisposed =>
      'El servicio de audio (AudioService) ha sido cerrado';

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
  String get kore => 'Kore (femenina, cálida)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Palabra ancla';

  @override
  String get creativeThematicTitle => 'Título temático creativo';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Breve justificación pedagógica o semántica';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'El carácter más representativo de la lista';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Una selección equilibrada de caracteres de tu biblioteca.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Tu respuesta conversacional natural en caracteres chinos.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'La traducción al español de tu respuesta.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'El Pinyin con marcas de tono para tu respuesta.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Una respuesta sugerida que el usuario podría decirte.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin para la sugerencia.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Traducción al español de la sugerencia.';

  @override
  String get scholarsCritique => 'Evaluación del Erudito';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'La Sala del Eco permanece en silencio. Toma aire e inténtalo de nuevo.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'Ninguno todavía.';

  @override
  String get exactSentence => 'Frase exacta:';

  @override
  String get englishTranslation => 'Traducción';

  @override
  String get previouslyGeneratedPhrases => 'Frases generadas previamente';

  @override
  String get iLikeDrinkingAppleJuice => 'Me gusta beber zumo de manzana.';

  @override
  String get theEnglishMeaningHere => 'El significado aquí...';

  @override
  String get failedToFetchDefinition => 'Error al obtener la definición.';

  @override
  String get failedToLoadExplanation => 'Error al cargar la explicación.';

  @override
  String get failedToLoadComparison => 'Error al cargar la comparación.';

  @override
  String get emptyResponseFromOpenrouter => 'Respuesta vacía de OpenRouter';

  @override
  String get emptyResponseFromVisionModel =>
      'Respuesta vacía del modelo Vision';

  @override
  String get standard => 'Estándar';

  @override
  String get theFullSentenceInChinese => 'La frase completa en chino...';

  @override
  String get theWordOrCharacterInChinese => 'La palabra o carácter en chino';

  @override
  String get thePinyinForThisSpecificWord =>
      'El Pinyin para esta palabra específica';

  @override
  String get emptyResponseFromDeepseekApi =>
      'Respuesta vacía de la API de DeepSeek';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'IMPORTANTE: Coloca la traducción al español en';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Traducción al español de la frase completa';

  @override
  String get hanziWord => 'Palabra Hanzi';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'La frase completa en chino simplificado...';

  @override
  String get lyingFlatACulturalMovement =>
      'Tang Ping (Tumbarse): Un movimiento cultural...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'El usuario con el que estás hablando se llama';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'REGLA IMPORTANTE: No te dirijas al usuario por ningún nombre. Nunca uses nombres de marcador de posición como';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Eres un tutor conciso de caligrafía y etimología china en una aplicación móvil de tarjetas de estudio.';

  @override
  String get theStudentIsStudyingTheCharacter =>
      'El estudiante está aprendiendo el carácter';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Nunca escribas introducciones, despedidas o frases de relleno como';

  @override
  String get beDirectAndInformative => 'Sé directo e informativo.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'REGLA CRÍTICA: Debes responder COMPLETAMENTE en el idioma correspondiente al código ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Eres un tutor conciso de gramática china en una aplicación móvil.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'El estudiante tiene dudas sobre la palabra';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Nunca escribas introducciones, despedidas o frases de relleno.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Faltan las claves de la API de voz de Azure.';

  @override
  String get success => 'Éxito';

  @override
  String get granularity => 'Nivel de detalle';

  @override
  String get phoneme1 => 'Fonema';

  @override
  String get dimension => 'Dimensión';

  @override
  String get comprehensive => 'Integral';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'No pudimos escucharte con claridad. Por favor, inténtalo de nuevo.';

  @override
  String get noNbestResultFound =>
      'No se encontró ningún resultado de reconocimiento óptimo (NBest).';

  @override
  String get words1 => 'Palabras';

  @override
  String get word => 'Palabra';

  @override
  String get phonemes => 'Fonemas';

  @override
  String get syllables => 'Sílabas';

  @override
  String get syllable => 'Sílaba';

  @override
  String get omission => 'Omisión';

  @override
  String get insertion => 'Inserción';

  @override
  String get youMissedThisWord => 'Omitiste esta palabra.';

  @override
  String get extraWordAddedHere => 'Se añadió una palabra adicional aquí.';

  @override
  String get mispronunciation => 'Pronunciación incorrecta';

  @override
  String get pronunciationWasInaccurate => 'La pronunciación fue imprecisa.';

  @override
  String get goodEffortKeepPracticing => '¡Buen intento! Sigue practicando.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      '¡Pronunciación perfecta! Suenas como un nativo.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      '¡Gran trabajo! Solo algunas pequeñas imprecisiones en los tonos.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'No está mal, pero tus tonos necesitan un poco más de práctica.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      '¡Sigue practicando! Escucha el audio nativo y vuelve a intentarlo.';

  @override
  String get lexical => 'Léxico';

  @override
  String get chineseHanziHere => 'Hanzi chino aquí';

  @override
  String get aShortSummaryInEnglish => 'Un breve resumen en español';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'No se encontró texto en chino legible en el escaneo.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'La traducción completa al español del texto escaneado... O \'No se encontró texto en chino legible.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Un título breve de 2 a 4 palabras para este escaneo (ej.: \'Menú de restaurante\', \'Señal de tráfico\')';

  @override
  String get china => 'China';

  @override
  String get noTranslationAvailable => 'No hay traducción disponible.';

  @override
  String get scanResults => 'Resultados del escaneo';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      '¿Cuándo fue escrito y qué sucedía en China en ese momento?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      '¿Por qué es famosa esta obra? ¿Qué temas filosóficos o culturales aborda?';

  @override
  String get aBriefBioOfTheAuthor => 'Una breve biografía del autor.';

  @override
  String get informationUnavailable => 'Información no disponible.';

  @override
  String get noSummaryAvailable => 'No hay resumen disponible.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'Prueba, Normal, Introducción';

  @override
  String get dailyDrop => 'Entrega diaria';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Notificaciones diarias para la palabra del día y noticias';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      '¡Una nueva palabra e historia del día te están esperando!';

  @override
  String get spacedRepetition => 'Repetición espaciada';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Recordatorios para tarjetas pendientes de repaso';

  @override
  String get engagementReminders => 'Recordatorios de actividad';

  @override
  String get trialReminders => 'Recordatorios del periodo de prueba';

  @override
  String get notificationsForYourTrialStatus =>
      'Notificaciones sobre el estado de tu prueba';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      '¡Ven a repasar tus Hanzi y prueba una llamada en directo antes de que termine tu acceso gratuito!';

  @override
  String get scholarsEye => 'Mirada del Erudito';

  @override
  String get clMeasureWord => 'Clasificador / Contador (CL):';

  @override
  String get surnameShi => 'Apellido Shi';

  @override
  String get chineseFamilyNameShi => 'Apellido chino (Shi)';

  @override
  String get neutralToneLight => 'Tono neutro (ligero)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Mantén el tono alto y constante, como si cantaras una nota sostenida.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Comienza en un tono medio y elévalo hacia arriba, como al preguntar \'¿Qué?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Baja el tono de tu voz y luego elévalo suavemente.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Haz caer el tono de forma brusca y tajante, como un \'¡No!\' categórico.';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Pronuncia de forma suave, breve y sin énfasis.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      '¡Perfecto! El tono fue alto, plano y sostenido.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      '¡Perfecto! La elevación del tono fue clara.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      '¡Perfecto! La curva descendente y ascendente fue precisa.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      '¡Perfecto! La caída tajante fue decidida y clara.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      '¡Perfecto! El tono se pronunció con exactitud.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Acepto los Términos de servicio y la Política de privacidad.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Enviarme actualizaciones periódicas, consejos y ofertas.';

  @override
  String get signInToSyncYourProgress =>
      'Inicia sesión para sincronizar tu progreso.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Crea una cuenta para guardar tus estadísticas.';

  @override
  String get smartSpiral => 'ESPIRAL INTELIGENTE';

  @override
  String get origin => 'Origen';

  @override
  String get elements => 'Elementos';

  @override
  String get humanity => 'Humanidad';

  @override
  String get village => 'Aldea';

  @override
  String get journey => 'Viaje';

  @override
  String get city => 'Ciudad';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Las formas más simples. El principio de todas las cosas.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Sol, Luna, Agua y Fuego. El mundo natural.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'El cuerpo, el corazón y la familia.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Campos, tejados y herramientas. Los cimientos de la sociedad.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Movimiento, habla y sustento.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Comercio, vestimenta y artefactos complejos.';

  @override
  String get equilibriumAlgorithm => 'Algoritmo de equilibrio';

  @override
  String get misc => 'Varios';

  @override
  String get cityOrOriginAs => '«Ciudad» u «Origen» como';

  @override
  String get miscToOrigin => '«Varios» a «Origen»';

  @override
  String get constellation => 'Constelación';

  @override
  String get whichOneIsWater => '¿Cuál de estos significa \'Agua\'?';

  @override
  String get whatIsThePinyin => '¿Cuál es el Pinyin?';

  @override
  String get nature => 'Naturaleza';

  @override
  String get whatEssenceDoes => '¿Qué esencia tiene';

  @override
  String get allTiers => 'Todos los niveles';

  @override
  String get active => 'Activo';

  @override
  String get theScrollOfOrigin1 => 'EL PERGAMINO DEL ORIGEN';

  @override
  String galaxyOf1(Object name) {
    return 'GALAXIA DE $name';
  }

  @override
  String get also => 'También';

  @override
  String get work => 'Trabajo';

  @override
  String get cloud => 'Nube';

  @override
  String get youArchaic => 'Tú (arcaico)';

  @override
  String get suddenly => 'De repente';

  @override
  String get owner => 'Dueño';

  @override
  String get door => 'Puerta';

  @override
  String get occupy => 'Ocupar';

  @override
  String get nail => 'Clavo';

  @override
  String get and => 'Y';

  @override
  String get buddhistNun => 'Monja budista';

  @override
  String get anxious => 'Inquieto';

  @override
  String get sprout => 'Brote';

  @override
  String get exchange => 'Intercambiar';

  @override
  String get sheep => 'Oveja';

  @override
  String get strange => 'Extraño';

  @override
  String get opposite => 'Opuesto';

  @override
  String get shorttailedBird => 'Pájaro de cola corta';

  @override
  String get shoot => 'Brote / Disparo';

  @override
  String get small => 'Pequeño';

  @override
  String get gather => 'Reunir';

  @override
  String get order => 'Orden';

  @override
  String get flat => 'Plano';

  @override
  String get thePersonWho => 'La persona que...';

  @override
  String get nobleman => 'Noble';

  @override
  String get cause => 'Causa';

  @override
  String get pig => 'Cerdo';

  @override
  String get bright => 'Brillante';

  @override
  String get slowly => 'Lentamente';

  @override
  String get give => 'Dar';

  @override
  String get arrow => 'Flecha';

  @override
  String get dry => 'Seco';

  @override
  String get obstacle => 'Obstáculo';

  @override
  String get beg => 'Rogar';

  @override
  String get window => 'Ventana';

  @override
  String get fear => 'Miedo';

  @override
  String get drum => 'Tambor';

  @override
  String get why => 'Por qué';

  @override
  String get talent => 'Talento';

  @override
  String get follow => 'Seguir';

  @override
  String get desert => 'Desierto';

  @override
  String get component => 'Componente';

  @override
  String divingInto1(Object topic) {
    return 'Sumergiéndonos en $topic';
  }

  @override
  String get unitIntro1 => 'Introducción de la unidad';

  @override
  String get theBlueprint => 'EL PLANO';

  @override
  String get theOrigin => 'EL ORIGEN';

  @override
  String get theGalaxy => 'LA GALAXIA';

  @override
  String get theScholarListens => 'El Erudito escucha...';

  @override
  String get consultingTheScrolls => 'Consultando los pergaminos...';

  @override
  String get traceWithTheGuide => 'Traza con la guía';

  @override
  String get traceTheGhost => 'Traza sobre la línea guía';

  @override
  String get connectTheDots => 'Une los puntos';

  @override
  String get drawFromMemory => 'Dibuja de memoria';

  @override
  String get assistant => 'Asistente';

  @override
  String get puck => 'Puck (masculino, deportivo)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      '¡Hola! Bienvenido. ¿Qué te gustaría pedir?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'Camarero Li';

  @override
  String get askForTheMenu => 'Pedir la carta';

  @override
  String get orderOneDishAndOneDrink => 'Pedir un plato y una bebida';

  @override
  String get askForTheBill => 'Pedir la cuenta';

  @override
  String get fenrir => 'Fenrir (masculino, enérgico)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'Conductor Wang';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Decirle al conductor que vas al aeropuerto';

  @override
  String get askHowLongTheTripWillTake =>
      'Preguntar cuánto tardará el trayecto';

  @override
  String get complainAboutTheTraffic => 'Comentar sobre el tráfico pesado';

  @override
  String get charon => 'Charon (masculino, estilo informativo)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'Esta prenda es de muy buena calidad, solo cuesta 200 kuai.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'Tía Chen';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'Preguntar cuánto cuesta la camisa de seda';

  @override
  String get sayItIsTooExpensive => 'Decir que es demasiado cara';

  @override
  String get bargainThePriceDownTo100Rmb => 'Regatear el precio hasta 100 RMB';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'Dr. Zhang';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Explicar que llevas dos días con dolor de cabeza';

  @override
  String get sayYouHaveASlightFever => 'Decir que tienes algo de fiebre';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Preguntar si necesitas tomar medicamentos';

  @override
  String get aoede => 'Aoede (femenina, alegre)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      '¡Hola! ¡Cuánto tiempo! ¿Qué tal has estado últimamente?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Por favor, preséntate. ¿Por qué te gustaría trabajar en nuestra empresa?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'Gerente Liu';

  @override
  String get introduceYourProfessionalBackground =>
      'Presenta brevemente tu trayectoria profesional';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Explica por qué quieres trabajar en esta empresa';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Haz una pregunta formal sobre la cultura de la empresa';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'Se requiere acceso al micrófono. Por favor, actívalo en los ajustes de tu dispositivo.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'No se pudo iniciar el micrófono. Revisa la configuración de audio e inténtalo de nuevo.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'No te hemos escuchado bien. Mantén pulsado el botón del micrófono e inténtalo de nuevo.';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'La grabación fue demasiado corta. Mantén pulsado el micrófono y habla con claridad.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'El búfer de audio estaba vacío. Revisa tu micrófono e inténtalo de nuevo.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'El archivo de audio está en silencio. Por favor, habla directamente al micrófono.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'No pudimos reconocer tu pronunciación. Habla con claridad e inténtalo de nuevo.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'El servidor está tardando demasiado en responder. Por favor, inténtalo de nuevo.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Sin conexión a internet. Revisa tu red e inténtalo de nuevo.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Error al procesar el audio. Por favor, inténtalo de nuevo.';

  @override
  String get permission => 'Permiso';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'No se pudo procesar tu grabación. Por favor, inténtalo de nuevo.';

  @override
  String get user => 'Usuario';

  @override
  String get scholar => 'Erudito';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Nuestros tutores de IA no están disponibles en este momento. Por favor, inténtalo más tarde.';

  @override
  String get hideTranslation => 'Ocultar traducción';

  @override
  String get azureAssessment => 'Evaluación de Azure en curso...';

  @override
  String get microphonePermissionRequired => 'Se requiere permiso de micrófono';

  @override
  String get connectedSpeakNow => '¡Conectado! Puedes hablar ahora.';

  @override
  String get initializationErrorCheckPermissions =>
      'Error de inicialización. Revisa los permisos.';

  @override
  String get microphoneErrorTapToRetry =>
      'Error de micrófono. Toca para reintentar.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'El tutor devolvió una respuesta vacía.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Conexión interrumpida. Por favor, habla de nuevo.';

  @override
  String get callPausedReviewingTones => 'Llamada pausada (Revisión de tonos)';

  @override
  String get pausedTakeABreak => 'En pausa: tómate un descanso';

  @override
  String get goodStartPracticing => 'Buen comienzo de práctica';

  @override
  String get studentCoach => 'Estudiante / Tutor';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Mantén tu 1.er tono alto y constante en';

  @override
  String get noScenariosFound => 'No se encontraron escenarios.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Diseña tu propia experiencia de juego de rol con IA';

  @override
  String get generateFromDeck => 'Generar a partir del mazo';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Practica el vocabulario de las tarjetas en un diálogo interactivo';

  @override
  String get tapToRoleplay => 'Toca para iniciar el juego de rol';

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
  String get dinnerWithDad => 'Cena con papá';

  @override
  String get orderingAtAChengduTeahouse => 'Pedir en una casa de té de Chengdu';

  @override
  String get buyingTeaAtTheMarket => 'Comprar té en el mercado';

  @override
  String get meetingAnOldClassmate =>
      'Quedar con un antiguo compañero de clase';

  @override
  String get readyToPractice => '¿Listo para practicar?';

  @override
  String get letsPracticeChinese => 'Practiquemos chino';

  @override
  String get areYouReady => '¿Estás listo?';

  @override
  String get discussWhatToHaveForDinner => 'Hablar sobre qué cenar';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Sugerir ver una película después';

  @override
  String get askIfTheyWouldLikeTea => 'Preguntar si desean té';

  @override
  String get helloVeryNiceToMeetYou => '¡Hola! Mucho gusto en conocerte.';

  @override
  String get deckPractice => 'Práctica con el mazo';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Practica vocabulario con un tutor de IA.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Crea diálogos y juegos de rol personalizados con IA';

  @override
  String get random => 'Aleatorio';

  @override
  String get scenarioTopic => 'Tema del escenario';

  @override
  String get contextSettingOptional => 'Contexto y entorno (opcional)';

  @override
  String get aiCharacterPersonaOptional =>
      'Perfil del personaje de IA (opcional)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Una tranquila casa de té con patio de bambú en Chengdu, acompañada de suave música de guzheng.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Un bullicioso mercado nocturno repleto de humo, brochetas, baozi y puestos de comida callejera.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Un animado restaurante de hotpot en Chongqing con caldo rojo hirviendo y un intenso aroma a chile.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Una tradicional casa de té cantonesa en Guangzhou llena de cestas de bambú al vapor.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Una elegante cafetería minimalista en la Concesión Francesa durante una tarde lluviosa de domingo.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Una acogedora cocina familiar en el norte de China en invierno, con harina en la mesa y ollas de jiaozi humeantes.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Un callejón nocturno de comida callejera con brochetas de cordero a la parrilla, berenjenas asadas y cerveza fría.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Una esquina nevada frente al Templo Lama con brochetas de espino confitado (Tanghulu) sobre hielo.';

  @override
  String get craftBeerBreweryInQingdao => 'Cervecería artesanal en Qingdao';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Una animada taberna costera con barriles de madera, brisa marina y grifos de cerveza de trigo fresca.';

  @override
  String get sichuanCookingMasterclass =>
      'Clase magistral de cocina de Sichuan';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Una dinámica cocina abierta con woks encendidos, aceite de chile chispeante y pimienta de Sichuan fresca.';

  @override
  String get highspeedRailSeatMixup =>
      'Confusión de asientos en el tren de alta velocidad';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Ruta al amanecer por la Gran Muralla en Mutianyu';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'Las antiguas murallas de piedra de la Gran Muralla al amanecer, rodeadas de verdes montañas neblinosas.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Paseo en balsa de bambú por el río Li en Guilin';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Deslizándose por las aguas kársticas esmeralda entre dramáticos picos de piedra caliza brumosos cerca de Yangshuo.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Ruta en camello por la Ruta de la Seda en Dunhuang';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Las ondulantes dunas doradas del monte Mingsha junto al oasis del Lago de la Media Luna.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Reservar un alojamiento tradicional con patio en Dali';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Un apacible hotel boutique con patio al estilo Bai con vistas al lago Erhai en Yunnan.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Peregrinación al Palacio de Potala en Lhasa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Las majestuosas escaleras de piedra bañadas por el sol frente al Palacio de Potala con ruedas de oración giratorias.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Un paraíso bajo cero con palacios de hielo de cristal iluminados e imponentes esculturas de nieve.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Teleférico de las montañas de Avatar en Zhangjiajie';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Suspendido en una cabina de teleférico de cristal sobrevolando miles de pilares de arenisca.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Campamento de observación astronómica en el desierto de Gobi en Gansu';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Un campamento de yurtas de lujo bajo el cielo despejado de la Vía Láctea en el desierto a las afueras de Jiayuguan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Crucero por las Tres Gargantas del río Yangtsé';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'En la cubierta de un crucero fluvial atravesando la imponente y espectacular Garganta de Qutang.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Comprar antigüedades en Panjiayuan, Pekín';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Un histórico horno de cerámica repleto de delicados jarrones de porcelana sin cocer y esmaltes azul cobalto.';

  @override
  String get suzhouSilkEmbroideryStudio =>
      'Taller de bordado en seda de Suzhou';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Un tranquilo taller con jardín junto al canal en Suzhou con finos hilos de seda y bastidores de madera.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Entre bastidores en un teatro tradicional de ópera de Pekín con trajes coloridos, espejos y tocados.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Consulta de Medicina Tradicional China (MTC)';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Taichí matutino en el Parque del Templo del Cielo';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Bajo antiguos cipreses al amanecer, con el canto de los pájaros y personas mayores practicando movimientos sincronizados.';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'Alquilar un Hanfu para una sesión de fotos';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Una tienda de trajes tradicionales cerca del Lago del Oeste con percheros de túnicas de las dinastías Tang y Song.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Taller de Guqin (antigua cítara china)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Un tranquilo taller de madera de pino en Hangzhou con instrumentos de paulownia envejecida y cuerdas de seda.';

  @override
  String get shaanxiShadowPuppetTheater =>
      'Teatro de sombras chinescas de Shaanxi';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Tras una pantalla de seda blanca iluminada con delicadas marionetas de cuero traslúcido.';

  @override
  String get chineseCalligraphyWorkshop => 'Taller de caligrafía china';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Un tranquilo estudio con aroma a tinta de hollín de pino, rollos de papel de arroz y suave fragancia a té.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Adoptar un gato en un refugio de animales';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Un acogedor centro de rescate en Hangzhou con gatitos juguetones y té para las visitas.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Juego de rol y misterio de asesinato (Jubensha)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Un salón temático de detectives en Shanghái con jugadores disfrazados a la luz de las velas.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Tienda de vinilos vintage en Shanghái';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Una tienda de vinilos oculta en un callejón tradicional (Shikumen), repleta de clásicos del Cantopop y jazz de los 80.';

  @override
  String get ktvKaraokePartyWithFriends => 'Fiesta de karaoke KTV con amigos';

  @override
  String get joiningACityBikeCyclingClub => 'Unirse a un club ciclista urbano';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Un grupo de ciclistas junto a la orilla del río preparándose para un paseo nocturno frente al horizonte de la ciudad.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Encuentro de intercambio de figuras en cajas sorpresa (Blind Box)';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Una colorida tienda de cultura pop en Chaoyang con estanterías llenas de cajas coleccionables sin abrir.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Grabación aérea del skyline con dron en el Bund';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'El paseo del Bund al atardecer, frente a los futuristas rascacielos iluminados de Pudong.';

  @override
  String get goldenRetrieverCafeInNanjing =>
      'Cafetería de Golden Retrievers en Nankín';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Una cafetería de mascotas soleada y alegre con decenas de perros cariñosos dando la bienvenida.';

  @override
  String get boulderingClimbingGymInChengdu => 'Rocódromo de búlder en Chengdu';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Un moderno rocódromo cubierto con presas de colores vivos y música motivadora.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Un enorme pabellón de convenciones repleto de coloridos puestos de videojuegos, zonas de fotos y creadores haciendo cosplay.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Preguntar por una dirección en un hutong de Pekín';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Un laberinto de callejones históricos de ladrillo gris con bicicletas, patios tradicionales y granados.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Comprar fruta fresca en un mercado tradicional';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Un animado mercado matutino de barrio con montones de lichis, mangos y pitahayas frescas.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Ramo del mercado de flores en Kunming';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'El famoso mercado de flores de Dounan, rodeado de miles de rosas frescas, lirios y ramas de eucalipto.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Arreglos de sastrería en una casa tradicional de callejón';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Una sastrería tradicional repleta de máquinas de coser, telas y cintas métricas.';

  @override
  String get expressParcelLockerRetrieval =>
      'Recoger un paquete en una taquilla inteligente';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'Abajo, en la entrada de un edificio residencial, junto a un sistema de taquillas inteligentes Hive.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Reparar un pinchazo de bicicleta en la puerta del campus';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Un pequeño puesto de herramientas al aire libre junto a la carretera, bajo un gran baniano frondoso.';

  @override
  String get techCompanyProductDemo =>
      'Demostración de producto de una empresa tecnológica';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Un stand futurista en una conferencia tecnológica en Shenzhen que presenta hardware de IA de vanguardia.';

  @override
  String get ecommerceLivestreamStudio =>
      'Estudio de emisión en directo para comercio electrónico';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Un dinámico estudio de transmisión con luces anulares, expositores de productos y pantallas con comentarios en vivo.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Mercado de Comercio Internacional de Yiwu';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Un inmenso centro de exposiciones comerciales de varios pisos repleto de productos al por mayor y artesanías.';

  @override
  String get universityCampusExchangeProgram =>
      'Programa de intercambio en un campus universitario';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Un soleado césped frente a la biblioteca universitaria con estudiantes repasando y tomando té con leche.';

  @override
  String get pleaseEnterAScenarioTopic =>
      'Introduce un tema para el escenario.';

  @override
  String get nameTitle => 'Nombre (Título)';

  @override
  String get aiCharacter => 'Personaje de IA';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      '¡Hola! Te damos la bienvenida, ¿de qué te gustaría hablar hoy?';

  @override
  String get greetYourConversationPartner => 'Saluda a tu interlocutor';

  @override
  String get askAQuestionInChinese => 'Haz una pregunta en chino';

  @override
  String get pinyinWithToneMarks => 'Pinyin con marcas de tono';

  @override
  String get goal1InEnglish => 'Objetivo 1 en español';

  @override
  String get goal2InEnglish => 'Objetivo 2 en español';

  @override
  String get goal3InEnglish => 'Objetivo 3 en español';

  @override
  String get beginner => 'Principiante';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Dominado';

  @override
  String get azurePronunciationAssessment =>
      'EVALUACIÓN DE PRONUNCIACIÓN DE AZURE';

  @override
  String get tapToReview => 'Toca para revisar';

  @override
  String get overallScore => 'Puntuación general';

  @override
  String get toneAccuracy => 'Precisión tonal';

  @override
  String get fluency => 'Fluidez';

  @override
  String get report => 'Informe';

  @override
  String get goodPronunciationButCanBeBetter =>
      '¡Buena pronunciación, pero se puede mejorar!';

  @override
  String get didYouMeanToSay => '¿Querías decir...?';

  @override
  String get greatKeepTrying => '¡Genial! ¡Sigue intentándolo!';

  @override
  String get completeness => 'Completitud';

  @override
  String get targetTone => 'Tono objetivo';

  @override
  String get k4toneComparisonTapToListen =>
      'Comparación de los 4 tonos (toca para escuchar):';

  @override
  String get youSpokeMatch => 'Pronunciaste (¡Coincidencia!)';

  @override
  String get youSpoke => 'Pronunciaste';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Tu colección principal de caracteres.';

  @override
  String get deckNotFound => 'Mazo no encontrado';

  @override
  String get cannotDeleteTheDefaultDeck =>
      'No se puede eliminar el mazo predeterminado';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Intermedio alto';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'Los primeros 150 caracteres para iniciar tu aprendizaje.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Amplía tu vocabulario a 300 palabras esenciales.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Domina la fluidez conversacional con 600 palabras.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Lee textos y conversa con fluidez con 1200 palabras.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Lee periódicos y mira películas con 2500 palabras.';

  @override
  String get databaseBoxNotOpen => 'La base de datos no está abierta';

  @override
  String get hsk1DataFileIsEmpty => 'El archivo de datos de HSK 1 está vacío';

  @override
  String get gold => 'Oro';

  @override
  String get globalDictionaryNotInitialized =>
      'Diccionario global no inicializado';

  @override
  String get reading => 'Lectura';

  @override
  String get recall => 'Evocación mental';

  @override
  String get speaking => 'Expresión oral';

  @override
  String get listening1 => 'Comprensión auditiva';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Practica el orden de trazos con guías visuales.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Observa el carácter y recuerda su Pinyin y significado.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Lee el significado y dibuja el carácter de memoria.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Lee en voz alta para evaluar tu pronunciación y tonos.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Escucha el audio e identifica el carácter correspondiente.';

  @override
  String get contract => 'Contrato';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Cualquiera que implemente esta interfaz DEBE ser capaz de realizar estas funciones.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck o local';

  @override
  String get manageDecks => 'Gestionar mazos';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Hubo un problema al cargar la biblioteca. Por favor, inténtalo de nuevo.';

  @override
  String get noCharactersInLexicon1 => 'No hay caracteres en el léxico';

  @override
  String get masterTheBuildingBlocks => 'Domina los componentes básicos';

  @override
  String get other => 'Otros';

  @override
  String get required => 'Obligatorio';

  @override
  String get library1 => 'Biblioteca';

  @override
  String get youAreAPremiumMember => 'Eres miembro Premium';

  @override
  String get createAccountToSyncProgress =>
      'Crea una cuenta para sincronizar tu progreso';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get account => 'Cuenta';

  @override
  String get guestScholar => 'Erudito invitado';

  @override
  String get localAccount => 'Cuenta local';

  @override
  String get unknownRadical => 'Radical desconocido';

  @override
  String get followTheGuideStroke => 'Sigue el trazo guía';

  @override
  String get strokeAnimationSpeed => 'Velocidad de animación de los trazos';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get deutsch => 'Alemán';

  @override
  String get bahasaIndonesia => 'Indonesio';

  @override
  String get italiano => 'Italiano';

  @override
  String get today1d2d3d4d5d6d => 'Hoy, 1 d, 2 d, 3 d, 4 d, 5 d, 6 d';

  @override
  String get targetDeck => 'Mazo objetivo';

  @override
  String get mixed => 'Mixto';

  @override
  String get topicForContext => 'Tema (para contexto)';

  @override
  String get nounsOnly => 'Solo sustantivos';

  @override
  String get verbsOnly => 'Solo verbos';

  @override
  String get idiomsChengyu => 'Modismos (Chengyu)';

  @override
  String get fullSentences => 'Oraciones completas';

  @override
  String get beginnerHsk12 => 'Principiante (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Intermedio (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Avanzado (HSK 5-6)';

  @override
  String get generatedByAi => 'Generado por IA';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      '¿Podrías darme dos ejemplos más utilizando esta palabra?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      '¿Qué palabras son similares y en qué se diferencian?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      '¿Se utiliza esta palabra principalmente en chino hablado o escrito?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      '¿Existen otras formas de traducir esta palabra?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      '¿Con qué palabras suele combinarse frecuentemente?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      '¿Cuáles son los errores más comunes que cometen los estudiantes con esta palabra?';

  @override
  String get emptyResponse => 'Respuesta vacía';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      '¿Cuál es el origen de este carácter en la escritura sobre huesos oraculares?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      '¿Cómo evolucionó la forma antigua de este carácter a lo largo del tiempo?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Indícame 3 palabras comunes que contengan este carácter.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      '¿Qué otros caracteres comparten el mismo radical?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      '¿Existe algún proverbio o dicho chino que incluya este carácter?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Explica las reglas del orden de trazos para este carácter.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Dame un consejo de caligrafía para trazar este carácter de forma armónica.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      '¿Existe alguna particularidad gramatical o de uso en este carácter?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      '¿Con qué palabras se confunde habitualmente y por qué?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      '¿Tiene este carácter algún simbolismo cultural especial en China?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      '¿Aparece este carácter habitualmente en canciones, películas o textos contemporáneos?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      '¿Qué significado aporta el radical de este carácter?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Desglosa cada componente con su significado correspondiente.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Dame una regla mnemotécnica para recordar el tono exacto de este carácter.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      '¿Existen homófonos frecuentes con los que se confunda habitualmente?';

  @override
  String get quotaExceeded => 'Límite de solicitudes alcanzado';

  @override
  String get mustProvideEitherCardOrCards =>
      'Debes proporcionar una tarjeta o una lista de tarjetas';

  @override
  String get deckSettings => 'Ajustes del mazo';

  @override
  String get saveSettings => 'Guardar ajustes';

  @override
  String get sealRed => 'Sello rojo';

  @override
  String get sealScript => 'Escritura de sello (Zhuan)';

  @override
  String get startYourStreak => 'INICIA TU RACHA';

  @override
  String get traditionalCharacter => 'Carácter tradicional';

  @override
  String get inQueue => 'En cola';

  @override
  String get tapToListenAgain => 'Toca para escuchar de nuevo';

  @override
  String get contextClue => 'Pista contextual';

  @override
  String get microphonePermissionRequired1 =>
      'Se requiere permiso de micrófono.';

  @override
  String get recordingFailedNoFile =>
      'Error en la grabación (archivo no generado).';

  @override
  String get holdToSpeakOptional => 'Mantén pulsado para hablar (opcional)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Permiso de micrófono denegado. Actívalo en Ajustes para utilizar el Estudio de Shadowing.';

  @override
  String get sessionSummary => 'Resumen de la sesión';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Estos son los caracteres que te resultaron más difíciles:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Aplicar calificaciones de la sesión al sistema de repetición espaciada (modo habla)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Domina tu pronunciación en mandarín\nimitando a hablantes nativos.';

  @override
  String get aiIsGradingYourPronunciation =>
      'La IA está evaluando tu pronunciación...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Mantén pulsado el micrófono para grabar. Suelta para evaluar.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Toca cualquier sílaba para escuchar los 4 tonos:';

  @override
  String get freeFlowConversationalPractice =>
      'Práctica de conversación fluida y libre.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'No se pudo generar la frase. Por favor, inténtalo de nuevo.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Grabación demasiado breve. Mantén pulsado el botón del micrófono durante más tiempo.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Error en la grabación. Por favor, inténtalo de nuevo.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'No se detectó ninguna grabación. Por favor, inténtalo de nuevo.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'El audio grabado está vacío. Inténtalo de nuevo hablando con claridad.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Faltan las claves de la API de voz de Azure';

  @override
  String get azureError401 => 'Error 401 de Azure';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Error de autenticación en Azure. Comprueba tu clave de la API de voz y la región en el archivo .env';

  @override
  String get azureError429 => 'Error 429 de Azure';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Se ha superado la cuota de Azure. Por favor, inténtalo más tarde.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'La evaluación de Azure superó el tiempo límite. Comprueba tu conexión a internet.';

  @override
  String get recognitionFailedNull =>
      'Fallo en el reconocimiento: resultado nulo';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'No pudimos escucharte con claridad. Por favor, inténtalo de nuevo.';

  @override
  String get singlePhrasePractice => 'Práctica de frase individual';

  @override
  String get failedToGeneratePhrase => 'No se pudo generar la frase';

  @override
  String get omitted => 'Omitido';

  @override
  String get partial => 'Parcial';

  @override
  String get mispronounced => 'Pronunciación imprecisa';

  @override
  String get startSession1 => 'Iniciar sesión';

  @override
  String get chinese => 'Chino';

  @override
  String get paused => 'En pausa';

  @override
  String get translationFailed => 'Error de traducción';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Análisis macroeconómicos y empresariales explicados con una narración amena y accesible.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Explora la economía global, la historia bancaria y las dinámicas industriales del mundo.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Mandarín claro y articulado, ideal para estudiantes de nivel intermedio y avanzado.';

  @override
  String get chefWang => 'Chef Wang';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Domina las técnicas culinarias de Sichuan de la mano de un chef profesional.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Recetas chinas auténticas paso a paso con técnicas de corte y manejo del wok.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Vocabulario gastronómico conciso e instrucciones claras en mandarín natural.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Cinematografía, tecnología audiovisual de vanguardia y análisis de medios digitales.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Documentales de alta producción sobre creación de vídeo e innovaciones en IA.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Vocabulario técnico enriquecido con pronunciación nítida y apoyo visual.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Periodismo de investigación en profundidad y análisis de actualidad.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Perspectivas críticas sobre dinámicas sociales, noticias globales e historia.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Lenguaje formal de investigación, ideal para perfeccionar la comprensión auditiva avanzada.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Microdocumentales científicos animados que responden preguntas de la vida diaria.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Explora conceptos de física, biología y curiosidades cotidianas con infografías amenas.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Mandarín estándar de Pekín con ritmo pausado y subtítulos nítidos.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Aventuras gastronómicas callejeras y conversaciones auténticas a lo largo de China.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Historias humanas locales, tradiciones familiares y delicias gastronómicas regionales.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Mandarín conversacional espontáneo con expresiones cotidianas y gran cercanía.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Reseñas desenfadadas y sinceras sobre tecnología de consumo probada en el día a día.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Pruebas reales de teléfonos, domótica y dispositivos tecnológicos cotidianos.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Diálogos distendidos con sentido del humor y modismos actuales.';

  @override
  String get seanKitchen => 'La cocina de Sean';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Deliciosos platos caseros chinos y versiones caseras de aperitivos callejeros.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Consejos culinarios sencillos para preparar auténtica comida asiática casera.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Comentarios amenos y cercanos con vocabulario práctico de cocina.';

  @override
  String get chineseChannel => 'Canal de chino';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Lecciones estructuradas de lengua china y cápsulas de inmersión cultural.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Explicaciones gramaticales, vocabulario HSK y estructuras conversacionales.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Ritmo pedagógico claro y adaptado a las necesidades de los estudiantes de chino.';

  @override
  String get oneInABillion => 'Uno entre mil millones';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Retratos personales e historias de vidas extraordinarias en la China contemporánea.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Explora decisiones de vida, cultura juvenil y transformaciones sociales recientes.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Narraciones profundas con un vocabulario variado y testimonios auténticos.';

  @override
  String get vickySoup => 'Vicky Soup';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Vlogs de estilo de vida, moda y rutinas cotidianas.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Diarios de viaje y momentos cotidianos grabados con sensibilidad cinematográfica.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Mandarín coloquial y natural hablado a un ritmo cómodo y expresivo.';

  @override
  String get tededMandarin => 'TED-Ed Mandarín';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Lecciones educativas animadas de primer nivel sobre ciencia, filosofía e historia.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Acertijos estimulantes, literatura clásica y enigmas psicológicos.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Locución impecable en mandarín con subtítulos bilingües sincronizados.';

  @override
  String get channel => 'Canal';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Documentales culturales seleccionados y aspectos destacados del estilo de vida chino.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Exploración de artes tradicionales, patrimonio artesanal y tendencias actuales.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Sonido de alta definición con subtítulos sincronizados en chino.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Historias fascinantes y proyectos audiovisuales creativos de la red china.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Entrevistas sugerentes, narraciones y exploraciones visuales.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Excelente material auditivo con pronunciación estándar.';

  @override
  String get xVsY => 'X frente a Y';

  @override
  String get untitled => 'Sin título';

  @override
  String get contemporaryStories => 'Relatos contemporáneos';

  @override
  String get history => 'Historia';

  @override
  String get advancedReading => 'Lectura avanzada';

  @override
  String get intermediateReading => 'Lectura intermedia';

  @override
  String get beginnerReading => 'Lectura inicial';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Desconocido';

  @override
  String get localDb => 'Base de datos local';

  @override
  String get emperorTaizong => 'Emperador Taizong';

  @override
  String get emperorXuanzong => 'Emperador Xuanzong';

  @override
  String get liBai => 'Li Bai';

  @override
  String get gradedReader => 'Lecturas graduadas';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Aprende mandarín con TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'Chino del día a día';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'Ting: Vida cotidiana en China';

  @override
  String get xinxin => 'Xinxin';

  @override
  String get sweetFamilyDailyLife => 'Vida familiar cotidiana';

  @override
  String get chinsunDailyLife => 'El día a día de Chin-Sun';

  @override
  String get tasteChina => 'Sabores de China';

  @override
  String get dawenFoodQuest => 'La ruta gastronómica de DaWen';

  @override
  String get chinaTravelWithCangbao => 'Viajar por China con Cangbao';

  @override
  String get alinFoodWalk => 'Ruta de comida callejera con Alin';

  @override
  String get videoOfTheDay => 'VÍDEO DEL DÍA';

  @override
  String get noValidVideoFound => 'No se encontró ningún vídeo válido.';

  @override
  String get listeningPractice => 'PRÁCTICA AUDITIVA';

  @override
  String get socialSkills => 'HABILIDADES SOCIALES';

  @override
  String get culturalContext => 'CONTEXTO CULTURAL';

  @override
  String get realLife => 'VIDA REAL';

  @override
  String get realWorld => 'MUNDO REAL';

  @override
  String get articleOfTheDay => 'ARTÍCULO DEL DÍA';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Error al cargar o procesar el canal RSS.';

  @override
  String get drama => 'Drama';

  @override
  String get youkugetAppNow => 'YOUKU: Descarga la app';

  @override
  String get romanceTrailer => 'Romance / Tráiler';

  @override
  String get romance => 'Romance';

  @override
  String get action => 'Acción';

  @override
  String get mystery => 'Misterio';

  @override
  String get historical => 'Histórico';

  @override
  String get historicalAction => 'Histórico / Acción';

  @override
  String get historicalRomance => 'Histórico / Romance';

  @override
  String get anYouth => 'Juventud';

  @override
  String get historicalSliceOfLife =>
      'Histórico / Costumbrista (Slice of Life)';

  @override
  String get historicalHighlight => 'Histórico / Momentos destacados';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: Descarga la app';

  @override
  String get theDouble => 'The Double';

  @override
  String get updatesByOshin => 'Actualizaciones de Oshin';

  @override
  String get backFromTheBrink => 'De vuelta del abismo';

  @override
  String get fallingIntoYourSmile => 'Enamorándome de tu sonrisa';

  @override
  String get everyoneLovesMe => 'Todos me quieren';

  @override
  String get tillTheEndOfTheMoon => 'Hasta el fin de la luna';

  @override
  String get theBestDayOfMyLife => 'El mejor día de mi vida';

  @override
  String get gikkiChineseDrama => 'Drama chino GIKKI';

  @override
  String get dashingYouth => 'Juventud intrépida';

  @override
  String get rebornChineseDramaEngSub => 'Drama chino Reborn (con subtítulos)';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'Cuando vuelo hacia ti';

  @override
  String get mztvExclusiveChineseDrama => 'Drama chino exclusivo de MZTV';

  @override
  String get theStarryLove => 'Amor estrellado';

  @override
  String get comedy => 'Comedia';

  @override
  String get backFromTheBrink1 => 'De vuelta del abismo';

  @override
  String get dashingYouth1 => 'Juventud intrépida';

  @override
  String get beReborn => 'Renacer';

  @override
  String get beautyStrategy => 'Estrategia de belleza';

  @override
  String get myDivineEmissary => 'Mi emisario divino';

  @override
  String get theHope => 'La esperanza';

  @override
  String get ep16In => 'Episodio 16';

  @override
  String get everyoneLovesMe1 => 'Todos me quieren';

  @override
  String get fallingIntoYourSmile1 => 'Enamorándome de tu sonrisa';

  @override
  String get hiddenLove => 'Amor secreto';

  @override
  String get loveBetweenFairyAndDevil => 'Amor entre un hada y un demonio';

  @override
  String get loveLikeTheGalaxy => 'Amor como la galaxia';

  @override
  String get membersPremiere => 'Estreno para miembros';

  @override
  String get moonlight => 'Luz de luna';

  @override
  String get myJourneyToYou => 'Mi viaje hacia ti';

  @override
  String get mysteriousLotusCasebook => 'El misterioso caso del loto';

  @override
  String get rebornChineseDramaEngSub1 => 'Drama chino Reborn (con subtítulos)';

  @override
  String get reborn => 'Renacido';

  @override
  String get theBestDayOfMyLife1 => 'El mejor día de mi vida';

  @override
  String get theDouble1 => 'The Double';

  @override
  String get theLongBallad => 'La larga balada';

  @override
  String get theStarryLove1 => 'Amor estrellado';

  @override
  String get theUntamed => 'The Untamed (El indomable)';

  @override
  String get tillTheEndOfTheMoon1 => 'Hasta el fin de la luna';

  @override
  String get whenIFlyTowardsYou1 => 'Cuando vuelo hacia ti';

  @override
  String get wordOfHonor => 'Palabra de honor';

  @override
  String get blossom => 'Florecer';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'De generación en generación';

  @override
  String get brocadeOdyssey => 'Odisea de brocado';

  @override
  String get circleOfLove => 'Círculo de amor';

  @override
  String get dawnIsBreaking => 'El amanecer despunta';

  @override
  String get firstRomance => 'Primer romance';

  @override
  String get loveInTheClouds => 'Amor en las nubes';

  @override
  String get secondChanceRomance => 'Segunda oportunidad de amor';

  @override
  String get mrBad => 'Mr. Bad';

  @override
  String get pursuitOfJade => 'En busca del jade';

  @override
  String get fatedHearts => 'Corazones predestinados';

  @override
  String get roadHome => 'El camino a casa';

  @override
  String get myDearGuardian => 'Mi querido guardián';

  @override
  String get brightEyesInTheDark => 'Miradas brillantes en la oscuridad';

  @override
  String get theIngeniousOne => 'El estratega';

  @override
  String get herPhoenixMajesty => 'Su Majestad Fénix';

  @override
  String get dreamsNeverEnd => 'Los sueños nunca terminan';

  @override
  String get theUltimateVowUnknownToYou => 'El voto supremo que desconoces';

  @override
  String get the300LoyalGhosts => 'Los 300 espíritus leales';

  @override
  String get homelandGuardian => 'Guardián de la patria';

  @override
  String get loveIsAlwaysOnline => 'El amor siempre está conectado';

  @override
  String get thePrincessDecree => 'El decreto de la princesa';

  @override
  String get aVowInTheDark => 'Un juramento en la sombra';

  @override
  String get aGirlLikeMe => 'Una chica como yo';

  @override
  String get iAmNobody => 'No soy nadie';

  @override
  String get myMamaGo => '¡Adelante, mamá!';

  @override
  String get myWesternRegionPrincess =>
      'Mi princesa de las Regiones Occidentales';

  @override
  String get aFlowerOnTheContinent => 'Una flor en el continente';

  @override
  String get thePrincess => 'La princesa';

  @override
  String get sweetLoveVersion => 'Versión romance dulce';

  @override
  String get hilariousFamily2 => 'Familia divertida 2';

  @override
  String get guYuanMountainHasASchool => 'La escuela del monte Gu Yuan';

  @override
  String get foreverYoung => 'Eternamente joven';

  @override
  String get theHiddenHeirYeChen => 'El heredero oculto Ye Chen';

  @override
  String get extraordinary => 'Extraordinario';

  @override
  String get sideStoryOfFoxVolant => 'Historia paralela del zorro volador';

  @override
  String get loveOfTheDivineTree => 'El amor del árbol sagrado';

  @override
  String get rebirth => 'Renacimiento';

  @override
  String get moonlitReunion => 'Reencuentro bajo la luna';

  @override
  String get videoCountsCannotBeNegative =>
      'El número de vídeos no puede ser negativo.';

  @override
  String get publicDomainClassic => 'Clásico de dominio público';

  @override
  String get idioms => 'Modismos';

  @override
  String get news => 'Noticias';

  @override
  String get fairyTales => 'Cuentos de hadas';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Aquí tienes una interesante explicación cultural';

  @override
  String get videoFetchTimedOut =>
      'Tiempo de espera agotado al obtener el vídeo';

  @override
  String get aboutChannel => 'SOBRE EL CANAL';

  @override
  String get noVideosFound => 'No se encontraron vídeos';

  @override
  String get failedToLoadVideos => 'Error al cargar los vídeos';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Contenido en mandarín seleccionado con vocabulario auténtico.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Chino oral genuino centrado en situaciones y temas reales.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Material audiovisual atractivo con subtítulos sincronizados interactivos.';

  @override
  String get watchVideo => 'Ver vídeo';

  @override
  String get culturalInsight => 'Apunte cultural';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'La IA está contextualizando el contenido cultural...';

  @override
  String get diveIntoFullContent => 'Acceder al contenido completo';

  @override
  String get savedArticles => 'Artículos guardados';

  @override
  String get liveOverlay => 'PANTALLA SUPERPUESTA EN DIRECTO';

  @override
  String get webExplorer => 'EXPLORADOR WEB';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Navega por cualquier sitio web chino con diccionario táctil, Pinyin instantáneo y traducción simultánea.';

  @override
  String get startExploring => 'COMENZAR A EXPLORAR';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Series de televisión chinas con subtítulos interactivos';

  @override
  String get failedToLoadContent => 'Error al cargar el contenido';

  @override
  String get searchingYoutube => 'Buscando en YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'No se encontraron vídeos. Prueba con otros términos de búsqueda.';

  @override
  String get searching => 'Buscando';

  @override
  String get noShowsFound => 'No se encontraron programas';

  @override
  String get bookmarked => 'Guardado';

  @override
  String get trailer1 => 'Tráiler';

  @override
  String get highlight1 => 'Momento destacado';

  @override
  String get noCaptionsAvailable => 'Subtítulos no disponibles';

  @override
  String get fetchingSubtitles => 'Cargando subtítulos...';

  @override
  String get generatingAiBriefing => 'Generando resumen con IA...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Este vídeo no dispone de subtítulos integrados (CC).';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Los vídeos con subtítulos incrustados en la imagen no cuentan con pistas de texto digital en YouTube.';

  @override
  String get translatingSubtitles => 'Traduciendo subtítulos...';

  @override
  String get processingYourPronunciation => 'Evaluando tu pronunciación...';

  @override
  String get couldntIdentifyLine => 'No se pudo identificar la línea de texto.';

  @override
  String get listeningSpeakNow => 'Escuchando... puedes hablar ahora.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Este vídeo no contiene subtítulos digitales (CC) en YouTube.';

  @override
  String get perfect1 => 'Perfecto';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Este vídeo ha sido retirado o ya no se encuentra disponible.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Este vídeo no se puede reproducir dentro de la app. Puedes verlo directamente en YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Tu dispositivo no puede reproducir este vídeo. Por favor, prueba con otro.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'El enlace del vídeo no es válido. Por favor, inténtalo de nuevo.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'No se pudo reproducir este vídeo. Por favor, prueba con otro.';

  @override
  String get startReading => 'Comenzar a leer';

  @override
  String get analyzingCulturalContext => 'Analizando el contexto cultural...';

  @override
  String get failedToLoadCulturalInsight =>
      'No se pudo cargar la información cultural.';

  @override
  String get historicalContext => 'Contexto histórico';

  @override
  String get culturalSignificance => 'Relevancia cultural';

  @override
  String get authorBackground => 'Perfil del autor';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'Más de 80 novelas clásicas completas y grandes epopeyas';

  @override
  String get storyOfTheDay => 'HISTORIA DEL DÍA';

  @override
  String get tangDynasty => 'Dinastía Tang';

  @override
  String get poetryClassicalVerse => 'Poesía clásica y verso';

  @override
  String get allHsk => 'Todos los niveles HSK';

  @override
  String get allStories => 'Todas las historias';

  @override
  String get keyWords => 'Palabras clave';

  @override
  String get openOriginalWebsite => 'Abrir página web original';

  @override
  String get aiReadingTools => 'Herramientas de lectura con IA';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Potencia tu comprensión lectora con herramientas inteligentes';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Selecciona el nivel de dificultad deseado para simplificar';

  @override
  String get chooseDifficultyForSimplification =>
      'Selecciona el nivel de dificultad para simplificar';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Extraer todas las palabras desconocidas a un nuevo mazo de tarjetas';

  @override
  String get length => 'Duración';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Extracción web';

  @override
  String get aiTools => 'Herramientas de IA';

  @override
  String get stop => 'Detener';

  @override
  String get keepPracticing1 => 'Sigue practicando';

  @override
  String get aiPrepRoom => 'Sala de preparación con IA';

  @override
  String get lessonSummary => 'RESUMEN DE LA LECCIÓN';

  @override
  String get unlockSinosparkPremium => 'Desbloquear SinoSpark Premium';

  @override
  String get monthYear => 'Mes / Año';

  @override
  String get enableNotifications => 'Activar notificaciones';

  @override
  String get notificationsConfigured => 'Notificaciones configuradas';

  @override
  String get neverMissAStroke2 => 'No te pierdas ningún trazo';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Tus avisos diarios y alertas de racha están listos.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Mantén la constancia con tus lecciones diarias y recordatorios oportunos.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Una nueva palabra e historia te esperan en tu sesión diaria.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Avisos útiles antes de que olvides los caracteres aprendidos.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Recibe un recordatorio 2 días antes de que finalice tu prueba gratuita.';

  @override
  String get yourPathTonchineseFluency =>
      'Tu camino hacia la\nfluidez en chino';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Responde 3 preguntas rápidas para que nuestra IA diseñe\nun plan de estudio a la medida de tu rutina.';

  @override
  String get whatIsYourLevelnwithChinese => '¿Cuál es tu nivel\nde chino?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Elige la opción que mejor describa tus conocimientos actuales.';

  @override
  String get whatDrivesYourStudy => '¿Cuál es tu objetivo al estudiar?';

  @override
  String get purposeFuelsTheBrush => 'El propósito guía el pincel';

  @override
  String get setYourDailyRitual => 'Establece tu rutina diaria.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Puedes modificar tu rutina cuando quieras.';

  @override
  String get letsBegin => 'Empecemos';

  @override
  String get brandNew => 'Principiante absoluto';

  @override
  String get iveNeverStudiedChineseBefore => 'Nunca he estudiado chino.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Conozco algunos caracteres y expresiones básicas.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Puedo mantener conversaciones sencillas y leer textos básicos.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Deseo perfeccionar mis competencias y alcanzar la maestría.';

  @override
  String get confirmSelection => 'Confirmar selección';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'El propósito da impulso a cada trazo.';

  @override
  String get buildMyPath => 'Crear mi ruta';

  @override
  String get hskCertification => 'Certificación HSK';

  @override
  String get culturalAppreciation => 'Interés por la cultura';

  @override
  String get yourPlanIsReady => 'Tu plan está listo';

  @override
  String get craftingYourCurriculum => 'Diseñando tu plan de estudio...';

  @override
  String get personalizedPathInitialized => 'PLAN PERSONALIZADO LISTO';

  @override
  String get calibratingAiNeuralMasters =>
      'CONFIGURANDO TUTORES INTELIGENTES...';

  @override
  String get calibrationComplete => 'Configuración completada';

  @override
  String get synthesizingModules => 'Organizando módulos de estudio...';

  @override
  String get oneAndWater => '«Uno» y «Agua»';

  @override
  String get theHorizontalStroke => 'EL TRAZO HORIZONTAL (HÉNG)';

  @override
  String get theRadical => 'EL RADICAL';

  @override
  String get water => 'Agua';

  @override
  String get river => 'Río';

  @override
  String get day5Reminder => 'Recordatorio del día 5';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Te prometimos avisar con 2 días de antelación antes de que concluya tu periodo de prueba.';

  @override
  String get continueWithoutReminder => 'Continuar sin recordatorio';

  @override
  String get masterChineseWithnsinospark => 'Domina el chino con\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Comenzar prueba gratuita de 7 días';

  @override
  String get precisionStrokes => 'Trazado de precisión';

  @override
  String get aiPronunciation => 'Pronunciación asistida por IA';

  @override
  String get today => 'Hoy';

  @override
  String get fullAccess => 'Acceso total';

  @override
  String get day5 => 'Día 5';

  @override
  String get reminder => 'Aviso';

  @override
  String get day7 => 'Día 7';

  @override
  String get trialBegins => 'Comienza la prueba';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat no tiene una oferta o paquetes configurados. Por favor, revisa tu panel de control.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Se requiere permiso de cámara para el escaneo en tiempo real.';

  @override
  String get cameraAccessRequired => 'Acceso a la cámara necesario';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Por favor, concede acceso a la cámara en los ajustes de tu dispositivo para usar esta función.';

  @override
  String get alignChineseTextWithinFrame =>
      'Encuadra el texto en chino dentro del marco';

  @override
  String get inLibrary => 'En la biblioteca';

  @override
  String get novice => 'Principiante';

  @override
  String get apprentice => 'Aprendiz';

  @override
  String get artisan => 'Artesano';

  @override
  String get grandmaster => 'Gran Maestro';

  @override
  String get poem => 'Poema';

  @override
  String get theNarrative => 'La narración';

  @override
  String get classicMasterpiece => 'Obra cumbre clásica';

  @override
  String get classicAuthor => 'Autor clásico';

  @override
  String get classical => 'Clásico';

  @override
  String get classicLiterature => 'Literatura clásica';

  @override
  String inThisChapterOf(Object title) {
    return 'En este capítulo de $title';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'A medida que la trama avanza, revela reflexiones universales y enseñanzas atemporales.';

  @override
  String get general => 'General';

  @override
  String get mythology => 'Mitología';

  @override
  String get dailyLife => 'Vida cotidiana';

  @override
  String get tangPoetry => 'Poesía Tang';

  @override
  String get classicalLiterature => 'Literatura clásica';

  @override
  String get justNow => 'Hace un instante';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'Los Guerreros de Terracota de Qin Shi Huang';

  @override
  String get lifeInsideTheForbiddenCity => 'La vida en la Ciudad Prohibida';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Comprar un billete y viajar en el tren de alta velocidad en China';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Ir al médico por un resfriado';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Pedir jiaozi (dumplings) en un restaurante tradicional';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'La ceremonia tradicional del té Gongfu';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'El arte de escribir caracteres chinos con pincel';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'La vida y protección del panda gigante';

  @override
  String get storyNotFoundInDatabase =>
      'Historia no encontrada en la base de datos';

  @override
  String get storyTextIsEmpty => 'El texto de la historia está vacío';

  @override
  String get myCustomStories => 'Mis historias personalizadas';

  @override
  String get userProvidedText => 'Texto facilitado por el usuario';

  @override
  String get local => 'Local';

  @override
  String get voiceEngineAllowance => 'Límite y motor de voz';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD frente a voz estándar sin límite';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'La voz estándar es 100% gratuita y sin límite';

  @override
  String get read => 'Leer';

  @override
  String get koreKoreFemaleWarm => 'Kore (femenina, cálida)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (femenina, alegre)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (masculina, enérgica)';

  @override
  String get charonCharonMaleNewsstyle =>
      'Charon (masculina, estilo informativo)';

  @override
  String get puckPuckMaleSporty => 'Puck (masculina, deportiva)';

  @override
  String get localOndevice => 'Voz integrada en el dispositivo';

  @override
  String get localOndeviceTts => 'Síntesis de voz (TTS) local del dispositivo';

  @override
  String get off => 'Desactivado';

  @override
  String get endOfCurrentChapter => 'Fin del capítulo actual';

  @override
  String get standardVoice => 'Voz estándar';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'No se encontraron novelas con los filtros seleccionados.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'No se encontraron microlecturas con los filtros seleccionados.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'No se encontraron poemas con los filtros seleccionados.';

  @override
  String get audiobook => 'Audiolibro';

  @override
  String get audio => 'Audio';

  @override
  String get continueReading => 'Continuar leyendo';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Buscar en 96 novelas completas, autores y epopeyas...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Buscar poemas clásicos, autores y versos...';

  @override
  String get allLevelsVal => 'Todos los niveles';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Principiante)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Elemental)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Intermedio)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Intermedio alto)';

  @override
  String get listenToAudiobook => 'Escuchar audiolibro';

  @override
  String get synopsis => 'Sinopsis';

  @override
  String get peoplesArtist => 'Artista del Pueblo';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«Kafkaesco» para referirse a la deshumanización burocrática y la angustia existencial.';

  @override
  String get bigBrotherAndNewspeak => '«Gran Hermano» y «Neolengua».';

  @override
  String get audiobookIncluded => 'Audiolibro incluido';

  @override
  String get readPoem => 'Leer poema';

  @override
  String get studioVoiceAllowance => 'Saldo de voz Studio';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Lectura semanal en alta definición con IA';

  @override
  String get resetsEveryMondayAt0000 =>
      'Se reinicia todos los lunes a las 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Cuando se agote tu saldo semanal de 4 horas de voz Studio, la app pasará automáticamente a la voz integrada del dispositivo para seguir escuchando sin límite ni interrupciones.';

  @override
  String get localDeviceVoice => 'Voz local del dispositivo';

  @override
  String get classicalVerse => 'Verso clásico';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Voz del dispositivo (4 h semanales consumidas)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Crea una historia personalizada con IA según tus intereses';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'En lugar de limitarse a un nivel HSK rígido, el motor de aprendizaje dinámico evalúa tu propia colección de tarjetas.';

  @override
  String get we => 'Nosotros';

  @override
  String get howCanWeHelpYou => '¿En qué podemos ayudarte?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Todo lo que necesitas saber sobre SinoSpark, sus funciones y tu privacidad.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      '¿Quiénes son los narradores de la aplicación?';

  @override
  String get howDoesTheWebExplorerWork => '¿Cómo funciona el Explorador Web?';

  @override
  String get whatIsZenMode => '¿Qué es el Modo Zen?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      '¿Cómo funciona el sistema de repetición espaciada de las tarjetas?';

  @override
  String get traceComplete => '¡Trazo completado!';

  @override
  String get traceCharacter => 'Trazar carácter';

  @override
  String get analyzingWordRelationships => 'Analizando relaciones léxicas...';

  @override
  String get identifyingUsageContexts => 'Identificando contextos de uso...';

  @override
  String get comparingFormalityLevels =>
      'Comparando registros de formalidad...';

  @override
  String get findingCommonCollocations => 'Buscando colocaciones frecuentes...';

  @override
  String get generatingComparison => 'Generando comparativa...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'La generación está tardando más de lo habitual debido a la alta demanda de la IA.';

  @override
  String get generationInterruptedShowingPartial =>
      'Generación interrumpida. Mostrando resultado parcial.';

  @override
  String get sorrySomethingWentWrong =>
      'Lo sentimos, ocurrió un error inesperado.';

  @override
  String get usage => 'Uso:';

  @override
  String get alsoSeenIn => 'También aparece en';

  @override
  String get quickLook => 'Vista rápida';

  @override
  String get notFound => 'No encontrado';

  @override
  String get errorLoadingFromAi => 'Error al cargar la información de la IA.';

  @override
  String get newLabel => 'Nuevo';

  @override
  String get analyzingImage => 'Analizando imagen...';

  @override
  String get extractingChineseText => 'Extrayendo texto en chino...';

  @override
  String get lookingUpVocabulary => 'Consultando vocabulario...';

  @override
  String get dreamOfTheRedChamber => 'Sueño en el pabellón rojo';

  @override
  String get journeyToTheWest => 'Viaje al Oeste';

  @override
  String get romanceOfTheThreeKingdoms => 'Romance de los Tres Reinos';

  @override
  String get mingDynasty => 'Dinastía Ming';

  @override
  String get wuChengEn => 'Wu Cheng\'en';

  @override
  String get hundredChapters => '100 capítulos';

  @override
  String get volume1 => 'Volumen 1';

  @override
  String bookmarksCount(Object count) {
    return 'Marcadores ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Aún no tienes marcadores guardados. Pulsa el icono de marcador para guardar un fragmento.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark no responde';

  @override
  String get closeApp => 'Cerrar app';

  @override
  String get wait => 'Esperar';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours h';
  }

  @override
  String bookPercentRead(Object percent) {
    return '$percent% leído';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Cap. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count libros y audiolibros';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Frase $current de $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Capítulo $current de $total';
  }

  @override
  String get allLevels => 'Todos los niveles';

  @override
  String get searchGradedMicroStories =>
      'Buscar microhistorias graduadas y fábulas...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count historias graduadas y microlecturas diarias';
  }

  @override
  String get searchClassicalPoems =>
      'Buscar poemas clásicos, autores y versos...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count poemas clásicos y versos';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Explora páginas web chinas con diccionario táctil, Pinyin simultáneo y traducción inmediata.';

  @override
  String get completed => 'COMPLETADO';

  @override
  String get aiIsReading => 'La IA está leyendo...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Avanzado)';

  @override
  String get hsk1Beginner => 'HSK 1 (Principiante)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Intermedio alto)';

  @override
  String get extractAllUnknownWords =>
      'Extraer todas las palabras desconocidas a un nuevo mazo de tarjetas';

  @override
  String get designCustomAiRoleplay =>
      'Diseñar una experiencia personalizada de conversación y rol con IA';

  @override
  String get practiceFlashcardVocabulary =>
      'Practicar el vocabulario de las tarjetas en un diálogo en vivo';

  @override
  String get surpriseMe => 'Sorpréndeme';

  @override
  String get rollCharacter => 'Elegir personaje al azar';

  @override
  String get historicalCostume => 'Drama histórico / De época';

  @override
  String get modernYouth => 'Juvenil y contemporáneo';

  @override
  String get fantasyMythology => 'Fantasía y mitología';

  @override
  String get familyDrama => 'Familiar y drama';

  @override
  String get fullVersion => 'Versión completa';

  @override
  String episodesCount(Object count) {
    return '$count episodios';
  }

  @override
  String episodeLabel(Object number) {
    return 'Capítulo $number';
  }

  @override
  String get translating => '[ Traduciendo... ]';

  @override
  String get engSub => '[SUB ESP]';

  @override
  String get standardVocabulary => 'Vocabulario estándar';

  @override
  String get characters => 'caracteres';
}
