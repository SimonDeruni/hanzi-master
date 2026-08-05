import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('vi')
  ];

  /// No description provided for @globalMastery.
  ///
  /// In en, this message translates to:
  /// **'GLOBAL MASTERY'**
  String get globalMastery;

  /// No description provided for @masteredCards.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get masteredCards;

  /// No description provided for @hsk1Candidate.
  ///
  /// In en, this message translates to:
  /// **'HSK 1 Candidate'**
  String get hsk1Candidate;

  /// No description provided for @hsk2Candidate.
  ///
  /// In en, this message translates to:
  /// **'HSK 2 Candidate'**
  String get hsk2Candidate;

  /// No description provided for @hsk3Candidate.
  ///
  /// In en, this message translates to:
  /// **'HSK 3 Candidate'**
  String get hsk3Candidate;

  /// No description provided for @hsk4Candidate.
  ///
  /// In en, this message translates to:
  /// **'HSK 4 Candidate'**
  String get hsk4Candidate;

  /// No description provided for @hsk5Candidate.
  ///
  /// In en, this message translates to:
  /// **'HSK 5 Candidate'**
  String get hsk5Candidate;

  /// No description provided for @hsk6Candidate.
  ///
  /// In en, this message translates to:
  /// **'HSK 6 Candidate'**
  String get hsk6Candidate;

  /// No description provided for @hsk6Master.
  ///
  /// In en, this message translates to:
  /// **'HSK 6 Master'**
  String get hsk6Master;

  /// No description provided for @currentRank.
  ///
  /// In en, this message translates to:
  /// **'CURRENT RANK'**
  String get currentRank;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @searchHanziOrPinyin.
  ///
  /// In en, this message translates to:
  /// **'Search Hanzi or Pinyin...'**
  String get searchHanziOrPinyin;

  /// No description provided for @dailyReview.
  ///
  /// In en, this message translates to:
  /// **'Daily Review'**
  String get dailyReview;

  /// No description provided for @upcomingForecast.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Forecast'**
  String get upcomingForecast;

  /// No description provided for @laterToday.
  ///
  /// In en, this message translates to:
  /// **'Later Today'**
  String get laterToday;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @next7Days.
  ///
  /// In en, this message translates to:
  /// **'Next 7 Days'**
  String get next7Days;

  /// No description provided for @theScholarWay.
  ///
  /// In en, this message translates to:
  /// **'The Scholar\'s Way'**
  String get theScholarWay;

  /// No description provided for @beginJourney.
  ///
  /// In en, this message translates to:
  /// **'Begin Journey'**
  String get beginJourney;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Easy on the eyes'**
  String get darkModeDesc;

  /// No description provided for @voiceSpeed.
  ///
  /// In en, this message translates to:
  /// **'Voice Speed'**
  String get voiceSpeed;

  /// No description provided for @artAndIntellect.
  ///
  /// In en, this message translates to:
  /// **'ART & INTELLECT'**
  String get artAndIntellect;

  /// No description provided for @theDigitalScholar.
  ///
  /// In en, this message translates to:
  /// **'The Digital Scholar'**
  String get theDigitalScholar;

  /// No description provided for @refineBrushVoice.
  ///
  /// In en, this message translates to:
  /// **'Refine your brush and voice with advanced AI.'**
  String get refineBrushVoice;

  /// No description provided for @liveVoiceCall.
  ///
  /// In en, this message translates to:
  /// **'Live Voice Call'**
  String get liveVoiceCall;

  /// No description provided for @immersiveRoleplay.
  ///
  /// In en, this message translates to:
  /// **'Immersive roleplay with AI avatars'**
  String get immersiveRoleplay;

  /// No description provided for @readingRoom.
  ///
  /// In en, this message translates to:
  /// **'Reading Room'**
  String get readingRoom;

  /// No description provided for @shadowingStudio.
  ///
  /// In en, this message translates to:
  /// **'Shadowing Studio'**
  String get shadowingStudio;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get errorPrefix;

  /// No description provided for @initializingLibrary.
  ///
  /// In en, this message translates to:
  /// **'Initializing Library...'**
  String get initializingLibrary;

  /// No description provided for @unlockCharactersToQuiz.
  ///
  /// In en, this message translates to:
  /// **'Unlock at least 4 characters to start a quiz!'**
  String get unlockCharactersToQuiz;

  /// No description provided for @practiceQuiz.
  ///
  /// In en, this message translates to:
  /// **'PRACTICE QUIZ'**
  String get practiceQuiz;

  /// No description provided for @curriculumPaths.
  ///
  /// In en, this message translates to:
  /// **'CURRICULUM PATHS'**
  String get curriculumPaths;

  /// No description provided for @noDecksFound.
  ///
  /// In en, this message translates to:
  /// **'No decks found. Add some to your library!'**
  String get noDecksFound;

  /// No description provided for @addCardsFirst.
  ///
  /// In en, this message translates to:
  /// **'Add some cards to this deck first!'**
  String get addCardsFirst;

  /// No description provided for @aiDraftingPath.
  ///
  /// In en, this message translates to:
  /// **'The AI Scholar is drafting your path...'**
  String get aiDraftingPath;

  /// No description provided for @pathReady.
  ///
  /// In en, this message translates to:
  /// **'Your path is ready!'**
  String get pathReady;

  /// No description provided for @errorGeneratingPath.
  ///
  /// In en, this message translates to:
  /// **'Error generating path'**
  String get errorGeneratingPath;

  /// No description provided for @brushingCurriculum.
  ///
  /// In en, this message translates to:
  /// **'Brushing Curriculum...'**
  String get brushingCurriculum;

  /// No description provided for @warmUp.
  ///
  /// In en, this message translates to:
  /// **'WARM UP'**
  String get warmUp;

  /// No description provided for @lessonComplete.
  ///
  /// In en, this message translates to:
  /// **'Lesson Complete! +10 Ink Points'**
  String get lessonComplete;

  /// No description provided for @step1Origin.
  ///
  /// In en, this message translates to:
  /// **'STEP 1: THE ORIGIN'**
  String get step1Origin;

  /// No description provided for @traceRadical.
  ///
  /// In en, this message translates to:
  /// **'Trace the Radical'**
  String get traceRadical;

  /// No description provided for @step2Forge.
  ///
  /// In en, this message translates to:
  /// **'STEP 2: THE FORGE'**
  String get step2Forge;

  /// No description provided for @chooseEssence.
  ///
  /// In en, this message translates to:
  /// **'Choose the Essence'**
  String get chooseEssence;

  /// No description provided for @wrongEssence.
  ///
  /// In en, this message translates to:
  /// **'Wrong essence! Try again.'**
  String get wrongEssence;

  /// No description provided for @step3Hunt.
  ///
  /// In en, this message translates to:
  /// **'STEP 3: THE HUNT'**
  String get step3Hunt;

  /// No description provided for @findCharacters.
  ///
  /// In en, this message translates to:
  /// **'Find characters'**
  String get findCharacters;

  /// No description provided for @notThatOne.
  ///
  /// In en, this message translates to:
  /// **'Not that one! Look closer.'**
  String get notThatOne;

  /// No description provided for @successfullyInstalled.
  ///
  /// In en, this message translates to:
  /// **'Successfully installed'**
  String get successfullyInstalled;

  /// No description provided for @failedToDownload.
  ///
  /// In en, this message translates to:
  /// **'Failed to download module.'**
  String get failedToDownload;

  /// No description provided for @rescindTitle.
  ///
  /// In en, this message translates to:
  /// **'Rescind?'**
  String get rescindTitle;

  /// No description provided for @removeCharactersWarning.
  ///
  /// In en, this message translates to:
  /// **'This will remove these characters from your library and reset your mastery progress.'**
  String get removeCharactersWarning;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @uninstall.
  ///
  /// In en, this message translates to:
  /// **'Uninstall'**
  String get uninstall;

  /// No description provided for @removedLibrary.
  ///
  /// In en, this message translates to:
  /// **'Removed Library.'**
  String get removedLibrary;

  /// No description provided for @tomeLibrary.
  ///
  /// In en, this message translates to:
  /// **'Tome Library'**
  String get tomeLibrary;

  /// No description provided for @libraryError.
  ///
  /// In en, this message translates to:
  /// **'Library Error'**
  String get libraryError;

  /// No description provided for @installTome.
  ///
  /// In en, this message translates to:
  /// **'INSTALL TOME'**
  String get installTome;

  /// No description provided for @unitIntro.
  ///
  /// In en, this message translates to:
  /// **'UNIT INTRO'**
  String get unitIntro;

  /// No description provided for @constellationCluster.
  ///
  /// In en, this message translates to:
  /// **'Constellation Cluster'**
  String get constellationCluster;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @divingInto.
  ///
  /// In en, this message translates to:
  /// **'Diving into...'**
  String get divingInto;

  /// No description provided for @keyRadicals.
  ///
  /// In en, this message translates to:
  /// **'KEY RADICALS'**
  String get keyRadicals;

  /// No description provided for @noRadicalData.
  ///
  /// In en, this message translates to:
  /// **'No radical data available.'**
  String get noRadicalData;

  /// No description provided for @discovery.
  ///
  /// In en, this message translates to:
  /// **'DISCOVERY'**
  String get discovery;

  /// No description provided for @startLearning.
  ///
  /// In en, this message translates to:
  /// **'START LEARNING'**
  String get startLearning;

  /// No description provided for @selectPersona.
  ///
  /// In en, this message translates to:
  /// **'Select Persona'**
  String get selectPersona;

  /// No description provided for @customPersona.
  ///
  /// In en, this message translates to:
  /// **'Custom Persona'**
  String get customPersona;

  /// No description provided for @geminiLiveCall.
  ///
  /// In en, this message translates to:
  /// **'GEMINI LIVE CALL'**
  String get geminiLiveCall;

  /// No description provided for @returnToMenu.
  ///
  /// In en, this message translates to:
  /// **'Return to menu'**
  String get returnToMenu;

  /// No description provided for @strokeAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Stroke Analysis'**
  String get strokeAnalysis;

  /// No description provided for @excellentWork.
  ///
  /// In en, this message translates to:
  /// **'Excellent work!'**
  String get excellentWork;

  /// No description provided for @keepPracticing.
  ///
  /// In en, this message translates to:
  /// **'Keep practicing!'**
  String get keepPracticing;

  /// No description provided for @drawingSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Drawing Submitted'**
  String get drawingSubmitted;

  /// No description provided for @customPersonaHint.
  ///
  /// In en, this message translates to:
  /// **'Define a custom persona...'**
  String get customPersonaHint;

  /// No description provided for @stepOneOrigin.
  ///
  /// In en, this message translates to:
  /// **'STEP 1: THE ORIGIN'**
  String get stepOneOrigin;

  /// No description provided for @stepTwoForge.
  ///
  /// In en, this message translates to:
  /// **'STEP 2: THE FORGE'**
  String get stepTwoForge;

  /// No description provided for @toForge.
  ///
  /// In en, this message translates to:
  /// **'To forge'**
  String get toForge;

  /// No description provided for @whatEssenceDoesNeed.
  ///
  /// In en, this message translates to:
  /// **'what essence does'**
  String get whatEssenceDoesNeed;

  /// No description provided for @need.
  ///
  /// In en, this message translates to:
  /// **'need'**
  String get need;

  /// No description provided for @forged.
  ///
  /// In en, this message translates to:
  /// **'FORGED'**
  String get forged;

  /// No description provided for @stepThreeHunt.
  ///
  /// In en, this message translates to:
  /// **'STEP 3: THE HUNT'**
  String get stepThreeHunt;

  /// No description provided for @findCharactersWith.
  ///
  /// In en, this message translates to:
  /// **'Find characters with'**
  String get findCharactersWith;

  /// No description provided for @uninstallButton.
  ///
  /// In en, this message translates to:
  /// **'UNINSTALL'**
  String get uninstallButton;

  /// No description provided for @gradedAiStories.
  ///
  /// In en, this message translates to:
  /// **'Graded Ai Stories'**
  String get gradedAiStories;

  /// No description provided for @calligraphy.
  ///
  /// In en, this message translates to:
  /// **'Calligraphy'**
  String get calligraphy;

  /// No description provided for @theScrollOfOrigin.
  ///
  /// In en, this message translates to:
  /// **'The Scroll Of Origin'**
  String get theScrollOfOrigin;

  /// No description provided for @galaxyOf.
  ///
  /// In en, this message translates to:
  /// **'Galaxy Of'**
  String get galaxyOf;

  /// No description provided for @constellationDescription.
  ///
  /// In en, this message translates to:
  /// **'Constellation Description'**
  String get constellationDescription;

  /// No description provided for @noRadicalDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Radical Data Available'**
  String get noRadicalDataAvailable;

  /// No description provided for @learningPreferences.
  ///
  /// In en, this message translates to:
  /// **'Learning Preferences'**
  String get learningPreferences;

  /// No description provided for @hardMode.
  ///
  /// In en, this message translates to:
  /// **'Hard Mode'**
  String get hardMode;

  /// No description provided for @hardModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Hard Mode Desc'**
  String get hardModeDesc;

  /// No description provided for @adaptiveGuidance.
  ///
  /// In en, this message translates to:
  /// **'Adaptive Guidance'**
  String get adaptiveGuidance;

  /// No description provided for @dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal'**
  String get dailyGoal;

  /// No description provided for @audioAndHaptics.
  ///
  /// In en, this message translates to:
  /// **'Audio And Haptics'**
  String get audioAndHaptics;

  /// No description provided for @autoPlayAudio.
  ///
  /// In en, this message translates to:
  /// **'Auto Play Audio'**
  String get autoPlayAudio;

  /// No description provided for @autoPlayDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto Play Desc'**
  String get autoPlayDesc;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @displayAndContent.
  ///
  /// In en, this message translates to:
  /// **'Display And Content'**
  String get displayAndContent;

  /// No description provided for @animationSpeed.
  ///
  /// In en, this message translates to:
  /// **'Animation Speed'**
  String get animationSpeed;

  /// No description provided for @manageTomes.
  ///
  /// In en, this message translates to:
  /// **'Manage Tomes'**
  String get manageTomes;

  /// No description provided for @manageTomesDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage Tomes Desc'**
  String get manageTomesDesc;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @resetAllData.
  ///
  /// In en, this message translates to:
  /// **'Reset All Data'**
  String get resetAllData;

  /// No description provided for @resetDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Reset Data Desc'**
  String get resetDataDesc;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure'**
  String get areYouSure;

  /// No description provided for @cannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'Cannot Be Undone'**
  String get cannotBeUndone;

  /// No description provided for @deleteEverything.
  ///
  /// In en, this message translates to:
  /// **'Delete Everything'**
  String get deleteEverything;

  /// Label for the app language setting
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @howDidYouDo.
  ///
  /// In en, this message translates to:
  /// **'How did you do?'**
  String get howDidYouDo;

  /// No description provided for @missedItEntirely.
  ///
  /// In en, this message translates to:
  /// **'Missed it entirely'**
  String get missedItEntirely;

  /// No description provided for @gotItButStruggled.
  ///
  /// In en, this message translates to:
  /// **'Got it, but struggled'**
  String get gotItButStruggled;

  /// No description provided for @gotItClearly.
  ///
  /// In en, this message translates to:
  /// **'Got it clearly'**
  String get gotItClearly;

  /// No description provided for @perfectAndImmediate.
  ///
  /// In en, this message translates to:
  /// **'Perfect & immediate'**
  String get perfectAndImmediate;

  /// No description provided for @again.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get again;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @tapToReveal.
  ///
  /// In en, this message translates to:
  /// **'Tap to Reveal'**
  String get tapToReveal;

  /// No description provided for @howWellDidYouRemember.
  ///
  /// In en, this message translates to:
  /// **'How well did you remember?'**
  String get howWellDidYouRemember;

  /// No description provided for @completelyForgot.
  ///
  /// In en, this message translates to:
  /// **'Completely forgot'**
  String get completelyForgot;

  /// No description provided for @gotItWithDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Got it with difficulty'**
  String get gotItWithDifficulty;

  /// No description provided for @recalledCorrectly.
  ///
  /// In en, this message translates to:
  /// **'Recalled correctly'**
  String get recalledCorrectly;

  /// No description provided for @perfectRecall.
  ///
  /// In en, this message translates to:
  /// **'Perfect recall'**
  String get perfectRecall;

  /// No description provided for @practiceWriting.
  ///
  /// In en, this message translates to:
  /// **'Practice Writing'**
  String get practiceWriting;

  /// No description provided for @hideScratchpad.
  ///
  /// In en, this message translates to:
  /// **'Hide Scratchpad'**
  String get hideScratchpad;

  /// No description provided for @whatCharacterMeans.
  ///
  /// In en, this message translates to:
  /// **'What character means:'**
  String get whatCharacterMeans;

  /// No description provided for @tapCardToReveal.
  ///
  /// In en, this message translates to:
  /// **'Tap card to Reveal'**
  String get tapCardToReveal;

  /// No description provided for @ratePronunciationConfidence.
  ///
  /// In en, this message translates to:
  /// **'Rate your pronunciation confidence'**
  String get ratePronunciationConfidence;

  /// No description provided for @botchedIt.
  ///
  /// In en, this message translates to:
  /// **'Botched it'**
  String get botchedIt;

  /// No description provided for @struggledWithTones.
  ///
  /// In en, this message translates to:
  /// **'Struggled with tones'**
  String get struggledWithTones;

  /// No description provided for @acceptable.
  ///
  /// In en, this message translates to:
  /// **'Acceptable'**
  String get acceptable;

  /// No description provided for @perfectlyNatural.
  ///
  /// In en, this message translates to:
  /// **'Perfectly natural'**
  String get perfectlyNatural;

  /// No description provided for @sessionComplete.
  ///
  /// In en, this message translates to:
  /// **'Session Complete!'**
  String get sessionComplete;

  /// No description provided for @accuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// No description provided for @reviewed.
  ///
  /// In en, this message translates to:
  /// **'Reviewed'**
  String get reviewed;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @backToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Back to Library'**
  String get backToLibrary;

  /// No description provided for @revealAnswer.
  ///
  /// In en, this message translates to:
  /// **'Reveal Answer'**
  String get revealAnswer;

  /// No description provided for @aiHubTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Hub'**
  String get aiHubTitle;

  /// No description provided for @textChat.
  ///
  /// In en, this message translates to:
  /// **'Text Chat'**
  String get textChat;

  /// No description provided for @scholarlyPersonas.
  ///
  /// In en, this message translates to:
  /// **'Scholarly Personas'**
  String get scholarlyPersonas;

  /// No description provided for @shadowing.
  ///
  /// In en, this message translates to:
  /// **'Shadowing'**
  String get shadowing;

  /// No description provided for @liveTranslation.
  ///
  /// In en, this message translates to:
  /// **'Live Translation'**
  String get liveTranslation;

  /// No description provided for @scholarsLibrary.
  ///
  /// In en, this message translates to:
  /// **'The Scholar\'s Library'**
  String get scholarsLibrary;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// No description provided for @searchPinyinHanziEnglish.
  ///
  /// In en, this message translates to:
  /// **'Search Pinyin, Hanzi, or English...'**
  String get searchPinyinHanziEnglish;

  /// No description provided for @liveTranslate.
  ///
  /// In en, this message translates to:
  /// **'Live Translate'**
  String get liveTranslate;

  /// No description provided for @travelInterpreter.
  ///
  /// In en, this message translates to:
  /// **'Travel Interpreter'**
  String get travelInterpreter;

  /// No description provided for @realTimeSplitScreen.
  ///
  /// In en, this message translates to:
  /// **'Real-time split-screen conversation with a native speaker. Breaks down language barriers instantly.'**
  String get realTimeSplitScreen;

  /// No description provided for @whisperEarpiece.
  ///
  /// In en, this message translates to:
  /// **'Whisper Earpiece'**
  String get whisperEarpiece;

  /// No description provided for @listenToChineseAudio.
  ///
  /// In en, this message translates to:
  /// **'Listen to Chinese audio and get real-time English subtitles directly on your screen.'**
  String get listenToChineseAudio;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @yourMindIsClear.
  ///
  /// In en, this message translates to:
  /// **'Your mind is clear.'**
  String get yourMindIsClear;

  /// No description provided for @noReviewsDueToday.
  ///
  /// In en, this message translates to:
  /// **'No reviews due today.'**
  String get noReviewsDueToday;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @hskLevel1.
  ///
  /// In en, this message translates to:
  /// **'HSK Level 1'**
  String get hskLevel1;

  /// No description provided for @hskLevel2.
  ///
  /// In en, this message translates to:
  /// **'HSK Level 2'**
  String get hskLevel2;

  /// No description provided for @hskLevel3.
  ///
  /// In en, this message translates to:
  /// **'HSK Level 3'**
  String get hskLevel3;

  /// No description provided for @hskLevel4.
  ///
  /// In en, this message translates to:
  /// **'HSK Level 4'**
  String get hskLevel4;

  /// No description provided for @hskLevel5.
  ///
  /// In en, this message translates to:
  /// **'HSK Level 5'**
  String get hskLevel5;

  /// No description provided for @hskLevel6.
  ///
  /// In en, this message translates to:
  /// **'HSK Level 6'**
  String get hskLevel6;

  /// No description provided for @generalVocabulary.
  ///
  /// In en, this message translates to:
  /// **'General Vocabulary'**
  String get generalVocabulary;

  /// No description provided for @cardsRequireAttention.
  ///
  /// In en, this message translates to:
  /// **'cards require attention.'**
  String get cardsRequireAttention;

  /// No description provided for @begin.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get begin;

  /// No description provided for @poweredByAi.
  ///
  /// In en, this message translates to:
  /// **'Powered by advanced AI. Seamless real-time translation for any scenario.'**
  String get poweredByAi;

  /// No description provided for @downloadingModel.
  ///
  /// In en, this message translates to:
  /// **'Downloading model...'**
  String get downloadingModel;

  /// No description provided for @soon.
  ///
  /// In en, this message translates to:
  /// **'SOON'**
  String get soon;

  /// No description provided for @installed.
  ///
  /// In en, this message translates to:
  /// **'INSTALLED'**
  String get installed;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get premium;

  /// No description provided for @coreModule.
  ///
  /// In en, this message translates to:
  /// **'CORE MODULE'**
  String get coreModule;

  /// No description provided for @step6Context.
  ///
  /// In en, this message translates to:
  /// **'STEP 6: CONTEXT'**
  String get step6Context;

  /// No description provided for @tapBuildingBlocksTo.
  ///
  /// In en, this message translates to:
  /// **'Tap building blocks to explore their origin.'**
  String get tapBuildingBlocksTo;

  /// No description provided for @initiateRadicalSequence.
  ///
  /// In en, this message translates to:
  /// **'INITIATE RADICAL SEQUENCE'**
  String get initiateRadicalSequence;

  /// No description provided for @holdToTalk.
  ///
  /// In en, this message translates to:
  /// **'Hold to Talk'**
  String get holdToTalk;

  /// No description provided for @customScenario.
  ///
  /// In en, this message translates to:
  /// **'Custom Scenario'**
  String get customScenario;

  /// No description provided for @voiceCall.
  ///
  /// In en, this message translates to:
  /// **'Voice Call'**
  String get voiceCall;

  /// No description provided for @pronunciation.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation'**
  String get pronunciation;

  /// No description provided for @selectAScenarioTo.
  ///
  /// In en, this message translates to:
  /// **'Select a scenario to practice your spoken Mandarin. The Scholar will grade your tones and clarity.'**
  String get selectAScenarioTo;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @createYourScenario.
  ///
  /// In en, this message translates to:
  /// **'Create Your Scenario'**
  String get createYourScenario;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @scholarsVerdict.
  ///
  /// In en, this message translates to:
  /// **'SCHOLAR\'S VERDICT'**
  String get scholarsVerdict;

  /// No description provided for @completeReview.
  ///
  /// In en, this message translates to:
  /// **'Complete Review'**
  String get completeReview;

  /// No description provided for @conversationReview.
  ///
  /// In en, this message translates to:
  /// **'CONVERSATION REVIEW'**
  String get conversationReview;

  /// No description provided for @linguisticAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Linguistic Analysis'**
  String get linguisticAnalysis;

  /// No description provided for @examplesInHsk1.
  ///
  /// In en, this message translates to:
  /// **'EXAMPLES IN HSK 1'**
  String get examplesInHsk1;

  /// No description provided for @characterReference.
  ///
  /// In en, this message translates to:
  /// **'Character Reference'**
  String get characterReference;

  /// No description provided for @askTutor.
  ///
  /// In en, this message translates to:
  /// **'Ask Tutor'**
  String get askTutor;

  /// No description provided for @addToStudyDeck.
  ///
  /// In en, this message translates to:
  /// **'Add to Study Deck'**
  String get addToStudyDeck;

  /// No description provided for @startPractice.
  ///
  /// In en, this message translates to:
  /// **'START PRACTICE'**
  String get startPractice;

  /// No description provided for @noOtherHsk1.
  ///
  /// In en, this message translates to:
  /// **'No other HSK 1 characters use this radical.'**
  String get noOtherHsk1;

  /// No description provided for @couldNotLoadAi.
  ///
  /// In en, this message translates to:
  /// **'Could not load AI context. (Rate limit or network error)\\nTap the refresh button below to try again later.'**
  String get couldNotLoadAi;

  /// No description provided for @noAvailableCardsFound.
  ///
  /// In en, this message translates to:
  /// **'No available cards found.'**
  String get noAvailableCardsFound;

  /// No description provided for @addCards.
  ///
  /// In en, this message translates to:
  /// **'Add Cards'**
  String get addCards;

  /// No description provided for @removeCard.
  ///
  /// In en, this message translates to:
  /// **'Remove Card'**
  String get removeCard;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @story.
  ///
  /// In en, this message translates to:
  /// **'Story'**
  String get story;

  /// No description provided for @thisDeckIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'This deck is empty.'**
  String get thisDeckIsEmpty;

  /// No description provided for @tapTheAddCards.
  ///
  /// In en, this message translates to:
  /// **'Tap the Add Cards button!'**
  String get tapTheAddCards;

  /// No description provided for @noCardsFound.
  ///
  /// In en, this message translates to:
  /// **'No cards found.'**
  String get noCardsFound;

  /// No description provided for @addCardsToSee.
  ///
  /// In en, this message translates to:
  /// **'Add cards to see statistics.'**
  String get addCardsToSee;

  /// No description provided for @aiGenerated.
  ///
  /// In en, this message translates to:
  /// **'AI Generated'**
  String get aiGenerated;

  /// No description provided for @allCardsCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'All cards caught up! Great job.'**
  String get allCardsCaughtUp;

  /// No description provided for @latestDiscoveries.
  ///
  /// In en, this message translates to:
  /// **'Latest Discoveries'**
  String get latestDiscoveries;

  /// No description provided for @noCharactersInLexicon.
  ///
  /// In en, this message translates to:
  /// **'No characters in lexicon yet.'**
  String get noCharactersInLexicon;

  /// No description provided for @yourBookshelf.
  ///
  /// In en, this message translates to:
  /// **'Your Bookshelf'**
  String get yourBookshelf;

  /// No description provided for @text_1782026184579.
  ///
  /// In en, this message translates to:
  /// **'字'**
  String get text_1782026184579;

  /// No description provided for @searchYourDictionary.
  ///
  /// In en, this message translates to:
  /// **'Search your dictionary...'**
  String get searchYourDictionary;

  /// No description provided for @saveCard.
  ///
  /// In en, this message translates to:
  /// **'Save Card'**
  String get saveCard;

  /// No description provided for @noCharactersFound.
  ///
  /// In en, this message translates to:
  /// **'No characters found.'**
  String get noCharactersFound;

  /// No description provided for @radicalsIndex.
  ///
  /// In en, this message translates to:
  /// **'Radicals Index'**
  String get radicalsIndex;

  /// No description provided for @masteringRadicalsIsThe.
  ///
  /// In en, this message translates to:
  /// **'Mastering radicals is the key to unlocking thousands of Hanzi. Select a radical to see all characters that use it.'**
  String get masteringRadicalsIsThe;

  /// No description provided for @noRadicalsFound.
  ///
  /// In en, this message translates to:
  /// **'No radicals found.'**
  String get noRadicalsFound;

  /// No description provided for @yourDrawing.
  ///
  /// In en, this message translates to:
  /// **'Your Drawing'**
  String get yourDrawing;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @rateYourRecall.
  ///
  /// In en, this message translates to:
  /// **'Rate your recall'**
  String get rateYourRecall;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @reportBugsOrRequest.
  ///
  /// In en, this message translates to:
  /// **'Report bugs or request features'**
  String get reportBugsOrRequest;

  /// No description provided for @allDataHasBeen.
  ///
  /// In en, this message translates to:
  /// **'All data has been wiped.'**
  String get allDataHasBeen;

  /// No description provided for @hanziMasterV100.
  ///
  /// In en, this message translates to:
  /// **'SinoSpark v1.0.0'**
  String get hanziMasterV100;

  /// No description provided for @myProgress.
  ///
  /// In en, this message translates to:
  /// **'My Progress'**
  String get myProgress;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @aiStory.
  ///
  /// In en, this message translates to:
  /// **'AI Story'**
  String get aiStory;

  /// No description provided for @usingYourDecksVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Using your deck\'s vocabulary'**
  String get usingYourDecksVocabulary;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @translate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translate;

  /// No description provided for @pinyin.
  ///
  /// In en, this message translates to:
  /// **'Pinyin'**
  String get pinyin;

  /// No description provided for @fullTranslation.
  ///
  /// In en, this message translates to:
  /// **'Full Translation'**
  String get fullTranslation;

  /// No description provided for @geminiFlashIsStructuring.
  ///
  /// In en, this message translates to:
  /// **'Crafting your custom story...'**
  String get geminiFlashIsStructuring;

  /// No description provided for @aiDeckGenerator.
  ///
  /// In en, this message translates to:
  /// **'AI Deck Generator'**
  String get aiDeckGenerator;

  /// No description provided for @whatDoYouWant.
  ///
  /// In en, this message translates to:
  /// **'What do you want to learn?'**
  String get whatDoYouWant;

  /// No description provided for @targetDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Target Difficulty'**
  String get targetDifficulty;

  /// No description provided for @focusArea.
  ///
  /// In en, this message translates to:
  /// **'Focus Area'**
  String get focusArea;

  /// No description provided for @specificContextOrTone.
  ///
  /// In en, this message translates to:
  /// **'Specific Context or Tone (Optional)'**
  String get specificContextOrTone;

  /// No description provided for @numberOfCards.
  ///
  /// In en, this message translates to:
  /// **'Number of Cards'**
  String get numberOfCards;

  /// No description provided for @generateDeck.
  ///
  /// In en, this message translates to:
  /// **'Generate Deck'**
  String get generateDeck;

  /// No description provided for @aiGrammarExplanation.
  ///
  /// In en, this message translates to:
  /// **'AI Grammar Explanation'**
  String get aiGrammarExplanation;

  /// No description provided for @scholarsDesk.
  ///
  /// In en, this message translates to:
  /// **'Scholar\'s Desk'**
  String get scholarsDesk;

  /// No description provided for @chooseADeck.
  ///
  /// In en, this message translates to:
  /// **'Choose a Deck'**
  String get chooseADeck;

  /// No description provided for @whereWouldYouLike.
  ///
  /// In en, this message translates to:
  /// **'Where would you like to save this character?'**
  String get whereWouldYouLike;

  /// No description provided for @addToDefaultStudy.
  ///
  /// In en, this message translates to:
  /// **'Add to Default Study Deck'**
  String get addToDefaultStudy;

  /// No description provided for @ifOffItsOnly.
  ///
  /// In en, this message translates to:
  /// **'If off, it\'s only saved to the global Dictionary'**
  String get ifOffItsOnly;

  /// No description provided for @saveToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Save to Library'**
  String get saveToLibrary;

  /// No description provided for @pleaseEnterValidChinese.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid Chinese characters'**
  String get pleaseEnterValidChinese;

  /// No description provided for @reviewAiCard.
  ///
  /// In en, this message translates to:
  /// **'Review AI Card'**
  String get reviewAiCard;

  /// No description provided for @pleaseDoublecheckTheAis.
  ///
  /// In en, this message translates to:
  /// **'Please double-check the AI\'s output below. Feel free to tweak the pinyin or definition before saving it to your permanent library.'**
  String get pleaseDoublecheckTheAis;

  /// No description provided for @alreadyInYourLibrary.
  ///
  /// In en, this message translates to:
  /// **'Already in your Library!'**
  String get alreadyInYourLibrary;

  /// No description provided for @meaningInContext.
  ///
  /// In en, this message translates to:
  /// **'Meaning in Context'**
  String get meaningInContext;

  /// No description provided for @explainGrammar.
  ///
  /// In en, this message translates to:
  /// **'Explain Grammar'**
  String get explainGrammar;

  /// No description provided for @addToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Add to Library'**
  String get addToLibrary;

  /// No description provided for @masterYourMandarinPronunciation.
  ///
  /// In en, this message translates to:
  /// **'Master your Mandarin pronunciation by mimicking native speech in real-time.'**
  String get masterYourMandarinPronunciation;

  /// No description provided for @startSession.
  ///
  /// In en, this message translates to:
  /// **'START SESSION'**
  String get startSession;

  /// No description provided for @sessionHistory.
  ///
  /// In en, this message translates to:
  /// **'Session History'**
  String get sessionHistory;

  /// No description provided for @noSavedSessions.
  ///
  /// In en, this message translates to:
  /// **'No saved sessions.'**
  String get noSavedSessions;

  /// No description provided for @aiBreakdown.
  ///
  /// In en, this message translates to:
  /// **'AI Breakdown'**
  String get aiBreakdown;

  /// No description provided for @sessionDetails.
  ///
  /// In en, this message translates to:
  /// **'Session Details'**
  String get sessionDetails;

  /// No description provided for @partner.
  ///
  /// In en, this message translates to:
  /// **'Partner (中文)'**
  String get partner;

  /// No description provided for @youEnglish.
  ///
  /// In en, this message translates to:
  /// **'You (English)'**
  String get youEnglish;

  /// No description provided for @noTranscriptToSave.
  ///
  /// In en, this message translates to:
  /// **'No transcript to save!'**
  String get noTranscriptToSave;

  /// No description provided for @sessionSaved.
  ///
  /// In en, this message translates to:
  /// **'Session saved!'**
  String get sessionSaved;

  /// No description provided for @realtimeBidirectionalTranslationSpeak.
  ///
  /// In en, this message translates to:
  /// **'Real-time bidirectional translation. Speak English or Mandarin, and it will instantly translate for you and your partner.'**
  String get realtimeBidirectionalTranslationSpeak;

  /// No description provided for @text_1782026184665.
  ///
  /// In en, this message translates to:
  /// **'录音中'**
  String get text_1782026184665;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get recording;

  /// No description provided for @yourSilentCompanionListen.
  ///
  /// In en, this message translates to:
  /// **'Your silent companion. Listen to Mandarin, and hear the English translation instantly.'**
  String get yourSilentCompanionListen;

  /// No description provided for @startListening.
  ///
  /// In en, this message translates to:
  /// **'START LISTENING'**
  String get startListening;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @independentStars.
  ///
  /// In en, this message translates to:
  /// **'INDEPENDENT STARS'**
  String get independentStars;

  /// No description provided for @notEveryCharacterHas.
  ///
  /// In en, this message translates to:
  /// **'Not every character has a parent Radical. Some are unique pictographs or stand alone.'**
  String get notEveryCharacterHas;

  /// No description provided for @onTheMapWe.
  ///
  /// In en, this message translates to:
  /// **'On the map, we group these independent characters into CONSTELLATIONS (✨).'**
  String get onTheMapWe;

  /// No description provided for @iUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I UNDERSTAND'**
  String get iUnderstand;

  /// No description provided for @whatAreRadicals.
  ///
  /// In en, this message translates to:
  /// **'WHAT ARE RADICALS?'**
  String get whatAreRadicals;

  /// No description provided for @hanziAreBuiltFrom.
  ///
  /// In en, this message translates to:
  /// **'Hanzi are built from building blocks called RADICALS.\\n\\nThey give the character its core meaning or theme.'**
  String get hanziAreBuiltFrom;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueText;

  /// No description provided for @hanziAreNotJust.
  ///
  /// In en, this message translates to:
  /// **'Hanzi are not just letters. They are pictures frozen in time.\\n\\nTo master them, you must learn to trace their flow.'**
  String get hanziAreNotJust;

  /// No description provided for @iAmReady.
  ///
  /// In en, this message translates to:
  /// **'I AM READY'**
  String get iAmReady;

  /// No description provided for @youAreAScholar.
  ///
  /// In en, this message translates to:
  /// **'YOU ARE A SCHOLAR'**
  String get youAreAScholar;

  /// No description provided for @theGalaxyMapAwaitsnmaster.
  ///
  /// In en, this message translates to:
  /// **'The Galaxy Map awaits.\\nMaster the Suns (Radicals) to unlock the Planets (Characters).'**
  String get theGalaxyMapAwaitsnmaster;

  /// No description provided for @enterTheScroll.
  ///
  /// In en, this message translates to:
  /// **'ENTER THE SCROLL'**
  String get enterTheScroll;

  /// No description provided for @openingTheOriginScroll.
  ///
  /// In en, this message translates to:
  /// **'Opening the Origin Scroll...'**
  String get openingTheOriginScroll;

  /// No description provided for @text_1782026184670.
  ///
  /// In en, this message translates to:
  /// **'+'**
  String get text_1782026184670;

  /// No description provided for @theScholarsEdition.
  ///
  /// In en, this message translates to:
  /// **'The Scholar\'s Edition'**
  String get theScholarsEdition;

  /// No description provided for @weArePreparingThe.
  ///
  /// In en, this message translates to:
  /// **'We are preparing the Scholar\'s Edition for launch.'**
  String get weArePreparingThe;

  /// No description provided for @devBypassUnlockNow.
  ///
  /// In en, this message translates to:
  /// **'DEV BYPASS: UNLOCK NOW'**
  String get devBypassUnlockNow;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @welcomeScholarTheScroll.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Scholar. The scroll is fully open to you.'**
  String get welcomeScholarTheScroll;

  /// No description provided for @purchasesRestoredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored successfully.'**
  String get purchasesRestoredSuccessfully;

  /// No description provided for @noPreviousPurchasesFound.
  ///
  /// In en, this message translates to:
  /// **'No previous purchases found on this account.'**
  String get noPreviousPurchasesFound;

  /// No description provided for @unlockTheFullPotential.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full potential of your journey. One time purchase, yours forever.'**
  String get unlockTheFullPotential;

  /// No description provided for @universalScanner.
  ///
  /// In en, this message translates to:
  /// **'Universal Scanner'**
  String get universalScanner;

  /// No description provided for @noChineseCharactersFound.
  ///
  /// In en, this message translates to:
  /// **'No Chinese characters found in the image.'**
  String get noChineseCharactersFound;

  /// No description provided for @addedNewCharactersTo.
  ///
  /// In en, this message translates to:
  /// **'Added new characters to your library!'**
  String get addedNewCharactersTo;

  /// No description provided for @extractingTextAndObjects.
  ///
  /// In en, this message translates to:
  /// **'Extracting text and objects...'**
  String get extractingTextAndObjects;

  /// No description provided for @scanATextbookSign.
  ///
  /// In en, this message translates to:
  /// **'Scan a textbook, sign, or object to extract Chinese characters.'**
  String get scanATextbookSign;

  /// No description provided for @extractedText.
  ///
  /// In en, this message translates to:
  /// **'Extracted Text'**
  String get extractedText;

  /// No description provided for @useText.
  ///
  /// In en, this message translates to:
  /// **'Use Text'**
  String get useText;

  /// No description provided for @noMatchingDictionaryEntries.
  ///
  /// In en, this message translates to:
  /// **'No matching dictionary entries found.'**
  String get noMatchingDictionaryEntries;

  /// No description provided for @quizComplete.
  ///
  /// In en, this message translates to:
  /// **'Quiz Complete!'**
  String get quizComplete;

  /// No description provided for @returnToCourse.
  ///
  /// In en, this message translates to:
  /// **'Return to Course'**
  String get returnToCourse;

  /// No description provided for @notEnoughCardsFor.
  ///
  /// In en, this message translates to:
  /// **'Not enough cards for a quiz! Need at least 4.'**
  String get notEnoughCardsFor;

  /// No description provided for @creatorMode.
  ///
  /// In en, this message translates to:
  /// **'Creator Mode'**
  String get creatorMode;

  /// No description provided for @noStoriesFoundMatching.
  ///
  /// In en, this message translates to:
  /// **'No stories found matching your search.'**
  String get noStoriesFoundMatching;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @generatingStoryViaDeepseek.
  ///
  /// In en, this message translates to:
  /// **'Generating story via DeepSeek...'**
  String get generatingStoryViaDeepseek;

  /// No description provided for @storySavedToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Story saved to Library!'**
  String get storySavedToLibrary;

  /// No description provided for @storyNotFound.
  ///
  /// In en, this message translates to:
  /// **'Story not found.'**
  String get storyNotFound;

  /// No description provided for @targetHskLevel.
  ///
  /// In en, this message translates to:
  /// **'Target HSK Level'**
  String get targetHskLevel;

  /// No description provided for @wedLoveToHear.
  ///
  /// In en, this message translates to:
  /// **'We\'d love to hear from you!'**
  String get wedLoveToHear;

  /// No description provided for @whetherYouveFoundA.
  ///
  /// In en, this message translates to:
  /// **'Whether you\'ve found a bug, have a feature request, or just want to say hi, your feedback helps us improve SinoSpark.'**
  String get whetherYouveFoundA;

  /// No description provided for @pointYourCameraAt.
  ///
  /// In en, this message translates to:
  /// **'Point your camera at objects'**
  String get pointYourCameraAt;

  /// No description provided for @reviewAddToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Review & Add to Library'**
  String get reviewAddToLibrary;

  /// No description provided for @hideStrokeGuideStreak.
  ///
  /// In en, this message translates to:
  /// **'Hide stroke guide at streak: {streak}'**
  String hideStrokeGuideStreak(Object streak);

  /// No description provided for @inkPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} Ink Points'**
  String inkPoints(Object points);

  /// No description provided for @speechRateMultiplier.
  ///
  /// In en, this message translates to:
  /// **'{rate}x'**
  String speechRateMultiplier(Object rate);

  /// No description provided for @animationSpeedMultiplier.
  ///
  /// In en, this message translates to:
  /// **'{rate}x'**
  String animationSpeedMultiplier(Object rate);

  /// No description provided for @supportAndFeedback.
  ///
  /// In en, this message translates to:
  /// **'Support & Feedback'**
  String get supportAndFeedback;

  /// No description provided for @reportBug.
  ///
  /// In en, this message translates to:
  /// **'Report a Bug'**
  String get reportBug;

  /// No description provided for @suggestFeature.
  ///
  /// In en, this message translates to:
  /// **'Suggest a Feature'**
  String get suggestFeature;

  /// No description provided for @generalFeedback.
  ///
  /// In en, this message translates to:
  /// **'General Feedback'**
  String get generalFeedback;

  /// No description provided for @pleaseDrawSomethingFirst.
  ///
  /// In en, this message translates to:
  /// **'Please draw something first'**
  String get pleaseDrawSomethingFirst;

  /// No description provided for @drawThisCharacter.
  ///
  /// In en, this message translates to:
  /// **'Draw this character:'**
  String get drawThisCharacter;

  /// No description provided for @followGuideStroke.
  ///
  /// In en, this message translates to:
  /// **'Follow the blue guide to draw stroke {current} of {total}'**
  String followGuideStroke(Object current, Object total);

  /// No description provided for @skipCurrentStroke.
  ///
  /// In en, this message translates to:
  /// **'Skip Current Stroke'**
  String get skipCurrentStroke;

  /// No description provided for @submitDrawing.
  ///
  /// In en, this message translates to:
  /// **'Submit Drawing'**
  String get submitDrawing;

  /// No description provided for @addedToDeck.
  ///
  /// In en, this message translates to:
  /// **'Added {hanzi} to {deckName}'**
  String addedToDeck(Object deckName, Object hanzi);

  /// No description provided for @removedFromDeck.
  ///
  /// In en, this message translates to:
  /// **'Removed {hanzi} from deck'**
  String removedFromDeck(Object hanzi);

  /// No description provided for @skippedNoStrokeData.
  ///
  /// In en, this message translates to:
  /// **'Skipped \"{hanzi}\" - No stroke data available for this AI character.'**
  String skippedNoStrokeData(Object hanzi);

  /// No description provided for @startingSession.
  ///
  /// In en, this message translates to:
  /// **'Starting session...'**
  String get startingSession;

  /// No description provided for @masterBuildingBlocks.
  ///
  /// In en, this message translates to:
  /// **'Master the building blocks of Hanzi'**
  String get masterBuildingBlocks;

  /// No description provided for @totalWords.
  ///
  /// In en, this message translates to:
  /// **'Total Words'**
  String get totalWords;

  /// No description provided for @newInk.
  ///
  /// In en, this message translates to:
  /// **'New Ink'**
  String get newInk;

  /// No description provided for @learningStatus.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get learningStatus;

  /// No description provided for @masteredStatus.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get masteredStatus;

  /// No description provided for @libraryMastery.
  ///
  /// In en, this message translates to:
  /// **'Library Mastery'**
  String get libraryMastery;

  /// No description provided for @accuracyByMode.
  ///
  /// In en, this message translates to:
  /// **'Accuracy by Mode'**
  String get accuracyByMode;

  /// No description provided for @upcomingReviews.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Reviews (Next 7 Days)'**
  String get upcomingReviews;

  /// No description provided for @culturalReadingRoom.
  ///
  /// In en, this message translates to:
  /// **'文化书房 (Cultural Reading Room)'**
  String get culturalReadingRoom;

  /// No description provided for @storyTitleHsk.
  ///
  /// In en, this message translates to:
  /// **'{title} (HSK {level})'**
  String storyTitleHsk(Object level, Object title);

  /// No description provided for @pleaseEnterTopic.
  ///
  /// In en, this message translates to:
  /// **'Please enter a topic'**
  String get pleaseEnterTopic;

  /// No description provided for @createdDeckCards.
  ///
  /// In en, this message translates to:
  /// **'Created {name} with {count} cards!'**
  String createdDeckCards(Object count, Object name);

  /// No description provided for @gradeResult.
  ///
  /// In en, this message translates to:
  /// **'Grade: {grade}'**
  String gradeResult(Object grade);

  /// No description provided for @listeningMode.
  ///
  /// In en, this message translates to:
  /// **'Listening Mode'**
  String get listeningMode;

  /// No description provided for @readingMode.
  ///
  /// In en, this message translates to:
  /// **'Reading Mode'**
  String get readingMode;

  /// No description provided for @recallMode.
  ///
  /// In en, this message translates to:
  /// **'Recall Mode'**
  String get recallMode;

  /// No description provided for @speakingMode.
  ///
  /// In en, this message translates to:
  /// **'Speaking Mode'**
  String get speakingMode;

  /// No description provided for @aiMemoryHook.
  ///
  /// In en, this message translates to:
  /// **'AI Memory Hook'**
  String get aiMemoryHook;

  /// No description provided for @exampleSentences.
  ///
  /// In en, this message translates to:
  /// **'Example Sentences'**
  String get exampleSentences;

  /// No description provided for @ghostCharacters.
  ///
  /// In en, this message translates to:
  /// **'Ghost Characters'**
  String get ghostCharacters;

  /// No description provided for @commonWords.
  ///
  /// In en, this message translates to:
  /// **'Common Words'**
  String get commonWords;

  /// No description provided for @personalNotes.
  ///
  /// In en, this message translates to:
  /// **'Personal Notes'**
  String get personalNotes;

  /// No description provided for @addPersonalNotes.
  ///
  /// In en, this message translates to:
  /// **'Add your own mnemonics or notes here...'**
  String get addPersonalNotes;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @arLens.
  ///
  /// In en, this message translates to:
  /// **'AR Lens'**
  String get arLens;

  /// No description provided for @addedCharToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Added {char} to Library'**
  String addedCharToLibrary(Object char);

  /// No description provided for @scoreText.
  ///
  /// In en, this message translates to:
  /// **'score'**
  String get scoreText;

  /// No description provided for @searchDictionaryHint.
  ///
  /// In en, this message translates to:
  /// **'Search character, pinyin, or meaning...'**
  String get searchDictionaryHint;

  /// No description provided for @searchDeckHint.
  ///
  /// In en, this message translates to:
  /// **'Search character, pinyin...'**
  String get searchDeckHint;

  /// No description provided for @localRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Local Restaurant'**
  String get localRestaurant;

  /// No description provided for @taxiToAirport.
  ///
  /// In en, this message translates to:
  /// **'Taxi to Airport'**
  String get taxiToAirport;

  /// No description provided for @silkMarketHaggling.
  ///
  /// In en, this message translates to:
  /// **'Silk Market Haggling'**
  String get silkMarketHaggling;

  /// No description provided for @medicalClinic.
  ///
  /// In en, this message translates to:
  /// **'Medical Clinic'**
  String get medicalClinic;

  /// No description provided for @meetingAFriend.
  ///
  /// In en, this message translates to:
  /// **'Meeting a Friend'**
  String get meetingAFriend;

  /// No description provided for @jobInterview.
  ///
  /// In en, this message translates to:
  /// **'Job Interview'**
  String get jobInterview;

  /// No description provided for @searchRadicalsHint.
  ///
  /// In en, this message translates to:
  /// **'Search radicals (e.g. Water, 氵)'**
  String get searchRadicalsHint;

  /// No description provided for @definition.
  ///
  /// In en, this message translates to:
  /// **'Definition'**
  String get definition;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'UNDO'**
  String get undo;

  /// No description provided for @hanziMaster.
  ///
  /// In en, this message translates to:
  /// **'SinoSpark'**
  String get hanziMaster;

  /// No description provided for @unlockForever.
  ///
  /// In en, this message translates to:
  /// **'Unlock Forever - \$9.99'**
  String get unlockForever;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clearChat.
  ///
  /// In en, this message translates to:
  /// **'Clear chat'**
  String get clearChat;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeMessage;

  /// No description provided for @addedToLibrary.
  ///
  /// In en, this message translates to:
  /// **'Added \'{hanzi}\' to your Library'**
  String addedToLibrary(Object hanzi);

  /// No description provided for @generateNewStory.
  ///
  /// In en, this message translates to:
  /// **'Generate New Story'**
  String get generateNewStory;

  /// No description provided for @failedToGenerateStory.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate story:\\n{error}'**
  String failedToGenerateStory(Object error);

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @scanText.
  ///
  /// In en, this message translates to:
  /// **'Scan Text'**
  String get scanText;

  /// No description provided for @createMagic.
  ///
  /// In en, this message translates to:
  /// **'Create Magic'**
  String get createMagic;

  /// No description provided for @learning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get learning;

  /// No description provided for @upcomingReviews7Days.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Reviews (Next 7 Days)'**
  String get upcomingReviews7Days;

  /// No description provided for @askFollowUpQuestion.
  ///
  /// In en, this message translates to:
  /// **'Ask a follow-up question...'**
  String get askFollowUpQuestion;

  /// No description provided for @pasteScanToSimplify.
  ///
  /// In en, this message translates to:
  /// **'Paste or scan Chinese text to simplify'**
  String get pasteScanToSimplify;

  /// No description provided for @searchStoriesHint.
  ///
  /// In en, this message translates to:
  /// **'Search stories by title or tags (e.g. mythology, travel)'**
  String get searchStoriesHint;

  /// No description provided for @importAll.
  ///
  /// In en, this message translates to:
  /// **'Import All'**
  String get importAll;

  /// No description provided for @ascendAll.
  ///
  /// In en, this message translates to:
  /// **'Ascend All'**
  String get ascendAll;

  /// No description provided for @startAscension.
  ///
  /// In en, this message translates to:
  /// **'Start Ascension'**
  String get startAscension;

  /// No description provided for @scenarioLocalRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Local Restaurant'**
  String get scenarioLocalRestaurant;

  /// No description provided for @scenarioLocalRestaurantDesc.
  ///
  /// In en, this message translates to:
  /// **'Practice ordering dishes and asking for recommendations.'**
  String get scenarioLocalRestaurantDesc;

  /// No description provided for @scenarioTaxiAirport.
  ///
  /// In en, this message translates to:
  /// **'Taxi to Airport'**
  String get scenarioTaxiAirport;

  /// No description provided for @scenarioTaxiAirportDesc.
  ///
  /// In en, this message translates to:
  /// **'Tell the driver your destination and discuss the traffic.'**
  String get scenarioTaxiAirportDesc;

  /// No description provided for @scenarioSilkMarket.
  ///
  /// In en, this message translates to:
  /// **'Silk Market Haggling'**
  String get scenarioSilkMarket;

  /// No description provided for @scenarioSilkMarketDesc.
  ///
  /// In en, this message translates to:
  /// **'Try to get a better price for a souvenir.'**
  String get scenarioSilkMarketDesc;

  /// No description provided for @scenarioMedicalClinic.
  ///
  /// In en, this message translates to:
  /// **'Medical Clinic'**
  String get scenarioMedicalClinic;

  /// No description provided for @scenarioMedicalClinicDesc.
  ///
  /// In en, this message translates to:
  /// **'Explain your symptoms to a traditional doctor.'**
  String get scenarioMedicalClinicDesc;

  /// No description provided for @scenarioMeetingFriend.
  ///
  /// In en, this message translates to:
  /// **'Meeting a Friend'**
  String get scenarioMeetingFriend;

  /// No description provided for @scenarioMeetingFriendDesc.
  ///
  /// In en, this message translates to:
  /// **'Introduce yourself and make small talk.'**
  String get scenarioMeetingFriendDesc;

  /// No description provided for @scenarioJobInterview.
  ///
  /// In en, this message translates to:
  /// **'Job Interview'**
  String get scenarioJobInterview;

  /// No description provided for @scenarioJobInterviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Apply for a role at a tech company in Shanghai.'**
  String get scenarioJobInterviewDesc;

  /// No description provided for @createCustomScenario.
  ///
  /// In en, this message translates to:
  /// **'Create Custom Scenario'**
  String get createCustomScenario;

  /// No description provided for @customScenarioTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Title (e.g. Wedding Reception)'**
  String get customScenarioTitleHint;

  /// No description provided for @customScenarioDescHint.
  ///
  /// In en, this message translates to:
  /// **'Description (Context)'**
  String get customScenarioDescHint;

  /// No description provided for @customScenarioPersonaHint.
  ///
  /// In en, this message translates to:
  /// **'AI Persona (e.g. A curious coworker)'**
  String get customScenarioPersonaHint;

  /// No description provided for @customScenarioDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get customScenarioDifficulty;

  /// No description provided for @createAction.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @mythsAndLegends.
  ///
  /// In en, this message translates to:
  /// **'Myths & Legends'**
  String get mythsAndLegends;

  /// No description provided for @historyAndCulture.
  ///
  /// In en, this message translates to:
  /// **'History & Culture'**
  String get historyAndCulture;

  /// No description provided for @idiomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Idioms (成语)'**
  String get idiomsTitle;

  /// No description provided for @theMonkeyKing.
  ///
  /// In en, this message translates to:
  /// **'The Monkey King'**
  String get theMonkeyKing;

  /// No description provided for @theMonkeyKingDesc.
  ///
  /// In en, this message translates to:
  /// **'Sun Wukong (Journey to the West)'**
  String get theMonkeyKingDesc;

  /// No description provided for @huaMulan.
  ///
  /// In en, this message translates to:
  /// **'Hua Mulan'**
  String get huaMulan;

  /// No description provided for @huaMulanDesc.
  ///
  /// In en, this message translates to:
  /// **'Hua Mulan joining the army instead of her father'**
  String get huaMulanDesc;

  /// No description provided for @confuciusTitle.
  ///
  /// In en, this message translates to:
  /// **'Confucius'**
  String get confuciusTitle;

  /// No description provided for @confuciusDesc.
  ///
  /// In en, this message translates to:
  /// **'The life and teachings of Confucius'**
  String get confuciusDesc;

  /// No description provided for @theGreatWall.
  ///
  /// In en, this message translates to:
  /// **'The Great Wall'**
  String get theGreatWall;

  /// No description provided for @theGreatWallDesc.
  ///
  /// In en, this message translates to:
  /// **'Building the Great Wall of China'**
  String get theGreatWallDesc;

  /// No description provided for @generateTopic.
  ///
  /// In en, this message translates to:
  /// **'Generate Topic'**
  String get generateTopic;

  /// No description provided for @simplifyText.
  ///
  /// In en, this message translates to:
  /// **'Simplify Text'**
  String get simplifyText;

  /// No description provided for @topicHint.
  ///
  /// In en, this message translates to:
  /// **'Topic (e.g. Aliens in Beijing)'**
  String get topicHint;

  /// No description provided for @tagsHint.
  ///
  /// In en, this message translates to:
  /// **'Tags (comma separated, optional)'**
  String get tagsHint;

  /// No description provided for @speakWithMasterLin.
  ///
  /// In en, this message translates to:
  /// **'Speak with Master Lin'**
  String get speakWithMasterLin;

  /// No description provided for @masterLinGreeting.
  ///
  /// In en, this message translates to:
  /// **'Greetings, student. The ink is ready. What character or phrase shall we examine today?'**
  String get masterLinGreeting;

  /// No description provided for @typeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeYourMessage;

  /// No description provided for @theMainLibrary.
  ///
  /// In en, this message translates to:
  /// **'The Main Library'**
  String get theMainLibrary;

  /// No description provided for @hsk1Foundation.
  ///
  /// In en, this message translates to:
  /// **'HSK 1: Foundation'**
  String get hsk1Foundation;

  /// No description provided for @hsk2Elementary.
  ///
  /// In en, this message translates to:
  /// **'HSK 2: Elementary'**
  String get hsk2Elementary;

  /// No description provided for @hsk3Intermediate.
  ///
  /// In en, this message translates to:
  /// **'HSK 3: Intermediate'**
  String get hsk3Intermediate;

  /// No description provided for @inDeckCheck.
  ///
  /// In en, this message translates to:
  /// **'In Deck ✓'**
  String get inDeckCheck;

  /// No description provided for @addToDeckPlus.
  ///
  /// In en, this message translates to:
  /// **'+ Add to Deck'**
  String get addToDeckPlus;

  /// No description provided for @openCardArrow.
  ///
  /// In en, this message translates to:
  /// **'Open Card →'**
  String get openCardArrow;

  /// No description provided for @pronunciationPartial.
  ///
  /// In en, this message translates to:
  /// **'Tone Imprecise'**
  String get pronunciationPartial;

  /// No description provided for @pronunciationWrong.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get pronunciationWrong;

  /// No description provided for @toneExpected.
  ///
  /// In en, this message translates to:
  /// **'Expected'**
  String get toneExpected;

  /// No description provided for @toneYouSaid.
  ///
  /// In en, this message translates to:
  /// **'You Said'**
  String get toneYouSaid;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get gotIt;

  /// No description provided for @foundNCharacters.
  ///
  /// In en, this message translates to:
  /// **'{count} Characters Found'**
  String foundNCharacters(int count);

  /// No description provided for @lookingUpCharacters.
  ///
  /// In en, this message translates to:
  /// **'Looking up characters…'**
  String get lookingUpCharacters;

  /// No description provided for @practiceAll.
  ///
  /// In en, this message translates to:
  /// **'Practice All'**
  String get practiceAll;

  /// No description provided for @arLensObjects.
  ///
  /// In en, this message translates to:
  /// **'Objects'**
  String get arLensObjects;

  /// No description provided for @arLensText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get arLensText;

  /// No description provided for @arLensDetectedText.
  ///
  /// In en, this message translates to:
  /// **'Detected Text'**
  String get arLensDetectedText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'it',
        'ja',
        'ko',
        'pt',
        'ru',
        'vi'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
