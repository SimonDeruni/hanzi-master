// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get originStoryChip => '📜 Historia del origen';

  @override
  String get ancientFormChip => '🏺 Forma antigua';

  @override
  String get threeMoreWordsChip => '📖 3 palabras más';

  @override
  String get wordFamilyChip => '🔗 Familia de palabras';

  @override
  String get idiomChip => '🀄 Modismo';

  @override
  String get proverbChip => '💬 Proverbio';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      '¿Hay algún modismo chino (成语) que contenga este carácter?';

  @override
  String get strokeOrderChip => '✏️ Orden de trazos';

  @override
  String get calligraphyTipChip => '🎨 Consejo de caligrafía';

  @override
  String get grammarNoteChip => '📝 Nota gramatical';

  @override
  String get similarWordsChip => '🔄 Palabras similares';

  @override
  String get culturalNoteChip => '🏮 Nota cultural';

  @override
  String get inMediaChip => '🀄 En medios';

  @override
  String get radicalMeaningChip => '🧩 Significado del radical';

  @override
  String get componentBreakdownChip => '🔍 Desglose de componentes';

  @override
  String get toneTipChip => '🎵 Consejo de tonos';

  @override
  String get homophonesChip => '👯 Homófonos';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Pregúntame lo que quieras sobre $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'Error del tutor de IA: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'El tutor de IA está ocupado en este momento. Espera un momento e inténtalo de nuevo.';

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
  String get shadowingStudio => 'Estudio de repetición';

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
  String get shadowing => 'Shadowing';

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
  String whereWouldYouLikeWords(int count) {
    return '¿Dónde quieres guardar estas $count palabras?';
  }

  @override
  String deckItemsCount(int count) {
    return '$count elementos';
  }

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
  String get studySession => 'Sesión de estudio';

  @override
  String get readyToStudy => 'Listo para estudiar';

  @override
  String get studyQueuePreviewDescription =>
      'Tu sesión se basa en la programación de hoy y los límites del mazo.';

  @override
  String get notNow => 'Ahora no';

  @override
  String get newLabel => 'Nuevo';

  @override
  String get studyDeckEmpty => 'Este mazo está vacío';

  @override
  String get studyDeckEmptyDescription =>
      'Añade tarjetas antes de iniciar una sesión de estudio.';

  @override
  String get studyDailyLimitReached => 'Límite diario completado';

  @override
  String get studyDailyLimitReachedDescription =>
      'Has alcanzado el límite diario de tarjetas nuevas o repasos para este mazo.';

  @override
  String get studyCaughtUpDescription =>
      'No hay nada más programado para hoy. Vuelve para tu próximo repaso.';

  @override
  String get noCardsAvailable => 'No hay tarjetas disponibles';

  @override
  String get studyNoEligibleCardsDescription =>
      'No hay tarjetas aptas para este modo de estudio en este momento.';

  @override
  String get studySessionLoadFailed =>
      'No se pudo cargar esta sesión de estudio. Inténtalo de nuevo.';

  @override
  String get retryLimitReached =>
      'Esta tarjeta reaparecerá en tu próxima sesión.';

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
    return 'Añadir a $target';
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
  String get warringStates => 'Reinos Combatientes';

  @override
  String get hanFeiLegalism =>
      'Han Fei (c. 280-233 a. C.) fue un príncipe del estado de Han y el principal pensador del legalismo chino. Al reunir las ideas de ley, técnica administrativa y autoridad, sus escritos en el Han Feizi influyeron profundamente en la filosofía política y las instituciones de la China imperial.';

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
      'Si la transcripción no coincide con lo que dijiste, selecciona la frase que querías decir y toca «¡Sí, vuelve a evaluarme!» para evaluar de nuevo la grabación original sin tener que repetirla.';

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
  String get libraryLabel => 'Biblioteca';

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
  String get maybeLater => 'Quizás más tarde';

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
  String get play => 'Reproducir';

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
  String get aiDataPrivacyTitle => 'Privacidad y datos de IA';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Consulta qué envían las funciones de IA, por qué y a quién';

  @override
  String get aiDataPrivacyOverviewTitle => 'Cuándo se usa la IA';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark solo usa IA en la nube cuando eliges una función que la requiere, como el chat de IA, explicaciones, traducción, análisis de imágenes, reconocimiento de voz, evaluación de pronunciación o voces en la nube. Los resultados de la IA pueden no ser precisos, por lo que te recomendamos revisar la información importante.';

  @override
  String get aiDataPrivacyProvidersTitle => 'Proveedores de servicios de IA';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini procesa solicitudes generativas de texto e imágenes. OpenRouter redirige algunas solicitudes generativas a Google Gemini o DeepSeek. Microsoft Azure AI Speech procesa el reconocimiento de voz, la evaluación de pronunciación y el texto enviado para la síntesis de voz en la nube.';

  @override
  String get aiDataPrivacySentTitle => 'Datos que pueden enviarse';

  @override
  String get aiDataPrivacySentBody =>
      'Según la función, enviamos el texto que introduces o seleccionas, el contexto relevante de la lección o conversación, las imágenes que eliges para análisis por IA, las grabaciones de voz que envías y datos técnicos de la solicitud, como la dirección IP y metadatos del dispositivo o de la red. No incluimos intencionadamente tu nombre o correo electrónico en las instrucciones de la IA.';

  @override
  String get aiDataPrivacyControlsTitle => 'Tus opciones';

  @override
  String get aiDataPrivacyControlsBody =>
      'No uses una función de IA si no quieres que sus datos se envíen al proveedor indicado. Puedes denegar los permisos de cámara, fotos o micrófono en los Ajustes del dispositivo. Elige la voz Local para mantener la síntesis de voz en tu dispositivo. Evita enviar información confidencial o sensible.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Almacenamiento y retención';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark no almacena intencionadamente en sus propios servidores las instrucciones de IA, imágenes enviadas ni grabaciones de voz tras su procesamiento. Los resultados generados pueden guardarse en tu dispositivo o en tu cuenta cuando decidas guardarlos. Los proveedores procesan los datos según sus propios términos y controles de retención configurados; consulta la política completa para obtener más detalles.';

  @override
  String get readFullPrivacyPolicy => 'Leer la política de privacidad completa';

  @override
  String get linkOpenFailed =>
      'No se pudo abrir el enlace. Inténtalo de nuevo.';

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
  String get toneGraphYourVoice => 'Your voice';

  @override
  String get toneGraphTarget => 'Target';

  @override
  String get toneGraphNoPitchMeasured =>
      'No pitch was measured in this take, so there is nothing to draw for your voice. The dashed stroke is still the shape you were aiming for.';

  @override
  String get toneGraphHowToReadPhraseNote =>
      'Here the dashed stroke is the shape of the phrase\'s tones, spaced evenly. We do not know where each syllable starts inside your recording, so the two strokes are not lined up in time — compare their shapes, not their positions. Your own stroke is the measured one.';

  @override
  String get toneGraphHowToReadTitle => 'How to read this graph';

  @override
  String get toneGraphHowToReadTooltip => 'How to read this graph';

  @override
  String get toneGraphHowToReadBody =>
      'Left to right is time. Up and down is pitch — how high your voice sits, not how loud it is. Read the direction of the stroke, not its height: tone 1 stays level and high, tone 2 rises, tone 3 dips low and often does not fully come back up, tone 4 falls from high. The first stroke is the tone you were aiming for. A second stroke is drawn only when a different tone was heard, so when you see two, the second is what was detected. Seeing only one stroke means either you matched the target or the tone was not measured — it never means you were wrong.';

  @override
  String get traceLabel => 'Trazar';

  @override
  String get trailer => 'TRÁILER';

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
  String get vlog => 'Vlog diario de China';

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
      '¿Qué puedo hacer si la IA interpreta mal lo que dije?';

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
      'El historial de conversaciones de Juego de rol que guardes permanece localmente en tu dispositivo para que puedas revisarlo. No usamos tus conversaciones personales para entrenar nuestros modelos de IA.';

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
      'Las grabaciones enviadas para evaluar la pronunciación se procesan de forma segura y SinoSpark no las conserva una vez finalizado el procesamiento. El historial de Juego de rol que decidas guardar puede permanecer en tu dispositivo y puedes eliminarlo en la app.';

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
  String get requiredLabel => 'Obligatorio';

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
  String get theDouble => 'La doble';

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
  String get liveOverlay => 'LECTURA AUMENTADA';

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

  @override
  String get todayDashboard => 'Hoy';

  @override
  String get studyToday => 'Estudiar las tarjetas de hoy';

  @override
  String get studyAhead => 'Estudiar por adelantado';

  @override
  String get studyAheadDescription =>
      'Practica los repasos programados más cercanos sin usar el cupo de hoy. No se introducen tarjetas nuevas.';

  @override
  String get studyAheadComplete => 'Práctica por adelantado completada';

  @override
  String get dueNow => 'Pendientes ahora';

  @override
  String get scheduled => 'Programadas';

  @override
  String get sevenDayForecast => 'Pronóstico de repasos a 7 días';

  @override
  String get reviews => 'Repasos';

  @override
  String get newCardsLabel => 'Tarjetas nuevas';

  @override
  String get attempts => 'Intentos';

  @override
  String get duration => 'Tiempo';

  @override
  String get answerBreakdown => 'Desglose de respuestas';

  @override
  String get reviewCards => 'Tarjetas a repasar';

  @override
  String get retries => 'Reintentos';

  @override
  String get needsPractice => 'Requiere práctica';

  @override
  String get uniqueCardsStudied => 'Tarjetas';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Dibuja en la otra dirección ➔';

  @override
  String get fastClean => '¡Rápido y limpio!';

  @override
  String get good2 => '¡Bien!';

  @override
  String get followTheFlow => 'Sigue el trazo.';

  @override
  String get masterful => '¡Magistral!';

  @override
  String get missingTheHookEnd => 'Falta el gancho o el final.';

  @override
  String get thai => 'Tailandés';

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
  String get ink => 'tinta,';

  @override
  String get stroke => 'trazo,';

  @override
  String get breath => 'respiración.';

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
  String get theExactSentenceProvided => 'la frase exacta proporcionada';

  @override
  String get pinyinWithToneMarks2 => 'pinyin con marcas de tono';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Extrae todos los caracteres chinos de esta imagen. Devuelve SOLO el texto extraído — sin comentarios, sin formato, sin traducciones. Conserva los saltos de línea. Si no hay caracteres chinos, devuelve una cadena vacía.';

  @override
  String get householdObject => 'objeto del hogar';

  @override
  String get genericLabelFromTheList => 'etiqueta genérica de la lista';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'clasificador';

  @override
  String get zenInk => 'Zen y Tinta';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      '¡CRÍTICO: Pon la traducción al inglés en la clave JSON \"english\"!';

  @override
  String get definitionInEnglish => 'definición en inglés';

  @override
  String get simplifiedLine0 => 'línea simplificada 0';

  @override
  String get simplifiedLine1 => 'línea simplificada 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'REGLA IMPORTANTE: No te dirijas al usuario por ningún nombre. Nunca uses nombres de ejemplo como \"Juan\". Háblale directamente sin usar nombres.';

  @override
  String get rULESAnswerIn23 =>
      'REGLAS: Responde en 2-3 frases como máximo. Usa viñetas para las listas.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Nunca escribas introducciones, despedidas o frases de relleno como \"¡Buena pregunta!\" o \"¡Por supuesto!\".';

  @override
  String get useBoldForChineseCharacters =>
      'Usa **negrita** para caracteres chinos y términos clave.';

  @override
  String get rULESAnswerIn232 => 'REGLAS: Responde en 2-3 frases como máximo.';

  @override
  String get accept => 'Aceptar';

  @override
  String get pronunciationAssessment => 'Evaluación de pronunciación';

  @override
  String get nBest => 'NMejores';

  @override
  String get none => 'Ninguno';

  @override
  String get theCorrectedChineseText => 'el texto en chino corregido';

  @override
  String get thePinyinForTheCorrected => 'el pinyin del texto corregido';

  @override
  String get theEnglishMeaningOfThe =>
      'el significado en inglés del texto corregido';

  @override
  String get pNyNWithTone => 'pīnyīn con marcas de tono';

  @override
  String get englishTranslation2 => 'traducción al inglés';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Eres un experto en literatura clásica china que ofrece resúmenes detallados y accesibles de poesía china clásica.';

  @override
  String get youAreAChineseCulture =>
      'Eres un experto en cultura y literatura china. Ofrece información cultural atractiva y bellamente redactada.';

  @override
  String get english2 => 'Inglés:';

  @override
  String get remindersWhenYouHavenT =>
      'Recordatorios cuando no has usado la app durante unos días';

  @override
  String get itSBeenAFew =>
      '¡Han pasado unos días! Tómate 5 minutos para aprender un nuevo Hanzi hoy.';

  @override
  String get abbreviationFor => 'abreviatura de';

  @override
  String get cL => 'CL:';

  @override
  String get measureWord2 => 'Clasificador:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'sin-usuario';

  @override
  String get passwordRequired => 'contraseña-requerida';

  @override
  String get unsupportedProvider => 'proveedor-no-compatible';

  @override
  String get appleRevocationUnavailable => 'revocación-apple-no-disponible';

  @override
  String get appleCredentialMissing => 'credencial-apple-faltante';

  @override
  String get authenticationDidNotReturnA =>
      'La autenticación no devolvió un usuario.';

  @override
  String get viewSubscriptionPlans => 'Ver planes de suscripción';

  @override
  String get wrongPassword => 'contraseña-incorrecta';

  @override
  String get invalidCredential => 'credencial-inválida';

  @override
  String get networkRequestFailed => 'error-de-conexión-de-red';

  @override
  String get requiresRecentLogin => 'requiere-sesión-reciente';

  @override
  String get userMismatch => 'usuario-no-coincide';

  @override
  String get deleteAccountPassword => 'contraseña-para-eliminar-cuenta';

  @override
  String get deleteAccountError => 'error-al-eliminar-cuenta';

  @override
  String get deleteAccountSubmit => 'confirmar-eliminación-de-cuenta';

  @override
  String get theSimplestShapesTheBeginning =>
      'Las formas más simples. El comienzo de todas las cosas.';

  @override
  String get sunMoonWaterAndFire =>
      'El Sol, la Luna, el Agua y el Fuego. El mundo natural.';

  @override
  String get theBodyTheHeartAnd => 'El cuerpo, el corazón y la familia.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Campos, tejados y herramientas. Los cimientos de la sociedad.';

  @override
  String get movementSpeechAndSustenance => 'Movimiento, habla y sustento.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Comercio, ropa y artefactos complejos.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 ¡Vía rápida! Carácter simple dominado.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ ¡Gran precisión! Trazo fantasma omitido.';

  @override
  String get sample => 'Muestra:';

  @override
  String get itsThat => 'Su/Ese';

  @override
  String get iMe => 'Yo/Mí';

  @override
  String get stillTough => 'Aún/Duro';

  @override
  String get partDecide => 'Parte/Decidir';

  @override
  String get selectTheCharacterFor => 'Selecciona el carácter para:';

  @override
  String get selectThePinyinFor => 'Selecciona el Pinyin para:';

  @override
  String get whereAreYouGoingThe =>
      '¿A dónde vas? ¿Al aeropuerto? ¡Es todo un viaje!';

  @override
  String get youAreAuntieChenA =>
      'Eres la tía Chen, una perspicaz vendedora de seda y telas en un mercado. Tu ÚNICO papel es el de vendedora. Negocia los precios con firmeza pero de forma justa en mandarín. NUNCA salgas del personaje ni te presentes como otra cosa que no sea una vendedora. Empieza con precios altos y muestra disposición a regatear.';

  @override
  String get youAreDrZhangA =>
      'Eres el Dr. Zhang, un médico tranquilo y profesional de una clínica. Tu ÚNICO papel es el de médico. Pregunta sobre los síntomas de salud y da consejos médicos en mandarín. NUNCA salgas del personaje ni te presentes como otra cosa que no sea un médico. Transmite tranquilidad pero sé exhaustivo.';

  @override
  String get whereDoYouFeelUncomfortable =>
      '¿Dónde sientes molestias? ¿Tienes fiebre?';

  @override
  String get youAreACloseFriend =>
      'Eres un amigo cercano poniéndose al día tras mucho tiempo. Tu ÚNICO papel es el de amigo. Mantén respuestas informales, cálidas y breves en mandarín. NUNCA salgas del personaje ni te presentes como otra cosa que no sea un amigo. Usa un lenguaje informal adecuado para amigos cercanos.';

  @override
  String get noNbest => 'sin nbest';

  @override
  String get timedOut => 'tiempo agotado';

  @override
  String get grading => 'Calificando...';

  @override
  String get label1st => '1.º ˉ';

  @override
  String get label2nd => '2.º ˊ';

  @override
  String get label3rd => '3.º ˇ';

  @override
  String get label4th => '4.º ˋ';

  @override
  String get speaking2 => 'Hablando...';

  @override
  String get sessionCompletedInYourNext =>
      'Sesión completada. En tu próxima práctica, habla con oraciones completas para recibir un diagnóstico detallado de pronunciación y tonos.';

  @override
  String get craneSoaring => 'vuelo de la grulla';

  @override
  String get gentleStream => 'arroyo suave';

  @override
  String get brushAndInk => 'pincel y tinta';

  @override
  String get myStudent => 'mi estudiante';

  @override
  String get honoredDisciple => 'distinguido discípulo';

  @override
  String get notEnoughInformation => 'información insuficiente';

  @override
  String get asAnAi => 'como una IA';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Buena sesión de práctica. Sigue enfocándote en contrastar claramente los tonos y en mantener un ritmo conversacional natural.';

  @override
  String get insideASleekFuxingBullet =>
      'A bordo de un elegante tren bala Fuxing a 350 km/h de Pekín a Shanghái.';

  @override
  String get harbinIceSnowWorldWonder =>
      'Maravilla del Mundo de Hielo y Nieve de Harbin';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'El famoso mercado de pulgas de fin de semana de Panjiayuan, repleto de pergaminos de caligrafía, jade y reliquias vintage.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Taller de porcelana azul y blanca de Jingdezhen';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Camerino y maquillaje de la Ópera de Pekín';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Una histórica botica Tongrentang con aroma a ginseng, bayas de goji y cientos de cajones de madera para hierbas.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Una vibrante sala privada de karaoke con luces de neón en Shenzhen, con micrófonos, platos de frutas y controles de pantalla.';

  @override
  String get animeCosplayExpoInGuangzhou =>
      'Expo de Anime y Cosplay en Guangzhou';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Sorpréndeme';

  @override
  String get eGALivelyBanquet =>
      'Ej.: Un banquete animado celebrando en Shanghái...';

  @override
  String get rollCharacter2 => '🎲 Personaje al azar';

  @override
  String get eGACuriousCousin =>
      'Ej.: Un primo curioso preguntando sobre tu carrera...';

  @override
  String get keepTrying => '¡Sigue intentándolo!';

  @override
  String get pending => 'Pendiente...';

  @override
  String get expected => '🎯 Esperado';

  @override
  String get hSK2Elementary => 'HSK 2: Elemental';

  @override
  String get hSK3Intermediate => 'HSK 3: Intermedio';

  @override
  String get hSK5Advanced => 'HSK 5: Avanzado';

  @override
  String get expressYourselfFullyWith5000 =>
      'Exprésate con fluidez con más de 5000 palabras.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Ilimitado';

  @override
  String get dueToday => 'Para hoy';

  @override
  String get newAvailable => 'Nuevas disponibles';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Da un único consejo corto y práctico sobre cómo mejorar la forma, posición o longitud de los trazos mal dibujados. Sé directo y útil, no seas excesivamente poético ni metafórico. No uses markdown.';

  @override
  String get localOnDeviceTTS => 'Local — TTS en el dispositivo';

  @override
  String get espaOl => 'Español';

  @override
  String get franAis => 'Francés';

  @override
  String get portuguS => 'Portugués';

  @override
  String get tiNgViT => 'Vietnamita';

  @override
  String get koreFemaleWarm => 'Kore — Femenina, cálida';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Femenina, alegre';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Masculino, animado';

  @override
  String get charonMaleNewsStyle => 'Charon — Masculino, estilo noticias';

  @override
  String get puckMaleSporty => 'Puck — Masculino, deportivo';

  @override
  String get systemVoice => 'Voz del sistema';

  @override
  String get generateAdd => 'Generar y añadir';

  @override
  String get moreExamples => '📝 Más ejemplos';

  @override
  String get usage2 => '❓ Uso';

  @override
  String get translation => '💬 Traducción';

  @override
  String get collocations => '📚 Colocaciones';

  @override
  String get mistakes => '❌ Errores';

  @override
  String get decrease => 'Disminuir';

  @override
  String get increase => 'Aumentar';

  @override
  String get label0MeansThisCardType =>
      '0 significa que este tipo de tarjeta está desactivado.';

  @override
  String get tapTheValueToEnter =>
      'Toca el valor para introducir un límite exacto.';

  @override
  String get exactDailyLimit => 'Límite diario exacto';

  @override
  String get enter0ToDisable => 'Introduce 0 para desactivar.';

  @override
  String get apply => 'Aplicar';

  @override
  String get selectDeck => 'Seleccionar mazo';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Claves de Azure Speech no configuradas. Añade AZURE_SPEECH_KEY y AZURE_SPEECH_REGION a .env';

  @override
  String get sTARTING => 'INICIANDO…';

  @override
  String get sTARTSESSION => 'COMENZAR SESIÓN';

  @override
  String get translating2 => 'Traduciendo...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'negocios y economía';

  @override
  String get hskPreparation => 'preparación para el HSK';

  @override
  String get liveInChina => 'vivir en China';

  @override
  String get comprehensiveExercise => 'ejercicio integral';

  @override
  String get howToUse => 'cómo usar';

  @override
  String get usesOf => 'usos de';

  @override
  String get appearedFirstOnMandarinBean => 'apareció primero en Mandarin Bean';

  @override
  String get news2 => 'noticias:';

  @override
  String get joke => 'chiste:';

  @override
  String get jokes => 'chistes:';

  @override
  String get academicScience => 'académico / ciencia';

  @override
  String get politicsCommunism => 'política y comunismo';

  @override
  String get foodDining => 'Comida y restaurantes';

  @override
  String get sciFi => 'ciencia ficción';

  @override
  String get scienceFictionTech => 'Ciencia ficción y tecnología';

  @override
  String get travelPlaces => 'Viajes y lugares';

  @override
  String get mythologyFantasy => 'Mitología y fantasía';

  @override
  String get cultureTraditions => 'Cultura y tradiciones';

  @override
  String get businessEconomy => 'Negocios y economía';

  @override
  String get natureAnimals => 'Naturaleza y animales';

  @override
  String get articleImg => 'imagen del artículo';

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
  String get xiXiPicturesOfficialChannel => 'Canal oficial de XiXi Pictures';

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
  String get getTheWeTVAPP => '腾讯视频 - Obtén la app de WeTV';

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
  String get learnMandarinWithTaiwanPlus => 'Aprende mandarín con TaiwanPlus';

  @override
  String get everydayChinese => 'Chino cotidiano';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting: Vida cotidiana en China';

  @override
  String get tFTFOODTRAVEL => 'TFT - COMIDA Y VIAJES';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: La vida del ajo';

  @override
  String get label2MINCULTURALCONTEXT => 'CONTEXTO CULTURAL DE 2 MIN';

  @override
  String get liziqi4 => '李子柒 Liziqi: Muebles de bambú';

  @override
  String get peppaPigChinese2 => 'Peppa Pig en chino: Charcos de barro';

  @override
  String get noBBCLeadArticleIs =>
      'No hay ningún artículo principal de la BBC disponible actualmente.';

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
  String get sIXSISTERS2 => '六姊妹 SEIS HERMANAS';

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
  String get shineOnMe => '骄阳似我 Brilla en mí';

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
  String get thoseDays => '四喜 Aquellos días';

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
  String get noFunnyNoMoney => '不好笑就露宿街头 Sin risas no hay dinero';

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
  String get getTheWeTVAPP2 => '腾讯视频 - 动漫 - Obtén la app WeTV';

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
      '«Lord of Mysteries» Vlog de doblaje de Cuttlefish (versión final) - Tencent Video Anime';

  @override
  String get lordOfMysteries =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 8 - Tencent Video Anime';

  @override
  String get lordOfMysteries2 =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 7 - Tencent Video Anime';

  @override
  String get lordOfMysteries3 =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 6 - Tencent Video Anime';

  @override
  String get lordOfMysteries4 =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 5 - Tencent Video Anime';

  @override
  String get lordOfMysteries5 =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 4 - Tencent Video Anime';

  @override
  String get lordOfMysteries6 =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 3 - Tencent Video Anime';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 2 - Tencent Video Anime';

  @override
  String get lordOfMysteries8 =>
      '«Lord of Mysteries» Clase de ocultismo Ep. 1 - Tencent Video Anime';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '[OST] «Lord of Mysteries» Tema final «No me olvides» - Tencent Video Anime';

  @override
  String get membersPremiere2 => 'Estreno exclusivo para miembros';

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
  String get eightHundred => '方圆八百米 Ochocientos';

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
  String get loveBeyondTheGrave => '白日提灯 Amor más allá de la tumba';

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
      'Extra del rodaje: Apodos por doquier para He Simu y Duan Xu【白日提灯 Amor más allá de la tumba】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'BTS｜【Fiesta de Dramas】¡Dilraba y Chen Feiyu con el elenco en fotos de los cinco sentidos!【白日提灯 Amor más allá de la tumba】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'BTS｜【Fiesta de Dramas】¡Dilraba y Chen Feiyu impactan con su mirada!【白日提灯 Amor más allá de la tumba】';

  @override
  String get herBlaze => '她的盛焰 Su resplandor';

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
  String get aboutLove => '玫瑰丛生 Sobre el amor';

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
      'Todo el elenco de «玫瑰丛生» está atrapado en la niebla del amor. ¿Cómo resolverán el dilema? | Protagonistas: Wang Ziwen, Liu Yuning';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 De generación en generación';

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
  String get loveStoryInThe1970s => '纯真年代的爱情 Amor en los años 70';

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
  String get whyIsHeStillSingle => '他为什么依然单身 ¿Por qué sigue soltero?';

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
  String get theGlamorousNight => '夜色正浓 La noche glamurosa';

  @override
  String get theGlamorousNightE03 =>
      '【夜色正浓 La noche glamurosa】E03 ¡Dominio total! El contraataque de Zhao Mei (Jiang Shuying, Tong Dawei)';

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
      'Clip 04: ¡El absurdo sistema añade drama! ¿Pañuelos convertidos en compresas? ¡Qué vergüenza! 【My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Clip 03: Va a una cita a ciegas por su amiga, ¿y resulta ser el protagonista? 【My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'BTS | Chen Xingxu y Wang Yuwen: ¿Quién es más caótico en el rodaje? 【My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Clip 02: Quería conquistar al protagonista, ¿pero se equivocó de persona? 【My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Clip 01: ¡Increíble! Transmigrada a un libro de repente, ¿cómo sigo este guion? 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'BTS | Chen Xingxu y Wang Yuwen se chocan tiernamente patinando sobre hielo 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'BTS | Dulce Año Nuevo de Chen Xingxu y Wang Yuwen 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'BTS | Chen Xingxu y Wang Yuwen inmortalizan un dulce momento en Qixi 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'BTS | Chen Xingxu y Wang Yuwen se divierten en el parque de atracciones 【My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '¡«My Page in the 90s» se estrena hoy! Chen Xingxu y Wang Yuwen disfrutan del dulce romance del sistema';

  @override
  String get myPageInThe90s3 =>
      '«My Page in the 90s» se estrena el 22 de enero: un romance fuera de lo común con Chen Xingxu y Wang Yuwen';

  @override
  String get myPageInThe90s4 =>
      '¡«My Page in the 90s» confirmada para el 22/01! Un romance a través del tiempo con Chen Xingxu y Wang Yuwen';

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
  String get label2TheImperialCoronerS2 => '御赐小仵作2 The Imperial Coroner T2';

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
  String get theDreamMaker => 'El creador de sueños The Dream Maker';

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
      '【轻年 Forever Young】E23 Martín regresa al hutong y es presionado por sus hermanos (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 ¡Preciso, firme y despiadado! Martín le enseña a su cuñada a controlar a su esposo (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 ¿Hay un rival en el amor? Martín es llamado tío por un mocoso (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

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
  String get hOMELANDGUARDIAN => '守诚者|GUARDIÁN DE LA PATRIA🚔';

  @override
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - Obtén la app de iQIYI';

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
  String get loveHasFireworks => '爱情有烟火 El amor tiene fuegos artificiales';

  @override
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - Obtén la app de WeTV';

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
  String get theHiddenHeirYeChen2 => 'El heredero oculto Ye Chen';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd =>
      'Escucha el viento del campo - Los sueños nunca terminan';

  @override
  String get mamaGo => '¡Mi mamá es la reina del campus! ¡Mama Go!';

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
      '¡Ya disponible el cálido cortometraje de narrativa doble de «Historia de amor en los años 70»!~';

  @override
  String get loveStoryInThe1970s3 =>
      'Se estrena oficialmente el cortometraje en pareja de «Historia de amor en los años 70»~ Escribamos una carta de amor con nuestros sentidos';

  @override
  String get bTSLoveStoryInThe =>
      'BTS | Fin de rodaje para todos, esperando el próximo reencuentro 【Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《Love Story in the 1970s》El amor es una poesía oculta en la cotidianidad~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《Love Story in the 1970s》¡Estreno oficial el 21 de febrero!~';

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
  String get theTruth => 'The Truth (Huellas en el viento)';

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
      'BTS｜Entrevista \'Fuera de personaje\': ¿quién es más disparatado, el Sr. Gao o Huan\'er? 《My Page in the 90s》 Tencent Video - Teatro Juvenil';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Escena destacada 04: ¡El absurdo sistema añade drama! ¿Un pañuelo convertido en compresa? ¡Qué momento más incómodo! 《My Page in the 90s》 Tencent Video - Teatro Juvenil';

  @override
  String get label03MyPageInThe2 =>
      'Escena destacada 03: Va a una cita a ciegas por su amiga y ¿resulta ser el protagonista? 《My Page in the 90s》 Tencent Video - Teatro Juvenil';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Escena destacada 02: Quería conquistar al protagonista, ¿pero se equivocó de persona? 《My Page in the 90s》 Tencent Video - Teatro Juvenil';

  @override
  String get label01MyPageInThe2 =>
      'Escena destacada 01: ¡Increíble! ¿Apareció de repente en un libro? ¿Cómo se supone que actúe? 《My Page in the 90s》 Tencent Video - Teatro Juvenil';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《My Page in the 90s》BTS｜Chen Xingxu y Wang Yuwen se chocan de lleno al patinar';

  @override
  String get myPageInThe90s6 =>
      '¡«My Page in the 90s» se estrena hoy! Chen Xingxu y Wang Yuwen en un dulce romance con el sistema';

  @override
  String get bTSMyPageInThe5 =>
      'BTS｜Interacción divertida y llena de química entre Chen Xingxu y Wang Yuwen 【My Page in the 90s】';

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
  String get dearSecretary => 'Mi querida secretaria Dear Secretary';

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
  String get foreverYoung2 => '轻年 Eterna juventud';

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
  String get lightOfDawn => '人之初 Luz del alba';

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
  String get sniperButterfly => '狙击蝴蝶 Mariposa francotiradora';

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
      '《狙击蝴蝶 Sniper Butterfly》 ¡Estreno el 04/12! Cruzar la línea por amor';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versión completa 1-15 ｜ Protagonistas: Chen Yanxi, Zhou Keyu - Tencent Video - Teatro Juventud';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versión completa 16-30 ｜ Protagonistas: Chen Yanxi, Zhou Keyu - Tencent Video - Teatro Juventud';

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
  String get loveIsAlwaysOnline2 => '对的时间对的人 Love is Always Online';

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
  String get loveOnTheTurquoiseLand => '枭起青壤 Amor en la tierra turquesa';

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
      '《Why Is He Still Single》 ¡Estreno el 16/11! ¡Cuento de amor maduro con Wallace Huo y Zhu Zhu!';

  @override
  String get whyIsHeStillSingle3 =>
      '《Why Is He Still Single》 Versión completa｜Protagonistas: Wallace Huo, Zhu Zhu - Tencent Video';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《Why Is He Still Single》 Versión completa 1｜Protagonistas: Wallace Huo, Zhu Zhu - Tencent Video';

  @override
  String get whyIsHeStillSingle5 =>
      '《Why Is He Still Single》 Versión completa 2｜Protagonistas: Wallace Huo, Zhu Zhu - Tencent Video';

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
  String get persona => 'Persona (重影)';

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
      '折腰 (Versión reducida) The Prisoner of Beauty';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '《The Prisoner of Beauty (Versión reducida)》Xiao Qiao se casa con el enemigo de su familia y choca con su esposo desde el primer día | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty3 =>
      '《The Prisoner of Beauty (Versión reducida)》Xiao Qiao desbarata la conspiración de Liu Yan y pasa de pelear con Wei Shao a protegerse mutuamente | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty4 =>
      '《The Prisoner of Beauty (Versión reducida)》Xiao Qiao finge enfermedad para disputar el patio principal; Wei Shao la defiende en público y rechaza concubinas | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty5 =>
      '《The Prisoner of Beauty (Versión reducida)》Xiao Qiao resuelve la trampa de la caja de madera y Wei Shao la reconoce como la señora de la casa | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty6 =>
      '《The Prisoner of Beauty (Versión reducida)》Xiao Qiao desvela astutamente la trampa y Wei Shao la protege; tensión en la familia | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty7 =>
      '《The Prisoner of Beauty (Versión reducida)》Wei Yan provoca problemas con una carta falsa; Xiao Qiao y Wei Shao sufren una crisis de confianza por un colgante | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty8 =>
      '《The Prisoner of Beauty (Versión reducida)》Su E\'huang intenta engañar a Xiao Qiao, pero Wei Shao la defiende y resuelve el caso, uniendo más a la pareja | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty9 =>
      '《The Prisoner of Beauty (Versión reducida)》Xiao Qiao y Wei Shao sufren un atentado y son envenenados; Xiao Qiao desbarata la conspiración y salva a su esposo | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '《The Prisoner of Beauty (Versión reducida)》Wei Shao regala un caballo de guerra y una horquilla; al desaparecer su esposa se desespera por encontrarla | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty11 =>
      '《The Prisoner of Beauty (Versión reducida)》Wei Shao siente celos por temor a que Xiao Qiao huya; se muda, se arrepiente y la extraña | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty12 =>
      '《The Prisoner of Beauty (Versión reducida)》Wei Shao, celoso, lleva a Xiao Qiao a cuestas; aclaran el misterio de la caja de madera y se acercan más | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty13 =>
      '《The Prisoner of Beauty (Versión reducida)》La visita de Qiao Ci despierta celos en Wei Shao; la pareja abre su corazón y promete amor eterno | Protagonistas: Song Zuer, Liu Yuning | Tencent Video - Teatro Juvenil';

  @override
  String get thePrisonerOfBeauty14 =>
      '«The Prisoner of Beauty (Versión reducida)» Wei Yan deja su hogar por Xiao Qiao, Shao y Qiao se reconcilian tras discutir | Protagonistas: Song Zuer, Liu Yuning — Tencent Video';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '«The Prisoner of Beauty (Versión reducida)» Motín en la noche de bodas y enemistad entre hermanas, Xiao Qiao repele al enemigo con astucia y Wei Shao admite su error | Protagonistas: Song Zuer, Liu Yuning — Tencent Video';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '«The Prisoner of Beauty (Versión reducida)» Wei Shao acompaña a Xiao Qiao a Kangjun para resolver sus dudas, el padre de Qiao acepta al yerno y la pareja consuma su matrimonio | Protagonistas: Song Zuer, Liu Yuning — Tencent Video';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '«The Prisoner of Beauty (Versión reducida)» Qiao Yue traiciona y Wei Liang muere, Da Qiao es secuestrada y Bi Zhi lucha desesperadamente para contraatacar | Protagonistas: Song Zuer, Liu Yuning — Tencent Video';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '«The Prisoner of Beauty (Versión reducida)» Wei Liang muere en batalla, Wei Qu pierde un brazo, Da Qiao cae del edificio y Liu Yan es destruido | Protagonistas: Song Zuer, Liu Yuning — Tencent Video';

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
      '¿Dijeron que fui lento en el trabajo en grupo? El CEO trepa por la ventana a medianoche para entregar la presentación y el guardia lo persigue — Tencent Video';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      'A mil millas de tu corazón (A Thousand Miles to Your Heart)';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video - Dramas de época - Consigue la app WeTV';

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
  String get theInescapable => 'El horquilla ineludible (The Inescapable)';

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
  String get pursuitOfJade2 => '逐玉 En busca del jade';

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
      '¡«江湖夜雨十年灯 Generation to Generation» se estrena el 22 de febrero! Mira a Mumu y Zhaozhao, la nueva generación más fuerte del jianghu, recorrer juntos el jianghu.';

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
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 Los 300 espíritus leales';

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
  String get danceOfThePhoenix => '且听凤鸣 La danza del fénix';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Extraordinario';

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
      '《御赐小仵作2 La forense imperial T2》estreno el 15/01, ¡la pareja Chu Yu regresa!';

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
  String get rebirthForYou => '嘉南传 Renacer para ti';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => '恋恋风陵渡 Un juramento en la oscuridad';

  @override
  String get theUltimateVowUnknownTo =>
      '君不知 El juramento definitivo, desconocido para ti';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => '长安少年行 Los jóvenes de Chang\'an';

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
  String get thePrincessDecree2 => '平凝有令 El decreto de la princesa';

  @override
  String get ppiNYsUwOA => 'PpiNYs-uwOA';

  @override
  String get label83tIjIiqM => '-_83tIjIiqM';

  @override
  String get p4cKjzSHFw => 'P4cKjz-sHFw';

  @override
  String get babysitter => '我在冷宫做月嫂 Niñera';

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
  String get herPhoenixMajesty2 => '凤皇传 Su Majestad la Fénix';

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
  String get aGirlLikeMe2 => '我就是这般女子 Una chica como yo';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 =>
      '飞狐外传 Historia secundaria del Zorro Volador';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 => '有花在洲 Una flor en el continente';

  @override
  String get aFlowerOnTheContinent3 =>
      '【有花在洲 Una flor en el continente】 El joven príncipe rehén es confundido con una princesa por la señorita Hua y terminan viviendo juntos';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 Una flor en el continente】 Se descubre el disfraz femenino de la señorita Hua; el joven príncipe arriesga su vida para protegerla y encima es acusado injustamente';

  @override
  String get aFlowerOnTheContinent5 =>
      '【A Flower On The Continent】 Hua Xiyu descubre que el asesino de su padre es el padre de Ning Xuanzhou y rompe con él de inmediato';

  @override
  String get aFlowerOnTheContinent6 =>
      '【A Flower On The Continent】 Hua Xiyu se viste de novia para ir al campamento enemigo y arriesga su vida para salvar a Ning Xuanzhou';

  @override
  String get aFlowerOnTheContinent7 =>
      '【A Flower On The Continent】 Ambos países firman la paz, pero Ning Xuanzhou rompe el edicto para casarse con Hua Xiyu';

  @override
  String get aFlowerOnTheContinent8 =>
      '【A Flower On The Continent】 Hua Xiyu se corta las venas para crear medicina, y Ning Xuanzhou denuncia a su padre por matar al de ella';

  @override
  String get aFlowerOnTheContinent9 =>
      '【A Flower On The Continent】 Hua Xiyu descubre la verdad sobre la muerte de su padre y rompe su promesa de amor en el mar de flores';

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
  String get sliceOfLife => 'Recuentos de la vida';

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
      'Momentos destacados 【锦月如歌 Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'BTS: ¡Especial de cumpleaños de Zhou Ye 🎂! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'BTS: ¡Especial de cumpleaños del gobernador Xiao (Cheng Lei) 🎂! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'BTS: Combate increíble en el campo de batalla, ¡nadie se resiste al gran dúo de Gran Wei! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'BTS: Plan de cita del 520 de Xi Xiao Yan Kai 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'BTS: Zhou Ye ebria es súper tierna, ¡su danza con espada enamora a todos y Cheng Lei no puede ocultar la sonrisa! 【锦月如歌 Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'Momentos destacados 【桃花映江山 The Princess\'s Gambit】';

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
      'Clip: ¡Vestida de rojo sobre la nieve! Jiang Taohua se despide de su hogar y se casa en Qi para proteger a su hermano 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'Clip: ¿Problemas con las esposas el día de la boda? Taohua responde con elegancia y calma 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'Clip: Descubren el falso desmayo de Taohua; Shen Zaiye la despierta con una aguja: ¡Sigue actuando! 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'Clip: ¡El ministro Shen investiga sin piedad! Mano dura contra la moneda falsa, los corruptos tiemblan 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Clip: El asesino enmascarado no escapa de la justicia; la detective Taohua: ¡Tus pies te delataron! 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'Clip: Interrogatorio con horquilla: Shen Zaiye le levanta la barbilla a Taohua y la cuestiona con frialdad 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Clip: ¡Primera reunión y ya tan osado! Shen Zaiye afectado por el veneno Huanhuan, miradas cruzadas 【桃花映江山 The Princess\'s Gambit】';

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
      '【COMPLETO Limitado】云襄传 | The Ingenious One | iQIYI 👑¡Únete a la membresía y disfruta de todos los episodios ahora!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - Obtén la app de iQIYI';

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
      '【COMPLETO】👮ROAD HOME💕 | Jing Boran, Seven Tan | iQIYI Filipinas';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI Filipinas - Obtén la app de iQIYI';

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
      '【Doblaje IA en inglés】Mr. BAD | Chen Zheyuan, Shen Yue | iQIYI Filipinas';

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
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | Episodios completos | iQIYI 👑¡Únete a la membresía y disfruta de los episodios completos ahora!';

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
      '【COMPLETO】🕊️My Dear Guardian | Johnny Huang, Li Qin | iQIYI Filipinas';

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
      '🌸【Romance reconfortante】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | Episodio COMPLETO | iQIYI 👑¡Hazte miembro y disfruta de episodios completos ya!';

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
      '📽️【EP01 2026】Drama chino Rebirth SUB ENG | Li Yunrui / Huangyang Tiantian / Zhang Kangle ⛵😍 Drama histórico 2026 #冰湖重生';

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
      '【COMPLETO】🏹Fated Hearts | Li Qin, Chen Zheyuan | iQIYI Filipinas';

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
      '【Completo】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Filipinas';

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
      '🎥✨【SUB ESP】Película china de fantasía | Fantasía, aventura【iQIYI MOVIE THEATER-Te invitamos a suscribirte】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 iQIYI MOVIE THEATER - Obtén la app de iQIYI';

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
      '🎀【微短剧 Mini Drama】SUB ENG | Colección completa | Descarga la app de WeTV / Tencent Video para ver más';

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
      '【Completo】Beauty of Resilience | Ju Jing Yi, Ficción | iQIYI Filipinas';

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
      '🔥 Tendencias【子夜归 Moonlit Reunion】Episodios completos | Humano y demonio se enamoran mientras resuelven misterios | Xu Kai, Tian Xiwei | SUB ENG';

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
  String get fallInLove => 'enamorarse';

  @override
  String get myGirl => 'mi chica';

  @override
  String get firstRomance2 => 'primer romance';

  @override
  String get fallFor => 'enamorarse de';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Amor oculto';

  @override
  String get loveBetweenFairyAndDevil2 => 'Amor entre el hada y el demonio';

  @override
  String get loveLikeTheGalaxy2 => 'Amor como la galaxia';

  @override
  String get myJourneyToYou2 => 'Mi viaje hacia ti';

  @override
  String get mysteriousLotusCasebook2 => 'Mysterious Lotus Casebook';

  @override
  String get reset => 'Restablecer';

  @override
  String get theLongBallad2 => 'La larga balada';

  @override
  String get theUntamed2 => 'The Untamed';

  @override
  String get wordOfHonor2 => 'Palabra de honor';

  @override
  String get lightOfDawn2 => '人之初 Luz del alba';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|GUARDIÁN DE LA PATRIA';

  @override
  String get searching2 => 'Buscando...';

  @override
  String get verse => 'Verso';

  @override
  String get allStories2 => 'Todas las historias';

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
      'artículo, .artículo, .post, .content, principal';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'Intermedio alto';

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
  String get processing => 'Procesando…';

  @override
  String get keepItUp => '好！¡Sigue así!';

  @override
  String get minutesDay => 'Minutos / día';

  @override
  String get consistencyIsTheInkThat =>
      '\"La constancia es la tinta que forma el carácter.\"';

  @override
  String get businessCareer => 'Negocios y carrera';

  @override
  String get travelSurvival => 'Viajes y supervivencia';

  @override
  String get label05MinDay => '05 min / día';

  @override
  String get label10MinDay => '10 min / día';

  @override
  String get label20MinDay => '20 min / día';

  @override
  String get label30MinDay => '30 min / día';

  @override
  String get dynamicDecksStrokeAnalysis =>
      'Mazos dinámicos y análisis de trazos';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Las suscripciones no están disponibles temporalmente. Inténtalo de nuevo.';

  @override
  String get trialReminder => 'Recordatorio de prueba';

  @override
  String get turnOnNotificationsIfYou =>
      'Activa las notificaciones si quieres recibir un recordatorio antes de que expire tu prueba elegible. La configuración de suscripciones de App Store sigue siendo la referencia oficial.';

  @override
  String get label2Months => '2 meses';

  @override
  String get label3Months => '3 meses';

  @override
  String get label6Months => '6 meses';

  @override
  String get billingPeriod => 'período de facturación';

  @override
  String get chooseASubscription => 'Elige una suscripción';

  @override
  String get startFreeTrial => 'Iniciar prueba gratis';

  @override
  String get smartNewsDict => 'Noticias inteligentes y dicc.';

  @override
  String get hSK16AIDecks => 'HSK 1-6 y mazos de IA';

  @override
  String get continueWithTemporaryPremium => 'Continuar con Premium temporal';

  @override
  String get testProductUnavailable => 'Producto de prueba no disponible';

  @override
  String get paymentIsChargedToYour =>
      'El pago se cargará a tu cuenta de App Store.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'Las suscripciones se renuevan automáticamente salvo cancelación';

  @override
  String get atLeast24HoursBefore =>
      'al menos 24 horas antes de que finalice el período actual.';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get closePurchaseOffer => 'Cerrar oferta de compra';

  @override
  String get loading => 'Cargando...';

  @override
  String get analyzingImage2 => 'Analizando imagen…';

  @override
  String get extractingChineseText2 => 'Extrayendo texto en chino…';

  @override
  String get lookingUpVocabulary2 => 'Buscando vocabulario…';

  @override
  String get deselectAll => 'Desmarcar todo';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Obra maestra de la literatura china y mundial.';

  @override
  String get classic => 'Clásico';

  @override
  String get literature => 'Literatura';

  @override
  String get theOriginAwakening => 'El origen y el despertar';

  @override
  String get turbulentHorizonsTheJourney => 'Horizontes turbulentos y el viaje';

  @override
  String get trialsTribulationsDevotion => 'Pruebas, tribulaciones y devoción';

  @override
  String get theClashOfWitsBravery => 'El duelo de ingenio y valentía';

  @override
  String get theGrandClimaxResolution => 'El gran clímax y la resolución';

  @override
  String get everlastingLegacyEpilogue => 'Legado eterno y epílogo';

  @override
  String get acrossTheVastExpanseOf =>
      'A lo largo de la gran extensión de cielo y tierra, los personajes persiguen su destino y convicciones mediante profundas pruebas.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Cada diálogo y encuentro de la historia transmite la brillantez del espíritu humano y la impronta de su época.';

  @override
  String get followingTheFlowOfProse =>
      'Siguiendo el flujo de la prosa, los lectores atraviesan siglos para compartir los triunfos y pesares de figuras legendarias.';

  @override
  String get preQin => 'Pre-Qin';

  @override
  String get theGoddessNWaRepairing => 'La diosa Nüwa reparando el cielo';

  @override
  String get artsTraditions => 'Arte y tradiciones';

  @override
  String get femaleWarm => 'Femenina, cálida';

  @override
  String get femaleCheerful => 'Femenina, alegre';

  @override
  String get maleUpbeat => 'Masculino, animado';

  @override
  String get maleNewsStyle => 'Masculino, estilo noticia';

  @override
  String get maleSporty => 'Masculino, deportivo';

  @override
  String get onDevice => 'En el dispositivo';

  @override
  String get label15Minutes => '15 minutos';

  @override
  String get label30Minutes => '30 minutos';

  @override
  String get label45Minutes => '45 minutos';

  @override
  String get selectChapter => 'Seleccionar capítulo';

  @override
  String get andContinuesToBeStudied =>
      'y se sigue estudiando y celebrando por lectores de distintas generaciones.';

  @override
  String get label1Poem => '1 poema';

  @override
  String get label1Chapter => '1 capítulo';

  @override
  String get localDeviceVoice2 => 'Voz local del dispositivo';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Límite semanal de Azure alcanzado — cambiando a voz local';

  @override
  String get sleepTimer2 => '定时关闭 · Temporizador de apagado';

  @override
  String get tableOfContents2 => '目录 · Índice';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Clásicos españoles, italianos y rusos';

  @override
  String get englishAmericanGlobalClassics =>
      'Clásicos ingleses, estadounidenses y globales';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'mientras integra estratégicamente las palabras que más te cuestan para que las aprendas en contexto.';

  @override
  String get poetryPainting => 'poesía y pintura';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Shadowing Studio es un espacio dedicado a practicar la imitación de hablantes nativos. Escuchas una frase, te grabas repitiéndola y comparas las ondas de voz y las puntuaciones de pronunciación para perfeccionar tu acento.';

  @override
  String get theVoicesInAIStories =>
      'Historias con IA y Juego de rol usan voces sintéticas generadas por modelos avanzados de texto a voz, ajustados para ofrecer una pronunciación china clara y natural. En algunas funciones también puede estar disponible la voz local del dispositivo.';

  @override
  String get theWebExplorerAllowsYou =>
      'El Explorador Web te permite navegar por cualquier sitio web chino. Cuando encuentres una palabra difícil, solo tócala para abrir la tarjeta de Vista Rápida, que ofrece pinyin, traducción y nivel de HSK al instante.';

  @override
  String get zenModeStripsAwayDistracting =>
      'El Modo Zen elimina los elementos web distractores, anuncios y diseños complejos de los artículos, ofreciéndote un entorno de lectura caligráfico y limpio centrado puramente en el texto.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Utilizamos un algoritmo inteligente que predice cuándo estás a punto de olvidar una palabra. Las palabras con las que tienes dificultad aparecerán con mayor frecuencia, mientras que las que dominas se programarán para más adelante.';

  @override
  String get usage3 => 'Uso:';

  @override
  String get tutorialOneExplanation =>
      'Este es el UNO (Yī). Dibuja siempre de izquierda a derecha.';

  @override
  String get tutorialWaterExplanation =>
      'Este es el carácter completo AGUA (Shuǐ). Cuando se usa como componente lateral izquierdo, ¡se transforma en \'氵\' (Tres Gotas)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Los hanzi se construyen a partir de piezas llamadas RADICALES. Le dan al carácter su significado o tema principal.';

  @override
  String get tutorialLettersExplanation =>
      'Los hanzi no son solo letras. Son imágenes congeladas en el tiempo. Para dominarlos, debes aprender a trazar su flujo.';

  @override
  String get tutorialGalaxyExplanation =>
      'El Mapa Galáctico te espera. Domina los Soles (Radicales) para desbloquear los Planetas (Caracteres).';

  @override
  String get onboardingDailyLifeTravel => 'Vida cotidiana y viajes';

  @override
  String get onboardingPhilosophyIdioms => 'Filosofía y modismos';

  @override
  String get onboardingBusinessCareerMulti => 'Negocios y\nCarrera';

  @override
  String get onboardingTravelSurvivalMulti => 'Viajes y\nSupervivencia';

  @override
  String get onboardingHskCertificationMulti => 'Certificación\nHSK';

  @override
  String get onboardingCulturalAppreciationMulti => 'Apreciación\ncultural';

  @override
  String get practiceReminders => 'Recordatorios de práctica';

  @override
  String get oneOptionalDailyReminderTo =>
      'Un recordatorio diario opcional para practicar chino';

  @override
  String get aFewMinutesOfChinese => '¿Unos minutos de chino? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Sigue progresando con una breve sesión de práctica.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'estudiar · aprender';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'descubrir';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'perseverar';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'crecer';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'tranquilo · apacible';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'comprender';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'calidez · cálido';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'concentrarse';

  @override
  String get definitionExpansionButton => 'botón de expansión de definición';

  @override
  String get wenigerAnzeigen => 'Mostrar menos';

  @override
  String get mostrarMenos => 'Mostrar menos';

  @override
  String get afficherMoins => 'Mostrar menos';

  @override
  String get mostraMeno => 'Mostrar menos';

  @override
  String get showFewer => 'Mostrar menos';

  @override
  String get masterLin => 'Maestro Lin';

  @override
  String get xiaoMei => 'Xiao Mei';

  @override
  String get thePoet => 'El poeta';

  @override
  String get aQiang => 'A-Qiang';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Formal y sabio';

  @override
  String get casualFriendly => 'Informal y amigable';

  @override
  String get poeticAncient => 'Poético y antiguo';

  @override
  String get slangInternet => 'Jerga e internet';

  @override
  String get trendyModern => 'Moderno y de moda';

  @override
  String get designYourOwn => 'Diseña el tuyo';

  @override
  String get theBambooSwaysAndThe =>
      'El bambú se mece y el erudito aguarda tus palabras como lluvia matutina...';

  @override
  String get yourCustomPersonaIsActive =>
      'Tu personaje personalizado está activo. Escribe para comenzar la conversación.';

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
      'Respuesta de expansión de diccionario obsoleta';

  @override
  String get dictionaryExpansionWasEmpty =>
      'La expansión del diccionario estaba vacía';

  @override
  String get explicationDTaillEDisponible => 'Explicación detallada disponible';

  @override
  String get ausfHrlicheErklRungVerf => 'Explicación detallada disponible';

  @override
  String get explicaciNDetalladaDisponible =>
      'Explicación detallada disponible';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Explicación detallada disponible';

  @override
  String get explicaODetalhadaDisponVel => 'Explicación detallada disponible';

  @override
  String get detailedExplanationAvailable => 'Explicación detallada disponible';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Un recordatorio diario de práctica opcional';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Elige un recordatorio de práctica diario opcional.';

  @override
  String get practiceReminder => 'Recordatorio de práctica';

  @override
  String get oneGentleReminderADay =>
      'Un amable recordatorio al día, solo si lo necesitas';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Completar la práctica silencia el recordatorio de hoy. Las alertas de repaso y';

  @override
  String get reEngagementAlertsAreCombined =>
      'de reactivación se combinan para no acumularse.';

  @override
  String get processing2 => 'Procesando…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Escuchar';

  @override
  String get notice => 'Observa';

  @override
  String get fourTones => 'Cuatro tonos';

  @override
  String get write => 'Escribir';

  @override
  String get recap => 'Resumen';

  @override
  String get playbackDidNotStart => 'La reproducción no se inició';

  @override
  String get audioIsUnavailableYouCan =>
      'El audio no está disponible. Aún puedes leer y continuar.';

  @override
  String get microphoneAccessWasNotGranted =>
      'No se otorgó acceso al micrófono. Puedes activarlo en Ajustes.';

  @override
  String get recordingIsUnavailableRightNow =>
      'La grabación no está disponible en este momento.';

  @override
  String get listeningToYourTones => 'Escuchando tus tonos…';

  @override
  String get noRecording => 'Sin grabación';

  @override
  String get weCouldNotScoreThat =>
      'No pudimos evaluar esa grabación, así que aquí tienes una comparación de tonos de muestra.';

  @override
  String get listenForTheLowDipping =>
      'Escucha el tercer tono, grave y descendente.';

  @override
  String get firstHearATinyMoment =>
      'Primero, escucha un breve momento en mandarín. Sin memorizar aún.';

  @override
  String get loadingAudio => 'Cargando audio…';

  @override
  String get listenToThePassage => 'Escucha el fragmento';

  @override
  String get continueAction => 'Continuar';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Observa cómo el significado, el sonido y los caracteres van de la mano.';

  @override
  String get shadowOneSentence => 'Imita una frase';

  @override
  String get listenOnceThenHoldThe =>
      'Escucha una vez, luego mantén pulsado el micrófono y di la frase.';

  @override
  String get hearItAgain => 'Escuchar de nuevo';

  @override
  String get stopAndCheckMyTones => 'Detener y revisar mis tonos';

  @override
  String get useMicrophone => 'Usar micrófono';

  @override
  String get iCanTSpeakRight => 'No puedo hablar ahora';

  @override
  String get tapACharacterToCompare =>
      'Toca un carácter para comparar tu tono con el objetivo y escuchar los tonos 1-4.';

  @override
  String get tryHandwriting => 'Probar escritura a mano';

  @override
  String get seeWhatYouLearned => 'Ver lo que aprendiste';

  @override
  String get inAFewMinutesYou =>
      'En unos minutos, usaste el mismo ciclo que impulsa tus lecciones.';

  @override
  String get listenedToChineseInContext => 'Escuchaste chino en contexto';

  @override
  String get shadowedASentence => 'Hiciste shadowing de una frase';

  @override
  String get comparedMandarinTones => 'Comparaste tonos en mandarín';

  @override
  String get practicedARealCharacter => 'Practicaste un carácter real';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'Al amanecer, la llovizna cesó. Abrí la ventana y escuché a los pájaros cantar en los árboles. Comenzó un nuevo día.';

  @override
  String get learnThroughRealVideos => 'Aprende con videos reales';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Sigue subtítulos interactivos, busca palabras al instante y convierte cada video en una lección.';

  @override
  String get videoLearningScreenshot =>
      'Captura de pantalla de aprendizaje con video';

  @override
  String get turnAnyBookIntoA =>
      'Convierte cualquier libro en una lección y audiolibro';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Lee de forma natural con pronunciación, definiciones y traducción disponibles cuando las necesites.';

  @override
  String get bookReaderScreenshot => 'Captura de pantalla del lector de libros';

  @override
  String get speakWithTheRightRhythm =>
      'Habla libremente con IA y tonos en vivo';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Haz shadowing de audio nativo y visualiza los cuatro tonos a medida que mejora tu pronunciación.';

  @override
  String get shadowingAndTonesScreenshot =>
      'Captura de pantalla de shadowing y tonos';

  @override
  String get understandEveryCharacter => 'Comprende cada carácter';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Explora el significado, la pronunciación, los componentes, el orden de trazos y vocabulario útil en un solo lugar.';

  @override
  String get characterDictionaryScreenshot =>
      'Captura de pantalla del diccionario de caracteres';

  @override
  String get learnChineseWithoutLimits => 'Aprende chino sin límites';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Mira, lee, habla y entiende chino con un compañero de aprendizaje completo.';

  @override
  String get seeWhatPremiumUnlocks => 'Descubre lo que desbloquea Premium';

  @override
  String get scrollToExploreTheComplete =>
      'Desplázate para explorar la experiencia de aprendizaje completa';

  @override
  String get cOMINGSOON => 'PRÓXIMAMENTE';

  @override
  String get guidedHandwritingPractice => 'Práctica de escritura guiada';

  @override
  String get scannerAndLiveTranslation => 'Escáner y traducción en vivo';

  @override
  String get hSK16AndAI => 'HSK 1–6 y mazos de IA';

  @override
  String get smartSpacedRepetition2 => 'Repetición espaciada inteligente';

  @override
  String get progressAndStreakTracking => 'Seguimiento de progreso y racha';

  @override
  String get learningToolsInOnePlace =>
      'Herramientas de aprendizaje en un solo lugar';

  @override
  String get everythingIncluded => 'Todo incluido';

  @override
  String get paymentIsChargedToYour2 =>
      'El pago se carga a tu cuenta de App Store. Las suscripciones se renuevan automáticamente a menos que se cancelen al menos 24 horas antes del final del período actual.';

  @override
  String get yourFirstWeekOfTracked =>
      'Tu primera semana de práctica registrada';

  @override
  String get sameNumberOfCardsAs =>
      'Mismo número de tarjetas que la semana pasada';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change tarjetas respecto a la semana pasada';
  }

  @override
  String get todaySPractice => 'Práctica de hoy';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Objetivo completado: todo lo demás es un extra.';

  @override
  String get aSmallAchievableTargetNo =>
      'Un objetivo pequeño y alcanzable. Sin penalización por un día de descanso.';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get minutes => 'Minutos';

  @override
  String get activeDays => 'Días activos';

  @override
  String dayStreakCount(int count) {
    return 'Racha de $count días';
  }

  @override
  String get masterChineseOneStrokeAt => 'Domina el chino, trazo a trazo';

  @override
  String get dictionaryExpansionButton => 'Botón de expansión del diccionario';

  @override
  String get kIErweiterterWRterbucheintrag =>
      'Entrada de diccionario ampliada por IA';

  @override
  String get detalleAmpliadoPorIA => 'Detalle ampliado por IA';

  @override
  String get dTailEnrichiParL => 'Detalle ampliado por IA';

  @override
  String get aI => 'Detalle de diccionario ampliado por IA';

  @override
  String get detailKamusYangDiperluasAI =>
      'Detalle de diccionario ampliado por IA';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'Detalle del diccionario ampliado por IA';

  @override
  String get aI2 => 'Detalle de diccionario ampliado por IA';

  @override
  String get aI3 => 'Detalle de diccionario ampliado por IA';

  @override
  String get detalheDeDicionRioExpandido =>
      'Detalle de diccionario ampliado por IA';

  @override
  String get aI4 => 'Detalle de diccionario ampliado por IA';

  @override
  String get chiTiTTI => 'Detalle de diccionario ampliado por IA';

  @override
  String get aI5 => 'Detalle de diccionario ampliado por IA';

  @override
  String get aIExpandedDictionaryDetail =>
      'Detalle de diccionario ampliado por IA';

  @override
  String get cetteEntrEEstBr =>
      'Esta entrada es breve. Hay una explicación detallada disponible.';

  @override
  String get dieserEintragIstKurzEine =>
      'Esta entrada es breve. Hay una explicación detallada disponible.';

  @override
  String get estaEntradaEsBreveHay =>
      'Esta entrada es breve. Hay una explicación detallada disponible.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Esta entrada es breve. Hay una explicación detallada disponible.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Esta entrada es breve. Hay una explicación detallada disponible.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Esta entrada del diccionario es breve. Hay una explicación detallada disponible.';

  @override
  String get dVelopperEnFranAis => 'Ampliar en francés';

  @override
  String get aufDeutschErweitern => 'Ampliar en alemán';

  @override
  String get ampliarEnEspaOl => 'Ampliar en español';

  @override
  String get approfondisciInItaliano => 'Ampliar en italiano';

  @override
  String get expandirEmPortuguS => 'Ampliar en portugués';

  @override
  String get expandDefinition => 'Ampliar definición';

  @override
  String get impossibleDeChargerLExplication =>
      'No se pudo cargar la explicación.';

  @override
  String get dieErklRungKonnteNicht => 'No se pudo cargar la explicación.';

  @override
  String get noSePudoCargarLa => 'No se pudo cargar la explicación.';

  @override
  String get impossibileCaricareLaSpiegazione =>
      'No se pudo cargar la explicación.';

  @override
  String get nOFoiPossVel => 'No se pudo cargar la explicación.';

  @override
  String get unableToLoadTheExplanation => 'No se pudo cargar la explicación.';

  @override
  String get failedToGenerateStoryN => 'No se pudo generar la historia:\\n\$e';

  @override
  String get thematic => 'Temático';

  @override
  String get deckFlashcards => 'Mazo (Tarjetas de estudio)';

  @override
  String get searchLibraryOrTypeCustom =>
      'Buscar en la biblioteca o escribir personalizado';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Análisis fallido: \$e';

  @override
  String get extractionFailedE => 'Falló la extracción: \$e';

  @override
  String get simplifyFailedE => 'Error al simplificar: \$e';

  @override
  String get translationFailedE => 'Error de traducción: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'No se pudieron guardar las palabras extraídas: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'Tú: $actual  ·  Objetivo: $expected';
  }

  @override
  String get improveTheLocalVoice => 'Mejorar la voz local';

  @override
  String get higherQualityOfflineMandarin =>
      'Mandarín sin conexión de alta calidad';

  @override
  String get removeDownload => '¿Eliminar descarga?';

  @override
  String get removeDownload2 => 'Eliminar descarga';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Femenina, cálida';

  @override
  String get voiceFemaleCheerful => 'Femenina, alegre';

  @override
  String get voiceMaleUpbeat => 'Masculino, dinámico';

  @override
  String get voiceMaleNewsStyle => 'Masculino, estilo noticias';

  @override
  String get voiceMaleSporty => 'Masculino, deportivo';

  @override
  String get voiceOnDeviceTts => 'TTS en el dispositivo';

  @override
  String get voiceSystemVoice => 'Voz del sistema';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Aplicar calificaciones de la sesión al sistema de repetición espaciada (modo habla)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'No se pudo cargar esta sección. Por favor, inténtalo de nuevo.';

  @override
  String get removeDownloadQuestion => '¿Eliminar descarga?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'Eliminar descarga';

  @override
  String get removeDownloadButton => 'Eliminar descarga';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'Resumen de IA';

  @override
  String get readability => 'Legibilidad';

  @override
  String get translateAction => 'Traducir';

  @override
  String get checkingDownload => 'Comprobando descarga';

  @override
  String downloadingBook(int percent) {
    return 'Descargando: $percent %';
  }

  @override
  String get retryDownload => 'Reintentar descarga';

  @override
  String get downloadBook => 'Descargar libro';

  @override
  String continueChapter(int chapter) {
    return 'Continuar por el cap?tulo $chapter';
  }

  @override
  String get downloadBookError =>
      'No se pudo descargar este libro. Comprueba tu conexi?n e int?ntalo de nuevo.';

  @override
  String downloadBookOffline(int count) {
    return 'Descarga el libro para leer sus $count cap?tulos sin conexi?n.';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poemas',
      one: '1 poema',
    );
    return '$_temp0';
  }

  @override
  String get americanLiterature => 'Literatura estadounidense';

  @override
  String get ancientChina => 'China antigua';

  @override
  String get britishLiterature => 'Literatura brit?nica';

  @override
  String get frenchLiterature => 'Literatura francesa';

  @override
  String get germanLiterature => 'Literatura alemana';

  @override
  String get italianLiterature => 'Literatura italiana';

  @override
  String get jinDynasty => 'Dinast?a Jin';

  @override
  String get preQinEra => '?poca pre-Qin';

  @override
  String get qingDynasty => 'Dinast?a Qing';

  @override
  String get republicOfChinaEra => 'Rep?blica de China';

  @override
  String get russianLiterature => 'Literatura rusa';

  @override
  String get spanishLiterature => 'Literatura espa?ola';

  @override
  String get springAndAutumn => 'Per?odo de Primaveras y Oto?os';

  @override
  String get westernHan => 'Han occidental';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'p. ej., Un animado banquete de celebración en Shanghái...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'p. ej., Un primo curioso que pregunta por tu carrera...';

  @override
  String get beginFirstLesson => 'Iniciar la primera lección';

  @override
  String get exploreLibraryDirectly => 'Explorar directamente la biblioteca';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'TU PRIMERA LECCIÓN  •  $current DE $total';
  }

  @override
  String get onboardingListenInstruction =>
      'Primero, escucha una de las líneas más célebres de la literatura china. Aún no intentes memorizar.';

  @override
  String get onboardingFromGrandLibrary => 'De la Gran Biblioteca';

  @override
  String get onboardingArtOfWarTitleAuthor => 'El arte de la guerra · Sun Tzu';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · Capítulo 3';

  @override
  String get onboardingClassicLineLabel => 'UNA LÍNEA CLÁSICA';

  @override
  String get onboardingArtOfWarTranslation =>
      '«Conoce al enemigo y conócete a ti mismo, y ni en cien batallas correrás peligro».';

  @override
  String get onboardingNoticeMeaning =>
      'Conoce al enemigo y conócete a ti mismo,';

  @override
  String get onboardingShadowMeaning =>
      'No correrás peligro ni en cien batallas.';

  @override
  String get onboardingPracticeThisLabel => 'PRACTICARÁS ESTO';

  @override
  String get onboardingFromArtOfWarLabel => 'DEL ARTE DE LA GUERRA';

  @override
  String get onboardingYourPronunciationLabel => 'TU PRONUNCIACIÓN';

  @override
  String get onboardingTapACharacter => 'Toca un carácter';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'Coincide';

  @override
  String get onboardingCompareTones => 'Comparar tonos';

  @override
  String get onboardingToneOneHigh => 'tono 1 · alto';

  @override
  String get onboardingToneTwoRising => 'tono 2 · ascendente';

  @override
  String get onboardingToneThreeDipping => 'tono 3 · descendente-ascendente';

  @override
  String get onboardingToneFourFalling => 'tono 4 · descendente';

  @override
  String get onboardingToneNotDetected => 'no detectado';

  @override
  String get onboardingFeedbackGreatThirdTone =>
      'Excelente tercer tono descendente-ascendente.';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'Deja que el cuarto tono caiga con firmeza y rapidez.';

  @override
  String get onboardingFeedbackClearFourthTone =>
      'Cuarto tono descendente claro y preciso.';

  @override
  String get onboardingFeedbackStrongFourthTone =>
      'Cuarto tono descendente firme y decidido.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return 'Traza $character ($pinyin, «$meaning»). Sigue la tenue guía de trazos.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas',
      one: '1 semana',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses',
      one: '1 mes',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count años',
      one: '1 año',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return 'Iniciar prueba gratuita de $period';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return 'Suscribirse por $price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'El producto seleccionado incluye una prueba gratuita elegible. Tras finalizar la prueba, se renovará por $price por $period a menos que se cancele.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'Aprender';

  @override
  String get booksAndStudioQualityAudiobooks =>
      '86 libros clásicos y audiolibros con calidad de estudio';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'Conversaciones con IA y retroalimentación de tono en tiempo real';

  @override
  String get interactiveVideoAndWebImmersion =>
      'Video interactivo e inmersión web';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'Análisis de caracteres y práctica de escritura a mano';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'Mazos HSK y repetición espaciada inteligente';

  @override
  String get termsOfUseEula => 'Términos de uso (EULA)';

  @override
  String get masterEveryStroke => 'Domina cada trazo';

  @override
  String get exploreTheChineseWeb => 'Explora la web china';

  @override
  String get tone1Description =>
      'Mantén tu tono alto y constante como al cantar una nota.';

  @override
  String get tone2Description =>
      'Empieza en el medio y desliza tu tono hacia arriba como al preguntar \'¿Qué?\'';

  @override
  String get tone3Description => 'Baja tu voz, luego súbela suavemente.';

  @override
  String get tone4Description =>
      'Baja tu tono de forma brusca y decisiva como un \'¡No!\' firme.';

  @override
  String get toneNeutralDescription =>
      'Pronuncia suavemente, brevemente y sin énfasis.';

  @override
  String get toneDiagMatch1 => '¡Exacto! El tono fue alto, plano y constante.';

  @override
  String get toneDiagMatch2 => '¡Exacto! El ascenso del tono fue claro.';

  @override
  String get toneDiagMatch3 =>
      '¡Exacto! La curva descendente baja fue precisa.';

  @override
  String get toneDiagMatch4 => '¡Exacto! La caída pronunciada fue decisiva.';

  @override
  String get toneDiagMatchDefault =>
      '¡Exacto! El tono fue pronunciado con precisión.';

  @override
  String get toneDiag1vs2 =>
      'Subiste el tono (2º tono /). Mantén tu voz plana y alta a lo largo de toda la sílaba (1er tono ˉ).';

  @override
  String get toneDiag1vs3 =>
      'Bajaste la voz (3er tono ˇ). Mantén tu tono constante y alto sin bajar (1er tono ˉ).';

  @override
  String get toneDiag1vs4 =>
      'Bajaste el tono (4º tono \\). Mantén un tono alto y nivelado como si cantaras una nota (1er tono ˉ).';

  @override
  String get toneDiag2vs1 =>
      'Te mantuviste plano (1er tono ˉ). Desliza tu tono hacia arriba como preguntando \'¿Qué?\' (2º tono /).';

  @override
  String get toneDiag2vs3 =>
      'Bajaste demasiado (3er tono ˇ). Empieza a nivel medio y sube suavemente sin tocar fondo (2º tono /).';

  @override
  String get toneDiag2vs4 =>
      'Bajaste el tono (4º tono \\). Sube hacia arriba como si hicieras una pregunta (2º tono /).';

  @override
  String get toneDiag3vs1 =>
      'Te mantuviste alto y plano (1er tono ˉ). Deja que tu tono baje a tu registro de pecho antes de subir (3er tono ˇ).';

  @override
  String get toneDiag3vs2 =>
      'Subiste inmediatamente (2º tono /). Asegúrate de bajar primero antes de volver a subir (3er tono ˇ).';

  @override
  String get toneDiag3vs4 =>
      'Bajaste bruscamente sin subir (4º tono \\). Permite que tu tono rebote suavemente al final (3er tono ˇ).';

  @override
  String get toneDiag4vs1 =>
      'Te mantuviste plano (1er tono ˉ). Baja tu tono de forma brusca y decisiva como un \'¡No!\' firme (4º tono \\).';

  @override
  String get toneDiag4vs2 =>
      'Subiste el tono (2º tono /). Empieza alto y baja bruscamente (4º tono \\).';

  @override
  String get toneDiag4vs3 =>
      'Bajaste y subiste (3er tono ˇ). Baja directamente sin volver a subir (4º tono \\).';

  @override
  String get toneDiagListenDiff =>
      'Escucha los 4 tonos a continuación para oír la diferencia.';

  @override
  String get liveCallSpeaking => 'Hablando...';

  @override
  String get toneAccurate => 'Tono correcto';

  @override
  String get toneNeedsWork => 'Tono a mejorar';

  @override
  String get liveCallSessionCompletedFallback =>
      'Sesión completada. En tu próxima práctica, habla con oraciones completas para recibir diagnósticos detallados de pronunciación y tonos.';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return 'Buen comienzo practicando \'$word\'. En tu próxima sesión, intenta unir oraciones completas para practicar las transiciones de tono y la fluidez natural.';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'Buen esfuerzo de conversación. Concéntrate en mantener los primeros tonos altos y estables (55) y los cuartos tonos firmes y decisivos (51) para mejorar tu claridad natural.';

  @override
  String get liveCallGoodPracticeFallback =>
      'Buena sesión de práctica. Continúa enfocándote en los contrastes claros de tono y en el ritmo natural de la conversación.';

  @override
  String sentenceNumber(Object number) {
    return 'Frase $number';
  }

  @override
  String endlessAiStreamSentence(Object count) {
    return 'Flujo continuo de IA • Frase $count';
  }

  @override
  String get aiConsentTitle => 'Práctica con IA y Privacidad';

  @override
  String get aiConsentSubtitle =>
      'SinoSpark utiliza servicios de IA de terceros seguros para la evaluación de pronunciación, juegos de rol y herramientas de estudio.';

  @override
  String get aiConsentDataSentTitle => 'Datos transmitidos';

  @override
  String get aiConsentDataSentBody =>
      'Grabaciones de voz, transcripciones del habla y solicitudes de estudio.';

  @override
  String get aiConsentProvidersTitle => 'Servicios de IA de terceros';

  @override
  String get aiConsentProvidersBody =>
      '• Microsoft Azure AI Speech (evaluación de pronunciación y síntesis de voz)\n• Google Gemini y DeepSeek (diálogos de conversación y generación de mazos)';

  @override
  String get aiConsentGuaranteesTitle => 'Garantías de privacidad';

  @override
  String get aiConsentGuaranteesBody =>
      'Sus datos se cifran en tránsito, se procesan de forma efímera, nunca se venden y nunca se utilizan para entrenar modelos públicos de IA.';

  @override
  String get aiConsentAgree => 'Aceptar y usar IA';

  @override
  String get aiConsentLearnMore => 'Más información';

  @override
  String get viewPlans => 'Ver planes';

  @override
  String get authInvalidCredentials =>
      'Correo o contraseña incorrectos. Si no tienes una cuenta, regístrate.';

  @override
  String get authInvalidEmail =>
      'Por favor, introduce un correo electrónico válido.';

  @override
  String get authEmailAlreadyInUse =>
      'Ya existe una cuenta con esta dirección de correo.';

  @override
  String get authWeakPassword =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get authTooManyRequests =>
      'Demasiados intentos fallidos. Por favor, inténtalo más tarde.';

  @override
  String get authNetworkError =>
      'Error de red. Por favor, comprueba tu conexión.';

  @override
  String get subscriptionRequired => 'Suscripción requerida';

  @override
  String get subscriptionRequiredDesc =>
      'Se requiere una suscripción activa a SinoSpark para acceder a todas las lecciones, libros y herramientas de voz de IA.';

  @override
  String signedInAs(String email) {
    return 'Conectado como $email';
  }

  @override
  String get battle => 'Batalla';

  @override
  String addedWordsAndUpdatedWords(
      int addedCount, int updatedCount, String deckName) {
    return 'Se añadieron $addedCount palabras nuevas y se actualizaron $updatedCount existentes en «$deckName»';
  }

  @override
  String addedWordsToDeck(int count, String deckName) {
    return 'Se añadieron $count palabras a «$deckName»';
  }

  @override
  String updatedWordsInDeck(int count, String deckName) {
    return 'Se actualizaron $count palabras existentes en «$deckName»';
  }

  @override
  String addedCardToDeck(String hanzi, String deckName) {
    return '«$hanzi» añadido a «$deckName»';
  }

  @override
  String get callCategory => 'LLAMADA EN VIVO';

  @override
  String get aiCallFluencyTitle => 'Llamadas de IA para mejorar la fluidez';

  @override
  String get aiCallFluencyDesc =>
      'Participa en conversaciones de voz realistas con tutores de IA, recibe calificación instantánea de tonos y desarrolla fluidez al hablar.';

  @override
  String get decksCategory => 'MAZOS';

  @override
  String get decksSpacedRepetitionTitle => 'Mazos con repetición espaciada';

  @override
  String get decksSpacedRepetitionDesc =>
      'Domina el HSK 1–6 y mazos personalizados con algoritmos de repetición espaciada científicamente probados.';

  @override
  String get booksCategory => 'LIBROS';

  @override
  String get classicalBooksPoemsTitle => '86 libros clásicos y 100 poemas';

  @override
  String get classicalBooksPoemsDesc =>
      'Sumérgete en literatura y poesía atemporales con audio sincronizado y anotaciones bilingües.';

  @override
  String get scanCategory => 'ESCÁNER';

  @override
  String get scannerScanCardsTitle =>
      'Escanea imágenes y añade tarjetas a tu mazo';

  @override
  String get scannerScanCardsDesc =>
      'Apunta tu cámara a cualquier texto, menú o letrero en chino para extraer palabras al instante y guardarlas en tus mazos.';

  @override
  String get smartDictionaryStrokeOrderTitle =>
      'Diccionario inteligente con orden de trazos';

  @override
  String get liveAiVoiceCallsAndToneGrading =>
      'Llamadas de voz con IA en vivo y calificación de tonos al instante';

  @override
  String get shadowingStudioAndToneAnalysis =>
      'Estudio de shadowing y análisis visual de tonos';

  @override
  String get startMy7DaysFreeTrial => 'Comenzar mis 7 días gratis';

  @override
  String trialSubtextUnderCta(String price, String period) {
    return 'Luego $price / $period. Cancela en cualquier momento en Ajustes.';
  }

  @override
  String get deckLibraryTitle => 'Biblioteca de mazos';

  @override
  String get deckLibrarySubtitle =>
      'Colecciones seleccionadas de HSK, cultura, deportes y académicas';

  @override
  String get downloadOfficialDecks =>
      'Descargar mazos oficiales de HSK y temáticos';

  @override
  String wordsSelectedCount(int selected, int total) {
    return '$selected de $total palabras seleccionadas';
  }

  @override
  String get comparisonLabel => 'COMPARACIÓN';

  @override
  String get ambientSoundscape => 'Ambiente sonoro';

  @override
  String get ambientSoundscapeDesc =>
      'Atmósfera relajante para leer y escuchar';

  @override
  String get ambientSoundscapeOff => 'Desactivado (Silencio)';

  @override
  String get soundscapeCourtyardRain => 'Lluvia de patio';

  @override
  String get soundscapeGuqinWind => 'Guqin y viento de bambú';

  @override
  String get soundscapeMidnightZen => 'Meditación nocturna';

  @override
  String get ambientVolume => 'Volumen de fondo';

  @override
  String get rateSinoSpark => 'Valorar SinoSpark';

  @override
  String get rateSinoSparkDesc => 'Comparte tu opinión en App Store';

  @override
  String get sendFeedback => 'Enviar comentarios';

  @override
  String get sendFeedbackDesc => 'Ayúdanos a mejorar o reporta un problema';

  @override
  String get enjoyingAppTitle => '¿Disfrutas de SinoSpark?';

  @override
  String get enjoyingAppSubtitle =>
      '¿Cómo va tu viaje de aprendizaje de chino hasta ahora?';

  @override
  String get ratingLovingIt => '¡Sí, me encanta!';

  @override
  String get ratingCouldBeBetter => 'Podría ser mejor';

  @override
  String get dictionarySearchFailed =>
      'La búsqueda en el diccionario ha fallado. Vuelve a intentarlo.';

  @override
  String get tapToHearVoiceSample => 'Toca ▶ para escuchar una muestra';

  @override
  String get soundEffects => 'Efectos de sonido';

  @override
  String get soundEffectsDesc =>
      'Papel suave, sello de madera y sonidos de caligrafía';

  @override
  String get generatingYourScenario => 'Creando tu escenario…';

  @override
  String get failedToGenerateScenario =>
      'No pudimos crear este escenario. Inténtalo de nuevo.';

  @override
  String get trickyCharacters => 'Caracteres difíciles';

  @override
  String get strongestCharacters => 'Caracteres mejor dominados';

  @override
  String get newThisWeek => 'Nuevos en los últimos 7 días';

  @override
  String get averageAttemptsPerWord => 'Intentos medios por palabra';

  @override
  String get noCardsYet => 'Aún no hay tarjetas en este mazo';

  @override
  String get libraryFilterOfficialHsk => 'HSK oficial';

  @override
  String get libraryFilterCulture => 'Cultura';

  @override
  String get libraryFilterSports => 'Deportes';

  @override
  String get libraryFilterEducation => 'Educación';

  @override
  String get libraryFilterTravel => 'Viajes';

  @override
  String get libraryFilterBusiness => 'Negocios';

  @override
  String get librarySearchHint => 'Busca mazos, temas o palabras hanzi...';

  @override
  String libraryNoMatch(String query) {
    return 'No se encontraron mazos para “$query”';
  }

  @override
  String get libraryResetFilters => 'Restablecer filtros';

  @override
  String get shelfHskTitle => 'Plan de estudios oficial de HSK';

  @override
  String get shelfHskSubtitle => 'Estándares oficiales de chino (HSK 1 - 6)';

  @override
  String get shelfCultureTitle => 'Cultura y patrimonio';

  @override
  String get shelfCultureSubtitle =>
      'Artes tradicionales, bienestar TCM, té y festivales';

  @override
  String get shelfSportsTitle => 'Deportes y artes marciales';

  @override
  String get shelfSportsSubtitle =>
      'Wushu kung fu, deportes de pelota, gimnasio y atletismo';

  @override
  String get shelfEducationTitle => 'Educación y academia';

  @override
  String get shelfEducationSubtitle =>
      'Investigación, ciencia, tecnología y lingüística';

  @override
  String get shelfTravelTitle => 'Viajes y vida urbana';

  @override
  String get shelfTravelSubtitle =>
      'Chino de supervivencia, restaurantes, compras y metro';

  @override
  String get shelfBusinessTitle => 'Negocios y profesional';

  @override
  String get shelfBusinessSubtitle =>
      'Contratos, negociación, entorno laboral y finanzas';

  @override
  String get shelfInstalled => 'Instalado en la biblioteca';

  @override
  String get shelfAvailable => 'Disponible para descargar';

  @override
  String shelfSampleVocabulary(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Vocabulario de muestra ($countString palabras)';
  }

  @override
  String get shelfRemoveFromBookshelf => 'Quitar de la biblioteca';

  @override
  String get shelfDownloadInstall => 'Descargar e instalar mazo';

  @override
  String get shelfGetButton => 'Obtener';

  @override
  String shelfDeckCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString mazos';
  }

  @override
  String shelfAddedThematic(String title) {
    return 'Se añadió “$title” a tu biblioteca.';
  }

  @override
  String shelfRemovedThematic(String title) {
    return 'Se quitó “$title”.';
  }

  @override
  String get hskDescription1 =>
      'Domina 154 hanzi básicos, saludos diarios, números y estructuras simples.';

  @override
  String get hskDescription2 =>
      'Domina 162 palabras elementales para la comunicación diaria.';

  @override
  String get hskDescription3 =>
      'Domina 299 palabras intermedias para conversar con soltura.';

  @override
  String get hskDescription4 =>
      'Domina 602 palabras de nivel intermedio alto para conversar con fluidez.';

  @override
  String get hskDescription5 =>
      'Domina 1.300 palabras avanzadas para leer prensa, revistas y cine.';

  @override
  String get hskDescription6 =>
      'Domina 2.500 palabras para entender cualquier chino y matizar.';

  @override
  String get storyCategoryIdiomStories => 'Historias de modismos';

  @override
  String get storyCategoryContemporaryStories => 'Historias contemporáneas';

  @override
  String get storyCategoryClassicalLiterature => 'Literatura clásica';

  @override
  String get storyCategoryEnglishWorld => 'Inglés y mundo';

  @override
  String get storyCategoryFrenchClassics => 'Clásicos franceses';

  @override
  String get storyCategoryAncientPhilosophy => 'Filosofía antigua';

  @override
  String get storyCategoryModernChinese => 'Chino moderno';

  @override
  String get storyCategoryGermanClassics => 'Clásicos alemanes';

  @override
  String get storyCategorySpanishWorld => 'Español y mundo';

  @override
  String get storyCategoryChineseEpics => 'Epopeyas chinas';

  @override
  String get storyCategorySupernaturalFolklore => 'Sobrenatural y folclore';

  @override
  String get storyCategoryChinesePoetry => 'Poesía china';

  @override
  String get storyCategoryTangPoetry => 'Poesía Tang';
}
