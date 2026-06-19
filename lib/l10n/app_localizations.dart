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

  /// No description provided for @hapticsDesc.
  ///
  /// In en, this message translates to:
  /// **'Haptics Desc'**
  String get hapticsDesc;

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
