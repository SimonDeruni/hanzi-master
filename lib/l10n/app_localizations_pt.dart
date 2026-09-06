// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get originStoryChip => '📜 História de origem';

  @override
  String get ancientFormChip => '🏺 Forma antiga';

  @override
  String get threeMoreWordsChip => '📖 Mais 3 palavras';

  @override
  String get wordFamilyChip => '🔗 Família de palavras';

  @override
  String get idiomChip => '🀄 Expressão idiomática';

  @override
  String get proverbChip => '💬 Provérbio';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'Existe alguma expressão idiomática chinesa (成语) que contenha este caractere?';

  @override
  String get strokeOrderChip => '✏️ Ordem dos traços';

  @override
  String get calligraphyTipChip => '🎨 Dica de caligrafia';

  @override
  String get grammarNoteChip => '📝 Nota gramatical';

  @override
  String get similarWordsChip => '🔄 Palavras similares';

  @override
  String get culturalNoteChip => '🏮 Nota cultural';

  @override
  String get inMediaChip => '🀄 Na mídia';

  @override
  String get radicalMeaningChip => '🧩 Significado do radical';

  @override
  String get componentBreakdownChip => '🔍 Análise de componentes';

  @override
  String get toneTipChip => '🎵 Dica de tom';

  @override
  String get homophonesChip => '👯 Homófonos';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Pergunte qualquer coisa sobre $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'Erro do tutor de IA: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'O tutor de IA está ocupado no momento. Aguarde um instante e tente novamente.';

  @override
  String get deleteAccount => 'Excluir conta';

  @override
  String get deleteAccountSubtitle => 'Exclua sua conta permanentemente';

  @override
  String get deleteAccountTitle => 'Excluir sua conta permanentemente?';

  @override
  String get accountDataDeletedTitle => 'Os dados da conta serão excluídos';

  @override
  String get accountDataDeletedBody =>
      'Sua conta de acesso e todas as informações armazenadas pelo SinoSpark serão excluídas permanentemente. Esta ação não pode ser desfeita.';

  @override
  String get localDataKeptTitle => 'Os dados neste dispositivo serão mantidos';

  @override
  String get localDataKeptBody =>
      'O progresso de estudo, os conteúdos baixados e as preferências salvas apenas neste dispositivo não serão removidos.';

  @override
  String get subscriptionNotCanceledTitle =>
      'As assinaturas não são canceladas automaticamente';

  @override
  String get subscriptionNotCanceledBody =>
      'A exclusão da sua conta não cancela uma assinatura da App Store. Ela poderá continuar sendo renovada até que você a cancele nas configurações da Apple.';

  @override
  String get manageSubscription => 'Gerenciar assinatura na App Store';

  @override
  String get subscriptionManagementFailed =>
      'Não foi possível abrir o gerenciamento de assinaturas da Apple. Abra Ajustes, toque no seu nome e, em seguida, em Assinaturas.';

  @override
  String get confirmPassword => 'Senha atual';

  @override
  String get confirmPasswordToDelete =>
      'Digite sua senha para confirmar sua identidade.';

  @override
  String get deleteAccountPermanently => 'Excluir conta permanentemente';

  @override
  String get deleteAccountFinalTitle => 'Confirmação final';

  @override
  String get deleteAccountFinalWarning =>
      'Isso excluirá sua conta permanentemente e não poderá ser desfeito. Os dados armazenados apenas neste dispositivo serão mantidos. Deseja continuar?';

  @override
  String get deletingAccount => 'Excluindo conta...';

  @override
  String get accountPasswordRequired =>
      'Digite sua senha atual para continuar.';

  @override
  String get accountPasswordIncorrect =>
      'A senha está incorreta. Tente novamente.';

  @override
  String get accountReauthenticationCanceled =>
      'A confirmação de identidade foi cancelada. Sua conta não foi excluída.';

  @override
  String get accountReauthenticationFailed =>
      'Não foi possível confirmar sua identidade. Tente novamente e conclua o login.';

  @override
  String get accountAlreadySignedOut =>
      'Você já saiu da conta. Nenhuma conta conectada foi excluída.';

  @override
  String get accountProviderUnsupported =>
      'Este método de login não pode ser verificado no aplicativo. Entre em contato com o suporte para obter ajuda na exclusão da conta.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'Por motivos de segurança, contas vinculadas à Apple devem ser excluídas em um dispositivo Apple.';

  @override
  String get accountDeletionNetworkError =>
      'Verifique sua conexão com a internet e tente excluir a conta novamente.';

  @override
  String get accountDeletionFailed =>
      'Não foi possível excluir a conta. Sua conta permanece ativa. Tente novamente.';

  @override
  String get accountDeletedSuccessfully =>
      'Sua conta foi excluída permanentemente.';

  @override
  String get globalMastery => 'DOMÍNIO GLOBAL';

  @override
  String get masteredCards => 'Dominadas';

  @override
  String get hsk1Candidate => 'Candidato ao HSK 1';

  @override
  String get hsk2Candidate => 'Candidato ao HSK 2';

  @override
  String get hsk3Candidate => 'Candidato ao HSK 3';

  @override
  String get hsk4Candidate => 'Candidato ao HSK 4';

  @override
  String get hsk5Candidate => 'Candidato ao HSK 5';

  @override
  String get hsk6Candidate => 'Candidato ao HSK 6';

  @override
  String get hsk6Master => 'Mestre HSK 6';

  @override
  String get currentRank => 'CLASSIFICAÇÃO ATUAL';

  @override
  String get next => 'Avançar';

  @override
  String get searchHanziOrPinyin => 'Buscar Hanzi ou Pinyin...';

  @override
  String get dailyReview => 'Revisão Diária';

  @override
  String get upcomingForecast => 'Previsão de Revisão';

  @override
  String get laterToday => 'Mais tarde hoje';

  @override
  String get tomorrow => 'Amanhã';

  @override
  String get next7Days => 'Próximos 7 dias';

  @override
  String get theScholarWay => 'O Caminho do Erudito';

  @override
  String get beginJourney => 'Iniciar jornada';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get darkModeDesc => 'Confortável para a visão';

  @override
  String get voiceSpeed => 'Velocidade da voz';

  @override
  String get artAndIntellect => 'ARTE E INTELECTO';

  @override
  String get theDigitalScholar => 'O Erudito Digital';

  @override
  String get refineBrushVoice => 'Aprimore seu traço e sua pronúncia com IA.';

  @override
  String get liveVoiceCall => 'Chamada de Voz em Tempo Real';

  @override
  String get immersiveRoleplay => 'Roleplay imersivo com avatares de IA';

  @override
  String get readingRoom => 'Sala de Leitura';

  @override
  String get shadowingStudio => 'Estúdio de Shadowing';

  @override
  String get errorPrefix => 'Erro: ';

  @override
  String get initializingLibrary => 'Inicializando biblioteca...';

  @override
  String get unlockCharactersToQuiz =>
      'Desbloqueie 4 caracteres para fazer um quiz!';

  @override
  String get practiceQuiz => 'QUIZ';

  @override
  String get curriculumPaths => 'ROTAS DE APRENDIZADO';

  @override
  String get noDecksFound => 'Nenhum baralho encontrado. Adicione alguns!';

  @override
  String get addCardsFirst => 'Adicione cartões primeiro!';

  @override
  String get aiDraftingPath => 'A IA está elaborando sua rota...';

  @override
  String get pathReady => 'Rota pronta!';

  @override
  String get errorGeneratingPath => 'Erro ao gerar rota';

  @override
  String get brushingCurriculum => 'Criando currículo...';

  @override
  String get warmUp => 'AQUECIMENTO';

  @override
  String get lessonComplete => 'Lição Concluída! +10 Pontos de Tinta';

  @override
  String get step1Origin => 'PASSO 1: A ORIGEM';

  @override
  String get traceRadical => 'Trace o Radical';

  @override
  String get step2Forge => 'PASSO 2: A FORJA';

  @override
  String get chooseEssence => 'Escolha a Essência';

  @override
  String get wrongEssence => 'Incorreto! Tente novamente.';

  @override
  String get step3Hunt => 'PASSO 3: A CAÇA';

  @override
  String get findCharacters => 'Encontre os caracteres';

  @override
  String get notThatOne => 'Não é este!';

  @override
  String get successfullyInstalled => 'Instalado com sucesso:';

  @override
  String get failedToDownload => 'Falha no download.';

  @override
  String get rescindTitle => 'Deseja revogar?';

  @override
  String get removeCharactersWarning => 'Isso removerá estes caracteres.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get uninstall => 'Desinstalar';

  @override
  String get removedLibrary => 'Removido da biblioteca:';

  @override
  String get tomeLibrary => 'Biblioteca de Tomos';

  @override
  String get libraryError => 'Erro na Biblioteca';

  @override
  String get installTome => 'INSTALAR';

  @override
  String get unitIntro => 'INTRODUÇÃO DA UNIDADE';

  @override
  String get constellationCluster => 'Aglomerado de Constelações';

  @override
  String get ok => 'OK';

  @override
  String get divingInto => 'Mergulhando nos estudos...';

  @override
  String get keyRadicals => 'RADICAIS PRINCIPAIS';

  @override
  String get noRadicalData => 'Sem dados disponíveis.';

  @override
  String get discovery => 'DESCOBERTA';

  @override
  String get startLearning => 'INICIAR APRENDIZADO';

  @override
  String get selectPersona => 'Escolha uma Persona';

  @override
  String get customPersona => 'Persona Personalizada';

  @override
  String get geminiLiveCall => 'CHAMADA AO VIVO';

  @override
  String get returnToMenu => 'Voltar ao Menu';

  @override
  String get strokeAnalysis => 'Análise da ordem dos traços';

  @override
  String get excellentWork => 'Excelente trabalho!';

  @override
  String get keepPracticing => 'Continue praticando!';

  @override
  String get drawingSubmitted => 'Desenho enviado';

  @override
  String get customPersonaHint => 'Defina uma persona personalizada...';

  @override
  String get stepOneOrigin => 'PASSO 1: A ORIGEM';

  @override
  String get stepTwoForge => 'PASSO 2: A FORJA';

  @override
  String get toForge => 'Para forjar';

  @override
  String get whatEssenceDoesNeed => 'De qual essência precisa';

  @override
  String get need => 'precisa';

  @override
  String get forged => 'FORJADO';

  @override
  String get stepThreeHunt => 'PASSO 3: A CAÇA';

  @override
  String get findCharactersWith => 'Encontre caracteres com';

  @override
  String get uninstallButton => 'DESINSTALAR';

  @override
  String get gradedAiStories => 'Histórias graduadas por IA';

  @override
  String get calligraphy => 'Caligrafia';

  @override
  String get theScrollOfOrigin => 'O Pergaminho da Origem';

  @override
  String get galaxyOf => 'Galáxia de';

  @override
  String get constellationDescription => 'Descrição da Constelação';

  @override
  String get noRadicalDataAvailable => 'Nenhum dado de radical disponível';

  @override
  String get learningPreferences => 'Preferências de Aprendizado';

  @override
  String get hardMode => 'Modo Difícil';

  @override
  String get hardModeDesc => 'Exige traços precisos sem guias visuais.';

  @override
  String get adaptiveGuidance => 'Orientação Adaptativa';

  @override
  String get dailyGoal => 'Meta Diária';

  @override
  String get audioAndHaptics => 'Áudio e Resposta Tátil';

  @override
  String get autoPlayAudio => 'Reprodução Automática de Áudio';

  @override
  String get autoPlayDesc =>
      'Reproduz automaticamente a pronúncia ao exibir o cartão.';

  @override
  String get haptics => 'Resposta Tátil (Haptic)';

  @override
  String get displayAndContent => 'Exibição e Conteúdo';

  @override
  String get useEnglishDefinitions => 'Usar definições em inglês';

  @override
  String get useEnglishDefinitionsDesc =>
      'As definições em inglês são geralmente mais detalhadas e precisas';

  @override
  String get animationSpeed => 'Velocidade da animação';

  @override
  String get manageTomes => 'Gerenciar Tomos';

  @override
  String get manageTomesDesc => 'Gerencie os tomos de estudo instalados.';

  @override
  String get dangerZone => 'Zona de Perigo';

  @override
  String get resetAllData => 'Redefinir todos os dados';

  @override
  String get resetDataDesc =>
      'Isso excluirá permanentemente todo o seu progresso, estatísticas e configurações. Esta ação não pode ser desfeita.';

  @override
  String get areYouSure => 'Tem certeza?';

  @override
  String get cannotBeUndone => 'Não pode ser desfeito';

  @override
  String get deleteEverything => 'Excluir Tudo';

  @override
  String get appLanguage => 'Idioma do aplicativo';

  @override
  String get howDidYouDo => 'Como você se saiu?';

  @override
  String get missedItEntirely => 'Errei completamente';

  @override
  String get gotItButStruggled => 'Lembrei com dificuldade';

  @override
  String get gotItClearly => 'Lembrei com clareza';

  @override
  String get perfectAndImmediate => 'Perfeito e imediato';

  @override
  String get again => 'Novamente';

  @override
  String get hard => 'Difícil';

  @override
  String get good => 'Bom';

  @override
  String get easy => 'Fácil';

  @override
  String get tapToReveal => 'Toque para revelar';

  @override
  String get howWellDidYouRemember => 'Quão bem você se lembrou?';

  @override
  String get completelyForgot => 'Esqueci completamente';

  @override
  String get gotItWithDifficulty => 'Lembrei com dificuldade';

  @override
  String get recalledCorrectly => 'Lembrei corretamente';

  @override
  String get perfectRecall => 'Lembrança perfeita';

  @override
  String get practiceWriting => 'Praticar escrita';

  @override
  String get hideScratchpad => 'Ocultar tela de escrita';

  @override
  String get whatCharacterMeans => 'Significado do caractere:';

  @override
  String get tapCardToReveal => 'Toque no cartão para revelar o verso';

  @override
  String get ratePronunciationConfidence => 'Avalie sua confiança na pronúncia';

  @override
  String get botchedIt => 'Muito impreciso';

  @override
  String get struggledWithTones => 'Tive dificuldade com os tons';

  @override
  String get acceptable => 'Aceitável';

  @override
  String get perfectlyNatural => 'Perfeitamente natural';

  @override
  String get sessionComplete => 'Sessão concluída!';

  @override
  String get accuracy => 'Precisão';

  @override
  String get reviewed => 'Revisados';

  @override
  String get correct => 'Corretos';

  @override
  String get backToLibrary => 'Voltar para a biblioteca';

  @override
  String get revealAnswer => 'Revelar resposta';

  @override
  String get aiHubTitle => 'Hub de IA';

  @override
  String get textChat => 'Chat de texto';

  @override
  String get scholarlyPersonas => 'Personas Eruditas';

  @override
  String get shadowing => 'Shadowing';

  @override
  String get liveTranslation => 'Tradução em tempo real';

  @override
  String get scholarsLibrary => 'A Biblioteca do Erudito';

  @override
  String get generate => 'Gerar';

  @override
  String get searchPinyinHanziEnglish =>
      'Pesquisar Pinyin, Hanzi ou significado...';

  @override
  String get liveTranslate => 'Traduzir em tempo real';

  @override
  String get travelInterpreter => 'Intérprete de viagem';

  @override
  String get realTimeSplitScreen =>
      'Conversa em tela dividida em tempo real com um falante nativo para superar qualquer barreira linguística.';

  @override
  String get whisperEarpiece => 'Legendas em tempo real';

  @override
  String get listenToChineseAudio =>
      'Ouça o áudio em chinês e receba legendas em português em tempo real na tela.';

  @override
  String get dashboardTitle => 'Painel';

  @override
  String get yourMindIsClear => 'Sua mente está pronta e afiada.';

  @override
  String get noReviewsDueToday => 'Nenhuma revisão pendente para hoje.';

  @override
  String get done => 'Concluído';

  @override
  String get hskLevel1 => 'Nível HSK 1';

  @override
  String get hskLevel2 => 'Nível HSK 2';

  @override
  String get hskLevel3 => 'Nível HSK 3';

  @override
  String get hskLevel4 => 'Nível HSK 4';

  @override
  String get hskLevel5 => 'Nível HSK 5';

  @override
  String get hskLevel6 => 'Nível HSK 6';

  @override
  String get generalVocabulary => 'Vocabulário geral';

  @override
  String cardsRequireAttention(Object count) {
    return '$count cartões precisam de revisão.';
  }

  @override
  String get begin => 'Iniciar';

  @override
  String get poweredByAi =>
      'Desenvolvido com IA avançada. Tradução fluida e em tempo real para qualquer situação.';

  @override
  String get downloadingModel => 'Baixando modelo de IA...';

  @override
  String get soon => 'EM BREVE';

  @override
  String get installed => 'INSTALADO';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'MÓDULO PRINCIPAL';

  @override
  String get step6Context => 'PASSO 6: CONTEXTO';

  @override
  String get tapBuildingBlocksTo =>
      'Toque nos componentes para explorar suas origens.';

  @override
  String get initiateRadicalSequence => 'INICIAR SEQUÊNCIA DE RADICAIS';

  @override
  String get holdToTalk => 'Segure para falar';

  @override
  String get customScenario => 'Cenário personalizado';

  @override
  String get voiceCall => 'Chamada de voz';

  @override
  String get pronunciation => 'Pronúncia';

  @override
  String get selectAScenarioTo =>
      'Selecione um cenário para praticar sua conversação em mandarim. O Erudito avaliará seus tons e sua clareza.';

  @override
  String get create => 'Criar';

  @override
  String get createYourScenario => 'Crie seu cenário';

  @override
  String get difficulty => 'Dificuldade';

  @override
  String get scholarsVerdict => 'VEREDITO DO ERUDITO';

  @override
  String get completeReview => 'Concluir revisão';

  @override
  String get conversationReview => 'REVISÃO DA CONVERSA';

  @override
  String get linguisticAnalysis => 'Análise linguística';

  @override
  String get examplesInHsk1 => 'EXEMPLOS NO HSK 1';

  @override
  String get characterReference => 'Referência do caractere';

  @override
  String get askTutor => 'Perguntar ao tutor';

  @override
  String get addToStudyDeck => 'Adicionar ao baralho de estudo';

  @override
  String get startPractice => 'INICIAR PRÁTICA';

  @override
  String get noOtherHsk1 =>
      'Nenhum outro caractere do HSK 1 utiliza este radical.';

  @override
  String get couldNotLoadAi =>
      'Não foi possível carregar o conteúdo de IA (limite de requisições ou erro de rede).\nToque no botão de atualizar abaixo para tentar novamente.';

  @override
  String get noAvailableCardsFound => 'Nenhum cartão disponível encontrado.';

  @override
  String get addCards => 'Adicionar cartões';

  @override
  String get removeCard => 'Remover cartão';

  @override
  String get remove => 'Remover';

  @override
  String get review => 'Revisar';

  @override
  String get story => 'História';

  @override
  String get thisDeckIsEmpty => 'Este baralho está vazio.';

  @override
  String get tapTheAddCards => 'Toque no botão \'Adicionar cartões\'!';

  @override
  String get noCardsFound => 'Nenhum cartão encontrado.';

  @override
  String get addCardsToSee =>
      'Adicione cartões para visualizar as estatísticas.';

  @override
  String get aiGenerated => 'Gerado por IA';

  @override
  String get allCardsCaughtUp =>
      'Todos os cartões foram revisados! Excelente trabalho.';

  @override
  String get latestDiscoveries => 'Últimas descobertas';

  @override
  String get noCharactersInLexicon =>
      'Ainda não há caracteres no seu vocabulário.';

  @override
  String get yourBookshelf => 'Sua estante';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Pesquise em seu dicionário...';

  @override
  String get saveCard => 'Salvar cartão';

  @override
  String get noCharactersFound => 'Nenhum caractere encontrado.';

  @override
  String get radicalsIndex => 'Índice de Radicais';

  @override
  String get masteringRadicalsIsThe =>
      'Dominar os radicais é o segredo para destravar milhares de Hanzi. Selecione um radical para ver todos os caracteres associados.';

  @override
  String get noRadicalsFound => 'Nenhum radical encontrado.';

  @override
  String get yourDrawing => 'Seu traço';

  @override
  String get reference => 'Referência';

  @override
  String get rateYourRecall => 'Avalie sua retenção de memória';

  @override
  String get contactUs => 'Fale conosco';

  @override
  String get reportBugsOrRequest => 'Relatar erros ou sugerir funcionalidades';

  @override
  String get allDataHasBeen => 'Todos os dados foram apagados.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Meu progresso';

  @override
  String get overview => 'Visão geral';

  @override
  String get aiStory => 'História com IA';

  @override
  String get usingYourDecksVocabulary =>
      'Utilizando o vocabulário do seu baralho';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get translate => 'Traduzir';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Tradução completa';

  @override
  String get geminiFlashIsStructuring =>
      'O Gemini Flash está estruturando sua história...';

  @override
  String get aiDeckGenerator => 'Gerador de Baralhos com IA';

  @override
  String get whatDoYouWant => 'O que você gostaria de aprender?';

  @override
  String get targetDifficulty => 'Dificuldade desejada';

  @override
  String get focusArea => 'Área de foco';

  @override
  String get specificContextOrTone => 'Contexto ou tom específico (opcional)';

  @override
  String get numberOfCards => 'Quantidade de cartões';

  @override
  String get generateDeck => 'Gerar baralho';

  @override
  String get aiGrammarExplanation => 'Explicação gramatical da IA';

  @override
  String get scholarsDesk => 'Escrivaninha do Erudito';

  @override
  String get chooseADeck => 'Escolha um baralho';

  @override
  String get whereWouldYouLike =>
      'Onde você gostaria de salvar este caractere?';

  @override
  String get addToDefaultStudy => 'Adicionar ao baralho de estudo padrão';

  @override
  String get ifOffItsOnly =>
      'Se desativado, será salvo apenas no dicionário global';

  @override
  String get saveToLibrary => 'Salvar na biblioteca';

  @override
  String get pleaseEnterValidChinese =>
      'Por favor, insira caracteres chineses válidos';

  @override
  String get reviewAiCard => 'Revisar cartão de IA';

  @override
  String get pleaseDoublecheckTheAis =>
      'Verifique o resultado da IA abaixo. Você pode ajustar o pinyin ou a definição antes de salvar em sua biblioteca permanente.';

  @override
  String get alreadyInYourLibrary => 'Já está na sua biblioteca!';

  @override
  String get meaningInContext => 'Significado no contexto';

  @override
  String get explainGrammar => 'Explicar gramática';

  @override
  String get addToLibrary => 'Adicionar à biblioteca';

  @override
  String get masterYourMandarinPronunciation =>
      'Aperfeiçoe sua pronúncia em mandarim imitando falantes nativos em tempo real.';

  @override
  String get startSession => 'INICIAR SESSÃO';

  @override
  String get sessionHistory => 'Histórico de sessões';

  @override
  String get noSavedSessions => 'Nenhuma sessão salva.';

  @override
  String get aiBreakdown => 'Análise detalhada da IA';

  @override
  String get sessionDetails => 'Detalhes da sessão';

  @override
  String partner(Object lang) {
    return 'Interlocutor ($lang)';
  }

  @override
  String get youEnglish => 'Você (Português)';

  @override
  String get noTranscriptToSave => 'Nenhuma transcrição para salvar!';

  @override
  String get sessionSaved => 'Sessão salva com sucesso!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Tradução bidirecional em tempo real. Fale em português ou mandarim e a tradução será exibida instantaneamente para você e seu interlocutor.';

  @override
  String get text_1782026184665 => 'Gravando';

  @override
  String get recording => 'Gravando';

  @override
  String get yourSilentCompanionListen =>
      'Seu assistente silencioso. Ouça mandarim e receba a tradução para o português em tempo real.';

  @override
  String get startListening => 'COMEÇAR A OUVIR';

  @override
  String get skip => 'Pular';

  @override
  String get independentStars => 'ESTRELAS INDEPENDENTES';

  @override
  String get notEveryCharacterHas =>
      'Nem todo caractere deriva de um radical pai. Alguns são pictogramas únicos ou caracteres independentes.';

  @override
  String get onTheMapWe =>
      'No mapa, agrupamos esses caracteres independentes em CONSTELAÇÕES (✨).';

  @override
  String get iUnderstand => 'ENTENDI';

  @override
  String get whatAreRadicals => 'O QUE SÃO RADICAIS?';

  @override
  String get hanziAreBuiltFrom =>
      'Os Hanzi são formados por blocos essenciais chamados RADICAIS.\n\nEles atribuem ao caractere seu significado ou tema principal.';

  @override
  String get continueText => 'CONTINUAR';

  @override
  String get hanziAreNotJust =>
      'Os Hanzi não são apenas letras. São imagens gravadas no tempo.\n\nPara dominá-los, você deve aprender a fluir com seus traços.';

  @override
  String get iAmReady => 'ESTOU PRONTO';

  @override
  String get youAreAScholar => 'VOCÊ É UM ERUDITO';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'O Mapa da Galáxia espera por você.\nDomine os Sóis (Radicais) para desbloquear os Planetas (Caracteres).';

  @override
  String get enterTheScroll => 'ABRIR O PERGAMINHO';

  @override
  String get openingTheOriginScroll => 'Abrindo o Pergaminho da Origem...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Edição do Erudito';

  @override
  String get weArePreparingThe =>
      'Estamos preparando o lançamento da Edição do Erudito.';

  @override
  String get devBypassUnlockNow => 'DESVIO DE DESENVOLVEDOR: DESBLOQUEAR AGORA';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get welcomeScholarTheScroll =>
      'Bem-vindo, Erudito. O pergaminho está totalmente aberto para você.';

  @override
  String get purchasesRestoredSuccessfully =>
      'Compras restauradas com sucesso.';

  @override
  String get noPreviousPurchasesFound =>
      'Nenhuma compra anterior foi encontrada para esta conta.';

  @override
  String get unlockTheFullPotential =>
      'Desbloqueie todo o potencial da sua jornada. Compra única, seu para sempre.';

  @override
  String get universalScanner => 'Scanner Universal';

  @override
  String get noChineseCharactersFound =>
      'Nenhum caractere chinês encontrado na imagem.';

  @override
  String get addedNewCharactersTo =>
      'Novos caracteres adicionados à sua biblioteca!';

  @override
  String get extractingTextAndObjects => 'Extraindo texto e objetos...';

  @override
  String get scanATextbookSign =>
      'Escaneie um livro didático, placa ou objeto para extrair caracteres chineses.';

  @override
  String get extractedText => 'Texto extraído';

  @override
  String get useText => 'Usar texto';

  @override
  String get noMatchingDictionaryEntries =>
      'Nenhuma entrada correspondente encontrada no dicionário.';

  @override
  String get quizComplete => 'Quiz concluído!';

  @override
  String get returnToCourse => 'Voltar ao curso';

  @override
  String get notEnoughCardsFor =>
      'Cartões insuficientes para um quiz! É necessário ter pelo menos 4.';

  @override
  String get creatorMode => 'Modo Criador';

  @override
  String get noStoriesFoundMatching =>
      'Nenhuma história encontrada com base na sua pesquisa.';

  @override
  String get discard => 'Descartar';

  @override
  String get save => 'Salvar';

  @override
  String get generatingStoryViaDeepseek => 'Gerando história com DeepSeek...';

  @override
  String get storySavedToLibrary => 'História salva na biblioteca!';

  @override
  String get storyNotFound => 'História não encontrada.';

  @override
  String get targetHskLevel => 'Nível HSK desejado';

  @override
  String get wedLoveToHear => 'Adoraríamos ouvir a sua opinião!';

  @override
  String get whetherYouveFoundA =>
      'Seja para relatar um bug, sugerir uma funcionalidade ou apenas dar um olá, seu feedback nos ajuda a aprimorar o SinoSpark.';

  @override
  String get pointYourCameraAt => 'Aponte a câmera para os objetos';

  @override
  String get reviewAddToLibrary => 'Revisar e adicionar à biblioteca';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Ocultar guia de traço na sequência de: $streak';
  }

  @override
  String inkPoints(Object points) {
    return '$points Pontos de Tinta';
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
  String get supportAndFeedback => 'Suporte e Feedback';

  @override
  String get reportBug => 'Relatar um erro';

  @override
  String get suggestFeature => 'Sugerir funcionalidade';

  @override
  String get generalFeedback => 'Feedback geral';

  @override
  String get pleaseDrawSomethingFirst => 'Por favor, desenhe algo primeiro';

  @override
  String get drawThisCharacter => 'Escreva este caractere:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Siga o guia azul para traçar o traço $current de $total';
  }

  @override
  String get skipCurrentStroke => 'Pular traço atual';

  @override
  String get submitDrawing => 'Enviar traçado';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '«$hanzi» adicionado ao baralho «$deckName»';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '«$hanzi» removido do baralho';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return '«$hanzi» ignorado: nenhum dado de traçado disponível para este caractere.';
  }

  @override
  String get startingSession => 'Iniciando sessão de estudo...';

  @override
  String get studySession => 'Sessão de estudo';

  @override
  String get readyToStudy => 'Pronto para estudar';

  @override
  String get studyQueuePreviewDescription =>
      'Sua sessão é baseada no cronograma de hoje e nos limites do baralho.';

  @override
  String get notNow => 'Agora não';

  @override
  String get newLabel => 'Novo';

  @override
  String get studyDeckEmpty => 'Este baralho está vazio';

  @override
  String get studyDeckEmptyDescription =>
      'Adicione cartões antes de iniciar uma sessão de estudo.';

  @override
  String get studyDailyLimitReached => 'Limite de hoje atingido';

  @override
  String get studyDailyLimitReachedDescription =>
      'Você atingiu o limite diário de novos cartões ou revisões para este baralho.';

  @override
  String get studyCaughtUpDescription =>
      'Nada mais agendado para hoje. Volte para a próxima revisão.';

  @override
  String get noCardsAvailable => 'Nenhum cartão disponível';

  @override
  String get studyNoEligibleCardsDescription =>
      'Nenhum cartão é elegível para este modo de estudo no momento.';

  @override
  String get studySessionLoadFailed =>
      'Não foi possível carregar esta sessão de estudo. Tente novamente.';

  @override
  String get retryLimitReached =>
      'Este cartão retornará na sua próxima sessão.';

  @override
  String get masterBuildingBlocks => 'Domine os blocos fundamentais dos Hanzi';

  @override
  String get totalWords => 'Total de palavras';

  @override
  String get newInk => 'Tinta acumulada';

  @override
  String get learningStatus => 'Aprendendo';

  @override
  String get masteredStatus => 'Dominado';

  @override
  String get libraryMastery => 'Domínio da biblioteca';

  @override
  String get accuracyByMode => 'Precisão por modo';

  @override
  String get upcomingReviews => 'Próximas revisões (próximos 7 dias)';

  @override
  String get culturalReadingRoom => 'Sala de Leitura Cultural (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Por favor, insira um tópico';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'Baralho «$name» criado com $count cartões!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Avaliação: $grade';
  }

  @override
  String get listeningMode => 'Modo de Escuta';

  @override
  String get readingMode => 'Modo de Leitura';

  @override
  String get recallMode => 'Modo de Recordação';

  @override
  String get speakingMode => 'Modo de Fala';

  @override
  String get aiMemoryHook => 'Gancho Mnemônico de IA';

  @override
  String get exampleSentences => 'Frases de exemplo';

  @override
  String get ghostCharacters => 'Caracteres guia (marca d\'água)';

  @override
  String get commonWords => 'Palavras frequentes';

  @override
  String get personalNotes => 'Anotações pessoais';

  @override
  String get addPersonalNotes =>
      'Adicione suas próprias dicas mnemônicas ou notas aqui...';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get gallery => 'Galeria';

  @override
  String get arLens => 'Lente de RA';

  @override
  String addedCharToLibrary(Object char) {
    return '«$char» adicionado à biblioteca';
  }

  @override
  String get scoreText => 'Pontuação';

  @override
  String get searchDictionaryHint =>
      'Pesquise por caractere, pinyin ou significado...';

  @override
  String get searchDeckHint => 'Pesquise no baralho por caractere ou pinyin...';

  @override
  String get localRestaurant => 'Restaurante Local';

  @override
  String get taxiToAirport => 'Táxi para o Aeroporto';

  @override
  String get silkMarketHaggling => 'Pechincha no Mercado da Seda';

  @override
  String get medicalClinic => 'Clínica Médica';

  @override
  String get meetingAFriend => 'Encontro com um Amigo';

  @override
  String get jobInterview => 'Entrevista de Emprego';

  @override
  String get searchRadicalsHint => 'Pesquisar radicais (ex.: Água, 氵)';

  @override
  String get definition => 'Definição';

  @override
  String get undo => 'DESFAZER';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Desbloquear Vitalício - US\$ 9,99';

  @override
  String get clear => 'Limpar';

  @override
  String get clearChat => 'Limpar histórico do chat';

  @override
  String get typeMessage => 'Digite sua mensagem...';

  @override
  String addedToLibrary(Object hanzi) {
    return '«$hanzi» adicionado à sua biblioteca';
  }

  @override
  String get generateNewStory => 'Gerar nova história';

  @override
  String failedToGenerateStory(Object error) {
    return 'Falha ao gerar história:\n$error';
  }

  @override
  String get detail => 'Detalhes';

  @override
  String get scanText => 'Escanear texto';

  @override
  String get createMagic => 'Criar com IA';

  @override
  String get learning => 'Aprendendo';

  @override
  String get upcomingReviews7Days => 'Próximas revisões (próximos 7 dias)';

  @override
  String get askFollowUpQuestion => 'Fazer pergunta de aprofundamento...';

  @override
  String get pasteScanToSimplify =>
      'Cole ou escaneie um texto em chinês para simplificá-lo';

  @override
  String get searchStoriesHint =>
      'Busque histórias por título ou tags (ex.: mitologia, viagem)';

  @override
  String get importAll => 'Importar tudo';

  @override
  String get ascendAll => 'Avançar tudo';

  @override
  String get startAscension => 'Iniciar avanço';

  @override
  String get scenarioLocalRestaurant => 'Restaurante local';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Pratique pedir pratos e solicitar recomendações no cardápio.';

  @override
  String get scenarioTaxiAirport => 'Táxi para o aeroporto';

  @override
  String get scenarioTaxiAirportDesc =>
      'Informe seu destino ao motorista e converse sobre o trânsito.';

  @override
  String get scenarioSilkMarket => 'Pechincha no Mercado da Seda';

  @override
  String get scenarioSilkMarketDesc =>
      'Negocie para conseguir um preço melhor em suas lembranças.';

  @override
  String get scenarioMedicalClinic => 'Consulta médica';

  @override
  String get scenarioMedicalClinicDesc =>
      'Descreva seus sintomas a um médico tradicional chinês.';

  @override
  String get scenarioMeetingFriend => 'Encontro com amigo';

  @override
  String get scenarioMeetingFriendDesc =>
      'Apresente-se, coloque o papo em dia e faça conversa casual.';

  @override
  String get scenarioJobInterview => 'Entrevista de emprego';

  @override
  String get scenarioJobInterviewDesc =>
      'Candidate-se a uma vaga em uma empresa de tecnologia em Xangai.';

  @override
  String get createCustomScenario => 'Criar cenário personalizado';

  @override
  String get customScenarioTitleHint => 'Título (ex.: Recepção de Casamento)';

  @override
  String get customScenarioDescHint => 'Descrição (Contexto)';

  @override
  String get customScenarioPersonaHint =>
      'Papel da IA (ex.: Um colega curioso)';

  @override
  String get customScenarioDifficulty => 'Dificuldade';

  @override
  String get createAction => 'Criar';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get mythsAndLegends => 'Mitos e Lendas';

  @override
  String get historyAndCulture => 'História e Cultura';

  @override
  String get idiomsTitle => 'Expressões Idiomáticas (成语)';

  @override
  String get theMonkeyKing => 'O Rei Macaco';

  @override
  String get theMonkeyKingDesc => 'Sun Wukong (Jornada ao Oeste)';

  @override
  String get huaMulan => 'Hua Mulan';

  @override
  String get huaMulanDesc =>
      'Hua Mulan alistando-se no exército no lugar de seu pai';

  @override
  String get confuciusTitle => 'Confúcio';

  @override
  String get confuciusDesc => 'A vida e os ensinamentos de Confúcio';

  @override
  String get theGreatWall => 'A Grande Muralha';

  @override
  String get theGreatWallDesc => 'A construção da Grande Muralha da China';

  @override
  String get generateTopic => 'Gerar tópico';

  @override
  String get simplifyText => 'Simplificar texto';

  @override
  String get topicHint => 'Tópico (ex.: Extraterrestres em Pequim)';

  @override
  String get tagsHint => 'Tags (separadas por vírgula, opcional)';

  @override
  String get speakWithMasterLin => 'Conversar com o Mestre Lin';

  @override
  String get masterLinGreeting =>
      'Saudações, aprendiz. A tinta está pronta. Qual caractere ou expressão estudaremos hoje?';

  @override
  String get typeYourMessage => 'Digite sua mensagem...';

  @override
  String get theMainLibrary => 'Biblioteca Principal';

  @override
  String get hsk1Foundation => 'HSK 1: Fundamentos';

  @override
  String get hsk2Elementary => 'HSK 2: Elementar';

  @override
  String get hsk3Intermediate => 'HSK 3: Intermediário';

  @override
  String get inDeckCheck => 'No baralho ✓';

  @override
  String get addToDeckPlus => '+ Adicionar ao baralho';

  @override
  String get openCardArrow => 'Abrir cartão →';

  @override
  String get pronunciationPartial => 'Tom impreciso';

  @override
  String get pronunciationWrong => 'Incorreto';

  @override
  String get toneExpected => 'Tom esperado';

  @override
  String get toneYouSaid => 'Tom pronunciado';

  @override
  String get gotIt => 'Entendi!';

  @override
  String foundNCharacters(int count) {
    return '$count caracteres encontrados';
  }

  @override
  String get lookingUpCharacters => 'Buscando caracteres…';

  @override
  String get practiceAll => 'Praticar tudo';

  @override
  String get arLensObjects => 'Objetos';

  @override
  String get arLensText => 'Texto';

  @override
  String get arLensDetectedText => 'Texto detectado';

  @override
  String get duration12Min => '1–2 min';

  @override
  String get aClassicTangDynastyPoem => 'Um poema clássico da dinastia Tang';

  @override
  String get aClassicTangDynastyPoemBy =>
      'Um poema clássico da dinastia Tang por';

  @override
  String get aStructuralComponent =>
      'Um componente estrutural (radical/elemento).';

  @override
  String get addSelectedToDeck => 'Adicionar selecionados ao baralho';

  @override
  String addTo(Object target) {
    return 'Adicionar a $target';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '«$hanzi» foi adicionado à sua biblioteca';
  }

  @override
  String get adjustFontSize => 'Ajustar tamanho da fonte';

  @override
  String get againGoodEasyHard =>
      '⬅️ Repetir    ➡️ Bom    ⬆️ Fácil    ⬇️ Difícil';

  @override
  String get aiAnalysisFailed => 'Falha na análise da IA';

  @override
  String get aiIsThinking => 'A IA está pensando...';

  @override
  String get aiSceneAnalysisFailed => 'Falha na análise de cena da IA';

  @override
  String get allLabel => 'Todos';

  @override
  String get allPinyin => 'Todo o Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Já tem uma conta? Entrar';

  @override
  String get analysisFailed => 'Falha na análise: ';

  @override
  String get analyzingClassicalCharacters =>
      'Analisando caracteres clássicos...';

  @override
  String get anatomy => 'Anatomia do caractere';

  @override
  String get ancientPhilosophy => 'Filosofia antiga';

  @override
  String get warringStates => 'Reinos Combatentes';

  @override
  String get hanFeiLegalism =>
      'Han Fei (c. 280–233 a.C.) foi um príncipe do estado de Han e o principal pensador do Legalismo chinês. Reunindo as ideias de lei, técnica administrativa e autoridade, seus escritos no Han Feizi influenciaram profundamente a filosofia política e as instituições da China imperial.';

  @override
  String get articleSavedToMediaHub => 'Artigo salvo no Media Hub!';

  @override
  String get askAFollowUp => 'Faça uma pergunta de acompanhamento...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Áudio, privacidade e funcionamento';

  @override
  String get audiobookPlayer => 'Reprodutor de audiolivro';

  @override
  String get audiobookVoice => 'Voz do audiolivro';

  @override
  String get auntieMaTown =>
      'Tia Ma (马阿姨): dona de barraca enérgica que prepara os Roujiamo e Liangpi mais crocantes da cidade.';

  @override
  String get back => 'Voltar';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯): um jovem e apaixonado mestre de torra que adora conversar sobre os grãos de café de Yunnan e suas notas sensoriais.';

  @override
  String get bbc => 'BBC Chinês Online';

  @override
  String get beginYourJourney => 'Comece sua jornada';

  @override
  String get bestValue => 'Melhor custo-benefício';

  @override
  String get bookLinkCopiedToClipboard =>
      'Link do livro copiado para a área de transferência!';

  @override
  String get bookmarkChapter => 'Adicionar capítulo aos favoritos';

  @override
  String get bookmarks => 'Favoritos';

  @override
  String get books => 'Livros';

  @override
  String get briefing => 'Resumo';

  @override
  String get bugReport => 'Relatório de erro';

  @override
  String get caoXueqinDecline =>
      'Cao Xueqin (c. 1715–1763) foi um romancista da dinastia Qing nascido em uma família nobre outrora rica, cuja fortuna ruiu sob o imperador Yongzheng. \'O Sonho do Pavilhão Vermelho\', escrito em seus últimos anos de pobreza, é amplamente considerado o ápice da ficção clássica chinesa — um vasto e psicologicamente rico panorama do declínio aristocrático.';

  @override
  String get cardsTitle => 'CARTÕES';

  @override
  String get cc => 'Legendas (CC)';

  @override
  String get characterOrWord => 'Caractere / Palavra';

  @override
  String get chatMore => 'Continuar conversando';

  @override
  String get chefChenShumai =>
      'Chef Chen (陈师傅): um alegre chef cantonês de dim sum que recomenda deliciosos bolinhos Har Gow e Shumai fresquinhos.';

  @override
  String get chineseEpics => 'Epopeias chinesas';

  @override
  String get chinesePoetry => 'Poesia chinesa';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast =>
      'Banquete de hotpot apimentado de Chongqing';

  @override
  String get chooseAudiobookVoice => 'Escolher voz do audiolivro';

  @override
  String get chooseVoice => 'Escolher voz';

  @override
  String get compare => 'Comparar';

  @override
  String get compare4Tones => 'Comparar os 4 tons';

  @override
  String get configuration => 'Configuração';

  @override
  String get contemporary => 'Contemporâneo';

  @override
  String get context => 'Contexto';

  @override
  String get couldNotLoadLibrary => 'Não foi possível carregar a biblioteca';

  @override
  String get couldNotLoadVocabulary =>
      'Não foi possível carregar o vocabulário.';

  @override
  String get couldNotOpenEmailApp =>
      'Não foi possível abrir o aplicativo de e-mail.';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get createNewDeck => 'Criar novo baralho';

  @override
  String get createScenario => 'Criar cenário';

  @override
  String get createStory => 'Criar história';

  @override
  String get customLabel => 'Personalizado';

  @override
  String get customWord => 'Palavra personalizada';

  @override
  String get days => 'dias';

  @override
  String get deck => 'Baralho';

  @override
  String get deckName => 'Nome do baralho';

  @override
  String get deckStory => 'História do baralho';

  @override
  String get deepAnalysis => 'Análise aprofundada';

  @override
  String get defaultDeck => 'Baralho padrão';

  @override
  String get deleteLabel => 'Excluir';

  @override
  String get deleteScenario => 'Excluir cenário';

  @override
  String get deletesAllProgressPermanently =>
      'Exclui todo o progresso permanentemente';

  @override
  String get developerBackdoorUnlocked =>
      'Acesso de desenvolvedor desbloqueado!';

  @override
  String get doesNotExistInChinese => 'Não existe em chinês';

  @override
  String get dontHaveAccountSignUp => 'Não tem uma conta? Cadastre-se';

  @override
  String get draftingStoryOutline => 'Elaborando esboço da história...';

  @override
  String get dynamicFlowState => 'Estado de fluxo dinâmico';

  @override
  String get dynamicFlowStateParenthetical => 'Dinâmico (Estado de fluxo)';

  @override
  String get editCard => 'Editar cartão';

  @override
  String get egAnimeVocab => 'Ex.: Vocabulário de animes';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'Ex.: linguagem formal de negócios, gírias para mensagens...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'Ex.: Pedir em um restaurante, vocabulário empresarial...';

  @override
  String get egWeddingReceptionTechInterview =>
      'Ex.: Recepção de casamento, entrevista técnica...';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get english => 'Inglês';

  @override
  String get englishAndWorld => 'Inglês e Literatura Mundial';

  @override
  String get episodes => 'episódios';

  @override
  String get erase => 'Apagar';

  @override
  String get eraseDeckQuestion => 'Apagar baralho?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Erro ao buscar tradução para $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Erro ao carregar microleituras: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Erro ao carregar romances: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Erro ao carregar poesia: $e';
  }

  @override
  String get exitFocus => 'Sair do modo foco';

  @override
  String get explore => 'Explorar';

  @override
  String get exportToThisDeck => 'Exportar para este baralho';

  @override
  String get extractAndSimplify => 'Extrair e simplificar';

  @override
  String get failedToCreateDeck => 'Falha ao criar baralho';

  @override
  String get failedToLoadDailyContent => 'Falha ao carregar conteúdo diário';

  @override
  String get failedToLoadEpisodes => 'Falha ao carregar episódios';

  @override
  String get failedToLoadShows => 'Falha ao carregar programas';

  @override
  String get finalizingDetails => 'Finalizando detalhes...';

  @override
  String get finalizingStoryDetails => 'Finalizando detalhes da história...';

  @override
  String get firebaseAuthConsole =>
      'Autenticação do Firebase não ativada. Ative o método de login necessário no console do Firebase.';

  @override
  String get flashcardDeckTitle => 'BARALHO DE FLASHCARDS';

  @override
  String get focus => 'Foco';

  @override
  String get foodAndCooking => 'Comida e Culinária';

  @override
  String get forward => 'Avançar';

  @override
  String get freeFlow => 'Fluxo livre';

  @override
  String get frenchClassics => 'Clássicos franceses';

  @override
  String get full => 'Completo';

  @override
  String get gamingAndEsports => 'Games e eSports';

  @override
  String get germanClassics => 'Clássicos alemães';

  @override
  String get ghostPinyin => 'Pinyin guia';

  @override
  String get goodAttempt => 'Boa tentativa!';

  @override
  String get gotItSimple => 'Entendi';

  @override
  String get grammar => 'Gramática';

  @override
  String get grandmaLiuFilling =>
      'Vovó Liu (刘奶奶): uma carinhosa avó do norte que ensina a dobrar os pasteizinhos jiaozi e preparar o recheio de porco com cebolinha.';

  @override
  String get great => 'Ótimo!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Banquete de jiaozi caseiros em Harbin';

  @override
  String get hanziCharacter => 'Hanzi (Caractere)';

  @override
  String get hapticFeedback => 'Resposta tátil (Haptic)';

  @override
  String get helpAndSupport => 'Ajuda e Suporte';

  @override
  String get hidden => 'Oculto';

  @override
  String get hideEnglishTranslations => 'Ocultar traduções em inglês';

  @override
  String get hidePinyin => 'Ocultar Pinyin';

  @override
  String get highlight => 'EM DESTAQUE';

  @override
  String get howWouldYouLikeToStudy => 'Como você gostaria de estudar?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Intermediário superior';

  @override
  String get hsk5Advanced => 'HSK 5: Avançado';

  @override
  String get hsk6Mastery => 'HSK 6: Domínio';

  @override
  String get hskCollections => 'Coleções HSK';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'Simplificar legendas para HSK';

  @override
  String get hskVocabularyCollections => 'Coleções de vocabulário HSK';

  @override
  String get i => 'Eu';

  @override
  String get ifTheAgain =>
      'Se a transcrição não corresponder ao que você disse, selecione a frase pretendida e toque em “Sim, reavalie-me!” para avaliar novamente a gravação original sem precisar falar de novo.';

  @override
  String get install => 'Instalar';

  @override
  String get just => 'Apenas US\$ ';

  @override
  String get keyword => 'palavra-chave';

  @override
  String get knowledgeBase => 'Base de conhecimento';

  @override
  String get liRuzhenSubjects =>
      'Li Ruzhen (c. 1763–1830) foi um erudito da dinastia Qing com grande interesse em fonologia, xadrez e cosmologia. \'Flores no Espelho\', seu romance fantástico sobre um mercador viajando por reinos extraordinários, destaca-se por seus temas feministas e escopo enciclopédico.';

  @override
  String get libraryLabel => 'Biblioteca';

  @override
  String get lifestyleAndVlog => 'Estilo de Vida e Vlogs';

  @override
  String get listenInAudiobookMode => 'Ouvir no modo audiolivro';

  @override
  String get listenToThisWord => 'Ouvir esta palavra';

  @override
  String get listening => 'Ouvindo...';

  @override
  String get liuEEncroachment =>
      'Liu E (1857–1909) foi um polímata do final da dinastia Qing — engenheiro, médico e romancista — cujo célebre romance \'As Viagens de Lao Can\' é um relato de viagem lírico e politicamente agudo sobre um curandeiro errante em uma China assolada pela crise dinástica e invasão estrangeira.';

  @override
  String get loadingTranslations => 'Carregando traduções...';

  @override
  String get luXunVernacular =>
      'Lu Xun (1881–1936), pseudônimo de Zhou Shuren, é o pai da literatura chinesa moderna. Médico que se dedicou à escrita para despertar o espírito chinês, utilizou a língua vernácula (Baihua) em suas clássicas coletâneas, como \'O Diário de um Louco\' e \'A Verdadeira História de Ah Q\'.';

  @override
  String get luoGuanzhongEpic =>
      'Luo Guanzhong (c. 1330–1400) foi um dramaturgo e romancista da transição Yuan-Ming, discípulo de Shi Nai\'an. Seu \'Romance dos Três Reinos\' reuniu crônicas históricas, tradição oral e narrativa dramática na maior epopeia histórica da literatura chinesa.';

  @override
  String get makeACustomCollection => 'Criar uma coleção personalizada';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Gerenciar Drops Diários e lembretes de revisão';

  @override
  String get managerYuOptions =>
      'Gerente Yu (余店长): uma animada gerente de restaurante de hotpot que recomenda bucho bovino especial, sangue de pato e opções de caldos suaves.';

  @override
  String get masterGaoRubs =>
      'Mestre Gao (高师傅): um carismático churrasqueiro de carvão que brinca com os clientes sobre os níveis de pimenta e seu tempero secreto de cominho.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Domine este elemento para desbloquear sua galáxia.';

  @override
  String get masterZhaoBrewing =>
      'Mestre Zhao (赵师傅): um paciente e experiente mestre do chá que adora demonstrar a arte do preparo do chá Gongfu.';

  @override
  String get mastery => 'Domínio';

  @override
  String get maybeLater => 'Talvez mais tarde';

  @override
  String get memes => 'Memes';

  @override
  String get midnightBbqSkewersInWuhan =>
      'Espetinhos de churrasco da meia-noite em Wuhan';

  @override
  String get mo => '/mês';

  @override
  String get modernChinese => 'Chinês moderno';

  @override
  String get monthly => 'Mensal';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Carrinho de dim sum matinal em Guangzhou';

  @override
  String get nameLabel => 'Nome';

  @override
  String get native => 'Nativo';

  @override
  String get newCard => 'Novo cartão';

  @override
  String get newDeck => 'Novo baralho';

  @override
  String get newDeckName => 'Nome do novo baralho';

  @override
  String get noActiveSubscriptionFound =>
      'Nenhuma assinatura ativa encontrada.';

  @override
  String get noEpisodesFound => 'Nenhum episódio encontrado';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Nenhuma palavra-chave encontrada para esta história.';

  @override
  String get noLabel => 'Não';

  @override
  String get noNewWordsFound => 'Nenhuma palavra nova encontrada!';

  @override
  String get noPinyin => 'Sem Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'Nenhum pacote premium disponível no momento.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'Nenhum resultado encontrado para «$searchQuery»';
  }

  @override
  String get noSavedArticlesYet => 'Nenhum artigo salvo ainda.';

  @override
  String get noShowsAvailable => 'Nenhum programa disponível';

  @override
  String get noStoriesFound => 'Nenhuma história encontrada.';

  @override
  String get noWordsSelected => 'Nenhuma palavra selecionada';

  @override
  String get notes => 'Anotações';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'OBJETIVOS';

  @override
  String get openInYoutube => 'Abrir no YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Pedindo café coado pour-over em Xangai';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Pedindo Tanghulu (espetinhos de espinheiro caramelizados) no inverno de Pequim';

  @override
  String partnerLang(String lang) {
    return 'Interlocutor ($lang)';
  }

  @override
  String get partnerListening => 'O interlocutor está ouvindo...';

  @override
  String get partnerSpeaking => 'O interlocutor está falando...';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get pause => 'Pausar';

  @override
  String get perfect => 'Perfeito!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Uma rota personalizada baseada no seu baralho.';

  @override
  String get play => 'Reproduzir )';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Por favor, digite uma mensagem antes de enviar.';

  @override
  String get practiceInRoleplay => 'Praticar em roleplay';

  @override
  String get practiceModes => 'Modos de prática';

  @override
  String get practicePronouncingWithAiGrading =>
      'Pratique a pronúncia desta palavra com avaliação por IA';

  @override
  String get preparingReadingInterface => 'Preparando interface de leitura...';

  @override
  String get privacy => 'Privacidade';

  @override
  String get privacyAndAudio => 'Privacidade e áudio';

  @override
  String get aiDataPrivacyTitle => 'Dados e Privacidade de IA';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Veja o que os recursos de IA enviam, por que e para quem';

  @override
  String get aiDataPrivacyOverviewTitle => 'Quando a IA é usada';

  @override
  String get aiDataPrivacyOverviewBody =>
      'O SinoSpark usa IA na nuvem apenas quando você escolhe um recurso que precisa dela, como chat com IA, explicações, tradução, análise de imagens, reconhecimento de voz, avaliação de pronúncia ou vozes na nuvem. Os resultados da IA podem conter imprecisões, portanto revise informações importantes.';

  @override
  String get aiDataPrivacyProvidersTitle => 'Provedores de serviços de IA';

  @override
  String get aiDataPrivacyProvidersBody =>
      'O Google Gemini processa solicitações generativas de texto e imagem. O OpenRouter direciona algumas solicitações generativas para o Google Gemini ou DeepSeek. O Microsoft Azure AI Speech processa reconhecimento de voz, avaliação de pronúncia e textos enviados para síntese de voz na nuvem.';

  @override
  String get aiDataPrivacySentTitle => 'Dados que podem ser enviados';

  @override
  String get aiDataPrivacySentBody =>
      'Dependendo do recurso, enviamos o texto inserido ou selecionado, contexto de conversa ou lição relevante, imagens escolhidas para análise de IA, gravações de voz enviadas e dados técnicos da solicitação, como endereço IP e metadados do dispositivo ou da rede. Não incluímos intencionalmente seu nome ou e-mail nos comandos de IA.';

  @override
  String get aiDataPrivacyControlsTitle => 'Suas escolhas';

  @override
  String get aiDataPrivacyControlsBody =>
      'Não use um recurso de IA se não quiser que os dados sejam enviados ao provedor especificado. Você pode negar permissões de câmera, fotos ou microfone nas Configurações do dispositivo. Escolha a voz local para manter a conversão de texto em voz no seu dispositivo. Evite enviar informações confidenciais ou sensíveis.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Armazenamento e retenção';

  @override
  String get aiDataPrivacyRetentionBody =>
      'O SinoSpark não armazena intencionalmente os comandos brutos de IA, imagens enviadas ou gravações de voz em seus próprios servidores após o processamento. Os resultados gerados podem ser salvos no seu dispositivo ou na sua conta quando você optar por salvá-los. Os provedores processam os dados de acordo com seus próprios termos e controles de retenção configurados; consulte a política completa para obter detalhes.';

  @override
  String get readFullPrivacyPolicy => 'Ler política de privacidade completa';

  @override
  String get linkOpenFailed =>
      'Não foi possível abrir o link. Tente novamente.';

  @override
  String get puSonglingLiterature =>
      'Pu Songling (1640–1715) foi um escritor da dinastia Qing que dedicou décadas à compilação dos \'Contos Estranhos do Estúdio de Liao\' (Liaozhai Zhiyi) após sucessivas reprovações nos exames imperiais. Suas narrativas sobrenaturais sobre espíritos de raposa, fantasmas e eruditos são a referência máxima da literatura fantástica chinesa.';

  @override
  String get qaFaq => 'Perguntas Frequentes / FAQ';

  @override
  String get questsTitle => 'MISSÕES';

  @override
  String get quickBookmarks => 'Favoritos rápidos';

  @override
  String get radical => 'Radical';

  @override
  String get ready => 'Pronto';

  @override
  String get readyToInterpret => 'Pronto para traduzir';

  @override
  String get readyToStart => 'Pronto para começar.';

  @override
  String get recentBookmarks => 'Favoritos recentes';

  @override
  String get refiningGrammar => 'Aprimorando gramática...';

  @override
  String get refresh => 'Atualizar';

  @override
  String get removeFromSaved => 'Remover dos salvos';

  @override
  String get removeFromSavedScenarios => 'Remover dos cenários salvos';

  @override
  String get removed => 'Removido';

  @override
  String get requestPermissions => 'Solicitar permissões';

  @override
  String get rescind => 'Revogar';

  @override
  String get restore => 'Restaurar';

  @override
  String get results => 'Resultados';

  @override
  String get resume => 'Retomar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get revenuecatError => 'Erro RevenueCat: ';

  @override
  String revenuecatErrorE(String e) {
    return 'Erro RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'Revisar baralho extraído';

  @override
  String get reviewIn => 'Revisar em';

  @override
  String get reviewingYourTones => 'Analisando seus tons...';

  @override
  String get saveAll => 'Salvar tudo';

  @override
  String get saveScenario => 'Salvar cenário';

  @override
  String get saveThisScenario => 'Salvar este cenário';

  @override
  String get saved => 'Salvo';

  @override
  String get scanAnother => 'Escanear outro';

  @override
  String get scenarioRemoved => 'Cenário removido';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Cenário salvo! Encontre-o na aba \'Personalizados\'.';

  @override
  String score(Object score, Object total) {
    return 'Pontuação: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'Buscar por pinyin ou significado...';

  @override
  String get searchByTitleOrTag => 'Buscar por título ou tag...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Buscar no dicionário ou digitar caractere';

  @override
  String get searchHint => 'Buscar...';

  @override
  String get searchOrEnterUrl => 'Buscar ou inserir URL';

  @override
  String get searchScenariosHint => 'Buscar cenários...';

  @override
  String get searchStoriesIdiomsNews =>
      'Buscar histórias, provérbios, notícias...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Buscar tópicos (ex.: Culinária, História)';

  @override
  String get seeAll => 'Ver tudo';

  @override
  String get selectADeck => 'Selecionar um baralho';

  @override
  String get selectPracticeMode => 'Selecionar modo de prática';

  @override
  String get selectingHskVocabulary => 'Selecionando vocabulário HSK...';

  @override
  String get send => 'Enviar';

  @override
  String get sendMessage => 'Enviar mensagem';

  @override
  String get serif => 'Com serifa (Serif)';

  @override
  String get shadow => 'Shadowing';

  @override
  String get shiNaianEpic =>
      'Shi Nai\'an (c. 1296–1372) foi um letrado da dinastia Yuan que, embora aprovado no exame imperial, optou pela reclusão acadêmica. Sua obra-prima \'Margem da Água\' (Shuihu Zhuan), sobre rebeldes justiceiros e honra marcial, definiu o arquétipo dos épicos marciais chineses.';

  @override
  String get showEnglish => 'Mostrar inglês';

  @override
  String get showEnglishTranslations => 'Mostrar traduções em inglês';

  @override
  String get showHanzi => 'Mostrar Hanzi';

  @override
  String get showPinyin => 'Mostrar Pinyin';

  @override
  String get showTranslation => 'Mostrar tradução';

  @override
  String get shows => 'Programas';

  @override
  String get signIn => 'Entrar';

  @override
  String get simplifiedArticle => 'Artigo simplificado';

  @override
  String get simplifyingSubtitles => 'Simplificando legendas...';

  @override
  String get sincereHonest => 'sincero e honesto';

  @override
  String get sleepTimer => 'Temporizador de sono';

  @override
  String get smartDeck => 'Baralho inteligente';

  @override
  String get spanishAndWorld => 'Espanhol e Literatura Mundial';

  @override
  String get speaker => 'Alto-falante';

  @override
  String get spotifyStylePlayer => 'Player estilo Spotify';

  @override
  String get storyBookmarkedInLibrary => 'História salva na biblioteca!';

  @override
  String get streetFoodNightMarketInXian =>
      'Mercado noturno de comida de rua em Xi\'an';

  @override
  String get strokes => 'Traços';

  @override
  String get studyCharacter => 'Estudar caractere';

  @override
  String get subtitleOpacity => 'Opacidade da legenda';

  @override
  String get suggestion => 'Sugestão';

  @override
  String get summary => 'Resumo';

  @override
  String get supernaturalAndFolklore => 'Sobrenatural e Folclore';

  @override
  String get swipeToGrade => 'Deslize para avaliar:';

  @override
  String get tableOfContents => 'Sumário';

  @override
  String get tapToRetry => 'Toque para tentar novamente';

  @override
  String get teaTastingInChengdu => 'Degustação de chá tradicional em Chengdu';

  @override
  String get techAndGadgets => 'Tecnologia e Gadgets';

  @override
  String get terms => 'Termos de Serviço';

  @override
  String get theGalaxyCharacters =>
      'O Mapa da Galáxia espera por você.\nDomine os Sóis (Radicais) para desbloquear os Planetas (Caracteres).';

  @override
  String get theme => 'Tema';

  @override
  String get thinking => 'Pensando...';

  @override
  String get thisArticleCharacters =>
      'Este artigo contém caracteres chineses tradicionais.';

  @override
  String get todaysWord => 'PALAVRA DO DIA';

  @override
  String get togglePinyin => 'Alternar Pinyin';

  @override
  String get toggleTranslation => 'Alternar tradução';

  @override
  String get toneDoesNotExistInMandarin =>
      'Este tom não existe no mandarim padrão.';

  @override
  String get toneGraph => 'Gráfico de pitch dos tons';

  @override
  String get traceLabel => 'Traçar';

  @override
  String get trailer => 'TRAILER';

  @override
  String get translatingAndAddingPinyin => 'Traduzindo e adicionando Pinyin...';

  @override
  String get translatingText => 'Traduzindo texto...';

  @override
  String get turnOn => 'Ativar';

  @override
  String get typeHanziPinyinOrEnglish =>
      'Digite Hanzi, Pinyin ou significado...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Desenrolando o pergaminho...';

  @override
  String get upperIntermediate => 'Intermediário superior';

  @override
  String get vibrationsForInteractions => 'Vibrações para interações (Haptic)';

  @override
  String get video => 'Vídeo';

  @override
  String get viewAnswer => 'Ver resposta';

  @override
  String get viewAsList => 'Ver como lista';

  @override
  String get viewBookmarks => 'Ver favoritos';

  @override
  String get viewMyDrawing => 'Ver meu desenho';

  @override
  String get vlog => 'Vlog diário da China';

  @override
  String get voice => 'Voz:';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou => 'Adoraríamos receber\nseu feedback.';

  @override
  String get welcomeBack => 'Bem-vindo de volta';

  @override
  String get whatDoesThisMean => 'O que isso significa?';

  @override
  String get whatHappensToMyChatHistory =>
      'O que acontece com meu histórico de chat?';

  @override
  String get whatIfAiMishears =>
      'O que posso fazer se a IA interpretar mal o que eu disse?';

  @override
  String get whichCharacterIs => 'Qual caractere corresponde a:';

  @override
  String get wikipedia => 'Wikipédia';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Palavras salvas e agendadas no sistema SRS!';

  @override
  String get writeYourMessageHere => 'Escreva sua mensagem aqui...';

  @override
  String get wuChengenLiterature =>
      'Wu Cheng\'en (c. 1500–1582) foi um romancista da dinastia Ming natural de Huai\'an, Jiangsu. Inspirando-se no folclore, em alegorias budistas e em seu refinado humor satírico, teceu o mito da peregrinação Tang na célebre obra \'Jornada ao Oeste\' — um dos clássicos mais inventivos e amados da literatura mundial.';

  @override
  String get wuJingziClass =>
      'Wu Jingzi (1701–1754) foi um romancista da dinastia Qing natural de Anhui que abriu mão de sua herança para dedicar a vida à escrita de \'Os Letrados\' (Rulin Waishi) — uma brilhante sátira que desnudou a vaidade, a corrupção e os absurdos do sistema de exames imperiais e da burocracia erudita.';

  @override
  String get xuZhonglinWarfare =>
      'Xu Zhonglin (ativo nos sécs. XVI–XVII) foi um autor da dinastia Ming ao qual se atribui a compilação de \'A Investidura dos Deuses\' (Fengshen Yanyi), monumento da literatura mitológica que funde a história da transição Shang-Zhou com a cosmologia taoista, burocracias celestiais e batalhas épicas.';

  @override
  String get yearly => 'Anual';

  @override
  String get yesReGradeMe => 'Sim, reavalie-me!';

  @override
  String you(Object lang) {
    return 'Você ($lang)';
  }

  @override
  String get youAreSpeaking => 'Você está falando';

  @override
  String get youLabel => 'Você';

  @override
  String youLang(String lang) {
    return 'Você ($lang)';
  }

  @override
  String get youMustAccount =>
      'Você deve aceitar os Termos de Serviço e a Política de Privacidade para criar uma conta.';

  @override
  String get yourEchoModels =>
      'O histórico de conversas de Roleplay que você salvar permanece localmente no dispositivo para consulta posterior. Não usamos suas conversas pessoais para treinar nossos modelos de IA.';

  @override
  String get zhOnly => 'Apenas Chinês (ZH)';

  @override
  String get hsk_1300_cards => '1300 cartões';

  @override
  String get hsk_154_cards => '154 cartões';

  @override
  String get hsk_162_cards => '162 cartões';

  @override
  String get hsk_2500_cards => '2500 cartões';

  @override
  String get hsk_299_cards => '299 cartões';

  @override
  String get hsk_602_cards => '602 cartões';

  @override
  String get added_to_review_queue => 'Adicionado à fila de revisão';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'Adicionados $cardCount cartões a «$deckName».';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '«$hanzi» foi adicionado à sua biblioteca';
  }

  @override
  String get advanced => 'Avançado';

  @override
  String get ai_stories => 'Histórias com IA';

  @override
  String analysis_failed(Object error) {
    return 'Falha na análise: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Analisando a pronúncia com Gemini AI...';

  @override
  String get analyzing_your_pronunciation => 'Analisando sua pronúncia...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Tem certeza de que deseja excluir permanentemente «$deckName»? Esta ação não pode ser desfeita e removerá todos os cartões contidos nele.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Pergunte sobre «$hanzi»...';
  }

  @override
  String get audio_haptics => 'Áudio e Resposta Tátil';

  @override
  String get audio_could_not_start_check_your =>
      'Não foi possível iniciar o áudio. Verifique sua conexão e os ajustes de voz do dispositivo.';

  @override
  String get calligraphy_trace => 'Traçado caligráfico';

  @override
  String chapters(Object count) {
    return '$count Capítulos';
  }

  @override
  String get char => 'Caractere';

  @override
  String get chinese_character => 'CARACTERE CHINÊS';

  @override
  String get contact_us_and_report_issues => 'Fale conosco e relate problemas';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Baralho inteligente criado: «$deckName» com $wordCount palavras!';
  }

  @override
  String get custom_ai_generated_story =>
      'História personalizada gerada por IA.';

  @override
  String get display_content => 'Exibição e Conteúdo';

  @override
  String get do_you_keep_or_store_my =>
      'Vocês gravam ou armazenam minhas gravações de voz?';

  @override
  String get elementary => 'Elementar';

  @override
  String error_creating_scenario(Object error) {
    return 'Erro ao criar cenário: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Erro ao buscar tradução: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Erro ao carregar capítulos: $error';
  }

  @override
  String get error_loading_decks => 'Erro ao carregar baralhos';

  @override
  String error_loading_microreads(Object error) {
    return 'Erro ao carregar microleituras: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Erro ao carregar romances: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Erro ao carregar poesias: $error';
  }

  @override
  String get etymology => 'Etimologia e origem: ';

  @override
  String get explanation => 'Explicação';

  @override
  String get extracted_text_tap_to_lookup =>
      'Texto extraído (Toque para pesquisar)';

  @override
  String extraction_failed(Object error) {
    return 'Falha na extração: $error';
  }

  @override
  String get failed_to_download => 'Falha no download.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Falha ao gerar cenário: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Falha ao gerar história:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Falha ao carregar contexto: $error';
  }

  @override
  String get feature_request => 'Sugestão de funcionalidade';

  @override
  String get foundation => 'Fundamentos';

  @override
  String get how_is_my_pronunciation_scored =>
      'Como minha pronúncia é avaliada?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'Vocabulário HSK $hskLevel';
  }

  @override
  String get hsk_level => 'NÍVEL HSK';

  @override
  String get intermediate => 'Intermediário';

  @override
  String get learning_stats => 'Estatísticas de aprendizado';

  @override
  String get mandarin => 'Mandarim';

  @override
  String get meaning => 'Significado';

  @override
  String get no_decks_found => 'Nenhum baralho encontrado.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'Nenhum resultado encontrado para «$searchQuery»';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'As gravações enviadas para avaliação de pronúncia são processadas com segurança e não são mantidas pela SinoSpark após o processamento. O histórico de Roleplay que você optar por salvar pode permanecer no dispositivo e ser excluído no app.';

  @override
  String get notification_settings => 'Configurações de notificação';

  @override
  String get open_settings => 'Abrir Configurações';

  @override
  String get phoneme => 'Fonema';

  @override
  String get play_reference_pronunciation =>
      'Reproduzir pronúncia de referência';

  @override
  String get please_select_a_deck_to_add =>
      'Selecione um baralho para adicionar cartões.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Aponte para o texto em chinês para traduzir';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Pratique traçar os traços à mão livre';

  @override
  String get preferences_audio_and_display => 'Preferências, áudio e exibição';

  @override
  String get preparing_your_scholars_verdict =>
      'Preparando o Veredito do Erudito...';

  @override
  String get previous => 'Anterior';

  @override
  String question(Object current, Object total) {
    return 'Pergunta $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Remover «$hanzi» deste baralho?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'Erro RevenueCat: $error';
  }

  @override
  String get review_tomorrow => 'Revisar amanhã';

  @override
  String get roleplay => 'Roleplay (Interpretação)';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Salvando $wordCount palavras em «$deckName»...';
  }

  @override
  String get search_radicals_eg_water => 'Pesquisar radicais (ex.: Água, 氵)';

  @override
  String get select_target_hsk_level => 'Selecione o nível HSK desejado';

  @override
  String get sentence => 'Frase';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'O Estúdio de Shadowing é um espaço dedicado para praticar a imitação de falantes nativos em tempo real.';

  @override
  String simplify_failed(Object error) {
    return 'Falha na simplificação: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Fala e Pronúncia';

  @override
  String get statistics => 'Estatísticas';

  @override
  String get table_of_contents => 'Sumário · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'A IA avalia sua fala em três dimensões:\n• Precisão: você articulou as sílabas corretas?\n• Completude: você pulou ou esqueceu alguma palavra?\n• Fluência: você fez pausas naturais e usou os tons corretos?\nO sistema compara seu áudio com padrões nativos para gerar uma nota de 0 a 100.';

  @override
  String get this_cannot_be_undone => 'Esta ação não pode ser desfeita.';

  @override
  String get title => 'Título';

  @override
  String get to_be_reviewed => 'Para revisar';

  @override
  String get traditional => 'Tradicional';

  @override
  String translation_failed(Object error) {
    return 'Falha na tradução: $error';
  }

  @override
  String get type_in => 'Digite...';

  @override
  String get type_your_message_in => 'Digite sua mensagem em...';

  @override
  String get unable_to_open_this_video_please =>
      'Não foi possível abrir este vídeo. Tente novamente mais tarde.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Veja seu histórico de estudo e sequências de dias';

  @override
  String get what_is_shadowing_studio => 'O que é o Estúdio de Shadowing?';

  @override
  String get words => 'palavras';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Sua rota para «$deckName» está pronta!';
  }

  @override
  String get you_said => '🗣️ Você disse';

  @override
  String vocabularyBatch(Object index) {
    return 'Lote de vocabulário $index';
  }

  @override
  String get yourDailyDropIsHere => 'Sua Dose Diária está pronta! ✨';

  @override
  String get timeToReview => 'Hora de revisar! 📚';

  @override
  String get neverMissAStroke => 'Não perca nenhum traço! 🖌️';

  @override
  String get yourTrialEndsTomorrow =>
      'Seu período de teste gratuito termina amanhã! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Níveis oficiais de vocabulário padrão';

  @override
  String get failedToLoadCollections => 'Falha ao carregar coleções.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Erro: $error';
  }

  @override
  String get aiSmartContext => 'Contexto inteligente da IA';

  @override
  String get aiSmartContextError => 'Erro no contexto inteligente da IA';

  @override
  String get downloadOfficialHskCollections =>
      'Baixar coleções oficiais do HSK';

  @override
  String get unableToLoadThisSection =>
      'Não foi possível carregar esta seção. Tente novamente.';

  @override
  String get translationLanguage => 'Idioma de tradução';

  @override
  String get dailyDrops => 'Doses Diárias';

  @override
  String get wordOfTheDayNews => 'Palavra do dia e notícias';

  @override
  String get reviewReminders => 'Lembretes de revisão';

  @override
  String get flashcardsDueForReview => 'Flashcards pendentes de revisão';

  @override
  String get dailyNewCards => 'Novos cartões diários';

  @override
  String get dailyReviewLimit => 'Limite diário de revisão';

  @override
  String get practiceMode => 'Modo de prática';

  @override
  String get liziqi => 'Li Ziqi (李子柒): Flores de seda';

  @override
  String get theLifeOfGarlicTraditional =>
      'A vida do alho: tradições rurais chinesas';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 frases essenciais';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Frases essenciais em chinês para iniciantes';

  @override
  String get makingBambooFurniture => 'Fabricação de móveis em bambu';

  @override
  String get peppaPigChinese => 'Peppa Pig em chinês: Esconde-esconde (躲猫猫)';

  @override
  String get muddyPuddlesBeginnerFriendly => 'Poças de lama (nível iniciante)';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 verbos essenciais';

  @override
  String get mostCommonChineseVerbs => 'Os verbos mais comuns em chinês';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Como pedir comida';

  @override
  String get howToOrderFoodIn => 'Como pedir comida em um restaurante chinês';

  @override
  String get silkFlowersTraditionalCraft =>
      'Flores de seda: artesanato tradicional';

  @override
  String get mandarinCorner => 'Mandarin Corner: Consulta médica em chinês';

  @override
  String get goingToTheDoctorReal => 'Indo ao médico: conversa da vida real';

  @override
  String get hideAndSeekBeginnerFriendly => 'Esconde-esconde (nível iniciante)';

  @override
  String get linGdp6 => 'Xiao Lin explica: Por que o PIB cresce 6%?';

  @override
  String get why6GdpGrowthEasy =>
      'Por que 6% de crescimento do PIB: economia chinesa descomplicada';

  @override
  String get bbcWorldNews => 'BBC 中文 (Notícias do Mundo)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Atualidades em chinês simplificado';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'BANCADA DO YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'Transcrições interativas e shadowing';

  @override
  String get showsDramas => 'SÉRIES E DRAMAS';

  @override
  String get extractToDeck => 'Extrair para o baralho';

  @override
  String get autoSimplify => 'Simplificar automaticamente';

  @override
  String get rewriteThisArticleToMatch =>
      'Reescrever este artigo para o seu nível HSK';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Falha ao salvar palavras extraídas: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Adicionar ao baralho ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Dose diária de descoberta';

  @override
  String get smartSpacedRepetition => 'Repetição espaçada inteligente (SRS)';

  @override
  String get trialProtectionAlert => 'Alerta de proteção do período de teste';

  @override
  String get masteryLevel => 'Nível de domínio';

  @override
  String get targetObjective => 'Objetivo de estudo';

  @override
  String get dailyPractice => 'Prática diária';

  @override
  String get aiSpacedRepetition => 'Repetição espaçada com IA';

  @override
  String get iVeGrantedAccess => 'Acesso concedido';

  @override
  String get scanner => 'Scanner';

  @override
  String get interpreter => 'Intérprete';

  @override
  String cards(Object count) {
    return '$count cartões';
  }

  @override
  String get nWaMendsTheHeavens => 'Nüwa remenda o céu (女娲补天)';

  @override
  String get terracottaArmy => 'Exército de Terracota';

  @override
  String get forbiddenCity => 'Cidade Proibida';

  @override
  String get aBlessingInDisguise => 'Há males que vêm para o bem (塞翁失马)';

  @override
  String get drawingASnake => 'Desenhar pés em uma cobra (画蛇添足)';

  @override
  String get takingTheBulletTrain => 'Viajar no trem de alta velocidade';

  @override
  String get visitingTheDoctor => 'Ir ao médico';

  @override
  String get orderingDumplings => 'Pedir jiaozi (pasteizinhos cozidos)';

  @override
  String get theTeaCeremony => 'A cerimônia tradicional do chá';

  @override
  String get chineseCalligraphy => 'Caligrafia chinesa';

  @override
  String get theGiantPanda => 'O panda-gigante';

  @override
  String get simplifiedText => 'Texto simplificado';

  @override
  String get novels96 => 'Romances (96 obras)';

  @override
  String get microReads => 'Microleituras';

  @override
  String get poetry => 'Poesia e versos clássicos';

  @override
  String get bookmarkRemoved => '书签已移除 · Favorito removido';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Favorito adicionado: Capítulo $chapter';
  }

  @override
  String get readingVocabulary => 'Leitura e vocabulário';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Lote de vocabulário $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'Sua Dose Diária está pronta! ✨';

  @override
  String get timeToReview1 => 'Hora de revisar! 📚';

  @override
  String get neverMissAStroke1 => 'Não perca nenhum traço! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 =>
      'Seu período de teste gratuito termina amanhã! ⏳';

  @override
  String get hskCollections1 => 'Coleções HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Níveis oficiais de vocabulário padrão';

  @override
  String get failedToLoadCollections1 => 'Falha ao carregar coleções.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Reproduzir $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Erro: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'Contexto inteligente da IA';

  @override
  String get aiSmartContextError1 => 'Erro no contexto inteligente da IA';

  @override
  String errorErr(Object err, Object error) {
    return 'Erro: $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Baixar coleções oficiais do HSK';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Não foi possível carregar esta seção. Tente novamente.';

  @override
  String get searchRadicalsEgWater => 'Pesquisar radicais (ex.: Água, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Idioma de tradução';

  @override
  String get appLanguage1 => 'Idioma do aplicativo';

  @override
  String get dailyDrops1 => 'Doses Diárias';

  @override
  String get wordOfTheDayNews1 => 'Palavra do dia e notícias';

  @override
  String get reviewReminders1 => 'Lembretes de revisão';

  @override
  String get flashcardsDueForReview1 => 'Flashcards pendentes de revisão';

  @override
  String get accuracyByMode1 => 'Precisão por modo';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => 'Próximas revisões (próximos 7 dias)';

  @override
  String get explaining => 'Explicação:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Novos cartões diários';

  @override
  String get dailyReviewLimit1 => 'Limite diário de revisão';

  @override
  String get listeningMode1 => 'Modo de Escuta';

  @override
  String get readingMode1 => 'Modo de Leitura';

  @override
  String get recallMode1 => 'Modo de Recordação';

  @override
  String get speakingMode1 => 'Modo de Fala';

  @override
  String get practiceMode1 => 'Modo de Prática';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'Interlocutor';

  @override
  String get partnerSpeaking1 => 'O interlocutor está falando…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'A vida do alho: tradições rurais chinesas';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 frases essenciais';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Frases essenciais em chinês para iniciantes';

  @override
  String get makingBambooFurniture1 => 'Fabricação de móveis em bambu';

  @override
  String get muddyPuddlesBeginnerFriendly1 => 'Poças de lama (nível iniciante)';

  @override
  String get mandarinCorner300Verbs1 =>
      'Mandarin Corner: 300 verbos fundamentais';

  @override
  String get mostCommonChineseVerbs1 => 'Os verbos mais comuns em chinês';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Como pedir comida';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Como pedir comida em um restaurante chinês';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Flores de seda: artesanato tradicional';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Indo ao médico: conversa da vida real';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'Esconde-esconde (nível iniciante)';

  @override
  String get lingdp6 => 'Xiao Lin explica: Por que o PIB cresce 6%?';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Por que 6% de crescimento do PIB: economia chinesa descomplicada';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Atualidades em chinês simplificado';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'BANCADA DO YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Transcrições interativas e shadowing';

  @override
  String get showsDramas1 => 'SÉRIES E DRAMAS';

  @override
  String error_error(Object error) {
    return 'Erro: $error';
  }

  @override
  String get extractToDeck1 => 'Extrair para o baralho';

  @override
  String get autosimplify => 'Simplificar automaticamente';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Reescreva este artigo para o seu nível HSK';

  @override
  String get addToDeck1 => 'Adicionar ao baralho';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Dose Diária de Descoberta';

  @override
  String get smartSpacedRepetition1 => 'Repetição espaçada inteligente (SRS)';

  @override
  String get trialProtectionAlert1 => 'Alerta de proteção do período de teste';

  @override
  String get masteryLevel1 => 'Nível de domínio';

  @override
  String get targetObjective1 => 'Objetivo de estudo';

  @override
  String get dailyPractice1 => 'Prática diária';

  @override
  String get aiSpacedRepetition1 => 'Repetição espaçada com IA';

  @override
  String get iveGrantedAccess => 'Acesso concedido';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Adicionar ao baralho ($count)';
  }

  @override
  String get scanner1 => 'Scanner';

  @override
  String get interpreter1 => 'Intérprete';

  @override
  String entryvalueCards(Object count) {
    return '$count cartões';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Pontuação: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'O Rei Macaco';

  @override
  String get huaMulan1 => 'Hua Mulan';

  @override
  String get nwaMendsTheHeavens => 'Nüwa remenda o céu';

  @override
  String get confucius => 'Confúcio';

  @override
  String get theGreatWall1 => 'A Grande Muralha';

  @override
  String get terracottaArmy1 => 'Exército de Terracota';

  @override
  String get forbiddenCity1 => 'Cidade Proibida';

  @override
  String get aBlessingInDisguise1 => 'Há males que vêm para o bem';

  @override
  String get drawingASnake1 => 'Desenhar pés em uma cobra';

  @override
  String get takingTheBulletTrain1 => 'Viajar no trem de alta velocidade';

  @override
  String get visitingTheDoctor1 => 'Ir ao médico';

  @override
  String get orderingDumplings1 => 'Pedir jiaozi (pasteizinhos cozidos)';

  @override
  String get theTeaCeremony1 => 'A cerimônia do chá';

  @override
  String get chineseCalligraphy1 => 'Caligrafia chinesa';

  @override
  String get theGiantPanda1 => 'O panda-gigante';

  @override
  String get simplifiedText1 => 'Texto simplificado';

  @override
  String get novels961 => 'Romances (96 obras)';

  @override
  String get microreads => 'Microleituras';

  @override
  String get poetry1 => 'Poesia e versos clássicos';

  @override
  String get readingVocabulary1 => 'Leitura e vocabulário';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions não foram configuradas para Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions não são suportadas nesta plataforma.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'Os traços não podem estar vazios.';

  @override
  String get wrongStartPoint => 'Ponto de partida incorreto.';

  @override
  String get rightShapeButWrongPlace => 'Forma correta, mas no lugar errado!';

  @override
  String get goodFollowTheFlow => 'Ótimo! Siga o fluxo natural do traço.';

  @override
  String get aBitShaky => 'O traço ficou um pouco trêmulo!';

  @override
  String get aBitHesitant => 'Um pouco hesitante...';

  @override
  String get shapeIsOff => 'A forma do traço está incorreta.';

  @override
  String get arabic => 'Árabe';

  @override
  String get german => 'Alemão';

  @override
  String get spanish => 'Espanhol';

  @override
  String get french => 'Francês';

  @override
  String get hindi => 'Hindi';

  @override
  String get indonesian => 'Indonésio';

  @override
  String get italian => 'Italiano';

  @override
  String get japanese => 'Japonês';

  @override
  String get korean => 'Coreano';

  @override
  String get portuguese => 'Português';

  @override
  String get russian => 'Russo';

  @override
  String get vietnamese => 'Vietnamita';

  @override
  String get microphonePermissionDenied => 'Permissão do microfone negada';

  @override
  String get offset => 'Deslocamento';

  @override
  String get audioserviceHasBeenDisposed => 'O AudioService foi descartado';

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
  String get kore => 'Kore (feminino, calorosa)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Palavra-âncora';

  @override
  String get creativeThematicTitle => 'Título temático criativo';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Breve justificativa pedagógica ou semântica';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'O caractere mais representativo da lista';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Um conjunto equilibrado de caracteres da sua biblioteca.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Sua resposta conversacional natural em caracteres chineses.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'A tradução em português da sua resposta.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'O pinyin com marcas de tom para sua resposta.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Uma resposta sugerida que o usuário poderia dar a você.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin para a sugestão.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Tradução em português para a sugestão.';

  @override
  String get scholarsCritique => 'Crítica e feedback do Erudito';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'O Salão do Eco permanece em silêncio. Respire fundo e tente novamente.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'Nenhum ainda.';

  @override
  String get exactSentence => 'Frase exata:';

  @override
  String get englishTranslation => 'Tradução em português';

  @override
  String get previouslyGeneratedPhrases => 'Frases geradas anteriormente';

  @override
  String get iLikeDrinkingAppleJuice => 'Eu gosto de beber suco de maçã.';

  @override
  String get theEnglishMeaningHere => 'O significado em português aqui...';

  @override
  String get failedToFetchDefinition => 'Falha ao buscar definição.';

  @override
  String get failedToLoadExplanation => 'Falha ao carregar explicação.';

  @override
  String get failedToLoadComparison => 'Falha ao carregar comparação.';

  @override
  String get emptyResponseFromOpenrouter => 'Resposta vazia do OpenRouter';

  @override
  String get emptyResponseFromVisionModel => 'Resposta vazia do modelo Vision';

  @override
  String get standard => 'Padrão';

  @override
  String get theFullSentenceInChinese => 'A frase completa em chinês...';

  @override
  String get theWordOrCharacterInChinese => 'A palavra ou caractere em chinês';

  @override
  String get thePinyinForThisSpecificWord =>
      'O pinyin para esta palavra específica';

  @override
  String get emptyResponseFromDeepseekApi => 'Resposta vazia da API DeepSeek';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'IMPORTANTE: Insira a tradução em português em';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Tradução em português da frase completa';

  @override
  String get hanziWord => 'Palavra em Hanzi';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'A frase completa em chinês simplificado...';

  @override
  String get lyingFlatACulturalMovement =>
      'Tang Ping (Deitar-se): um fenômeno cultural...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'O usuário com quem você está falando se chama';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'REGRA IMPORTANTE: Não se dirija ao usuário por nenhum nome específico. Nunca use nomes de exemplo como';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Você é um tutor conciso e especialista em caligrafia e etimologia chinesa dentro de um aplicativo móvel de flashcards.';

  @override
  String get theStudentIsStudyingTheCharacter =>
      'O aluno está estudando o caractere';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Nunca escreva introduções, despedidas ou frases de preenchimento como';

  @override
  String get beDirectAndInformative => 'Seja direto e informativo.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'REGRA CRÍTICA: Você deve responder INTEIRAMENTE no idioma correspondente ao código ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Você é um tutor conciso de gramática chinesa dentro de um aplicativo móvel.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'O aluno tem dúvidas sobre a palavra';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Nunca escreva introduções, despedidas ou frases de preenchimento.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'As chaves da API de Fala do Azure estão ausentes.';

  @override
  String get success => 'Sucesso';

  @override
  String get granularity => 'Granularidade';

  @override
  String get phoneme1 => 'Fonema';

  @override
  String get dimension => 'Dimensão';

  @override
  String get comprehensive => 'Abrangente';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Não conseguimos ouvir você com clareza. Tente novamente.';

  @override
  String get noNbestResultFound =>
      'Nenhum resultado ideal de reconhecimento foi encontrado.';

  @override
  String get words1 => 'Palavras';

  @override
  String get word => 'Palavra';

  @override
  String get phonemes => 'Fonemas';

  @override
  String get syllables => 'Sílabas';

  @override
  String get syllable => 'Sílaba';

  @override
  String get omission => 'Omissão';

  @override
  String get insertion => 'Inserção';

  @override
  String get youMissedThisWord => 'Você pulou esta palavra.';

  @override
  String get extraWordAddedHere => 'Palavra extra adicionada aqui.';

  @override
  String get mispronunciation => 'Pronúncia incorreta';

  @override
  String get pronunciationWasInaccurate => 'A pronúncia estava imprecisa.';

  @override
  String get goodEffortKeepPracticing => 'Bom esforço! Continue praticando.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Pronúncia perfeita! Soa como um falante nativo.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Ótimo trabalho! Apenas pequenas imprecisões nos tons.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Nada mal, mas seus tons ainda precisam de um pouco de prática.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Continue praticando! Ouça o áudio nativo e tente novamente.';

  @override
  String get lexical => 'Lexical';

  @override
  String get chineseHanziHere => 'Hanzi chinês aqui';

  @override
  String get aShortSummaryInEnglish => 'Um breve resumo em português';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'Nenhum texto chinês legível foi encontrado no escaneamento.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'A tradução completa em português do texto escaneado... OU \'Nenhum texto chinês legível encontrado.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Um título curto de 2 a 4 palavras para este escaneamento (ex.: \'Cardápio do Restaurante\', \'Placa de Rua\')';

  @override
  String get china => 'China';

  @override
  String get noTranslationAvailable => 'Nenhuma tradução disponível.';

  @override
  String get scanResults => 'Resultados do Escaneamento';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Quando foi escrito e qual era o contexto histórico na China na época?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Por que esta obra é famosa? Quais temas filosóficos ou culturais ela explora?';

  @override
  String get aBriefBioOfTheAuthor => 'Uma breve biografia do autor.';

  @override
  String get informationUnavailable => 'Informação indisponível.';

  @override
  String get noSummaryAvailable => 'Nenhum resumo disponível.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'Teste, Normal, Introdução';

  @override
  String get dailyDrop => 'Dose Diária';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Notificações diárias para a Palavra do Dia e notícias';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Uma nova Palavra e História do Dia estão esperando por você!';

  @override
  String get spacedRepetition => 'Repetição Espaçada (SRS)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Lembretes para flashcards pendentes de revisão';

  @override
  String get engagementReminders => 'Lembretes de Engajamento';

  @override
  String get trialReminders => 'Lembretes do Período de Teste';

  @override
  String get notificationsForYourTrialStatus =>
      'Notificações sobre o status do seu período de teste';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Venha revisar seus Hanzi e experimente uma Chamada ao Vivo antes do término do seu acesso gratuito!';

  @override
  String get scholarsEye => 'Olhar do Erudito';

  @override
  String get clMeasureWord => 'Classificador (CL):';

  @override
  String get surnameShi => 'Sobrenome Shi';

  @override
  String get chineseFamilyNameShi => 'Sobrenome chinês (Shi)';

  @override
  String get neutralToneLight => 'Tom Neutro (Leve)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Mantenha seu tom alto e constante, como sustentar uma nota musical.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Comece em uma altura média e eleve o tom para cima, como perguntando \'O quê?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Baixe a voz até um tom grave e depois suba suavemente.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Baixe o tom de forma rápida e decidida, como em um \'Não!\' enfático.';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Pronuncie de forma leve, curta e sem ênfase.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'Perfeito! O tom foi mantido alto, plano e estável.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'Perfeito! A elevação do tom para cima foi clara e nítida.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'Perfeito! A descida e a leve subida do tom foram muito precisas.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'Perfeito! A queda rápida e firme do tom foi certeira.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'Perfeito! O tom foi pronunciado com exatidão.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Concordo com os Termos de Serviço e a Política de Privacidade.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Quero receber novidades, dicas e ofertas especiais.';

  @override
  String get signInToSyncYourProgress =>
      'Faça login para sincronizar seu progresso na nuvem.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Crie uma conta para salvar suas estatísticas de estudo.';

  @override
  String get smartSpiral => 'ESPIRAL INTELIGENTE';

  @override
  String get origin => 'Origem';

  @override
  String get elements => 'Elementos Naturais';

  @override
  String get humanity => 'Humanidade e Corpo';

  @override
  String get village => 'Vida e Aldeia';

  @override
  String get journey => 'Jornada e Movimento';

  @override
  String get city => 'Cidade e Sociedade';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'As formas mais fundamentais. O início de todas as coisas.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Sol, Lua, Água e Fogo. O mundo natural.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'O corpo, o coração e a família.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Campos, telhados e ferramentas. Os alicerces da sociedade.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Movimento, fala e sustento.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Comércio, vestuário e a complexidade da civilização.';

  @override
  String get equilibriumAlgorithm => 'Algoritmo de Equilíbrio';

  @override
  String get misc => 'Diversos';

  @override
  String get cityOrOriginAs => '«Cidade» ou «Origem» como';

  @override
  String get miscToOrigin => 'De «Diversos» para «Origem»';

  @override
  String get constellation => 'Constelação';

  @override
  String get whichOneIsWater => 'Qual destes significa \'Água\'?';

  @override
  String get whatIsThePinyin => 'Qual é o pinyin correto?';

  @override
  String get nature => 'Natureza';

  @override
  String get whatEssenceDoes => 'Qual essência (radical) compõe';

  @override
  String get allTiers => 'Todos os Níveis';

  @override
  String get active => 'Ativo';

  @override
  String get theScrollOfOrigin1 => 'O PERGAMINHO DA ORIGEM';

  @override
  String galaxyOf1(Object name) {
    return 'GALÁXIA DE $name';
  }

  @override
  String get also => 'Também';

  @override
  String get work => 'Trabalho';

  @override
  String get cloud => 'Nuvem';

  @override
  String get youArchaic => 'Tu (arcaico)';

  @override
  String get suddenly => 'De repente';

  @override
  String get owner => 'Proprietário';

  @override
  String get door => 'Porta';

  @override
  String get occupy => 'Ocupar';

  @override
  String get nail => 'Prego';

  @override
  String get and => 'E';

  @override
  String get buddhistNun => 'Monja Budista';

  @override
  String get anxious => 'Ansioso';

  @override
  String get sprout => 'Broto';

  @override
  String get exchange => 'Troca';

  @override
  String get sheep => 'Ovelha';

  @override
  String get strange => 'Estranho';

  @override
  String get opposite => 'Oposto';

  @override
  String get shorttailedBird => 'Pássaro de cauda curta (隹)';

  @override
  String get shoot => 'Disparar / Broto de bambu';

  @override
  String get small => 'Pequeno';

  @override
  String get gather => 'Reunir';

  @override
  String get order => 'Ordem';

  @override
  String get flat => 'Plano';

  @override
  String get thePersonWho => 'A pessoa que...';

  @override
  String get nobleman => 'Nobre / Cavalheiro';

  @override
  String get cause => 'Causa';

  @override
  String get pig => 'Porco';

  @override
  String get bright => 'Brilhante';

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
  String get beg => 'Pedir / Rogar';

  @override
  String get window => 'Janela';

  @override
  String get fear => 'Medo';

  @override
  String get drum => 'Tambor';

  @override
  String get why => 'Por que / Razão';

  @override
  String get talent => 'Talento';

  @override
  String get follow => 'Seguir';

  @override
  String get desert => 'Deserto';

  @override
  String get component => 'Componente';

  @override
  String divingInto1(Object topic) {
    return 'Mergulhando em $topic';
  }

  @override
  String get unitIntro1 => 'Introdução da Unidade';

  @override
  String get theBlueprint => 'O PROJETO';

  @override
  String get theOrigin => 'A ORIGEM';

  @override
  String get theGalaxy => 'A GALÁXIA';

  @override
  String get theScholarListens => 'O Erudito escuta...';

  @override
  String get consultingTheScrolls => 'Consultando os pergaminhos...';

  @override
  String get traceWithTheGuide => 'Trace com a Guia';

  @override
  String get traceTheGhost => 'Trace sobre a marca d\'água';

  @override
  String get connectTheDots => 'Ligue os Pontos';

  @override
  String get drawFromMemory => 'Desenhe de Memória';

  @override
  String get assistant => 'Assistente';

  @override
  String get puck => 'Puck (masculino, esportivo)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Olá! Seja bem-vindo(a). O que você gostaria de pedir hoje?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'Garçom Li';

  @override
  String get askForTheMenu => 'Pedir o cardápio';

  @override
  String get orderOneDishAndOneDrink => 'Pedir um prato e uma bebida';

  @override
  String get askForTheBill => 'Pedir a conta';

  @override
  String get fenrir => 'Fenrir (masculino, animado)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'Motorista Wang';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Diga ao motorista que você vai para o aeroporto';

  @override
  String get askHowLongTheTripWillTake =>
      'Pergunte quanto tempo levará a viagem';

  @override
  String get complainAboutTheTraffic => 'Comente sobre o trânsito pesado';

  @override
  String get charon => 'Charon (masculino, estilo jornalístico)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'A qualidade desta roupa é excelente, custa apenas 200 kuai.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'Tia Chen';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'Pergunte quanto custa a camisa de seda';

  @override
  String get sayItIsTooExpensive => 'Diga que está muito caro';

  @override
  String get bargainThePriceDownTo100Rmb => 'Pechinche o preço para 100 RMB';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'Dr. Zhang';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Explique que você está com dor de cabeça há dois dias';

  @override
  String get sayYouHaveASlightFever => 'Diga que está com um pouco de febre';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Pergunte se é necessário tomar remédio';

  @override
  String get aoede => 'Aoede (feminino, alegre)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Oi! Quanto tempo, como você tem passado ultimamente?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Por favor, apresente-se. Por que você deseja trabalhar em nossa empresa?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'Gerente Liu';

  @override
  String get introduceYourProfessionalBackground =>
      'Apresente brevemente sua trajetória profissional';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Explique por que quer fazer parte desta empresa';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Faça uma pergunta educada sobre a cultura da empresa';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'O acesso ao microfone é obrigatório. Ative-o nos Ajustes do dispositivo.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Não foi possível iniciar o microfone. Verifique as configurações de áudio e tente novamente.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Não conseguimos entender claramente. Segure o botão do microfone e tente novamente!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'A gravação foi muito curta. Segure o botão do microfone e fale com clareza.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'O buffer de áudio estava vazio. Verifique seu microfone e tente novamente.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'O arquivo de áudio está silencioso. Fale diretamente no microfone.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Não conseguimos reconhecer sua pronúncia. Fale claramente e tente de novo.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'O servidor está demorando muito para responder. Tente novamente.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Sem conexão com a internet. Verifique sua rede e tente novamente.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Falha no processamento de áudio. Tente novamente.';

  @override
  String get permission => 'Permissão';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Não foi possível processar sua gravação. Tente novamente.';

  @override
  String get user => 'Usuário';

  @override
  String get scholar => 'Erudito';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Nossos tutores de IA estão temporariamente offline. Tente novamente mais tarde.';

  @override
  String get hideTranslation => 'Ocultar tradução';

  @override
  String get azureAssessment => 'Avaliação Azure em andamento...';

  @override
  String get microphonePermissionRequired =>
      'Permissão de microfone necessária';

  @override
  String get connectedSpeakNow => 'Conectado! Pode falar agora.';

  @override
  String get initializationErrorCheckPermissions =>
      'Erro de inicialização. Verifique as permissões.';

  @override
  String get microphoneErrorTapToRetry =>
      'Erro no microfone. Toque para tentar novamente.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'O tutor retornou uma resposta vazia.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Conexão interrompida. Por favor, fale novamente.';

  @override
  String get callPausedReviewingTones => 'Chamada pausada (revisando tons)';

  @override
  String get pausedTakeABreak => 'Pausado - Faça uma breve pausa';

  @override
  String get goodStartPracticing => 'Ótimo início de prática';

  @override
  String get studentCoach => 'Aluno / Treinador';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Mantenha o 1º tom alto e estável em';

  @override
  String get noScenariosFound => 'Nenhum cenário encontrado.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Crie sua própria experiência de roleplay com IA';

  @override
  String get generateFromDeck => 'Gerar a partir do baralho';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Pratique o vocabulário dos cartões em um diálogo ao vivo';

  @override
  String get tapToRoleplay => 'Toque para iniciar o roleplay';

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
  String get dinnerWithDad => 'Jantar com o Pai';

  @override
  String get orderingAtAChengduTeahouse =>
      'Pedindo em uma casa de chá em Chengdu';

  @override
  String get buyingTeaAtTheMarket => 'Comprando chá no mercado tradicional';

  @override
  String get meetingAnOldClassmate =>
      'Reencontro com um antigo colega de classe';

  @override
  String get readyToPractice => 'Pronto para praticar?';

  @override
  String get letsPracticeChinese => 'Vamos praticar chinês';

  @override
  String get areYouReady => 'Você está pronto?';

  @override
  String get discussWhatToHaveForDinner => 'Decidir o que comer no jantar';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Sugerir assistir a um filme depois do jantar';

  @override
  String get askIfTheyWouldLikeTea => 'Perguntar se gostariam de um chá';

  @override
  String get helloVeryNiceToMeetYou => 'Olá! É um grande prazer conhecer você.';

  @override
  String get deckPractice => 'Prática do baralho';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Pratique vocabulário com um parceiro de IA.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Crie diálogos e roleplays personalizados com IA';

  @override
  String get random => 'Aleatório';

  @override
  String get scenarioTopic => 'Tópico do cenário';

  @override
  String get contextSettingOptional => 'Contexto e ambientação (opcional)';

  @override
  String get aiCharacterPersonaOptional =>
      'Personagem / Persona de IA (opcional)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Uma tranquila casa de chá com pátio de bambu em Chengdu, acompanhada pelo som suave do guzheng.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Um animado mercado noturno repleto de aromas, com espetinhos grelhados, baozi no vapor e comida de rua.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Um animado restaurante de hotpot em Chongqing com caldo vermelho borbulhante e o aroma marcante da pimenta.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Uma tradicional e movimentada casa de chá cantonesa em Guangzhou, repleta de cestos de bambu fumegantes.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Um café elegante e minimalista na Concessão Francesa durante uma tarde chuvosa de domingo.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Uma acolhedora cozinha do norte no inverno, com farinha na mesa e panelas de jiaozi fumegantes.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Um beco de comida de rua noturno ao ar livre com espetinhos de cordeiro na brasa, berinjela assada e cerveja gelada.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Uma esquina coberta de neve em frente ao Templo dos Lamas, com espetinhos de tanghulu vermelhos e brilhantes no gelo.';

  @override
  String get craftBeerBreweryInQingdao => 'Cervejaria artesanal em Qingdao';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Um animado taproom litorâneo com barris de madeira, brisa do mar e chope de trigo artesanal.';

  @override
  String get sichuanCookingMasterclass => 'Masterclass de culinária de Sichuan';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Uma vibrante cozinha aberta com woks em chamas, óleo de pimenta fervente e grãos de pimenta-de-sichuan frescos.';

  @override
  String get highspeedRailSeatMixup =>
      'Troca de assentos no trem de alta velocidade';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Caminhada ao nascer do sol na Grande Muralha em Mutianyu';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'As antigas muralhas de pedra da Grande Muralha ao amanhecer, cercadas por montanhas verdes e enevoadas.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Passeio de balsa de bambu pelo Rio Li em Guilin';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Deslizando pelas águas cársticas esmeralda entre os imponentes picos de calcário perto de Yangshuo.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Passeio de camelo pela Rota da Seda em Dunhuang';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'As ondulantes dunas douradas da Montanha Mingsha ao lado do oásis do Lago da Meia-Lua.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Reservando uma hospedagem tradicional com pátio em Dali';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Um sereno hotel boutique com pátio em estilo Bai com vista para o Lago Erhai, em Yunnan.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Peregrinação ao Palácio de Potala em Lhasa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Os majestosos degraus de pedra ensolarados do Palácio de Potala, com as rodas de oração girando.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Um reino congelado abaixo de zero com palácios de gelo iluminados e imponentes esculturas de neve.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Teleférico das Montanhas de Avatar em Zhangjiajie';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Suspenso no alto em um teleférico panorâmico de vidro, sobrevoando milhares de pilares de arenito.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Acampamento para observação de estrelas no Deserto de Gobi, em Gansu';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Um acampamento de luxo em yurt sob o céu cristalino da Via Láctea no deserto próximo a Jiayuguan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Cruzeiro pelas Três Gargantas do Rio Yangtzé';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'No convés de um navio de cruzeiro fluvial atravessando a imponente Garganta de Qutang.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Comprando antiguidades em Panjiayuan, Pequim';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Um forno cerâmico histórico repleto de delicados vasos de porcelana crua e esmaltes azul-cobalto.';

  @override
  String get suzhouSilkEmbroideryStudio =>
      'Ateliê de bordado em seda de Suzhou';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Um tranquilo ateliê com jardim à beira dos canais de Suzhou, com finos fios de seda e bastidores de madeira.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Nos bastidores de um teatro tradicional de Ópera de Pequim, com trajes coloridos, espelhos e adereços de cabeça.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Consulta de Medicina Tradicional Chinesa (MTC)';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Tai Chi matinal no Parque do Templo do Céu';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Sob ciprestes milenares ao amanhecer, com pássaros cantando e idosos praticando movimentos sincronizados.';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'Aluguel de Hanfu para sessão de fotos';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Uma boutique de trajes tradicionais perto do Lago Oeste com araras de vestes das dinastias Tang e Song.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Oficina de Guqin (cítara clássica chinesa)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Um estúdio tranquilo de madeira de pinho em Hangzhou, repleto de instrumentos de paulóvnia envelhecida e cordas de seda.';

  @override
  String get shaanxiShadowPuppetTheater => 'Teatro de Sombras de Shaanxi';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Atrás de uma tela de seda branca iluminada, com delicadas figuras de couro translúcido do teatro de sombras.';

  @override
  String get chineseCalligraphyWorkshop => 'Oficina de caligrafia chinesa';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Um ateliê tranquilo perfumado com tinta de fuligem de pinho, rolos de papel de arroz e suave aroma de chá.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Adotando um gato em um abrigo de animais';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Um acolhedor centro de resgate de animais em Hangzhou com gatinhos brincalhões e chá para os visitantes.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Jogo de RPG de mistério e assassinato (Jubensha)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Um lounge temático de detetives em Xangai com jogadores caracterizados à luz de velas.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Loja de discos de vinil vintage em Xangai';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Uma loja de vinil escondida em um antigo beco tradicional shikumen, repleta de clássicos do Cantopop e jazz dos anos 80.';

  @override
  String get ktvKaraokePartyWithFriends => 'Festa de karaokê no KTV com amigos';

  @override
  String get joiningACityBikeCyclingClub =>
      'Entrando para um clube de ciclismo urbano';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Um encontro de ciclistas na orla fluvial preparando-se para um passeio noturno apreciando o horizonte da cidade.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Encontro de troca de brinquedos colecionáveis (Blind Box)';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Uma vibrante loja de brinquedos de cultura pop em Chaoyang com prateleiras repletas de caixas colecionáveis lacradas.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Filmagens aéreas com drone do horizonte no Bund';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'O calçadão do Bund ao entardecer com vista para os futuristas arranha-céus iluminados de Pudong.';

  @override
  String get goldenRetrieverCafeInNanjing =>
      'Café de Golden Retrievers em Nanquim';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Um café ensolarado e alegre com dezenas de cães dóceis e brincalhões recebendo os visitantes.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Academia de escalada indoor (Bouldering) em Chengdu';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Uma moderna academia de escalada indoor com vias coloridas e música energética.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Um enorme pavilhão de convenções repleto de estandes de jogos, murais para fotos e cosplayers.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Pedindo informações em um Hutong de Pequim';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Um labirinto de vielas históricas de tijolos cinzas com bicicletas, pátios internos e pés de romã.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Comprando frutas frescas em um mercado tradicional';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Um animado mercado matinal de bairro com bancas cheias de lichia, manga e pitaia frescas.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Buquê no mercado de flores de Kunming';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'O famoso mercado de flores de Dounan cercado por milhares de rosas frescas, lírios e folhas de eucalipto.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Ajustes de alfaiataria em uma antiga casa de viela';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Uma alfaiataria tradicional repleta de máquinas de costura, rolos de tecido e fitas métricas.';

  @override
  String get expressParcelLockerRetrieval =>
      'Retirada de encomenda no armário inteligente (Locker)';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'No térreo, junto à portaria do condomínio, ao lado do armário inteligente Hive Box.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Conserto de pneu furado de bicicleta na portaria do campus';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Uma pequena oficina ao ar livre à beira da calçada, sob a sombra de uma grande figueira-de-bengala.';

  @override
  String get techCompanyProductDemo =>
      'Demonstração de produto de empresa de tecnologia';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Um estande futurista em uma conferência de tecnologia em Shenzhen exibindo hardware de IA de ponta.';

  @override
  String get ecommerceLivestreamStudio =>
      'Estúdio de transmissão ao vivo para e-commerce';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Um estúdio de transmissão dinâmico com ring lights, expositores de produtos e telas de comentários em tempo real.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Mercado de Comércio Internacional de Yiwu';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Um imenso centro comercial de múltiplos andares com milhões de itens e artesanato no atacado.';

  @override
  String get universityCampusExchangeProgram =>
      'Programa de intercâmbio no campus universitário';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Um gramado ensolarado em frente à biblioteca da universidade com estudantes lendo e tomando chá com leite.';

  @override
  String get pleaseEnterAScenarioTopic =>
      'Por favor, insira um tópico para o cenário.';

  @override
  String get nameTitle => 'Nome (Título)';

  @override
  String get aiCharacter => 'Personagem de IA';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Olá! Boas-vindas. Sobre o que gostaria de conversar hoje?';

  @override
  String get greetYourConversationPartner => 'Cumprimente seu interlocutor';

  @override
  String get askAQuestionInChinese => 'Faça uma pergunta em chinês';

  @override
  String get pinyinWithToneMarks => 'Pinyin com marcas de tom';

  @override
  String get goal1InEnglish => 'Objetivo 1 (em português)';

  @override
  String get goal2InEnglish => 'Objetivo 2 (em português)';

  @override
  String get goal3InEnglish => 'Objetivo 3 (em português)';

  @override
  String get beginner => 'Iniciante';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Mestre';

  @override
  String get azurePronunciationAssessment => 'AVALIAÇÃO DE PRONÚNCIA AZURE';

  @override
  String get tapToReview => 'Toque para revisar';

  @override
  String get overallScore => 'Pontuação geral';

  @override
  String get toneAccuracy => 'Precisão dos tons';

  @override
  String get fluency => 'Fluência';

  @override
  String get report => 'Relatório';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Boa pronúncia, mas ainda pode melhorar!';

  @override
  String get didYouMeanToSay => 'Você quis dizer...?';

  @override
  String get greatKeepTrying => 'Ótimo! Continue praticando!';

  @override
  String get completeness => 'Completude';

  @override
  String get targetTone => 'Tom esperado';

  @override
  String get k4toneComparisonTapToListen =>
      'Comparação dos 4 tons (Toque para ouvir):';

  @override
  String get youSpokeMatch => 'Você pronunciou (Correto!)';

  @override
  String get youSpoke => 'Você pronunciou';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Sua coleção principal de caracteres.';

  @override
  String get deckNotFound => 'Baralho não encontrado';

  @override
  String get cannotDeleteTheDefaultDeck =>
      'Não é possível excluir o baralho padrão';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Intermediário Superior';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'Os primeiros 150 caracteres para iniciar sua jornada.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Construa seu vocabulário com 300 palavras essenciais.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Domine a fluência na conversação com 600 palavras.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Leia textos e converse com fluência com 1.200 palavras.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Leia notícias e assista a filmes com 2.500 palavras.';

  @override
  String get databaseBoxNotOpen => 'Banco de dados não aberto';

  @override
  String get hsk1DataFileIsEmpty => 'O arquivo de dados do HSK 1 está vazio';

  @override
  String get gold => 'Ouro';

  @override
  String get globalDictionaryNotInitialized =>
      'Dicionário global não inicializado';

  @override
  String get reading => 'Leitura';

  @override
  String get recall => 'Recordação';

  @override
  String get speaking => 'Fala';

  @override
  String get listening1 => 'Escuta';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Pratique a ordem dos traços com guias visuais.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Veja o caractere e lembre-se do Pinyin e do significado.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Veja o significado e desenhe o caractere de memória.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Leia em voz alta para avaliar seus tons e pronúncia.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Ouça o áudio e identifique o caractere correto.';

  @override
  String get contract => 'Contrato';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Quem implementar esta interface DEVE suportar estas operações.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck ou voz local';

  @override
  String get manageDecks => 'Gerenciar baralhos';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Ocorreu um problema ao carregar a biblioteca. Tente novamente.';

  @override
  String get noCharactersInLexicon1 => 'Nenhum caractere no vocabulário';

  @override
  String get masterTheBuildingBlocks => 'Domine os blocos fundamentais';

  @override
  String get other => 'Outro';

  @override
  String get requiredLabel => 'Obrigatório';

  @override
  String get library1 => 'Biblioteca';

  @override
  String get youAreAPremiumMember => 'Você é um membro Premium';

  @override
  String get createAccountToSyncProgress =>
      'Crie uma conta para sincronizar o progresso';

  @override
  String get signOut => 'Sair da conta';

  @override
  String get account => 'Conta';

  @override
  String get guestScholar => 'Estudioso Convidado';

  @override
  String get localAccount => 'Conta local';

  @override
  String get unknownRadical => 'Radical desconhecido';

  @override
  String get followTheGuideStroke => 'Siga o traço guia';

  @override
  String get strokeAnimationSpeed => 'Velocidade da animação do traço';

  @override
  String get notifications => 'Notificações';

  @override
  String get deutsch => 'Alemão';

  @override
  String get bahasaIndonesia => 'Indonésio';

  @override
  String get italiano => 'Italiano';

  @override
  String get today1d2d3d4d5d6d => 'Hoje, 1d, 2d, 3d, 4d, 5d, 6d';

  @override
  String get targetDeck => 'Baralho de destino';

  @override
  String get mixed => 'Misto';

  @override
  String get topicForContext => 'Tópico (para contexto)';

  @override
  String get nounsOnly => 'Apenas substantivos';

  @override
  String get verbsOnly => 'Apenas verbos';

  @override
  String get idiomsChengyu => 'Expressões idiomáticas (Chengyu)';

  @override
  String get fullSentences => 'Frases completas';

  @override
  String get beginnerHsk12 => 'Iniciante (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Intermediário (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Avançado (HSK 5-6)';

  @override
  String get generatedByAi => 'Gerado por IA';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Pode me dar mais dois exemplos usando esta palavra?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Quais são algumas palavras semelhantes e como elas se diferenciam?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Esta palavra é mais usada no chinês falado ou escrito?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Existem outras formas de traduzir esta palavra?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'Quais são as combinações de palavras (colocações) mais comuns com este termo?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Quais são os erros mais comuns cometidos por estudantes com esta palavra?';

  @override
  String get emptyResponse => 'Resposta vazia';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Qual é a origem deste caractere na escrita em ossos oraculares?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Como a forma ancestral deste caractere evoluiu com o tempo?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Cite 3 palavras comuns que contêm este caractere.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'Quais outros caracteres compartilham este mesmo radical?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Existe algum provérbio ou dito popular chinês que contenha este caractere?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Explique as regras de ordem dos traços para este caractere.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Dê-me uma dica de caligrafia para escrever este caractere de forma elegante.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Há alguma particularidade ou pegadinha no uso gramatical desta palavra?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'Quais palavras são frequentemente confundidas com esta e por quê?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Este caractere possui algum simbolismo cultural especial na China?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Este caractere é comum em filmes, músicas ou textos contemporâneos em chinês?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Qual é o significado do radical deste caractere?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Decomponha cada componente do caractere e explique seus significados.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Dê-me um truque mnemônico para lembrar o tom correto deste caractere.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Existem homófonos comuns que costumam gerar confusão?';

  @override
  String get quotaExceeded => 'Limite de uso excedido';

  @override
  String get mustProvideEitherCardOrCards =>
      'É necessário fornecer um cartão ou uma lista de cartões';

  @override
  String get deckSettings => 'Configurações do baralho';

  @override
  String get saveSettings => 'Salvar configurações';

  @override
  String get sealRed => 'Selo vermelho';

  @override
  String get sealScript => 'Escrita do Selo (Zhuan)';

  @override
  String get startYourStreak => 'COMECE SUA SEQUÊNCIA';

  @override
  String get traditionalCharacter => 'Caractere tradicional';

  @override
  String get inQueue => 'Na fila';

  @override
  String get tapToListenAgain => 'Toque para ouvir novamente';

  @override
  String get contextClue => 'Pista de contexto';

  @override
  String get microphonePermissionRequired1 =>
      'Permissão de microfone necessária.';

  @override
  String get recordingFailedNoFile =>
      'Falha na gravação (nenhum arquivo gerado).';

  @override
  String get holdToSpeakOptional => 'Segure para falar (opcional)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Permissão de microfone negada. Ative-a nas Configurações para usar o Shadowing Studio.';

  @override
  String get sessionSummary => 'Resumo da sessão';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Aqui estão os caracteres com os quais você teve mais dificuldade:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Aplicar notas da sessão à Repetição Espaçada (Modo de Fala)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Aperfeiçoe sua pronúncia em mandarim\nimitando a fala nativa.';

  @override
  String get aiIsGradingYourPronunciation =>
      'A IA está avaliando sua pronúncia...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Segure o microfone para gravar. Solte para avaliar.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Toque em qualquer sílaba para ouvir todos os 4 tons:';

  @override
  String get freeFlowConversationalPractice => 'Prática de conversação livre.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Falha ao gerar frase. Tente novamente.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Gravação muito curta. Segure o botão do microfone por mais tempo.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Erro de gravação. Tente novamente.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Nenhum áudio foi capturado. Tente novamente.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'O áudio gravado está mudo. Fale com clareza e tente novamente.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'As chaves da API de Fala do Azure estão ausentes';

  @override
  String get azureError401 => 'Erro Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Falha na autenticação do Azure. Verifique sua chave da Speech API e a região no arquivo .env';

  @override
  String get azureError429 => 'Erro Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Cota do Azure excedida. Tente novamente mais tarde.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'A avaliação do Azure expirou por tempo. Verifique sua conexão com a internet.';

  @override
  String get recognitionFailedNull => 'Falha no reconhecimento: nulo';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Não foi possível ouvir você com clareza. Tente novamente.';

  @override
  String get singlePhrasePractice => 'Prática de frase única';

  @override
  String get failedToGeneratePhrase => 'Falha ao gerar frase';

  @override
  String get omitted => 'Omitido';

  @override
  String get partial => 'Parcial';

  @override
  String get mispronounced => 'Pronúncia incorreta';

  @override
  String get startSession1 => 'Iniciar sessão';

  @override
  String get chinese => 'Chinês';

  @override
  String get paused => 'Pausado';

  @override
  String get translationFailed => 'Falha na tradução';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Análises macroeconômicas e de negócios envolventes explicadas com narrativas cativantes.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Explora economias mundiais, histórias do sistema bancário e dinâmicas da indústria global.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Mandarim claro e articulado, ideal para estudantes de níveis intermediário e avançado.';

  @override
  String get chefWang => 'Chef Wang';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Domine técnicas culinárias autênticas de Sichuan ensinadas diretamente por um chef profissional.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Receitas chinesas tradicionais passo a passo com foco no controle do wok e técnicas de corte.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Vocabulário gastronômico conciso e instruções claras em mandarim natural.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Cinematografia, tecnologia de câmeras de ponta e análises profundas de mídia digital.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Estilo documentário de alto padrão explorando criação de vídeo e inovações em IA.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Vocabulário técnico refinado com pronúncia cristalina e legendas visuais.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Jornalismo investigativo aprofundado e comentários perspicazes sobre temas atuais.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Perspectivas críticas sobre fenômenos sociais, notícias internacionais e história.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Discurso investigativo formal, excelente para treino de compreensão auditiva avançada.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Minidocumentários animados de divulgação científica respondendo a dúvidas do cotidiano.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Explora física, biologia e curiosidades cotidianas com infográficos dinâmicos.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Mandarim padrão de Pequim com ritmo agradável de narração e legendas nítidas.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Emocionantes viagens gastronômicas de comida de rua e conversas autênticas por toda a China.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Explora histórias humanas regionais, tradições de família e delícias gastronômicas locais.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Mandarim falado natural com expressões do dia a dia e acolhimento cultural.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Avaliações bem-humoradas e sinceras de eletrônicos de consumo baseadas na vida real.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Testes práticos de smartphones, dispositivos de casa inteligente e acessórios de tecnologia.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Diálogos casuais e descontraídos com expressões coloquiais modernas.';

  @override
  String get seanKitchen => 'Cozinha do Sean';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Pratos caseiros chineses saborosos e recriação de petiscos de rua populares.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Dicas práticas de cozinha para preparar comida asiática autêntica e reconfortante.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Comentários calorosos e didáticos com vocabulário culinário prático.';

  @override
  String get chineseChannel => 'Canal Chinês';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Aulas estruturadas de língua chinesa e tutoriais de imersão cultural.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Pontos gramaticais, expansão de vocabulário HSK e padrões de conversação.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Ritmo pedagógico claro e adaptado sob medida para estudantes de chinês.';

  @override
  String get oneInABillion => 'Um em Um Bilhão';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Retratos intimistas e histórias de pessoas singulares na China contemporânea.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Explora escolhas de vida diversas, cultura jovem e transformações sociais modernas.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Narrativa profunda e cativante com vocabulário rico e vozes autênticas.';

  @override
  String get vickySoup => 'Sopa Vicky';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Vlogs de estilo de vida, moda e rotinas diárias com estética refinada.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Diários de viagem e momentos aconchegantes registrados com sensibilidade cinematográfica.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Mandarim casual e espontâneo falado em um ritmo confortável e expressivo.';

  @override
  String get tededMandarin => 'TED-Ed Mandarim';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Aulas animadas de alto nível sobre ciência, filosofia e história.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Enigmas estimulantes, literatura clássica e mistérios da psicologia.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Locução impecável em mandarim padrão com legendas bilíngues sincronizadas.';

  @override
  String get channel => 'Canal';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Documentários culturais selecionados e destaques do estilo de vida chinês.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Explorando artes tradicionais, patrimônio artesanal e tendências contemporâneas.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Áudio de alta fidelidade com legendas em chinês sincronizadas.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Histórias curiosas e projetos de vídeo criativos da internet chinesa.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Entrevistas envolventes, narrativas fascinantes e explorações visuais.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Excelente material de escuta com pronúncia padrão.';

  @override
  String get xVsY => 'X vs Y';

  @override
  String get untitled => 'Sem título';

  @override
  String get contemporaryStories => 'Histórias contemporâneas';

  @override
  String get history => 'História';

  @override
  String get advancedReading => 'Leitura avançada';

  @override
  String get intermediateReading => 'Leitura intermediária';

  @override
  String get beginnerReading => 'Leitura para iniciantes';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Desconhecido';

  @override
  String get localDb => 'BD Local';

  @override
  String get emperorTaizong => 'Imperador Taizong';

  @override
  String get emperorXuanzong => 'Imperador Xuanzong';

  @override
  String get liBai => 'Li Bai';

  @override
  String get gradedReader => 'Leituras graduadas';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Aprenda Mandarim com TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'Chinês do Dia a Dia';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'Ting: Vida Diária na China';

  @override
  String get xinxin => 'Xinxin';

  @override
  String get sweetFamilyDailyLife => 'Doce Vida Familiar';

  @override
  String get chinsunDailyLife => 'O Dia a Dia de Chin-Sun';

  @override
  String get tasteChina => 'Sabores da China';

  @override
  String get dawenFoodQuest => 'Aventura Gastronômica de DaWen';

  @override
  String get chinaTravelWithCangbao => 'Viagem pela China com Cangbao';

  @override
  String get alinFoodWalk => 'Passeio Gastronômico com Alin';

  @override
  String get videoOfTheDay => 'VÍDEO DO DIA';

  @override
  String get noValidVideoFound => 'Nenhum vídeo válido encontrado.';

  @override
  String get listeningPractice => 'PRÁTICA DE ESCUTA';

  @override
  String get socialSkills => 'HABILIDADES SOCIAIS';

  @override
  String get culturalContext => 'CONTEXTO CULTURAL';

  @override
  String get realLife => 'VIDA REAL';

  @override
  String get realWorld => 'MUNDO REAL';

  @override
  String get articleOfTheDay => 'ARTIGO DO DIA';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Falha ao carregar ou processar o feed RSS.';

  @override
  String get drama => 'Drama';

  @override
  String get youkugetAppNow => 'YOUKU: Baixe o app agora';

  @override
  String get romanceTrailer => 'Romance / Trailer';

  @override
  String get romance => 'Romance';

  @override
  String get action => 'Ação';

  @override
  String get mystery => 'Mistério';

  @override
  String get historical => 'Histórico / De época';

  @override
  String get historicalAction => 'Histórico / Ação';

  @override
  String get historicalRomance => 'Histórico / Romance';

  @override
  String get anYouth => 'Juventude';

  @override
  String get historicalSliceOfLife => 'Histórico / Cotidiano';

  @override
  String get historicalHighlight => 'Histórico / Destaques';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: Baixe o app agora';

  @override
  String get theDouble => 'The Double (O Duplo)';

  @override
  String get updatesByOshin => 'Atualizações por Oshin';

  @override
  String get backFromTheBrink => 'De Volta do Abismo';

  @override
  String get fallingIntoYourSmile => 'Apaixonando-me pelo Seu Sorriso';

  @override
  String get everyoneLovesMe => 'Todo Mundo Me Ama';

  @override
  String get tillTheEndOfTheMoon => 'Até o Fim da Lua';

  @override
  String get theBestDayOfMyLife => 'O Melhor Dia da Minha Vida';

  @override
  String get gikkiChineseDrama => 'Drama Chinês GIKKI';

  @override
  String get dashingYouth => 'Juventude Destemida';

  @override
  String get rebornChineseDramaEngSub => 'Drama Chinês Reborn (Legendas)';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'Quando Eu Voo em Sua Direção';

  @override
  String get mztvExclusiveChineseDrama => 'Drama Chinês Exclusivo MZTV';

  @override
  String get theStarryLove => 'Amor Estrelado';

  @override
  String get comedy => 'Comédia';

  @override
  String get backFromTheBrink1 => 'De Volta do Abismo';

  @override
  String get dashingYouth1 => 'Juventude Destemida';

  @override
  String get beReborn => 'Renascer';

  @override
  String get beautyStrategy => 'Estratégia de Beleza';

  @override
  String get myDivineEmissary => 'Meu Emissário Divino';

  @override
  String get theHope => 'A Esperança';

  @override
  String get ep16In => 'Episódio 16';

  @override
  String get everyoneLovesMe1 => 'Todo Mundo Me Ama';

  @override
  String get fallingIntoYourSmile1 => 'Apaixonando-me pelo Seu Sorriso';

  @override
  String get hiddenLove => 'Amor Oculto';

  @override
  String get loveBetweenFairyAndDevil => 'O Amor Entre a Fada e o Demônio';

  @override
  String get loveLikeTheGalaxy => 'Amor Como a Galáxia';

  @override
  String get membersPremiere => 'Estreia para Membros VIP';

  @override
  String get moonlight => 'Luar (Moonlight)';

  @override
  String get myJourneyToYou => 'Minha Jornada Até Você';

  @override
  String get mysteriousLotusCasebook => 'O Misterioso Livro de Casos de Lótus';

  @override
  String get rebornChineseDramaEngSub1 => 'Drama Chinês Reborn (Legendas)';

  @override
  String get reborn => 'Renascer';

  @override
  String get theBestDayOfMyLife1 => 'O Melhor Dia da Minha Vida';

  @override
  String get theDouble1 => 'The Double';

  @override
  String get theLongBallad => 'A Longa Balada';

  @override
  String get theStarryLove1 => 'Amor Estrelado';

  @override
  String get theUntamed => 'Os Indomáveis (The Untamed)';

  @override
  String get tillTheEndOfTheMoon1 => 'Até o Fim da Lua';

  @override
  String get whenIFlyTowardsYou1 => 'Quando Eu Voo em Sua Direção';

  @override
  String get wordOfHonor => 'Palavra de Honra (Word of Honor)';

  @override
  String get blossom => 'Florescer (Blossoms Shanghai)';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'De Geração em Geração';

  @override
  String get brocadeOdyssey => 'Odisseia de Brocado';

  @override
  String get circleOfLove => 'Círculo de Amor';

  @override
  String get dawnIsBreaking => 'O Romper da Aurora';

  @override
  String get firstRomance => 'Primeiro Romance';

  @override
  String get loveInTheClouds => 'Amor nas Nuvens';

  @override
  String get secondChanceRomance => 'Uma Segunda Chance para o Amor';

  @override
  String get mrBad => 'Mr. Bad';

  @override
  String get pursuitOfJade => 'A Busca pelo Jade';

  @override
  String get fatedHearts => 'Corações Destinados';

  @override
  String get roadHome => 'Caminho de Casa';

  @override
  String get myDearGuardian => 'Meu Querido Guardião';

  @override
  String get brightEyesInTheDark => 'Olhos Brilhantes na Escuridão';

  @override
  String get theIngeniousOne => 'A Mente Engenhosa';

  @override
  String get herPhoenixMajesty => 'Sua Majestade a Fênix';

  @override
  String get dreamsNeverEnd => 'Sonhos Nunca Morrem';

  @override
  String get theUltimateVowUnknownToYou => 'O Voto Secreto';

  @override
  String get the300LoyalGhosts => 'Os 300 Espíritos Leais';

  @override
  String get homelandGuardian => 'Guardião da Pátria';

  @override
  String get loveIsAlwaysOnline => 'O Amor Está Sempre Online';

  @override
  String get thePrincessDecree => 'O Decreto da Princesa';

  @override
  String get aVowInTheDark => 'Um Juramento nas Sombras';

  @override
  String get aGirlLikeMe => 'Uma Garota Como Eu';

  @override
  String get iAmNobody => 'Eu Não Sou Ninguém (I Am Nobody)';

  @override
  String get myMamaGo => 'Vai, Mamãe!';

  @override
  String get myWesternRegionPrincess => 'Minha Princesa das Terras Ocidentais';

  @override
  String get aFlowerOnTheContinent => 'Uma Flor no Continente';

  @override
  String get thePrincess => 'A Princesa';

  @override
  String get sweetLoveVersion => 'Versão Romance Doce';

  @override
  String get hilariousFamily2 => 'Família Hilária 2';

  @override
  String get guYuanMountainHasASchool => 'A Escola do Monte Gu Yuan';

  @override
  String get foreverYoung => 'Para Sempre Jovem';

  @override
  String get theHiddenHeirYeChen => 'Ye Chen, o Herdeiro Oculto';

  @override
  String get extraordinary => 'Extraordinário';

  @override
  String get sideStoryOfFoxVolant => 'História Paralela da Raposa Voadora';

  @override
  String get loveOfTheDivineTree => 'O Amor da Árvore Sagrada';

  @override
  String get rebirth => 'Renascimento';

  @override
  String get moonlitReunion => 'Reencontro ao Luar';

  @override
  String get videoCountsCannotBeNegative =>
      'A quantidade de vídeos não pode ser negativa.';

  @override
  String get publicDomainClassic => 'Clássico de Domínio Público';

  @override
  String get idioms => 'Expressões Idiomáticas';

  @override
  String get news => 'Notícias';

  @override
  String get fairyTales => 'Fábulas e Contos de Fadas';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Aqui está uma explicação cultural fascinante:';

  @override
  String get videoFetchTimedOut => 'Tempo esgotado ao buscar o vídeo';

  @override
  String get aboutChannel => 'SOBRE O CANAL';

  @override
  String get noVideosFound => 'Nenhum vídeo encontrado';

  @override
  String get failedToLoadVideos => 'Falha ao carregar vídeos';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Conteúdo selecionado em mandarim de alta qualidade com vocabulário natural.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Chinês falado autêntico em situações e tópicos do mundo real.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Material de vídeo envolvente com legendas interativas sincronizadas.';

  @override
  String get watchVideo => 'Assistir ao Vídeo';

  @override
  String get culturalInsight => 'Visão Cultural';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'A IA está analisando o contexto cultural...';

  @override
  String get diveIntoFullContent => 'Ver Conteúdo Completo';

  @override
  String get savedArticles => 'Artigos Salvos';

  @override
  String get liveOverlay => 'LEITURA INTERATIVA';

  @override
  String get webExplorer => 'NAVEGADOR WEB';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Navegue por qualquer site em chinês com dicionário ao toque, anotações de pinyin e tradução instantânea.';

  @override
  String get startExploring => 'INICIAR EXPLORAÇÃO';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Séries chinesas com legendas interativas';

  @override
  String get failedToLoadContent => 'Falha ao carregar conteúdo';

  @override
  String get searchingYoutube => 'Pesquisando no YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'Nenhum vídeo encontrado. Tente outros termos de busca.';

  @override
  String get searching => 'Buscando...';

  @override
  String get noShowsFound => 'Nenhuma série encontrada';

  @override
  String get bookmarked => 'Salvo nos favoritos';

  @override
  String get trailer1 => 'Trailer';

  @override
  String get highlight1 => 'Destaques';

  @override
  String get noCaptionsAvailable => 'Nenhuma legenda disponível';

  @override
  String get fetchingSubtitles => 'Buscando legendas...';

  @override
  String get generatingAiBriefing => 'Gerando resumo por IA...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Nenhuma legenda digital (CC) encontrada para este vídeo.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Vídeos com legendas gravadas diretamente na imagem não possuem faixas digitais de texto no YouTube.';

  @override
  String get translatingSubtitles => 'Traduzindo legendas...';

  @override
  String get processingYourPronunciation => 'Processando sua pronúncia...';

  @override
  String get couldntIdentifyLine => 'Não foi possível identificar a frase.';

  @override
  String get listeningSpeakNow => 'Ouvindo... pode falar agora.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Este vídeo não possui faixa de legendas digitais (CC) no YouTube.';

  @override
  String get perfect1 => 'Perfeito';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Este vídeo foi removido ou não está mais disponível.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Este vídeo não pode ser reproduzido dentro do app. Você pode assisti-lo no YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Seu dispositivo não suporta este vídeo. Tente outro.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Referência de vídeo inválida. Tente novamente.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Não foi possível carregar este vídeo. Tente outro.';

  @override
  String get startReading => 'Começar a ler';

  @override
  String get analyzingCulturalContext => 'Analisando contexto cultural...';

  @override
  String get failedToLoadCulturalInsight =>
      'Falha ao carregar a análise cultural.';

  @override
  String get historicalContext => 'Contexto Histórico';

  @override
  String get culturalSignificance => 'Significado Cultural';

  @override
  String get authorBackground => 'Biografia do Autor';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'Mais de 80 romances clássicos completos e epopeias mundiais';

  @override
  String get storyOfTheDay => 'HISTÓRIA DO DIA';

  @override
  String get tangDynasty => 'Dinastia Tang';

  @override
  String get poetryClassicalVerse => 'Poesia clássica e versos';

  @override
  String get allHsk => 'Todos os níveis HSK';

  @override
  String get allStories => 'Todas as Histórias';

  @override
  String get keyWords => 'Palavras-chave';

  @override
  String get openOriginalWebsite => 'Abrir Site Original';

  @override
  String get aiReadingTools => 'Ferramentas de Leitura com IA';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Aprimore sua leitura com ferramentas baseadas em IA';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Escolha o nível de dificuldade desejado para a simplificação';

  @override
  String get chooseDifficultyForSimplification =>
      'Escolha a dificuldade de simplificação';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Extraia todas as palavras desconhecidas para um novo baralho';

  @override
  String get length => 'Extensão';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Extração da Web';

  @override
  String get aiTools => 'Ferramentas de IA';

  @override
  String get stop => 'Parar';

  @override
  String get keepPracticing1 => 'Continue praticando';

  @override
  String get aiPrepRoom => 'Sala de Preparação com IA';

  @override
  String get lessonSummary => 'RESUMO DA LIÇÃO';

  @override
  String get unlockSinosparkPremium => 'Desbloquear SinoSpark Premium';

  @override
  String get monthYear => 'Mês / Ano';

  @override
  String get enableNotifications => 'Ativar notificações';

  @override
  String get notificationsConfigured => 'Notificações configuradas';

  @override
  String get neverMissAStroke2 => 'Não perca nenhum traço';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Seus lembretes de Dose Diária e sequência de estudo estão prontos.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Mantenha a consistência com doses diárias de aprendizado e alertas pontuais sobre o período de teste.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Uma nova palavra e história esperam pelo seu ritual diário de estudo.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Lembretes cuidadosos antes que os caracteres desapareçam da sua memória.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Receba um lembrete 2 dias antes do término do seu teste gratuito.';

  @override
  String get yourPathTonchineseFluency =>
      'Seu caminho para a\nfluência em chinês';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Responda a 3 perguntas rápidas para que nossa IA monte\num currículo sob medida para o seu dia a dia.';

  @override
  String get whatIsYourLevelnwithChinese => 'Qual é o seu nível\nde chinês?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Escolha o percurso mais adequado ao seu conhecimento atual.';

  @override
  String get whatDrivesYourStudy => 'O que motiva você a aprender chinês?';

  @override
  String get purposeFuelsTheBrush => 'O propósito guia o traço do pincel';

  @override
  String get setYourDailyRitual => 'Defina sua rotina de estudo diária.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Você pode ajustar sua rotina a qualquer momento.';

  @override
  String get letsBegin => 'Vamos começar';

  @override
  String get brandNew => 'Iniciante absoluto';

  @override
  String get iveNeverStudiedChineseBefore => 'Nunca estudei chinês antes.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Conheço caracteres e saudações básicas.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Consigo manter conversas simples e ler frases curtas.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Quero aperfeiçoar e polir minhas habilidades para falar com maestria.';

  @override
  String get confirmSelection => 'Confirmar seleção';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'A intenção clara dá vida ao movimento do pincel.';

  @override
  String get buildMyPath => 'Criar minha jornada';

  @override
  String get hskCertification => 'Certificação e exames HSK';

  @override
  String get culturalAppreciation => 'Apreço pela cultura, história e artes';

  @override
  String get yourPlanIsReady => 'Seu plano está pronto';

  @override
  String get craftingYourCurriculum => 'Criando seu currículo personalizado...';

  @override
  String get personalizedPathInitialized => 'JORNADA PERSONALIZADA INICIADA';

  @override
  String get calibratingAiNeuralMasters =>
      'CALIBRANDO TUTORES NEURAIS DE IA...';

  @override
  String get calibrationComplete => 'Calibração concluída';

  @override
  String get synthesizingModules => 'Sintetizando módulos de estudo...';

  @override
  String get oneAndWater => '«Um» e «Água»';

  @override
  String get theHorizontalStroke => 'O TRAÇO HORIZONTAL (HÉNG)';

  @override
  String get theRadical => 'O RADICAL';

  @override
  String get water => 'Água';

  @override
  String get river => 'Rio';

  @override
  String get day5Reminder => 'Lembrete do 5º dia';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Como prometido, avisamos você 2 dias antes do fim do teste gratuito para que você possa decidir com calma.';

  @override
  String get continueWithoutReminder => 'Continuar sem lembretes';

  @override
  String get masterChineseWithnsinospark => 'Domine o chinês com\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Iniciar teste gratuito de 7 dias';

  @override
  String get precisionStrokes => 'Traços com máxima precisão';

  @override
  String get aiPronunciation => 'Pronúncia guiada por IA';

  @override
  String get today => 'Hoje';

  @override
  String get fullAccess => 'Acesso completo';

  @override
  String get day5 => 'Dia 5';

  @override
  String get reminder => 'Lembrete';

  @override
  String get day7 => 'Dia 7';

  @override
  String get trialBegins => 'Início do teste';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'O RevenueCat não possui pacotes ativos no momento. Configure o seu painel.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Acesso à câmera necessário para escaneamento em tempo real.';

  @override
  String get cameraAccessRequired => 'Acesso à câmera necessário';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Por favor, ative a permissão da câmera nas configurações do seu dispositivo para usar esta função.';

  @override
  String get alignChineseTextWithinFrame =>
      'Alinhe o texto em chinês dentro da moldura';

  @override
  String get inLibrary => 'Na biblioteca';

  @override
  String get novice => 'Iniciante';

  @override
  String get apprentice => 'Aprendiz';

  @override
  String get artisan => 'Artesão';

  @override
  String get grandmaster => 'Grão-Mestre';

  @override
  String get poem => 'Poema';

  @override
  String get theNarrative => 'A narrativa';

  @override
  String get classicMasterpiece => 'Obra-prima clássica';

  @override
  String get classicAuthor => 'Autor clássico';

  @override
  String get classical => 'Clássico';

  @override
  String get classicLiterature => 'Literatura clássica';

  @override
  String inThisChapterOf(Object title) {
    return 'Neste capítulo de «$title»';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'Conforme a narrativa se desenvolve, ela revela sabedorias fundamentais da vida e inspirações duradouras.';

  @override
  String get general => 'Geral';

  @override
  String get mythology => 'Mitologia';

  @override
  String get dailyLife => 'Vida cotidiana';

  @override
  String get tangPoetry => 'Poesia Tang';

  @override
  String get classicalLiterature => 'Literatura clássica';

  @override
  String get justNow => 'Agora mesmo';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'O Exército de Terracota de Qin Shi Huang';

  @override
  String get lifeInsideTheForbiddenCity => 'A vida na Cidade Proibida';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Comprando passagem e viajando no trem de alta velocidade na China';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Indo ao hospital por causa de um resfriado e consultando um médico';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Indo a um restaurante tradicional para pedir jiaozi (pasteizinhos cozidos)';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'A tradicional cerimônia de chá Gongfu';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'A arte de escrever caracteres chineses com pincel';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'A vida e a preservação do panda-gigante';

  @override
  String get storyNotFoundInDatabase =>
      'História não encontrada no banco de dados';

  @override
  String get storyTextIsEmpty => 'O texto da história está vazio';

  @override
  String get myCustomStories => 'Minhas histórias personalizadas';

  @override
  String get userProvidedText => 'Texto inserido pelo usuário';

  @override
  String get local => 'Local';

  @override
  String get voiceEngineAllowance => 'Motor de voz e cota de uso';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Vozes Studio HD vs. Vozes Padrão Ilimitadas';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'A voz padrão é 100% gratuita e ilimitada';

  @override
  String get read => 'Ler';

  @override
  String get koreKoreFemaleWarm => 'Kore (feminino, calorosa)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (feminino, alegre)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (masculino, enérgico)';

  @override
  String get charonCharonMaleNewsstyle =>
      'Charon (masculino, estilo jornalístico)';

  @override
  String get puckPuckMaleSporty => 'Puck (masculino, esportivo)';

  @override
  String get localOndevice => 'Voz do dispositivo';

  @override
  String get localOndeviceTts => 'TTS local do dispositivo';

  @override
  String get off => 'Desativado';

  @override
  String get endOfCurrentChapter => 'Fim do capítulo';

  @override
  String get standardVoice => 'Voz padrão';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Nenhum romance encontrado com os filtros selecionados.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Nenhuma microleitura encontrada com os filtros selecionados.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Nenhum poema encontrado com os filtros selecionados.';

  @override
  String get audiobook => 'Audiolivro';

  @override
  String get audio => 'Áudio';

  @override
  String get continueReading => 'Continuar lendo';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Pesquise por 96 romances completos, autores e epopeias...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Pesquise poemas clássicos, autores e versos...';

  @override
  String get allLevelsVal => 'Todos os níveis';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Iniciante)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Elementar)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Intermediário)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Intermediário superior)';

  @override
  String get listenToAudiobook => 'Ouvir audiolivro';

  @override
  String get synopsis => 'Sinopse';

  @override
  String get peoplesArtist => 'Artista do Povo';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«Kafkaesco» para retratar o absurdo burocrático, a alienação e a angústia existencial.';

  @override
  String get bigBrotherAndNewspeak => '«Grande Irmão» e «Novilíngua».';

  @override
  String get audiobookIncluded => 'Audiolivro incluído';

  @override
  String get readPoem => 'Ler poema';

  @override
  String get studioVoiceAllowance => 'Cota de voz Studio HD';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Recitação semanal com IA em alta definição';

  @override
  String get resetsEveryMondayAt0000 => 'Renova toda segunda-feira às 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Ao esgotar suas 4 horas semanais de vozes Studio, o aplicativo alterna automaticamente para a voz do dispositivo para que você continue ouvindo gratuitamente e sem limites.';

  @override
  String get localDeviceVoice => 'Voz do dispositivo';

  @override
  String get classicalVerse => 'Versos clássicos';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Voz do dispositivo (4h semanais utilizadas)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Gere uma história personalizada por IA com base nos seus interesses';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Em vez de se limitar a um nível rígido de HSK, o motor dinâmico analisa o vocabulário contido na sua coleção de cartões.';

  @override
  String get we => 'Nós';

  @override
  String get howCanWeHelpYou => 'Como podemos ajudar você?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Tudo o que você precisa saber sobre o SinoSpark, seus recursos e sua privacidade.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Quais são as vozes que narram no aplicativo?';

  @override
  String get howDoesTheWebExplorerWork => 'Como funciona o Navegador Web?';

  @override
  String get whatIsZenMode => 'O que é o Modo Zen?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Como funciona a repetição espaçada dos flashcards?';

  @override
  String get traceComplete => 'Traçado concluído!';

  @override
  String get traceCharacter => 'Traçar caractere';

  @override
  String get analyzingWordRelationships =>
      'Analisando conexões entre palavras...';

  @override
  String get identifyingUsageContexts => 'Identificando contextos de uso...';

  @override
  String get comparingFormalityLevels => 'Comparando níveis de formalidade...';

  @override
  String get findingCommonCollocations =>
      'Localizando combinações de palavras frequentes...';

  @override
  String get generatingComparison => 'Gerando análise comparativa...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'A geração está demorando mais do que o habitual. A IA pode estar com alta demanda.';

  @override
  String get generationInterruptedShowingPartial =>
      'Processamento interrompido. Exibindo os resultados parciais disponíveis.';

  @override
  String get sorrySomethingWentWrong => 'Pedimos desculpas, algo deu errado.';

  @override
  String get usage => 'Uso:';

  @override
  String get alsoSeenIn => 'Também presente em';

  @override
  String get quickLook => 'Visualização rápida';

  @override
  String get notFound => 'Não encontrado';

  @override
  String get errorLoadingFromAi => 'Erro ao carregar dados da IA.';

  @override
  String get analyzingImage => 'Analisando imagem...';

  @override
  String get extractingChineseText => 'Extraindo texto em chinês...';

  @override
  String get lookingUpVocabulary => 'Consultando no dicionário...';

  @override
  String get dreamOfTheRedChamber =>
      'O Sonho do Pavilhão Vermelho (Hongloumeng)';

  @override
  String get journeyToTheWest => 'Jornada ao Oeste (Xiyouji)';

  @override
  String get romanceOfTheThreeKingdoms =>
      'Romance dos Três Reinos (Sanguo Yanyi)';

  @override
  String get mingDynasty => 'Dinastia Ming';

  @override
  String get wuChengEn => 'Wu Cheng\'en';

  @override
  String get hundredChapters => '100 capítulos';

  @override
  String get volume1 => 'Volume 1';

  @override
  String bookmarksCount(Object count) {
    return 'Favoritos ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Nenhum favorito salvo. Toque no ícone de marcador para salvar um trecho.';

  @override
  String get sinosparkIsNotResponding => 'O SinoSpark não está respondendo';

  @override
  String get closeApp => 'Fechar app';

  @override
  String get wait => 'Aguardar';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: ${hours}h';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Livro $percent% lido';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Cap. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count livros e audiolivros';
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
  String get allLevels => 'Todos os níveis';

  @override
  String get searchGradedMicroStories =>
      'Pesquisar microleituras e fábulas graduadas...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count histórias graduadas e microleituras diárias';
  }

  @override
  String get searchClassicalPoems =>
      'Pesquisar poemas clássicos, autores e versos...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count poemas clássicos e versos';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Navegue por qualquer site em chinês com dicionário ao toque, anotações de pinyin e tradução instantânea.';

  @override
  String get completed => 'CONCLUÍDO';

  @override
  String get aiIsReading => 'A IA está lendo...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Avançado)';

  @override
  String get hsk1Beginner => 'HSK 1 (Iniciante)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Intermediário superior)';

  @override
  String get extractAllUnknownWords =>
      'Extrair todas as palavras desconhecidas para um novo baralho';

  @override
  String get designCustomAiRoleplay =>
      'Projetar experiência de conversação e roleplay com IA';

  @override
  String get practiceFlashcardVocabulary =>
      'Praticar o vocabulário dos cartões em um diálogo ao vivo';

  @override
  String get surpriseMe => 'Surpreenda-me';

  @override
  String get rollCharacter => 'Sortear personagem';

  @override
  String get historicalCostume => 'Drama histórico / De época';

  @override
  String get modernYouth => 'Moderno e juventude';

  @override
  String get fantasyMythology => 'Fantasia e mitologia';

  @override
  String get familyDrama => 'Drama familiar';

  @override
  String get fullVersion => 'Versão completa';

  @override
  String episodesCount(Object count) {
    return '$count episódios';
  }

  @override
  String episodeLabel(Object number) {
    return 'Episódio $number';
  }

  @override
  String get translating => '[ Traduzindo... ]';

  @override
  String get engSub => '[Legendas: Português]';

  @override
  String get standardVocabulary => 'Vocabulário padrão';

  @override
  String get characters => 'caracteres';

  @override
  String get todayDashboard => 'Hoje';

  @override
  String get studyToday => 'Estudar cartões de hoje';

  @override
  String get studyAhead => 'Adiantar estudos';

  @override
  String get studyAheadDescription =>
      'Pratique as próximas revisões agendadas sem usar a cota de hoje. Nenhum cartão novo será introduzido.';

  @override
  String get studyAheadComplete => 'Prática antecipada concluída';

  @override
  String get dueNow => 'Para agora';

  @override
  String get scheduled => 'Agendados';

  @override
  String get sevenDayForecast => 'Previsão de 7 dias';

  @override
  String get reviews => 'Revisões';

  @override
  String get newCardsLabel => 'Novos cartões';

  @override
  String get attempts => 'Tentativas';

  @override
  String get duration => 'Tempo';

  @override
  String get answerBreakdown => 'Detalhamento de respostas';

  @override
  String get reviewCards => 'Revisar cartões';

  @override
  String get retries => 'Novas tentativas';

  @override
  String get needsPractice => 'Precisa praticar';

  @override
  String get uniqueCardsStudied => 'Cartões';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Desenhe na outra direção ➔';

  @override
  String get fastClean => 'Rápido e limpo!';

  @override
  String get good2 => 'Muito bem!';

  @override
  String get followTheFlow => 'Siga o fluxo.';

  @override
  String get masterful => 'Magistral!';

  @override
  String get missingTheHookEnd => 'Falta o gancho/final.';

  @override
  String get thai => 'Tailandês';

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
  String get stroke => 'traço,';

  @override
  String get breath => 'respiração.';

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
  String get theExactSentenceProvided => 'a frase exata fornecida';

  @override
  String get pinyinWithToneMarks2 => 'pinyin com marcas de tom';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Extraia todos os caracteres chineses desta imagem. Retorne APENAS o texto extraído — sem comentários, sem formatação, sem traduções. Preserve as quebras de linha. Se não houver caracteres chineses, retorne uma string vazia.';

  @override
  String get householdObject => 'objeto doméstico';

  @override
  String get genericLabelFromTheList => 'rótulo genérico da lista';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'classificador';

  @override
  String get zenInk => 'Zen & Nanquim';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'CRÍTICO: Coloque a tradução em inglês na chave JSON \"english\"!';

  @override
  String get definitionInEnglish => 'definição em inglês';

  @override
  String get simplifiedLine0 => 'linha simplificada 0';

  @override
  String get simplifiedLine1 => 'linha simplificada 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'REGRA IMPORTANTE: Não se dirija ao usuário por nenhum nome. Nunca use nomes fictícios como \"João\". Fale diretamente com ele sem usar nomes.';

  @override
  String get rULESAnswerIn23 =>
      'REGRAS: Responda em no máximo 2–3 frases. Prefira listas com marcadores.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Nunca escreva introduções, despedidas ou frases de preenchimento como \"Ótima pergunta!\" ou \"Com certeza!\".';

  @override
  String get useBoldForChineseCharacters =>
      'Use **negrito** para caracteres chineses e termos-chave.';

  @override
  String get rULESAnswerIn232 => 'REGRAS: Responda em no máximo 2–3 frases.';

  @override
  String get accept => 'Aceitar';

  @override
  String get pronunciationAssessment => 'Avaliação de pronúncia';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'Nenhum';

  @override
  String get theCorrectedChineseText => 'o texto em chinês corrigido';

  @override
  String get thePinyinForTheCorrected => 'o pinyin do texto corrigido';

  @override
  String get theEnglishMeaningOfThe =>
      'o significado em inglês do texto corrigido';

  @override
  String get pNyNWithTone => 'pīnyīn com marcas de tom';

  @override
  String get englishTranslation2 => 'tradução em inglês';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Você é um especialista em literatura clássica chinesa que fornece resumos detalhados e acessíveis da poesia clássica chinesa.';

  @override
  String get youAreAChineseCulture =>
      'Você é um especialista em cultura e literatura chinesa. Forneça análises culturais envolventes e bem escritas.';

  @override
  String get english2 => 'Inglês:';

  @override
  String get remindersWhenYouHavenT =>
      'Lembretes para quando você não usar o app por alguns dias';

  @override
  String get itSBeenAFew =>
      'Já faz alguns dias! Reserve 5 minutos para aprender um novo Hanzi hoje.';

  @override
  String get abbreviationFor => 'abreviação de';

  @override
  String get cL => 'CL:';

  @override
  String get measureWord2 => 'Classificador:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'sem-usuario';

  @override
  String get passwordRequired => 'senha-obrigatoria';

  @override
  String get unsupportedProvider => 'provedor-nao-suportado';

  @override
  String get appleRevocationUnavailable => 'revogacao-apple-indisponivel';

  @override
  String get appleCredentialMissing => 'credencial-apple-ausente';

  @override
  String get authenticationDidNotReturnA =>
      'A autenticação não retornou um usuário.';

  @override
  String get viewSubscriptionPlans => 'Ver planos de assinatura';

  @override
  String get wrongPassword => 'senha-incorreta';

  @override
  String get invalidCredential => 'credencial-invalida';

  @override
  String get networkRequestFailed => 'falha-na-requisicao-de-rede';

  @override
  String get requiresRecentLogin => 'requer-login-recente';

  @override
  String get userMismatch => 'usuario-incompativel';

  @override
  String get deleteAccountPassword => 'senha-para-excluir-conta';

  @override
  String get deleteAccountError => 'erro-ao-excluir-conta';

  @override
  String get deleteAccountSubmit => 'enviar-exclusao-de-conta';

  @override
  String get theSimplestShapesTheBeginning =>
      'As formas mais simples. O início de todas as coisas.';

  @override
  String get sunMoonWaterAndFire => 'Sol, Lua, Água e Fogo. O mundo natural.';

  @override
  String get theBodyTheHeartAnd => 'O corpo, o coração e a família.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Campos, telhados e ferramentas. Os fundamentos da sociedade.';

  @override
  String get movementSpeechAndSustenance => 'Movimento, fala e sustentação.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Comércio, vestuário e artefatos complexos.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Atalho! Caractere simples dominado.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Excelente precisão! Rastro fantasma pulado.';

  @override
  String get sample => 'Amostra:';

  @override
  String get itsThat => 'Dele/Aquele';

  @override
  String get iMe => 'Eu/Mim';

  @override
  String get stillTough => 'Ainda/Difícil';

  @override
  String get partDecide => 'Parte/Decidir';

  @override
  String get selectTheCharacterFor => 'Selecione o caractere para:';

  @override
  String get selectThePinyinFor => 'Selecione o Pinyin para:';

  @override
  String get whereAreYouGoingThe =>
      'Para onde você vai? Para o aeroporto? É uma longa viagem!';

  @override
  String get youAreAuntieChenA =>
      'Você é a Tia Chen, uma vendedora astuta de mercado que vende seda e tecidos. Seu ÚNICO papel é o de vendedora de mercado. Negocie os preços de forma firme, mas justa, em mandarim. NUNCA saia do personagem nem se apresente como outra coisa além de uma vendedora. Comece com preços altos e esteja disposta a pechinchar.';

  @override
  String get youAreDrZhangA =>
      'Você é o Dr. Zhang, um médico calmo e profissional em uma clínica médica. Seu ÚNICO papel é o de médico. Pergunte sobre os sintomas de saúde e dê conselhos médicos em mandarim. NUNCA saia do personagem nem se apresente como outra coisa além de um médico. Seja tranquilizador, mas minucioso.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Onde você está sentindo desconforto? Está com febre?';

  @override
  String get youAreACloseFriend =>
      'Você é um amigo próximo se reencontrando após muito tempo. Seu ÚNICO papel é o de amigo. Mantenha as respostas informais, calorosas e curtas em mandarim. NUNCA saia do personagem nem se apresente como outra coisa além de um amigo. Use linguagem informal apropriada para amigos próximos.';

  @override
  String get noNbest => 'sem n-best';

  @override
  String get timedOut => 'tempo esgotado';

  @override
  String get grading => 'Avaliando...';

  @override
  String get label1st => '1º ˉ';

  @override
  String get label2nd => '2º ˊ';

  @override
  String get label3rd => '3º ˇ';

  @override
  String get label4th => '4º ˋ';

  @override
  String get speaking2 => 'Falando...';

  @override
  String get sessionCompletedInYourNext =>
      'Sessão concluída. Em sua próxima prática, fale frases completas para receber diagnósticos detalhados de pronúncia e tom.';

  @override
  String get craneSoaring => 'garça em voo';

  @override
  String get gentleStream => 'riacho suave';

  @override
  String get brushAndInk => 'pincel e tinta';

  @override
  String get myStudent => 'meu aluno';

  @override
  String get honoredDisciple => 'discípulo honrado';

  @override
  String get notEnoughInformation => 'informações insuficientes';

  @override
  String get asAnAi => 'como uma IA';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Boa sessão de prática. Continue focando no contraste claro dos tons e no ritmo natural de conversação.';

  @override
  String get insideASleekFuxingBullet =>
      'Dentro de um moderno trem-bala Fuxing a 350 km/h de Pequim a Xangai.';

  @override
  String get harbinIceSnowWorldWonder =>
      'Maravilha do Mundo de Gelo e Neve de Harbin';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'O famoso mercado de pulgas de fim de semana de Panjiayuan, repleto de pergaminhos de caligrafia, jade e quinquilharias vintage.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Estúdio de Porcelana Azul e Branca de Jingdezhen';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Camarim e Maquiagem da Ópera de Pequim';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Uma farmácia histórica da Tongrentang com aroma de ginseng, goji berry e centenas de gavetas de madeira para ervas.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Uma vibrante sala privativa de karaokê iluminada por neon em Shenzhen, com microfones, pratos de frutas e controles de tela.';

  @override
  String get animeCosplayExpoInGuangzhou =>
      'Expo de Anime e Cosplay em Guangzhou';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Surpreenda-me';

  @override
  String get eGALivelyBanquet =>
      'ex.: Um banquete animado celebrando em Xangai...';

  @override
  String get rollCharacter2 => '🎲 Sortear Personagem';

  @override
  String get eGACuriousCousin =>
      'ex.: Um primo curioso perguntando sobre sua carreira...';

  @override
  String get keepTrying => 'Continue tentando!';

  @override
  String get pending => 'Pendente...';

  @override
  String get expected => '🎯 Esperado';

  @override
  String get hSK2Elementary => 'HSK 2: Básico';

  @override
  String get hSK3Intermediate => 'HSK 3: Intermediário';

  @override
  String get hSK5Advanced => 'HSK 5: Avançado';

  @override
  String get expressYourselfFullyWith5000 =>
      'Expresse-se totalmente com mais de 5.000 palavras.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Ilimitado';

  @override
  String get dueToday => 'Para hoje';

  @override
  String get newAvailable => 'Novos disponíveis';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Dê uma dica única, curta e prática sobre como melhorar a forma, a posição ou o comprimento dos traços mal desenhados. Seja direto e útil, sem ser excessivamente poético ou metafórico. Não use markdown.';

  @override
  String get localOnDeviceTTS => 'Local — TTS no dispositivo';

  @override
  String get espaOl => 'Espanhol';

  @override
  String get franAis => 'Francês';

  @override
  String get portuguS => 'Português';

  @override
  String get tiNgViT => 'Vietnamita';

  @override
  String get koreFemaleWarm => 'Kore — Feminina, acolhedora';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Feminina, alegre';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Masculino, animado';

  @override
  String get charonMaleNewsStyle => 'Charon — Masculino, estilo jornalístico';

  @override
  String get puckMaleSporty => 'Puck — Masculino, esportivo';

  @override
  String get systemVoice => 'Voz do sistema';

  @override
  String get generateAdd => 'Gerar e adicionar';

  @override
  String get moreExamples => '📝 Mais exemplos';

  @override
  String get usage2 => '❓ Uso';

  @override
  String get translation => '💬 Tradução';

  @override
  String get collocations => '📚 Colocações';

  @override
  String get mistakes => '❌ Erros';

  @override
  String get decrease => 'Diminuir';

  @override
  String get increase => 'Aumentar';

  @override
  String get label0MeansThisCardType =>
      '0 significa que este tipo de cartão está desativado.';

  @override
  String get tapTheValueToEnter =>
      'Toque no valor para inserir um limite exato.';

  @override
  String get exactDailyLimit => 'Limite diário exato';

  @override
  String get enter0ToDisable => 'Digite 0 para desativar.';

  @override
  String get apply => 'Aplicar';

  @override
  String get selectDeck => 'Selecionar baralho';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Chaves do Azure Speech não configuradas. Adicione AZURE_SPEECH_KEY e AZURE_SPEECH_REGION ao .env';

  @override
  String get sTARTING => 'INICIANDO…';

  @override
  String get sTARTSESSION => 'INICIAR SESSÃO';

  @override
  String get translating2 => 'Traduzindo...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'negócios e economia';

  @override
  String get hskPreparation => 'preparação para o HSK';

  @override
  String get liveInChina => 'morar na China';

  @override
  String get comprehensiveExercise => 'exercício completo';

  @override
  String get howToUse => 'como usar';

  @override
  String get usesOf => 'usos de';

  @override
  String get appearedFirstOnMandarinBean =>
      'apareceu primeiro no Mandarin Bean';

  @override
  String get news2 => 'notícias:';

  @override
  String get joke => 'piada:';

  @override
  String get jokes => 'piadas:';

  @override
  String get academicScience => 'acadêmico / ciência';

  @override
  String get politicsCommunism => 'política e comunismo';

  @override
  String get foodDining => 'Comida e Gastronomia';

  @override
  String get sciFi => 'ficção científica';

  @override
  String get scienceFictionTech => 'Ficção Científica e Tecnologia';

  @override
  String get travelPlaces => 'Viagens e Lugares';

  @override
  String get mythologyFantasy => 'Mitologia e Fantasia';

  @override
  String get cultureTraditions => 'Cultura e Tradições';

  @override
  String get businessEconomy => 'Negócios e Economia';

  @override
  String get natureAnimals => 'Natureza e Animais';

  @override
  String get articleImg => 'imagem do artigo';

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
  String get xiXiPicturesOfficialChannel => 'Canal Oficial da XiXi Pictures';

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
  String get getTheWeTVAPP => '腾讯视频 - Baixe o app WeTV';

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
  String get learnMandarinWithTaiwanPlus => 'Aprenda mandarim com o TaiwanPlus';

  @override
  String get everydayChinese => 'Chinês do dia a dia';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting - Vida cotidiana na China';

  @override
  String get tFTFOODTRAVEL => 'TFT - COMIDA E VIAGEM';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: A vida do alho';

  @override
  String get label2MINCULTURALCONTEXT => 'CONTEXTO CULTURAL DE 2 MIN';

  @override
  String get liziqi4 => '李子柒 Liziqi: Móveis de bambu';

  @override
  String get peppaPigChinese2 => 'Peppa Pig em Chinês: Poça de Lama';

  @override
  String get noBBCLeadArticleIs =>
      'Nenhum artigo principal da BBC está disponível no momento.';

  @override
  String get mediaThumbnail => 'media:thumbnail';

  @override
  String get bBC => 'BBC Chinês';

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
  String get sIXSISTERS2 => '六姊妹 SEIS IRMÃS';

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
  String get shineOnMe => '骄阳似我 Brilhe em Mim';

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
  String get thoseDays => '四喜 Aqueles Dias';

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
  String get noFunnyNoMoney => 'Sem Graça, Sem Dinheiro';

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
  String get getTheWeTVAPP2 => 'Tencent Video - Animes - Baixe o app WeTV';

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
      '《诡秘之主》Lord of Mysteries - Vlog de Dublagem do Cuttlefish (Versão Final) - Tencent Video - Anime';

  @override
  String get lordOfMysteries =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 8 - Tencent Video - Anime';

  @override
  String get lordOfMysteries2 =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 7 - Tencent Video - Anime';

  @override
  String get lordOfMysteries3 =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 6 - Tencent Video - Anime';

  @override
  String get lordOfMysteries4 =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 5 - Tencent Video - Anime';

  @override
  String get lordOfMysteries5 =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 4 - Tencent Video - Anime';

  @override
  String get lordOfMysteries6 =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 3 - Tencent Video - Anime';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 2 - Tencent Video - Anime';

  @override
  String get lordOfMysteries8 =>
      '《诡秘之主》Lord of Mysteries - Aula de Ocultismo Ep. 1 - Tencent Video - Anime';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】《诡秘之主》Lord of Mysteries - Tema de Encerramento \'Não Me Esqueça\' - Tencent Video - Anime';

  @override
  String get membersPremiere2 => 'Estreia para Membros';

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
  String get eightHundred => 'Num Raio de Oitocentos Metros';

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
  String get aboutLove => '玫瑰丛生 Sobre o Amor';

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
      'Em «Sobre o Amor», todos estão perdidos na névoa do amor. Como virar o jogo? | Estrelando: Wang Ziwen, Liu Yuning';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 De Geração em Geração';

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
  String get loveStoryInThe1970s => 'Amor nos Anos 70';

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
  String get whyIsHeStillSingle => 'Por Que Ele Ainda Está Solteiro?';

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
  String get theGlamorousNight => 'A Noite Glamourosa';

  @override
  String get theGlamorousNightE03 =>
      '【A Noite Glamourosa】E03 Jogada de mestre! O contra-ataque de Zhao Mei (Jiang Shuying, Tong Dawei)';

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
  String get myPageInThe90s => 'My Page in the 90s (突然的喜欢)';

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
      'Destaque 04: Sistema absurdo força a barra! Lenço vira absorvente? Que mico! 【My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Destaque 03: Foi num encontro às cegas no lugar da amiga e encontrou o próprio protagonista? 【My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'BTS | Chen Xingxu e Wang Yuwen: Quem é mais caótico, o Sr. Gao ou Huan\'er? 【My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Destaque 02: Tentou conquistar o protagonista, mas errou de pessoa? 【My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Destaque 01: Absurdo! Transmigrou para um livro de repente? Como vou atuar nisso? 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'BTS | Chen Xingxu e Wang Yuwen se trombam na pista de patinação 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'BTS | Chen Xingxu e Wang Yuwen passam o Ano-Novo juntos em clima de romance 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'BTS | Chen Xingxu e Wang Yuwen eternizam momento romântico no Qixi 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'BTS | Chen Xingxu e Wang Yuwen se divertem no parque de diversões 【My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '《My Page in the 90s》 estreia hoje! Chen Xingxu e Wang Yuwen vivem romance apaixonante no sistema';

  @override
  String get myPageInThe90s3 =>
      '《My Page in the 90s》 estreia em 22 de janeiro com o romance nada clichê de Chen Xingxu e Wang Yuwen';

  @override
  String get myPageInThe90s4 =>
      '《My Page in the 90s》 confirmado para 22/01! O romance atemporal de Chen Xingxu e Wang Yuwen';

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
  String get label2TheImperialCoronerS2 => 'The Imperial Coroner T2 (御赐小仵作2)';

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
  String get theDreamMaker => 'O Criador de Sonhos The Dream Maker';

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
      '【轻年 Forever Young】E23 Martin volta ao hutong e é pego de surpresa pelos irmãos (霍建华, 田雨, 张雪迎, 乔振宇)';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 Firme e certeiro! Martin ensina a cunhada a dominar o marido (霍建华, 田雨, 张雪迎, 乔振宇)';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 Um rival no amor? Martin é chamado de tio por um jovem (霍建华, 田雨, 张雪迎, 乔振宇)';

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
  String get hOMELANDGUARDIAN => '守诚者|GUARDIÃO DA PÁTRIA🚔';

  @override
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - Baixe o app iQIYI';

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
  String get loveHasFireworks => '爱情有烟火 O Amor Tem Fogos de Artifício';

  @override
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - Baixe o app WeTV';

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
  String get theHiddenHeirYeChen2 => 'O Herdeiro Oculto Ye Chen 2';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => '去听旷野的风 Dresms Never End';

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
      'Chegou o emocionante curta-metragem de cronologia dupla de 《纯真年代的爱情 Love Story in the 1970s》~';

  @override
  String get loveStoryInThe1970s3 =>
      'O curta-metragem em dupla de 《纯真年代的爱情 Love Story in the 1970s》 foi oficialmente lançado~ Vamos escrever uma carta de amor com nossos sentidos';

  @override
  String get bTSLoveStoryInThe =>
      'Bastidores | Gravações encerradas para todo o elenco, ansiosos pelo próximo reencontro 【Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《Love Story in the 1970s》O amor é uma poesia escondida na rotina diária~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《Love Story in the 1970s》Estreia oficial confirmada para 21 de fevereiro~';

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
  String get theTruth => 'Rastros do Vento: The Truth';

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
      'BTS｜Entrevista em Dupla \"Fora do Personagem\" — Quem é mais excêntrico, o Sr. Gao ou Huan\'er? 《My Page in the 90s》 Tencent Video - Drama Jovem';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Melhores Momentos 04: O sistema absurdo força o drama! Lenço vira absorvente? Que mico! 《My Page in the 90s》 Tencent Video - Drama Jovem';

  @override
  String get label03MyPageInThe2 =>
      'Melhores Momentos 03: Foi ao encontro às cegas pela amiga e achou o próprio protagonista? 《My Page in the 90s》 Tencent Video - Drama Jovem';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Melhores Momentos 02: Queria conquistar o protagonista, mas confundiu a pessoa? 《My Page in the 90s》 Tencent Video - Drama Jovem';

  @override
  String get label01MyPageInThe2 =>
      'Melhores Momentos 01: Bizarro! Transmigrou para um livro do nada? Como atuar nesse enredo? 《My Page in the 90s》 Tencent Video - Drama Jovem';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《My Page in the 90s》Bastidores｜Chen Xingxu e Wang Yuwen se trombando na pista de patinação';

  @override
  String get myPageInThe90s6 =>
      '《My Page in the 90s》Estreia Hoje! Chen Xingxu e Wang Yuwen dominam o sistema num romance doce';

  @override
  String get bTSMyPageInThe5 =>
      'Bastidores｜Interações divertidas e muita química entre Chen Xingxu e Wang Yuwen 【My Page in the 90s】';

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
  String get dearSecretary => 'Minha Querida Secretária Dear Secretary';

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
  String get foreverYoung2 => '轻年 Eternamente Jovem';

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
  String get lightOfDawn => '人之初 Luz do Alvorecer';

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
  String get sniperButterfly => 'Borboleta Atiradora Sniper Butterfly';

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
      '《狙击蝴蝶 Sniper Butterfly》 Estreia em 04/12! Ultrapassando limites por amor';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versão Completa 1-15｜Elenco: Chen Yanxi, Zhou Keyu | Tencent Video - Teatro da Juventude';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versão Completa 16-30｜Elenco: Chen Yanxi, Zhou Keyu | Tencent Video - Teatro da Juventude';

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
  String get allRise => 'Entrando em Cena - All Rise';

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
      'A Pessoa Certa no Tempo Certo - Love is Always Online';

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
  String get loveOnTheTurquoiseLand => '枭起青壤 Amor na Terra Turquesa';

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
      '《Por Que Ele Continua Solteiro (Why Is He Still Single)》 Estreia em 16/11! O conto de fadas do amor maduro com Wallace Huo e Zhu Zhu!';

  @override
  String get whyIsHeStillSingle3 =>
      '《Por Que Ele Continua Solteiro (Why Is He Still Single)》 Versão Completa｜Estrelando: Wallace Huo, Zhu Zhu | Tencent Video - Teatro Jovem';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《Por Que Ele Continua Solteiro (Why Is He Still Single)》 Versão Completa 1｜Estrelando: Wallace Huo, Zhu Zhu | Tencent Video - Teatro Jovem';

  @override
  String get whyIsHeStillSingle5 =>
      '《Por Que Ele Continua Solteiro (Why Is He Still Single)》 Versão Completa 2｜Estrelando: Wallace Huo, Zhu Zhu | Tencent Video - Teatro Jovem';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => '山河枕 Lute pelo Amor (Fight for Love)';

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
  String get iMNobody => '我本无名  Não Sou Ninguém';

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
      '折腰 (Versão Compacta) The Prisoner of Beauty';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Xiao Qiao se casa com o inimigo no lugar da irmã e entra em conflito com o marido logo no primeiro dia | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty3 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Xiao Qiao frustra a conspiração de Liu Yan de explodir o canal, e ela e Wei Shao passam de inimigos a protetores mútuos | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty4 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Xiao Qiao finge doença para disputar o pátio principal, e Wei Shao defende a esposa em público recusando concubinas | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty5 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Xiao Qiao desmascara a armadilha da caixa de madeira, e Wei Shao a reconhece como a senhora da casa | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty6 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Xiao Qiao desvenda a falsa acusação com sabedoria, Wei Shao protege a esposa e o clima esquenta com a sogra | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty7 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Wei Yan provoca intriga com cartas falsas, criando uma crise de confiança entre Xiao Qiao e Wei Shao por causa de um pingente de jade | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty8 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Su Ehuang tenta prejudicar Xiao Qiao com trigo cozido, mas Wei Shao defende a esposa e desvenda o caso, aproximando o casal | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty9 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Xiao Qiao e Wei Shao sofrem uma emboscada e são envenenados; Xiao Qiao desfaz o plano com astúcia para salvar o marido | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Wei Shao presenteia um cavalo de guerra e um grampo de cabelo; ao proteger a esposa, ele desaparece e fica ansioso | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty11 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Wei Shao sente ciúmes e protege Xiao Qiao com medo de que ela fuja; ele se muda de casa, mas logo se arrepende | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty12 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Wei Shao sente ciúmes e carrega Xiao Qiao nas costas; resolver o mistério da caixa de madeira aproxima ainda mais o casal | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty13 =>
      '《The Prisoner of Beauty (Versão Compacta)》 Qiao Ci visita a irmã e desperta o ciúme de Wei Shao; Xiao Qiao e o marido abrem o coração e firmam um compromisso para a vida toda | Estrelando: Song Zuer, Liu Yuning | Tencent Video-Youth Theater';

  @override
  String get thePrisonerOfBeauty14 =>
      'The Prisoner of Beauty (Versão Resumida) Wei Yan deixa sua terra natal por Xiao Qiao; Shao e Qiao fazem as pazes após discutir | Estrelando: Song Zuer, Liu Yuning Tencent Video - Drama Jovem';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      'The Prisoner of Beauty (Versão Resumida) Motim na noite de núpcias afasta irmãs; Xiao Qiao repele o inimigo com sabedoria e Wei Shao admite o erro | Estrelando: Song Zuer, Liu Yuning Tencent Video - Drama Jovem';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      'The Prisoner of Beauty (Versão Resumida) Wei Shao acompanha Xiao Qiao a Kangjun para resolver ressentimentos; o pai de Qiao aceita o genro e o casal consuma a união | Estrelando: Song Zuer, Liu Yuning Tencent Video - Drama Jovem';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      'The Prisoner of Beauty (Versão Resumida) Qiao Yue trai e Wei Liang morre; Da Qiao é sequestrada e Bi Zhi luta bravamente contra os inimigos | Estrelando: Song Zuer, Liu Yuning Tencent Video - Drama Jovem';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      'The Prisoner of Beauty (Versão Resumida) Wei Liang morre na batalha e Wei Qu perde um braço; Da Qiao cai do prédio e Liu Yan é derrotado | Estrelando: Song Zuer, Liu Yuning Tencent Video - Drama Jovem';

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
      'Achou o meu trabalho em grupo lento? O CEO dominador escala a janela à meia-noite para me entregar o PPT e os seguranças correm atrás dele | Tencent Video - Drama Jovem';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      'Percorrendo Mil Cidades Para Te Encontrar - A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video - Drama de Época - Baixe o App WeTV';

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
  String get theInescapable => 'Suozan - The Inescapable';

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
  String get pursuitOfJade2 => '逐玉 Em Busca do Jade';

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
      '《江湖夜雨十年灯 De Geração em Geração》 estreia em 22 de fevereiro! Venha ver Mumu e Zhaozhao, a nova geração mais forte do Jianghu, desbravando o Jianghu juntos!';

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
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 Os 300 Fantasmas Leais';

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
  String get danceOfThePhoenix => '且听凤鸣 A Dança da Fênix';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Extraordinário';

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
      '《御赐小仵作2 O Legista Imperial T2》定档0115，楚瑜夫妇暖心回归！';

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
  String get theChangAnYouth => 'A Juventude de Chang\'An The Chang\'An Youth';

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
  String get herPhoenixMajesty2 => '凤皇传 Sua Majestade a Fênix';

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
  String get aGirlLikeMe2 => '我就是这般女子 Uma Garota Como Eu';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 => '飞狐外传 História da Raposa Volante';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 => '有花在洲 Uma Flor no Continente';

  @override
  String get aFlowerOnTheContinent3 =>
      '【有花在洲 Uma Flor no Continente】 O jovem príncipe vira refém, é confundido com uma princesa por uma garota e moram juntos';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 Uma Flor no Continente】 O disfarce da garota é descoberto; o jovem príncipe arrisca a vida para salvá-la e ainda é acusado';

  @override
  String get aFlowerOnTheContinent5 =>
      '【A Flower On The Continent】 Hua Xiyu descobre que o assassino do seu pai é o pai de Ning Xuanzhou e rompe na hora';

  @override
  String get aFlowerOnTheContinent6 =>
      '【A Flower On The Continent】 Hua Xiyu veste traje de noiva, invade o acampamento inimigo e quase morre ao salvar Ning Xuanzhou';

  @override
  String get aFlowerOnTheContinent7 =>
      '【A Flower On The Continent】 Os dois países assinam um tratado de paz, mas Ning Xuanzhou rasga o decreto para se casar com Hua Xiyu';

  @override
  String get aFlowerOnTheContinent8 =>
      '【A Flower On The Continent】 Hua Xiyu tira sangue do pulso para fazer remédio; Ning Xuanzhou denuncia o próprio pai por matar o pai dela';

  @override
  String get aFlowerOnTheContinent9 =>
      '【A Flower On The Continent】 Hua Xiyu descobre que o pai de Ning Xuanzhou matou seu pai e corta o ramo do noivado no mar de flores';

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
  String get sliceOfLife => 'Cotidiano';

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
      'Coleção de Destaques 【锦月如歌 Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'BTS: Especial de Aniversário da Zhou Ye 🎂! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'BTS: Especial de Aniversário do Governador Xiao (Cheng Lei) 🎂! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'BTS: Luta incrível juntos no campo de batalha! 【锦月如歌 Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'BTS: Plano de encontro romântico do Dia dos Namorados (520) 【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'BTS: Zhou Ye bêbada é super fofa dançando com a espada, e Cheng Lei não consegue esconder o sorriso! 【锦月如歌 Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'Coleção de Destaques 【桃花映江山 The Princess\'s Gambit】';

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
      'Cena: Vestida de vermelho na neve! Jiang Taohua se despede de sua terra natal para proteger seu irmão mais novo 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'Cena: Confusão com as concubinas no dia do casamento? Taohua lida com a situação com calma 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'Cena: Taohua finge desmaio, mas Shen Zaiye a acorda com uma agulha: \'Continue atuando!\' 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'Cena: O Primeiro-Ministro Shen é implacável! Investigando o caso de moeda falsa, os oficiais corruptos tremem 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Cena: O assassino mascarado não escapa! A detetive Taohua diz: \'Seus pés entregaram você!\' 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'Cena: Interrogatório com grampo de cabelo! Shen Zaiye ergue o queixo de Taohua e a questiona friamente 【桃花映江山 The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Clipe: Indo tão longe logo no primeiro encontro! Shen Zaiye e Taohua se encaram sob o efeito do afrodisíaco 【The Princess\'s Gambit】';

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
      '【Completo por Tempo Limitado】云襄传 | The Ingenious One | iQIYI 👑Seja membro e assista aos episódios completos agora!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - Baixe o App do iQIYI';

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
      '【COMPLETO】👮ROAD HOME💕 | BoranJing, Seven Tan | iQIYI Filipinas';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI Filipinas - Baixe o app iQIYI';

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
      '【Dublagem em Inglês por IA】Mr. BAD | Chen Zheyuan, Yue Shen | iQIYI Filipinas';

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
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | FULL正片 | iQIYI 👑Seja membro e assista aos episódios completos agora!';

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
      '【COMPLETO】🕊️My Dear Guardian | Johnny Huang, Li Qin | iQIYI Philippines';

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
      '🌸【Romance Curativo】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | COMPLETO正片 | iQIYI 👑Seja membro e aproveite os episódios completos agora!';

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
      '📽️【EP01 2026】Rebirth Drama Chinês ENGSUB | Li Yunrui / Huangyang Tiantian / Zhang Kangle ⛵😍 Drama Histórico 2026 #冰湖重生';

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
      '🎥✨【LEG PT】Filme Chinês de Fantasia | Fantasia, Aventura【 CINEMA iQIYI - Inscreva-se】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 CINEMA iQIYI - Baixe o app iQIYI';

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
      '🎀【微短剧 Mini Drama】Legendas em ENG | Coleção da Versão Completa | Baixe o app WeTV / Tencent Video para assistir mais';

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
      '【Completo】Beauty of Resilience | Ju Jing Yi, Fiction | iQIYI Philippines';

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
      '🔥Em Alta【子夜归 Moonlit Reunion】EPs Completos | Humano e Demônio se apaixonam enquanto desvendam mistérios | Xu Kai, Tian Xiwei | LEG PT';

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
  String get fallInLove => 'apaixonar-se';

  @override
  String get myGirl => 'minha garota';

  @override
  String get firstRomance2 => 'primeiro romance';

  @override
  String get fallFor => 'apaixonar-se por';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Amor Oculto';

  @override
  String get loveBetweenFairyAndDevil2 => 'Amor Entre Fada e Demônio';

  @override
  String get loveLikeTheGalaxy2 => 'Amor Como a Galáxia';

  @override
  String get myJourneyToYou2 => 'Minha Jornada Até Você';

  @override
  String get mysteriousLotusCasebook2 => 'O Mistério do Lótus';

  @override
  String get reset => 'Redefinir';

  @override
  String get theLongBallad2 => 'A Longa Balada';

  @override
  String get theUntamed2 => 'Os Indomáveis';

  @override
  String get wordOfHonor2 => 'Palavra de Honra';

  @override
  String get lightOfDawn2 => '人之初 Luz da Alvorada';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|GUARDIÃO DA PÁTRIA';

  @override
  String get searching2 => 'Pesquisando...';

  @override
  String get verse => 'Verso';

  @override
  String get allStories2 => 'Todas as Histórias';

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
      'artigo, .artigo, .post, .content, principal';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'Intermediário Avançado';

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
  String get processing => 'Processando…';

  @override
  String get keepItUp => '好！Continue assim';

  @override
  String get minutesDay => 'Minutos / Dia';

  @override
  String get consistencyIsTheInkThat =>
      '\"A constância é a tinta que constrói o caractere.\"';

  @override
  String get businessCareer => 'Negócios e Carreira';

  @override
  String get travelSurvival => 'Viagens e Sobrevivência';

  @override
  String get label05MinDay => '05 Min / Dia';

  @override
  String get label10MinDay => '10 Min / Dia';

  @override
  String get label20MinDay => '20 Min / Dia';

  @override
  String get label30MinDay => '30 Min / Dia';

  @override
  String get dynamicDecksStrokeAnalysis =>
      'Baralhos Dinâmicos e Análise de Traços';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'As assinaturas estão temporariamente indisponíveis. Tente novamente.';

  @override
  String get trialReminder => 'Lembrete do Período de Teste';

  @override
  String get turnOnNotificationsIfYou =>
      'Ative as notificações se desejar um lembrete antes que seu período de teste expire. As configurações de assinatura da App Store permanecem como a fonte oficial.';

  @override
  String get label2Months => '2 meses';

  @override
  String get label3Months => '3 meses';

  @override
  String get label6Months => '6 meses';

  @override
  String get billingPeriod => 'período de cobrança';

  @override
  String get chooseASubscription => 'Escolha uma assinatura';

  @override
  String get startFreeTrial => 'Iniciar teste grátis';

  @override
  String get smartNewsDict => 'Notícias Inteligentes e Dicionário';

  @override
  String get hSK16AIDecks => 'HSK 1-6 e Baralhos de IA';

  @override
  String get continueWithTemporaryPremium => 'Continuar com Premium temporário';

  @override
  String get testProductUnavailable => 'Produto de teste indisponível';

  @override
  String get paymentIsChargedToYour =>
      'O pagamento é cobrado na sua conta da App Store.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'As assinaturas renovam automaticamente, a menos que canceladas';

  @override
  String get atLeast24HoursBefore =>
      'pelo menos 24 horas antes do fim do período atual.';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get closePurchaseOffer => 'Fechar oferta de compra';

  @override
  String get loading => 'Carregando...';

  @override
  String get analyzingImage2 => 'Analisando imagem…';

  @override
  String get extractingChineseText2 => 'Extraindo texto em chinês…';

  @override
  String get lookingUpVocabulary2 => 'Buscando vocabulário…';

  @override
  String get deselectAll => 'Desmarcar tudo';

  @override
  String get selectAll => 'Selecionar tudo';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Obra-prima da literatura chinesa e mundial.';

  @override
  String get classic => 'Clássico';

  @override
  String get literature => 'Literatura';

  @override
  String get theOriginAwakening => 'A Origem e o Despertar';

  @override
  String get turbulentHorizonsTheJourney =>
      'Horizontes Turbulentos e a Jornada';

  @override
  String get trialsTribulationsDevotion => 'Provações, Tribulações e Devoção';

  @override
  String get theClashOfWitsBravery => 'O Confronto de Astúcia e Coragem';

  @override
  String get theGrandClimaxResolution => 'O Grande Clímax e a Resolução';

  @override
  String get everlastingLegacyEpilogue => 'Legado Eterno e Epílogo';

  @override
  String get acrossTheVastExpanseOf =>
      'Pela vasta extensão do céu e da terra, personagens buscam seu destino e convicções através de profundas provações.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Cada diálogo e encontro na história carrega o brilho do espírito humano e a marca de sua época.';

  @override
  String get followingTheFlowOfProse =>
      'Seguindo o fluxo da prosa, os leitores atravessam séculos para compartilhar os triunfos e tristezas de figuras lendárias.';

  @override
  String get preQin => 'pré-qin';

  @override
  String get theGoddessNWaRepairing => 'A deusa Nüwa reparando o céu';

  @override
  String get artsTraditions => 'Artes e Tradições';

  @override
  String get femaleWarm => 'Feminina, acolhedora';

  @override
  String get femaleCheerful => 'Feminina, alegre';

  @override
  String get maleUpbeat => 'Masculina, animada';

  @override
  String get maleNewsStyle => 'Masculina, estilo jornalístico';

  @override
  String get maleSporty => 'Masculina, esportiva';

  @override
  String get onDevice => 'No dispositivo';

  @override
  String get label15Minutes => '15 Minutos';

  @override
  String get label30Minutes => '30 Minutos';

  @override
  String get label45Minutes => '45 Minutos';

  @override
  String get selectChapter => 'Selecionar capítulo';

  @override
  String get andContinuesToBeStudied =>
      'e continua sendo estudado e celebrado por leitores através das gerações.';

  @override
  String get label1Poem => '1 Poema';

  @override
  String get label1Chapter => '1 Capítulo';

  @override
  String get localDeviceVoice2 => 'Voz do dispositivo local';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Cota semanal do Azure atingida — alternando para a voz local';

  @override
  String get sleepTimer2 => '定时关闭 · Temporizador';

  @override
  String get tableOfContents2 => '目录 · Sumário';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Clássicos Espanhóis, Italianos e Russos';

  @override
  String get englishAmericanGlobalClassics =>
      'Clássicos Ingleses, Americanos e Mundiais';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'enquanto insere estrategicamente palavras com as quais você tem dificuldade para que possa aprendê-las no contexto.';

  @override
  String get poetryPainting => 'poesia e pintura';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'O Estúdio de Shadowing é um espaço dedicado para praticar a imitação de falantes nativos. Você ouve uma frase, grava a si mesmo repetindo e compara as formas de onda e pontuações de pronúncia para aprimorar seu sotaque.';

  @override
  String get theVoicesInAIStories =>
      'Histórias com IA e Roleplay usam vozes sintéticas geradas por modelos avançados de conversão de texto em fala, ajustados para uma pronúncia chinesa clara e natural. Uma voz local do dispositivo também pode estar disponível em alguns recursos.';

  @override
  String get theWebExplorerAllowsYou =>
      'O Navegador Web permite explorar qualquer site em chinês. Quando encontrar uma palavra difícil, basta tocar nela para abrir o cartão de Consulta Rápida, que exibe pinyin, tradução e nível HSK instantaneamente.';

  @override
  String get zenModeStripsAwayDistracting =>
      'O Modo Zen remove elementos de texto distraidores, anúncios e layouts complexos de artigos, apresentando um ambiente de leitura limpo e caligráfico focado puramente no texto.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Usamos um algoritmo inteligente que prevê quando você está prestes a esquecer uma palavra. As palavras com as quais você tem dificuldade aparecerão com mais frequência, enquanto as que você já domina serão agendadas para mais tarde.';

  @override
  String get usage3 => 'Uso:';

  @override
  String get tutorialOneExplanation =>
      'Este é o UM (Yī). Desenhe sempre da esquerda para a direita.';

  @override
  String get tutorialWaterExplanation =>
      'Este é o caractere completo ÁGUA (Shuǐ). Quando usado como componente no lado esquerdo, ele se transforma em \'氵\' (Três Pingos)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Os Hanzi são construídos a partir de blocos chamados RADICAIS. Eles dão ao caractere seu significado principal ou tema.';

  @override
  String get tutorialLettersExplanation =>
      'Os Hanzi não são apenas letras. São imagens congeladas no tempo. Para dominá-los, você deve aprender a seguir seu fluxo.';

  @override
  String get tutorialGalaxyExplanation =>
      'O Mapa da Galáxia espera por você. Domine os Sóis (Radicais) para desbloquear os Planetas (Caracteres).';

  @override
  String get onboardingDailyLifeTravel => 'Dia a Dia e Viagens';

  @override
  String get onboardingPhilosophyIdioms => 'Filosofia e Expressões';

  @override
  String get onboardingBusinessCareerMulti => 'Negócios e\nCarreira';

  @override
  String get onboardingTravelSurvivalMulti => 'Viagem e\nSobrevivência';

  @override
  String get onboardingHskCertificationMulti => 'Certificação\nHSK';

  @override
  String get onboardingCulturalAppreciationMulti => 'Apreciação\nCultural';

  @override
  String get practiceReminders => 'Lembretes de prática';

  @override
  String get oneOptionalDailyReminderTo =>
      'Um lembrete diário opcional para praticar chinês';

  @override
  String get aFewMinutesOfChinese => 'Alguns minutos de chinês? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Mantenha seu progresso em dia com uma sessão rápida de prática.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'estudar · aprender';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'descobrir';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'persistir';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'crescer';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'calmo · tranquilo';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'entender';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'calor · quente';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'focar';

  @override
  String get definitionExpansionButton => 'botão-de-expansão-de-definição';

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
  String get masterLin => 'Mestre Lin';

  @override
  String get xiaoMei => 'Xiao Mei';

  @override
  String get thePoet => 'O Poeta';

  @override
  String get aQiang => 'A-Qiang';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Formal e sábio';

  @override
  String get casualFriendly => 'Casual e amigável';

  @override
  String get poeticAncient => 'Poético e antigo';

  @override
  String get slangInternet => 'Gírias e internet';

  @override
  String get trendyModern => 'Moderno e descolado';

  @override
  String get designYourOwn => 'Crie o seu próprio';

  @override
  String get theBambooSwaysAndThe =>
      'O bambu balança, e o sábio aguarda suas palavras como a chuva da manhã...';

  @override
  String get yourCustomPersonaIsActive =>
      'Sua persona personalizada está ativa. Digite para começar a conversa.';

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
      'Resposta de expansão do dicionário obsoleta';

  @override
  String get dictionaryExpansionWasEmpty =>
      'A expansão do dicionário estava vazia';

  @override
  String get explicationDTaillEDisponible => 'Explicação detalhada disponível';

  @override
  String get ausfHrlicheErklRungVerf => 'Explicação detalhada disponível';

  @override
  String get explicaciNDetalladaDisponible => 'Explicação detalhada disponível';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Explicação detalhada disponível';

  @override
  String get explicaODetalhadaDisponVel => 'Explicação detalhada disponível';

  @override
  String get detailedExplanationAvailable => 'Explicação detalhada disponível';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Um lembrete diário opcional de prática';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Escolha um lembrete diário opcional de prática.';

  @override
  String get practiceReminder => 'Lembrete de prática';

  @override
  String get oneGentleReminderADay =>
      'Um lembrete suave por dia, apenas se precisar';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Concluir a prática silencia o lembrete de hoje. Revisão e';

  @override
  String get reEngagementAlertsAreCombined =>
      'alertas de reengajamento são combinados para nunca acumular.';

  @override
  String get processing2 => 'Processando…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Ouvir';

  @override
  String get notice => 'Observe';

  @override
  String get fourTones => 'Quatro tons';

  @override
  String get write => 'Escrever';

  @override
  String get recap => 'Resumo';

  @override
  String get playbackDidNotStart => 'A reprodução não foi iniciada';

  @override
  String get audioIsUnavailableYouCan =>
      'O áudio está indisponível. Você ainda pode ler e continuar.';

  @override
  String get microphoneAccessWasNotGranted =>
      'O acesso ao microfone não foi concedido. Você pode usar a opção silenciosa abaixo.';

  @override
  String get recordingIsUnavailableRightNow =>
      'A gravação não está disponível no momento.';

  @override
  String get listeningToYourTones => 'Ouvindo seus tons…';

  @override
  String get noRecording => 'Sem gravação';

  @override
  String get weCouldNotScoreThat =>
      'Não foi possível avaliar essa gravação. Aqui está uma comparação de tons de exemplo.';

  @override
  String get listenForTheLowDipping =>
      'Ouça o terceiro tom, baixo e descendente.';

  @override
  String get firstHearATinyMoment =>
      'Primeiro, ouça um trecho em mandarim. Nada de memorizar ainda.';

  @override
  String get loadingAudio => 'Carregando áudio…';

  @override
  String get listenToThePassage => 'Ouça o trecho';

  @override
  String get continueAction => 'Continuar';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Observe como significado, som e caracteres andam juntos.';

  @override
  String get shadowOneSentence => 'Faça o shadowing de uma frase';

  @override
  String get listenOnceThenHoldThe =>
      'Ouça uma vez e, depois, segure o microfone e diga a frase.';

  @override
  String get hearItAgain => 'Ouvir novamente';

  @override
  String get stopAndCheckMyTones => 'Parar e verificar meus tons';

  @override
  String get useMicrophone => 'Usar microfone';

  @override
  String get iCanTSpeakRight => 'Não posso falar agora';

  @override
  String get tapACharacterToCompare =>
      'Toque em um caractere para comparar o tom dito com o tom correto e, depois, ouça os tons 1–4.';

  @override
  String get tryHandwriting => 'Tente a escrita à mão';

  @override
  String get seeWhatYouLearned => 'Veja o que você aprendeu';

  @override
  String get inAFewMinutesYou =>
      'Em poucos minutos, você usou o mesmo ciclo que impulsiona suas lições.';

  @override
  String get listenedToChineseInContext => 'Ouviu chinês no contexto';

  @override
  String get shadowedASentence => 'Praticou shadowing em uma frase';

  @override
  String get comparedMandarinTones => 'Comparou tons do mandarim';

  @override
  String get practicedARealCharacter => 'Praticou um caractere real';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'Ao amanhecer, a chuva fina parou. Abri a janela e ouvi os passarinhos cantando nas árvores. Um novo dia começou.';

  @override
  String get learnThroughRealVideos => 'Aprenda com vídeos reais';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Acompanhe legendas interativas, consulte palavras instantaneamente e transforme qualquer vídeo em uma lição.';

  @override
  String get videoLearningScreenshot =>
      'Captura de tela do aprendizado por vídeo';

  @override
  String get turnAnyBookIntoA =>
      'Transforme qualquer livro em uma lição e audiolivro';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Leia com naturalidade, tendo pronúncia, definições e tradução sempre à disposição.';

  @override
  String get bookReaderScreenshot => 'Captura de tela do leitor de livros';

  @override
  String get speakWithTheRightRhythm => 'Fale livremente com IA e tons ao vivo';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Pratique o shadowing do áudio nativo e visualize todos os quatro tons conforme sua pronúncia melhora.';

  @override
  String get shadowingAndTonesScreenshot =>
      'Captura de tela de shadowing e tons';

  @override
  String get understandEveryCharacter => 'Entenda cada caractere';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Explore significado, pronúncia, componentes, ordem dos traços e vocabulário útil em um só lugar.';

  @override
  String get characterDictionaryScreenshot =>
      'Captura de tela do dicionário de caracteres';

  @override
  String get learnChineseWithoutLimits => 'Aprenda chinês sem limites';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Assista, leia, fale e entenda chinês com um companheiro de estudo completo.';

  @override
  String get seeWhatPremiumUnlocks => 'Veja o que o Premium desbloqueia';

  @override
  String get scrollToExploreTheComplete =>
      'Role para explorar a experiência completa de aprendizado';

  @override
  String get cOMINGSOON => 'EM BREVE';

  @override
  String get guidedHandwritingPractice => 'Prática guiada de escrita à mão';

  @override
  String get scannerAndLiveTranslation => 'Escâner e tradução ao vivo';

  @override
  String get hSK16AndAI => 'Baralhos de HSK 1–6 e IA';

  @override
  String get smartSpacedRepetition2 => 'Repetição espaçada inteligente';

  @override
  String get progressAndStreakTracking =>
      'Acompanhamento de progresso e sequência';

  @override
  String get learningToolsInOnePlace =>
      'Ferramentas de aprendizado em um só lugar';

  @override
  String get everythingIncluded => 'Tudo incluído';

  @override
  String get paymentIsChargedToYour2 =>
      'O pagamento é cobrado na sua conta da App Store. As assinaturas renovam automaticamente, a menos que sejam canceladas pelo menos 24 horas antes do final do período atual.';

  @override
  String get yourFirstWeekOfTracked =>
      'Sua primeira semana de prática monitorada';

  @override
  String get sameNumberOfCardsAs => 'Mesmo número de cartões da semana passada';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change cartões em relação à semana passada';
  }

  @override
  String get todaySPractice => 'Prática de hoje';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Meta concluída — o que vier a mais é bônus.';

  @override
  String get aSmallAchievableTargetNo =>
      'Uma meta pequena e alcançável. Sem penalidade nos dias de descanso.';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get minutes => 'Minutos';

  @override
  String get activeDays => 'Dias ativos';

  @override
  String dayStreakCount(int count) {
    return 'Sequência de $count dias';
  }

  @override
  String get masterChineseOneStrokeAt =>
      'Domine o chinês, um traço de cada vez';

  @override
  String get dictionaryExpansionButton => 'Botão de expansão do dicionário';

  @override
  String get kIErweiterterWRterbucheintrag =>
      'Entrada de dicionário expandida por IA';

  @override
  String get detalleAmpliadoPorIA => 'Detalhes ampliados por IA';

  @override
  String get dTailEnrichiParL => 'Detalhes enriquecidos por IA';

  @override
  String get aI => 'Detalhes do dicionário expandidos por IA';

  @override
  String get detailKamusYangDiperluasAI =>
      'Detalhes do dicionário expandidos por IA';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'Detalhes do dicionário ampliados por IA';

  @override
  String get aI2 => 'Complemento de dicionário por IA';

  @override
  String get aI3 => 'Explicação de dicionário expandida por IA';

  @override
  String get detalheDeDicionRioExpandido =>
      'Detalhes do dicionário expandidos por IA';

  @override
  String get aI4 => 'Detalhes do dicionário expandidos por IA';

  @override
  String get chiTiTTI => 'Detalhes do dicionário expandidos por IA';

  @override
  String get aI5 => 'Definição do dicionário expandida por IA';

  @override
  String get aIExpandedDictionaryDetail =>
      'Detalhes do dicionário expandidos por IA';

  @override
  String get cetteEntrEEstBr =>
      'Esta entrada é breve. Uma explicação detalhada está disponível.';

  @override
  String get dieserEintragIstKurzEine =>
      'Esta entrada é curta. Uma explicação detalhada está disponível.';

  @override
  String get estaEntradaEsBreveHay =>
      'Esta entrada é breve. Há uma explicação detalhada disponível.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Esta entrada é breve. Uma explicação detalhada está disponível.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Esta entrada é breve. Uma explicação detalhada está disponível.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Esta entrada do dicionário é breve. Uma explicação detalhada está disponível.';

  @override
  String get dVelopperEnFranAis => 'Expandir em francês';

  @override
  String get aufDeutschErweitern => 'Expandir em alemão';

  @override
  String get ampliarEnEspaOl => 'Expandir em espanhol';

  @override
  String get approfondisciInItaliano => 'Expandir em italiano';

  @override
  String get expandirEmPortuguS => 'Expandir em português';

  @override
  String get expandDefinition => 'Expandir definição';

  @override
  String get impossibleDeChargerLExplication =>
      'Não foi possível carregar a explicação.';

  @override
  String get dieErklRungKonnteNicht =>
      'Não foi possível carregar a explicação.';

  @override
  String get noSePudoCargarLa => 'Não foi possível carregar a explicação.';

  @override
  String get impossibileCaricareLaSpiegazione =>
      'Não foi possível carregar a explicação.';

  @override
  String get nOFoiPossVel => 'Não foi possível carregar a explicação.';

  @override
  String get unableToLoadTheExplanation =>
      'Não foi possível carregar a explicação.';

  @override
  String get failedToGenerateStoryN => 'Falha ao gerar a história:\\n\$e';

  @override
  String get thematic => 'Temático';

  @override
  String get deckFlashcards => 'Baralho (Flashcards)';

  @override
  String get searchLibraryOrTypeCustom =>
      'Pesquisar na biblioteca ou digitar personalizado';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Falha na análise: \$e';

  @override
  String get extractionFailedE => 'Falha na extração: \$e';

  @override
  String get simplifyFailedE => 'Falha ao simplificar: \$e';

  @override
  String get translationFailedE => 'Falha na tradução: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Falha ao salvar as palavras extraídas: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'Você: $actual  ·  Alvo: $expected';
  }

  @override
  String get improveTheLocalVoice => 'Melhorar a voz local';

  @override
  String get higherQualityOfflineMandarin =>
      'Mandarim offline de alta qualidade';

  @override
  String get removeDownload => 'Remover o download?';

  @override
  String get removeDownload2 => 'Remover Download';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Feminina, calorosa';

  @override
  String get voiceFemaleCheerful => 'Feminina, alegre';

  @override
  String get voiceMaleUpbeat => 'Masculino, animado';

  @override
  String get voiceMaleNewsStyle => 'Masculino, estilo jornalístico';

  @override
  String get voiceMaleSporty => 'Masculino, esportivo';

  @override
  String get voiceOnDeviceTts => 'Síntese de voz no dispositivo';

  @override
  String get voiceSystemVoice => 'Voz do sistema';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Aplicar notas da sessão à Repetição Espaçada (Modo de Fala)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Não foi possível carregar esta seção. Tente novamente.';

  @override
  String get removeDownloadQuestion => 'Remover o download?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'Remover Download';

  @override
  String get removeDownloadButton => 'Remover Download';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'Resumo da IA';

  @override
  String get readability => 'Legibilidade';

  @override
  String get translateAction => 'Traduzir';

  @override
  String get checkingDownload => 'Verificando download';

  @override
  String downloadingBook(int percent) {
    return 'Baixando: $percent%';
  }

  @override
  String get retryDownload => 'Tentar baixar novamente';

  @override
  String get downloadBook => 'Baixar livro';

  @override
  String continueChapter(int chapter) {
    return 'Continuar no cap?tulo $chapter';
  }

  @override
  String get downloadBookError =>
      'N?o foi poss?vel baixar este livro. Verifique sua conex?o e tente novamente.';

  @override
  String downloadBookOffline(int count) {
    return 'Baixe o livro para ler seus $count cap?tulos offline.';
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
  String get americanLiterature => 'Literatura americana';

  @override
  String get ancientChina => 'China Antiga';

  @override
  String get britishLiterature => 'Literatura brit?nica';

  @override
  String get frenchLiterature => 'Literatura francesa';

  @override
  String get germanLiterature => 'Literatura alem?';

  @override
  String get italianLiterature => 'Literatura italiana';

  @override
  String get jinDynasty => 'Dinastia Jin';

  @override
  String get preQinEra => 'Per?odo pr?-Qin';

  @override
  String get qingDynasty => 'Dinastia Qing';

  @override
  String get republicOfChinaEra => 'Rep?blica da China';

  @override
  String get russianLiterature => 'Literatura russa';

  @override
  String get spanishLiterature => 'Literatura espanhola';

  @override
  String get springAndAutumn => 'Per?odo das Primaveras e Outonos';

  @override
  String get westernHan => 'Han Ocidental';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'ex.: Um animado banquete de celebração em Xangai...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'ex.: Um primo curioso perguntando sobre sua carreira...';

  @override
  String get beginFirstLesson => 'Iniciar Primeira Lição';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'SUA PRIMEIRA LIÇÃO  •  $current DE $total';
  }

  @override
  String get onboardingListenInstruction =>
      'Primeiro, ouça uma das frases mais conhecidas da literatura chinesa. Nada de memorizar por enquanto.';

  @override
  String get onboardingFromGrandLibrary => 'Da Grande Biblioteca';

  @override
  String get onboardingArtOfWarTitleAuthor => 'A Arte da Guerra · Sun Tzu';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · Capítulo 3';

  @override
  String get onboardingClassicLineLabel => 'UMA FRASE CLÁSSICA';

  @override
  String get onboardingArtOfWarTranslation =>
      '“Conhece o inimigo e conhece-te a ti mesmo, e não temerás o resultado de cem batalhas.”';

  @override
  String get onboardingNoticeMeaning =>
      'Conhece o inimigo e conhece-te a ti mesmo,';

  @override
  String get onboardingShadowMeaning => 'Não correrás perigo em cem batalhas.';

  @override
  String get onboardingPracticeThisLabel => 'VOCÊ PRATICARÁ ISTO';

  @override
  String get onboardingFromArtOfWarLabel => 'DE A ARTE DA GUERRA';

  @override
  String get onboardingYourPronunciationLabel => 'SUA PRONÚNCIA';

  @override
  String get onboardingTapACharacter => 'Toque em um caractere';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'Correspondente';

  @override
  String get onboardingCompareTones => 'Comparar tons';

  @override
  String get onboardingToneOneHigh => 'tom 1 · alto';

  @override
  String get onboardingToneTwoRising => 'tom 2 · ascendente';

  @override
  String get onboardingToneThreeDipping => 'tom 3 · descendente-ascendente';

  @override
  String get onboardingToneFourFalling => 'tom 4 · descendente';

  @override
  String get onboardingToneNotDetected => 'não detectado';

  @override
  String get onboardingFeedbackGreatThirdTone =>
      'Excelente terceiro tom descendente-ascendente.';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'Deixe o quarto tom cair com firmeza e rapidez.';

  @override
  String get onboardingFeedbackClearFourthTone =>
      'Quarto tom descendente claro.';

  @override
  String get onboardingFeedbackStrongFourthTone =>
      'Quarto tom descendente firme.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return 'Trace $character ($pinyin, “$meaning”). Siga o guia suave dos traços.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
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
      one: '1 mês',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anos',
      one: '1 ano',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return 'Iniciar teste gratuito de $period';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return 'Assinar por $price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'O seu produto selecionado inclui um teste gratuito elegível. Após o período de teste, a assinatura é renovada por $price por $period, a menos que seja cancelada.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'Aprender';

  @override
  String get booksAndStudioQualityAudiobooks =>
      'Livros e audiolivros com qualidade de estúdio';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'Conversas com IA e feedback de tom em tempo real';

  @override
  String get interactiveVideoAndWebImmersion =>
      'Vídeo interativo e imersão na web';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'Insights sobre caracteres e prática de caligrafia';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'Decks do HSK e repetição espaçada inteligente';

  @override
  String get termsOfUseEula => 'Termos de Uso (EULA)';

  @override
  String get masterEveryStroke => 'Domine cada traço';

  @override
  String get exploreTheChineseWeb => 'Explore a web chinesa';

  @override
  String get tone1Description =>
      'Mantenha seu tom alto e estável como ao cantar uma nota.';

  @override
  String get tone2Description =>
      'Comece no meio e deslize seu tom para cima como ao perguntar \'O quê?\'';

  @override
  String get tone3Description => 'Abaixe sua voz, depois suba suavemente.';

  @override
  String get tone4Description =>
      'Abaixe seu tom de forma brusca e decisiva como um \'Não!\' firme.';

  @override
  String get toneNeutralDescription =>
      'Pronuncie suavemente, brevemente e sem ênfase.';

  @override
  String get toneDiagMatch1 => 'Perfeito! O tom foi alto, plano e constante.';

  @override
  String get toneDiagMatch2 => 'Perfeito! A subida do tom foi clara.';

  @override
  String get toneDiagMatch3 =>
      'Perfeito! A curva de descida baixa foi precisa.';

  @override
  String get toneDiagMatch4 => 'Perfeito! A queda acentuada foi decisiva.';

  @override
  String get toneDiagMatchDefault =>
      'Perfeito! O tom foi pronunciado com precisão.';

  @override
  String get toneDiag1vs2 =>
      'Você subiu o tom (2º tom /). Mantenha sua voz plana e alta em toda a sílaba (1º tom ˉ).';

  @override
  String get toneDiag1vs3 =>
      'Você abaixou a voz (3º tom ˇ). Mantenha seu tom estável e alto sem abaixar (1º tom ˉ).';

  @override
  String get toneDiag1vs4 =>
      'Você abaixou o tom (4º tom \\). Mantenha um tom alto e nivelado como se estivesse cantando uma nota (1º tom ˉ).';

  @override
  String get toneDiag2vs1 =>
      'Você ficou plano (1º tom ˉ). Deslize seu tom para cima como se perguntasse \'O quê?\' (2º tom /).';

  @override
  String get toneDiag2vs3 =>
      'Você desceu demais (3º tom ˇ). Comece no nível médio e suba suavemente sem ir até o fundo (2º tom /).';

  @override
  String get toneDiag2vs4 =>
      'Você abaixou o tom (4º tom \\). Suba para cima como se estivesse fazendo uma pergunta (2º tom /).';

  @override
  String get toneDiag3vs1 =>
      'Você ficou alto e plano (1º tom ˉ). Deixe seu tom cair baixo para o seu registro de peito antes de subir (3º tom ˇ).';

  @override
  String get toneDiag3vs2 =>
      'Você subiu imediatamente (2º tom /). Certifique-se de descer primeiro antes de subir novamente (3º tom ˇ).';

  @override
  String get toneDiag3vs4 =>
      'Você caiu bruscamente sem subir (4º tom \\). Permita que seu tom suba suavemente no final (3º tom ˇ).';

  @override
  String get toneDiag4vs1 =>
      'Você ficou plano (1º tom ˉ). Abaixe seu tom de forma acentuada e decisiva como um \'Não!\' firme (4º tom \\).';

  @override
  String get toneDiag4vs2 =>
      'Você subiu o tom (2º tom /). Comece alto e desça bruscamente (4º tom \\).';

  @override
  String get toneDiag4vs3 =>
      'Você desceu e subiu (3º tom ˇ). Desça direto sem subir novamente (4º tom \\).';

  @override
  String get toneDiagListenDiff =>
      'Ouça os 4 tons abaixo para ouvir a diferença.';
}
