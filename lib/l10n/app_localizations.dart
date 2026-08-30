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

  /// No description provided for @useEnglishDefinitions.
  ///
  /// In en, this message translates to:
  /// **'Use English definitions'**
  String get useEnglishDefinitions;

  /// No description provided for @useEnglishDefinitionsDesc.
  ///
  /// In en, this message translates to:
  /// **'English definitions are generally more accurate and detailed'**
  String get useEnglishDefinitionsDesc;

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
  /// **'Hide stroke guide at streak: (streak)'**
  String get hideStrokeGuideStreak;

  /// No description provided for @inkPoints.
  ///
  /// In en, this message translates to:
  /// **'(points) Ink Points'**
  String get inkPoints;

  /// No description provided for @speechRateMultiplier.
  ///
  /// In en, this message translates to:
  /// **'(rate)x'**
  String get speechRateMultiplier;

  /// No description provided for @animationSpeedMultiplier.
  ///
  /// In en, this message translates to:
  /// **'(rate)x'**
  String get animationSpeedMultiplier;

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
  /// **'Follow the blue guide to draw stroke (current) of (total)'**
  String get followGuideStroke;

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
  /// **'Added (hanzi) to (deckName)'**
  String get addedToDeck;

  /// No description provided for @removedFromDeck.
  ///
  /// In en, this message translates to:
  /// **'Removed (hanzi) from deck'**
  String get removedFromDeck;

  /// No description provided for @skippedNoStrokeData.
  ///
  /// In en, this message translates to:
  /// **'Skipped \"(hanzi)\" - No stroke data available for this AI character.'**
  String get skippedNoStrokeData;

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
  /// **'(title) (HSK (level))'**
  String get storyTitleHsk;

  /// No description provided for @pleaseEnterTopic.
  ///
  /// In en, this message translates to:
  /// **'Please enter a topic'**
  String get pleaseEnterTopic;

  /// No description provided for @createdDeckCards.
  ///
  /// In en, this message translates to:
  /// **'Created (name) with (count) cards!'**
  String get createdDeckCards;

  /// No description provided for @gradeResult.
  ///
  /// In en, this message translates to:
  /// **'Grade: (grade)'**
  String get gradeResult;

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
  /// **'Added (char) to Library'**
  String get addedCharToLibrary;

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
  /// **'Unlock Forever - .99'**
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
  /// **'Added \'(hanzi)\' to your Library'**
  String get addedToLibrary;

  /// No description provided for @generateNewStory.
  ///
  /// In en, this message translates to:
  /// **'Generate New Story'**
  String get generateNewStory;

  /// No description provided for @failedToGenerateStory.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate story:\\n(error)'**
  String get failedToGenerateStory;

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

  /// No description provided for @duration12Min.
  ///
  /// In en, this message translates to:
  /// **'1-2 min'**
  String get duration12Min;

  /// No description provided for @aClassicTangDynastyPoem.
  ///
  /// In en, this message translates to:
  /// **'A classic Tang Dynasty poem'**
  String get aClassicTangDynastyPoem;

  /// No description provided for @aClassicTangDynastyPoemBy.
  ///
  /// In en, this message translates to:
  /// **'A classic Tang Dynasty poem by'**
  String get aClassicTangDynastyPoemBy;

  /// No description provided for @aStructuralComponent.
  ///
  /// In en, this message translates to:
  /// **'A structural component.'**
  String get aStructuralComponent;

  /// No description provided for @addSelectedToDeck.
  ///
  /// In en, this message translates to:
  /// **'Add Selected to Deck'**
  String get addSelectedToDeck;

  /// No description provided for @addTo.
  ///
  /// In en, this message translates to:
  /// **'Add to'**
  String get addTo;

  /// No description provided for @addedHanziToYourLibrary.
  ///
  /// In en, this message translates to:
  /// **'Added \'{hanzi}\' to your Library'**
  String addedHanziToYourLibrary(String hanzi);

  /// No description provided for @adjustFontSize.
  ///
  /// In en, this message translates to:
  /// **'Adjust Font Size'**
  String get adjustFontSize;

  /// No description provided for @againGoodEasyHard.
  ///
  /// In en, this message translates to:
  /// **'⬅️ Again    ➡️ Good    ⬆️ Easy    ⬇️ Hard'**
  String get againGoodEasyHard;

  /// No description provided for @aiAnalysisFailed.
  ///
  /// In en, this message translates to:
  /// **'AI Analysis Failed'**
  String get aiAnalysisFailed;

  /// No description provided for @aiIsThinking.
  ///
  /// In en, this message translates to:
  /// **'AI is thinking...'**
  String get aiIsThinking;

  /// No description provided for @aiSceneAnalysisFailed.
  ///
  /// In en, this message translates to:
  /// **'AI Scene Analysis Failed'**
  String get aiSceneAnalysisFailed;

  /// No description provided for @allLabel.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allLabel;

  /// No description provided for @allPinyin.
  ///
  /// In en, this message translates to:
  /// **'All Pinyin'**
  String get allPinyin;

  /// No description provided for @alreadyHaveAccountSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get alreadyHaveAccountSignIn;

  /// No description provided for @analysisFailed.
  ///
  /// In en, this message translates to:
  /// **'Analysis Failed:'**
  String get analysisFailed;

  /// No description provided for @analyzingClassicalCharacters.
  ///
  /// In en, this message translates to:
  /// **'Analyzing classical characters...'**
  String get analyzingClassicalCharacters;

  /// No description provided for @anatomy.
  ///
  /// In en, this message translates to:
  /// **'Anatomy'**
  String get anatomy;

  /// No description provided for @ancientPhilosophy.
  ///
  /// In en, this message translates to:
  /// **'Ancient Philosophy'**
  String get ancientPhilosophy;

  /// No description provided for @articleSavedToMediaHub.
  ///
  /// In en, this message translates to:
  /// **'Article saved to Media Hub!'**
  String get articleSavedToMediaHub;

  /// No description provided for @askAFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Ask a follow-up...'**
  String get askAFollowUp;

  /// No description provided for @audioPrivacyAndHowThingsWork.
  ///
  /// In en, this message translates to:
  /// **'Audio, privacy, and how things work'**
  String get audioPrivacyAndHowThingsWork;

  /// No description provided for @audiobookPlayer.
  ///
  /// In en, this message translates to:
  /// **'Audiobook Player'**
  String get audiobookPlayer;

  /// No description provided for @audiobookVoice.
  ///
  /// In en, this message translates to:
  /// **'Audiobook Voice'**
  String get audiobookVoice;

  /// No description provided for @auntieMaTown.
  ///
  /// In en, this message translates to:
  /// **'Auntie Ma (马阿姨), an energetic and loud stall owner who makes the crispiest Roujiamo and Liangpi in town.'**
  String get auntieMaTown;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @baristaKevinNotes.
  ///
  /// In en, this message translates to:
  /// **'Barista Kevin (小凯), a passionate young coffee roaster who loves discussing Yunnan coffee beans and flavor notes.'**
  String get baristaKevinNotes;

  /// No description provided for @bbc.
  ///
  /// In en, this message translates to:
  /// **'BBC 中文网'**
  String get bbc;

  /// No description provided for @beginYourJourney.
  ///
  /// In en, this message translates to:
  /// **'Begin Your Journey'**
  String get beginYourJourney;

  /// No description provided for @bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get bestValue;

  /// No description provided for @bookLinkCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Book link copied to clipboard!'**
  String get bookLinkCopiedToClipboard;

  /// No description provided for @bookmarkChapter.
  ///
  /// In en, this message translates to:
  /// **'Bookmark Chapter'**
  String get bookmarkChapter;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @briefing.
  ///
  /// In en, this message translates to:
  /// **'Briefing'**
  String get briefing;

  /// No description provided for @bugReport.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReport;

  /// No description provided for @caoXueqinDecline.
  ///
  /// In en, this message translates to:
  /// **'Cao Xueqin (c. 1715–1763) was a Qing Dynasty novelist born into a once-wealthy Bannerman family whose fortunes collapsed under Emperor Yongzheng. Dream of the Red Chamber, written in his poverty-stricken final years, is widely regarded as the pinnacle of Chinese fiction — a vast, psychologically rich taphos of aristocratic decline.'**
  String get caoXueqinDecline;

  /// No description provided for @cardsTitle.
  ///
  /// In en, this message translates to:
  /// **'CARDS'**
  String get cardsTitle;

  /// No description provided for @cc.
  ///
  /// In en, this message translates to:
  /// **'CC'**
  String get cc;

  /// No description provided for @characterOrWord.
  ///
  /// In en, this message translates to:
  /// **'Character / Word'**
  String get characterOrWord;

  /// No description provided for @chatMore.
  ///
  /// In en, this message translates to:
  /// **'Chat more'**
  String get chatMore;

  /// No description provided for @chefChenShumai.
  ///
  /// In en, this message translates to:
  /// **'Chef Chen (陈师傅), a cheerful Cantonese dim sum chef recommending fresh Har Gow shrimp dumplings and Shumai.'**
  String get chefChenShumai;

  /// No description provided for @chineseEpics.
  ///
  /// In en, this message translates to:
  /// **'Chinese Epics'**
  String get chineseEpics;

  /// No description provided for @chinesePoetry.
  ///
  /// In en, this message translates to:
  /// **'Chinese Poetry'**
  String get chinesePoetry;

  /// No description provided for @chng.
  ///
  /// In en, this message translates to:
  /// **'chéng'**
  String get chng;

  /// No description provided for @chongqingSpicyHotpotFeast.
  ///
  /// In en, this message translates to:
  /// **'Chongqing Spicy Hotpot Feast'**
  String get chongqingSpicyHotpotFeast;

  /// No description provided for @chooseAudiobookVoice.
  ///
  /// In en, this message translates to:
  /// **'Choose Audiobook Voice'**
  String get chooseAudiobookVoice;

  /// No description provided for @chooseVoice.
  ///
  /// In en, this message translates to:
  /// **'Choose Voice'**
  String get chooseVoice;

  /// No description provided for @compare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get compare;

  /// No description provided for @compare4Tones.
  ///
  /// In en, this message translates to:
  /// **'Compare 4 Tones'**
  String get compare4Tones;

  /// No description provided for @configuration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// No description provided for @contemporary.
  ///
  /// In en, this message translates to:
  /// **'Contemporary'**
  String get contemporary;

  /// No description provided for @context.
  ///
  /// In en, this message translates to:
  /// **'Context'**
  String get context;

  /// No description provided for @couldNotLoadLibrary.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the library'**
  String get couldNotLoadLibrary;

  /// No description provided for @couldNotLoadVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Could not load vocabulary.'**
  String get couldNotLoadVocabulary;

  /// No description provided for @couldNotOpenEmailApp.
  ///
  /// In en, this message translates to:
  /// **'Could not open email app.'**
  String get couldNotOpenEmailApp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @createNewDeck.
  ///
  /// In en, this message translates to:
  /// **'Create New Deck'**
  String get createNewDeck;

  /// No description provided for @createScenario.
  ///
  /// In en, this message translates to:
  /// **'Create Scenario'**
  String get createScenario;

  /// No description provided for @createStory.
  ///
  /// In en, this message translates to:
  /// **'Create Story'**
  String get createStory;

  /// No description provided for @customLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customLabel;

  /// No description provided for @customWord.
  ///
  /// In en, this message translates to:
  /// **'Custom Word'**
  String get customWord;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @deck.
  ///
  /// In en, this message translates to:
  /// **'Deck'**
  String get deck;

  /// No description provided for @deckName.
  ///
  /// In en, this message translates to:
  /// **'Deck Name'**
  String get deckName;

  /// No description provided for @deckStory.
  ///
  /// In en, this message translates to:
  /// **'Deck Story'**
  String get deckStory;

  /// No description provided for @deepAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Deep Analysis'**
  String get deepAnalysis;

  /// No description provided for @defaultDeck.
  ///
  /// In en, this message translates to:
  /// **'Default Deck'**
  String get defaultDeck;

  /// No description provided for @deleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteLabel;

  /// No description provided for @deleteScenario.
  ///
  /// In en, this message translates to:
  /// **'Delete Scenario'**
  String get deleteScenario;

  /// No description provided for @deletesAllProgressPermanently.
  ///
  /// In en, this message translates to:
  /// **'Deletes all progress permanently'**
  String get deletesAllProgressPermanently;

  /// No description provided for @developerBackdoorUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Developer Backdoor Unlocked!'**
  String get developerBackdoorUnlocked;

  /// No description provided for @doesNotExistInChinese.
  ///
  /// In en, this message translates to:
  /// **'Does not exist in Chinese'**
  String get doesNotExistInChinese;

  /// No description provided for @dontHaveAccountSignUp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get dontHaveAccountSignUp;

  /// No description provided for @draftingStoryOutline.
  ///
  /// In en, this message translates to:
  /// **'Drafting story outline...'**
  String get draftingStoryOutline;

  /// No description provided for @dynamicFlowState.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Flow State'**
  String get dynamicFlowState;

  /// No description provided for @dynamicFlowStateParenthetical.
  ///
  /// In en, this message translates to:
  /// **'Dynamic (Flow State)'**
  String get dynamicFlowStateParenthetical;

  /// No description provided for @editCard.
  ///
  /// In en, this message translates to:
  /// **'Edit Card'**
  String get editCard;

  /// No description provided for @egAnimeVocab.
  ///
  /// In en, this message translates to:
  /// **'E.g. Anime Vocab'**
  String get egAnimeVocab;

  /// No description provided for @egFormalBusinessLanguageSlangForTexting.
  ///
  /// In en, this message translates to:
  /// **'e.g., Formal business language, slang for texting...'**
  String get egFormalBusinessLanguageSlangForTexting;

  /// No description provided for @egOrderingAtARestaurantBusinessVocab.
  ///
  /// In en, this message translates to:
  /// **'e.g., Ordering at a restaurant, Business vocab...'**
  String get egOrderingAtARestaurantBusinessVocab;

  /// No description provided for @egWeddingReceptionTechInterview.
  ///
  /// In en, this message translates to:
  /// **'e.g., Wedding Reception, Tech Interview...'**
  String get egWeddingReceptionTechInterview;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @englishAndWorld.
  ///
  /// In en, this message translates to:
  /// **'English & World'**
  String get englishAndWorld;

  /// No description provided for @episodes.
  ///
  /// In en, this message translates to:
  /// **'episodes'**
  String get episodes;

  /// No description provided for @erase.
  ///
  /// In en, this message translates to:
  /// **'Erase'**
  String get erase;

  /// No description provided for @eraseDeckQuestion.
  ///
  /// In en, this message translates to:
  /// **'Erase Deck?'**
  String get eraseDeckQuestion;

  /// No description provided for @errorFetchingTranslationForLabelE.
  ///
  /// In en, this message translates to:
  /// **'Error fetching translation for {label}: {e}'**
  String errorFetchingTranslationForLabelE(String label, String e);

  /// No description provided for @errorLoadingMicroreadsE.
  ///
  /// In en, this message translates to:
  /// **'Error loading micro-reads: {e}'**
  String errorLoadingMicroreadsE(String e);

  /// No description provided for @errorLoadingNovelsE.
  ///
  /// In en, this message translates to:
  /// **'Error loading novels: {e}'**
  String errorLoadingNovelsE(String e);

  /// No description provided for @errorLoadingPoetryE.
  ///
  /// In en, this message translates to:
  /// **'Error loading poetry: {e}'**
  String errorLoadingPoetryE(String e);

  /// No description provided for @exitFocus.
  ///
  /// In en, this message translates to:
  /// **'Exit Focus'**
  String get exitFocus;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @exportToThisDeck.
  ///
  /// In en, this message translates to:
  /// **'Export to this deck'**
  String get exportToThisDeck;

  /// No description provided for @extractAndSimplify.
  ///
  /// In en, this message translates to:
  /// **'Extract & Simplify'**
  String get extractAndSimplify;

  /// No description provided for @failedToCreateDeck.
  ///
  /// In en, this message translates to:
  /// **'Failed to create deck'**
  String get failedToCreateDeck;

  /// No description provided for @failedToLoadDailyContent.
  ///
  /// In en, this message translates to:
  /// **'Failed to load daily content'**
  String get failedToLoadDailyContent;

  /// No description provided for @failedToLoadEpisodes.
  ///
  /// In en, this message translates to:
  /// **'Failed to load episodes'**
  String get failedToLoadEpisodes;

  /// No description provided for @failedToLoadShows.
  ///
  /// In en, this message translates to:
  /// **'Failed to load shows'**
  String get failedToLoadShows;

  /// No description provided for @finalizingDetails.
  ///
  /// In en, this message translates to:
  /// **'Finalizing details...'**
  String get finalizingDetails;

  /// No description provided for @finalizingStoryDetails.
  ///
  /// In en, this message translates to:
  /// **'Finalizing story details...'**
  String get finalizingStoryDetails;

  /// No description provided for @firebaseAuthConsole.
  ///
  /// In en, this message translates to:
  /// **'Firebase Auth not enabled. Please enable the required Sign-In method in your Firebase Console.'**
  String get firebaseAuthConsole;

  /// No description provided for @flashcardDeckTitle.
  ///
  /// In en, this message translates to:
  /// **'FLASHCARD DECK'**
  String get flashcardDeckTitle;

  /// No description provided for @focus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focus;

  /// No description provided for @foodAndCooking.
  ///
  /// In en, this message translates to:
  /// **'Food & Cooking'**
  String get foodAndCooking;

  /// No description provided for @forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get forward;

  /// No description provided for @freeFlow.
  ///
  /// In en, this message translates to:
  /// **'Free Flow'**
  String get freeFlow;

  /// No description provided for @frenchClassics.
  ///
  /// In en, this message translates to:
  /// **'French Classics'**
  String get frenchClassics;

  /// No description provided for @full.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get full;

  /// No description provided for @gamingAndEsports.
  ///
  /// In en, this message translates to:
  /// **'Gaming & Esports'**
  String get gamingAndEsports;

  /// No description provided for @germanClassics.
  ///
  /// In en, this message translates to:
  /// **'German Classics'**
  String get germanClassics;

  /// No description provided for @ghostPinyin.
  ///
  /// In en, this message translates to:
  /// **'Ghost Pinyin'**
  String get ghostPinyin;

  /// No description provided for @goodAttempt.
  ///
  /// In en, this message translates to:
  /// **'Good attempt'**
  String get goodAttempt;

  /// No description provided for @gotItSimple.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotItSimple;

  /// No description provided for @grammar.
  ///
  /// In en, this message translates to:
  /// **'Grammar'**
  String get grammar;

  /// No description provided for @grandmaLiuFilling.
  ///
  /// In en, this message translates to:
  /// **'Grandma Liu (刘奶奶), a doting northern grandmother who teaches you how to pinch dumpling pleats and make pork-scallion filling.'**
  String get grandmaLiuFilling;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get great;

  /// No description provided for @handmadeDumplingFeastInHarbin.
  ///
  /// In en, this message translates to:
  /// **'Handmade Dumpling Feast in Harbin'**
  String get handmadeDumplingFeastInHarbin;

  /// No description provided for @hanziCharacter.
  ///
  /// In en, this message translates to:
  /// **'Hanzi (Character)'**
  String get hanziCharacter;

  /// No description provided for @hapticFeedback.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get hapticFeedback;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hidden;

  /// No description provided for @hideEnglishTranslations.
  ///
  /// In en, this message translates to:
  /// **'Hide English Translations'**
  String get hideEnglishTranslations;

  /// No description provided for @hidePinyin.
  ///
  /// In en, this message translates to:
  /// **'Hide Pinyin'**
  String get hidePinyin;

  /// No description provided for @highlight.
  ///
  /// In en, this message translates to:
  /// **'HIGHLIGHT'**
  String get highlight;

  /// No description provided for @howWouldYouLikeToStudy.
  ///
  /// In en, this message translates to:
  /// **'How would you like to study?'**
  String get howWouldYouLikeToStudy;

  /// No description provided for @hsk1.
  ///
  /// In en, this message translates to:
  /// **'HSK 1'**
  String get hsk1;

  /// No description provided for @hsk4UpperIntermediate.
  ///
  /// In en, this message translates to:
  /// **'HSK 4: Upper Int.'**
  String get hsk4UpperIntermediate;

  /// No description provided for @hsk5Advanced.
  ///
  /// In en, this message translates to:
  /// **'HSK 5: Advanced'**
  String get hsk5Advanced;

  /// No description provided for @hsk6Mastery.
  ///
  /// In en, this message translates to:
  /// **'HSK 6: Mastery'**
  String get hsk6Mastery;

  /// No description provided for @hskCollections.
  ///
  /// In en, this message translates to:
  /// **'HSK Collections'**
  String get hskCollections;

  /// No description provided for @hskLevel.
  ///
  /// In en, this message translates to:
  /// **'HSK {level}'**
  String hskLevel(String level);

  /// No description provided for @hskSimplifySubtitles.
  ///
  /// In en, this message translates to:
  /// **'HSK Simplify Subtitles'**
  String get hskSimplifySubtitles;

  /// No description provided for @hskVocabularyCollections.
  ///
  /// In en, this message translates to:
  /// **'HSK vocabulary collections'**
  String get hskVocabularyCollections;

  /// No description provided for @i.
  ///
  /// In en, this message translates to:
  /// **'I\\'**
  String get i;

  /// No description provided for @ifTheAgain.
  ///
  /// In en, this message translates to:
  /// **'If the AI detects a mismatch, it will ask \'Did you mean to say...?\'. You can tap the \'Yes, Re-Grade Me!\' button to instantly re-evaluate your original audio against your true intention without having to speak again.'**
  String get ifTheAgain;

  /// No description provided for @install.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install;

  /// No description provided for @just.
  ///
  /// In en, this message translates to:
  /// **'Just \\\$'**
  String get just;

  /// No description provided for @keyword.
  ///
  /// In en, this message translates to:
  /// **'keyword'**
  String get keyword;

  /// No description provided for @knowledgeBase.
  ///
  /// In en, this message translates to:
  /// **'Knowledge Base'**
  String get knowledgeBase;

  /// No description provided for @liRuzhenSubjects.
  ///
  /// In en, this message translates to:
  /// **'Li Ruzhen (c. 1763–1830) was a Qing Dynasty scholar with deep interests in phonology, chess, and cosmology. Flowers in the Mirror, his fantastical novel of a merchant journeying through impossible kingdoms, is remarkable for its feminist themes and encyclopaedic range of subjects.'**
  String get liRuzhenSubjects;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'æ–‡åŒ–ä¹¦æˆ¿ Library'**
  String get library;

  /// No description provided for @lifestyleAndVlog.
  ///
  /// In en, this message translates to:
  /// **'Lifestyle & Vlog'**
  String get lifestyleAndVlog;

  /// No description provided for @listenInAudiobookMode.
  ///
  /// In en, this message translates to:
  /// **'Listen in Audiobook Mode'**
  String get listenInAudiobookMode;

  /// No description provided for @listenToThisWord.
  ///
  /// In en, this message translates to:
  /// **'Listen to this word'**
  String get listenToThisWord;

  /// No description provided for @listening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listening;

  /// No description provided for @liuEEncroachment.
  ///
  /// In en, this message translates to:
  /// **'Liu E (1857–1909) was a late-Qing polymath — engineer, doctor, and novelist — whose sole novel The Travels of Lao Can is a lyrical yet politically charged travelogue of a wandering healer navigating a China in the throes of dynastic collapse and foreign encroachment.'**
  String get liuEEncroachment;

  /// No description provided for @loadingTranslations.
  ///
  /// In en, this message translates to:
  /// **'Loading translations...'**
  String get loadingTranslations;

  /// No description provided for @luXunVernacular.
  ///
  /// In en, this message translates to:
  /// **'Lu Xun (1881–1936), pen name of Zhou Shuren, is the father of modern Chinese literature. A physician who switched to writing to heal the Chinese spirit, his short story collections — Diary of a Madman and The True Story of Ah Q — used vernacular'**
  String get luXunVernacular;

  /// No description provided for @luoGuanzhongEpic.
  ///
  /// In en, this message translates to:
  /// **'Luo Guanzhong (c. 1330–1400) was a Yuan-to-Ming transition era playwright and novelist, believed to have studied under Shi Nai\'an. His Romance of the Three Kingdoms synthesised historical chronicles, oral tradition, and dramatic storytelling into the definitive Chinese historical epic.'**
  String get luoGuanzhongEpic;

  /// No description provided for @makeACustomCollection.
  ///
  /// In en, this message translates to:
  /// **'Make a custom collection'**
  String get makeACustomCollection;

  /// No description provided for @manageDailyDropsAndReviewReminders.
  ///
  /// In en, this message translates to:
  /// **'Manage Daily Drops and Review Reminders'**
  String get manageDailyDropsAndReviewReminders;

  /// No description provided for @managerYuOptions.
  ///
  /// In en, this message translates to:
  /// **'Manager Yu (余店长), a fiery hotpot restaurant manager who recommends signature tripe, duck blood, and mild broth options.'**
  String get managerYuOptions;

  /// No description provided for @masterGaoRubs.
  ///
  /// In en, this message translates to:
  /// **'Master Gao (高师傅), a charismatic charcoal BBQ master bantering with customers about spice levels and secret cumin rubs.'**
  String get masterGaoRubs;

  /// No description provided for @masterThisToUnlockItsGalaxy.
  ///
  /// In en, this message translates to:
  /// **'Master this to unlock its galaxy.'**
  String get masterThisToUnlockItsGalaxy;

  /// No description provided for @masterZhaoBrewing.
  ///
  /// In en, this message translates to:
  /// **'Master Zhao (赵师傅), a patient and knowledgeable tea sommelier who loves explaining Gongfu tea brewing.'**
  String get masterZhaoBrewing;

  /// No description provided for @mastery.
  ///
  /// In en, this message translates to:
  /// **'Mastery'**
  String get mastery;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get maybeLater;

  /// No description provided for @memes.
  ///
  /// In en, this message translates to:
  /// **'Memes'**
  String get memes;

  /// No description provided for @midnightBbqSkewersInWuhan.
  ///
  /// In en, this message translates to:
  /// **'Midnight BBQ Skewers in Wuhan'**
  String get midnightBbqSkewersInWuhan;

  /// No description provided for @mo.
  ///
  /// In en, this message translates to:
  /// **'/mo'**
  String get mo;

  /// No description provided for @modernChinese.
  ///
  /// In en, this message translates to:
  /// **'Modern Chinese'**
  String get modernChinese;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @morningDimSumCartInGuangzhou.
  ///
  /// In en, this message translates to:
  /// **'Morning Dim Sum Cart in Guangzhou'**
  String get morningDimSumCartInGuangzhou;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @native.
  ///
  /// In en, this message translates to:
  /// **'Native'**
  String get native;

  /// No description provided for @newCard.
  ///
  /// In en, this message translates to:
  /// **'New Card'**
  String get newCard;

  /// No description provided for @newDeck.
  ///
  /// In en, this message translates to:
  /// **'New Deck'**
  String get newDeck;

  /// No description provided for @newDeckName.
  ///
  /// In en, this message translates to:
  /// **'New Deck Name'**
  String get newDeckName;

  /// No description provided for @noActiveSubscriptionFound.
  ///
  /// In en, this message translates to:
  /// **'No active subscription found.'**
  String get noActiveSubscriptionFound;

  /// No description provided for @noEpisodesFound.
  ///
  /// In en, this message translates to:
  /// **'No episodes found'**
  String get noEpisodesFound;

  /// No description provided for @noKeyWordsFoundForThisStory.
  ///
  /// In en, this message translates to:
  /// **'No key words found for this story.'**
  String get noKeyWordsFoundForThisStory;

  /// No description provided for @noLabel.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noLabel;

  /// No description provided for @noNewWordsFound.
  ///
  /// In en, this message translates to:
  /// **'No new words found!'**
  String get noNewWordsFound;

  /// No description provided for @noPinyin.
  ///
  /// In en, this message translates to:
  /// **'No Pinyin'**
  String get noPinyin;

  /// No description provided for @noPremiumPackagesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No premium packages available at the moment.'**
  String get noPremiumPackagesAvailable;

  /// No description provided for @noResultsFoundForSearchquery.
  ///
  /// In en, this message translates to:
  /// **'No results found for \'{searchQuery}\''**
  String noResultsFoundForSearchquery(String searchQuery);

  /// No description provided for @noSavedArticlesYet.
  ///
  /// In en, this message translates to:
  /// **'No saved articles yet.'**
  String get noSavedArticlesYet;

  /// No description provided for @noShowsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No shows available'**
  String get noShowsAvailable;

  /// No description provided for @noStoriesFound.
  ///
  /// In en, this message translates to:
  /// **'No stories found.'**
  String get noStoriesFound;

  /// No description provided for @noWordsSelected.
  ///
  /// In en, this message translates to:
  /// **'No words selected'**
  String get noWordsSelected;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notoserifsc.
  ///
  /// In en, this message translates to:
  /// **'NotoSerifSC'**
  String get notoserifsc;

  /// No description provided for @objectivesTitle.
  ///
  /// In en, this message translates to:
  /// **'OBJECTIVES'**
  String get objectivesTitle;

  /// No description provided for @openInYoutube.
  ///
  /// In en, this message translates to:
  /// **'Open in YouTube'**
  String get openInYoutube;

  /// No description provided for @orderingHanddripCoffeeInShanghai.
  ///
  /// In en, this message translates to:
  /// **'Ordering Hand-Drip Coffee in Shanghai'**
  String get orderingHanddripCoffeeInShanghai;

  /// No description provided for @orderingSugarcoatedHawsInWinterBeijing.
  ///
  /// In en, this message translates to:
  /// **'Ordering Sugar-Coated Haws in Winter Beijing'**
  String get orderingSugarcoatedHawsInWinterBeijing;

  /// No description provided for @partnerLang.
  ///
  /// In en, this message translates to:
  /// **'Partner ({lang})'**
  String partnerLang(String lang);

  /// No description provided for @partnerListening.
  ///
  /// In en, this message translates to:
  /// **'Partner listening...'**
  String get partnerListening;

  /// No description provided for @partnerSpeaking.
  ///
  /// In en, this message translates to:
  /// **'Partner speaking…'**
  String get partnerSpeaking;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @perfect.
  ///
  /// In en, this message translates to:
  /// **'Perfect!'**
  String get perfect;

  /// No description provided for @personalizedPathBasedOnDeck.
  ///
  /// In en, this message translates to:
  /// **'A personalized path based on your deck.'**
  String get personalizedPathBasedOnDeck;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pleaseEnterMessageBeforeSending.
  ///
  /// In en, this message translates to:
  /// **'Please enter a message before sending.'**
  String get pleaseEnterMessageBeforeSending;

  /// No description provided for @practiceInRoleplay.
  ///
  /// In en, this message translates to:
  /// **'Practice in Roleplay'**
  String get practiceInRoleplay;

  /// No description provided for @practiceModes.
  ///
  /// In en, this message translates to:
  /// **'Practice Modes'**
  String get practiceModes;

  /// No description provided for @practicePronouncingWithAiGrading.
  ///
  /// In en, this message translates to:
  /// **'Practice pronouncing this word with AI grading'**
  String get practicePronouncingWithAiGrading;

  /// No description provided for @preparingReadingInterface.
  ///
  /// In en, this message translates to:
  /// **'Preparing reading interface...'**
  String get preparingReadingInterface;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyAndAudio.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Audio'**
  String get privacyAndAudio;

  /// No description provided for @puSonglingLiterature.
  ///
  /// In en, this message translates to:
  /// **'Pu Songling (1640–1715) was a Qing Dynasty writer who spent decades compiling Strange Tales from a Chinese Studio after repeatedly failing the imperial examinations. His supernatural stories of fox spirits, ghosts, and scholars remain the gold standard of Chinese gothic literature.'**
  String get puSonglingLiterature;

  /// No description provided for @qaFaq.
  ///
  /// In en, this message translates to:
  /// **'Q&A / FAQ'**
  String get qaFaq;

  /// No description provided for @questsTitle.
  ///
  /// In en, this message translates to:
  /// **'QUESTS'**
  String get questsTitle;

  /// No description provided for @quickBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Quick Bookmarks'**
  String get quickBookmarks;

  /// No description provided for @radical.
  ///
  /// In en, this message translates to:
  /// **'Radical'**
  String get radical;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get ready;

  /// No description provided for @readyToInterpret.
  ///
  /// In en, this message translates to:
  /// **'Ready to interpret'**
  String get readyToInterpret;

  /// No description provided for @readyToStart.
  ///
  /// In en, this message translates to:
  /// **'Ready to start.'**
  String get readyToStart;

  /// No description provided for @recentBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Recent Bookmarks'**
  String get recentBookmarks;

  /// No description provided for @refiningGrammar.
  ///
  /// In en, this message translates to:
  /// **'Refining grammar...'**
  String get refiningGrammar;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @removeFromSaved.
  ///
  /// In en, this message translates to:
  /// **'Remove from Saved'**
  String get removeFromSaved;

  /// No description provided for @removeFromSavedScenarios.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved scenarios'**
  String get removeFromSavedScenarios;

  /// No description provided for @removed.
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get removed;

  /// No description provided for @requestPermissions.
  ///
  /// In en, this message translates to:
  /// **'Request Permissions'**
  String get requestPermissions;

  /// No description provided for @rescind.
  ///
  /// In en, this message translates to:
  /// **'Rescind'**
  String get rescind;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @revenuecatError.
  ///
  /// In en, this message translates to:
  /// **'RevenueCat Error:'**
  String get revenuecatError;

  /// No description provided for @revenuecatErrorE.
  ///
  /// In en, this message translates to:
  /// **'RevenueCat Error: {e}'**
  String revenuecatErrorE(String e);

  /// No description provided for @reviewExtractedDeck.
  ///
  /// In en, this message translates to:
  /// **'Review Extracted Deck'**
  String get reviewExtractedDeck;

  /// No description provided for @reviewIn.
  ///
  /// In en, this message translates to:
  /// **'Review in'**
  String get reviewIn;

  /// No description provided for @reviewingYourTones.
  ///
  /// In en, this message translates to:
  /// **'Reviewing your tones...'**
  String get reviewingYourTones;

  /// No description provided for @saveAll.
  ///
  /// In en, this message translates to:
  /// **'Save All'**
  String get saveAll;

  /// No description provided for @saveScenario.
  ///
  /// In en, this message translates to:
  /// **'Save Scenario'**
  String get saveScenario;

  /// No description provided for @saveThisScenario.
  ///
  /// In en, this message translates to:
  /// **'Save this scenario'**
  String get saveThisScenario;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @scanAnother.
  ///
  /// In en, this message translates to:
  /// **'Scan Another'**
  String get scanAnother;

  /// No description provided for @scenarioRemoved.
  ///
  /// In en, this message translates to:
  /// **'Scenario removed'**
  String get scenarioRemoved;

  /// No description provided for @scenarioSavedFindInCustomTab.
  ///
  /// In en, this message translates to:
  /// **'Scenario saved! Find it in the Custom tab.'**
  String get scenarioSavedFindInCustomTab;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score:'**
  String get score;

  /// No description provided for @searchByPinyinOrMeaning.
  ///
  /// In en, this message translates to:
  /// **'Search by pinyin or meaning...'**
  String get searchByPinyinOrMeaning;

  /// No description provided for @searchByTitleOrTag.
  ///
  /// In en, this message translates to:
  /// **'Search by title or tag...'**
  String get searchByTitleOrTag;

  /// No description provided for @searchDictionaryOrTypeCustom.
  ///
  /// In en, this message translates to:
  /// **'Search dictionary or type custom'**
  String get searchDictionaryOrTypeCustom;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @searchOrEnterUrl.
  ///
  /// In en, this message translates to:
  /// **'Search or enter URL'**
  String get searchOrEnterUrl;

  /// No description provided for @searchScenariosHint.
  ///
  /// In en, this message translates to:
  /// **'Search scenarios...'**
  String get searchScenariosHint;

  /// No description provided for @searchStoriesIdiomsNews.
  ///
  /// In en, this message translates to:
  /// **'Search stories, idioms, news...'**
  String get searchStoriesIdiomsNews;

  /// No description provided for @searchTopicsEgCookingHistory.
  ///
  /// In en, this message translates to:
  /// **'Search topics (e.g., Cooking, History)'**
  String get searchTopicsEgCookingHistory;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @selectADeck.
  ///
  /// In en, this message translates to:
  /// **'Select a Deck'**
  String get selectADeck;

  /// No description provided for @selectPracticeMode.
  ///
  /// In en, this message translates to:
  /// **'Select Practice Mode'**
  String get selectPracticeMode;

  /// No description provided for @selectingHskVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Selecting HSK vocabulary...'**
  String get selectingHskVocabulary;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @serif.
  ///
  /// In en, this message translates to:
  /// **'Serif'**
  String get serif;

  /// No description provided for @shadow.
  ///
  /// In en, this message translates to:
  /// **'Shadow'**
  String get shadow;

  /// No description provided for @shiNaianEpic.
  ///
  /// In en, this message translates to:
  /// **'Shi Nai\'an (c. 1296–1372) was a Yuan Dynasty literatus who reportedly passed the imperial examination yet chose the life of a reclusive scholar. Water Margin, his masterwork of heroic outlaws and righteous rebellion, established the archetype of the Chinese martial epic.'**
  String get shiNaianEpic;

  /// No description provided for @showEnglish.
  ///
  /// In en, this message translates to:
  /// **'Show English'**
  String get showEnglish;

  /// No description provided for @showEnglishTranslations.
  ///
  /// In en, this message translates to:
  /// **'Show English Translations'**
  String get showEnglishTranslations;

  /// No description provided for @showHanzi.
  ///
  /// In en, this message translates to:
  /// **'Show Hanzi'**
  String get showHanzi;

  /// No description provided for @showPinyin.
  ///
  /// In en, this message translates to:
  /// **'Show Pinyin'**
  String get showPinyin;

  /// No description provided for @showTranslation.
  ///
  /// In en, this message translates to:
  /// **'Show Translation'**
  String get showTranslation;

  /// No description provided for @shows.
  ///
  /// In en, this message translates to:
  /// **'Shows'**
  String get shows;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @simplifiedArticle.
  ///
  /// In en, this message translates to:
  /// **'Simplified Article'**
  String get simplifiedArticle;

  /// No description provided for @simplifyingSubtitles.
  ///
  /// In en, this message translates to:
  /// **'Simplifying subtitles...'**
  String get simplifyingSubtitles;

  /// No description provided for @sincereHonest.
  ///
  /// In en, this message translates to:
  /// **'sincere; honest'**
  String get sincereHonest;

  /// No description provided for @sleepTimer.
  ///
  /// In en, this message translates to:
  /// **'Sleep Timer'**
  String get sleepTimer;

  /// No description provided for @smartDeck.
  ///
  /// In en, this message translates to:
  /// **'Smart Deck'**
  String get smartDeck;

  /// No description provided for @spanishAndWorld.
  ///
  /// In en, this message translates to:
  /// **'Spanish & World'**
  String get spanishAndWorld;

  /// No description provided for @speaker.
  ///
  /// In en, this message translates to:
  /// **'Speaker'**
  String get speaker;

  /// No description provided for @spotifyStylePlayer.
  ///
  /// In en, this message translates to:
  /// **'Spotify-style Player'**
  String get spotifyStylePlayer;

  /// No description provided for @storyBookmarkedInLibrary.
  ///
  /// In en, this message translates to:
  /// **'Story bookmarked in Library!'**
  String get storyBookmarkedInLibrary;

  /// No description provided for @streetFoodNightMarketInXian.
  ///
  /// In en, this message translates to:
  /// **'Street Food Night Market in Xi\'an'**
  String get streetFoodNightMarketInXian;

  /// No description provided for @strokes.
  ///
  /// In en, this message translates to:
  /// **'Strokes'**
  String get strokes;

  /// No description provided for @studyCharacter.
  ///
  /// In en, this message translates to:
  /// **'Study Character'**
  String get studyCharacter;

  /// No description provided for @subtitleOpacity.
  ///
  /// In en, this message translates to:
  /// **'Subtitle Opacity'**
  String get subtitleOpacity;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @supernaturalAndFolklore.
  ///
  /// In en, this message translates to:
  /// **'Supernatural & Folklore'**
  String get supernaturalAndFolklore;

  /// No description provided for @swipeToGrade.
  ///
  /// In en, this message translates to:
  /// **'Swipe to Grade:'**
  String get swipeToGrade;

  /// No description provided for @tableOfContents.
  ///
  /// In en, this message translates to:
  /// **'Table of Contents'**
  String get tableOfContents;

  /// No description provided for @tapToRetry.
  ///
  /// In en, this message translates to:
  /// **'Tap to Retry'**
  String get tapToRetry;

  /// No description provided for @teaTastingInChengdu.
  ///
  /// In en, this message translates to:
  /// **'Tea Tasting in Chengdu'**
  String get teaTastingInChengdu;

  /// No description provided for @techAndGadgets.
  ///
  /// In en, this message translates to:
  /// **'Tech & Gadgets'**
  String get techAndGadgets;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @theGalaxyCharacters.
  ///
  /// In en, this message translates to:
  /// **'The Galaxy Map awaits.\nMaster the Suns (Radicals) to unlock the Planets (Characters).'**
  String get theGalaxyCharacters;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @thinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get thinking;

  /// No description provided for @thisArticleCharacters.
  ///
  /// In en, this message translates to:
  /// **'This article contains Traditional Chinese characters.'**
  String get thisArticleCharacters;

  /// No description provided for @todaysWord.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S WORD'**
  String get todaysWord;

  /// No description provided for @togglePinyin.
  ///
  /// In en, this message translates to:
  /// **'Toggle Pinyin'**
  String get togglePinyin;

  /// No description provided for @toggleTranslation.
  ///
  /// In en, this message translates to:
  /// **'Toggle Translation'**
  String get toggleTranslation;

  /// No description provided for @toneDoesNotExistInMandarin.
  ///
  /// In en, this message translates to:
  /// **'This tone does not exist in standard Mandarin.'**
  String get toneDoesNotExistInMandarin;

  /// No description provided for @toneGraph.
  ///
  /// In en, this message translates to:
  /// **'Tone Graph'**
  String get toneGraph;

  /// No description provided for @traceLabel.
  ///
  /// In en, this message translates to:
  /// **'Trace'**
  String get traceLabel;

  /// No description provided for @trailer.
  ///
  /// In en, this message translates to:
  /// **'TRAILER'**
  String get trailer;

  /// No description provided for @translatingAndAddingPinyin.
  ///
  /// In en, this message translates to:
  /// **'Translating and adding Pinyin...'**
  String get translatingAndAddingPinyin;

  /// No description provided for @translatingText.
  ///
  /// In en, this message translates to:
  /// **'Translating text...'**
  String get translatingText;

  /// No description provided for @turnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn On'**
  String get turnOn;

  /// No description provided for @typeHanziPinyinOrEnglish.
  ///
  /// In en, this message translates to:
  /// **'Type Hanzi, Pinyin, or English...'**
  String get typeHanziPinyinOrEnglish;

  /// No description provided for @unknown2.
  ///
  /// In en, this message translates to:
  /// **'游戏 实况 王者荣耀 原神'**
  String get unknown2;

  /// No description provided for @unknown3.
  ///
  /// In en, this message translates to:
  /// **'中国 美食 菜谱'**
  String get unknown3;

  /// No description provided for @unknown4.
  ///
  /// In en, this message translates to:
  /// **'中国 科技 测评'**
  String get unknown4;

  /// No description provided for @unrollingTheScroll.
  ///
  /// In en, this message translates to:
  /// **'Unrolling the scroll...'**
  String get unrollingTheScroll;

  /// No description provided for @upperIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Upper Int.'**
  String get upperIntermediate;

  /// No description provided for @vibrationsForInteractions.
  ///
  /// In en, this message translates to:
  /// **'Vibrations for interactions'**
  String get vibrationsForInteractions;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @viewAnswer.
  ///
  /// In en, this message translates to:
  /// **'View Answer'**
  String get viewAnswer;

  /// No description provided for @viewAsList.
  ///
  /// In en, this message translates to:
  /// **'View as List'**
  String get viewAsList;

  /// No description provided for @viewBookmarks.
  ///
  /// In en, this message translates to:
  /// **'View Bookmarks'**
  String get viewBookmarks;

  /// No description provided for @viewMyDrawing.
  ///
  /// In en, this message translates to:
  /// **'View My Drawing'**
  String get viewMyDrawing;

  /// No description provided for @vlog.
  ///
  /// In en, this message translates to:
  /// **'中国 日常 vlog'**
  String get vlog;

  /// No description provided for @voice.
  ///
  /// In en, this message translates to:
  /// **'Voice:'**
  String get voice;

  /// No description provided for @web.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get web;

  /// No description provided for @wedLoveToHearFromYou.
  ///
  /// In en, this message translates to:
  /// **'We\'d love to\nhear from you.'**
  String get wedLoveToHearFromYou;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @whatDoesThisMean.
  ///
  /// In en, this message translates to:
  /// **'What does this mean?'**
  String get whatDoesThisMean;

  /// No description provided for @whatHappensToMyChatHistory.
  ///
  /// In en, this message translates to:
  /// **'What happens to my chat history?'**
  String get whatHappensToMyChatHistory;

  /// No description provided for @whatIfAiMishears.
  ///
  /// In en, this message translates to:
  /// **'What if the AI mishears what I meant to say?'**
  String get whatIfAiMishears;

  /// No description provided for @whichCharacterIs.
  ///
  /// In en, this message translates to:
  /// **'Which character is:'**
  String get whichCharacterIs;

  /// No description provided for @wikipedia.
  ///
  /// In en, this message translates to:
  /// **'Wikipedia'**
  String get wikipedia;

  /// No description provided for @wordsSavedAndSrsScheduled.
  ///
  /// In en, this message translates to:
  /// **'Words saved and SRS scheduled!'**
  String get wordsSavedAndSrsScheduled;

  /// No description provided for @writeYourMessageHere.
  ///
  /// In en, this message translates to:
  /// **'Write your message here...'**
  String get writeYourMessageHere;

  /// No description provided for @wuChengenLiterature.
  ///
  /// In en, this message translates to:
  /// **'Wu Cheng\'en (c. 1500–1582) was a Ming Dynasty novelist from Huai\'an, Jiangsu. Drawing on decades of folklore, Buddhist allegory, and satirical wit, he wove the mythology of the Tang pilgrimage into Journey to the West — one of the most inventive and beloved works in world literature.'**
  String get wuChengenLiterature;

  /// No description provided for @wuJingziClass.
  ///
  /// In en, this message translates to:
  /// **'Wu Jingzi (1701–1754) was a Qing Dynasty novelist from Anhui who abandoned his inherited fortune and spent his life writing The Scholars — a biting satirical novel exposing the vanity, corruption, and absurdity of the imperial examination system and the scholar-gentry class.'**
  String get wuJingziClass;

  /// No description provided for @xuZhonglinWarfare.
  ///
  /// In en, this message translates to:
  /// **'Xu Zhonglin (fl. 16th–17th century) was a Ming Dynasty author credited with compiling Investiture of the Gods (封神演义), a monumental work of mythological fiction blending Shang-Zhou history with Daoist cosmology, celestial bureaucracy, and heroic warfare.'**
  String get xuZhonglinWarfare;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @yesReGradeMe.
  ///
  /// In en, this message translates to:
  /// **'Yes, Re-Grade Me!'**
  String get yesReGradeMe;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @youAreSpeaking.
  ///
  /// In en, this message translates to:
  /// **'You are speaking'**
  String get youAreSpeaking;

  /// No description provided for @youLabel.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get youLabel;

  /// No description provided for @youLang.
  ///
  /// In en, this message translates to:
  /// **'You ({lang})'**
  String youLang(String lang);

  /// No description provided for @youMustAccount.
  ///
  /// In en, this message translates to:
  /// **'You must accept the Terms of Service and Privacy Policy to create an account.'**
  String get youMustAccount;

  /// No description provided for @yourEchoModels.
  ///
  /// In en, this message translates to:
  /// **'Your Echo Hall conversations are stored locally on your device so you can review them anytime. We do not use your personal conversations to train our AI models.'**
  String get yourEchoModels;

  /// No description provided for @zhOnly.
  ///
  /// In en, this message translates to:
  /// **'ZH Only'**
  String get zhOnly;

  /// No description provided for @hsk_1300_cards.
  ///
  /// In en, this message translates to:
  /// **'1300 cards'**
  String get hsk_1300_cards;

  /// No description provided for @hsk_154_cards.
  ///
  /// In en, this message translates to:
  /// **'154 cards'**
  String get hsk_154_cards;

  /// No description provided for @hsk_162_cards.
  ///
  /// In en, this message translates to:
  /// **'162 cards'**
  String get hsk_162_cards;

  /// No description provided for @hsk_2500_cards.
  ///
  /// In en, this message translates to:
  /// **'2500 cards'**
  String get hsk_2500_cards;

  /// No description provided for @hsk_299_cards.
  ///
  /// In en, this message translates to:
  /// **'299 cards'**
  String get hsk_299_cards;

  /// No description provided for @hsk_602_cards.
  ///
  /// In en, this message translates to:
  /// **'602 cards'**
  String get hsk_602_cards;

  /// No description provided for @added_to_review_queue.
  ///
  /// In en, this message translates to:
  /// **'Added  to Review Queue'**
  String get added_to_review_queue;

  /// No description provided for @added_cards_to.
  ///
  /// In en, this message translates to:
  /// **'Added {cardCount} cards to \"{deckName}\".'**
  String added_cards_to(int cardCount, String deckName);

  /// No description provided for @added_to_your_library.
  ///
  /// In en, this message translates to:
  /// **'Added \'\' to your Library'**
  String get added_to_your_library;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @ai_stories.
  ///
  /// In en, this message translates to:
  /// **'AI Stories'**
  String get ai_stories;

  /// No description provided for @analysis_failed.
  ///
  /// In en, this message translates to:
  /// **'Analysis Failed: (error)'**
  String get analysis_failed;

  /// No description provided for @analyzing_pronunciation_with_gemini_ai.
  ///
  /// In en, this message translates to:
  /// **'Analyzing pronunciation with Gemini AI...'**
  String get analyzing_pronunciation_with_gemini_ai;

  /// No description provided for @analyzing_your_pronunciation.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your pronunciation...'**
  String get analyzing_your_pronunciation;

  /// No description provided for @are_you_sure_you_want_to.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently erase \"{deckName}\"? This action cannot be undone and will delete all cards inside it.'**
  String are_you_sure_you_want_to(String deckName);

  /// No description provided for @ask_about.
  ///
  /// In en, this message translates to:
  /// **'Ask about {hanzi}...'**
  String ask_about(String hanzi);

  /// No description provided for @audio_haptics.
  ///
  /// In en, this message translates to:
  /// **'Audio & Haptics'**
  String get audio_haptics;

  /// No description provided for @audio_could_not_start_check_your.
  ///
  /// In en, this message translates to:
  /// **'Audio could not start. Check your connection and device voice settings.'**
  String get audio_could_not_start_check_your;

  /// No description provided for @calligraphy_trace.
  ///
  /// In en, this message translates to:
  /// **'Calligraphy Trace'**
  String get calligraphy_trace;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters)'**
  String get chapters;

  /// No description provided for @char.
  ///
  /// In en, this message translates to:
  /// **'char'**
  String get char;

  /// No description provided for @chinese_character.
  ///
  /// In en, this message translates to:
  /// **'CHINESE CHARACTER'**
  String get chinese_character;

  /// No description provided for @contact_us_and_report_issues.
  ///
  /// In en, this message translates to:
  /// **'Contact us and report issues'**
  String get contact_us_and_report_issues;

  /// No description provided for @created_smart_deck_with_words.
  ///
  /// In en, this message translates to:
  /// **'Created smart deck: \"{deckName}\" with {wordCount} words!'**
  String created_smart_deck_with_words(String deckName, int wordCount);

  /// No description provided for @custom_ai_generated_story.
  ///
  /// In en, this message translates to:
  /// **'Custom AI generated story.'**
  String get custom_ai_generated_story;

  /// No description provided for @display_content.
  ///
  /// In en, this message translates to:
  /// **'Display & Content'**
  String get display_content;

  /// No description provided for @do_you_keep_or_store_my.
  ///
  /// In en, this message translates to:
  /// **'Do you keep or store my voice recordings?'**
  String get do_you_keep_or_store_my;

  /// No description provided for @elementary.
  ///
  /// In en, this message translates to:
  /// **'Elementary'**
  String get elementary;

  /// No description provided for @error_creating_scenario.
  ///
  /// In en, this message translates to:
  /// **'Error creating scenario: (error)'**
  String get error_creating_scenario;

  /// No description provided for @error_fetching_translation_for.
  ///
  /// In en, this message translates to:
  /// **'Error fetching translation for : (error)'**
  String get error_fetching_translation_for;

  /// No description provided for @error_loading_chapters.
  ///
  /// In en, this message translates to:
  /// **'Error loading chapters: (error)'**
  String get error_loading_chapters;

  /// No description provided for @error_loading_decks.
  ///
  /// In en, this message translates to:
  /// **'Error loading decks'**
  String get error_loading_decks;

  /// No description provided for @error_loading_microreads.
  ///
  /// In en, this message translates to:
  /// **'Error loading micro-reads: (error)'**
  String get error_loading_microreads;

  /// No description provided for @error_loading_novels.
  ///
  /// In en, this message translates to:
  /// **'Error loading novels: (error)'**
  String get error_loading_novels;

  /// No description provided for @error_loading_poetry.
  ///
  /// In en, this message translates to:
  /// **'Error loading poetry: (error)'**
  String get error_loading_poetry;

  /// No description provided for @etymology.
  ///
  /// In en, this message translates to:
  /// **'Etymology: '**
  String get etymology;

  /// No description provided for @explanation.
  ///
  /// In en, this message translates to:
  /// **'explanation'**
  String get explanation;

  /// No description provided for @extracted_text_tap_to_lookup.
  ///
  /// In en, this message translates to:
  /// **'Extracted Text (Tap to lookup)'**
  String get extracted_text_tap_to_lookup;

  /// No description provided for @extraction_failed.
  ///
  /// In en, this message translates to:
  /// **'Extraction Failed: \\(error)'**
  String get extraction_failed;

  /// No description provided for @failed_to_download.
  ///
  /// In en, this message translates to:
  /// **'Failed to download.'**
  String get failed_to_download;

  /// No description provided for @failed_to_generate_scenario.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate scenario: (error)'**
  String get failed_to_generate_scenario;

  /// No description provided for @failed_to_generate_story.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate story:\\n(error)'**
  String get failed_to_generate_story;

  /// No description provided for @failed_to_load_context.
  ///
  /// In en, this message translates to:
  /// **'Failed to load context: (error)rr'**
  String get failed_to_load_context;

  /// No description provided for @feature_request.
  ///
  /// In en, this message translates to:
  /// **'Feature Request'**
  String get feature_request;

  /// No description provided for @foundation.
  ///
  /// In en, this message translates to:
  /// **'Foundation'**
  String get foundation;

  /// No description provided for @how_is_my_pronunciation_scored.
  ///
  /// In en, this message translates to:
  /// **'How is my pronunciation scored?'**
  String get how_is_my_pronunciation_scored;

  /// No description provided for @hsk.
  ///
  /// In en, this message translates to:
  /// **'HSK '**
  String get hsk;

  /// No description provided for @hsk_vocabulary.
  ///
  /// In en, this message translates to:
  /// **'HSK {hskLevel} vocabulary'**
  String hsk_vocabulary(int hskLevel);

  /// No description provided for @hsk_level.
  ///
  /// In en, this message translates to:
  /// **'HSK LEVEL'**
  String get hsk_level;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @learning_stats.
  ///
  /// In en, this message translates to:
  /// **'Learning Stats'**
  String get learning_stats;

  /// No description provided for @mandarin.
  ///
  /// In en, this message translates to:
  /// **'Mandarin'**
  String get mandarin;

  /// No description provided for @meaning.
  ///
  /// In en, this message translates to:
  /// **'meaning'**
  String get meaning;

  /// No description provided for @no_decks_found.
  ///
  /// In en, this message translates to:
  /// **'No decks found.'**
  String get no_decks_found;

  /// No description provided for @no_results_found_for.
  ///
  /// In en, this message translates to:
  /// **'No results found for \'\''**
  String get no_results_found_for;

  /// No description provided for @no_when_you_use_echo_hall.
  ///
  /// In en, this message translates to:
  /// **'No. When you use Echo Hall, Scholar\'s Verdict, or Shadowing Studio, your audio is securely evaluated in real-time to generate a pronunciation score and then immediately discarded. We only store your numerical ratings to track your progress.'**
  String get no_when_you_use_echo_hall;

  /// No description provided for @notification_settings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notification_settings;

  /// No description provided for @open_settings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get open_settings;

  /// No description provided for @phoneme.
  ///
  /// In en, this message translates to:
  /// **'phoneme'**
  String get phoneme;

  /// No description provided for @play_reference_pronunciation.
  ///
  /// In en, this message translates to:
  /// **'Play Reference Pronunciation'**
  String get play_reference_pronunciation;

  /// No description provided for @please_select_a_deck_to_add.
  ///
  /// In en, this message translates to:
  /// **'Please select a deck to add cards to.'**
  String get please_select_a_deck_to_add;

  /// No description provided for @point_at_chinese_text_to_translate.
  ///
  /// In en, this message translates to:
  /// **'Point at Chinese text to translate'**
  String get point_at_chinese_text_to_translate;

  /// No description provided for @practice_writing_the_strokes_by_hand.
  ///
  /// In en, this message translates to:
  /// **'Practice writing the strokes by hand'**
  String get practice_writing_the_strokes_by_hand;

  /// No description provided for @preferences_audio_and_display.
  ///
  /// In en, this message translates to:
  /// **'Preferences, Audio, and Display'**
  String get preferences_audio_and_display;

  /// No description provided for @preparing_your_scholars_verdict.
  ///
  /// In en, this message translates to:
  /// **'Preparing your Scholar\'s Verdict...'**
  String get preparing_your_scholars_verdict;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @remove_from_this_deck.
  ///
  /// In en, this message translates to:
  /// **'Remove {hanzi} from this deck?'**
  String remove_from_this_deck(String hanzi);

  /// No description provided for @revenuecat_error.
  ///
  /// In en, this message translates to:
  /// **'RevenueCat Error: (error)'**
  String get revenuecat_error;

  /// No description provided for @review_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Review Tomorrow'**
  String get review_tomorrow;

  /// No description provided for @roleplay.
  ///
  /// In en, this message translates to:
  /// **'Roleplay'**
  String get roleplay;

  /// No description provided for @saving_words_to.
  ///
  /// In en, this message translates to:
  /// **'Saving {wordCount} words to {deckName}...'**
  String saving_words_to(int wordCount, String deckName);

  /// No description provided for @search_radicals_eg_water.
  ///
  /// In en, this message translates to:
  /// **'Search radicals (e.g. Water, 氵)'**
  String get search_radicals_eg_water;

  /// No description provided for @select_target_hsk_level.
  ///
  /// In en, this message translates to:
  /// **'Select Target HSK Level'**
  String get select_target_hsk_level;

  /// No description provided for @sentence.
  ///
  /// In en, this message translates to:
  /// **'Sentence'**
  String get sentence;

  /// No description provided for @shadowing_studio_is_a_dedicated_space.
  ///
  /// In en, this message translates to:
  /// **'Shadowing Studio is a dedicated space to practice mimicking native'**
  String get shadowing_studio_is_a_dedicated_space;

  /// No description provided for @simplify_failed.
  ///
  /// In en, this message translates to:
  /// **'Simplify Failed: (error)'**
  String get simplify_failed;

  /// No description provided for @sinospark_premium.
  ///
  /// In en, this message translates to:
  /// **'SinoSpark Premium'**
  String get sinospark_premium;

  /// No description provided for @speaking_pronunciation.
  ///
  /// In en, this message translates to:
  /// **'Speaking & Pronunciation'**
  String get speaking_pronunciation;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @table_of_contents.
  ///
  /// In en, this message translates to:
  /// **'Table of Contents · 目录 ('**
  String get table_of_contents;

  /// No description provided for @the_ai_evaluates_your_speech_across.
  ///
  /// In en, this message translates to:
  /// **'The AI evaluates your speech across three dimensions:\n• Accuracy: Did you articulate the correct syllables?\n• Completeness: Did you skip or miss any words?\n• Fluency: Did you pause naturally and use the correct tones?\nIt compares your audio against native models to generate a score out of 100.'**
  String get the_ai_evaluates_your_speech_across;

  /// No description provided for @this_cannot_be_undone.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get this_cannot_be_undone;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get title;

  /// No description provided for @to_be_reviewed.
  ///
  /// In en, this message translates to:
  /// **'To Be Reviewed'**
  String get to_be_reviewed;

  /// No description provided for @traditional.
  ///
  /// In en, this message translates to:
  /// **'Traditional'**
  String get traditional;

  /// No description provided for @translation_failed.
  ///
  /// In en, this message translates to:
  /// **'Translation Failed: (error)'**
  String get translation_failed;

  /// No description provided for @type_in.
  ///
  /// In en, this message translates to:
  /// **'Type in ...'**
  String get type_in;

  /// No description provided for @type_your_message_in.
  ///
  /// In en, this message translates to:
  /// **'Type your message in ...'**
  String get type_your_message_in;

  /// No description provided for @unable_to_open_this_video_please.
  ///
  /// In en, this message translates to:
  /// **'Unable to open this video. Please try again later.'**
  String get unable_to_open_this_video_please;

  /// No description provided for @view_your_learning_history_and_streaks.
  ///
  /// In en, this message translates to:
  /// **'View your learning history and streaks'**
  String get view_your_learning_history_and_streaks;

  /// No description provided for @what_is_shadowing_studio.
  ///
  /// In en, this message translates to:
  /// **'What is Shadowing Studio?'**
  String get what_is_shadowing_studio;

  /// No description provided for @words.
  ///
  /// In en, this message translates to:
  /// **'words'**
  String get words;

  /// No description provided for @your_path_for_is_ready.
  ///
  /// In en, this message translates to:
  /// **'Your path for \'{deckName}\' is ready!'**
  String your_path_for_is_ready(String deckName);

  /// No description provided for @you_said.
  ///
  /// In en, this message translates to:
  /// **'🗣️ You Said'**
  String get you_said;

  /// No description provided for @vocabularyBatch.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary Batch (index)'**
  String get vocabularyBatch;

  /// No description provided for @yourDailyDropIsHere.
  ///
  /// In en, this message translates to:
  /// **'Your Daily Drop is here! ✨'**
  String get yourDailyDropIsHere;

  /// No description provided for @timeToReview.
  ///
  /// In en, this message translates to:
  /// **'Time to Review! 📚'**
  String get timeToReview;

  /// No description provided for @neverMissAStroke.
  ///
  /// In en, this message translates to:
  /// **'Never miss a stroke! 🖌️'**
  String get neverMissAStroke;

  /// No description provided for @yourTrialEndsTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Your trial ends tomorrow! ⏳'**
  String get yourTrialEndsTomorrow;

  /// No description provided for @officialStandardVocabularyTiers.
  ///
  /// In en, this message translates to:
  /// **'Official standard vocabulary tiers'**
  String get officialStandardVocabularyTiers;

  /// No description provided for @failedToLoadCollections.
  ///
  /// In en, this message translates to:
  /// **'Failed to load collections.'**
  String get failedToLoadCollections;

  /// No description provided for @unnamedKey.
  ///
  /// In en, this message translates to:
  /// **'#(tag)'**
  String get unnamedKey;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: (error)'**
  String get error;

  /// No description provided for @aiSmartContext.
  ///
  /// In en, this message translates to:
  /// **'AI Smart Context'**
  String get aiSmartContext;

  /// No description provided for @aiSmartContextError.
  ///
  /// In en, this message translates to:
  /// **'AI Smart Context Error'**
  String get aiSmartContextError;

  /// No description provided for @downloadOfficialHskCollections.
  ///
  /// In en, this message translates to:
  /// **'Download official HSK collections'**
  String get downloadOfficialHskCollections;

  /// No description provided for @unableToLoadThisSection.
  ///
  /// In en, this message translates to:
  /// **'Unable to load this section. Please try again.'**
  String get unableToLoadThisSection;

  /// No description provided for @translationLanguage.
  ///
  /// In en, this message translates to:
  /// **'Translation Language'**
  String get translationLanguage;

  /// No description provided for @dailyDrops.
  ///
  /// In en, this message translates to:
  /// **'Daily Drops'**
  String get dailyDrops;

  /// No description provided for @wordOfTheDayNews.
  ///
  /// In en, this message translates to:
  /// **'Word of the Day & news'**
  String get wordOfTheDayNews;

  /// No description provided for @reviewReminders.
  ///
  /// In en, this message translates to:
  /// **'Review Reminders'**
  String get reviewReminders;

  /// No description provided for @flashcardsDueForReview.
  ///
  /// In en, this message translates to:
  /// **'Flashcards due for review'**
  String get flashcardsDueForReview;

  /// No description provided for @dailyNewCards.
  ///
  /// In en, this message translates to:
  /// **'Daily New Cards'**
  String get dailyNewCards;

  /// No description provided for @dailyReviewLimit.
  ///
  /// In en, this message translates to:
  /// **'Daily Review Limit'**
  String get dailyReviewLimit;

  /// No description provided for @practiceMode.
  ///
  /// In en, this message translates to:
  /// **'Practice Mode'**
  String get practiceMode;

  /// No description provided for @liziqi.
  ///
  /// In en, this message translates to:
  /// **'李子柒 Liziqi: 绢花'**
  String get liziqi;

  /// No description provided for @theLifeOfGarlicTraditional.
  ///
  /// In en, this message translates to:
  /// **'The Life of Garlic - Traditional Chinese Life'**
  String get theLifeOfGarlicTraditional;

  /// No description provided for @graceMandarin50Phrases.
  ///
  /// In en, this message translates to:
  /// **'Grace Mandarin: 50 Phrases'**
  String get graceMandarin50Phrases;

  /// No description provided for @essentialChinesePhrasesForBeginners.
  ///
  /// In en, this message translates to:
  /// **'Essential Chinese Phrases for Beginners'**
  String get essentialChinesePhrasesForBeginners;

  /// No description provided for @makingBambooFurniture.
  ///
  /// In en, this message translates to:
  /// **'Making Bamboo Furniture'**
  String get makingBambooFurniture;

  /// No description provided for @peppaPigChinese.
  ///
  /// In en, this message translates to:
  /// **'Peppa Pig Chinese: 躲猫猫'**
  String get peppaPigChinese;

  /// No description provided for @muddyPuddlesBeginnerFriendly.
  ///
  /// In en, this message translates to:
  /// **'Muddy Puddles - Beginner Friendly'**
  String get muddyPuddlesBeginnerFriendly;

  /// No description provided for @mandarinCorner300Verbs.
  ///
  /// In en, this message translates to:
  /// **'Mandarin Corner: 300 Verbs'**
  String get mandarinCorner300Verbs;

  /// No description provided for @mostCommonChineseVerbs.
  ///
  /// In en, this message translates to:
  /// **'Most Common Chinese Verbs'**
  String get mostCommonChineseVerbs;

  /// No description provided for @graceMandarinOrderFood.
  ///
  /// In en, this message translates to:
  /// **'Grace Mandarin: Order Food'**
  String get graceMandarinOrderFood;

  /// No description provided for @howToOrderFoodIn.
  ///
  /// In en, this message translates to:
  /// **'How to order food in a Chinese restaurant'**
  String get howToOrderFoodIn;

  /// No description provided for @silkFlowersTraditionalCraft.
  ///
  /// In en, this message translates to:
  /// **'Silk Flowers - Traditional Craft'**
  String get silkFlowersTraditionalCraft;

  /// No description provided for @mandarinCorner.
  ///
  /// In en, this message translates to:
  /// **'Mandarin Corner: 学中文 看病'**
  String get mandarinCorner;

  /// No description provided for @goingToTheDoctorReal.
  ///
  /// In en, this message translates to:
  /// **'Going to the Doctor - Real Life Conversation'**
  String get goingToTheDoctorReal;

  /// No description provided for @hideAndSeekBeginnerFriendly.
  ///
  /// In en, this message translates to:
  /// **'Hide and Seek - Beginner Friendly'**
  String get hideAndSeekBeginnerFriendly;

  /// No description provided for @linGdp6.
  ///
  /// In en, this message translates to:
  /// **'小Lin说: 为什么GDP增长6%'**
  String get linGdp6;

  /// No description provided for @why6GdpGrowthEasy.
  ///
  /// In en, this message translates to:
  /// **'Why 6% GDP Growth - Easy Chinese Economics'**
  String get why6GdpGrowthEasy;

  /// No description provided for @bbcWorldNews.
  ///
  /// In en, this message translates to:
  /// **'BBC 中文 (World News)'**
  String get bbcWorldNews;

  /// No description provided for @currentEventsInSimplifiedChinese.
  ///
  /// In en, this message translates to:
  /// **'Current Events in Simplified Chinese'**
  String get currentEventsInSimplifiedChinese;

  /// No description provided for @baidu.
  ///
  /// In en, this message translates to:
  /// **'Baidu'**
  String get baidu;

  /// No description provided for @youtubeDesk.
  ///
  /// In en, this message translates to:
  /// **'YOUTUBE DESK'**
  String get youtubeDesk;

  /// No description provided for @interactiveTranscriptsShadowing.
  ///
  /// In en, this message translates to:
  /// **'Interactive transcripts & shadowing'**
  String get interactiveTranscriptsShadowing;

  /// No description provided for @showsDramas.
  ///
  /// In en, this message translates to:
  /// **'SHOWS & DRAMAS'**
  String get showsDramas;

  /// No description provided for @extractToDeck.
  ///
  /// In en, this message translates to:
  /// **'Extract to Deck'**
  String get extractToDeck;

  /// No description provided for @autoSimplify.
  ///
  /// In en, this message translates to:
  /// **'Auto-Simplify'**
  String get autoSimplify;

  /// No description provided for @rewriteThisArticleToMatch.
  ///
  /// In en, this message translates to:
  /// **'Rewrite this article to match your HSK level'**
  String get rewriteThisArticleToMatch;

  /// No description provided for @failedToSaveExtractedWords.
  ///
  /// In en, this message translates to:
  /// **'Failed to save extracted words: (error)'**
  String get failedToSaveExtractedWords;

  /// No description provided for @addToDeck.
  ///
  /// In en, this message translates to:
  /// **'Add to Deck ((count))'**
  String get addToDeck;

  /// No description provided for @dailyDiscoveryDrop.
  ///
  /// In en, this message translates to:
  /// **'Daily Discovery Drop'**
  String get dailyDiscoveryDrop;

  /// No description provided for @smartSpacedRepetition.
  ///
  /// In en, this message translates to:
  /// **'Smart Spaced Repetition'**
  String get smartSpacedRepetition;

  /// No description provided for @trialProtectionAlert.
  ///
  /// In en, this message translates to:
  /// **'Trial Protection Alert'**
  String get trialProtectionAlert;

  /// No description provided for @masteryLevel.
  ///
  /// In en, this message translates to:
  /// **'Mastery Level'**
  String get masteryLevel;

  /// No description provided for @targetObjective.
  ///
  /// In en, this message translates to:
  /// **'Target Objective'**
  String get targetObjective;

  /// No description provided for @dailyPractice.
  ///
  /// In en, this message translates to:
  /// **'Daily Practice'**
  String get dailyPractice;

  /// No description provided for @aiSpacedRepetition.
  ///
  /// In en, this message translates to:
  /// **'AI Spaced Repetition'**
  String get aiSpacedRepetition;

  /// No description provided for @iVeGrantedAccess.
  ///
  /// In en, this message translates to:
  /// **'I\'ve granted access'**
  String get iVeGrantedAccess;

  /// No description provided for @scanner.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get scanner;

  /// No description provided for @interpreter.
  ///
  /// In en, this message translates to:
  /// **'Interpreter'**
  String get interpreter;

  /// No description provided for @cards.
  ///
  /// In en, this message translates to:
  /// **'(count) cards'**
  String get cards;

  /// No description provided for @nWaMendsTheHeavens.
  ///
  /// In en, this message translates to:
  /// **'Nüwa Mends the Heavens'**
  String get nWaMendsTheHeavens;

  /// No description provided for @terracottaArmy.
  ///
  /// In en, this message translates to:
  /// **'Terracotta Army'**
  String get terracottaArmy;

  /// No description provided for @forbiddenCity.
  ///
  /// In en, this message translates to:
  /// **'Forbidden City'**
  String get forbiddenCity;

  /// No description provided for @aBlessingInDisguise.
  ///
  /// In en, this message translates to:
  /// **'A Blessing in Disguise'**
  String get aBlessingInDisguise;

  /// No description provided for @drawingASnake.
  ///
  /// In en, this message translates to:
  /// **'Drawing a Snake'**
  String get drawingASnake;

  /// No description provided for @takingTheBulletTrain.
  ///
  /// In en, this message translates to:
  /// **'Taking the Bullet Train'**
  String get takingTheBulletTrain;

  /// No description provided for @visitingTheDoctor.
  ///
  /// In en, this message translates to:
  /// **'Visiting the Doctor'**
  String get visitingTheDoctor;

  /// No description provided for @orderingDumplings.
  ///
  /// In en, this message translates to:
  /// **'Ordering Dumplings'**
  String get orderingDumplings;

  /// No description provided for @theTeaCeremony.
  ///
  /// In en, this message translates to:
  /// **'The Tea Ceremony'**
  String get theTeaCeremony;

  /// No description provided for @chineseCalligraphy.
  ///
  /// In en, this message translates to:
  /// **'Chinese Calligraphy'**
  String get chineseCalligraphy;

  /// No description provided for @theGiantPanda.
  ///
  /// In en, this message translates to:
  /// **'The Giant Panda'**
  String get theGiantPanda;

  /// No description provided for @simplifiedText.
  ///
  /// In en, this message translates to:
  /// **'Simplified Text'**
  String get simplifiedText;

  /// No description provided for @novels96.
  ///
  /// In en, this message translates to:
  /// **'Novels (96)'**
  String get novels96;

  /// No description provided for @microReads.
  ///
  /// In en, this message translates to:
  /// **'Micro-Reads'**
  String get microReads;

  /// No description provided for @poetry.
  ///
  /// In en, this message translates to:
  /// **'Poetry'**
  String get poetry;

  /// No description provided for @bookmarkRemoved.
  ///
  /// In en, this message translates to:
  /// **'书签已移除 · Bookmark removed'**
  String get bookmarkRemoved;

  /// No description provided for @bookmarkAdded.
  ///
  /// In en, this message translates to:
  /// **'已添加书签 · Bookmark added: 第(chapter)回'**
  String get bookmarkAdded;

  /// No description provided for @readingVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Reading & Vocabulary'**
  String get readingVocabulary;

  /// No description provided for @vocabularyBatchUnitindex1.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary Batch \$(unitIndex + 1)'**
  String get vocabularyBatchUnitindex1;

  /// No description provided for @yourDailyDropIsHere1.
  ///
  /// In en, this message translates to:
  /// **'Your Daily Drop is here! ✨'**
  String get yourDailyDropIsHere1;

  /// No description provided for @timeToReview1.
  ///
  /// In en, this message translates to:
  /// **'Time to Review! 📚'**
  String get timeToReview1;

  /// No description provided for @neverMissAStroke1.
  ///
  /// In en, this message translates to:
  /// **'Never miss a stroke! 🖌️'**
  String get neverMissAStroke1;

  /// No description provided for @yourTrialEndsTomorrow1.
  ///
  /// In en, this message translates to:
  /// **'Your trial ends tomorrow! ⏳'**
  String get yourTrialEndsTomorrow1;

  /// No description provided for @hskCollections1.
  ///
  /// In en, this message translates to:
  /// **'HSK Collections'**
  String get hskCollections1;

  /// No description provided for @officialStandardVocabularyTiers1.
  ///
  /// In en, this message translates to:
  /// **'Official standard vocabulary tiers'**
  String get officialStandardVocabularyTiers1;

  /// No description provided for @failedToLoadCollections1.
  ///
  /// In en, this message translates to:
  /// **'Failed to load collections.'**
  String get failedToLoadCollections1;

  /// No description provided for @ui__transcription.
  ///
  /// In en, this message translates to:
  /// **'\"\$_transcription\"'**
  String get ui__transcription;

  /// No description provided for @playPinyinwithtone.
  ///
  /// In en, this message translates to:
  /// **'Play \$pinyinWithTone'**
  String get playPinyinwithtone;

  /// No description provided for @errorE.
  ///
  /// In en, this message translates to:
  /// **'Error: \$e'**
  String get errorE;

  /// No description provided for @lookalikepinyin.
  ///
  /// In en, this message translates to:
  /// **'(\$(lookAlike.pinyin))'**
  String get lookalikepinyin;

  /// No description provided for @aiSmartContext1.
  ///
  /// In en, this message translates to:
  /// **'AI Smart Context'**
  String get aiSmartContext1;

  /// No description provided for @aiSmartContextError1.
  ///
  /// In en, this message translates to:
  /// **'AI Smart Context Error'**
  String get aiSmartContextError1;

  /// No description provided for @errorErr.
  ///
  /// In en, this message translates to:
  /// **'Error: \$err'**
  String get errorErr;

  /// No description provided for @downloadOfficialHskCollections1.
  ///
  /// In en, this message translates to:
  /// **'Download official HSK collections'**
  String get downloadOfficialHskCollections1;

  /// No description provided for @unableToLoadThisSectionPleaseTryAga.
  ///
  /// In en, this message translates to:
  /// **'Unable to load this section. Please try again.'**
  String get unableToLoadThisSectionPleaseTryAga;

  /// No description provided for @searchRadicalsEgWater.
  ///
  /// In en, this message translates to:
  /// **'Search radicals (e.g. Water, 氵)'**
  String get searchRadicalsEgWater;

  /// No description provided for @ui__currentstrokeindex1totalstrokes.
  ///
  /// In en, this message translates to:
  /// **'\$(_currentStrokeIndex + 1)/\$totalStrokes'**
  String get ui__currentstrokeindex1totalstrokes;

  /// No description provided for @translationLanguage1.
  ///
  /// In en, this message translates to:
  /// **'Translation Language'**
  String get translationLanguage1;

  /// No description provided for @appLanguage1.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage1;

  /// No description provided for @dailyDrops1.
  ///
  /// In en, this message translates to:
  /// **'Daily Drops'**
  String get dailyDrops1;

  /// No description provided for @wordOfTheDayNews1.
  ///
  /// In en, this message translates to:
  /// **'Word of the Day & news'**
  String get wordOfTheDayNews1;

  /// No description provided for @reviewReminders1.
  ///
  /// In en, this message translates to:
  /// **'Review Reminders'**
  String get reviewReminders1;

  /// No description provided for @flashcardsDueForReview1.
  ///
  /// In en, this message translates to:
  /// **'Flashcards due for review'**
  String get flashcardsDueForReview1;

  /// No description provided for @accuracyByMode1.
  ///
  /// In en, this message translates to:
  /// **'Accuracy by Mode'**
  String get accuracyByMode1;

  /// No description provided for @accuracytostringasfixed1.
  ///
  /// In en, this message translates to:
  /// **'\$(accuracy.toStringAsFixed(1))%'**
  String get accuracytostringasfixed1;

  /// No description provided for @upcomingReviewsNext7Days.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Reviews (Next 7 Days)'**
  String get upcomingReviewsNext7Days;

  /// No description provided for @explaining.
  ///
  /// In en, this message translates to:
  /// **'Explaining:'**
  String get explaining;

  /// No description provided for @entryhanziEntrypinyin.
  ///
  /// In en, this message translates to:
  /// **'\$(entry.hanzi) [\$(entry.pinyin)]'**
  String get entryhanziEntrypinyin;

  /// No description provided for @dailyNewCards1.
  ///
  /// In en, this message translates to:
  /// **'Daily New Cards'**
  String get dailyNewCards1;

  /// No description provided for @dailyReviewLimit1.
  ///
  /// In en, this message translates to:
  /// **'Daily Review Limit'**
  String get dailyReviewLimit1;

  /// No description provided for @listeningMode1.
  ///
  /// In en, this message translates to:
  /// **'Listening Mode'**
  String get listeningMode1;

  /// No description provided for @readingMode1.
  ///
  /// In en, this message translates to:
  /// **'Reading Mode'**
  String get readingMode1;

  /// No description provided for @recallMode1.
  ///
  /// In en, this message translates to:
  /// **'Recall Mode'**
  String get recallMode1;

  /// No description provided for @speakingMode1.
  ///
  /// In en, this message translates to:
  /// **'Speaking Mode'**
  String get speakingMode1;

  /// No description provided for @practiceMode1.
  ///
  /// In en, this message translates to:
  /// **'Practice Mode'**
  String get practiceMode1;

  /// No description provided for @acc.
  ///
  /// In en, this message translates to:
  /// **'\$acc%'**
  String get acc;

  /// No description provided for @partner1.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get partner1;

  /// No description provided for @partnerSpeaking1.
  ///
  /// In en, this message translates to:
  /// **'Partner speaking…'**
  String get partnerSpeaking1;

  /// No description provided for @theLifeOfGarlicTraditionalChineseLi.
  ///
  /// In en, this message translates to:
  /// **'The Life of Garlic - Traditional Chinese Life'**
  String get theLifeOfGarlicTraditionalChineseLi;

  /// No description provided for @graceMandarin50Phrases1.
  ///
  /// In en, this message translates to:
  /// **'Grace Mandarin: 50 Phrases'**
  String get graceMandarin50Phrases1;

  /// No description provided for @essentialChinesePhrasesForBeginners1.
  ///
  /// In en, this message translates to:
  /// **'Essential Chinese Phrases for Beginners'**
  String get essentialChinesePhrasesForBeginners1;

  /// No description provided for @makingBambooFurniture1.
  ///
  /// In en, this message translates to:
  /// **'Making Bamboo Furniture'**
  String get makingBambooFurniture1;

  /// No description provided for @muddyPuddlesBeginnerFriendly1.
  ///
  /// In en, this message translates to:
  /// **'Muddy Puddles - Beginner Friendly'**
  String get muddyPuddlesBeginnerFriendly1;

  /// No description provided for @mandarinCorner300Verbs1.
  ///
  /// In en, this message translates to:
  /// **'Mandarin Corner: 300 Verbs'**
  String get mandarinCorner300Verbs1;

  /// No description provided for @mostCommonChineseVerbs1.
  ///
  /// In en, this message translates to:
  /// **'Most Common Chinese Verbs'**
  String get mostCommonChineseVerbs1;

  /// No description provided for @graceMandarinOrderFood1.
  ///
  /// In en, this message translates to:
  /// **'Grace Mandarin: Order Food'**
  String get graceMandarinOrderFood1;

  /// No description provided for @howToOrderFoodInAChineseRestaurant.
  ///
  /// In en, this message translates to:
  /// **'How to order food in a Chinese restaurant'**
  String get howToOrderFoodInAChineseRestaurant;

  /// No description provided for @silkFlowersTraditionalCraft1.
  ///
  /// In en, this message translates to:
  /// **'Silk Flowers - Traditional Craft'**
  String get silkFlowersTraditionalCraft1;

  /// No description provided for @goingToTheDoctorRealLifeConversatio.
  ///
  /// In en, this message translates to:
  /// **'Going to the Doctor - Real Life Conversation'**
  String get goingToTheDoctorRealLifeConversatio;

  /// No description provided for @hideAndSeekBeginnerFriendly1.
  ///
  /// In en, this message translates to:
  /// **'Hide and Seek - Beginner Friendly'**
  String get hideAndSeekBeginnerFriendly1;

  /// No description provided for @lingdp6.
  ///
  /// In en, this message translates to:
  /// **'小Lin说: 为什么GDP增长6%'**
  String get lingdp6;

  /// No description provided for @why6GdpGrowthEasyChineseEconomics.
  ///
  /// In en, this message translates to:
  /// **'Why 6% GDP Growth - Easy Chinese Economics'**
  String get why6GdpGrowthEasyChineseEconomics;

  /// No description provided for @currentEventsInSimplifiedChinese1.
  ///
  /// In en, this message translates to:
  /// **'Current Events in Simplified Chinese'**
  String get currentEventsInSimplifiedChinese1;

  /// No description provided for @baidu1.
  ///
  /// In en, this message translates to:
  /// **'Baidu'**
  String get baidu1;

  /// No description provided for @youtubeDesk1.
  ///
  /// In en, this message translates to:
  /// **'YOUTUBE DESK'**
  String get youtubeDesk1;

  /// No description provided for @interactiveTranscriptsShadowing1.
  ///
  /// In en, this message translates to:
  /// **'Interactive transcripts & shadowing'**
  String get interactiveTranscriptsShadowing1;

  /// No description provided for @showsDramas1.
  ///
  /// In en, this message translates to:
  /// **'SHOWS & DRAMAS'**
  String get showsDramas1;

  /// No description provided for @error_error.
  ///
  /// In en, this message translates to:
  /// **'Error: \$_error'**
  String get error_error;

  /// No description provided for @extractToDeck1.
  ///
  /// In en, this message translates to:
  /// **'Extract to Deck'**
  String get extractToDeck1;

  /// No description provided for @autosimplify.
  ///
  /// In en, this message translates to:
  /// **'Auto-Simplify'**
  String get autosimplify;

  /// No description provided for @rewriteThisArticleToMatchYourHskLev.
  ///
  /// In en, this message translates to:
  /// **'Rewrite this article to match your HSK level'**
  String get rewriteThisArticleToMatchYourHskLev;

  /// No description provided for @addToDeck1.
  ///
  /// In en, this message translates to:
  /// **'Add to Deck'**
  String get addToDeck1;

  /// No description provided for @playbackratex.
  ///
  /// In en, this message translates to:
  /// **'\$(playbackRate)x'**
  String get playbackratex;

  /// No description provided for @speedx.
  ///
  /// In en, this message translates to:
  /// **'\$(speed)x'**
  String get speedx;

  /// No description provided for @dailyDiscoveryDrop1.
  ///
  /// In en, this message translates to:
  /// **'Daily Discovery Drop'**
  String get dailyDiscoveryDrop1;

  /// No description provided for @smartSpacedRepetition1.
  ///
  /// In en, this message translates to:
  /// **'Smart Spaced Repetition'**
  String get smartSpacedRepetition1;

  /// No description provided for @trialProtectionAlert1.
  ///
  /// In en, this message translates to:
  /// **'Trial Protection Alert'**
  String get trialProtectionAlert1;

  /// No description provided for @masteryLevel1.
  ///
  /// In en, this message translates to:
  /// **'Mastery Level'**
  String get masteryLevel1;

  /// No description provided for @targetObjective1.
  ///
  /// In en, this message translates to:
  /// **'Target Objective'**
  String get targetObjective1;

  /// No description provided for @dailyPractice1.
  ///
  /// In en, this message translates to:
  /// **'Daily Practice'**
  String get dailyPractice1;

  /// No description provided for @aiSpacedRepetition1.
  ///
  /// In en, this message translates to:
  /// **'AI Spaced Repetition'**
  String get aiSpacedRepetition1;

  /// No description provided for @iveGrantedAccess.
  ///
  /// In en, this message translates to:
  /// **'I\'ve granted access'**
  String get iveGrantedAccess;

  /// No description provided for @addToDeck_selectedwordindiceslength.
  ///
  /// In en, this message translates to:
  /// **'Add to Deck (\$(_selectedWordIndices.length))'**
  String get addToDeck_selectedwordindiceslength;

  /// No description provided for @scanner1.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get scanner1;

  /// No description provided for @interpreter1.
  ///
  /// In en, this message translates to:
  /// **'Interpreter'**
  String get interpreter1;

  /// No description provided for @entryvalueCards.
  ///
  /// In en, this message translates to:
  /// **'\$(entry.value) cards'**
  String get entryvalueCards;

  /// No description provided for @score_score_questionslength.
  ///
  /// In en, this message translates to:
  /// **'Score: \$_score / \$(_questions.length)'**
  String get score_score_questionslength;

  /// No description provided for @theMonkeyKing1.
  ///
  /// In en, this message translates to:
  /// **'The Monkey King'**
  String get theMonkeyKing1;

  /// No description provided for @huaMulan1.
  ///
  /// In en, this message translates to:
  /// **'Hua Mulan'**
  String get huaMulan1;

  /// No description provided for @nwaMendsTheHeavens.
  ///
  /// In en, this message translates to:
  /// **'Nüwa Mends the Heavens'**
  String get nwaMendsTheHeavens;

  /// No description provided for @confucius.
  ///
  /// In en, this message translates to:
  /// **'Confucius'**
  String get confucius;

  /// No description provided for @theGreatWall1.
  ///
  /// In en, this message translates to:
  /// **'The Great Wall'**
  String get theGreatWall1;

  /// No description provided for @terracottaArmy1.
  ///
  /// In en, this message translates to:
  /// **'Terracotta Army'**
  String get terracottaArmy1;

  /// No description provided for @forbiddenCity1.
  ///
  /// In en, this message translates to:
  /// **'Forbidden City'**
  String get forbiddenCity1;

  /// No description provided for @aBlessingInDisguise1.
  ///
  /// In en, this message translates to:
  /// **'A Blessing in Disguise'**
  String get aBlessingInDisguise1;

  /// No description provided for @drawingASnake1.
  ///
  /// In en, this message translates to:
  /// **'Drawing a Snake'**
  String get drawingASnake1;

  /// No description provided for @takingTheBulletTrain1.
  ///
  /// In en, this message translates to:
  /// **'Taking the Bullet Train'**
  String get takingTheBulletTrain1;

  /// No description provided for @visitingTheDoctor1.
  ///
  /// In en, this message translates to:
  /// **'Visiting the Doctor'**
  String get visitingTheDoctor1;

  /// No description provided for @orderingDumplings1.
  ///
  /// In en, this message translates to:
  /// **'Ordering Dumplings'**
  String get orderingDumplings1;

  /// No description provided for @theTeaCeremony1.
  ///
  /// In en, this message translates to:
  /// **'The Tea Ceremony'**
  String get theTeaCeremony1;

  /// No description provided for @chineseCalligraphy1.
  ///
  /// In en, this message translates to:
  /// **'Chinese Calligraphy'**
  String get chineseCalligraphy1;

  /// No description provided for @theGiantPanda1.
  ///
  /// In en, this message translates to:
  /// **'The Giant Panda'**
  String get theGiantPanda1;

  /// No description provided for @simplifiedText1.
  ///
  /// In en, this message translates to:
  /// **'Simplified Text'**
  String get simplifiedText1;

  /// No description provided for @novels961.
  ///
  /// In en, this message translates to:
  /// **'Novels (96)'**
  String get novels961;

  /// No description provided for @microreads.
  ///
  /// In en, this message translates to:
  /// **'Micro-Reads'**
  String get microreads;

  /// No description provided for @poetry1.
  ///
  /// In en, this message translates to:
  /// **'Poetry'**
  String get poetry1;

  /// No description provided for @readingVocabulary1.
  ///
  /// In en, this message translates to:
  /// **'Reading & Vocabulary'**
  String get readingVocabulary1;
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
