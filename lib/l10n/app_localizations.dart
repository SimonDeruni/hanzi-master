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
import 'app_localizations_th.dart';
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
    Locale('th'),
    Locale('vi')
  ];

  /// No description provided for @originStoryChip.
  ///
  /// In en, this message translates to:
  /// **'📜 Origin story'**
  String get originStoryChip;

  /// No description provided for @ancientFormChip.
  ///
  /// In en, this message translates to:
  /// **'🏺 Ancient form'**
  String get ancientFormChip;

  /// No description provided for @threeMoreWordsChip.
  ///
  /// In en, this message translates to:
  /// **'📖 3 more words'**
  String get threeMoreWordsChip;

  /// No description provided for @wordFamilyChip.
  ///
  /// In en, this message translates to:
  /// **'🔗 Word family'**
  String get wordFamilyChip;

  /// No description provided for @idiomChip.
  ///
  /// In en, this message translates to:
  /// **'🀄 Idiom'**
  String get idiomChip;

  /// No description provided for @proverbChip.
  ///
  /// In en, this message translates to:
  /// **'💬 Proverb'**
  String get proverbChip;

  /// No description provided for @strokeOrderChip.
  ///
  /// In en, this message translates to:
  /// **'✏️ Stroke order'**
  String get strokeOrderChip;

  /// No description provided for @calligraphyTipChip.
  ///
  /// In en, this message translates to:
  /// **'🎨 Calligraphy tip'**
  String get calligraphyTipChip;

  /// No description provided for @grammarNoteChip.
  ///
  /// In en, this message translates to:
  /// **'📝 Grammar note'**
  String get grammarNoteChip;

  /// No description provided for @similarWordsChip.
  ///
  /// In en, this message translates to:
  /// **'🔄 Similar words'**
  String get similarWordsChip;

  /// No description provided for @culturalNoteChip.
  ///
  /// In en, this message translates to:
  /// **'🏮 Cultural note'**
  String get culturalNoteChip;

  /// No description provided for @inMediaChip.
  ///
  /// In en, this message translates to:
  /// **'🀄 In media'**
  String get inMediaChip;

  /// No description provided for @radicalMeaningChip.
  ///
  /// In en, this message translates to:
  /// **'🧩 Radical meaning'**
  String get radicalMeaningChip;

  /// No description provided for @componentBreakdownChip.
  ///
  /// In en, this message translates to:
  /// **'🔍 Component breakdown'**
  String get componentBreakdownChip;

  /// No description provided for @toneTipChip.
  ///
  /// In en, this message translates to:
  /// **'🎵 Tone tip'**
  String get toneTipChip;

  /// No description provided for @homophonesChip.
  ///
  /// In en, this message translates to:
  /// **'👯 Homophones'**
  String get homophonesChip;

  /// No description provided for @askMeAnythingAbout.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything about {hanzi}...'**
  String askMeAnythingAbout(String hanzi);

  /// No description provided for @aiTutorError.
  ///
  /// In en, this message translates to:
  /// **'AI tutor error: {error}'**
  String aiTutorError(String error);

  /// No description provided for @aiTutorRateLimit.
  ///
  /// In en, this message translates to:
  /// **'The AI tutor is busy right now. Please wait a moment and try again.'**
  String get aiTutorRateLimit;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account'**
  String get deleteAccountSubtitle;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account?'**
  String get deleteAccountTitle;

  /// No description provided for @accountDataDeletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account data will be deleted'**
  String get accountDataDeletedTitle;

  /// No description provided for @accountDataDeletedBody.
  ///
  /// In en, this message translates to:
  /// **'Your sign-in account and account information held by SinoSpark will be permanently deleted. This cannot be undone.'**
  String get accountDataDeletedBody;

  /// No description provided for @localDataKeptTitle.
  ///
  /// In en, this message translates to:
  /// **'Data on this device will remain'**
  String get localDataKeptTitle;

  /// No description provided for @localDataKeptBody.
  ///
  /// In en, this message translates to:
  /// **'Study progress, downloaded content, and preferences stored only on this device will not be removed.'**
  String get localDataKeptBody;

  /// No description provided for @subscriptionNotCanceledTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions are not canceled'**
  String get subscriptionNotCanceledTitle;

  /// No description provided for @subscriptionNotCanceledBody.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account does not cancel an App Store subscription. It may continue to renew until you cancel it with Apple.'**
  String get subscriptionNotCanceledBody;

  /// No description provided for @manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage App Store Subscription'**
  String get manageSubscription;

  /// No description provided for @subscriptionManagementFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open Apple subscription management. Open Settings, tap your name, then tap Subscriptions.'**
  String get subscriptionManagementFailed;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordToDelete.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to confirm your identity.'**
  String get confirmPasswordToDelete;

  /// No description provided for @deleteAccountPermanently.
  ///
  /// In en, this message translates to:
  /// **'Delete Account Permanently'**
  String get deleteAccountPermanently;

  /// No description provided for @deleteAccountFinalTitle.
  ///
  /// In en, this message translates to:
  /// **'Final confirmation'**
  String get deleteAccountFinalTitle;

  /// No description provided for @deleteAccountFinalWarning.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account and cannot be undone. Data stored only on this device will remain. Continue?'**
  String get deleteAccountFinalWarning;

  /// No description provided for @deletingAccount.
  ///
  /// In en, this message translates to:
  /// **'Deleting account...'**
  String get deletingAccount;

  /// No description provided for @accountPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password to continue.'**
  String get accountPasswordRequired;

  /// No description provided for @accountPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'The password is incorrect. Please try again.'**
  String get accountPasswordIncorrect;

  /// No description provided for @accountReauthenticationCanceled.
  ///
  /// In en, this message translates to:
  /// **'Identity confirmation was canceled. Your account was not deleted.'**
  String get accountReauthenticationCanceled;

  /// No description provided for @accountReauthenticationFailed.
  ///
  /// In en, this message translates to:
  /// **'We could not confirm your identity. Please try again and complete the sign-in prompt.'**
  String get accountReauthenticationFailed;

  /// No description provided for @accountAlreadySignedOut.
  ///
  /// In en, this message translates to:
  /// **'You are already signed out. No signed-in account was deleted.'**
  String get accountAlreadySignedOut;

  /// No description provided for @accountProviderUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method cannot be verified in the app. Contact support for help deleting the account.'**
  String get accountProviderUnsupported;

  /// No description provided for @appleDeletionRequiresAppleDevice.
  ///
  /// In en, this message translates to:
  /// **'For security, an account linked to Apple must be deleted on an Apple device.'**
  String get appleDeletionRequiresAppleDevice;

  /// No description provided for @accountDeletionNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try deleting the account again.'**
  String get accountDeletionNetworkError;

  /// No description provided for @accountDeletionFailed.
  ///
  /// In en, this message translates to:
  /// **'The account could not be deleted. Your account remains active. Please try again.'**
  String get accountDeletionFailed;

  /// No description provided for @accountDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your account was permanently deleted.'**
  String get accountDeletedSuccessfully;

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
  String cardsRequireAttention(Object count);

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
  /// **'Start session'**
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
  String partner(Object lang);

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
  String hideStrokeGuideStreak(Object streak);

  /// No description provided for @inkPoints.
  ///
  /// In en, this message translates to:
  /// **'(points) Ink Points'**
  String inkPoints(Object points);

  /// No description provided for @speechRateMultiplier.
  ///
  /// In en, this message translates to:
  /// **'(rate)x'**
  String speechRateMultiplier(Object rate);

  /// No description provided for @animationSpeedMultiplier.
  ///
  /// In en, this message translates to:
  /// **'(rate)x'**
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
  /// **'Follow the blue guide to draw stroke (current) of (total)'**
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
  /// **'Added (hanzi) to (deckName)'**
  String addedToDeck(Object deckName, Object hanzi);

  /// No description provided for @removedFromDeck.
  ///
  /// In en, this message translates to:
  /// **'Removed (hanzi) from deck'**
  String removedFromDeck(Object hanzi);

  /// No description provided for @skippedNoStrokeData.
  ///
  /// In en, this message translates to:
  /// **'Skipped \"(hanzi)\" - No stroke data available for this AI character.'**
  String skippedNoStrokeData(Object hanzi);

  /// No description provided for @startingSession.
  ///
  /// In en, this message translates to:
  /// **'Starting session...'**
  String get startingSession;

  /// No description provided for @studySession.
  ///
  /// In en, this message translates to:
  /// **'Study session'**
  String get studySession;

  /// No description provided for @readyToStudy.
  ///
  /// In en, this message translates to:
  /// **'Ready to study'**
  String get readyToStudy;

  /// No description provided for @studyQueuePreviewDescription.
  ///
  /// In en, this message translates to:
  /// **'Your session is based on today\'s schedule and deck limits.'**
  String get studyQueuePreviewDescription;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @studyDeckEmpty.
  ///
  /// In en, this message translates to:
  /// **'This deck is empty'**
  String get studyDeckEmpty;

  /// No description provided for @studyDeckEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Add cards before starting a study session.'**
  String get studyDeckEmptyDescription;

  /// No description provided for @studyDailyLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Today\'s limit is complete'**
  String get studyDailyLimitReached;

  /// No description provided for @studyDailyLimitReachedDescription.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used this deck\'s new-card or review allowance for today.'**
  String get studyDailyLimitReachedDescription;

  /// No description provided for @studyCaughtUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Nothing else is scheduled for today. Come back for the next review.'**
  String get studyCaughtUpDescription;

  /// No description provided for @noCardsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No cards available'**
  String get noCardsAvailable;

  /// No description provided for @studyNoEligibleCardsDescription.
  ///
  /// In en, this message translates to:
  /// **'No cards are eligible for this study mode right now.'**
  String get studyNoEligibleCardsDescription;

  /// No description provided for @studySessionLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load this study session. Please try again.'**
  String get studySessionLoadFailed;

  /// No description provided for @retryLimitReached.
  ///
  /// In en, this message translates to:
  /// **'This card will return in your next session.'**
  String get retryLimitReached;

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
  String storyTitleHsk(Object level, Object title);

  /// No description provided for @pleaseEnterTopic.
  ///
  /// In en, this message translates to:
  /// **'Please enter a topic'**
  String get pleaseEnterTopic;

  /// No description provided for @createdDeckCards.
  ///
  /// In en, this message translates to:
  /// **'Created (name) with (count) cards!'**
  String createdDeckCards(Object count, Object name);

  /// No description provided for @gradeResult.
  ///
  /// In en, this message translates to:
  /// **'Grade: (grade)'**
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
  /// **'Added (char) to Library'**
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
  String addedToLibrary(Object hanzi);

  /// No description provided for @generateNewStory.
  ///
  /// In en, this message translates to:
  /// **'Generate New Story'**
  String get generateNewStory;

  /// No description provided for @failedToGenerateStory.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate story:\\n(error)'**
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
  /// **'HSK 2 (Elementary)'**
  String get hsk2Elementary;

  /// No description provided for @hsk3Intermediate.
  ///
  /// In en, this message translates to:
  /// **'HSK 3 (Intermediate)'**
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
  String addTo(Object target);

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
  /// **'HSK 5 (Advanced)'**
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
  String play(Object pinyin);

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

  /// No description provided for @aiDataPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Data & Privacy'**
  String get aiDataPrivacyTitle;

  /// No description provided for @aiDataPrivacySettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See what AI features send, why, and to whom'**
  String get aiDataPrivacySettingsSubtitle;

  /// No description provided for @aiDataPrivacyOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'When AI is used'**
  String get aiDataPrivacyOverviewTitle;

  /// No description provided for @aiDataPrivacyOverviewBody.
  ///
  /// In en, this message translates to:
  /// **'SinoSpark uses cloud AI only when you choose a feature that needs it, such as AI chat, explanations, translation, image analysis, speech recognition, pronunciation grading, or cloud voices. AI output can be inaccurate, so review important results.'**
  String get aiDataPrivacyOverviewBody;

  /// No description provided for @aiDataPrivacyProvidersTitle.
  ///
  /// In en, this message translates to:
  /// **'AI service providers'**
  String get aiDataPrivacyProvidersTitle;

  /// No description provided for @aiDataPrivacyProvidersBody.
  ///
  /// In en, this message translates to:
  /// **'Google Gemini processes generative text and image requests. OpenRouter routes some generative requests to Google Gemini or DeepSeek. Microsoft Azure AI Speech processes speech recognition, pronunciation assessment, and text sent for cloud voice synthesis.'**
  String get aiDataPrivacyProvidersBody;

  /// No description provided for @aiDataPrivacySentTitle.
  ///
  /// In en, this message translates to:
  /// **'Data that may be sent'**
  String get aiDataPrivacySentTitle;

  /// No description provided for @aiDataPrivacySentBody.
  ///
  /// In en, this message translates to:
  /// **'Depending on the feature, we send the text you enter or select, relevant conversation or lesson context, images you choose for AI analysis, voice recordings you submit, and technical request data such as IP address and device/network metadata. We do not intentionally include your name or email in AI prompts.'**
  String get aiDataPrivacySentBody;

  /// No description provided for @aiDataPrivacyControlsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your choices'**
  String get aiDataPrivacyControlsTitle;

  /// No description provided for @aiDataPrivacyControlsBody.
  ///
  /// In en, this message translates to:
  /// **'Do not use an AI feature if you do not want its input sent to the named provider. You can deny camera, photo, or microphone permission in device Settings. Choose the Local voice to keep text-to-speech on your device. Avoid submitting sensitive or confidential information.'**
  String get aiDataPrivacyControlsBody;

  /// No description provided for @aiDataPrivacyRetentionTitle.
  ///
  /// In en, this message translates to:
  /// **'Storage and retention'**
  String get aiDataPrivacyRetentionTitle;

  /// No description provided for @aiDataPrivacyRetentionBody.
  ///
  /// In en, this message translates to:
  /// **'SinoSpark does not intentionally store raw AI prompts, submitted images, or voice recordings on its own servers after processing. Generated results may be saved on your device or with your account when you choose to save them. Providers process data under their own terms and configured retention controls; see the full policy for details.'**
  String get aiDataPrivacyRetentionBody;

  /// No description provided for @readFullPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Read Full Privacy Policy'**
  String get readFullPrivacyPolicy;

  /// No description provided for @linkOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link. Please try again.'**
  String get linkOpenFailed;

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
  String score(Object score, Object total);

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
  String you(Object lang);

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
  String added_to_your_library(Object hanzi);

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
  String analysis_failed(Object error);

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
  String chapters(Object count);

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
  String error_creating_scenario(Object error);

  /// No description provided for @error_fetching_translation_for.
  ///
  /// In en, this message translates to:
  /// **'Error fetching translation for : (error)'**
  String error_fetching_translation_for(Object error);

  /// No description provided for @error_loading_chapters.
  ///
  /// In en, this message translates to:
  /// **'Error loading chapters: (error)'**
  String error_loading_chapters(Object error);

  /// No description provided for @error_loading_decks.
  ///
  /// In en, this message translates to:
  /// **'Error loading decks'**
  String get error_loading_decks;

  /// No description provided for @error_loading_microreads.
  ///
  /// In en, this message translates to:
  /// **'Error loading micro-reads: (error)'**
  String error_loading_microreads(Object error);

  /// No description provided for @error_loading_novels.
  ///
  /// In en, this message translates to:
  /// **'Error loading novels: (error)'**
  String error_loading_novels(Object error);

  /// No description provided for @error_loading_poetry.
  ///
  /// In en, this message translates to:
  /// **'Error loading poetry: (error)'**
  String error_loading_poetry(Object error);

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
  String extraction_failed(Object error);

  /// No description provided for @failed_to_download.
  ///
  /// In en, this message translates to:
  /// **'Failed to download.'**
  String get failed_to_download;

  /// No description provided for @failed_to_generate_scenario.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate scenario: (error)'**
  String failed_to_generate_scenario(Object error);

  /// No description provided for @failed_to_generate_story.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate story:\\n(error)'**
  String failed_to_generate_story(Object error);

  /// No description provided for @failed_to_load_context.
  ///
  /// In en, this message translates to:
  /// **'Failed to load context: (error)rr'**
  String failed_to_load_context(Object error);

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
  String hsk(Object level);

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
  String no_results_found_for(Object searchQuery);

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
  String question(Object current, Object total);

  /// No description provided for @remove_from_this_deck.
  ///
  /// In en, this message translates to:
  /// **'Remove {hanzi} from this deck?'**
  String remove_from_this_deck(String hanzi);

  /// No description provided for @revenuecat_error.
  ///
  /// In en, this message translates to:
  /// **'RevenueCat Error: (error)'**
  String revenuecat_error(Object error);

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
  String simplify_failed(Object error);

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
  String translation_failed(Object error);

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
  String vocabularyBatch(Object index);

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
  String unnamedKey(Object tag);

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: (error)'**
  String error(Object error);

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
  String failedToSaveExtractedWords(Object error);

  /// No description provided for @addToDeck.
  ///
  /// In en, this message translates to:
  /// **'Add to Deck ((count))'**
  String addToDeck(Object count);

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
  String cards(Object count);

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
  String bookmarkAdded(Object chapter);

  /// No description provided for @readingVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Reading & Vocabulary'**
  String get readingVocabulary;

  /// No description provided for @vocabularyBatchUnitindex1.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary Batch \$(unitIndex + 1)'**
  String vocabularyBatchUnitindex1(Object index);

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
  String ui__transcription(Object transcription);

  /// No description provided for @playPinyinwithtone.
  ///
  /// In en, this message translates to:
  /// **'Play \$pinyinWithTone'**
  String playPinyinwithtone(Object pinyinWithTone);

  /// No description provided for @errorE.
  ///
  /// In en, this message translates to:
  /// **'Error: \$e'**
  String errorE(Object e);

  /// No description provided for @lookalikepinyin.
  ///
  /// In en, this message translates to:
  /// **'(\$(lookAlike.pinyin))'**
  String lookalikepinyin(Object pinyin);

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
  String errorErr(Object err, Object error);

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
  String ui__currentstrokeindex1totalstrokes(Object current, Object total);

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
  String accuracytostringasfixed1(Object accuracy);

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
  String entryhanziEntrypinyin(Object hanzi, Object pinyin);

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
  String acc(Object acc);

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
  String error_error(Object error);

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
  String playbackratex(Object playbackRate);

  /// No description provided for @speedx.
  ///
  /// In en, this message translates to:
  /// **'\$(speed)x'**
  String speedx(Object speed);

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
  String addToDeck_selectedwordindiceslength(Object count);

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
  String entryvalueCards(Object count);

  /// No description provided for @score_score_questionslength.
  ///
  /// In en, this message translates to:
  /// **'Score: \$_score / \$(_questions.length)'**
  String score_score_questionslength(Object score, Object total);

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

  /// No description provided for @defaultfirebaseoptionsHaveNotBeenCo.
  ///
  /// In en, this message translates to:
  /// **'DefaultFirebaseOptions have not been configured for linux -'**
  String get defaultfirebaseoptionsHaveNotBeenCo;

  /// No description provided for @defaultfirebaseoptionsAreNotSupport.
  ///
  /// In en, this message translates to:
  /// **'DefaultFirebaseOptions are not supported for this platform.'**
  String get defaultfirebaseoptionsAreNotSupport;

  /// No description provided for @hanziMaster1.
  ///
  /// In en, this message translates to:
  /// **'Hanzi Master'**
  String get hanziMaster1;

  /// No description provided for @strokesCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Strokes cannot be empty.'**
  String get strokesCannotBeEmpty;

  /// No description provided for @wrongStartPoint.
  ///
  /// In en, this message translates to:
  /// **'Wrong start point.'**
  String get wrongStartPoint;

  /// No description provided for @rightShapeButWrongPlace.
  ///
  /// In en, this message translates to:
  /// **'Right shape, but wrong place!'**
  String get rightShapeButWrongPlace;

  /// No description provided for @goodFollowTheFlow.
  ///
  /// In en, this message translates to:
  /// **'Good!\') : \'Follow the flow.'**
  String get goodFollowTheFlow;

  /// No description provided for @aBitShaky.
  ///
  /// In en, this message translates to:
  /// **'A bit shaky!'**
  String get aBitShaky;

  /// No description provided for @aBitHesitant.
  ///
  /// In en, this message translates to:
  /// **'A bit hesitant...'**
  String get aBitHesitant;

  /// No description provided for @shapeIsOff.
  ///
  /// In en, this message translates to:
  /// **'Shape is off.'**
  String get shapeIsOff;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @indonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get indonesian;

  /// No description provided for @italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get italian;

  /// No description provided for @japanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japanese;

  /// No description provided for @korean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get korean;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @microphonePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission denied'**
  String get microphonePermissionDenied;

  /// No description provided for @offset.
  ///
  /// In en, this message translates to:
  /// **'Offset'**
  String get offset;

  /// No description provided for @audioserviceHasBeenDisposed.
  ///
  /// In en, this message translates to:
  /// **'AudioService has been disposed'**
  String get audioserviceHasBeenDisposed;

  /// No description provided for @fenrirZhcnyunxineural.
  ///
  /// In en, this message translates to:
  /// **'Fenrir\': \'zh-CN-YunxiNeural'**
  String get fenrirZhcnyunxineural;

  /// No description provided for @charonZhcnyunyangneural.
  ///
  /// In en, this message translates to:
  /// **'Charon\': \'zh-CN-YunyangNeural'**
  String get charonZhcnyunyangneural;

  /// No description provided for @koreZhcnxiaoxiaoneural.
  ///
  /// In en, this message translates to:
  /// **'Kore\': \'zh-CN-XiaoxiaoNeural'**
  String get koreZhcnxiaoxiaoneural;

  /// No description provided for @aoedeZhcnxiaoyineural.
  ///
  /// In en, this message translates to:
  /// **'Aoede\': \'zh-CN-XiaoyiNeural'**
  String get aoedeZhcnxiaoyineural;

  /// No description provided for @puckZhcnyunjianneural.
  ///
  /// In en, this message translates to:
  /// **'Puck\': \'zh-CN-YunjianNeural'**
  String get puckZhcnyunjianneural;

  /// No description provided for @kore.
  ///
  /// In en, this message translates to:
  /// **'Kore'**
  String get kore;

  /// No description provided for @xmicrosoftoutputformatAudio24khz48k.
  ///
  /// In en, this message translates to:
  /// **'X-Microsoft-OutputFormat\': \'audio-24khz-48kbitrate-mono-mp3'**
  String get xmicrosoftoutputformatAudio24khz48k;

  /// No description provided for @useragentHanzimasterapp.
  ///
  /// In en, this message translates to:
  /// **'User-Agent\': \'HanziMasterApp'**
  String get useragentHanzimasterapp;

  /// No description provided for @anchorWord.
  ///
  /// In en, this message translates to:
  /// **'Anchor Word'**
  String get anchorWord;

  /// No description provided for @creativeThematicTitle.
  ///
  /// In en, this message translates to:
  /// **'Creative Thematic Title'**
  String get creativeThematicTitle;

  /// No description provided for @briefPedagogicalOrSemanticRationale.
  ///
  /// In en, this message translates to:
  /// **'Brief pedagogical or semantic rationale'**
  String get briefPedagogicalOrSemanticRationale;

  /// No description provided for @theSingleMostCentralCharacterFromTh.
  ///
  /// In en, this message translates to:
  /// **'The single most central character from the list'**
  String get theSingleMostCentralCharacterFromTh;

  /// No description provided for @aBalancedSetOfCharactersFromYourLib.
  ///
  /// In en, this message translates to:
  /// **'A balanced set of characters from your library.'**
  String get aBalancedSetOfCharactersFromYourLib;

  /// No description provided for @yourNaturalConversationalReplyInChi.
  ///
  /// In en, this message translates to:
  /// **'Your natural conversational reply in Chinese characters.'**
  String get yourNaturalConversationalReplyInChi;

  /// No description provided for @theEnglishTranslationOfYourReply.
  ///
  /// In en, this message translates to:
  /// **'The English translation of your reply.'**
  String get theEnglishTranslationOfYourReply;

  /// No description provided for @thePinyinWithToneMarksForYourReply.
  ///
  /// In en, this message translates to:
  /// **'The Pinyin with tone marks for your reply.'**
  String get thePinyinWithToneMarksForYourReply;

  /// No description provided for @aSuggestedResponseTheUserCouldSayBa.
  ///
  /// In en, this message translates to:
  /// **'A suggested response the user could say back to you.'**
  String get aSuggestedResponseTheUserCouldSayBa;

  /// No description provided for @pinyinForTheSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Pinyin for the suggestion.'**
  String get pinyinForTheSuggestion;

  /// No description provided for @englishTranslationForTheSuggestion.
  ///
  /// In en, this message translates to:
  /// **'English translation for the suggestion.'**
  String get englishTranslationForTheSuggestion;

  /// No description provided for @scholarsCritique.
  ///
  /// In en, this message translates to:
  /// **'Scholar\'s Critique'**
  String get scholarsCritique;

  /// No description provided for @theEchoHallRemainsSilentTryYourBrea.
  ///
  /// In en, this message translates to:
  /// **'The Echo Hall remains silent. Try your breath again.'**
  String get theEchoHallRemainsSilentTryYourBrea;

  /// No description provided for @xtitleHanziMaster.
  ///
  /// In en, this message translates to:
  /// **'X-Title\': \'Hanzi Master'**
  String get xtitleHanziMaster;

  /// No description provided for @noneYet.
  ///
  /// In en, this message translates to:
  /// **'None yet.'**
  String get noneYet;

  /// No description provided for @exactSentence.
  ///
  /// In en, this message translates to:
  /// **'Exact Sentence:'**
  String get exactSentence;

  /// No description provided for @englishTranslation.
  ///
  /// In en, this message translates to:
  /// **'English translation'**
  String get englishTranslation;

  /// No description provided for @previouslyGeneratedPhrases.
  ///
  /// In en, this message translates to:
  /// **'Previously generated phrases'**
  String get previouslyGeneratedPhrases;

  /// No description provided for @iLikeDrinkingAppleJuice.
  ///
  /// In en, this message translates to:
  /// **'I like drinking apple juice.'**
  String get iLikeDrinkingAppleJuice;

  /// No description provided for @theEnglishMeaningHere.
  ///
  /// In en, this message translates to:
  /// **'The English meaning here...'**
  String get theEnglishMeaningHere;

  /// No description provided for @failedToFetchDefinition.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch definition.'**
  String get failedToFetchDefinition;

  /// No description provided for @failedToLoadExplanation.
  ///
  /// In en, this message translates to:
  /// **'Failed to load explanation.'**
  String get failedToLoadExplanation;

  /// No description provided for @failedToLoadComparison.
  ///
  /// In en, this message translates to:
  /// **'Failed to load comparison.'**
  String get failedToLoadComparison;

  /// No description provided for @emptyResponseFromOpenrouter.
  ///
  /// In en, this message translates to:
  /// **'Empty response from OpenRouter'**
  String get emptyResponseFromOpenrouter;

  /// No description provided for @emptyResponseFromVisionModel.
  ///
  /// In en, this message translates to:
  /// **'Empty response from Vision model'**
  String get emptyResponseFromVisionModel;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @theFullSentenceInChinese.
  ///
  /// In en, this message translates to:
  /// **'The full sentence in Chinese...'**
  String get theFullSentenceInChinese;

  /// No description provided for @theWordOrCharacterInChinese.
  ///
  /// In en, this message translates to:
  /// **'The word or character in Chinese'**
  String get theWordOrCharacterInChinese;

  /// No description provided for @thePinyinForThisSpecificWord.
  ///
  /// In en, this message translates to:
  /// **'The pinyin for this specific word'**
  String get thePinyinForThisSpecificWord;

  /// No description provided for @emptyResponseFromDeepseekApi.
  ///
  /// In en, this message translates to:
  /// **'Empty response from DeepSeek API'**
  String get emptyResponseFromDeepseekApi;

  /// No description provided for @criticalPutTheEnglishTranslationInT.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL: Put the English translation in the'**
  String get criticalPutTheEnglishTranslationInT;

  /// No description provided for @englishTranslationOfTheEntireSenten.
  ///
  /// In en, this message translates to:
  /// **'English translation of the entire sentence'**
  String get englishTranslationOfTheEntireSenten;

  /// No description provided for @hanziWord.
  ///
  /// In en, this message translates to:
  /// **'Hanzi word'**
  String get hanziWord;

  /// No description provided for @theFullSimplifiedSentenceInChinese.
  ///
  /// In en, this message translates to:
  /// **'The full simplified sentence in Chinese...'**
  String get theFullSimplifiedSentenceInChinese;

  /// No description provided for @lyingFlatACulturalMovement.
  ///
  /// In en, this message translates to:
  /// **'Lying flat: A cultural movement...'**
  String get lyingFlatACulturalMovement;

  /// No description provided for @theUserYouAreSpeakingToIsNamed.
  ///
  /// In en, this message translates to:
  /// **'The user you are speaking to is named'**
  String get theUserYouAreSpeakingToIsNamed;

  /// No description provided for @importantRuleDoNotAddressTheUserByA.
  ///
  /// In en, this message translates to:
  /// **'IMPORTANT RULE: Do not address the user by any name. Never use placeholder names like'**
  String get importantRuleDoNotAddressTheUserByA;

  /// No description provided for @youAreAConciseChineseCalligraphyAnd.
  ///
  /// In en, this message translates to:
  /// **'You are a concise Chinese Calligraphy and Etymology tutor inside a mobile flashcard app.'**
  String get youAreAConciseChineseCalligraphyAnd;

  /// No description provided for @theStudentIsStudyingTheCharacter.
  ///
  /// In en, this message translates to:
  /// **'The student is studying the character'**
  String get theStudentIsStudyingTheCharacter;

  /// No description provided for @neverWriteIntroductionsSignoffsOrFi.
  ///
  /// In en, this message translates to:
  /// **'Never write introductions, sign-offs, or filler phrases like'**
  String get neverWriteIntroductionsSignoffsOrFi;

  /// No description provided for @beDirectAndInformative.
  ///
  /// In en, this message translates to:
  /// **'Be direct and informative.'**
  String get beDirectAndInformative;

  /// No description provided for @criticalRuleYouMustRespondEntirelyI.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL RULE: You must respond ENTIRELY in the language corresponding to ISO 639-1 code'**
  String get criticalRuleYouMustRespondEntirelyI;

  /// No description provided for @youAreAConciseChineseGrammarTutorIn.
  ///
  /// In en, this message translates to:
  /// **'You are a concise Chinese Grammar tutor inside a mobile app.'**
  String get youAreAConciseChineseGrammarTutorIn;

  /// No description provided for @theStudentIsConfusedAboutTheWord.
  ///
  /// In en, this message translates to:
  /// **'The student is confused about the word'**
  String get theStudentIsConfusedAboutTheWord;

  /// No description provided for @neverWriteIntroductionsSignoffsOrFi1.
  ///
  /// In en, this message translates to:
  /// **'Never write introductions, sign-offs, or filler phrases.'**
  String get neverWriteIntroductionsSignoffsOrFi1;

  /// No description provided for @azureSpeechApiKeysAreMissing.
  ///
  /// In en, this message translates to:
  /// **'Azure Speech API keys are missing.'**
  String get azureSpeechApiKeysAreMissing;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @granularity.
  ///
  /// In en, this message translates to:
  /// **'Granularity'**
  String get granularity;

  /// No description provided for @phoneme1.
  ///
  /// In en, this message translates to:
  /// **'Phoneme'**
  String get phoneme1;

  /// No description provided for @dimension.
  ///
  /// In en, this message translates to:
  /// **'Dimension'**
  String get dimension;

  /// No description provided for @comprehensive.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive'**
  String get comprehensive;

  /// No description provided for @weCouldntHearYouClearlyPleaseTryAga.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t hear you clearly. Please try again.'**
  String get weCouldntHearYouClearlyPleaseTryAga;

  /// No description provided for @noNbestResultFound.
  ///
  /// In en, this message translates to:
  /// **'No NBest result found.'**
  String get noNbestResultFound;

  /// No description provided for @words1.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get words1;

  /// No description provided for @word.
  ///
  /// In en, this message translates to:
  /// **'Word'**
  String get word;

  /// No description provided for @phonemes.
  ///
  /// In en, this message translates to:
  /// **'Phonemes'**
  String get phonemes;

  /// No description provided for @syllables.
  ///
  /// In en, this message translates to:
  /// **'Syllables'**
  String get syllables;

  /// No description provided for @syllable.
  ///
  /// In en, this message translates to:
  /// **'Syllable'**
  String get syllable;

  /// No description provided for @omission.
  ///
  /// In en, this message translates to:
  /// **'Omission'**
  String get omission;

  /// No description provided for @insertion.
  ///
  /// In en, this message translates to:
  /// **'Insertion'**
  String get insertion;

  /// No description provided for @youMissedThisWord.
  ///
  /// In en, this message translates to:
  /// **'You missed this word.'**
  String get youMissedThisWord;

  /// No description provided for @extraWordAddedHere.
  ///
  /// In en, this message translates to:
  /// **'Extra word added here.'**
  String get extraWordAddedHere;

  /// No description provided for @mispronunciation.
  ///
  /// In en, this message translates to:
  /// **'Mispronunciation'**
  String get mispronunciation;

  /// No description provided for @pronunciationWasInaccurate.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation was inaccurate.'**
  String get pronunciationWasInaccurate;

  /// No description provided for @goodEffortKeepPracticing.
  ///
  /// In en, this message translates to:
  /// **'Good effort! Keep practicing.'**
  String get goodEffortKeepPracticing;

  /// No description provided for @perfectPronunciationSoundsLikeANati.
  ///
  /// In en, this message translates to:
  /// **'Perfect pronunciation! Sounds like a native speaker.'**
  String get perfectPronunciationSoundsLikeANati;

  /// No description provided for @greatJobAFewMinorToneInaccuracies.
  ///
  /// In en, this message translates to:
  /// **'Great job! A few minor tone inaccuracies.'**
  String get greatJobAFewMinorToneInaccuracies;

  /// No description provided for @notBadButYourTonesNeedSomeWork.
  ///
  /// In en, this message translates to:
  /// **'Not bad, but your tones need some work.'**
  String get notBadButYourTonesNeedSomeWork;

  /// No description provided for @keepPracticingListenToTheNativeAudi.
  ///
  /// In en, this message translates to:
  /// **'Keep practicing! Listen to the native audio and try again.'**
  String get keepPracticingListenToTheNativeAudi;

  /// No description provided for @lexical.
  ///
  /// In en, this message translates to:
  /// **'Lexical'**
  String get lexical;

  /// No description provided for @chineseHanziHere.
  ///
  /// In en, this message translates to:
  /// **'Chinese Hanzi here'**
  String get chineseHanziHere;

  /// No description provided for @aShortSummaryInEnglish.
  ///
  /// In en, this message translates to:
  /// **'A short summary in English'**
  String get aShortSummaryInEnglish;

  /// No description provided for @noCoherentChineseTextFoundInTheScan.
  ///
  /// In en, this message translates to:
  /// **'No coherent Chinese text found in the scan.'**
  String get noCoherentChineseTextFoundInTheScan;

  /// No description provided for @theFullEnglishTranslationOfTheScann.
  ///
  /// In en, this message translates to:
  /// **'The full English translation of the scanned text... OR \'No coherent Chinese text found.\''**
  String get theFullEnglishTranslationOfTheScann;

  /// No description provided for @aShort24WordTitleForThisScanEgResta.
  ///
  /// In en, this message translates to:
  /// **'A short 2-4 word title for this scan (e.g. \'Restaurant Menu\', \'Street Sign\')'**
  String get aShort24WordTitleForThisScanEgResta;

  /// No description provided for @china.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get china;

  /// No description provided for @noTranslationAvailable.
  ///
  /// In en, this message translates to:
  /// **'No translation available.'**
  String get noTranslationAvailable;

  /// No description provided for @scanResults.
  ///
  /// In en, this message translates to:
  /// **'Scan Results'**
  String get scanResults;

  /// No description provided for @whenWasItWrittenAndWhatWasHappening.
  ///
  /// In en, this message translates to:
  /// **'When was it written and what was happening in China at the time?'**
  String get whenWasItWrittenAndWhatWasHappening;

  /// No description provided for @whyIsThisPieceFamousWhatPhilosophic.
  ///
  /// In en, this message translates to:
  /// **'Why is this piece famous? What philosophical or cultural themes does it explore?'**
  String get whyIsThisPieceFamousWhatPhilosophic;

  /// No description provided for @aBriefBioOfTheAuthor.
  ///
  /// In en, this message translates to:
  /// **'A brief bio of the author.'**
  String get aBriefBioOfTheAuthor;

  /// No description provided for @informationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Information unavailable.'**
  String get informationUnavailable;

  /// No description provided for @noSummaryAvailable.
  ///
  /// In en, this message translates to:
  /// **'No summary available.'**
  String get noSummaryAvailable;

  /// No description provided for @hanziAiPro.
  ///
  /// In en, this message translates to:
  /// **'Hanzi AI Pro'**
  String get hanziAiPro;

  /// No description provided for @trialNormalIntro.
  ///
  /// In en, this message translates to:
  /// **'TRIAL\', \'NORMAL\', \'INTRO'**
  String get trialNormalIntro;

  /// No description provided for @dailyDrop.
  ///
  /// In en, this message translates to:
  /// **'Daily Drop'**
  String get dailyDrop;

  /// No description provided for @dailyNotificationsForWordOfTheDayAn.
  ///
  /// In en, this message translates to:
  /// **'Daily notifications for Word of the Day and news'**
  String get dailyNotificationsForWordOfTheDayAn;

  /// No description provided for @aNewWordAndStoryOfTheDayAreWaitingF.
  ///
  /// In en, this message translates to:
  /// **'A new Word and Story of the Day are waiting for you!'**
  String get aNewWordAndStoryOfTheDayAreWaitingF;

  /// No description provided for @spacedRepetition.
  ///
  /// In en, this message translates to:
  /// **'Spaced Repetition'**
  String get spacedRepetition;

  /// No description provided for @remindersForFlashcardsDueForReview.
  ///
  /// In en, this message translates to:
  /// **'Reminders for flashcards due for review'**
  String get remindersForFlashcardsDueForReview;

  /// No description provided for @engagementReminders.
  ///
  /// In en, this message translates to:
  /// **'Engagement Reminders'**
  String get engagementReminders;

  /// No description provided for @trialReminders.
  ///
  /// In en, this message translates to:
  /// **'Trial Reminders'**
  String get trialReminders;

  /// No description provided for @notificationsForYourTrialStatus.
  ///
  /// In en, this message translates to:
  /// **'Notifications for your trial status'**
  String get notificationsForYourTrialStatus;

  /// No description provided for @comeReviewYourHanziAndTryALiveCallB.
  ///
  /// In en, this message translates to:
  /// **'Come review your Hanzi and try a Live Call before your free access ends!'**
  String get comeReviewYourHanziAndTryALiveCallB;

  /// No description provided for @scholarsEye.
  ///
  /// In en, this message translates to:
  /// **'Scholar\'s Eye'**
  String get scholarsEye;

  /// No description provided for @clMeasureWord.
  ///
  /// In en, this message translates to:
  /// **'CL:\', \'Measure word:'**
  String get clMeasureWord;

  /// No description provided for @surnameShi.
  ///
  /// In en, this message translates to:
  /// **'Surname Shi'**
  String get surnameShi;

  /// No description provided for @chineseFamilyNameShi.
  ///
  /// In en, this message translates to:
  /// **'Chinese family name (Shi)'**
  String get chineseFamilyNameShi;

  /// No description provided for @neutralToneLight.
  ///
  /// In en, this message translates to:
  /// **'Neutral Tone (Light)'**
  String get neutralToneLight;

  /// No description provided for @keepYourPitchHighAndSteadyLikeSingi.
  ///
  /// In en, this message translates to:
  /// **'Keep your pitch high and steady like singing a note.'**
  String get keepYourPitchHighAndSteadyLikeSingi;

  /// No description provided for @startInTheMiddleAndSlideYourPitchUp.
  ///
  /// In en, this message translates to:
  /// **'Start in the middle and slide your pitch upward like asking \'What?\''**
  String get startInTheMiddleAndSlideYourPitchUp;

  /// No description provided for @dipYourVoiceDownLowThenRiseGentlyBa.
  ///
  /// In en, this message translates to:
  /// **'Dip your voice down low, then rise gently back up.'**
  String get dipYourVoiceDownLowThenRiseGentlyBa;

  /// No description provided for @dropYourPitchSharplyAndDecisivelyLi.
  ///
  /// In en, this message translates to:
  /// **'Drop your pitch sharply and decisively like a firm \'No!\''**
  String get dropYourPitchSharplyAndDecisivelyLi;

  /// No description provided for @pronounceSoftlyBrieflyAndWithoutEmp.
  ///
  /// In en, this message translates to:
  /// **'Pronounce softly, briefly, and without emphasis.'**
  String get pronounceSoftlyBrieflyAndWithoutEmp;

  /// No description provided for @spotOnPitchWasHighFlatAndSteady.
  ///
  /// In en, this message translates to:
  /// **'Spot on! Pitch was high, flat, and steady.'**
  String get spotOnPitchWasHighFlatAndSteady;

  /// No description provided for @spotOnUpwardPitchRiseWasClear.
  ///
  /// In en, this message translates to:
  /// **'Spot on! Upward pitch rise was clear.'**
  String get spotOnUpwardPitchRiseWasClear;

  /// No description provided for @spotOnLowDippingCurveWasAccurate.
  ///
  /// In en, this message translates to:
  /// **'Spot on! Low dipping curve was accurate.'**
  String get spotOnLowDippingCurveWasAccurate;

  /// No description provided for @spotOnSharpFallingDropWasDecisive.
  ///
  /// In en, this message translates to:
  /// **'Spot on! Sharp falling drop was decisive.'**
  String get spotOnSharpFallingDropWasDecisive;

  /// No description provided for @spotOnToneWasPronouncedAccurately.
  ///
  /// In en, this message translates to:
  /// **'Spot on! Tone was pronounced accurately.'**
  String get spotOnToneWasPronouncedAccurately;

  /// No description provided for @iAgreeToTheTermsOfServiceAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy.'**
  String get iAgreeToTheTermsOfServiceAndPrivacy;

  /// No description provided for @sendMeOccasionalUpdatesTipsAndOffer.
  ///
  /// In en, this message translates to:
  /// **'Send me occasional updates, tips, and offers.'**
  String get sendMeOccasionalUpdatesTipsAndOffer;

  /// No description provided for @signInToSyncYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your progress.'**
  String get signInToSyncYourProgress;

  /// No description provided for @createAnAccountToSaveYourStats.
  ///
  /// In en, this message translates to:
  /// **'Create an account to save your stats.'**
  String get createAnAccountToSaveYourStats;

  /// No description provided for @smartSpiral.
  ///
  /// In en, this message translates to:
  /// **'SMART SPIRAL'**
  String get smartSpiral;

  /// No description provided for @origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get origin;

  /// No description provided for @elements.
  ///
  /// In en, this message translates to:
  /// **'Elements'**
  String get elements;

  /// No description provided for @humanity.
  ///
  /// In en, this message translates to:
  /// **'Humanity'**
  String get humanity;

  /// No description provided for @village.
  ///
  /// In en, this message translates to:
  /// **'Village'**
  String get village;

  /// No description provided for @journey.
  ///
  /// In en, this message translates to:
  /// **'Journey'**
  String get journey;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @originTheSimplestShapesTheBeginning.
  ///
  /// In en, this message translates to:
  /// **'Origin\': \'The simplest shapes. The beginning of all things.'**
  String get originTheSimplestShapesTheBeginning;

  /// No description provided for @elementsSunMoonWaterAndFireTheNatur.
  ///
  /// In en, this message translates to:
  /// **'Elements\': \'Sun, Moon, Water, and Fire. The natural world.'**
  String get elementsSunMoonWaterAndFireTheNatur;

  /// No description provided for @humanityTheBodyTheHeartAndTheFamily.
  ///
  /// In en, this message translates to:
  /// **'Humanity\': \'The body, the heart, and the family.'**
  String get humanityTheBodyTheHeartAndTheFamily;

  /// No description provided for @villageFieldsRoofsAndToolsTheFounda.
  ///
  /// In en, this message translates to:
  /// **'Village\': \'Fields, roofs, and tools. The foundations of society.'**
  String get villageFieldsRoofsAndToolsTheFounda;

  /// No description provided for @journeyMovementSpeechAndSustenance.
  ///
  /// In en, this message translates to:
  /// **'Journey\': \'Movement, speech, and sustenance.'**
  String get journeyMovementSpeechAndSustenance;

  /// No description provided for @cityCommerceClothingAndComplexArtif.
  ///
  /// In en, this message translates to:
  /// **'City\': \'Commerce, clothing, and complex artifacts.'**
  String get cityCommerceClothingAndComplexArtif;

  /// No description provided for @equilibriumAlgorithm.
  ///
  /// In en, this message translates to:
  /// **'Equilibrium Algorithm'**
  String get equilibriumAlgorithm;

  /// No description provided for @misc.
  ///
  /// In en, this message translates to:
  /// **'Misc'**
  String get misc;

  /// No description provided for @cityOrOriginAs.
  ///
  /// In en, this message translates to:
  /// **'City\' or \'Origin\' as'**
  String get cityOrOriginAs;

  /// No description provided for @miscToOrigin.
  ///
  /// In en, this message translates to:
  /// **'Misc\' to \'Origin'**
  String get miscToOrigin;

  /// No description provided for @constellation.
  ///
  /// In en, this message translates to:
  /// **'Constellation'**
  String get constellation;

  /// No description provided for @whichOneIsWater.
  ///
  /// In en, this message translates to:
  /// **'Which one is \'Water\'?'**
  String get whichOneIsWater;

  /// No description provided for @whatIsThePinyin.
  ///
  /// In en, this message translates to:
  /// **'What is the pinyin?'**
  String get whatIsThePinyin;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @whatEssenceDoes.
  ///
  /// In en, this message translates to:
  /// **'What essence does'**
  String get whatEssenceDoes;

  /// No description provided for @allTiers.
  ///
  /// In en, this message translates to:
  /// **'All Tiers'**
  String get allTiers;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @theScrollOfOrigin1.
  ///
  /// In en, this message translates to:
  /// **'THE SCROLL OF ORIGIN'**
  String get theScrollOfOrigin1;

  /// No description provided for @galaxyOf1.
  ///
  /// In en, this message translates to:
  /// **'GALAXY OF'**
  String galaxyOf1(Object name);

  /// No description provided for @also.
  ///
  /// In en, this message translates to:
  /// **'Also'**
  String get also;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @cloud.
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get cloud;

  /// No description provided for @youArchaic.
  ///
  /// In en, this message translates to:
  /// **'You (archaic)'**
  String get youArchaic;

  /// No description provided for @suddenly.
  ///
  /// In en, this message translates to:
  /// **'Suddenly'**
  String get suddenly;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @door.
  ///
  /// In en, this message translates to:
  /// **'Door'**
  String get door;

  /// No description provided for @occupy.
  ///
  /// In en, this message translates to:
  /// **'Occupy'**
  String get occupy;

  /// No description provided for @nail.
  ///
  /// In en, this message translates to:
  /// **'Nail'**
  String get nail;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get and;

  /// No description provided for @buddhistNun.
  ///
  /// In en, this message translates to:
  /// **'Buddhist Nun'**
  String get buddhistNun;

  /// No description provided for @anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get anxious;

  /// No description provided for @sprout.
  ///
  /// In en, this message translates to:
  /// **'Sprout'**
  String get sprout;

  /// No description provided for @exchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchange;

  /// No description provided for @sheep.
  ///
  /// In en, this message translates to:
  /// **'Sheep'**
  String get sheep;

  /// No description provided for @strange.
  ///
  /// In en, this message translates to:
  /// **'Strange'**
  String get strange;

  /// No description provided for @opposite.
  ///
  /// In en, this message translates to:
  /// **'Opposite'**
  String get opposite;

  /// No description provided for @shorttailedBird.
  ///
  /// In en, this message translates to:
  /// **'Short-tailed bird'**
  String get shorttailedBird;

  /// No description provided for @shoot.
  ///
  /// In en, this message translates to:
  /// **'Shoot'**
  String get shoot;

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @gather.
  ///
  /// In en, this message translates to:
  /// **'Gather'**
  String get gather;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @flat.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get flat;

  /// No description provided for @thePersonWho.
  ///
  /// In en, this message translates to:
  /// **'The person who...'**
  String get thePersonWho;

  /// No description provided for @nobleman.
  ///
  /// In en, this message translates to:
  /// **'Nobleman'**
  String get nobleman;

  /// No description provided for @cause.
  ///
  /// In en, this message translates to:
  /// **'Cause'**
  String get cause;

  /// No description provided for @pig.
  ///
  /// In en, this message translates to:
  /// **'Pig'**
  String get pig;

  /// No description provided for @bright.
  ///
  /// In en, this message translates to:
  /// **'Bright'**
  String get bright;

  /// No description provided for @slowly.
  ///
  /// In en, this message translates to:
  /// **'Slowly'**
  String get slowly;

  /// No description provided for @give.
  ///
  /// In en, this message translates to:
  /// **'Give'**
  String get give;

  /// No description provided for @arrow.
  ///
  /// In en, this message translates to:
  /// **'Arrow'**
  String get arrow;

  /// No description provided for @dry.
  ///
  /// In en, this message translates to:
  /// **'Dry'**
  String get dry;

  /// No description provided for @obstacle.
  ///
  /// In en, this message translates to:
  /// **'Obstacle'**
  String get obstacle;

  /// No description provided for @beg.
  ///
  /// In en, this message translates to:
  /// **'Beg'**
  String get beg;

  /// No description provided for @window.
  ///
  /// In en, this message translates to:
  /// **'Window'**
  String get window;

  /// No description provided for @fear.
  ///
  /// In en, this message translates to:
  /// **'Fear'**
  String get fear;

  /// No description provided for @drum.
  ///
  /// In en, this message translates to:
  /// **'Drum'**
  String get drum;

  /// No description provided for @why.
  ///
  /// In en, this message translates to:
  /// **'Why'**
  String get why;

  /// No description provided for @talent.
  ///
  /// In en, this message translates to:
  /// **'Talent'**
  String get talent;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @desert.
  ///
  /// In en, this message translates to:
  /// **'Desert'**
  String get desert;

  /// No description provided for @component.
  ///
  /// In en, this message translates to:
  /// **'Component'**
  String get component;

  /// No description provided for @divingInto1.
  ///
  /// In en, this message translates to:
  /// **'Diving into'**
  String divingInto1(Object topic);

  /// No description provided for @unitIntro1.
  ///
  /// In en, this message translates to:
  /// **'Unit Intro'**
  String get unitIntro1;

  /// No description provided for @theBlueprint.
  ///
  /// In en, this message translates to:
  /// **'THE BLUEPRINT'**
  String get theBlueprint;

  /// No description provided for @theOrigin.
  ///
  /// In en, this message translates to:
  /// **'THE ORIGIN'**
  String get theOrigin;

  /// No description provided for @theGalaxy.
  ///
  /// In en, this message translates to:
  /// **'THE GALAXY'**
  String get theGalaxy;

  /// No description provided for @theScholarListens.
  ///
  /// In en, this message translates to:
  /// **'The Scholar listens...'**
  String get theScholarListens;

  /// No description provided for @consultingTheScrolls.
  ///
  /// In en, this message translates to:
  /// **'Consulting the scrolls...'**
  String get consultingTheScrolls;

  /// No description provided for @traceWithTheGuide.
  ///
  /// In en, this message translates to:
  /// **'Trace with the Guide'**
  String get traceWithTheGuide;

  /// No description provided for @traceTheGhost.
  ///
  /// In en, this message translates to:
  /// **'Trace the Ghost'**
  String get traceTheGhost;

  /// No description provided for @connectTheDots.
  ///
  /// In en, this message translates to:
  /// **'Connect the Dots'**
  String get connectTheDots;

  /// No description provided for @drawFromMemory.
  ///
  /// In en, this message translates to:
  /// **'Draw from Memory'**
  String get drawFromMemory;

  /// No description provided for @assistant.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get assistant;

  /// No description provided for @puck.
  ///
  /// In en, this message translates to:
  /// **'Puck'**
  String get puck;

  /// No description provided for @helloWelcomeWhatWouldYouLikeToOrder.
  ///
  /// In en, this message translates to:
  /// **'Hello! Welcome. What would you like to order?'**
  String get helloWelcomeWhatWouldYouLikeToOrder;

  /// No description provided for @ni3Hao3Huan1ying2Guang1lin2Qing3wen.
  ///
  /// In en, this message translates to:
  /// **'Ni3 hao3! Huan1ying2 guang1lin2. Qing3wen4 ni3 yao4 dian3 shen2me?'**
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen;

  /// No description provided for @waiterLi.
  ///
  /// In en, this message translates to:
  /// **'Waiter Li'**
  String get waiterLi;

  /// No description provided for @askForTheMenu.
  ///
  /// In en, this message translates to:
  /// **'Ask for the menu'**
  String get askForTheMenu;

  /// No description provided for @orderOneDishAndOneDrink.
  ///
  /// In en, this message translates to:
  /// **'Order one dish and one drink'**
  String get orderOneDishAndOneDrink;

  /// No description provided for @askForTheBill.
  ///
  /// In en, this message translates to:
  /// **'Ask for the bill'**
  String get askForTheBill;

  /// No description provided for @fenrir.
  ///
  /// In en, this message translates to:
  /// **'Fenrir'**
  String get fenrir;

  /// No description provided for @ni3Qu4Na3rAJi1chang3MaTing3Yuan3De.
  ///
  /// In en, this message translates to:
  /// **'Ni3 qu4 na3r a? Ji1chang3 ma? Ting3 yuan3 de!'**
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De;

  /// No description provided for @driverWang.
  ///
  /// In en, this message translates to:
  /// **'Driver Wang'**
  String get driverWang;

  /// No description provided for @tellTheDriverYouAreGoingToTheAirpor.
  ///
  /// In en, this message translates to:
  /// **'Tell the driver you are going to the airport'**
  String get tellTheDriverYouAreGoingToTheAirpor;

  /// No description provided for @askHowLongTheTripWillTake.
  ///
  /// In en, this message translates to:
  /// **'Ask how long the trip will take'**
  String get askHowLongTheTripWillTake;

  /// No description provided for @complainAboutTheTraffic.
  ///
  /// In en, this message translates to:
  /// **'Complain about the traffic'**
  String get complainAboutTheTraffic;

  /// No description provided for @charon.
  ///
  /// In en, this message translates to:
  /// **'Charon'**
  String get charon;

  /// No description provided for @thisClothingQualityIsEspeciallyGood.
  ///
  /// In en, this message translates to:
  /// **'This clothing quality is especially good, only 200 kuai.'**
  String get thisClothingQualityIsEspeciallyGood;

  /// No description provided for @zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3.
  ///
  /// In en, this message translates to:
  /// **'Zhe4 jian4 yi1fu zhi4liang4 te4bie2 hao3, zhi3yao4 liang3 bai3 kuai4.'**
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3;

  /// No description provided for @auntieChen.
  ///
  /// In en, this message translates to:
  /// **'Auntie Chen'**
  String get auntieChen;

  /// No description provided for @askHowMuchTheSilkShirtCosts.
  ///
  /// In en, this message translates to:
  /// **'Ask how much the silk shirt costs'**
  String get askHowMuchTheSilkShirtCosts;

  /// No description provided for @sayItIsTooExpensive.
  ///
  /// In en, this message translates to:
  /// **'Say it is too expensive'**
  String get sayItIsTooExpensive;

  /// No description provided for @bargainThePriceDownTo100Rmb.
  ///
  /// In en, this message translates to:
  /// **'Bargain the price down to 100 RMB'**
  String get bargainThePriceDownTo100Rmb;

  /// No description provided for @ni3Na3li3Bu4Shu1fuFa1shao1LeMa.
  ///
  /// In en, this message translates to:
  /// **'Ni3 na3li3 bu4 shu1fu? Fa1shao1 le ma?'**
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa;

  /// No description provided for @drZhang.
  ///
  /// In en, this message translates to:
  /// **'Dr. Zhang'**
  String get drZhang;

  /// No description provided for @explainYouHaveHadAHeadacheForTwoDay.
  ///
  /// In en, this message translates to:
  /// **'Explain you have had a headache for two days'**
  String get explainYouHaveHadAHeadacheForTwoDay;

  /// No description provided for @sayYouHaveASlightFever.
  ///
  /// In en, this message translates to:
  /// **'Say you have a slight fever'**
  String get sayYouHaveASlightFever;

  /// No description provided for @askIfYouNeedToTakeMedicine.
  ///
  /// In en, this message translates to:
  /// **'Ask if you need to take medicine'**
  String get askIfYouNeedToTakeMedicine;

  /// No description provided for @aoede.
  ///
  /// In en, this message translates to:
  /// **'Aoede'**
  String get aoede;

  /// No description provided for @heyLongTimeNoSeeHowHaveYouBeenLatel.
  ///
  /// In en, this message translates to:
  /// **'Hey! Long time no see, how have you been lately?'**
  String get heyLongTimeNoSeeHowHaveYouBeenLatel;

  /// No description provided for @ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z.
  ///
  /// In en, this message translates to:
  /// **'Ni3 hao3! Hao3jiu3 bu4jian4, ni3 zui4jin4 zen3me yang4?'**
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z;

  /// No description provided for @pleaseIntroduceYourselfWhyDoYouWant.
  ///
  /// In en, this message translates to:
  /// **'Please introduce yourself. Why do you want to work at our company?'**
  String get pleaseIntroduceYourselfWhyDoYouWant;

  /// No description provided for @qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3.
  ///
  /// In en, this message translates to:
  /// **'Qing3 xian1 zi4wo3 jie4shao4 yi1xia4. Ni3 wei4shen2me xiang3 lai2 wo3men gong1si1 gong1zuo4?'**
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3;

  /// No description provided for @managerLiu.
  ///
  /// In en, this message translates to:
  /// **'Manager Liu'**
  String get managerLiu;

  /// No description provided for @introduceYourProfessionalBackground.
  ///
  /// In en, this message translates to:
  /// **'Introduce your professional background briefly'**
  String get introduceYourProfessionalBackground;

  /// No description provided for @explainWhyYouWantToWorkAtThisCompan.
  ///
  /// In en, this message translates to:
  /// **'Explain why you want to work at this company'**
  String get explainWhyYouWantToWorkAtThisCompan;

  /// No description provided for @askAPoliteQuestionAboutTheCompanyCu.
  ///
  /// In en, this message translates to:
  /// **'Ask a polite question about the company culture'**
  String get askAPoliteQuestionAboutTheCompanyCu;

  /// No description provided for @microphoneAccessIsRequiredPleaseEna.
  ///
  /// In en, this message translates to:
  /// **'Microphone access is required. Please enable it in your device Settings.'**
  String get microphoneAccessIsRequiredPleaseEna;

  /// No description provided for @couldNotStartMicrophonePleaseCheckY.
  ///
  /// In en, this message translates to:
  /// **'Could not start microphone. Please check your audio settings and try again.'**
  String get couldNotStartMicrophonePleaseCheckY;

  /// No description provided for @weDidntQuiteCatchThatPleaseHoldTheM.
  ///
  /// In en, this message translates to:
  /// **'We didn\'t quite catch that. Please hold the mic and try again!'**
  String get weDidntQuiteCatchThatPleaseHoldTheM;

  /// No description provided for @recordingWasTooShortHoldTheMicAndSp.
  ///
  /// In en, this message translates to:
  /// **'Recording was too short. Hold the mic and speak clearly.'**
  String get recordingWasTooShortHoldTheMicAndSp;

  /// No description provided for @audioBufferWasEmptyPleaseCheckYourM.
  ///
  /// In en, this message translates to:
  /// **'Audio buffer was empty. Please check your microphone and try again.'**
  String get audioBufferWasEmptyPleaseCheckYourM;

  /// No description provided for @audioFileIsSilentPleaseSpeakIntoThe.
  ///
  /// In en, this message translates to:
  /// **'Audio file is silent. Please speak into the microphone.'**
  String get audioFileIsSilentPleaseSpeakIntoThe;

  /// No description provided for @weCouldntUnderstandYourPronunciatio.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t understand your pronunciation. Please speak clearly and try again.'**
  String get weCouldntUnderstandYourPronunciatio;

  /// No description provided for @theServerIsTakingTooLongToRespondPl.
  ///
  /// In en, this message translates to:
  /// **'The server is taking too long to respond. Please try again.'**
  String get theServerIsTakingTooLongToRespondPl;

  /// No description provided for @noInternetConnectionPleaseCheckYour.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network and try again.'**
  String get noInternetConnectionPleaseCheckYour;

  /// No description provided for @audioProcessingFailedPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Audio processing failed. Please try again.'**
  String get audioProcessingFailedPleaseTryAgain;

  /// No description provided for @permission.
  ///
  /// In en, this message translates to:
  /// **'Permission'**
  String get permission;

  /// No description provided for @couldNotProcessYourRecordingPleaseT.
  ///
  /// In en, this message translates to:
  /// **'Could not process your recording. Please try again.'**
  String get couldNotProcessYourRecordingPleaseT;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @scholar.
  ///
  /// In en, this message translates to:
  /// **'Scholar'**
  String get scholar;

  /// No description provided for @ourAiTutorsAreCurrentlyOfflinePleas.
  ///
  /// In en, this message translates to:
  /// **'Our AI tutors are currently offline, please try again later.'**
  String get ourAiTutorsAreCurrentlyOfflinePleas;

  /// No description provided for @hideTranslation.
  ///
  /// In en, this message translates to:
  /// **'Hide Translation'**
  String get hideTranslation;

  /// No description provided for @azureAssessment.
  ///
  /// In en, this message translates to:
  /// **'Azure Assessment...'**
  String get azureAssessment;

  /// No description provided for @microphonePermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission required'**
  String get microphonePermissionRequired;

  /// No description provided for @connectedSpeakNow.
  ///
  /// In en, this message translates to:
  /// **'Connected! Speak now.'**
  String get connectedSpeakNow;

  /// No description provided for @initializationErrorCheckPermissions.
  ///
  /// In en, this message translates to:
  /// **'Initialization error. Check permissions.'**
  String get initializationErrorCheckPermissions;

  /// No description provided for @microphoneErrorTapToRetry.
  ///
  /// In en, this message translates to:
  /// **'Microphone error. Tap to retry.'**
  String get microphoneErrorTapToRetry;

  /// No description provided for @theTutorReturnedAnEmptyResponse.
  ///
  /// In en, this message translates to:
  /// **'The tutor returned an empty response'**
  String get theTutorReturnedAnEmptyResponse;

  /// No description provided for @connectionInterruptedPleaseSpeakAga.
  ///
  /// In en, this message translates to:
  /// **'Connection interrupted. Please speak again.'**
  String get connectionInterruptedPleaseSpeakAga;

  /// No description provided for @callPausedReviewingTones.
  ///
  /// In en, this message translates to:
  /// **'Call Paused (Reviewing Tones)'**
  String get callPausedReviewingTones;

  /// No description provided for @pausedTakeABreak.
  ///
  /// In en, this message translates to:
  /// **'Paused - Take a break'**
  String get pausedTakeABreak;

  /// No description provided for @goodStartPracticing.
  ///
  /// In en, this message translates to:
  /// **'Good start practicing'**
  String get goodStartPracticing;

  /// No description provided for @studentCoach.
  ///
  /// In en, this message translates to:
  /// **'STUDENT\' : \'COACH'**
  String get studentCoach;

  /// No description provided for @keepYour1stToneHighAndSteadyOn.
  ///
  /// In en, this message translates to:
  /// **'Keep your 1st tone high and steady on'**
  String get keepYour1stToneHighAndSteadyOn;

  /// No description provided for @noScenariosFound.
  ///
  /// In en, this message translates to:
  /// **'No scenarios found.'**
  String get noScenariosFound;

  /// No description provided for @designYourOwnAiRoleplayExperience.
  ///
  /// In en, this message translates to:
  /// **'Design your own AI roleplay experience'**
  String get designYourOwnAiRoleplayExperience;

  /// No description provided for @generateFromDeck.
  ///
  /// In en, this message translates to:
  /// **'Generate from Deck'**
  String get generateFromDeck;

  /// No description provided for @practiceFlashcardVocabularyInALiveD.
  ///
  /// In en, this message translates to:
  /// **'Practice flashcard vocabulary in a live dialogue'**
  String get practiceFlashcardVocabularyInALiveD;

  /// No description provided for @tapToRoleplay.
  ///
  /// In en, this message translates to:
  /// **'Tap to roleplay'**
  String get tapToRoleplay;

  /// No description provided for @hsk2.
  ///
  /// In en, this message translates to:
  /// **'HSK 2'**
  String get hsk2;

  /// No description provided for @hsk3.
  ///
  /// In en, this message translates to:
  /// **'HSK 3'**
  String get hsk3;

  /// No description provided for @hsk4.
  ///
  /// In en, this message translates to:
  /// **'HSK 4'**
  String get hsk4;

  /// No description provided for @hsk5.
  ///
  /// In en, this message translates to:
  /// **'HSK 5'**
  String get hsk5;

  /// No description provided for @hsk6.
  ///
  /// In en, this message translates to:
  /// **'HSK 6'**
  String get hsk6;

  /// No description provided for @dinnerWithDad.
  ///
  /// In en, this message translates to:
  /// **'Dinner with Dad'**
  String get dinnerWithDad;

  /// No description provided for @orderingAtAChengduTeahouse.
  ///
  /// In en, this message translates to:
  /// **'Ordering at a Chengdu Teahouse'**
  String get orderingAtAChengduTeahouse;

  /// No description provided for @buyingTeaAtTheMarket.
  ///
  /// In en, this message translates to:
  /// **'Buying Tea at the Market'**
  String get buyingTeaAtTheMarket;

  /// No description provided for @meetingAnOldClassmate.
  ///
  /// In en, this message translates to:
  /// **'Meeting an Old Classmate'**
  String get meetingAnOldClassmate;

  /// No description provided for @readyToPractice.
  ///
  /// In en, this message translates to:
  /// **'Ready to practice?'**
  String get readyToPractice;

  /// No description provided for @letsPracticeChinese.
  ///
  /// In en, this message translates to:
  /// **'Let\'s practice Chinese'**
  String get letsPracticeChinese;

  /// No description provided for @areYouReady.
  ///
  /// In en, this message translates to:
  /// **'Are you ready?'**
  String get areYouReady;

  /// No description provided for @discussWhatToHaveForDinner.
  ///
  /// In en, this message translates to:
  /// **'Discuss what to have for dinner'**
  String get discussWhatToHaveForDinner;

  /// No description provided for @suggestWatchingAMovieAfterwards.
  ///
  /// In en, this message translates to:
  /// **'Suggest watching a movie afterwards'**
  String get suggestWatchingAMovieAfterwards;

  /// No description provided for @askIfTheyWouldLikeTea.
  ///
  /// In en, this message translates to:
  /// **'Ask if they would like tea'**
  String get askIfTheyWouldLikeTea;

  /// No description provided for @helloVeryNiceToMeetYou.
  ///
  /// In en, this message translates to:
  /// **'Hello! Very nice to meet you.'**
  String get helloVeryNiceToMeetYou;

  /// No description provided for @deckPractice.
  ///
  /// In en, this message translates to:
  /// **'Deck Practice'**
  String get deckPractice;

  /// No description provided for @practiceVocabularyWithAnAiPartner.
  ///
  /// In en, this message translates to:
  /// **'Practice vocabulary with an AI partner.'**
  String get practiceVocabularyWithAnAiPartner;

  /// No description provided for @designCustomAiRoleplayConversation.
  ///
  /// In en, this message translates to:
  /// **'Design custom AI roleplay & conversation'**
  String get designCustomAiRoleplayConversation;

  /// No description provided for @random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get random;

  /// No description provided for @scenarioTopic.
  ///
  /// In en, this message translates to:
  /// **'Scenario Topic'**
  String get scenarioTopic;

  /// No description provided for @contextSettingOptional.
  ///
  /// In en, this message translates to:
  /// **'Context & Setting (Optional)'**
  String get contextSettingOptional;

  /// No description provided for @aiCharacterPersonaOptional.
  ///
  /// In en, this message translates to:
  /// **'AI Character / Persona (Optional)'**
  String get aiCharacterPersonaOptional;

  /// No description provided for @aQuietBambooCourtyardTeahouseInChen.
  ///
  /// In en, this message translates to:
  /// **'A quiet bamboo courtyard teahouse in Chengdu with gentle guzheng music playing.'**
  String get aQuietBambooCourtyardTeahouseInChen;

  /// No description provided for @aBustlingSmokyNightMarketFilledWith.
  ///
  /// In en, this message translates to:
  /// **'A bustling, smoky night market filled with skewers, steamed buns, and street food stalls.'**
  String get aBustlingSmokyNightMarketFilledWith;

  /// No description provided for @aLivelyHotpotRestaurantInChongqingW.
  ///
  /// In en, this message translates to:
  /// **'A lively hotpot restaurant in Chongqing with boiling crimson broth and fragrant chili aroma.'**
  String get aLivelyHotpotRestaurantInChongqingW;

  /// No description provided for @aBustlingTraditionalCantoneseTeahou.
  ///
  /// In en, this message translates to:
  /// **'A bustling traditional Cantonese teahouse in Guangzhou filled with steaming bamboo baskets.'**
  String get aBustlingTraditionalCantoneseTeahou;

  /// No description provided for @aChicMinimalistCafeInTheFrenchConce.
  ///
  /// In en, this message translates to:
  /// **'A chic minimalist cafe in the French Concession during a rainy Sunday afternoon.'**
  String get aChicMinimalistCafeInTheFrenchConce;

  /// No description provided for @aWarmNorthernHomeKitchenDuringWinte.
  ///
  /// In en, this message translates to:
  /// **'A warm northern home kitchen during winter with flour on the table and steaming dumpling pots.'**
  String get aWarmNorthernHomeKitchenDuringWinte;

  /// No description provided for @anOpenairNightStreetFoodAlleyWithSi.
  ///
  /// In en, this message translates to:
  /// **'An open-air night street food alley with sizzling lamb skewers, roasted eggplant, and cold beer.'**
  String get anOpenairNightStreetFoodAlleyWithSi;

  /// No description provided for @aSnowyStreetCornerOutsideTheLamaTem.
  ///
  /// In en, this message translates to:
  /// **'A snowy street corner outside the Lama Temple with glowing red candied hawthorn skewers on ice.'**
  String get aSnowyStreetCornerOutsideTheLamaTem;

  /// No description provided for @craftBeerBreweryInQingdao.
  ///
  /// In en, this message translates to:
  /// **'Craft Beer Brewery in Qingdao'**
  String get craftBeerBreweryInQingdao;

  /// No description provided for @aLivelyCoastalTaproomWithWoodenBarr.
  ///
  /// In en, this message translates to:
  /// **'A lively coastal taproom with wooden barrels, ocean breeze, and fresh wheat beer taps.'**
  String get aLivelyCoastalTaproomWithWoodenBarr;

  /// No description provided for @sichuanCookingMasterclass.
  ///
  /// In en, this message translates to:
  /// **'Sichuan Cooking Masterclass'**
  String get sichuanCookingMasterclass;

  /// No description provided for @aVibrantOpenKitchenWithWoksBlazingC.
  ///
  /// In en, this message translates to:
  /// **'A vibrant open kitchen with woks blazing, chili oil simmering, and fresh peppercorns.'**
  String get aVibrantOpenKitchenWithWoksBlazingC;

  /// No description provided for @highspeedRailSeatMixup.
  ///
  /// In en, this message translates to:
  /// **'High-Speed Rail Seat Mix-Up'**
  String get highspeedRailSeatMixup;

  /// No description provided for @greatWallSunriseTrekInMutianyu.
  ///
  /// In en, this message translates to:
  /// **'Great Wall Sunrise Trek in Mutianyu'**
  String get greatWallSunriseTrekInMutianyu;

  /// No description provided for @theAncientStoneRampartsOfTheGreatWa.
  ///
  /// In en, this message translates to:
  /// **'The ancient stone ramparts of the Great Wall at dawn, surrounded by misty green mountains.'**
  String get theAncientStoneRampartsOfTheGreatWa;

  /// No description provided for @bambooRaftDriftOnGuilinLiRiver.
  ///
  /// In en, this message translates to:
  /// **'Bamboo Raft Drift on Guilin Li River'**
  String get bambooRaftDriftOnGuilinLiRiver;

  /// No description provided for @glidingAlongEmeraldKarstWatersBetwe.
  ///
  /// In en, this message translates to:
  /// **'Gliding along emerald karst waters between dramatic misty limestone peaks near Yangshuo.'**
  String get glidingAlongEmeraldKarstWatersBetwe;

  /// No description provided for @silkRoadCamelTrekInDunhuang.
  ///
  /// In en, this message translates to:
  /// **'Silk Road Camel Trek in Dunhuang'**
  String get silkRoadCamelTrekInDunhuang;

  /// No description provided for @theRollingGoldenSandDunesOfMingshaM.
  ///
  /// In en, this message translates to:
  /// **'The rolling golden sand dunes of Mingsha Mountain next to the Crescent Lake oasis.'**
  String get theRollingGoldenSandDunesOfMingshaM;

  /// No description provided for @bookingACourtyardHomestayInDali.
  ///
  /// In en, this message translates to:
  /// **'Booking a Courtyard Homestay in Dali'**
  String get bookingACourtyardHomestayInDali;

  /// No description provided for @aSereneBaistyleBoutiqueCourtyardHot.
  ///
  /// In en, this message translates to:
  /// **'A serene Bai-style boutique courtyard hotel overlooking Erhai Lake in Yunnan.'**
  String get aSereneBaistyleBoutiqueCourtyardHot;

  /// No description provided for @potalaPalacePilgrimageInLhasa.
  ///
  /// In en, this message translates to:
  /// **'Potala Palace Pilgrimage in Lhasa'**
  String get potalaPalacePilgrimageInLhasa;

  /// No description provided for @theMajesticSundrenchedStoneStepsOut.
  ///
  /// In en, this message translates to:
  /// **'The majestic sun-drenched stone steps outside the Potala Palace with spinning prayer wheels.'**
  String get theMajesticSundrenchedStoneStepsOut;

  /// No description provided for @aSubzeroWonderlandOfIlluminatedCrys.
  ///
  /// In en, this message translates to:
  /// **'A sub-zero wonderland of illuminated crystal ice palaces and towering snow sculptures.'**
  String get aSubzeroWonderlandOfIlluminatedCrys;

  /// No description provided for @zhangjiajieAvatarMountainCableCar.
  ///
  /// In en, this message translates to:
  /// **'Zhangjiajie Avatar Mountain Cable Car'**
  String get zhangjiajieAvatarMountainCableCar;

  /// No description provided for @suspendedHighInAGlassCableCarSoarin.
  ///
  /// In en, this message translates to:
  /// **'Suspended high in a glass cable car soaring above thousands of sandstone pillar peaks.'**
  String get suspendedHighInAGlassCableCarSoarin;

  /// No description provided for @gobiDesertStargazingCampInGansu.
  ///
  /// In en, this message translates to:
  /// **'Gobi Desert Stargazing Camp in Gansu'**
  String get gobiDesertStargazingCampInGansu;

  /// No description provided for @aLuxuryYurtCampUnderACrystalclearMi.
  ///
  /// In en, this message translates to:
  /// **'A luxury yurt camp under a crystal-clear Milky Way sky in the desert outside Jiayuguan.'**
  String get aLuxuryYurtCampUnderACrystalclearMi;

  /// No description provided for @yangtzeRiverThreeGorgesCruise.
  ///
  /// In en, this message translates to:
  /// **'Yangtze River Three Gorges Cruise'**
  String get yangtzeRiverThreeGorgesCruise;

  /// No description provided for @onTheSunDeckOfARiverCruiseShipPassi.
  ///
  /// In en, this message translates to:
  /// **'On the sun deck of a river cruise ship passing through the dramatic towering Qutang Gorge.'**
  String get onTheSunDeckOfARiverCruiseShipPassi;

  /// No description provided for @buyingAntiquesInBeijingPanjiayuan.
  ///
  /// In en, this message translates to:
  /// **'Buying Antiques in Beijing Panjiayuan'**
  String get buyingAntiquesInBeijingPanjiayuan;

  /// No description provided for @aHistoricPotteryKilnFilledWithDelic.
  ///
  /// In en, this message translates to:
  /// **'A historic pottery kiln filled with delicate unfired porcelain vases and cobalt blue glazes.'**
  String get aHistoricPotteryKilnFilledWithDelic;

  /// No description provided for @suzhouSilkEmbroideryStudio.
  ///
  /// In en, this message translates to:
  /// **'Suzhou Silk Embroidery Studio'**
  String get suzhouSilkEmbroideryStudio;

  /// No description provided for @aPeacefulCanalsideGardenStudioInSuz.
  ///
  /// In en, this message translates to:
  /// **'A peaceful canal-side garden studio in Suzhou with fine silk threads and wooden embroidery frames.'**
  String get aPeacefulCanalsideGardenStudioInSuz;

  /// No description provided for @backstageAtATraditionalBeijingOpera.
  ///
  /// In en, this message translates to:
  /// **'Backstage at a traditional Beijing opera theater with colorful costumes, mirrors, and headpieces.'**
  String get backstageAtATraditionalBeijingOpera;

  /// No description provided for @traditionalChineseMedicineConsultat.
  ///
  /// In en, this message translates to:
  /// **'Traditional Chinese Medicine Consultation'**
  String get traditionalChineseMedicineConsultat;

  /// No description provided for @morningTaiChiInTempleOfHeavenPark.
  ///
  /// In en, this message translates to:
  /// **'Morning Tai Chi in Temple of Heaven Park'**
  String get morningTaiChiInTempleOfHeavenPark;

  /// No description provided for @beneathAncientCypressTreesAtDawnWit.
  ///
  /// In en, this message translates to:
  /// **'Beneath ancient cypress trees at dawn with park birds and seniors practicing synchronized movements.'**
  String get beneathAncientCypressTreesAtDawnWit;

  /// No description provided for @rentingAHanfuForAPhotoShoot.
  ///
  /// In en, this message translates to:
  /// **'Renting a Hanfu for a Photo Shoot'**
  String get rentingAHanfuForAPhotoShoot;

  /// No description provided for @aTraditionalCostumeBoutiqueNearTheW.
  ///
  /// In en, this message translates to:
  /// **'A traditional costume boutique near the West Lake with racks of Tang and Song dynasty robes.'**
  String get aTraditionalCostumeBoutiqueNearTheW;

  /// No description provided for @guqinAncientZitherInstrumentWorksho.
  ///
  /// In en, this message translates to:
  /// **'Guqin Ancient Zither Instrument Workshop'**
  String get guqinAncientZitherInstrumentWorksho;

  /// No description provided for @aQuietPinewoodStudioInHangzhouFille.
  ///
  /// In en, this message translates to:
  /// **'A quiet pine-wood studio in Hangzhou filled with aged paulownia wood and silk-string instruments.'**
  String get aQuietPinewoodStudioInHangzhouFille;

  /// No description provided for @shaanxiShadowPuppetTheater.
  ///
  /// In en, this message translates to:
  /// **'Shaanxi Shadow Puppet Theater'**
  String get shaanxiShadowPuppetTheater;

  /// No description provided for @behindAnIlluminatedWhiteSilkScreenW.
  ///
  /// In en, this message translates to:
  /// **'Behind an illuminated white silk screen with delicate translucent leather shadow figures.'**
  String get behindAnIlluminatedWhiteSilkScreenW;

  /// No description provided for @chineseCalligraphyWorkshop.
  ///
  /// In en, this message translates to:
  /// **'Chinese Calligraphy Workshop'**
  String get chineseCalligraphyWorkshop;

  /// No description provided for @aTranquilStudioScentedWithPineSootI.
  ///
  /// In en, this message translates to:
  /// **'A tranquil studio scented with pine soot ink, rice paper scrolls, and soft tea aromas.'**
  String get aTranquilStudioScentedWithPineSootI;

  /// No description provided for @adoptingACatAtAnAnimalShelter.
  ///
  /// In en, this message translates to:
  /// **'Adopting a Cat at an Animal Shelter'**
  String get adoptingACatAtAnAnimalShelter;

  /// No description provided for @aCozyPetRescueCenterInHangzhouWithE.
  ///
  /// In en, this message translates to:
  /// **'A cozy pet rescue center in Hangzhou with energetic rescue kittens and tea for visitors.'**
  String get aCozyPetRescueCenterInHangzhouWithE;

  /// No description provided for @scriptMurderMysteryJubenshaGame.
  ///
  /// In en, this message translates to:
  /// **'Script Murder Mystery (Jubensha) Game'**
  String get scriptMurderMysteryJubenshaGame;

  /// No description provided for @aThemedDetectiveLoungeInShanghaiWit.
  ///
  /// In en, this message translates to:
  /// **'A themed detective lounge in Shanghai with costumed players and candlelight.'**
  String get aThemedDetectiveLoungeInShanghaiWit;

  /// No description provided for @vintageVinylRecordShopInShanghai.
  ///
  /// In en, this message translates to:
  /// **'Vintage Vinyl Record Shop in Shanghai'**
  String get vintageVinylRecordShopInShanghai;

  /// No description provided for @aHiddenVinylStoreInAnOldLaneHousePa.
  ///
  /// In en, this message translates to:
  /// **'A hidden vinyl store in an old lane house packed with classic 80s Cantopop and jazz records.'**
  String get aHiddenVinylStoreInAnOldLaneHousePa;

  /// No description provided for @ktvKaraokePartyWithFriends.
  ///
  /// In en, this message translates to:
  /// **'KTV Karaoke Party with Friends'**
  String get ktvKaraokePartyWithFriends;

  /// No description provided for @joiningACityBikeCyclingClub.
  ///
  /// In en, this message translates to:
  /// **'Joining a City Bike Cycling Club'**
  String get joiningACityBikeCyclingClub;

  /// No description provided for @aGatheringOfCyclistsByTheRiverfront.
  ///
  /// In en, this message translates to:
  /// **'A gathering of cyclists by the riverfront preparing for an evening ride around the city skyline.'**
  String get aGatheringOfCyclistsByTheRiverfront;

  /// No description provided for @blindBoxToyTradingMeetup.
  ///
  /// In en, this message translates to:
  /// **'Blind Box Toy Trading Meetup'**
  String get blindBoxToyTradingMeetup;

  /// No description provided for @aColorfulPopcultureToyStoreInChaoya.
  ///
  /// In en, this message translates to:
  /// **'A colorful pop-culture toy store in Chaoyang with display shelves and unopened collectible boxes.'**
  String get aColorfulPopcultureToyStoreInChaoya;

  /// No description provided for @droneSkylineVideographyAtTheBund.
  ///
  /// In en, this message translates to:
  /// **'Drone Skyline Videography at the Bund'**
  String get droneSkylineVideographyAtTheBund;

  /// No description provided for @theBundPromenadeAtDuskOverlookingTh.
  ///
  /// In en, this message translates to:
  /// **'The Bund promenade at dusk overlooking the futuristic illuminated skyscrapers of Pudong.'**
  String get theBundPromenadeAtDuskOverlookingTh;

  /// No description provided for @goldenRetrieverCafeInNanjing.
  ///
  /// In en, this message translates to:
  /// **'Golden Retriever Cafe in Nanjing'**
  String get goldenRetrieverCafeInNanjing;

  /// No description provided for @aSunnyCheerfulPetCafeWithDozensOfFr.
  ///
  /// In en, this message translates to:
  /// **'A sunny, cheerful pet cafe with dozens of friendly, fluffy dogs greeting visitors.'**
  String get aSunnyCheerfulPetCafeWithDozensOfFr;

  /// No description provided for @boulderingClimbingGymInChengdu.
  ///
  /// In en, this message translates to:
  /// **'Bouldering Climbing Gym in Chengdu'**
  String get boulderingClimbingGymInChengdu;

  /// No description provided for @aModernIndoorClimbingGymWithVibrant.
  ///
  /// In en, this message translates to:
  /// **'A modern indoor climbing gym with vibrant colored hold routes and energetic music.'**
  String get aModernIndoorClimbingGymWithVibrant;

  /// No description provided for @aMassiveConventionHallFilledWithCol.
  ///
  /// In en, this message translates to:
  /// **'A massive convention hall filled with colorful game booths, photo walls, and costumed creators.'**
  String get aMassiveConventionHallFilledWithCol;

  /// No description provided for @askingForDirectionsInABeijingHutong.
  ///
  /// In en, this message translates to:
  /// **'Asking for Directions in a Beijing Hutong'**
  String get askingForDirectionsInABeijingHutong;

  /// No description provided for @aMazeOfHistoricGreybrickAlleysWithB.
  ///
  /// In en, this message translates to:
  /// **'A maze of historic grey-brick alleys with bicycles, courtyards, and pomegranate trees.'**
  String get aMazeOfHistoricGreybrickAlleysWithB;

  /// No description provided for @buyingFreshFruitAtAWetMarket.
  ///
  /// In en, this message translates to:
  /// **'Buying Fresh Fruit at a Wet Market'**
  String get buyingFreshFruitAtAWetMarket;

  /// No description provided for @aLivelyMorningNeighborhoodMarketWit.
  ///
  /// In en, this message translates to:
  /// **'A lively morning neighborhood market with mounds of fresh lychees, mangoes, and dragonfruit.'**
  String get aLivelyMorningNeighborhoodMarketWit;

  /// No description provided for @flowerMarketBouquetInKunming.
  ///
  /// In en, this message translates to:
  /// **'Flower Market Bouquet in Kunming'**
  String get flowerMarketBouquetInKunming;

  /// No description provided for @theFamousDounanFlowerMarketSurround.
  ///
  /// In en, this message translates to:
  /// **'The famous Dounan Flower Market surrounded by thousands of fresh roses, lilies, and eucalyptus stems.'**
  String get theFamousDounanFlowerMarketSurround;

  /// No description provided for @tailorAlterationsInAnOldLaneHouse.
  ///
  /// In en, this message translates to:
  /// **'Tailor Alterations in an Old Lane House'**
  String get tailorAlterationsInAnOldLaneHouse;

  /// No description provided for @aTraditionalTailorShopFilledWithSew.
  ///
  /// In en, this message translates to:
  /// **'A traditional tailor shop filled with sewing machines, fabrics, and measuring tapes.'**
  String get aTraditionalTailorShopFilledWithSew;

  /// No description provided for @expressParcelLockerRetrieval.
  ///
  /// In en, this message translates to:
  /// **'Express Parcel Locker Retrieval'**
  String get expressParcelLockerRetrieval;

  /// No description provided for @downstairsAtAResidentialApartmentGa.
  ///
  /// In en, this message translates to:
  /// **'Downstairs at a residential apartment gate next to a smart Hive box locker system.'**
  String get downstairsAtAResidentialApartmentGa;

  /// No description provided for @bicycleFlatTireRepairAtCampusGate.
  ///
  /// In en, this message translates to:
  /// **'Bicycle Flat Tire Repair at Campus Gate'**
  String get bicycleFlatTireRepairAtCampusGate;

  /// No description provided for @aSmallOutdoorRoadsideToolkitStandUn.
  ///
  /// In en, this message translates to:
  /// **'A small outdoor roadside toolkit stand under a large leafy banyan tree.'**
  String get aSmallOutdoorRoadsideToolkitStandUn;

  /// No description provided for @techCompanyProductDemo.
  ///
  /// In en, this message translates to:
  /// **'Tech Company Product Demo'**
  String get techCompanyProductDemo;

  /// No description provided for @aFuturisticTechConferenceBoothInShe.
  ///
  /// In en, this message translates to:
  /// **'A futuristic tech conference booth in Shenzhen showcasing cutting-edge AI hardware.'**
  String get aFuturisticTechConferenceBoothInShe;

  /// No description provided for @ecommerceLivestreamStudio.
  ///
  /// In en, this message translates to:
  /// **'E-commerce Live-Stream Studio'**
  String get ecommerceLivestreamStudio;

  /// No description provided for @aHighenergyBroadcastStudioWithRingL.
  ///
  /// In en, this message translates to:
  /// **'A high-energy broadcast studio with ring lights, product display racks, and live comment monitors.'**
  String get aHighenergyBroadcastStudioWithRingL;

  /// No description provided for @yiwuInternationalTradeMarket.
  ///
  /// In en, this message translates to:
  /// **'Yiwu International Trade Market'**
  String get yiwuInternationalTradeMarket;

  /// No description provided for @aVastMultistoryCommercialExhibition.
  ///
  /// In en, this message translates to:
  /// **'A vast multi-story commercial exhibition mall filled with millions of wholesale goods and crafts.'**
  String get aVastMultistoryCommercialExhibition;

  /// No description provided for @universityCampusExchangeProgram.
  ///
  /// In en, this message translates to:
  /// **'University Campus Exchange Program'**
  String get universityCampusExchangeProgram;

  /// No description provided for @aSunnyLawnOutsideTheUniversityLibra.
  ///
  /// In en, this message translates to:
  /// **'A sunny lawn outside the university library with students studying and drinking milk tea.'**
  String get aSunnyLawnOutsideTheUniversityLibra;

  /// No description provided for @pleaseEnterAScenarioTopic.
  ///
  /// In en, this message translates to:
  /// **'Please enter a scenario topic.'**
  String get pleaseEnterAScenarioTopic;

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'Name (Title)'**
  String get nameTitle;

  /// No description provided for @aiCharacter.
  ///
  /// In en, this message translates to:
  /// **'AI Character'**
  String get aiCharacter;

  /// No description provided for @helloWelcomeHereWhatShallWeChatAbou.
  ///
  /// In en, this message translates to:
  /// **'Hello! Welcome here, what shall we chat about today?'**
  String get helloWelcomeHereWhatShallWeChatAbou;

  /// No description provided for @greetYourConversationPartner.
  ///
  /// In en, this message translates to:
  /// **'Greet your conversation partner'**
  String get greetYourConversationPartner;

  /// No description provided for @askAQuestionInChinese.
  ///
  /// In en, this message translates to:
  /// **'Ask a question in Chinese'**
  String get askAQuestionInChinese;

  /// No description provided for @pinyinWithToneMarks.
  ///
  /// In en, this message translates to:
  /// **'Pinyin with tone marks'**
  String get pinyinWithToneMarks;

  /// No description provided for @goal1InEnglish.
  ///
  /// In en, this message translates to:
  /// **'Goal 1 in English'**
  String get goal1InEnglish;

  /// No description provided for @goal2InEnglish.
  ///
  /// In en, this message translates to:
  /// **'Goal 2 in English'**
  String get goal2InEnglish;

  /// No description provided for @goal3InEnglish.
  ///
  /// In en, this message translates to:
  /// **'Goal 3 in English'**
  String get goal3InEnglish;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @hsk12.
  ///
  /// In en, this message translates to:
  /// **'HSK 1-2'**
  String get hsk12;

  /// No description provided for @hsk34.
  ///
  /// In en, this message translates to:
  /// **'HSK 3-4'**
  String get hsk34;

  /// No description provided for @hsk56.
  ///
  /// In en, this message translates to:
  /// **'HSK 5-6'**
  String get hsk56;

  /// No description provided for @master.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get master;

  /// No description provided for @azurePronunciationAssessment.
  ///
  /// In en, this message translates to:
  /// **'AZURE PRONUNCIATION ASSESSMENT'**
  String get azurePronunciationAssessment;

  /// No description provided for @tapToReview.
  ///
  /// In en, this message translates to:
  /// **'Tap to review'**
  String get tapToReview;

  /// No description provided for @overallScore.
  ///
  /// In en, this message translates to:
  /// **'Overall Score'**
  String get overallScore;

  /// No description provided for @toneAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Tone Accuracy'**
  String get toneAccuracy;

  /// No description provided for @fluency.
  ///
  /// In en, this message translates to:
  /// **'Fluency'**
  String get fluency;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @goodPronunciationButCanBeBetter.
  ///
  /// In en, this message translates to:
  /// **'Good pronunciation, but can be better!'**
  String get goodPronunciationButCanBeBetter;

  /// No description provided for @didYouMeanToSay.
  ///
  /// In en, this message translates to:
  /// **'Did you mean to say...?'**
  String get didYouMeanToSay;

  /// No description provided for @greatKeepTrying.
  ///
  /// In en, this message translates to:
  /// **'Great!\' : \'Keep trying!'**
  String get greatKeepTrying;

  /// No description provided for @completeness.
  ///
  /// In en, this message translates to:
  /// **'Completeness'**
  String get completeness;

  /// No description provided for @targetTone.
  ///
  /// In en, this message translates to:
  /// **'Target Tone'**
  String get targetTone;

  /// No description provided for @k4toneComparisonTapToListen.
  ///
  /// In en, this message translates to:
  /// **'4-Tone Comparison (Tap to Listen):'**
  String get k4toneComparisonTapToListen;

  /// No description provided for @youSpokeMatch.
  ///
  /// In en, this message translates to:
  /// **'You Spoke (Match!)'**
  String get youSpokeMatch;

  /// No description provided for @youSpoke.
  ///
  /// In en, this message translates to:
  /// **'You Spoke'**
  String get youSpoke;

  /// No description provided for @yourPrimaryCollectionOfCharacters.
  ///
  /// In en, this message translates to:
  /// **'Your primary collection of characters.'**
  String get yourPrimaryCollectionOfCharacters;

  /// No description provided for @deckNotFound.
  ///
  /// In en, this message translates to:
  /// **'Deck not found'**
  String get deckNotFound;

  /// No description provided for @cannotDeleteTheDefaultDeck.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete the default deck'**
  String get cannotDeleteTheDefaultDeck;

  /// No description provided for @hsk4UpperIntermediate1.
  ///
  /// In en, this message translates to:
  /// **'HSK 4: Upper Intermediate'**
  String get hsk4UpperIntermediate1;

  /// No description provided for @theFirst150CharactersToStartYourJou.
  ///
  /// In en, this message translates to:
  /// **'The first 150 characters to start your journey.'**
  String get theFirst150CharactersToStartYourJou;

  /// No description provided for @buildYourVocabularyTo300EssentialWo.
  ///
  /// In en, this message translates to:
  /// **'Build your vocabulary to 300 essential words.'**
  String get buildYourVocabularyTo300EssentialWo;

  /// No description provided for @masterConversationalFluencyWith600W.
  ///
  /// In en, this message translates to:
  /// **'Master conversational fluency with 600 words.'**
  String get masterConversationalFluencyWith600W;

  /// No description provided for @readTextsAndConverseFluentlyWith120.
  ///
  /// In en, this message translates to:
  /// **'Read texts and converse fluently with 1200 words.'**
  String get readTextsAndConverseFluentlyWith120;

  /// No description provided for @readNewspapersAndWatchMoviesWith250.
  ///
  /// In en, this message translates to:
  /// **'Read newspapers and watch movies with 2500 words.'**
  String get readNewspapersAndWatchMoviesWith250;

  /// No description provided for @databaseBoxNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Database box not open'**
  String get databaseBoxNotOpen;

  /// No description provided for @hsk1DataFileIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'HSK1 data file is empty'**
  String get hsk1DataFileIsEmpty;

  /// No description provided for @gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get gold;

  /// No description provided for @globalDictionaryNotInitialized.
  ///
  /// In en, this message translates to:
  /// **'Global Dictionary not initialized'**
  String get globalDictionaryNotInitialized;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get reading;

  /// No description provided for @recall.
  ///
  /// In en, this message translates to:
  /// **'Recall'**
  String get recall;

  /// No description provided for @speaking.
  ///
  /// In en, this message translates to:
  /// **'Speaking'**
  String get speaking;

  /// No description provided for @listening1.
  ///
  /// In en, this message translates to:
  /// **'Listening'**
  String get listening1;

  /// No description provided for @practiceStrokeOrderWithVisualGuides.
  ///
  /// In en, this message translates to:
  /// **'Practice stroke order with visual guides.'**
  String get practiceStrokeOrderWithVisualGuides;

  /// No description provided for @seeTheCharacterRecallThePinyinAndMe.
  ///
  /// In en, this message translates to:
  /// **'See the character, recall the Pinyin and Meaning.'**
  String get seeTheCharacterRecallThePinyinAndMe;

  /// No description provided for @seeTheMeaningDrawTheCharacterFromMe.
  ///
  /// In en, this message translates to:
  /// **'See the meaning, draw the character from memory.'**
  String get seeTheMeaningDrawTheCharacterFromMe;

  /// No description provided for @readOutLoudToTestYourPronunciationT.
  ///
  /// In en, this message translates to:
  /// **'Read out loud to test your pronunciation tones.'**
  String get readOutLoudToTestYourPronunciationT;

  /// No description provided for @listenToTheAudioAndIdentifyTheChara.
  ///
  /// In en, this message translates to:
  /// **'Listen to the audio and identify the character.'**
  String get listenToTheAudioAndIdentifyTheChara;

  /// No description provided for @contract.
  ///
  /// In en, this message translates to:
  /// **'Contract'**
  String get contract;

  /// No description provided for @whoeverImplementsMeMustBeAbleToDoTh.
  ///
  /// In en, this message translates to:
  /// **'Whoever implements me MUST be able to do these things.'**
  String get whoeverImplementsMeMustBeAbleToDoTh;

  /// No description provided for @koreFenrirCharonAoedePuckOrLocal.
  ///
  /// In en, this message translates to:
  /// **'Kore\', \'Fenrir\', \'Charon\', \'Aoede\', \'Puck\', or \'local'**
  String get koreFenrirCharonAoedePuckOrLocal;

  /// No description provided for @manageDecks.
  ///
  /// In en, this message translates to:
  /// **'Manage Decks'**
  String get manageDecks;

  /// No description provided for @weRanIntoTroubleLoadingTheLibraryPl.
  ///
  /// In en, this message translates to:
  /// **'We ran into trouble loading the library. Please try again.'**
  String get weRanIntoTroubleLoadingTheLibraryPl;

  /// No description provided for @noCharactersInLexicon1.
  ///
  /// In en, this message translates to:
  /// **'No characters in lexicon'**
  String get noCharactersInLexicon1;

  /// No description provided for @masterTheBuildingBlocks.
  ///
  /// In en, this message translates to:
  /// **'Master the building blocks'**
  String get masterTheBuildingBlocks;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @library1.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library1;

  /// No description provided for @youAreAPremiumMember.
  ///
  /// In en, this message translates to:
  /// **'You are a Premium member'**
  String get youAreAPremiumMember;

  /// No description provided for @createAccountToSyncProgress.
  ///
  /// In en, this message translates to:
  /// **'Create Account to Sync Progress'**
  String get createAccountToSyncProgress;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @guestScholar.
  ///
  /// In en, this message translates to:
  /// **'Guest Scholar'**
  String get guestScholar;

  /// No description provided for @localAccount.
  ///
  /// In en, this message translates to:
  /// **'Local Account'**
  String get localAccount;

  /// No description provided for @unknownRadical.
  ///
  /// In en, this message translates to:
  /// **'Unknown Radical'**
  String get unknownRadical;

  /// No description provided for @followTheGuideStroke.
  ///
  /// In en, this message translates to:
  /// **'Follow the guide stroke'**
  String get followTheGuideStroke;

  /// No description provided for @strokeAnimationSpeed.
  ///
  /// In en, this message translates to:
  /// **'Stroke Animation Speed'**
  String get strokeAnimationSpeed;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @deutsch.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get deutsch;

  /// No description provided for @bahasaIndonesia.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get bahasaIndonesia;

  /// No description provided for @italiano.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get italiano;

  /// No description provided for @today1d2d3d4d5d6d.
  ///
  /// In en, this message translates to:
  /// **'Today\', \'1d\', \'2d\', \'3d\', \'4d\', \'5d\', \'6d'**
  String get today1d2d3d4d5d6d;

  /// No description provided for @targetDeck.
  ///
  /// In en, this message translates to:
  /// **'Target Deck'**
  String get targetDeck;

  /// No description provided for @mixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get mixed;

  /// No description provided for @topicForContext.
  ///
  /// In en, this message translates to:
  /// **'Topic (for context)'**
  String get topicForContext;

  /// No description provided for @nounsOnly.
  ///
  /// In en, this message translates to:
  /// **'Nouns only'**
  String get nounsOnly;

  /// No description provided for @verbsOnly.
  ///
  /// In en, this message translates to:
  /// **'Verbs only'**
  String get verbsOnly;

  /// No description provided for @idiomsChengyu.
  ///
  /// In en, this message translates to:
  /// **'Idioms (Chengyu)'**
  String get idiomsChengyu;

  /// No description provided for @fullSentences.
  ///
  /// In en, this message translates to:
  /// **'Full Sentences'**
  String get fullSentences;

  /// No description provided for @beginnerHsk12.
  ///
  /// In en, this message translates to:
  /// **'Beginner (HSK 1-2)'**
  String get beginnerHsk12;

  /// No description provided for @intermediateHsk34.
  ///
  /// In en, this message translates to:
  /// **'Intermediate (HSK 3-4)'**
  String get intermediateHsk34;

  /// No description provided for @advancedHsk56.
  ///
  /// In en, this message translates to:
  /// **'Advanced (HSK 5-6)'**
  String get advancedHsk56;

  /// No description provided for @generatedByAi.
  ///
  /// In en, this message translates to:
  /// **'Generated by AI'**
  String get generatedByAi;

  /// No description provided for @canYouGiveMeTwoMoreExamplesUsingThi.
  ///
  /// In en, this message translates to:
  /// **'Can you give me two more examples using this word?'**
  String get canYouGiveMeTwoMoreExamplesUsingThi;

  /// No description provided for @whatAreSomeSimilarWordsAndHowDoThey.
  ///
  /// In en, this message translates to:
  /// **'What are some similar words and how do they differ?'**
  String get whatAreSomeSimilarWordsAndHowDoThey;

  /// No description provided for @isThisWordUsedInSpokenOrWrittenChin.
  ///
  /// In en, this message translates to:
  /// **'Is this word used in spoken or written Chinese more?'**
  String get isThisWordUsedInSpokenOrWrittenChin;

  /// No description provided for @areThereOtherWaysToTranslateThisWor.
  ///
  /// In en, this message translates to:
  /// **'Are there other ways to translate this word?'**
  String get areThereOtherWaysToTranslateThisWor;

  /// No description provided for @whatAreCommonWordsThatGoTogetherWit.
  ///
  /// In en, this message translates to:
  /// **'What are common words that go together with this word?'**
  String get whatAreCommonWordsThatGoTogetherWit;

  /// No description provided for @whatAreCommonMistakesLearnersMakeWi.
  ///
  /// In en, this message translates to:
  /// **'What are common mistakes learners make with this word?'**
  String get whatAreCommonMistakesLearnersMakeWi;

  /// No description provided for @emptyResponse.
  ///
  /// In en, this message translates to:
  /// **'Empty response'**
  String get emptyResponse;

  /// No description provided for @whatIsTheOracleBoneScriptOriginOfTh.
  ///
  /// In en, this message translates to:
  /// **'What is the oracle bone script origin of this character?'**
  String get whatIsTheOracleBoneScriptOriginOfTh;

  /// No description provided for @howDidTheAncientFormOfThisCharacter.
  ///
  /// In en, this message translates to:
  /// **'How did the ancient form of this character evolve over time?'**
  String get howDidTheAncientFormOfThisCharacter;

  /// No description provided for @giveMe3CommonWordsThatContainThisCh.
  ///
  /// In en, this message translates to:
  /// **'Give me 3 common words that contain this character.'**
  String get giveMe3CommonWordsThatContainThisCh;

  /// No description provided for @whatOtherCharactersShareTheSameRadi.
  ///
  /// In en, this message translates to:
  /// **'What other characters share the same radical?'**
  String get whatOtherCharactersShareTheSameRadi;

  /// No description provided for @isThereAChineseProverbOrSayingFeatu.
  ///
  /// In en, this message translates to:
  /// **'Is there a Chinese proverb or saying featuring this character?'**
  String get isThereAChineseProverbOrSayingFeatu;

  /// No description provided for @explainTheStrokeOrderRulesForThisCh.
  ///
  /// In en, this message translates to:
  /// **'Explain the stroke order rules for this character.'**
  String get explainTheStrokeOrderRulesForThisCh;

  /// No description provided for @giveMeOneCalligraphyTipForWritingTh.
  ///
  /// In en, this message translates to:
  /// **'Give me one calligraphy tip for writing this character beautifully.'**
  String get giveMeOneCalligraphyTipForWritingTh;

  /// No description provided for @isThereAnythingTrickyAboutUsingThis.
  ///
  /// In en, this message translates to:
  /// **'Is there anything tricky about using this grammatically?'**
  String get isThereAnythingTrickyAboutUsingThis;

  /// No description provided for @whatWordsAreCommonlyConfusedWithThi.
  ///
  /// In en, this message translates to:
  /// **'What words are commonly confused with this one and why?'**
  String get whatWordsAreCommonlyConfusedWithThi;

  /// No description provided for @doesThisCharacterCarryCulturalSymbo.
  ///
  /// In en, this message translates to:
  /// **'Does this character carry cultural symbolism in China?'**
  String get doesThisCharacterCarryCulturalSymbo;

  /// No description provided for @isThisCharacterCommonlySeenInChines.
  ///
  /// In en, this message translates to:
  /// **'Is this character commonly seen in Chinese movies, songs, or texts?'**
  String get isThisCharacterCommonlySeenInChines;

  /// No description provided for @whatDoesTheRadicalOfThisCharacterMe.
  ///
  /// In en, this message translates to:
  /// **'What does the radical of this character mean?'**
  String get whatDoesTheRadicalOfThisCharacterMe;

  /// No description provided for @breakDownEveryComponentAndItsMeanin.
  ///
  /// In en, this message translates to:
  /// **'Break down every component and its meaning.'**
  String get breakDownEveryComponentAndItsMeanin;

  /// No description provided for @giveMeATrickToRememberTheCorrectTon.
  ///
  /// In en, this message translates to:
  /// **'Give me a trick to remember the correct tone for this character.'**
  String get giveMeATrickToRememberTheCorrectTon;

  /// No description provided for @areThereCommonHomophonesThatAreOfte.
  ///
  /// In en, this message translates to:
  /// **'Are there common homophones that are often confused with this?'**
  String get areThereCommonHomophonesThatAreOfte;

  /// No description provided for @quotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'Quota exceeded'**
  String get quotaExceeded;

  /// No description provided for @mustProvideEitherCardOrCards.
  ///
  /// In en, this message translates to:
  /// **'Must provide either card or cards'**
  String get mustProvideEitherCardOrCards;

  /// No description provided for @deckSettings.
  ///
  /// In en, this message translates to:
  /// **'Deck Settings'**
  String get deckSettings;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// No description provided for @sealRed.
  ///
  /// In en, this message translates to:
  /// **'Seal Red'**
  String get sealRed;

  /// No description provided for @sealScript.
  ///
  /// In en, this message translates to:
  /// **'Seal Script'**
  String get sealScript;

  /// No description provided for @startYourStreak.
  ///
  /// In en, this message translates to:
  /// **'START YOUR STREAK'**
  String get startYourStreak;

  /// No description provided for @traditionalCharacter.
  ///
  /// In en, this message translates to:
  /// **'Traditional Character'**
  String get traditionalCharacter;

  /// No description provided for @inQueue.
  ///
  /// In en, this message translates to:
  /// **'In Queue'**
  String get inQueue;

  /// No description provided for @tapToListenAgain.
  ///
  /// In en, this message translates to:
  /// **'Tap to listen again'**
  String get tapToListenAgain;

  /// No description provided for @contextClue.
  ///
  /// In en, this message translates to:
  /// **'Context Clue'**
  String get contextClue;

  /// No description provided for @microphonePermissionRequired1.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission required.'**
  String get microphonePermissionRequired1;

  /// No description provided for @recordingFailedNoFile.
  ///
  /// In en, this message translates to:
  /// **'Recording failed (no file).'**
  String get recordingFailedNoFile;

  /// No description provided for @holdToSpeakOptional.
  ///
  /// In en, this message translates to:
  /// **'Hold to speak (Optional)'**
  String get holdToSpeakOptional;

  /// No description provided for @microphonePermissionDeniedEnableItI.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission denied. Enable it in Settings to use Shadowing Studio.'**
  String get microphonePermissionDeniedEnableItI;

  /// No description provided for @sessionSummary.
  ///
  /// In en, this message translates to:
  /// **'Session Summary'**
  String get sessionSummary;

  /// No description provided for @hereAreTheCharactersYouStruggledWit.
  ///
  /// In en, this message translates to:
  /// **'Here are the characters you struggled with:'**
  String get hereAreTheCharactersYouStruggledWit;

  /// No description provided for @applySessionGradesToSpacedRepetitio.
  ///
  /// In en, this message translates to:
  /// **'Apply session grades to Spaced Repetition (Speaking Mode)'**
  String get applySessionGradesToSpacedRepetitio;

  /// No description provided for @masterYourMandarinPronunciationnbyM.
  ///
  /// In en, this message translates to:
  /// **'Master your Mandarin pronunciation\\nby mimicking native speech.'**
  String get masterYourMandarinPronunciationnbyM;

  /// No description provided for @aiIsGradingYourPronunciation.
  ///
  /// In en, this message translates to:
  /// **'AI is grading your pronunciation...'**
  String get aiIsGradingYourPronunciation;

  /// No description provided for @holdMicToRecordReleaseToGrade.
  ///
  /// In en, this message translates to:
  /// **'Hold mic to record. Release to grade.'**
  String get holdMicToRecordReleaseToGrade;

  /// No description provided for @tapAnySyllableToAuditionAll4Tones.
  ///
  /// In en, this message translates to:
  /// **'Tap any syllable to audition all 4 tones:'**
  String get tapAnySyllableToAuditionAll4Tones;

  /// No description provided for @freeFlowConversationalPractice.
  ///
  /// In en, this message translates to:
  /// **'Free flow conversational practice.'**
  String get freeFlowConversationalPractice;

  /// No description provided for @failedToGeneratePhrasePleaseTryAgai.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate phrase. Please try again.'**
  String get failedToGeneratePhrasePleaseTryAgai;

  /// No description provided for @recordingTooShortHoldTheMicButtonLo.
  ///
  /// In en, this message translates to:
  /// **'Recording too short. Hold the mic button longer.'**
  String get recordingTooShortHoldTheMicButtonLo;

  /// No description provided for @recordingErrorPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Recording error. Please try again.'**
  String get recordingErrorPleaseTryAgain;

  /// No description provided for @noRecordingCapturedPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'No recording captured. Please try again.'**
  String get noRecordingCapturedPleaseTryAgain;

  /// No description provided for @recordedAudioIsEmptyPleaseTryAgainA.
  ///
  /// In en, this message translates to:
  /// **'Recorded audio is empty. Please try again and speak clearly.'**
  String get recordedAudioIsEmptyPleaseTryAgainA;

  /// No description provided for @azureSpeechApiKeysAreMissing1.
  ///
  /// In en, this message translates to:
  /// **'Azure Speech API keys are missing'**
  String get azureSpeechApiKeysAreMissing1;

  /// No description provided for @azureError401.
  ///
  /// In en, this message translates to:
  /// **'Azure Error 401'**
  String get azureError401;

  /// No description provided for @azureAuthenticationFailedCheckYourS.
  ///
  /// In en, this message translates to:
  /// **'Azure authentication failed. Check your Speech API key and region in .env'**
  String get azureAuthenticationFailedCheckYourS;

  /// No description provided for @azureError429.
  ///
  /// In en, this message translates to:
  /// **'Azure Error 429'**
  String get azureError429;

  /// No description provided for @azureQuotaExceededTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Azure quota exceeded. Try again later.'**
  String get azureQuotaExceededTryAgainLater;

  /// No description provided for @azureGradingTimedOutCheckYourIntern.
  ///
  /// In en, this message translates to:
  /// **'Azure grading timed out. Check your internet connection.'**
  String get azureGradingTimedOutCheckYourIntern;

  /// No description provided for @recognitionFailedNull.
  ///
  /// In en, this message translates to:
  /// **'Recognition failed: null'**
  String get recognitionFailedNull;

  /// No description provided for @couldNotHearYouClearlyPleaseTryAgai.
  ///
  /// In en, this message translates to:
  /// **'Could not hear you clearly. Please try again.'**
  String get couldNotHearYouClearlyPleaseTryAgai;

  /// No description provided for @singlePhrasePractice.
  ///
  /// In en, this message translates to:
  /// **'Single Phrase Practice'**
  String get singlePhrasePractice;

  /// No description provided for @failedToGeneratePhrase.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate phrase'**
  String get failedToGeneratePhrase;

  /// No description provided for @omitted.
  ///
  /// In en, this message translates to:
  /// **'Omitted'**
  String get omitted;

  /// No description provided for @partial.
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get partial;

  /// No description provided for @mispronounced.
  ///
  /// In en, this message translates to:
  /// **'Mispronounced'**
  String get mispronounced;

  /// No description provided for @startSession1.
  ///
  /// In en, this message translates to:
  /// **'Start Session'**
  String get startSession1;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @translationFailed.
  ///
  /// In en, this message translates to:
  /// **'Translation failed'**
  String get translationFailed;

  /// No description provided for @engagingMacroeconomicAndBusinessBre.
  ///
  /// In en, this message translates to:
  /// **'Engaging macroeconomic and business breakdowns explained through lively storytelling.'**
  String get engagingMacroeconomicAndBusinessBre;

  /// No description provided for @exploresWorldEconomiesBankingHistor.
  ///
  /// In en, this message translates to:
  /// **'Explores world economies, banking histories, and global industry dynamics.'**
  String get exploresWorldEconomiesBankingHistor;

  /// No description provided for @clearArticulateMandarinPerfectForIn.
  ///
  /// In en, this message translates to:
  /// **'Clear, articulate Mandarin perfect for intermediate and advanced learners.'**
  String get clearArticulateMandarinPerfectForIn;

  /// No description provided for @chefWang.
  ///
  /// In en, this message translates to:
  /// **'Chef Wang'**
  String get chefWang;

  /// No description provided for @masterSichuanCulinaryTechniquesTaug.
  ///
  /// In en, this message translates to:
  /// **'Master Sichuan culinary techniques taught directly by a professional head chef.'**
  String get masterSichuanCulinaryTechniquesTaug;

  /// No description provided for @stepbystepAuthenticChineseRecipesWi.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step authentic Chinese recipes with wok control and knife work.'**
  String get stepbystepAuthenticChineseRecipesWi;

  /// No description provided for @conciseCulinaryVocabularyAndClearIn.
  ///
  /// In en, this message translates to:
  /// **'Concise culinary vocabulary and clear instruction in natural Mandarin.'**
  String get conciseCulinaryVocabularyAndClearIn;

  /// No description provided for @cinematographyCuttingedgeCameraTech.
  ///
  /// In en, this message translates to:
  /// **'Cinematography, cutting-edge camera tech, and deep digital media evaluations.'**
  String get cinematographyCuttingedgeCameraTech;

  /// No description provided for @highproductionDocumentaryStyleExplo.
  ///
  /// In en, this message translates to:
  /// **'High-production documentary style exploring video creation and AI innovations.'**
  String get highproductionDocumentaryStyleExplo;

  /// No description provided for @richTechnicalMandarinWithCrystalcle.
  ///
  /// In en, this message translates to:
  /// **'Rich technical Mandarin with crystal-clear pronunciation and visual captions.'**
  String get richTechnicalMandarinWithCrystalcle;

  /// No description provided for @indepthInvestigativeJournalismAndCu.
  ///
  /// In en, this message translates to:
  /// **'In-depth investigative journalism and current affairs commentary.'**
  String get indepthInvestigativeJournalismAndCu;

  /// No description provided for @criticalPerspectivesOnSocialPhenome.
  ///
  /// In en, this message translates to:
  /// **'Critical perspectives on social phenomena, world news, and history.'**
  String get criticalPerspectivesOnSocialPhenome;

  /// No description provided for @formalInvestigativeDiscourseIdealFo.
  ///
  /// In en, this message translates to:
  /// **'Formal investigative discourse ideal for advanced listening comprehension.'**
  String get formalInvestigativeDiscourseIdealFo;

  /// No description provided for @bitesizedAnimatedScienceDocumentari.
  ///
  /// In en, this message translates to:
  /// **'Bite-sized animated science documentaries answering everyday questions.'**
  String get bitesizedAnimatedScienceDocumentari;

  /// No description provided for @exploresPhysicsBiologyAndEverydayCu.
  ///
  /// In en, this message translates to:
  /// **'Explores physics, biology, and everyday curiosities with fun infographics.'**
  String get exploresPhysicsBiologyAndEverydayCu;

  /// No description provided for @standardBeijingMandarinWithWellpace.
  ///
  /// In en, this message translates to:
  /// **'Standard Beijing Mandarin with well-paced narration and clear subtitles.'**
  String get standardBeijingMandarinWithWellpace;

  /// No description provided for @heartwarmingStreetFoodAdventuresAnd.
  ///
  /// In en, this message translates to:
  /// **'Heartwarming street food adventures and genuine conversations across China.'**
  String get heartwarmingStreetFoodAdventuresAnd;

  /// No description provided for @exploresRegionalHumanStoriesFamilyT.
  ///
  /// In en, this message translates to:
  /// **'Explores regional human stories, family traditions, and local delicacies.'**
  String get exploresRegionalHumanStoriesFamilyT;

  /// No description provided for @naturalConversationalMandarinWithDa.
  ///
  /// In en, this message translates to:
  /// **'Natural conversational Mandarin with daily slang and emotional warmth.'**
  String get naturalConversationalMandarinWithDa;

  /// No description provided for @humorousAndHonestConsumerElectronic.
  ///
  /// In en, this message translates to:
  /// **'Humorous and honest consumer electronics reviews from real-life experience.'**
  String get humorousAndHonestConsumerElectronic;

  /// No description provided for @testingSmartphonesSmartHomeGadgetsA.
  ///
  /// In en, this message translates to:
  /// **'Testing smartphones, smart home gadgets, and tech lifestyle gear.'**
  String get testingSmartphonesSmartHomeGadgetsA;

  /// No description provided for @relaxedHumorousConversationalDialog.
  ///
  /// In en, this message translates to:
  /// **'Relaxed, humorous conversational dialogue with modern colloquialisms.'**
  String get relaxedHumorousConversationalDialog;

  /// No description provided for @seanKitchen.
  ///
  /// In en, this message translates to:
  /// **'Sean Kitchen'**
  String get seanKitchen;

  /// No description provided for @deliciousHomecookedChineseDishesAnd.
  ///
  /// In en, this message translates to:
  /// **'Delicious home-cooked Chinese dishes and street snack recreation.'**
  String get deliciousHomecookedChineseDishesAnd;

  /// No description provided for @easytofollowKitchenTipsForCookingAu.
  ///
  /// In en, this message translates to:
  /// **'Easy-to-follow kitchen tips for cooking authentic Asian comfort food.'**
  String get easytofollowKitchenTipsForCookingAu;

  /// No description provided for @warmInvitingCommentaryWithPractical.
  ///
  /// In en, this message translates to:
  /// **'Warm, inviting commentary with practical kitchen vocabulary.'**
  String get warmInvitingCommentaryWithPractical;

  /// No description provided for @chineseChannel.
  ///
  /// In en, this message translates to:
  /// **'Chinese Channel'**
  String get chineseChannel;

  /// No description provided for @structuredChineseLanguageLessonsAnd.
  ///
  /// In en, this message translates to:
  /// **'Structured Chinese language lessons and cultural discovery tutorials.'**
  String get structuredChineseLanguageLessonsAnd;

  /// No description provided for @grammarPointsHskVocabularyBuildingA.
  ///
  /// In en, this message translates to:
  /// **'Grammar points, HSK vocabulary building, and conversational patterns.'**
  String get grammarPointsHskVocabularyBuildingA;

  /// No description provided for @clearEducationalPacingTailoredSpeci.
  ///
  /// In en, this message translates to:
  /// **'Clear educational pacing tailored specifically for Chinese learners.'**
  String get clearEducationalPacingTailoredSpeci;

  /// No description provided for @oneInABillion.
  ///
  /// In en, this message translates to:
  /// **'One in a Billion'**
  String get oneInABillion;

  /// No description provided for @intimatePortraitsAndStoriesOfUnique.
  ///
  /// In en, this message translates to:
  /// **'Intimate portraits and stories of unique individuals in contemporary China.'**
  String get intimatePortraitsAndStoriesOfUnique;

  /// No description provided for @exploresDiverseLifeChoicesYouthCult.
  ///
  /// In en, this message translates to:
  /// **'Explores diverse life choices, youth culture, and modern social shifts.'**
  String get exploresDiverseLifeChoicesYouthCult;

  /// No description provided for @deepNarrativeStorytellingWithRichVo.
  ///
  /// In en, this message translates to:
  /// **'Deep narrative storytelling with rich vocabulary and authentic voices.'**
  String get deepNarrativeStorytellingWithRichVo;

  /// No description provided for @vickySoup.
  ///
  /// In en, this message translates to:
  /// **'Vicky Soup'**
  String get vickySoup;

  /// No description provided for @aestheticLifestyleVlogsFashionStyli.
  ///
  /// In en, this message translates to:
  /// **'Aesthetic lifestyle vlogs, fashion styling, and daily routines.'**
  String get aestheticLifestyleVlogsFashionStyli;

  /// No description provided for @travelDiariesAndCozyLifeMomentsDocu.
  ///
  /// In en, this message translates to:
  /// **'Travel diaries and cozy life moments documented with cinematic warmth.'**
  String get travelDiariesAndCozyLifeMomentsDocu;

  /// No description provided for @naturalCasualMandarinSpokenAtAComfo.
  ///
  /// In en, this message translates to:
  /// **'Natural casual Mandarin spoken at a comfortable, expressive pace.'**
  String get naturalCasualMandarinSpokenAtAComfo;

  /// No description provided for @tededMandarin.
  ///
  /// In en, this message translates to:
  /// **'TED-Ed Mandarin'**
  String get tededMandarin;

  /// No description provided for @highqualityAnimatedEducationalLesso.
  ///
  /// In en, this message translates to:
  /// **'High-quality animated educational lessons on science, philosophy, and history.'**
  String get highqualityAnimatedEducationalLesso;

  /// No description provided for @thoughtprovokingRiddlesClassicLiter.
  ///
  /// In en, this message translates to:
  /// **'Thought-provoking riddles, classic literature, and psychology mysteries.'**
  String get thoughtprovokingRiddlesClassicLiter;

  /// No description provided for @impeccableVoiceoverMandarinWithSync.
  ///
  /// In en, this message translates to:
  /// **'Impeccable voice-over Mandarin with synchronized bilingual subtitles.'**
  String get impeccableVoiceoverMandarinWithSync;

  /// No description provided for @channel.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get channel;

  /// No description provided for @curatedCulturalDocumentariesAndChin.
  ///
  /// In en, this message translates to:
  /// **'Curated cultural documentaries and Chinese lifestyle highlights.'**
  String get curatedCulturalDocumentariesAndChin;

  /// No description provided for @exploringTraditionalArtsHeritageCra.
  ///
  /// In en, this message translates to:
  /// **'Exploring traditional arts, heritage craftsmanship, and modern trends.'**
  String get exploringTraditionalArtsHeritageCra;

  /// No description provided for @highQualityAudioWithSynchronizedChi.
  ///
  /// In en, this message translates to:
  /// **'High quality audio with synchronized Chinese closed captions.'**
  String get highQualityAudioWithSynchronizedChi;

  /// No description provided for @interestingStoriesAndCreativeVideoP.
  ///
  /// In en, this message translates to:
  /// **'Interesting stories and creative video projects across the Chinese web.'**
  String get interestingStoriesAndCreativeVideoP;

  /// No description provided for @engagingInterviewsStorytellingAndVi.
  ///
  /// In en, this message translates to:
  /// **'Engaging interviews, storytelling, and visual explorations.'**
  String get engagingInterviewsStorytellingAndVi;

  /// No description provided for @greatListeningMaterialWithStandardP.
  ///
  /// In en, this message translates to:
  /// **'Great listening material with standard pronunciation.'**
  String get greatListeningMaterialWithStandardP;

  /// No description provided for @xVsY.
  ///
  /// In en, this message translates to:
  /// **'X vs Y'**
  String get xVsY;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @contemporaryStories.
  ///
  /// In en, this message translates to:
  /// **'Contemporary Stories'**
  String get contemporaryStories;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @advancedReading.
  ///
  /// In en, this message translates to:
  /// **'Advanced Reading'**
  String get advancedReading;

  /// No description provided for @intermediateReading.
  ///
  /// In en, this message translates to:
  /// **'Intermediate Reading'**
  String get intermediateReading;

  /// No description provided for @beginnerReading.
  ///
  /// In en, this message translates to:
  /// **'Beginner Reading'**
  String get beginnerReading;

  /// No description provided for @mandarinBean.
  ///
  /// In en, this message translates to:
  /// **'Mandarin Bean'**
  String get mandarinBean;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @localDb.
  ///
  /// In en, this message translates to:
  /// **'Local DB'**
  String get localDb;

  /// No description provided for @emperorTaizong.
  ///
  /// In en, this message translates to:
  /// **'Emperor Taizong'**
  String get emperorTaizong;

  /// No description provided for @emperorXuanzong.
  ///
  /// In en, this message translates to:
  /// **'Emperor Xuanzong'**
  String get emperorXuanzong;

  /// No description provided for @liBai.
  ///
  /// In en, this message translates to:
  /// **'Li Bai'**
  String get liBai;

  /// No description provided for @gradedReader.
  ///
  /// In en, this message translates to:
  /// **'Graded Reader'**
  String get gradedReader;

  /// No description provided for @ucj10r97lkwgdtqbt6xzv8gLearnMandari.
  ///
  /// In en, this message translates to:
  /// **'UCJ10R97LkwGdTqBT6xz-v8g\': \'Learn Mandarin with TaiwanPlus'**
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari;

  /// No description provided for @ucsxriuqkzzmaqklq0n9xfvwEverydayChi.
  ///
  /// In en, this message translates to:
  /// **'UCSXriUqkzZmAQklQ0N9XFVw\': \'Everyday Chinese'**
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi;

  /// No description provided for @graceMandarinChinese.
  ///
  /// In en, this message translates to:
  /// **'Grace Mandarin Chinese'**
  String get graceMandarinChinese;

  /// No description provided for @ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi.
  ///
  /// In en, this message translates to:
  /// **'UCOLBhVvL5dcJLMZeQBUu1Vw\': \'Ting-Daily life in China'**
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi;

  /// No description provided for @xinxin.
  ///
  /// In en, this message translates to:
  /// **'Xinxin'**
  String get xinxin;

  /// No description provided for @sweetFamilyDailyLife.
  ///
  /// In en, this message translates to:
  /// **'Sweet Family Daily Life'**
  String get sweetFamilyDailyLife;

  /// No description provided for @chinsunDailyLife.
  ///
  /// In en, this message translates to:
  /// **'Chin-Sun Daily Life'**
  String get chinsunDailyLife;

  /// No description provided for @tasteChina.
  ///
  /// In en, this message translates to:
  /// **'Taste China'**
  String get tasteChina;

  /// No description provided for @dawenFoodQuest.
  ///
  /// In en, this message translates to:
  /// **'DaWen Food Quest'**
  String get dawenFoodQuest;

  /// No description provided for @chinaTravelWithCangbao.
  ///
  /// In en, this message translates to:
  /// **'China Travel with Cangbao'**
  String get chinaTravelWithCangbao;

  /// No description provided for @alinFoodWalk.
  ///
  /// In en, this message translates to:
  /// **'Alin Food Walk'**
  String get alinFoodWalk;

  /// No description provided for @videoOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'VIDEO OF THE DAY'**
  String get videoOfTheDay;

  /// No description provided for @noValidVideoFound.
  ///
  /// In en, this message translates to:
  /// **'No valid video found.'**
  String get noValidVideoFound;

  /// No description provided for @listeningPractice.
  ///
  /// In en, this message translates to:
  /// **'LISTENING PRACTICE'**
  String get listeningPractice;

  /// No description provided for @socialSkills.
  ///
  /// In en, this message translates to:
  /// **'SOCIAL SKILLS'**
  String get socialSkills;

  /// No description provided for @culturalContext.
  ///
  /// In en, this message translates to:
  /// **'CULTURAL CONTEXT'**
  String get culturalContext;

  /// No description provided for @realLife.
  ///
  /// In en, this message translates to:
  /// **'REAL LIFE'**
  String get realLife;

  /// No description provided for @realWorld.
  ///
  /// In en, this message translates to:
  /// **'REAL WORLD'**
  String get realWorld;

  /// No description provided for @articleOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'ARTICLE OF THE DAY'**
  String get articleOfTheDay;

  /// No description provided for @failedToLoadOrParseRssFeed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load or parse RSS feed.'**
  String get failedToLoadOrParseRssFeed;

  /// No description provided for @drama.
  ///
  /// In en, this message translates to:
  /// **'Drama'**
  String get drama;

  /// No description provided for @youkugetAppNow.
  ///
  /// In en, this message translates to:
  /// **'YOUKU-Get APP now'**
  String get youkugetAppNow;

  /// No description provided for @romanceTrailer.
  ///
  /// In en, this message translates to:
  /// **'Romance\', \'Trailer'**
  String get romanceTrailer;

  /// No description provided for @romance.
  ///
  /// In en, this message translates to:
  /// **'Romance'**
  String get romance;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @mystery.
  ///
  /// In en, this message translates to:
  /// **'Mystery'**
  String get mystery;

  /// No description provided for @historical.
  ///
  /// In en, this message translates to:
  /// **'Historical'**
  String get historical;

  /// No description provided for @historicalAction.
  ///
  /// In en, this message translates to:
  /// **'Historical\', \'Action'**
  String get historicalAction;

  /// No description provided for @historicalRomance.
  ///
  /// In en, this message translates to:
  /// **'Historical\', \'Romance'**
  String get historicalRomance;

  /// No description provided for @anYouth.
  ///
  /// In en, this message translates to:
  /// **'An Youth'**
  String get anYouth;

  /// No description provided for @historicalSliceOfLife.
  ///
  /// In en, this message translates to:
  /// **'Historical\', \'Slice of Life'**
  String get historicalSliceOfLife;

  /// No description provided for @historicalHighlight.
  ///
  /// In en, this message translates to:
  /// **'Historical\', \'Highlight'**
  String get historicalHighlight;

  /// No description provided for @youkuEnglishgetAppNow.
  ///
  /// In en, this message translates to:
  /// **'YOUKU English-Get APP now'**
  String get youkuEnglishgetAppNow;

  /// No description provided for @theDouble.
  ///
  /// In en, this message translates to:
  /// **'The Double'**
  String get theDouble;

  /// No description provided for @updatesByOshin.
  ///
  /// In en, this message translates to:
  /// **'Updates By Oshin'**
  String get updatesByOshin;

  /// No description provided for @backFromTheBrink.
  ///
  /// In en, this message translates to:
  /// **'Back from the Brink'**
  String get backFromTheBrink;

  /// No description provided for @fallingIntoYourSmile.
  ///
  /// In en, this message translates to:
  /// **'Falling Into Your Smile'**
  String get fallingIntoYourSmile;

  /// No description provided for @everyoneLovesMe.
  ///
  /// In en, this message translates to:
  /// **'Everyone Loves Me'**
  String get everyoneLovesMe;

  /// No description provided for @tillTheEndOfTheMoon.
  ///
  /// In en, this message translates to:
  /// **'Till The End of The Moon'**
  String get tillTheEndOfTheMoon;

  /// No description provided for @theBestDayOfMyLife.
  ///
  /// In en, this message translates to:
  /// **'The Best Day of My Life'**
  String get theBestDayOfMyLife;

  /// No description provided for @gikkiChineseDrama.
  ///
  /// In en, this message translates to:
  /// **'GIKKI Chinese Drama'**
  String get gikkiChineseDrama;

  /// No description provided for @dashingYouth.
  ///
  /// In en, this message translates to:
  /// **'Dashing Youth'**
  String get dashingYouth;

  /// No description provided for @rebornChineseDramaEngSub.
  ///
  /// In en, this message translates to:
  /// **'Reborn Chinese drama ENG SUB'**
  String get rebornChineseDramaEngSub;

  /// No description provided for @ijenwaBenita.
  ///
  /// In en, this message translates to:
  /// **'Ijenwa Benita'**
  String get ijenwaBenita;

  /// No description provided for @whenIFlyTowardsYou.
  ///
  /// In en, this message translates to:
  /// **'When I Fly Towards You'**
  String get whenIFlyTowardsYou;

  /// No description provided for @mztvExclusiveChineseDrama.
  ///
  /// In en, this message translates to:
  /// **'MZTV Exclusive Chinese Drama'**
  String get mztvExclusiveChineseDrama;

  /// No description provided for @theStarryLove.
  ///
  /// In en, this message translates to:
  /// **'The Starry Love'**
  String get theStarryLove;

  /// No description provided for @comedy.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get comedy;

  /// No description provided for @backFromTheBrink1.
  ///
  /// In en, this message translates to:
  /// **'Back from the Brink\':'**
  String get backFromTheBrink1;

  /// No description provided for @dashingYouth1.
  ///
  /// In en, this message translates to:
  /// **'Dashing Youth\':'**
  String get dashingYouth1;

  /// No description provided for @beReborn.
  ///
  /// In en, this message translates to:
  /// **'Be Reborn'**
  String get beReborn;

  /// No description provided for @beautyStrategy.
  ///
  /// In en, this message translates to:
  /// **'Beauty Strategy'**
  String get beautyStrategy;

  /// No description provided for @myDivineEmissary.
  ///
  /// In en, this message translates to:
  /// **'My Divine Emissary'**
  String get myDivineEmissary;

  /// No description provided for @theHope.
  ///
  /// In en, this message translates to:
  /// **'The Hope'**
  String get theHope;

  /// No description provided for @ep16In.
  ///
  /// In en, this message translates to:
  /// **'EP16\': \'In'**
  String get ep16In;

  /// No description provided for @everyoneLovesMe1.
  ///
  /// In en, this message translates to:
  /// **'Everyone Loves Me\': \''**
  String get everyoneLovesMe1;

  /// No description provided for @fallingIntoYourSmile1.
  ///
  /// In en, this message translates to:
  /// **'Falling Into Your Smile\':'**
  String get fallingIntoYourSmile1;

  /// No description provided for @hiddenLove.
  ///
  /// In en, this message translates to:
  /// **'Hidden Love\':'**
  String get hiddenLove;

  /// No description provided for @loveBetweenFairyAndDevil.
  ///
  /// In en, this message translates to:
  /// **'Love Between Fairy and Devil\':'**
  String get loveBetweenFairyAndDevil;

  /// No description provided for @loveLikeTheGalaxy.
  ///
  /// In en, this message translates to:
  /// **'Love Like The Galaxy\':'**
  String get loveLikeTheGalaxy;

  /// No description provided for @membersPremiere.
  ///
  /// In en, this message translates to:
  /// **'Members Premiere'**
  String get membersPremiere;

  /// No description provided for @moonlight.
  ///
  /// In en, this message translates to:
  /// **'Moonlight'**
  String get moonlight;

  /// No description provided for @myJourneyToYou.
  ///
  /// In en, this message translates to:
  /// **'My Journey to You\':'**
  String get myJourneyToYou;

  /// No description provided for @mysteriousLotusCasebook.
  ///
  /// In en, this message translates to:
  /// **'Mysterious Lotus Casebook\':'**
  String get mysteriousLotusCasebook;

  /// No description provided for @rebornChineseDramaEngSub1.
  ///
  /// In en, this message translates to:
  /// **'Reborn Chinese drama ENG SUB\': \''**
  String get rebornChineseDramaEngSub1;

  /// No description provided for @reborn.
  ///
  /// In en, this message translates to:
  /// **'Reborn'**
  String get reborn;

  /// No description provided for @theBestDayOfMyLife1.
  ///
  /// In en, this message translates to:
  /// **'The Best Day of My Life\': \''**
  String get theBestDayOfMyLife1;

  /// No description provided for @theDouble1.
  ///
  /// In en, this message translates to:
  /// **'The Double\':'**
  String get theDouble1;

  /// No description provided for @theLongBallad.
  ///
  /// In en, this message translates to:
  /// **'The Long Ballad\':'**
  String get theLongBallad;

  /// No description provided for @theStarryLove1.
  ///
  /// In en, this message translates to:
  /// **'The Starry Love\':'**
  String get theStarryLove1;

  /// No description provided for @theUntamed.
  ///
  /// In en, this message translates to:
  /// **'The Untamed\':'**
  String get theUntamed;

  /// No description provided for @tillTheEndOfTheMoon1.
  ///
  /// In en, this message translates to:
  /// **'Till The End of The Moon\':'**
  String get tillTheEndOfTheMoon1;

  /// No description provided for @whenIFlyTowardsYou1.
  ///
  /// In en, this message translates to:
  /// **'When I Fly Towards You\':'**
  String get whenIFlyTowardsYou1;

  /// No description provided for @wordOfHonor.
  ///
  /// In en, this message translates to:
  /// **'Word of Honor\':'**
  String get wordOfHonor;

  /// No description provided for @blossom.
  ///
  /// In en, this message translates to:
  /// **'Blossom'**
  String get blossom;

  /// No description provided for @gemini.
  ///
  /// In en, this message translates to:
  /// **'Gemini'**
  String get gemini;

  /// No description provided for @generationToGeneration.
  ///
  /// In en, this message translates to:
  /// **'Generation to Generation'**
  String get generationToGeneration;

  /// No description provided for @brocadeOdyssey.
  ///
  /// In en, this message translates to:
  /// **'Brocade Odyssey'**
  String get brocadeOdyssey;

  /// No description provided for @circleOfLove.
  ///
  /// In en, this message translates to:
  /// **'Circle of Love'**
  String get circleOfLove;

  /// No description provided for @dawnIsBreaking.
  ///
  /// In en, this message translates to:
  /// **'Dawn is Breaking'**
  String get dawnIsBreaking;

  /// No description provided for @firstRomance.
  ///
  /// In en, this message translates to:
  /// **'First Romance'**
  String get firstRomance;

  /// No description provided for @loveInTheClouds.
  ///
  /// In en, this message translates to:
  /// **'Love in The Clouds'**
  String get loveInTheClouds;

  /// No description provided for @secondChanceRomance.
  ///
  /// In en, this message translates to:
  /// **'Second Chance Romance'**
  String get secondChanceRomance;

  /// No description provided for @mrBad.
  ///
  /// In en, this message translates to:
  /// **'Mr. BAD'**
  String get mrBad;

  /// No description provided for @pursuitOfJade.
  ///
  /// In en, this message translates to:
  /// **'Pursuit of Jade'**
  String get pursuitOfJade;

  /// No description provided for @fatedHearts.
  ///
  /// In en, this message translates to:
  /// **'Fated Hearts'**
  String get fatedHearts;

  /// No description provided for @roadHome.
  ///
  /// In en, this message translates to:
  /// **'Road Home'**
  String get roadHome;

  /// No description provided for @myDearGuardian.
  ///
  /// In en, this message translates to:
  /// **'My Dear Guardian'**
  String get myDearGuardian;

  /// No description provided for @brightEyesInTheDark.
  ///
  /// In en, this message translates to:
  /// **'Bright Eyes in the Dark'**
  String get brightEyesInTheDark;

  /// No description provided for @theIngeniousOne.
  ///
  /// In en, this message translates to:
  /// **'The Ingenious One'**
  String get theIngeniousOne;

  /// No description provided for @herPhoenixMajesty.
  ///
  /// In en, this message translates to:
  /// **'Her Phoenix Majesty'**
  String get herPhoenixMajesty;

  /// No description provided for @dreamsNeverEnd.
  ///
  /// In en, this message translates to:
  /// **'Dreams Never End'**
  String get dreamsNeverEnd;

  /// No description provided for @theUltimateVowUnknownToYou.
  ///
  /// In en, this message translates to:
  /// **'The Ultimate Vow, Unknown to You'**
  String get theUltimateVowUnknownToYou;

  /// No description provided for @the300LoyalGhosts.
  ///
  /// In en, this message translates to:
  /// **'The 300 Loyal Ghosts'**
  String get the300LoyalGhosts;

  /// No description provided for @homelandGuardian.
  ///
  /// In en, this message translates to:
  /// **'Homeland Guardian'**
  String get homelandGuardian;

  /// No description provided for @loveIsAlwaysOnline.
  ///
  /// In en, this message translates to:
  /// **'Love is Always Online'**
  String get loveIsAlwaysOnline;

  /// No description provided for @thePrincessDecree.
  ///
  /// In en, this message translates to:
  /// **'The Princess Decree'**
  String get thePrincessDecree;

  /// No description provided for @aVowInTheDark.
  ///
  /// In en, this message translates to:
  /// **'A Vow in the Dark'**
  String get aVowInTheDark;

  /// No description provided for @aGirlLikeMe.
  ///
  /// In en, this message translates to:
  /// **'A Girl Like Me'**
  String get aGirlLikeMe;

  /// No description provided for @iAmNobody.
  ///
  /// In en, this message translates to:
  /// **'I Am Nobody'**
  String get iAmNobody;

  /// No description provided for @myMamaGo.
  ///
  /// In en, this message translates to:
  /// **'My Mama Go!'**
  String get myMamaGo;

  /// No description provided for @myWesternRegionPrincess.
  ///
  /// In en, this message translates to:
  /// **'My Western Region Princess'**
  String get myWesternRegionPrincess;

  /// No description provided for @aFlowerOnTheContinent.
  ///
  /// In en, this message translates to:
  /// **'A Flower On The Continent'**
  String get aFlowerOnTheContinent;

  /// No description provided for @thePrincess.
  ///
  /// In en, this message translates to:
  /// **'The Princess'**
  String get thePrincess;

  /// No description provided for @sweetLoveVersion.
  ///
  /// In en, this message translates to:
  /// **'Sweet Love Version'**
  String get sweetLoveVersion;

  /// No description provided for @hilariousFamily2.
  ///
  /// In en, this message translates to:
  /// **'Hilarious Family 2'**
  String get hilariousFamily2;

  /// No description provided for @guYuanMountainHasASchool.
  ///
  /// In en, this message translates to:
  /// **'Gu Yuan Mountain Has a School'**
  String get guYuanMountainHasASchool;

  /// No description provided for @foreverYoung.
  ///
  /// In en, this message translates to:
  /// **'Forever Young'**
  String get foreverYoung;

  /// No description provided for @theHiddenHeirYeChen.
  ///
  /// In en, this message translates to:
  /// **'The Hidden Heir Ye Chen'**
  String get theHiddenHeirYeChen;

  /// No description provided for @extraordinary.
  ///
  /// In en, this message translates to:
  /// **'Extraordinary'**
  String get extraordinary;

  /// No description provided for @sideStoryOfFoxVolant.
  ///
  /// In en, this message translates to:
  /// **'Side Story of Fox Volant'**
  String get sideStoryOfFoxVolant;

  /// No description provided for @loveOfTheDivineTree.
  ///
  /// In en, this message translates to:
  /// **'Love of the Divine Tree'**
  String get loveOfTheDivineTree;

  /// No description provided for @rebirth.
  ///
  /// In en, this message translates to:
  /// **'Rebirth'**
  String get rebirth;

  /// No description provided for @moonlitReunion.
  ///
  /// In en, this message translates to:
  /// **'Moonlit Reunion'**
  String get moonlitReunion;

  /// No description provided for @videoCountsCannotBeNegative.
  ///
  /// In en, this message translates to:
  /// **'Video counts cannot be negative.'**
  String get videoCountsCannotBeNegative;

  /// No description provided for @publicDomainClassic.
  ///
  /// In en, this message translates to:
  /// **'Public Domain Classic'**
  String get publicDomainClassic;

  /// No description provided for @idioms.
  ///
  /// In en, this message translates to:
  /// **'Idioms'**
  String get idioms;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @fairyTales.
  ///
  /// In en, this message translates to:
  /// **'Fairy Tales'**
  String get fairyTales;

  /// No description provided for @hereIsAFascinatingCulturalExplanati.
  ///
  /// In en, this message translates to:
  /// **'Here is a fascinating cultural explanation'**
  String get hereIsAFascinatingCulturalExplanati;

  /// No description provided for @videoFetchTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Video fetch timed out'**
  String get videoFetchTimedOut;

  /// No description provided for @aboutChannel.
  ///
  /// In en, this message translates to:
  /// **'ABOUT CHANNEL'**
  String get aboutChannel;

  /// No description provided for @noVideosFound.
  ///
  /// In en, this message translates to:
  /// **'No videos found'**
  String get noVideosFound;

  /// No description provided for @failedToLoadVideos.
  ///
  /// In en, this message translates to:
  /// **'Failed to load videos'**
  String get failedToLoadVideos;

  /// No description provided for @highqualityCuratedMandarinContentWi.
  ///
  /// In en, this message translates to:
  /// **'High-quality curated Mandarin content with natural vocabulary.'**
  String get highqualityCuratedMandarinContentWi;

  /// No description provided for @authenticSpokenChineseAcrossRealwor.
  ///
  /// In en, this message translates to:
  /// **'Authentic spoken Chinese across real-world themes and topics.'**
  String get authenticSpokenChineseAcrossRealwor;

  /// No description provided for @engagingVideoMaterialWithInteractiv.
  ///
  /// In en, this message translates to:
  /// **'Engaging video material with interactive synchronized subtitles.'**
  String get engagingVideoMaterialWithInteractiv;

  /// No description provided for @watchVideo.
  ///
  /// In en, this message translates to:
  /// **'Watch Video'**
  String get watchVideo;

  /// No description provided for @culturalInsight.
  ///
  /// In en, this message translates to:
  /// **'Cultural Insight'**
  String get culturalInsight;

  /// No description provided for @aiIsAnalyzingCulturalContext.
  ///
  /// In en, this message translates to:
  /// **'AI is analyzing cultural context...'**
  String get aiIsAnalyzingCulturalContext;

  /// No description provided for @diveIntoFullContent.
  ///
  /// In en, this message translates to:
  /// **'Dive into Full Content'**
  String get diveIntoFullContent;

  /// No description provided for @savedArticles.
  ///
  /// In en, this message translates to:
  /// **'Saved Articles'**
  String get savedArticles;

  /// No description provided for @liveOverlay.
  ///
  /// In en, this message translates to:
  /// **'LIVE OVERLAY'**
  String get liveOverlay;

  /// No description provided for @webExplorer.
  ///
  /// In en, this message translates to:
  /// **'WEB EXPLORER'**
  String get webExplorer;

  /// No description provided for @browseAnyChineseWebsiteWithRealtime.
  ///
  /// In en, this message translates to:
  /// **'Browse any Chinese website with real-time tap dictionary, pinyin annotations & instant translations.'**
  String get browseAnyChineseWebsiteWithRealtime;

  /// No description provided for @startExploring.
  ///
  /// In en, this message translates to:
  /// **'START EXPLORING'**
  String get startExploring;

  /// No description provided for @chineseTvSeriesWithInteractiveSubti.
  ///
  /// In en, this message translates to:
  /// **'Chinese TV series with interactive subtitles'**
  String get chineseTvSeriesWithInteractiveSubti;

  /// No description provided for @failedToLoadContent.
  ///
  /// In en, this message translates to:
  /// **'Failed to load content'**
  String get failedToLoadContent;

  /// No description provided for @searchingYoutube.
  ///
  /// In en, this message translates to:
  /// **'Searching YouTube...'**
  String get searchingYoutube;

  /// No description provided for @noVideosFoundTryADifferentSearchTer.
  ///
  /// In en, this message translates to:
  /// **'No videos found. Try a different search term.'**
  String get noVideosFoundTryADifferentSearchTer;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching'**
  String get searching;

  /// No description provided for @noShowsFound.
  ///
  /// In en, this message translates to:
  /// **'No shows found'**
  String get noShowsFound;

  /// No description provided for @bookmarked.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get bookmarked;

  /// No description provided for @trailer1.
  ///
  /// In en, this message translates to:
  /// **'Trailer'**
  String get trailer1;

  /// No description provided for @highlight1.
  ///
  /// In en, this message translates to:
  /// **'Highlight'**
  String get highlight1;

  /// No description provided for @noCaptionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Captions Available'**
  String get noCaptionsAvailable;

  /// No description provided for @fetchingSubtitles.
  ///
  /// In en, this message translates to:
  /// **'Fetching subtitles...'**
  String get fetchingSubtitles;

  /// No description provided for @generatingAiBriefing.
  ///
  /// In en, this message translates to:
  /// **'Generating AI briefing...'**
  String get generatingAiBriefing;

  /// No description provided for @noClosedCaptionsCcFoundForThisVideo.
  ///
  /// In en, this message translates to:
  /// **'No Closed Captions (CC) found for this video.'**
  String get noClosedCaptionsCcFoundForThisVideo;

  /// No description provided for @videosWithHardcodedOrBurnedinSubtit.
  ///
  /// In en, this message translates to:
  /// **'Videos with hardcoded or burned-in subtitles do not have digital text tracks available on YouTube.'**
  String get videosWithHardcodedOrBurnedinSubtit;

  /// No description provided for @translatingSubtitles.
  ///
  /// In en, this message translates to:
  /// **'Translating subtitles...'**
  String get translatingSubtitles;

  /// No description provided for @processingYourPronunciation.
  ///
  /// In en, this message translates to:
  /// **'Processing your pronunciation...'**
  String get processingYourPronunciation;

  /// No description provided for @couldntIdentifyLine.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t identify line.'**
  String get couldntIdentifyLine;

  /// No description provided for @listeningSpeakNow.
  ///
  /// In en, this message translates to:
  /// **'Listening... speak now.'**
  String get listeningSpeakNow;

  /// No description provided for @thisVideoDoesNotHaveADigitalClosedC.
  ///
  /// In en, this message translates to:
  /// **'This video does not have a digital Closed Captions (CC) track on YouTube.'**
  String get thisVideoDoesNotHaveADigitalClosedC;

  /// No description provided for @perfect1.
  ///
  /// In en, this message translates to:
  /// **'Perfect'**
  String get perfect1;

  /// No description provided for @thisVideoHasBeenRemovedOrIsNoLonger.
  ///
  /// In en, this message translates to:
  /// **'This video has been removed or is no longer available.'**
  String get thisVideoHasBeenRemovedOrIsNoLonger;

  /// No description provided for @thisVideoCannotBePlayedInTheAppYouC.
  ///
  /// In en, this message translates to:
  /// **'This video cannot be played in the app. You can still watch it on YouTube.'**
  String get thisVideoCannotBePlayedInTheAppYouC;

  /// No description provided for @yourDeviceCannotPlayThisVideoPlease.
  ///
  /// In en, this message translates to:
  /// **'Your device cannot play this video. Please try a different one.'**
  String get yourDeviceCannotPlayThisVideoPlease;

  /// No description provided for @invalidVideoReferencePleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Invalid video reference. Please try again.'**
  String get invalidVideoReferencePleaseTryAgain;

  /// No description provided for @unableToLoadThisVideoPleaseTryAnoth.
  ///
  /// In en, this message translates to:
  /// **'Unable to load this video. Please try another one.'**
  String get unableToLoadThisVideoPleaseTryAnoth;

  /// No description provided for @startReading.
  ///
  /// In en, this message translates to:
  /// **'Start Reading'**
  String get startReading;

  /// No description provided for @analyzingCulturalContext.
  ///
  /// In en, this message translates to:
  /// **'Analyzing cultural context...'**
  String get analyzingCulturalContext;

  /// No description provided for @failedToLoadCulturalInsight.
  ///
  /// In en, this message translates to:
  /// **'Failed to load cultural insight.'**
  String get failedToLoadCulturalInsight;

  /// No description provided for @historicalContext.
  ///
  /// In en, this message translates to:
  /// **'Historical Context'**
  String get historicalContext;

  /// No description provided for @culturalSignificance.
  ///
  /// In en, this message translates to:
  /// **'Cultural Significance'**
  String get culturalSignificance;

  /// No description provided for @authorBackground.
  ///
  /// In en, this message translates to:
  /// **'Author Background'**
  String get authorBackground;

  /// No description provided for @k80CompleteClassicNovelsWorldEpics.
  ///
  /// In en, this message translates to:
  /// **'80+ Complete classic novels & world epics'**
  String get k80CompleteClassicNovelsWorldEpics;

  /// No description provided for @storyOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'STORY OF THE DAY'**
  String get storyOfTheDay;

  /// No description provided for @tangDynasty.
  ///
  /// In en, this message translates to:
  /// **'Tang Dynasty'**
  String get tangDynasty;

  /// No description provided for @poetryClassicalVerse.
  ///
  /// In en, this message translates to:
  /// **'Poetry\', \'Classical\', \'Verse'**
  String get poetryClassicalVerse;

  /// No description provided for @allHsk.
  ///
  /// In en, this message translates to:
  /// **'All HSK'**
  String get allHsk;

  /// No description provided for @allStories.
  ///
  /// In en, this message translates to:
  /// **'All Stories\' :'**
  String get allStories;

  /// No description provided for @keyWords.
  ///
  /// In en, this message translates to:
  /// **'Key Words'**
  String get keyWords;

  /// No description provided for @openOriginalWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open Original Website'**
  String get openOriginalWebsite;

  /// No description provided for @aiReadingTools.
  ///
  /// In en, this message translates to:
  /// **'AI Reading Tools'**
  String get aiReadingTools;

  /// No description provided for @enhanceYourReadingWithAipoweredTool.
  ///
  /// In en, this message translates to:
  /// **'Enhance your reading with AI-powered tools'**
  String get enhanceYourReadingWithAipoweredTool;

  /// No description provided for @chooseTheTargetDifficultyForSimplif.
  ///
  /// In en, this message translates to:
  /// **'Choose the target difficulty for simplification'**
  String get chooseTheTargetDifficultyForSimplif;

  /// No description provided for @chooseDifficultyForSimplification.
  ///
  /// In en, this message translates to:
  /// **'Choose difficulty for simplification'**
  String get chooseDifficultyForSimplification;

  /// No description provided for @extractAllUnknownWordsToANewFlashca.
  ///
  /// In en, this message translates to:
  /// **'Extract all unknown words to a new flashcard deck'**
  String get extractAllUnknownWordsToANewFlashca;

  /// No description provided for @length.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get length;

  /// No description provided for @m1554846a550010707.
  ///
  /// In en, this message translates to:
  /// **'M15.54 8.46a5 5 0 0 1 0 7.07'**
  String get m1554846a550010707;

  /// No description provided for @m1907493a101000101414.
  ///
  /// In en, this message translates to:
  /// **'M19.07 4.93a10 10 0 0 1 0 14.14'**
  String get m1907493a101000101414;

  /// No description provided for @webExtraction.
  ///
  /// In en, this message translates to:
  /// **'Web Extraction'**
  String get webExtraction;

  /// No description provided for @aiTools.
  ///
  /// In en, this message translates to:
  /// **'AI Tools'**
  String get aiTools;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @keepPracticing1.
  ///
  /// In en, this message translates to:
  /// **'Keep practicing'**
  String get keepPracticing1;

  /// No description provided for @aiPrepRoom.
  ///
  /// In en, this message translates to:
  /// **'AI Prep Room'**
  String get aiPrepRoom;

  /// No description provided for @lessonSummary.
  ///
  /// In en, this message translates to:
  /// **'LESSON SUMMARY'**
  String get lessonSummary;

  /// No description provided for @unlockSinosparkPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock SinoSpark Premium'**
  String get unlockSinosparkPremium;

  /// No description provided for @monthYear.
  ///
  /// In en, this message translates to:
  /// **'Month\' : \'Year'**
  String get monthYear;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @notificationsConfigured.
  ///
  /// In en, this message translates to:
  /// **'Notifications Configured'**
  String get notificationsConfigured;

  /// No description provided for @neverMissAStroke2.
  ///
  /// In en, this message translates to:
  /// **'Never Miss a Stroke'**
  String get neverMissAStroke2;

  /// No description provided for @yourDailyDropAndStreakAlertsArePrim.
  ///
  /// In en, this message translates to:
  /// **'Your daily drop and streak alerts are primed.'**
  String get yourDailyDropAndStreakAlertsArePrim;

  /// No description provided for @stayConsistentWithDailyRitualDropsA.
  ///
  /// In en, this message translates to:
  /// **'Stay consistent with daily ritual drops and timely trial reminders.'**
  String get stayConsistentWithDailyRitualDropsA;

  /// No description provided for @aNewWordAndStoryWaitingForYourDaily.
  ///
  /// In en, this message translates to:
  /// **'A new Word and Story waiting for your daily ritual.'**
  String get aNewWordAndStoryWaitingForYourDaily;

  /// No description provided for @gentlePromptsBeforeCharactersFadeFr.
  ///
  /// In en, this message translates to:
  /// **'Gentle prompts before characters fade from your memory.'**
  String get gentlePromptsBeforeCharactersFadeFr;

  /// No description provided for @receiveAReminder2DaysBeforeYourFree.
  ///
  /// In en, this message translates to:
  /// **'Receive a reminder 2 days before your free trial ends.'**
  String get receiveAReminder2DaysBeforeYourFree;

  /// No description provided for @yourPathTonchineseFluency.
  ///
  /// In en, this message translates to:
  /// **'Your Path to\\nChinese Fluency'**
  String get yourPathTonchineseFluency;

  /// No description provided for @answer3QuickQuestionsSoOurAiCanCraf.
  ///
  /// In en, this message translates to:
  /// **'Answer 3 quick questions so our AI can craft\\na curriculum that fits your life.'**
  String get answer3QuickQuestionsSoOurAiCanCraf;

  /// No description provided for @whatIsYourLevelnwithChinese.
  ///
  /// In en, this message translates to:
  /// **'What is your level\\nwith Chinese?'**
  String get whatIsYourLevelnwithChinese;

  /// No description provided for @chooseThePathThatFitsYourDepth.
  ///
  /// In en, this message translates to:
  /// **'Choose the path that fits your depth.'**
  String get chooseThePathThatFitsYourDepth;

  /// No description provided for @whatDrivesYourStudy.
  ///
  /// In en, this message translates to:
  /// **'What drives your study?'**
  String get whatDrivesYourStudy;

  /// No description provided for @purposeFuelsTheBrush.
  ///
  /// In en, this message translates to:
  /// **'Purpose fuels the brush'**
  String get purposeFuelsTheBrush;

  /// No description provided for @setYourDailyRitual.
  ///
  /// In en, this message translates to:
  /// **'Set your daily ritual.'**
  String get setYourDailyRitual;

  /// No description provided for @youCanAdjustYourRitualAnyTime.
  ///
  /// In en, this message translates to:
  /// **'You can adjust your ritual any time.'**
  String get youCanAdjustYourRitualAnyTime;

  /// No description provided for @letsBegin.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Begin'**
  String get letsBegin;

  /// No description provided for @brandNew.
  ///
  /// In en, this message translates to:
  /// **'Brand New'**
  String get brandNew;

  /// No description provided for @iveNeverStudiedChineseBefore.
  ///
  /// In en, this message translates to:
  /// **'I\'ve never studied Chinese before.'**
  String get iveNeverStudiedChineseBefore;

  /// No description provided for @iKnowBasicCharactersAndPhrases.
  ///
  /// In en, this message translates to:
  /// **'I know basic characters and phrases.'**
  String get iKnowBasicCharactersAndPhrases;

  /// No description provided for @iCanHoldConversationsAndRead.
  ///
  /// In en, this message translates to:
  /// **'I can hold conversations and read.'**
  String get iCanHoldConversationsAndRead;

  /// No description provided for @iWantToRefineAndPerfectMySkills.
  ///
  /// In en, this message translates to:
  /// **'I want to refine and perfect my skills.'**
  String get iWantToRefineAndPerfectMySkills;

  /// No description provided for @confirmSelection.
  ///
  /// In en, this message translates to:
  /// **'Confirm Selection'**
  String get confirmSelection;

  /// No description provided for @purposeFuelsTheBrushsMotion.
  ///
  /// In en, this message translates to:
  /// **'Purpose fuels the brush\'s motion.'**
  String get purposeFuelsTheBrushsMotion;

  /// No description provided for @buildMyPath.
  ///
  /// In en, this message translates to:
  /// **'Build My Path'**
  String get buildMyPath;

  /// No description provided for @hskCertification.
  ///
  /// In en, this message translates to:
  /// **'HSK Certification'**
  String get hskCertification;

  /// No description provided for @culturalAppreciation.
  ///
  /// In en, this message translates to:
  /// **'Cultural Appreciation'**
  String get culturalAppreciation;

  /// No description provided for @yourPlanIsReady.
  ///
  /// In en, this message translates to:
  /// **'Your Plan is Ready'**
  String get yourPlanIsReady;

  /// No description provided for @craftingYourCurriculum.
  ///
  /// In en, this message translates to:
  /// **'Crafting Your Curriculum'**
  String get craftingYourCurriculum;

  /// No description provided for @personalizedPathInitialized.
  ///
  /// In en, this message translates to:
  /// **'PERSONALIZED PATH INITIALIZED'**
  String get personalizedPathInitialized;

  /// No description provided for @calibratingAiNeuralMasters.
  ///
  /// In en, this message translates to:
  /// **'CALIBRATING AI NEURAL MASTERS...'**
  String get calibratingAiNeuralMasters;

  /// No description provided for @calibrationComplete.
  ///
  /// In en, this message translates to:
  /// **'Calibration Complete'**
  String get calibrationComplete;

  /// No description provided for @synthesizingModules.
  ///
  /// In en, this message translates to:
  /// **'Synthesizing Modules...'**
  String get synthesizingModules;

  /// No description provided for @oneAndWater.
  ///
  /// In en, this message translates to:
  /// **'One\' and \'Water'**
  String get oneAndWater;

  /// No description provided for @theHorizontalStroke.
  ///
  /// In en, this message translates to:
  /// **'THE HORIZONTAL STROKE'**
  String get theHorizontalStroke;

  /// No description provided for @theRadical.
  ///
  /// In en, this message translates to:
  /// **'THE RADICAL'**
  String get theRadical;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @river.
  ///
  /// In en, this message translates to:
  /// **'River'**
  String get river;

  /// No description provided for @day5Reminder.
  ///
  /// In en, this message translates to:
  /// **'Day 5 Reminder'**
  String get day5Reminder;

  /// No description provided for @wePromisedToAlertYou2DaysBeforeYour.
  ///
  /// In en, this message translates to:
  /// **'We promised to alert you 2 days before your trial ends so you'**
  String get wePromisedToAlertYou2DaysBeforeYour;

  /// No description provided for @continueWithoutReminder.
  ///
  /// In en, this message translates to:
  /// **'Continue without reminder'**
  String get continueWithoutReminder;

  /// No description provided for @masterChineseWithnsinospark.
  ///
  /// In en, this message translates to:
  /// **'Master Chinese with\\nSinoSpark'**
  String get masterChineseWithnsinospark;

  /// No description provided for @start7dayFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start 7-Day Free Trial'**
  String get start7dayFreeTrial;

  /// No description provided for @precisionStrokes.
  ///
  /// In en, this message translates to:
  /// **'Precision Strokes'**
  String get precisionStrokes;

  /// No description provided for @aiPronunciation.
  ///
  /// In en, this message translates to:
  /// **'AI Pronunciation'**
  String get aiPronunciation;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @fullAccess.
  ///
  /// In en, this message translates to:
  /// **'Full Access'**
  String get fullAccess;

  /// No description provided for @day5.
  ///
  /// In en, this message translates to:
  /// **'Day 5'**
  String get day5;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminder;

  /// No description provided for @day7.
  ///
  /// In en, this message translates to:
  /// **'Day 7'**
  String get day7;

  /// No description provided for @trialBegins.
  ///
  /// In en, this message translates to:
  /// **'Trial Begins'**
  String get trialBegins;

  /// No description provided for @revenuecatIsMissingACurrentOffering.
  ///
  /// In en, this message translates to:
  /// **'RevenueCat is missing a Current Offering or Packages. Please configure your Dashboard.'**
  String get revenuecatIsMissingACurrentOffering;

  /// No description provided for @cameraPermissionRequiredForLiveScan.
  ///
  /// In en, this message translates to:
  /// **'Camera permission required for live scanning.'**
  String get cameraPermissionRequiredForLiveScan;

  /// No description provided for @cameraAccessRequired.
  ///
  /// In en, this message translates to:
  /// **'Camera Access Required'**
  String get cameraAccessRequired;

  /// No description provided for @pleaseEnableCameraAccessInYourDevic.
  ///
  /// In en, this message translates to:
  /// **'Please enable camera access in your device settings to use this feature.'**
  String get pleaseEnableCameraAccessInYourDevic;

  /// No description provided for @alignChineseTextWithinFrame.
  ///
  /// In en, this message translates to:
  /// **'Align Chinese text within frame'**
  String get alignChineseTextWithinFrame;

  /// No description provided for @inLibrary.
  ///
  /// In en, this message translates to:
  /// **'In Library'**
  String get inLibrary;

  /// No description provided for @novice.
  ///
  /// In en, this message translates to:
  /// **'Novice'**
  String get novice;

  /// No description provided for @apprentice.
  ///
  /// In en, this message translates to:
  /// **'Apprentice'**
  String get apprentice;

  /// No description provided for @artisan.
  ///
  /// In en, this message translates to:
  /// **'Artisan'**
  String get artisan;

  /// No description provided for @grandmaster.
  ///
  /// In en, this message translates to:
  /// **'Grandmaster'**
  String get grandmaster;

  /// No description provided for @poem.
  ///
  /// In en, this message translates to:
  /// **'Poem'**
  String get poem;

  /// No description provided for @theNarrative.
  ///
  /// In en, this message translates to:
  /// **'The Narrative'**
  String get theNarrative;

  /// No description provided for @classicMasterpiece.
  ///
  /// In en, this message translates to:
  /// **'Classic Masterpiece'**
  String get classicMasterpiece;

  /// No description provided for @classicAuthor.
  ///
  /// In en, this message translates to:
  /// **'Classic Author'**
  String get classicAuthor;

  /// No description provided for @classical.
  ///
  /// In en, this message translates to:
  /// **'Classical'**
  String get classical;

  /// No description provided for @classicLiterature.
  ///
  /// In en, this message translates to:
  /// **'Classic\', \'Literature'**
  String get classicLiterature;

  /// No description provided for @inThisChapterOf.
  ///
  /// In en, this message translates to:
  /// **'In this chapter of'**
  String inThisChapterOf(Object title);

  /// No description provided for @asTheNarrativeUnfoldsItIlluminatesT.
  ///
  /// In en, this message translates to:
  /// **'As the narrative unfolds, it illuminates the fundamental wisdom of life and lasting inspiration.'**
  String get asTheNarrativeUnfoldsItIlluminatesT;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @mythology.
  ///
  /// In en, this message translates to:
  /// **'Mythology'**
  String get mythology;

  /// No description provided for @dailyLife.
  ///
  /// In en, this message translates to:
  /// **'Daily Life'**
  String get dailyLife;

  /// No description provided for @tangPoetry.
  ///
  /// In en, this message translates to:
  /// **'Tang Poetry'**
  String get tangPoetry;

  /// No description provided for @classicalLiterature.
  ///
  /// In en, this message translates to:
  /// **'Classical Literature'**
  String get classicalLiterature;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @theTerracottaArmyOfQinShiHuang.
  ///
  /// In en, this message translates to:
  /// **'The Terracotta Army of Qin Shi Huang'**
  String get theTerracottaArmyOfQinShiHuang;

  /// No description provided for @lifeInsideTheForbiddenCity.
  ///
  /// In en, this message translates to:
  /// **'Life inside the Forbidden City'**
  String get lifeInsideTheForbiddenCity;

  /// No description provided for @buyingATicketAndTakingTheHighSpeedT.
  ///
  /// In en, this message translates to:
  /// **'Buying a ticket and taking the high speed train in China'**
  String get buyingATicketAndTakingTheHighSpeedT;

  /// No description provided for @goingToTheHospitalForAColdAndSeeing.
  ///
  /// In en, this message translates to:
  /// **'Going to the hospital for a cold and seeing a doctor'**
  String get goingToTheHospitalForAColdAndSeeing;

  /// No description provided for @goingToALocalRestaurantToOrderJiaoz.
  ///
  /// In en, this message translates to:
  /// **'Going to a local restaurant to order Jiaozi (dumplings)'**
  String get goingToALocalRestaurantToOrderJiaoz;

  /// No description provided for @theTraditionalGongfuTeaCeremony.
  ///
  /// In en, this message translates to:
  /// **'The traditional Gongfu tea ceremony'**
  String get theTraditionalGongfuTeaCeremony;

  /// No description provided for @theArtOfWritingChineseCharactersWit.
  ///
  /// In en, this message translates to:
  /// **'The art of writing Chinese characters with a brush'**
  String get theArtOfWritingChineseCharactersWit;

  /// No description provided for @theLifeAndConservationOfGiantPandas.
  ///
  /// In en, this message translates to:
  /// **'The life and conservation of Giant Pandas'**
  String get theLifeAndConservationOfGiantPandas;

  /// No description provided for @storyNotFoundInDatabase.
  ///
  /// In en, this message translates to:
  /// **'Story not found in database'**
  String get storyNotFoundInDatabase;

  /// No description provided for @storyTextIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Story text is empty'**
  String get storyTextIsEmpty;

  /// No description provided for @myCustomStories.
  ///
  /// In en, this message translates to:
  /// **'My Custom Stories'**
  String get myCustomStories;

  /// No description provided for @userProvidedText.
  ///
  /// In en, this message translates to:
  /// **'User provided text'**
  String get userProvidedText;

  /// No description provided for @local.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get local;

  /// No description provided for @voiceEngineAllowance.
  ///
  /// In en, this message translates to:
  /// **'Voice Engine & Allowance'**
  String get voiceEngineAllowance;

  /// No description provided for @studioHdVsUnlimitedStandardVoice.
  ///
  /// In en, this message translates to:
  /// **'Studio HD vs. Unlimited Standard Voice'**
  String get studioHdVsUnlimitedStandardVoice;

  /// No description provided for @standardVoiceIs100UnlimitedFree.
  ///
  /// In en, this message translates to:
  /// **'Standard Voice is 100% Unlimited & Free'**
  String get standardVoiceIs100UnlimitedFree;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @koreKoreFemaleWarm.
  ///
  /// In en, this message translates to:
  /// **'Kore\', \'Kore\', \'Female, warm'**
  String get koreKoreFemaleWarm;

  /// No description provided for @aoedeAoedeFemaleCheerful.
  ///
  /// In en, this message translates to:
  /// **'Aoede\', \'Aoede\', \'Female, cheerful'**
  String get aoedeAoedeFemaleCheerful;

  /// No description provided for @fenrirFenrirMaleUpbeat.
  ///
  /// In en, this message translates to:
  /// **'Fenrir\', \'Fenrir\', \'Male, upbeat'**
  String get fenrirFenrirMaleUpbeat;

  /// No description provided for @charonCharonMaleNewsstyle.
  ///
  /// In en, this message translates to:
  /// **'Charon\', \'Charon\', \'Male, news-style'**
  String get charonCharonMaleNewsstyle;

  /// No description provided for @puckPuckMaleSporty.
  ///
  /// In en, this message translates to:
  /// **'Puck\', \'Puck\', \'Male, sporty'**
  String get puckPuckMaleSporty;

  /// No description provided for @localOndevice.
  ///
  /// In en, this message translates to:
  /// **'Local\', \'On-device'**
  String get localOndevice;

  /// No description provided for @localOndeviceTts.
  ///
  /// In en, this message translates to:
  /// **'Local on-device TTS'**
  String get localOndeviceTts;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @endOfCurrentChapter.
  ///
  /// In en, this message translates to:
  /// **'End of Current Chapter'**
  String get endOfCurrentChapter;

  /// No description provided for @standardVoice.
  ///
  /// In en, this message translates to:
  /// **'Standard Voice'**
  String get standardVoice;

  /// No description provided for @noNovelsFoundMatchingYourFilter.
  ///
  /// In en, this message translates to:
  /// **'No novels found matching your filter.'**
  String get noNovelsFoundMatchingYourFilter;

  /// No description provided for @noMicroreadsFoundMatchingYourFilter.
  ///
  /// In en, this message translates to:
  /// **'No micro-reads found matching your filter.'**
  String get noMicroreadsFoundMatchingYourFilter;

  /// No description provided for @noPoemsFoundMatchingYourFilter.
  ///
  /// In en, this message translates to:
  /// **'No poems found matching your filter.'**
  String get noPoemsFoundMatchingYourFilter;

  /// No description provided for @audiobook.
  ///
  /// In en, this message translates to:
  /// **'Audiobook'**
  String get audiobook;

  /// No description provided for @audio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get continueReading;

  /// No description provided for @search96FullNovelsAuthorsEpics.
  ///
  /// In en, this message translates to:
  /// **'Search 96 full novels, authors, epics...'**
  String get search96FullNovelsAuthorsEpics;

  /// No description provided for @searchClassicalPoemsAuthorsVerses.
  ///
  /// In en, this message translates to:
  /// **'Search classical poems, authors, verses...'**
  String get searchClassicalPoemsAuthorsVerses;

  /// No description provided for @allLevelsVal.
  ///
  /// In en, this message translates to:
  /// **'All Levels'**
  String get allLevelsVal;

  /// No description provided for @hsk1BeginnerVal.
  ///
  /// In en, this message translates to:
  /// **'HSK 1 (Beginner)'**
  String get hsk1BeginnerVal;

  /// No description provided for @hsk2ElementaryVal.
  ///
  /// In en, this message translates to:
  /// **'HSK 2 (Elementary)'**
  String get hsk2ElementaryVal;

  /// No description provided for @hsk3IntermediateVal.
  ///
  /// In en, this message translates to:
  /// **'HSK 3 (Intermediate)'**
  String get hsk3IntermediateVal;

  /// No description provided for @hsk4UpperIntVal.
  ///
  /// In en, this message translates to:
  /// **'HSK 4 (Upper Int)'**
  String get hsk4UpperIntVal;

  /// No description provided for @listenToAudiobook.
  ///
  /// In en, this message translates to:
  /// **'Listen to Audiobook'**
  String get listenToAudiobook;

  /// No description provided for @synopsis.
  ///
  /// In en, this message translates to:
  /// **'Synopsis'**
  String get synopsis;

  /// No description provided for @peoplesArtist.
  ///
  /// In en, this message translates to:
  /// **'People\'s Artist\'.'**
  String get peoplesArtist;

  /// No description provided for @kafkaesqueForBureaucraticAbsurdityA.
  ///
  /// In en, this message translates to:
  /// **'Kafkaesque\' for bureaucratic absurdity, alienation, and existential dread.'**
  String get kafkaesqueForBureaucraticAbsurdityA;

  /// No description provided for @bigBrotherAndNewspeak.
  ///
  /// In en, this message translates to:
  /// **'Big Brother\', and \'Newspeak\'.'**
  String get bigBrotherAndNewspeak;

  /// No description provided for @audiobookIncluded.
  ///
  /// In en, this message translates to:
  /// **'Audiobook Included'**
  String get audiobookIncluded;

  /// No description provided for @readPoem.
  ///
  /// In en, this message translates to:
  /// **'Read Poem'**
  String get readPoem;

  /// No description provided for @studioVoiceAllowance.
  ///
  /// In en, this message translates to:
  /// **'Studio Voice Allowance'**
  String get studioVoiceAllowance;

  /// No description provided for @weeklyHighdefinitionAiRecitation.
  ///
  /// In en, this message translates to:
  /// **'Weekly High-Definition AI Recitation'**
  String get weeklyHighdefinitionAiRecitation;

  /// No description provided for @resetsEveryMondayAt0000.
  ///
  /// In en, this message translates to:
  /// **'Resets every Monday at 00:00'**
  String get resetsEveryMondayAt0000;

  /// No description provided for @whenYourWeekly4hourStudioAllowanceI.
  ///
  /// In en, this message translates to:
  /// **'When your weekly 4-hour Studio allowance is used, the app automatically switches to On-Device Voice for unlimited, free listening without interruption.'**
  String get whenYourWeekly4hourStudioAllowanceI;

  /// No description provided for @localDeviceVoice.
  ///
  /// In en, this message translates to:
  /// **'Local device voice\' :'**
  String get localDeviceVoice;

  /// No description provided for @classicalVerse.
  ///
  /// In en, this message translates to:
  /// **'Classical Verse'**
  String get classicalVerse;

  /// No description provided for @ondeviceVoice4hWeeklyUsed.
  ///
  /// In en, this message translates to:
  /// **'On-Device Voice (4h weekly used)'**
  String get ondeviceVoice4hWeeklyUsed;

  /// No description provided for @generateACustomAiStoryBasedOnYourIn.
  ///
  /// In en, this message translates to:
  /// **'Generate a custom AI story based on your interests'**
  String get generateACustomAiStoryBasedOnYourIn;

  /// No description provided for @insteadOfAFixedHskLevelTheFlowState.
  ///
  /// In en, this message translates to:
  /// **'Instead of a fixed HSK level, the Flow State Engine analyzes your Flashcard Library.\\n\\n'**
  String get insteadOfAFixedHskLevelTheFlowState;

  /// No description provided for @we.
  ///
  /// In en, this message translates to:
  /// **'We'**
  String get we;

  /// No description provided for @howCanWeHelpYou.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get howCanWeHelpYou;

  /// No description provided for @everythingYouNeedToKnowAboutHanziMa.
  ///
  /// In en, this message translates to:
  /// **'Everything you need to know about Hanzi Master, its features, and your privacy.'**
  String get everythingYouNeedToKnowAboutHanziMa;

  /// No description provided for @whoAreTheVoicesSpeakingInTheApp.
  ///
  /// In en, this message translates to:
  /// **'Who are the voices speaking in the app?'**
  String get whoAreTheVoicesSpeakingInTheApp;

  /// No description provided for @howDoesTheWebExplorerWork.
  ///
  /// In en, this message translates to:
  /// **'How does the Web Explorer work?'**
  String get howDoesTheWebExplorerWork;

  /// No description provided for @whatIsZenMode.
  ///
  /// In en, this message translates to:
  /// **'What is Zen Mode?'**
  String get whatIsZenMode;

  /// No description provided for @howDoesTheFlashcardSpacedrepetition.
  ///
  /// In en, this message translates to:
  /// **'How does the Flashcard spaced-repetition work?'**
  String get howDoesTheFlashcardSpacedrepetition;

  /// No description provided for @traceComplete.
  ///
  /// In en, this message translates to:
  /// **'Trace Complete!'**
  String get traceComplete;

  /// No description provided for @traceCharacter.
  ///
  /// In en, this message translates to:
  /// **'Trace Character'**
  String get traceCharacter;

  /// No description provided for @analyzingWordRelationships.
  ///
  /// In en, this message translates to:
  /// **'Analyzing word relationships...'**
  String get analyzingWordRelationships;

  /// No description provided for @identifyingUsageContexts.
  ///
  /// In en, this message translates to:
  /// **'Identifying usage contexts...'**
  String get identifyingUsageContexts;

  /// No description provided for @comparingFormalityLevels.
  ///
  /// In en, this message translates to:
  /// **'Comparing formality levels...'**
  String get comparingFormalityLevels;

  /// No description provided for @findingCommonCollocations.
  ///
  /// In en, this message translates to:
  /// **'Finding common collocations...'**
  String get findingCommonCollocations;

  /// No description provided for @generatingComparison.
  ///
  /// In en, this message translates to:
  /// **'Generating comparison...'**
  String get generatingComparison;

  /// No description provided for @generationIsTakingLongerThanExpecte.
  ///
  /// In en, this message translates to:
  /// **'Generation is taking longer than expected. The AI may be overloaded.'**
  String get generationIsTakingLongerThanExpecte;

  /// No description provided for @generationInterruptedShowingPartial.
  ///
  /// In en, this message translates to:
  /// **'Generation interrupted. Showing partial result.'**
  String get generationInterruptedShowingPartial;

  /// No description provided for @sorrySomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Sorry, something went wrong.'**
  String get sorrySomethingWentWrong;

  /// No description provided for @usage.
  ///
  /// In en, this message translates to:
  /// **'Usage:\', \''**
  String get usage;

  /// No description provided for @alsoSeenIn.
  ///
  /// In en, this message translates to:
  /// **'Also seen in'**
  String get alsoSeenIn;

  /// No description provided for @quickLook.
  ///
  /// In en, this message translates to:
  /// **'Quick Look'**
  String get quickLook;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFound;

  /// No description provided for @errorLoadingFromAi.
  ///
  /// In en, this message translates to:
  /// **'Error loading from AI.'**
  String get errorLoadingFromAi;

  /// No description provided for @analyzingImage.
  ///
  /// In en, this message translates to:
  /// **'Analyzing image...'**
  String get analyzingImage;

  /// No description provided for @extractingChineseText.
  ///
  /// In en, this message translates to:
  /// **'Extracting Chinese text...'**
  String get extractingChineseText;

  /// No description provided for @lookingUpVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Looking up vocabulary...'**
  String get lookingUpVocabulary;

  /// No description provided for @dreamOfTheRedChamber.
  ///
  /// In en, this message translates to:
  /// **'Dream of the Red Chamber'**
  String get dreamOfTheRedChamber;

  /// No description provided for @journeyToTheWest.
  ///
  /// In en, this message translates to:
  /// **'Journey to the West'**
  String get journeyToTheWest;

  /// No description provided for @romanceOfTheThreeKingdoms.
  ///
  /// In en, this message translates to:
  /// **'Romance of the Three Kingdoms'**
  String get romanceOfTheThreeKingdoms;

  /// No description provided for @mingDynasty.
  ///
  /// In en, this message translates to:
  /// **'Ming Dynasty'**
  String get mingDynasty;

  /// No description provided for @wuChengEn.
  ///
  /// In en, this message translates to:
  /// **'Wu Cheng\'en'**
  String get wuChengEn;

  /// No description provided for @hundredChapters.
  ///
  /// In en, this message translates to:
  /// **'100 Chapters'**
  String get hundredChapters;

  /// No description provided for @volume1.
  ///
  /// In en, this message translates to:
  /// **'Volume 1'**
  String get volume1;

  /// No description provided for @bookmarksCount.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks ({count})'**
  String bookmarksCount(Object count);

  /// No description provided for @noBookmarksYet.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet. Tap the bookmark icon to save a passage.'**
  String get noBookmarksYet;

  /// No description provided for @sinosparkIsNotResponding.
  ///
  /// In en, this message translates to:
  /// **'SinoSpark isn\'t responding'**
  String get sinosparkIsNotResponding;

  /// No description provided for @closeApp.
  ///
  /// In en, this message translates to:
  /// **'Close app'**
  String get closeApp;

  /// No description provided for @wait.
  ///
  /// In en, this message translates to:
  /// **'Wait'**
  String get wait;

  /// No description provided for @studioHdAllowance.
  ///
  /// In en, this message translates to:
  /// **'Studio HD: {hours}h'**
  String studioHdAllowance(Object hours);

  /// No description provided for @bookPercentRead.
  ///
  /// In en, this message translates to:
  /// **'Book {percent}%'**
  String bookPercentRead(Object percent);

  /// No description provided for @chAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'Ch. {number}'**
  String chAbbreviation(Object number);

  /// No description provided for @booksAndAudiobooks.
  ///
  /// In en, this message translates to:
  /// **'{count} Books & Audiobooks'**
  String booksAndAudiobooks(Object count);

  /// No description provided for @sentenceXOfY.
  ///
  /// In en, this message translates to:
  /// **'Sentence {current} of {total}'**
  String sentenceXOfY(Object current, Object total);

  /// No description provided for @chapterXOfY.
  ///
  /// In en, this message translates to:
  /// **'Chapter {current} of {total}'**
  String chapterXOfY(Object current, Object total);

  /// No description provided for @allLevels.
  ///
  /// In en, this message translates to:
  /// **'All Levels'**
  String get allLevels;

  /// No description provided for @searchGradedMicroStories.
  ///
  /// In en, this message translates to:
  /// **'Search graded micro-stories & fables...'**
  String get searchGradedMicroStories;

  /// No description provided for @gradedStoriesAndMicroReads.
  ///
  /// In en, this message translates to:
  /// **'{count} Graded Stories & Daily Micro-Reads'**
  String gradedStoriesAndMicroReads(Object count);

  /// No description provided for @searchClassicalPoems.
  ///
  /// In en, this message translates to:
  /// **'Search classical poems, authors, verses...'**
  String get searchClassicalPoems;

  /// No description provided for @classicalPoemsAndVerse.
  ///
  /// In en, this message translates to:
  /// **'{count} Classical Poems & Verse'**
  String classicalPoemsAndVerse(Object count);

  /// No description provided for @browseAnyChineseWebsite.
  ///
  /// In en, this message translates to:
  /// **'Browse any Chinese website with real-time tap dictionary, pinyin annotations & instant translations.'**
  String get browseAnyChineseWebsite;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get completed;

  /// No description provided for @aiIsReading.
  ///
  /// In en, this message translates to:
  /// **'AI is reading...'**
  String get aiIsReading;

  /// No description provided for @bbcVerify.
  ///
  /// In en, this message translates to:
  /// **'BBC VERIFY'**
  String get bbcVerify;

  /// No description provided for @hsk5AdvancedVal.
  ///
  /// In en, this message translates to:
  /// **'HSK 5 (Advanced)'**
  String get hsk5AdvancedVal;

  /// No description provided for @hsk1Beginner.
  ///
  /// In en, this message translates to:
  /// **'HSK 1 (Beginner)'**
  String get hsk1Beginner;

  /// No description provided for @hsk4UpperInt.
  ///
  /// In en, this message translates to:
  /// **'HSK 4 (Upper Int)'**
  String get hsk4UpperInt;

  /// No description provided for @extractAllUnknownWords.
  ///
  /// In en, this message translates to:
  /// **'Extract all unknown words to a new flashcard deck'**
  String get extractAllUnknownWords;

  /// No description provided for @designCustomAiRoleplay.
  ///
  /// In en, this message translates to:
  /// **'Design custom AI roleplay & conversation'**
  String get designCustomAiRoleplay;

  /// No description provided for @practiceFlashcardVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Practice flashcard vocabulary in a live dialogue'**
  String get practiceFlashcardVocabulary;

  /// No description provided for @surpriseMe.
  ///
  /// In en, this message translates to:
  /// **'Surprise Me'**
  String get surpriseMe;

  /// No description provided for @rollCharacter.
  ///
  /// In en, this message translates to:
  /// **'Roll Character'**
  String get rollCharacter;

  /// No description provided for @historicalCostume.
  ///
  /// In en, this message translates to:
  /// **'Historical / Costume'**
  String get historicalCostume;

  /// No description provided for @modernYouth.
  ///
  /// In en, this message translates to:
  /// **'Modern & Youth'**
  String get modernYouth;

  /// No description provided for @fantasyMythology.
  ///
  /// In en, this message translates to:
  /// **'Fantasy & Mythology'**
  String get fantasyMythology;

  /// No description provided for @familyDrama.
  ///
  /// In en, this message translates to:
  /// **'Family & Drama'**
  String get familyDrama;

  /// No description provided for @fullVersion.
  ///
  /// In en, this message translates to:
  /// **'Full Version'**
  String get fullVersion;

  /// No description provided for @episodesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} episodes'**
  String episodesCount(Object count);

  /// No description provided for @episodeLabel.
  ///
  /// In en, this message translates to:
  /// **'EP{number}'**
  String episodeLabel(Object number);

  /// No description provided for @translating.
  ///
  /// In en, this message translates to:
  /// **'[ Translating... ]'**
  String get translating;

  /// No description provided for @engSub.
  ///
  /// In en, this message translates to:
  /// **'[ENG SUB]'**
  String get engSub;

  /// No description provided for @standardVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Standard Vocabulary'**
  String get standardVocabulary;

  /// No description provided for @characters.
  ///
  /// In en, this message translates to:
  /// **'characters'**
  String get characters;

  /// No description provided for @todayDashboard.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayDashboard;

  /// No description provided for @studyToday.
  ///
  /// In en, this message translates to:
  /// **'Study today\'s cards'**
  String get studyToday;

  /// No description provided for @studyAhead.
  ///
  /// In en, this message translates to:
  /// **'Study ahead'**
  String get studyAhead;

  /// No description provided for @studyAheadDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice the nearest scheduled reviews without using today\'s quota. No new cards are introduced.'**
  String get studyAheadDescription;

  /// No description provided for @studyAheadComplete.
  ///
  /// In en, this message translates to:
  /// **'Study-ahead practice complete'**
  String get studyAheadComplete;

  /// No description provided for @dueNow.
  ///
  /// In en, this message translates to:
  /// **'Due now'**
  String get dueNow;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @sevenDayForecast.
  ///
  /// In en, this message translates to:
  /// **'7-day review forecast'**
  String get sevenDayForecast;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @newCardsLabel.
  ///
  /// In en, this message translates to:
  /// **'New cards'**
  String get newCardsLabel;

  /// No description provided for @attempts.
  ///
  /// In en, this message translates to:
  /// **'Attempts'**
  String get attempts;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get duration;

  /// No description provided for @answerBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Answer breakdown'**
  String get answerBreakdown;

  /// No description provided for @reviewCards.
  ///
  /// In en, this message translates to:
  /// **'Review cards'**
  String get reviewCards;

  /// No description provided for @retries.
  ///
  /// In en, this message translates to:
  /// **'Retries'**
  String get retries;

  /// No description provided for @needsPractice.
  ///
  /// In en, this message translates to:
  /// **'Needs practice'**
  String get needsPractice;

  /// No description provided for @uniqueCardsStudied.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get uniqueCardsStudied;

  /// No description provided for @dartConvert.
  ///
  /// In en, this message translates to:
  /// **'dart:convert'**
  String get dartConvert;

  /// No description provided for @env.
  ///
  /// In en, this message translates to:
  /// **'.env'**
  String get env;

  /// No description provided for @dartUi.
  ///
  /// In en, this message translates to:
  /// **'dart:ui'**
  String get dartUi;

  /// No description provided for @dartMath.
  ///
  /// In en, this message translates to:
  /// **'dart:math'**
  String get dartMath;

  /// No description provided for @drawInTheOtherDirection.
  ///
  /// In en, this message translates to:
  /// **'Draw in the other direction ➔'**
  String get drawInTheOtherDirection;

  /// No description provided for @fastClean.
  ///
  /// In en, this message translates to:
  /// **'Fast & Clean!'**
  String get fastClean;

  /// No description provided for @good2.
  ///
  /// In en, this message translates to:
  /// **'Good!'**
  String get good2;

  /// No description provided for @followTheFlow.
  ///
  /// In en, this message translates to:
  /// **'Follow the flow.'**
  String get followTheFlow;

  /// No description provided for @masterful.
  ///
  /// In en, this message translates to:
  /// **'Masterful!'**
  String get masterful;

  /// No description provided for @missingTheHookEnd.
  ///
  /// In en, this message translates to:
  /// **'Missing the hook/end.'**
  String get missingTheHookEnd;

  /// No description provided for @thai.
  ///
  /// In en, this message translates to:
  /// **'Thai'**
  String get thai;

  /// No description provided for @dartIo.
  ///
  /// In en, this message translates to:
  /// **'dart:io'**
  String get dartIo;

  /// No description provided for @dartAsync.
  ///
  /// In en, this message translates to:
  /// **'dart:async'**
  String get dartAsync;

  /// No description provided for @asset.
  ///
  /// In en, this message translates to:
  /// **'asset:'**
  String get asset;

  /// No description provided for @ocpApimSubscriptionKey.
  ///
  /// In en, this message translates to:
  /// **'Ocp-Apim-Subscription-Key'**
  String get ocpApimSubscriptionKey;

  /// No description provided for @xMicrosoftOutputFormat.
  ///
  /// In en, this message translates to:
  /// **'X-Microsoft-OutputFormat'**
  String get xMicrosoftOutputFormat;

  /// No description provided for @audio24khz48kbitrateMonoMp3.
  ///
  /// In en, this message translates to:
  /// **'audio-24khz-48kbitrate-mono-mp3'**
  String get audio24khz48kbitrateMonoMp3;

  /// No description provided for @googleGemini25Flash.
  ///
  /// In en, this message translates to:
  /// **'google/gemini-2.5-flash'**
  String get googleGemini25Flash;

  /// No description provided for @ink.
  ///
  /// In en, this message translates to:
  /// **'ink,'**
  String get ink;

  /// No description provided for @stroke.
  ///
  /// In en, this message translates to:
  /// **'stroke,'**
  String get stroke;

  /// No description provided for @breath.
  ///
  /// In en, this message translates to:
  /// **'breath.'**
  String get breath;

  /// No description provided for @deepseekDeepseekChat.
  ///
  /// In en, this message translates to:
  /// **'deepseek/deepseek-chat'**
  String get deepseekDeepseekChat;

  /// No description provided for @hTTPReferer.
  ///
  /// In en, this message translates to:
  /// **'HTTP-Referer'**
  String get hTTPReferer;

  /// No description provided for @xTitle.
  ///
  /// In en, this message translates to:
  /// **'X-Title'**
  String get xTitle;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'data:'**
  String get data;

  /// No description provided for @shadowingModeCustomSentence.
  ///
  /// In en, this message translates to:
  /// **'ShadowingMode.customSentence'**
  String get shadowingModeCustomSentence;

  /// No description provided for @theExactSentenceProvided.
  ///
  /// In en, this message translates to:
  /// **'the exact sentence provided'**
  String get theExactSentenceProvided;

  /// No description provided for @pinyinWithToneMarks2.
  ///
  /// In en, this message translates to:
  /// **'pinyin with tone marks'**
  String get pinyinWithToneMarks2;

  /// No description provided for @wXHuNH.
  ///
  /// In en, this message translates to:
  /// **'Wǒ xǐhuān hē píngguǒzhī.'**
  String get wXHuNH;

  /// No description provided for @extractAllChineseCharactersFrom.
  ///
  /// In en, this message translates to:
  /// **'Extract all Chinese characters from this image. Return ONLY the extracted text — no commentary, no formatting, no translations. Preserve line breaks. If there are no Chinese characters, return an empty string.'**
  String get extractAllChineseCharactersFrom;

  /// No description provided for @householdObject.
  ///
  /// In en, this message translates to:
  /// **'household object'**
  String get householdObject;

  /// No description provided for @genericLabelFromTheList.
  ///
  /// In en, this message translates to:
  /// **'generic label from the list'**
  String get genericLabelFromTheList;

  /// No description provided for @gNgS.
  ///
  /// In en, this message translates to:
  /// **'gōng sī'**
  String get gNgS;

  /// No description provided for @measureWord.
  ///
  /// In en, this message translates to:
  /// **'measure word'**
  String get measureWord;

  /// No description provided for @zenInk.
  ///
  /// In en, this message translates to:
  /// **'Zen & Ink'**
  String get zenInk;

  /// No description provided for @cRITICALPutTheEnglishTranslation.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL: Put the English translation in the \"english\" JSON key!'**
  String get cRITICALPutTheEnglishTranslation;

  /// No description provided for @definitionInEnglish.
  ///
  /// In en, this message translates to:
  /// **'definition in English'**
  String get definitionInEnglish;

  /// No description provided for @simplifiedLine0.
  ///
  /// In en, this message translates to:
  /// **'simplified line 0'**
  String get simplifiedLine0;

  /// No description provided for @simplifiedLine1.
  ///
  /// In en, this message translates to:
  /// **'simplified line 1'**
  String get simplifiedLine1;

  /// No description provided for @iMPORTANTRULEDoNotAddress.
  ///
  /// In en, this message translates to:
  /// **'IMPORTANT RULE: Do not address the user by any name. Never use placeholder names like \"John\". Speak directly to them without using a name.'**
  String get iMPORTANTRULEDoNotAddress;

  /// No description provided for @rULESAnswerIn23.
  ///
  /// In en, this message translates to:
  /// **'RULES: Answer in 2–3 sentences max. Prefer bullet points for lists.'**
  String get rULESAnswerIn23;

  /// No description provided for @neverWriteIntroductionsSignOffs.
  ///
  /// In en, this message translates to:
  /// **'Never write introductions, sign-offs, or filler phrases like \"Great question!\" or \"Certainly!\".'**
  String get neverWriteIntroductionsSignOffs;

  /// No description provided for @useBoldForChineseCharacters.
  ///
  /// In en, this message translates to:
  /// **'Use **bold** for Chinese characters and key terms.'**
  String get useBoldForChineseCharacters;

  /// No description provided for @rULESAnswerIn232.
  ///
  /// In en, this message translates to:
  /// **'RULES: Answer in 2–3 sentences max.'**
  String get rULESAnswerIn232;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @pronunciationAssessment.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation-Assessment'**
  String get pronunciationAssessment;

  /// No description provided for @nBest.
  ///
  /// In en, this message translates to:
  /// **'NBest'**
  String get nBest;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @theCorrectedChineseText.
  ///
  /// In en, this message translates to:
  /// **'the corrected Chinese text'**
  String get theCorrectedChineseText;

  /// No description provided for @thePinyinForTheCorrected.
  ///
  /// In en, this message translates to:
  /// **'the pinyin for the corrected text'**
  String get thePinyinForTheCorrected;

  /// No description provided for @theEnglishMeaningOfThe.
  ///
  /// In en, this message translates to:
  /// **'the english meaning of the corrected text'**
  String get theEnglishMeaningOfThe;

  /// No description provided for @pNyNWithTone.
  ///
  /// In en, this message translates to:
  /// **'pīnyīn with tone marks'**
  String get pNyNWithTone;

  /// No description provided for @englishTranslation2.
  ///
  /// In en, this message translates to:
  /// **'english translation'**
  String get englishTranslation2;

  /// No description provided for @zhNggu.
  ///
  /// In en, this message translates to:
  /// **'Zhōngguó'**
  String get zhNggu;

  /// No description provided for @youAreAChineseClassical.
  ///
  /// In en, this message translates to:
  /// **'You are a Chinese classical literature expert providing detailed accessible summaries of classical Chinese poetry.'**
  String get youAreAChineseClassical;

  /// No description provided for @youAreAChineseCulture.
  ///
  /// In en, this message translates to:
  /// **'You are a Chinese culture and literature expert. Provide highly engaging, beautifully written cultural insights.'**
  String get youAreAChineseCulture;

  /// No description provided for @english2.
  ///
  /// In en, this message translates to:
  /// **'English:'**
  String get english2;

  /// No description provided for @remindersWhenYouHavenT.
  ///
  /// In en, this message translates to:
  /// **'Reminders when you haven\'t used the app for a few days'**
  String get remindersWhenYouHavenT;

  /// No description provided for @itSBeenAFew.
  ///
  /// In en, this message translates to:
  /// **'It\'s been a few days! Take 5 minutes to learn a new Hanzi today.'**
  String get itSBeenAFew;

  /// No description provided for @abbreviationFor.
  ///
  /// In en, this message translates to:
  /// **'abbreviation for'**
  String get abbreviationFor;

  /// No description provided for @cL.
  ///
  /// In en, this message translates to:
  /// **'CL:'**
  String get cL;

  /// No description provided for @measureWord2.
  ///
  /// In en, this message translates to:
  /// **'Measure word:'**
  String get measureWord2;

  /// No description provided for @lu.
  ///
  /// In en, this message translates to:
  /// **'lu:'**
  String get lu;

  /// No description provided for @luE.
  ///
  /// In en, this message translates to:
  /// **'lu:e'**
  String get luE;

  /// No description provided for @nu.
  ///
  /// In en, this message translates to:
  /// **'nu:'**
  String get nu;

  /// No description provided for @nuE.
  ///
  /// In en, this message translates to:
  /// **'nu:e'**
  String get nuE;

  /// No description provided for @noUser.
  ///
  /// In en, this message translates to:
  /// **'no-user'**
  String get noUser;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'password-required'**
  String get passwordRequired;

  /// No description provided for @unsupportedProvider.
  ///
  /// In en, this message translates to:
  /// **'unsupported-provider'**
  String get unsupportedProvider;

  /// No description provided for @appleRevocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'apple-revocation-unavailable'**
  String get appleRevocationUnavailable;

  /// No description provided for @appleCredentialMissing.
  ///
  /// In en, this message translates to:
  /// **'apple-credential-missing'**
  String get appleCredentialMissing;

  /// No description provided for @authenticationDidNotReturnA.
  ///
  /// In en, this message translates to:
  /// **'Authentication did not return a user.'**
  String get authenticationDidNotReturnA;

  /// No description provided for @viewSubscriptionPlans.
  ///
  /// In en, this message translates to:
  /// **'View subscription plans'**
  String get viewSubscriptionPlans;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'wrong-password'**
  String get wrongPassword;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'invalid-credential'**
  String get invalidCredential;

  /// No description provided for @networkRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'network-request-failed'**
  String get networkRequestFailed;

  /// No description provided for @requiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'requires-recent-login'**
  String get requiresRecentLogin;

  /// No description provided for @userMismatch.
  ///
  /// In en, this message translates to:
  /// **'user-mismatch'**
  String get userMismatch;

  /// No description provided for @deleteAccountPassword.
  ///
  /// In en, this message translates to:
  /// **'delete-account-password'**
  String get deleteAccountPassword;

  /// No description provided for @deleteAccountError.
  ///
  /// In en, this message translates to:
  /// **'delete-account-error'**
  String get deleteAccountError;

  /// No description provided for @deleteAccountSubmit.
  ///
  /// In en, this message translates to:
  /// **'delete-account-submit'**
  String get deleteAccountSubmit;

  /// No description provided for @theSimplestShapesTheBeginning.
  ///
  /// In en, this message translates to:
  /// **'The simplest shapes. The beginning of all things.'**
  String get theSimplestShapesTheBeginning;

  /// No description provided for @sunMoonWaterAndFire.
  ///
  /// In en, this message translates to:
  /// **'Sun, Moon, Water, and Fire. The natural world.'**
  String get sunMoonWaterAndFire;

  /// No description provided for @theBodyTheHeartAnd.
  ///
  /// In en, this message translates to:
  /// **'The body, the heart, and the family.'**
  String get theBodyTheHeartAnd;

  /// No description provided for @fieldsRoofsAndToolsThe.
  ///
  /// In en, this message translates to:
  /// **'Fields, roofs, and tools. The foundations of society.'**
  String get fieldsRoofsAndToolsThe;

  /// No description provided for @movementSpeechAndSustenance.
  ///
  /// In en, this message translates to:
  /// **'Movement, speech, and sustenance.'**
  String get movementSpeechAndSustenance;

  /// No description provided for @commerceClothingAndComplexArtifacts.
  ///
  /// In en, this message translates to:
  /// **'Commerce, clothing, and complex artifacts.'**
  String get commerceClothingAndComplexArtifacts;

  /// No description provided for @fastTrackSimpleCharacterMastered.
  ///
  /// In en, this message translates to:
  /// **'🚀 Fast Track! Simple character mastered.'**
  String get fastTrackSimpleCharacterMastered;

  /// No description provided for @excellentPrecisionGhostTraceSkipped.
  ///
  /// In en, this message translates to:
  /// **'⚡ Excellent precision! Ghost trace skipped.'**
  String get excellentPrecisionGhostTraceSkipped;

  /// No description provided for @sample.
  ///
  /// In en, this message translates to:
  /// **'Sample:'**
  String get sample;

  /// No description provided for @itsThat.
  ///
  /// In en, this message translates to:
  /// **'Its/That'**
  String get itsThat;

  /// No description provided for @iMe.
  ///
  /// In en, this message translates to:
  /// **'I/Me'**
  String get iMe;

  /// No description provided for @stillTough.
  ///
  /// In en, this message translates to:
  /// **'Still/Tough'**
  String get stillTough;

  /// No description provided for @partDecide.
  ///
  /// In en, this message translates to:
  /// **'Part/Decide'**
  String get partDecide;

  /// No description provided for @selectTheCharacterFor.
  ///
  /// In en, this message translates to:
  /// **'Select the character for:'**
  String get selectTheCharacterFor;

  /// No description provided for @selectThePinyinFor.
  ///
  /// In en, this message translates to:
  /// **'Select the Pinyin for:'**
  String get selectThePinyinFor;

  /// No description provided for @whereAreYouGoingThe.
  ///
  /// In en, this message translates to:
  /// **'Where are you going? The airport? It is quite a trip!'**
  String get whereAreYouGoingThe;

  /// No description provided for @youAreAuntieChenA.
  ///
  /// In en, this message translates to:
  /// **'You are Auntie Chen, a shrewd market vendor selling silk and fabrics. Your ONLY role is a market vendor. Negotiate prices firmly but fairly in Mandarin. NEVER break character or introduce yourself as anything other than a vendor. Start with high prices and be willing to bargain down.'**
  String get youAreAuntieChenA;

  /// No description provided for @youAreDrZhangA.
  ///
  /// In en, this message translates to:
  /// **'You are Dr. Zhang, a calm and professional doctor at a medical clinic. Your ONLY role is a doctor. Ask about health symptoms and provide medical advice in Mandarin. NEVER break character or introduce yourself as anything other than a doctor. Be reassuring but thorough.'**
  String get youAreDrZhangA;

  /// No description provided for @whereDoYouFeelUncomfortable.
  ///
  /// In en, this message translates to:
  /// **'Where do you feel uncomfortable? Do you have a fever?'**
  String get whereDoYouFeelUncomfortable;

  /// No description provided for @youAreACloseFriend.
  ///
  /// In en, this message translates to:
  /// **'You are a close friend catching up after a long time. Your ONLY role is a friend. Keep responses casual, warm, and short in Mandarin. NEVER break character or introduce yourself as anything other than a friend. Use informal speech patterns appropriate for close friends.'**
  String get youAreACloseFriend;

  /// No description provided for @noNbest.
  ///
  /// In en, this message translates to:
  /// **'no nbest'**
  String get noNbest;

  /// No description provided for @timedOut.
  ///
  /// In en, this message translates to:
  /// **'timed out'**
  String get timedOut;

  /// No description provided for @grading.
  ///
  /// In en, this message translates to:
  /// **'Grading...'**
  String get grading;

  /// No description provided for @label1st.
  ///
  /// In en, this message translates to:
  /// **'1st ˉ'**
  String get label1st;

  /// No description provided for @label2nd.
  ///
  /// In en, this message translates to:
  /// **'2nd ˊ'**
  String get label2nd;

  /// No description provided for @label3rd.
  ///
  /// In en, this message translates to:
  /// **'3rd ˇ'**
  String get label3rd;

  /// No description provided for @label4th.
  ///
  /// In en, this message translates to:
  /// **'4th ˋ'**
  String get label4th;

  /// No description provided for @speaking2.
  ///
  /// In en, this message translates to:
  /// **'Speaking...'**
  String get speaking2;

  /// No description provided for @sessionCompletedInYourNext.
  ///
  /// In en, this message translates to:
  /// **'Session completed. In your next practice, speak complete sentences to receive detailed pronunciation and tone diagnostics.'**
  String get sessionCompletedInYourNext;

  /// No description provided for @craneSoaring.
  ///
  /// In en, this message translates to:
  /// **'crane soaring'**
  String get craneSoaring;

  /// No description provided for @gentleStream.
  ///
  /// In en, this message translates to:
  /// **'gentle stream'**
  String get gentleStream;

  /// No description provided for @brushAndInk.
  ///
  /// In en, this message translates to:
  /// **'brush and ink'**
  String get brushAndInk;

  /// No description provided for @myStudent.
  ///
  /// In en, this message translates to:
  /// **'my student'**
  String get myStudent;

  /// No description provided for @honoredDisciple.
  ///
  /// In en, this message translates to:
  /// **'honored disciple'**
  String get honoredDisciple;

  /// No description provided for @notEnoughInformation.
  ///
  /// In en, this message translates to:
  /// **'not enough information'**
  String get notEnoughInformation;

  /// No description provided for @asAnAi.
  ///
  /// In en, this message translates to:
  /// **'as an ai'**
  String get asAnAi;

  /// No description provided for @goodPracticeSessionContinueFocusing.
  ///
  /// In en, this message translates to:
  /// **'Good practice session. Continue focusing on clear tone pitch contrasts and natural conversational pacing.'**
  String get goodPracticeSessionContinueFocusing;

  /// No description provided for @insideASleekFuxingBullet.
  ///
  /// In en, this message translates to:
  /// **'Inside a sleek Fuxing bullet train traveling at 350 km/h from Beijing to Shanghai.'**
  String get insideASleekFuxingBullet;

  /// No description provided for @harbinIceSnowWorldWonder.
  ///
  /// In en, this message translates to:
  /// **'Harbin Ice & Snow World Wonder'**
  String get harbinIceSnowWorldWonder;

  /// No description provided for @theFamousPanjiayuanWeekendFlea.
  ///
  /// In en, this message translates to:
  /// **'The famous Panjiayuan weekend flea market crowded with calligraphy scrolls, jade, and vintage trinkets.'**
  String get theFamousPanjiayuanWeekendFlea;

  /// No description provided for @jingdezhenBlueWhitePorcelainStudio.
  ///
  /// In en, this message translates to:
  /// **'Jingdezhen Blue & White Porcelain Studio'**
  String get jingdezhenBlueWhitePorcelainStudio;

  /// No description provided for @pekingOperaDressingRoomMakeup.
  ///
  /// In en, this message translates to:
  /// **'Peking Opera Dressing Room & Makeup'**
  String get pekingOperaDressingRoomMakeup;

  /// No description provided for @aHistoricTongrentangApothecaryScented.
  ///
  /// In en, this message translates to:
  /// **'A historic Tongrentang apothecary scented with ginseng, wolfberry, and hundreds of wooden herbal drawers.'**
  String get aHistoricTongrentangApothecaryScented;

  /// No description provided for @aVibrantPrivateNeonLit.
  ///
  /// In en, this message translates to:
  /// **'A vibrant private neon-lit karaoke room in Shenzhen with microphones, fruit platters, and screen controls.'**
  String get aVibrantPrivateNeonLit;

  /// No description provided for @animeCosplayExpoInGuangzhou.
  ///
  /// In en, this message translates to:
  /// **'Anime & Cosplay Expo in Guangzhou'**
  String get animeCosplayExpoInGuangzhou;

  /// No description provided for @nHOHuNy.
  ///
  /// In en, this message translates to:
  /// **'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?'**
  String get nHOHuNy;

  /// No description provided for @surpriseMe2.
  ///
  /// In en, this message translates to:
  /// **'🎲 Surprise Me'**
  String get surpriseMe2;

  /// No description provided for @eGALivelyBanquet.
  ///
  /// In en, this message translates to:
  /// **'e.g., A lively banquet celebrating in Shanghai...'**
  String get eGALivelyBanquet;

  /// No description provided for @rollCharacter2.
  ///
  /// In en, this message translates to:
  /// **'🎲 Roll Character'**
  String get rollCharacter2;

  /// No description provided for @eGACuriousCousin.
  ///
  /// In en, this message translates to:
  /// **'e.g., A curious cousin asking about your career...'**
  String get eGACuriousCousin;

  /// No description provided for @keepTrying.
  ///
  /// In en, this message translates to:
  /// **'Keep trying!'**
  String get keepTrying;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending...'**
  String get pending;

  /// No description provided for @expected.
  ///
  /// In en, this message translates to:
  /// **'🎯 Expected'**
  String get expected;

  /// No description provided for @hSK2Elementary.
  ///
  /// In en, this message translates to:
  /// **'HSK 2: Elementary'**
  String get hSK2Elementary;

  /// No description provided for @hSK3Intermediate.
  ///
  /// In en, this message translates to:
  /// **'HSK 3: Intermediate'**
  String get hSK3Intermediate;

  /// No description provided for @hSK5Advanced.
  ///
  /// In en, this message translates to:
  /// **'HSK 5: Advanced'**
  String get hSK5Advanced;

  /// No description provided for @expressYourselfFullyWith5000.
  ///
  /// In en, this message translates to:
  /// **'Express yourself fully with 5000+ words.'**
  String get expressYourselfFullyWith5000;

  /// No description provided for @hanziWriter.
  ///
  /// In en, this message translates to:
  /// **'hanzi-writer'**
  String get hanziWriter;

  /// No description provided for @hvg.
  ///
  /// In en, this message translates to:
  /// **'hvg:'**
  String get hvg;

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get dueToday;

  /// No description provided for @newAvailable.
  ///
  /// In en, this message translates to:
  /// **'New available'**
  String get newAvailable;

  /// No description provided for @deleteAccountTile.
  ///
  /// In en, this message translates to:
  /// **'delete-account-tile'**
  String get deleteAccountTile;

  /// No description provided for @giveASingleShortPractical.
  ///
  /// In en, this message translates to:
  /// **'Give a single, short, practical tip on how to improve the shape, position, or length of the poorly drawn strokes. Be direct and helpful, do not be overly poetic or metaphorical. Do not use markdown.'**
  String get giveASingleShortPractical;

  /// No description provided for @localOnDeviceTTS.
  ///
  /// In en, this message translates to:
  /// **'Local — On-device TTS'**
  String get localOnDeviceTTS;

  /// No description provided for @espaOl.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get espaOl;

  /// No description provided for @franAis.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get franAis;

  /// No description provided for @portuguS.
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get portuguS;

  /// No description provided for @tiNgViT.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get tiNgViT;

  /// No description provided for @koreFemaleWarm.
  ///
  /// In en, this message translates to:
  /// **'Kore — Female, warm'**
  String get koreFemaleWarm;

  /// No description provided for @aoedeFemaleCheerful.
  ///
  /// In en, this message translates to:
  /// **'Aoede — Female, cheerful'**
  String get aoedeFemaleCheerful;

  /// No description provided for @fenrirMaleUpbeat.
  ///
  /// In en, this message translates to:
  /// **'Fenrir — Male, upbeat'**
  String get fenrirMaleUpbeat;

  /// No description provided for @charonMaleNewsStyle.
  ///
  /// In en, this message translates to:
  /// **'Charon — Male, news-style'**
  String get charonMaleNewsStyle;

  /// No description provided for @puckMaleSporty.
  ///
  /// In en, this message translates to:
  /// **'Puck — Male, sporty'**
  String get puckMaleSporty;

  /// No description provided for @systemVoice.
  ///
  /// In en, this message translates to:
  /// **'System voice'**
  String get systemVoice;

  /// No description provided for @generateAdd.
  ///
  /// In en, this message translates to:
  /// **'Generate & Add'**
  String get generateAdd;

  /// No description provided for @moreExamples.
  ///
  /// In en, this message translates to:
  /// **'📝 More examples'**
  String get moreExamples;

  /// No description provided for @usage2.
  ///
  /// In en, this message translates to:
  /// **'❓ Usage'**
  String get usage2;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'💬 Translation'**
  String get translation;

  /// No description provided for @collocations.
  ///
  /// In en, this message translates to:
  /// **'📚 Collocations'**
  String get collocations;

  /// No description provided for @mistakes.
  ///
  /// In en, this message translates to:
  /// **'❌ Mistakes'**
  String get mistakes;

  /// No description provided for @decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @label0MeansThisCardType.
  ///
  /// In en, this message translates to:
  /// **'0 means this card type is disabled.'**
  String get label0MeansThisCardType;

  /// No description provided for @tapTheValueToEnter.
  ///
  /// In en, this message translates to:
  /// **'Tap the value to enter an exact limit.'**
  String get tapTheValueToEnter;

  /// No description provided for @exactDailyLimit.
  ///
  /// In en, this message translates to:
  /// **'Exact daily limit'**
  String get exactDailyLimit;

  /// No description provided for @enter0ToDisable.
  ///
  /// In en, this message translates to:
  /// **'Enter 0 to disable.'**
  String get enter0ToDisable;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @selectDeck.
  ///
  /// In en, this message translates to:
  /// **'Select Deck'**
  String get selectDeck;

  /// No description provided for @azureSpeechKeysNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Azure Speech keys not configured. Add AZURE_SPEECH_KEY and AZURE_SPEECH_REGION to .env'**
  String get azureSpeechKeysNotConfigured;

  /// No description provided for @sTARTING.
  ///
  /// In en, this message translates to:
  /// **'STARTING…'**
  String get sTARTING;

  /// No description provided for @sTARTSESSION.
  ///
  /// In en, this message translates to:
  /// **'START SESSION'**
  String get sTARTSESSION;

  /// No description provided for @translating2.
  ///
  /// In en, this message translates to:
  /// **'Translating...'**
  String get translating2;

  /// No description provided for @chai.
  ///
  /// In en, this message translates to:
  /// **'柴知道Chai...'**
  String get chai;

  /// No description provided for @oneInABillion2.
  ///
  /// In en, this message translates to:
  /// **'@One-In-a-Billion'**
  String get oneInABillion2;

  /// No description provided for @businessEconomics.
  ///
  /// In en, this message translates to:
  /// **'business & economics'**
  String get businessEconomics;

  /// No description provided for @hskPreparation.
  ///
  /// In en, this message translates to:
  /// **'hsk preparation'**
  String get hskPreparation;

  /// No description provided for @liveInChina.
  ///
  /// In en, this message translates to:
  /// **'live in china'**
  String get liveInChina;

  /// No description provided for @comprehensiveExercise.
  ///
  /// In en, this message translates to:
  /// **'comprehensive exercise'**
  String get comprehensiveExercise;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'how to use'**
  String get howToUse;

  /// No description provided for @usesOf.
  ///
  /// In en, this message translates to:
  /// **'uses of'**
  String get usesOf;

  /// No description provided for @appearedFirstOnMandarinBean.
  ///
  /// In en, this message translates to:
  /// **'appeared first on Mandarin Bean'**
  String get appearedFirstOnMandarinBean;

  /// No description provided for @news2.
  ///
  /// In en, this message translates to:
  /// **'news:'**
  String get news2;

  /// No description provided for @joke.
  ///
  /// In en, this message translates to:
  /// **'joke:'**
  String get joke;

  /// No description provided for @jokes.
  ///
  /// In en, this message translates to:
  /// **'jokes:'**
  String get jokes;

  /// No description provided for @academicScience.
  ///
  /// In en, this message translates to:
  /// **'academic / science'**
  String get academicScience;

  /// No description provided for @politicsCommunism.
  ///
  /// In en, this message translates to:
  /// **'politics & communism'**
  String get politicsCommunism;

  /// No description provided for @foodDining.
  ///
  /// In en, this message translates to:
  /// **'Food & Dining'**
  String get foodDining;

  /// No description provided for @sciFi.
  ///
  /// In en, this message translates to:
  /// **'sci-fi'**
  String get sciFi;

  /// No description provided for @scienceFictionTech.
  ///
  /// In en, this message translates to:
  /// **'Science Fiction & Tech'**
  String get scienceFictionTech;

  /// No description provided for @travelPlaces.
  ///
  /// In en, this message translates to:
  /// **'Travel & Places'**
  String get travelPlaces;

  /// No description provided for @mythologyFantasy.
  ///
  /// In en, this message translates to:
  /// **'Mythology & Fantasy'**
  String get mythologyFantasy;

  /// No description provided for @cultureTraditions.
  ///
  /// In en, this message translates to:
  /// **'Culture & Traditions'**
  String get cultureTraditions;

  /// No description provided for @businessEconomy.
  ///
  /// In en, this message translates to:
  /// **'Business & Economy'**
  String get businessEconomy;

  /// No description provided for @natureAnimals.
  ///
  /// In en, this message translates to:
  /// **'Nature & Animals'**
  String get natureAnimals;

  /// No description provided for @articleImg.
  ///
  /// In en, this message translates to:
  /// **'article img'**
  String get articleImg;

  /// No description provided for @entryContentImg.
  ///
  /// In en, this message translates to:
  /// **'.entry-content img'**
  String get entryContentImg;

  /// No description provided for @zhHans.
  ///
  /// In en, this message translates to:
  /// **'zh-Hans'**
  String get zhHans;

  /// No description provided for @zhHant.
  ///
  /// In en, this message translates to:
  /// **'zh-Hant'**
  String get zhHant;

  /// No description provided for @pLDpUVcjhvJisQCVw4YJVNTxTDrVQUgbr.
  ///
  /// In en, this message translates to:
  /// **'PLDpUVcjhvJisQCVw4YJVNTxT-DrVQUgbr'**
  String get pLDpUVcjhvJisQCVw4YJVNTxTDrVQUgbr;

  /// No description provided for @siJin.
  ///
  /// In en, this message translates to:
  /// **'【似锦 Si Jin】正片 | #张晚意 #景甜'**
  String get siJin;

  /// No description provided for @xiXiPicturesOfficialChannel.
  ///
  /// In en, this message translates to:
  /// **'西嘻影业官方频道 XiXi Pictures Official Channel'**
  String get xiXiPicturesOfficialChannel;

  /// No description provided for @pLDpUVcjhvJitpknWzhJbWevf7VSVWXk2.
  ///
  /// In en, this message translates to:
  /// **'PLDpUVcjhvJitpknWzhJb-wevf7VSVWXk2'**
  String get pLDpUVcjhvJitpknWzhJbWevf7VSVWXk2;

  /// No description provided for @sIXSISTERS.
  ///
  /// In en, this message translates to:
  /// **'【六姊妹 SIX SISTERS】正片 | #梅婷 #陆毅 #邬君梅 #奚美娟'**
  String get sIXSISTERS;

  /// No description provided for @shineOnMeENGSUB.
  ///
  /// In en, this message translates to:
  /// **'【骄阳似我 Shine On Me】ENG SUB | #宋威龙 #赵今麦'**
  String get shineOnMeENGSUB;

  /// No description provided for @eNGSUBThoseDays.
  ///
  /// In en, this message translates to:
  /// **'ENG SUB【四喜 Those Days】| 童瑶 蒋欣 黄明昊 许娣'**
  String get eNGSUBThoseDays;

  /// No description provided for @getTheWeTVAPP.
  ///
  /// In en, this message translates to:
  /// **'腾讯视频 - Get the WeTV APP'**
  String get getTheWeTVAPP;

  /// No description provided for @liziqi2.
  ///
  /// In en, this message translates to:
  /// **'李子柒 Liziqi'**
  String get liziqi2;

  /// No description provided for @uCQRJN2yW42jqXIGK2VKIPw.
  ///
  /// In en, this message translates to:
  /// **'UCQ_RJN2yW42jqXIGK2VKIPw'**
  String get uCQRJN2yW42jqXIGK2VKIPw;

  /// No description provided for @uCt4t3iY8hL5sF5pV6qW2xRg.
  ///
  /// In en, this message translates to:
  /// **'UCt4t3iY8hL5sF5pV6qW2xRg'**
  String get uCt4t3iY8hL5sF5pV6qW2xRg;

  /// No description provided for @uCp8q9rL2jG5hV7xW3mR5bNQ.
  ///
  /// In en, this message translates to:
  /// **'UCp8q9rL2jG5hV7xW3mR5bNQ'**
  String get uCp8q9rL2jG5hV7xW3mR5bNQ;

  /// No description provided for @uCvZ9W7u3T6a5YJS0VT28oA.
  ///
  /// In en, this message translates to:
  /// **'UCvZ9W7u3T6a5YJS0VT-28oA'**
  String get uCvZ9W7u3T6a5YJS0VT28oA;

  /// No description provided for @uCm7yM8rL5jG5pV6qW3xR2bQ.
  ///
  /// In en, this message translates to:
  /// **'UCm7yM8rL5jG5pV6qW3xR2bQ'**
  String get uCm7yM8rL5jG5pV6qW3xR2bQ;

  /// No description provided for @uCJ10R97LkwGdTqBT6xzV8g.
  ///
  /// In en, this message translates to:
  /// **'UCJ10R97LkwGdTqBT6xz-v8g'**
  String get uCJ10R97LkwGdTqBT6xzV8g;

  /// No description provided for @learnMandarinWithTaiwanPlus.
  ///
  /// In en, this message translates to:
  /// **'Learn Mandarin with TaiwanPlus'**
  String get learnMandarinWithTaiwanPlus;

  /// No description provided for @everydayChinese.
  ///
  /// In en, this message translates to:
  /// **'Everyday Chinese'**
  String get everydayChinese;

  /// No description provided for @uCCFdR7zZ5SUXuOrEdKw.
  ///
  /// In en, this message translates to:
  /// **'UCC_fdR7zZ_5SU--xuOrEdKw'**
  String get uCCFdR7zZ5SUXuOrEdKw;

  /// No description provided for @tingDailyLifeInChina.
  ///
  /// In en, this message translates to:
  /// **'Ting-Daily life in China'**
  String get tingDailyLifeInChina;

  /// No description provided for @tFTFOODTRAVEL.
  ///
  /// In en, this message translates to:
  /// **'TFT - FOOD & TRAVEL'**
  String get tFTFOODTRAVEL;

  /// No description provided for @uCsHMiBJ9r87fRH7VAWZw.
  ///
  /// In en, this message translates to:
  /// **'UCs_h_miBJ9r8-7fRH7VAWZw'**
  String get uCsHMiBJ9r87fRH7VAWZw;

  /// No description provided for @liziqi3.
  ///
  /// In en, this message translates to:
  /// **'李子柒 Liziqi: 大蒜的一生'**
  String get liziqi3;

  /// No description provided for @label2MINCULTURALCONTEXT.
  ///
  /// In en, this message translates to:
  /// **'2 MIN CULTURAL CONTEXT'**
  String get label2MINCULTURALCONTEXT;

  /// No description provided for @liziqi4.
  ///
  /// In en, this message translates to:
  /// **'李子柒 Liziqi: 竹子家具'**
  String get liziqi4;

  /// No description provided for @peppaPigChinese2.
  ///
  /// In en, this message translates to:
  /// **'Peppa Pig Chinese: 泥坑'**
  String get peppaPigChinese2;

  /// No description provided for @noBBCLeadArticleIs.
  ///
  /// In en, this message translates to:
  /// **'No BBC lead article is currently available.'**
  String get noBBCLeadArticleIs;

  /// No description provided for @mediaThumbnail.
  ///
  /// In en, this message translates to:
  /// **'media:thumbnail'**
  String get mediaThumbnail;

  /// No description provided for @bBC.
  ///
  /// In en, this message translates to:
  /// **'BBC 中文'**
  String get bBC;

  /// No description provided for @siJin2.
  ///
  /// In en, this message translates to:
  /// **'似锦 Si Jin'**
  String get siJin2;

  /// No description provided for @n9Yh6jSqjg.
  ///
  /// In en, this message translates to:
  /// **'n9Yh-6jSqjg'**
  String get n9Yh6jSqjg;

  /// No description provided for @eV4j0RDXDVU.
  ///
  /// In en, this message translates to:
  /// **'EV4j0RDXDVU'**
  String get eV4j0RDXDVU;

  /// No description provided for @eY3hnHAmSg.
  ///
  /// In en, this message translates to:
  /// **'e-Y3hnHAmSg'**
  String get eY3hnHAmSg;

  /// No description provided for @cD0Q81FnaY.
  ///
  /// In en, this message translates to:
  /// **'CD0Q81-fnaY'**
  String get cD0Q81FnaY;

  /// No description provided for @label0UEwtWyW5s.
  ///
  /// In en, this message translates to:
  /// **'0UEwtWy-W5s'**
  String get label0UEwtWyW5s;

  /// No description provided for @label8PNkm5Mxxk.
  ///
  /// In en, this message translates to:
  /// **'8PNkm5-Mxxk'**
  String get label8PNkm5Mxxk;

  /// No description provided for @iWNYkjEle8.
  ///
  /// In en, this message translates to:
  /// **'IWNYkj-ele8'**
  String get iWNYkjEle8;

  /// No description provided for @rGrzq5WtBE.
  ///
  /// In en, this message translates to:
  /// **'r-grzq5WtBE'**
  String get rGrzq5WtBE;

  /// No description provided for @tBo7q3wafw.
  ///
  /// In en, this message translates to:
  /// **'t-bo7q3wafw'**
  String get tBo7q3wafw;

  /// No description provided for @iJkbO5H6E.
  ///
  /// In en, this message translates to:
  /// **'I_jkbO5-h6E'**
  String get iJkbO5H6E;

  /// No description provided for @oMM5UD0T2w.
  ///
  /// In en, this message translates to:
  /// **'OMM5_UD0T2w'**
  String get oMM5UD0T2w;

  /// No description provided for @sIXSISTERS2.
  ///
  /// In en, this message translates to:
  /// **'六姊妹 SIX SISTERS'**
  String get sIXSISTERS2;

  /// No description provided for @cNylns5HiA.
  ///
  /// In en, this message translates to:
  /// **'c-nylns5HiA'**
  String get cNylns5HiA;

  /// No description provided for @mEUH5U8EZa4.
  ///
  /// In en, this message translates to:
  /// **'MEUH5U8EZa4'**
  String get mEUH5U8EZa4;

  /// No description provided for @label3Wx8JnjWZc.
  ///
  /// In en, this message translates to:
  /// **'3Wx8JnjW-Zc'**
  String get label3Wx8JnjWZc;

  /// No description provided for @qj17RJVE5B0.
  ///
  /// In en, this message translates to:
  /// **'Qj17RJVE5B0'**
  String get qj17RJVE5B0;

  /// No description provided for @vO4nggZ6Grs.
  ///
  /// In en, this message translates to:
  /// **'VO4nggZ6Grs'**
  String get vO4nggZ6Grs;

  /// No description provided for @zNR4WLEcJ4.
  ///
  /// In en, this message translates to:
  /// **'Z-NR4WLEcJ4'**
  String get zNR4WLEcJ4;

  /// No description provided for @mA08u68O7Q.
  ///
  /// In en, this message translates to:
  /// **'MA08u68O7_Q'**
  String get mA08u68O7Q;

  /// No description provided for @ig8tnI0c9xM.
  ///
  /// In en, this message translates to:
  /// **'Ig8tnI0c9xM'**
  String get ig8tnI0c9xM;

  /// No description provided for @gIBYzq4lFtw.
  ///
  /// In en, this message translates to:
  /// **'GIBYzq4lFtw'**
  String get gIBYzq4lFtw;

  /// No description provided for @qDOf4OCZgd0.
  ///
  /// In en, this message translates to:
  /// **'QDOf4OCZgd0'**
  String get qDOf4OCZgd0;

  /// No description provided for @shineOnMe.
  ///
  /// In en, this message translates to:
  /// **'骄阳似我 Shine on Me'**
  String get shineOnMe;

  /// No description provided for @zx7pUK2J1Uc.
  ///
  /// In en, this message translates to:
  /// **'Zx7pUK2J1Uc'**
  String get zx7pUK2J1Uc;

  /// No description provided for @zdgymrBo9Y.
  ///
  /// In en, this message translates to:
  /// **'zdgymr-bo9Y'**
  String get zdgymrBo9Y;

  /// No description provided for @label7yMAZEUBs.
  ///
  /// In en, this message translates to:
  /// **'7yMAZ_e-uBs'**
  String get label7yMAZEUBs;

  /// No description provided for @l9AqUHU14.
  ///
  /// In en, this message translates to:
  /// **'_l9AqU-hU14'**
  String get l9AqUHU14;

  /// No description provided for @label1elnMxr0A0.
  ///
  /// In en, this message translates to:
  /// **'1elnMxr0-A0'**
  String get label1elnMxr0A0;

  /// No description provided for @ozsUxgd7sk.
  ///
  /// In en, this message translates to:
  /// **'OzsUxgd-7sk'**
  String get ozsUxgd7sk;

  /// No description provided for @label4czDUfmwv8.
  ///
  /// In en, this message translates to:
  /// **'4cz-dUfmwv8'**
  String get label4czDUfmwv8;

  /// No description provided for @iuiTM37MII.
  ///
  /// In en, this message translates to:
  /// **'iuiTM37M-II'**
  String get iuiTM37MII;

  /// No description provided for @xgXf9j96yM.
  ///
  /// In en, this message translates to:
  /// **'XgXf-9j96yM'**
  String get xgXf9j96yM;

  /// No description provided for @thoseDays.
  ///
  /// In en, this message translates to:
  /// **'四喜 Those days'**
  String get thoseDays;

  /// No description provided for @a5nhDbkkCU.
  ///
  /// In en, this message translates to:
  /// **'a5nhDbkkC-U'**
  String get a5nhDbkkCU;

  /// No description provided for @jb8unABN00.
  ///
  /// In en, this message translates to:
  /// **'-jb8unABN00'**
  String get jb8unABN00;

  /// No description provided for @label78OX9HXqKA.
  ///
  /// In en, this message translates to:
  /// **'78OX-9HXqKA'**
  String get label78OX9HXqKA;

  /// No description provided for @oDw77ocPGXg.
  ///
  /// In en, this message translates to:
  /// **'ODw77ocPGXg'**
  String get oDw77ocPGXg;

  /// No description provided for @tt28uayZ7U.
  ///
  /// In en, this message translates to:
  /// **'-tt28uayZ7U'**
  String get tt28uayZ7U;

  /// No description provided for @sOl3U7rPEPc.
  ///
  /// In en, this message translates to:
  /// **'SOl3U7rPEPc'**
  String get sOl3U7rPEPc;

  /// No description provided for @sffGZZpJ48.
  ///
  /// In en, this message translates to:
  /// **'sffGZZp-j48'**
  String get sffGZZpJ48;

  /// No description provided for @v2UNvBajdY.
  ///
  /// In en, this message translates to:
  /// **'v2UNv-BajdY'**
  String get v2UNvBajdY;

  /// No description provided for @noFunnyNoMoney.
  ///
  /// In en, this message translates to:
  /// **'不好笑就露宿街头No Funny No Money'**
  String get noFunnyNoMoney;

  /// No description provided for @dob3yGGLHIg.
  ///
  /// In en, this message translates to:
  /// **'Dob3yGGLHIg'**
  String get dob3yGGLHIg;

  /// No description provided for @q5vqCQ6P9Pk.
  ///
  /// In en, this message translates to:
  /// **'Q5vqCQ6P9Pk'**
  String get q5vqCQ6P9Pk;

  /// No description provided for @label9Nc40rZ3b8.
  ///
  /// In en, this message translates to:
  /// **'-9Nc40rZ3b8'**
  String get label9Nc40rZ3b8;

  /// No description provided for @d3zEt3pV8.
  ///
  /// In en, this message translates to:
  /// **'_D3z-Et3pV8'**
  String get d3zEt3pV8;

  /// No description provided for @label5S3yHQ10.
  ///
  /// In en, this message translates to:
  /// **'5_S3yHQ--10'**
  String get label5S3yHQ10;

  /// No description provided for @jQbyRRCa5U.
  ///
  /// In en, this message translates to:
  /// **'JQbyR-rCa5U'**
  String get jQbyRRCa5U;

  /// No description provided for @x5WFTXq2FW0.
  ///
  /// In en, this message translates to:
  /// **'X5WFTXq2FW0'**
  String get x5WFTXq2FW0;

  /// No description provided for @getTheWeTVAPP2.
  ///
  /// In en, this message translates to:
  /// **'腾讯视频 - 动漫 - Get the WeTV APP'**
  String get getTheWeTVAPP2;

  /// No description provided for @y4TWL0m2i4c.
  ///
  /// In en, this message translates to:
  /// **'Y4TWL0m2i4c'**
  String get y4TWL0m2i4c;

  /// No description provided for @uVZdKZcAXU.
  ///
  /// In en, this message translates to:
  /// **'UV-ZdKZcAXU'**
  String get uVZdKZcAXU;

  /// No description provided for @mR8VUhHc.
  ///
  /// In en, this message translates to:
  /// **'-__MR8VUhHc'**
  String get mR8VUhHc;

  /// No description provided for @jrTInzf1Kc.
  ///
  /// In en, this message translates to:
  /// **'Jr_tInzf1Kc'**
  String get jrTInzf1Kc;

  /// No description provided for @xfjz857p3w.
  ///
  /// In en, this message translates to:
  /// **'Xfjz_857p3w'**
  String get xfjz857p3w;

  /// No description provided for @mI1Wl3V5WBE.
  ///
  /// In en, this message translates to:
  /// **'MI1Wl3V5WBE'**
  String get mI1Wl3V5WBE;

  /// No description provided for @lordOfMysteriesVlog.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 乌贼配音vlog终版 腾讯视频 - 动漫'**
  String get lordOfMysteriesVlog;

  /// No description provided for @lordOfMysteries.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第八期 腾讯视频 - 动漫'**
  String get lordOfMysteries;

  /// No description provided for @lordOfMysteries2.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第七期 腾讯视频 - 动漫'**
  String get lordOfMysteries2;

  /// No description provided for @lordOfMysteries3.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第六期 腾讯视频 - 动漫'**
  String get lordOfMysteries3;

  /// No description provided for @lordOfMysteries4.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第五期 腾讯视频 - 动漫'**
  String get lordOfMysteries4;

  /// No description provided for @lordOfMysteries5.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第四期 腾讯视频 - 动漫'**
  String get lordOfMysteries5;

  /// No description provided for @lordOfMysteries6.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第三期 腾讯视频 - 动漫'**
  String get lordOfMysteries6;

  /// No description provided for @pakhctn6g6A.
  ///
  /// In en, this message translates to:
  /// **'Pakhctn6g6A'**
  String get pakhctn6g6A;

  /// No description provided for @lordOfMysteries7.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第二期 腾讯视频 - 动漫'**
  String get lordOfMysteries7;

  /// No description provided for @lordOfMysteries8.
  ///
  /// In en, this message translates to:
  /// **'《诡秘之主》Lord of Mysteries 神秘学课堂第一期 腾讯视频 - 动漫'**
  String get lordOfMysteries8;

  /// No description provided for @g5fLWO98axs.
  ///
  /// In en, this message translates to:
  /// **'G5fLWO98axs'**
  String get g5fLWO98axs;

  /// No description provided for @gK0eOTF2s4c.
  ///
  /// In en, this message translates to:
  /// **'GK0eOTF2s4c'**
  String get gK0eOTF2s4c;

  /// No description provided for @oSTLordOfMysteries.
  ///
  /// In en, this message translates to:
  /// **'【OST】《诡秘之主》Lord of Mysteries 终幕曲《勿忘我》 腾讯视频 - 动漫'**
  String get oSTLordOfMysteries;

  /// No description provided for @membersPremiere2.
  ///
  /// In en, this message translates to:
  /// **'Members Premiere 会员抢先看'**
  String get membersPremiere2;

  /// No description provided for @dOtFXu1Vw.
  ///
  /// In en, this message translates to:
  /// **'_dOt-fXu1Vw'**
  String get dOtFXu1Vw;

  /// No description provided for @eA13aHY8jw.
  ///
  /// In en, this message translates to:
  /// **'EA13aH_Y8jw'**
  String get eA13aHY8jw;

  /// No description provided for @jVfwogmt8JM.
  ///
  /// In en, this message translates to:
  /// **'JVfwogmt8JM'**
  String get jVfwogmt8JM;

  /// No description provided for @sfj9727Xu4.
  ///
  /// In en, this message translates to:
  /// **'Sfj9727-Xu4'**
  String get sfj9727Xu4;

  /// No description provided for @tnv6Me0FI4s.
  ///
  /// In en, this message translates to:
  /// **'Tnv6Me0FI4s'**
  String get tnv6Me0FI4s;

  /// No description provided for @wEY80ZpZ8.
  ///
  /// In en, this message translates to:
  /// **'wEY80-_ZpZ8'**
  String get wEY80ZpZ8;

  /// No description provided for @pNRv9ncKDq4.
  ///
  /// In en, this message translates to:
  /// **'PNRv9ncKDq4'**
  String get pNRv9ncKDq4;

  /// No description provided for @yZI6rr4wR1I.
  ///
  /// In en, this message translates to:
  /// **'YZI6rr4wR1I'**
  String get yZI6rr4wR1I;

  /// No description provided for @bDzKpcxWto.
  ///
  /// In en, this message translates to:
  /// **'B-DzKpcxWto'**
  String get bDzKpcxWto;

  /// No description provided for @dy9QDPpZBk.
  ///
  /// In en, this message translates to:
  /// **'dy9QDPpZ-bk'**
  String get dy9QDPpZBk;

  /// No description provided for @tZ53akmpvyc.
  ///
  /// In en, this message translates to:
  /// **'TZ53akmpvyc'**
  String get tZ53akmpvyc;

  /// No description provided for @label4Ip1rJO4gE.
  ///
  /// In en, this message translates to:
  /// **'4-Ip1rJO4gE'**
  String get label4Ip1rJO4gE;

  /// No description provided for @label5VKww8pjFA.
  ///
  /// In en, this message translates to:
  /// **'5-vKww8pjFA'**
  String get label5VKww8pjFA;

  /// No description provided for @label60SpwYfgUU.
  ///
  /// In en, this message translates to:
  /// **'60Spw-yfgUU'**
  String get label60SpwYfgUU;

  /// No description provided for @v8AG9HnmFA.
  ///
  /// In en, this message translates to:
  /// **'V8AG9_hnmFA'**
  String get v8AG9HnmFA;

  /// No description provided for @vY6ao4ktdo.
  ///
  /// In en, this message translates to:
  /// **'-vY6ao4ktdo'**
  String get vY6ao4ktdo;

  /// No description provided for @htxVeakvE.
  ///
  /// In en, this message translates to:
  /// **'-htx-veakvE'**
  String get htxVeakvE;

  /// No description provided for @fO7muIAr9dA.
  ///
  /// In en, this message translates to:
  /// **'FO7muIAr9dA'**
  String get fO7muIAr9dA;

  /// No description provided for @s4O9Nk3Q4.
  ///
  /// In en, this message translates to:
  /// **'S4_O9Nk-3Q4'**
  String get s4O9Nk3Q4;

  /// No description provided for @lMDHc55prI.
  ///
  /// In en, this message translates to:
  /// **'LM_dHc55prI'**
  String get lMDHc55prI;

  /// No description provided for @lGpl7G7850.
  ///
  /// In en, this message translates to:
  /// **'-LGpl7G7850'**
  String get lGpl7G7850;

  /// No description provided for @xJ2dwZ2xCw0.
  ///
  /// In en, this message translates to:
  /// **'XJ2dwZ2xCw0'**
  String get xJ2dwZ2xCw0;

  /// No description provided for @qo47iejJOQ.
  ///
  /// In en, this message translates to:
  /// **'Qo_47iejJOQ'**
  String get qo47iejJOQ;

  /// No description provided for @gbnoj9WUP5Y.
  ///
  /// In en, this message translates to:
  /// **'Gbnoj9WUP5Y'**
  String get gbnoj9WUP5Y;

  /// No description provided for @qCHKUuwF0.
  ///
  /// In en, this message translates to:
  /// **'QCHKUuw_f_0'**
  String get qCHKUuwF0;

  /// No description provided for @qyh4kU263OA.
  ///
  /// In en, this message translates to:
  /// **'Qyh4kU263OA'**
  String get qyh4kU263OA;

  /// No description provided for @vnTQZY6QM.
  ///
  /// In en, this message translates to:
  /// **'Vn-TQZ_Y6QM'**
  String get vnTQZY6QM;

  /// No description provided for @vwk9yx7WL0c.
  ///
  /// In en, this message translates to:
  /// **'Vwk9yx7WL0c'**
  String get vwk9yx7WL0c;

  /// No description provided for @uLa6Qw2aL0.
  ///
  /// In en, this message translates to:
  /// **'u-La6Qw2aL0'**
  String get uLa6Qw2aL0;

  /// No description provided for @kQJ5gjZwU0.
  ///
  /// In en, this message translates to:
  /// **'k-QJ5gjZwU0'**
  String get kQJ5gjZwU0;

  /// No description provided for @mQH5jhyqPHc.
  ///
  /// In en, this message translates to:
  /// **'MQH5jhyqPHc'**
  String get mQH5jhyqPHc;

  /// No description provided for @h6rjzyquxA.
  ///
  /// In en, this message translates to:
  /// **'h6rjzyqux-A'**
  String get h6rjzyquxA;

  /// No description provided for @pLMX26aiIvX5phl8n87NqTbaeXK2HHm.
  ///
  /// In en, this message translates to:
  /// **'PLMX26aiIvX5phl8n8-7-nqTbaeXK2HHm-'**
  String get pLMX26aiIvX5phl8n87NqTbaeXK2HHm;

  /// No description provided for @eightHundred.
  ///
  /// In en, this message translates to:
  /// **'方圆八百米 Eight Hundred'**
  String get eightHundred;

  /// No description provided for @l1Xmsbo6RE.
  ///
  /// In en, this message translates to:
  /// **'L1Xmsbo6_rE'**
  String get l1Xmsbo6RE;

  /// No description provided for @dq1IgosbLQ.
  ///
  /// In en, this message translates to:
  /// **'Dq1Igosb_lQ'**
  String get dq1IgosbLQ;

  /// No description provided for @i8e9E1bZR7I.
  ///
  /// In en, this message translates to:
  /// **'I8e9E1bZR7I'**
  String get i8e9E1bZR7I;

  /// No description provided for @iqRK2KUN0I.
  ///
  /// In en, this message translates to:
  /// **'IqRK2KUN-0I'**
  String get iqRK2KUN0I;

  /// No description provided for @c3wWSQPFc0.
  ///
  /// In en, this message translates to:
  /// **'C3w-WSQPFc0'**
  String get c3wWSQPFc0;

  /// No description provided for @loveBeyondTheGrave.
  ///
  /// In en, this message translates to:
  /// **'白日提灯 Love Beyond the Grave'**
  String get loveBeyondTheGrave;

  /// No description provided for @rPWA2OHxlaw.
  ///
  /// In en, this message translates to:
  /// **'RPWA2OHxlaw'**
  String get rPWA2OHxlaw;

  /// No description provided for @label8NShMGCGZk.
  ///
  /// In en, this message translates to:
  /// **'8NShMG-cGZk'**
  String get label8NShMGCGZk;

  /// No description provided for @q2TPc3EOYl4.
  ///
  /// In en, this message translates to:
  /// **'Q2TPc3EOYl4'**
  String get q2TPc3EOYl4;

  /// No description provided for @pmPPM7YT5M.
  ///
  /// In en, this message translates to:
  /// **'PmPP-M7YT5M'**
  String get pmPPM7YT5M;

  /// No description provided for @azFL5ujNQ0.
  ///
  /// In en, this message translates to:
  /// **'-AzFL5ujNQ0'**
  String get azFL5ujNQ0;

  /// No description provided for @kpD2a0Z9yE.
  ///
  /// In en, this message translates to:
  /// **'kpD-2a0Z9yE'**
  String get kpD2a0Z9yE;

  /// No description provided for @dMAm1i8Ylb8.
  ///
  /// In en, this message translates to:
  /// **'DMAm1i8Ylb8'**
  String get dMAm1i8Ylb8;

  /// No description provided for @ppk0MGKF8Y.
  ///
  /// In en, this message translates to:
  /// **'Ppk_0MGKF8Y'**
  String get ppk0MGKF8Y;

  /// No description provided for @label1ZEKWcipU.
  ///
  /// In en, this message translates to:
  /// **'1_zEK-WcipU'**
  String get label1ZEKWcipU;

  /// No description provided for @dcOLJI4L5A.
  ///
  /// In en, this message translates to:
  /// **'dcO-LJI4L5A'**
  String get dcOLJI4L5A;

  /// No description provided for @loveBeyondTheGrave2.
  ///
  /// In en, this message translates to:
  /// **'片场彩蛋：贺思慕段胥本名难觅花名纷至【白日提灯 Love Beyond the Grave】'**
  String get loveBeyondTheGrave2;

  /// No description provided for @label5MVET41ATY.
  ///
  /// In en, this message translates to:
  /// **'5MVET41A-tY'**
  String get label5MVET41ATY;

  /// No description provided for @bTSLoveBeyondTheGrave.
  ///
  /// In en, this message translates to:
  /// **'BTS｜【鹅剧派对】迪丽热巴陈飞宇携众主创默契五感五连拍！【白日提灯 Love Beyond the Grave】'**
  String get bTSLoveBeyondTheGrave;

  /// No description provided for @bTSLoveBeyondTheGrave2.
  ///
  /// In en, this message translates to:
  /// **'BTS｜【鹅剧派对】迪丽热巴陈飞宇亮相，眼神杀直接封神！【白日提灯 Love Beyond the Grave】'**
  String get bTSLoveBeyondTheGrave2;

  /// No description provided for @herBlaze.
  ///
  /// In en, this message translates to:
  /// **'她的盛焰 Her Blaze'**
  String get herBlaze;

  /// No description provided for @opOIDzw8Vo.
  ///
  /// In en, this message translates to:
  /// **'Op_OIDzw8Vo'**
  String get opOIDzw8Vo;

  /// No description provided for @rv9nnIn4wxQ.
  ///
  /// In en, this message translates to:
  /// **'Rv9nnIn4wxQ'**
  String get rv9nnIn4wxQ;

  /// No description provided for @c5e9V1GRnn8.
  ///
  /// In en, this message translates to:
  /// **'C5e9V1GRnn8'**
  String get c5e9V1GRnn8;

  /// No description provided for @xAjvi1fmrrQ.
  ///
  /// In en, this message translates to:
  /// **'XAjvi1fmrrQ'**
  String get xAjvi1fmrrQ;

  /// No description provided for @yIkxweh5A0.
  ///
  /// In en, this message translates to:
  /// **'yIkxweh5-A0'**
  String get yIkxweh5A0;

  /// No description provided for @label9CM48di86g.
  ///
  /// In en, this message translates to:
  /// **'9-CM48di86g'**
  String get label9CM48di86g;

  /// No description provided for @dAwbSEDikg.
  ///
  /// In en, this message translates to:
  /// **'D-AwbSEDikg'**
  String get dAwbSEDikg;

  /// No description provided for @ecXCXc5EUg.
  ///
  /// In en, this message translates to:
  /// **'Ec_xCXc5EUg'**
  String get ecXCXc5EUg;

  /// No description provided for @lKBf8Y0Qfqg.
  ///
  /// In en, this message translates to:
  /// **'LKBf8Y0Qfqg'**
  String get lKBf8Y0Qfqg;

  /// No description provided for @qnc5caQJITA.
  ///
  /// In en, this message translates to:
  /// **'Qnc5caQJITA'**
  String get qnc5caQJITA;

  /// No description provided for @xmLEreDeoU.
  ///
  /// In en, this message translates to:
  /// **'xmLEreDeo-U'**
  String get xmLEreDeoU;

  /// No description provided for @aboutLove.
  ///
  /// In en, this message translates to:
  /// **'玫瑰丛生 About Love'**
  String get aboutLove;

  /// No description provided for @i4cZFlj8Fw.
  ///
  /// In en, this message translates to:
  /// **'I4cZ-Flj8Fw'**
  String get i4cZFlj8Fw;

  /// No description provided for @v8m00Hcam0.
  ///
  /// In en, this message translates to:
  /// **'V8m0-0Hcam0'**
  String get v8m00Hcam0;

  /// No description provided for @aVPsfT4c4.
  ///
  /// In en, this message translates to:
  /// **'a-_vPsfT4c4'**
  String get aVPsfT4c4;

  /// No description provided for @cJ9KNnY2cc.
  ///
  /// In en, this message translates to:
  /// **'CJ9K-NnY2cc'**
  String get cJ9KNnY2cc;

  /// No description provided for @j078HAJbI.
  ///
  /// In en, this message translates to:
  /// **'J-078H-aJbI'**
  String get j078HAJbI;

  /// No description provided for @byLJulMrNs.
  ///
  /// In en, this message translates to:
  /// **'by-lJulMrNs'**
  String get byLJulMrNs;

  /// No description provided for @hj663skfypU.
  ///
  /// In en, this message translates to:
  /// **'Hj663skfypU'**
  String get hj663skfypU;

  /// No description provided for @lVOj0dkxDQ.
  ///
  /// In en, this message translates to:
  /// **'LVOj0dkx-DQ'**
  String get lVOj0dkxDQ;

  /// No description provided for @hKCVYT0J0.
  ///
  /// In en, this message translates to:
  /// **'hK-CVYT0J_0'**
  String get hKCVYT0J0;

  /// No description provided for @v9czXRh5oUc.
  ///
  /// In en, this message translates to:
  /// **'V9czXRh5oUc'**
  String get v9czXRh5oUc;

  /// No description provided for @af4fVhhPVg.
  ///
  /// In en, this message translates to:
  /// **'af4fVhhP-Vg'**
  String get af4fVhhPVg;

  /// No description provided for @tA.
  ///
  /// In en, this message translates to:
  /// **'《玫瑰丛生》全员陷入爱情迷雾，TA会如何破局？ ｜主演：王子文、刘宇宁'**
  String get tA;

  /// No description provided for @pLMX26aiIvX5rSLe74r7sARps4oOqaBWD.
  ///
  /// In en, this message translates to:
  /// **'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD'**
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD;

  /// No description provided for @generationToGeneration2.
  ///
  /// In en, this message translates to:
  /// **'江湖夜雨十年灯 Generation to Generation'**
  String get generationToGeneration2;

  /// No description provided for @wCfp3YN9mPs.
  ///
  /// In en, this message translates to:
  /// **'WCfp3YN9mPs'**
  String get wCfp3YN9mPs;

  /// No description provided for @label0Sus6s0HWM.
  ///
  /// In en, this message translates to:
  /// **'0Sus6s0-hWM'**
  String get label0Sus6s0HWM;

  /// No description provided for @zjcGjE54zU.
  ///
  /// In en, this message translates to:
  /// **'Zjc-GjE54zU'**
  String get zjcGjE54zU;

  /// No description provided for @g1q8I4lZ5mU.
  ///
  /// In en, this message translates to:
  /// **'G1q8I4lZ5mU'**
  String get g1q8I4lZ5mU;

  /// No description provided for @y2IWPq6jFCE.
  ///
  /// In en, this message translates to:
  /// **'Y2IWPq6jFCE'**
  String get y2IWPq6jFCE;

  /// No description provided for @wz9oy74X8.
  ///
  /// In en, this message translates to:
  /// **'Wz9oy_74_x8'**
  String get wz9oy74X8;

  /// No description provided for @ztz3CXfrQE.
  ///
  /// In en, this message translates to:
  /// **'-ztz3CXfrQE'**
  String get ztz3CXfrQE;

  /// No description provided for @loveStoryInThe1970s.
  ///
  /// In en, this message translates to:
  /// **'纯真年代的爱情 Love Story in the 1970s'**
  String get loveStoryInThe1970s;

  /// No description provided for @eGYAJh8Z8Pc.
  ///
  /// In en, this message translates to:
  /// **'EGYAJh8Z8Pc'**
  String get eGYAJh8Z8Pc;

  /// No description provided for @aBXZma9Mqc.
  ///
  /// In en, this message translates to:
  /// **'A-bXZma9Mqc'**
  String get aBXZma9Mqc;

  /// No description provided for @wSHZC7Yb5s.
  ///
  /// In en, this message translates to:
  /// **'WSHZC_7Yb5s'**
  String get wSHZC7Yb5s;

  /// No description provided for @aK8Fl3m9W7I.
  ///
  /// In en, this message translates to:
  /// **'AK8Fl3m9W7I'**
  String get aK8Fl3m9W7I;

  /// No description provided for @label0jw5TGzM0s.
  ///
  /// In en, this message translates to:
  /// **'0jw5T-gzM0s'**
  String get label0jw5TGzM0s;

  /// No description provided for @xIbV4LmjNk.
  ///
  /// In en, this message translates to:
  /// **'XIbV4-lmjNk'**
  String get xIbV4LmjNk;

  /// No description provided for @hkpSEzLKLg.
  ///
  /// In en, this message translates to:
  /// **'HkpSEzLK-Lg'**
  String get hkpSEzLKLg;

  /// No description provided for @pLMX26aiIvX5q5kRTszb0kZqKc2TJWnf.
  ///
  /// In en, this message translates to:
  /// **'PLMX26aiIvX5q5kR_Tszb0kZqKc2T-JWnf'**
  String get pLMX26aiIvX5q5kRTszb0kZqKc2TJWnf;

  /// No description provided for @whyIsHeStillSingle.
  ///
  /// In en, this message translates to:
  /// **'他为什么依然单身 Why Is He Still Single'**
  String get whyIsHeStillSingle;

  /// No description provided for @okB86OjCI.
  ///
  /// In en, this message translates to:
  /// **'okB_86OjC-I'**
  String get okB86OjCI;

  /// No description provided for @m8eZwl6rA4.
  ///
  /// In en, this message translates to:
  /// **'m8eZwl6rA-4'**
  String get m8eZwl6rA4;

  /// No description provided for @label3ub1XXXYI.
  ///
  /// In en, this message translates to:
  /// **'3ub-1-xXXYI'**
  String get label3ub1XXXYI;

  /// No description provided for @label4dW228WSVk.
  ///
  /// In en, this message translates to:
  /// **'4dW228-wSVk'**
  String get label4dW228WSVk;

  /// No description provided for @wCAK3UFi5M.
  ///
  /// In en, this message translates to:
  /// **'WCAK3_uFi5M'**
  String get wCAK3UFi5M;

  /// No description provided for @eZzak3C73nI.
  ///
  /// In en, this message translates to:
  /// **'EZzak3C73nI'**
  String get eZzak3C73nI;

  /// No description provided for @theGlamorousNight.
  ///
  /// In en, this message translates to:
  /// **'夜色正浓 The Glamorous Night'**
  String get theGlamorousNight;

  /// No description provided for @theGlamorousNightE03.
  ///
  /// In en, this message translates to:
  /// **'【夜色正浓 The Glamorous Night】E03 霸气出招！赵玫绝地反击（江疏影，佟大为）'**
  String get theGlamorousNightE03;

  /// No description provided for @zaalDLrc.
  ///
  /// In en, this message translates to:
  /// **'--Zaal-DLrc'**
  String get zaalDLrc;

  /// No description provided for @label26Lkp84WD0.
  ///
  /// In en, this message translates to:
  /// **'2-6Lkp84WD0'**
  String get label26Lkp84WD0;

  /// No description provided for @jD9iPkDDqC.
  ///
  /// In en, this message translates to:
  /// **'jD9iPkDDq-c'**
  String get jD9iPkDDqC;

  /// No description provided for @jIyk18uXB7Q.
  ///
  /// In en, this message translates to:
  /// **'JIyk18uXB7Q'**
  String get jIyk18uXB7Q;

  /// No description provided for @h3XEsv0mgA.
  ///
  /// In en, this message translates to:
  /// **'h3-xEsv0mgA'**
  String get h3XEsv0mgA;

  /// No description provided for @vClRnlEUTQ.
  ///
  /// In en, this message translates to:
  /// **'VClRnlEUT-Q'**
  String get vClRnlEUTQ;

  /// No description provided for @myPageInThe90s.
  ///
  /// In en, this message translates to:
  /// **'突然的喜欢 My Page in the 90s'**
  String get myPageInThe90s;

  /// No description provided for @m7XBiuw1TU.
  ///
  /// In en, this message translates to:
  /// **'m7XBiuw1-tU'**
  String get m7XBiuw1TU;

  /// No description provided for @a25pD4FCQio.
  ///
  /// In en, this message translates to:
  /// **'A25pD4FCQio'**
  String get a25pD4FCQio;

  /// No description provided for @muCj0GdNdw.
  ///
  /// In en, this message translates to:
  /// **'muCj-0GdNdw'**
  String get muCj0GdNdw;

  /// No description provided for @aQ4hlmkOv3A.
  ///
  /// In en, this message translates to:
  /// **'AQ4hlmkOv3A'**
  String get aQ4hlmkOv3A;

  /// No description provided for @nEiRnIHDg.
  ///
  /// In en, this message translates to:
  /// **'NEiRn_IH-Dg'**
  String get nEiRnIHDg;

  /// No description provided for @label04MyPageInThe.
  ///
  /// In en, this message translates to:
  /// **'精彩片段04 : 离谱系统强行加戏！纸巾变卫生棉？这下尴尬大了！【突然的喜欢 My Page in the 90s】'**
  String get label04MyPageInThe;

  /// No description provided for @label03MyPageInThe.
  ///
  /// In en, this message translates to:
  /// **'精彩片段03 : 替闺蜜去相亲，结果相到了男主本尊？【突然的喜欢 My Page in the 90s】'**
  String get label03MyPageInThe;

  /// No description provided for @bTSXXMyPage.
  ///
  /// In en, this message translates to:
  /// **'BTS｜「出戏 X 陈星旭 X 王玉雯」高总和欢儿的抽象究竟谁更甚一筹？【突然的喜欢 My Page in the 90s】'**
  String get bTSXXMyPage;

  /// No description provided for @label02MyPageInThe.
  ///
  /// In en, this message translates to:
  /// **'精彩片段 02：本想攻略男主，结果竟然认错人？【突然的喜欢 My Page in the 90s】'**
  String get label02MyPageInThe;

  /// No description provided for @label01MyPageInThe.
  ///
  /// In en, this message translates to:
  /// **'精彩片段01 : 离谱！突然就穿书了？这剧情我该怎么演?【突然的喜欢 My Page in the 90s】'**
  String get label01MyPageInThe;

  /// No description provided for @bTSMyPageInThe.
  ///
  /// In en, this message translates to:
  /// **'BTS｜陈星旭王玉雯溜冰撞了个满怀【突然的喜欢 My Page in the 90s】'**
  String get bTSMyPageInThe;

  /// No description provided for @bTSMyPageInThe2.
  ///
  /// In en, this message translates to:
  /// **'BTS｜陈星旭王玉雯甜蜜跨年【突然的喜欢 My Page in the 90s】'**
  String get bTSMyPageInThe2;

  /// No description provided for @bTSMyPageInThe3.
  ///
  /// In en, this message translates to:
  /// **'BTS｜陈星旭王玉雯七夕定格甜蜜瞬间【突然的喜欢 My Page in the 90s】'**
  String get bTSMyPageInThe3;

  /// No description provided for @bTSMyPageInThe4.
  ///
  /// In en, this message translates to:
  /// **'BTS｜陈星旭王玉雯欢乐游乐场【突然的喜欢 My Page in the 90s】'**
  String get bTSMyPageInThe4;

  /// No description provided for @myPageInThe90s2.
  ///
  /// In en, this message translates to:
  /// **'《突然的喜欢 My Page in the 90s》今日开播，陈星旭王玉雯玩转系统甜蜜热恋'**
  String get myPageInThe90s2;

  /// No description provided for @myPageInThe90s3.
  ///
  /// In en, this message translates to:
  /// **'《突然的喜欢 My Page in the 90s》1月22日甜蜜开播，陈星旭王玉雯反套路恋爱'**
  String get myPageInThe90s3;

  /// No description provided for @myPageInThe90s4.
  ///
  /// In en, this message translates to:
  /// **'《突然的喜欢 My Page in the 90s》定档0122！陈星旭王玉雯跨时代热恋'**
  String get myPageInThe90s4;

  /// No description provided for @pLMX26aiIvX5qxr2ZxGgBQKRNVGydd.
  ///
  /// In en, this message translates to:
  /// **'PLMX26aiIvX5qxr2ZxGgBQKR-n-V_Gydd-'**
  String get pLMX26aiIvX5qxr2ZxGgBQKRNVGydd;

  /// No description provided for @uDFuWJvE1M.
  ///
  /// In en, this message translates to:
  /// **'uDFuWJv-e1M'**
  String get uDFuWJvE1M;

  /// No description provided for @bNKH0V8G.
  ///
  /// In en, this message translates to:
  /// **'bN-kH-0V8-g'**
  String get bNKH0V8G;

  /// No description provided for @l4tkACioRc.
  ///
  /// In en, this message translates to:
  /// **'L4tkACio-Rc'**
  String get l4tkACioRc;

  /// No description provided for @label2TheImperialCoronerS2.
  ///
  /// In en, this message translates to:
  /// **'御赐小仵作2 The Imperial Coroner S2'**
  String get label2TheImperialCoronerS2;

  /// No description provided for @hNa1FW55Q5s.
  ///
  /// In en, this message translates to:
  /// **'HNa1FW55Q5s'**
  String get hNa1FW55Q5s;

  /// No description provided for @yyn06Ql7ADg.
  ///
  /// In en, this message translates to:
  /// **'Yyn06Ql7ADg'**
  String get yyn06Ql7ADg;

  /// No description provided for @h0LBmMzQBc.
  ///
  /// In en, this message translates to:
  /// **'h0LBmMz-qBc'**
  String get h0LBmMzQBc;

  /// No description provided for @label25FI49I6Sk.
  ///
  /// In en, this message translates to:
  /// **'25FI49I6-Sk'**
  String get label25FI49I6Sk;

  /// No description provided for @aAY7eaH3jw.
  ///
  /// In en, this message translates to:
  /// **'aAY7ea-H3jw'**
  String get aAY7eaH3jw;

  /// No description provided for @ukcZXSZhOc.
  ///
  /// In en, this message translates to:
  /// **'UkcZX-SZhOc'**
  String get ukcZXSZhOc;

  /// No description provided for @pLMX26aiIvX5o7sdz290MeDHgSqCHsIS.
  ///
  /// In en, this message translates to:
  /// **'PLMX26aiIvX5o7sdz290MeD-HgSqCHsI_s'**
  String get pLMX26aiIvX5o7sdz290MeDHgSqCHsIS;

  /// No description provided for @theDreamMaker.
  ///
  /// In en, this message translates to:
  /// **'小城大事 The Dream Maker'**
  String get theDreamMaker;

  /// No description provided for @fLcyGh4lXM.
  ///
  /// In en, this message translates to:
  /// **'FLcy_gh4lXM'**
  String get fLcyGh4lXM;

  /// No description provided for @zvaRoKDtG0.
  ///
  /// In en, this message translates to:
  /// **'ZvaRoKDtG-0'**
  String get zvaRoKDtG0;

  /// No description provided for @x1CkUlPzUc.
  ///
  /// In en, this message translates to:
  /// **'x1CkUl-pzUc'**
  String get x1CkUlPzUc;

  /// No description provided for @axn5uV9sXSw.
  ///
  /// In en, this message translates to:
  /// **'Axn5uV9sXSw'**
  String get axn5uV9sXSw;

  /// No description provided for @hj11XBTF4hQ.
  ///
  /// In en, this message translates to:
  /// **'Hj11XBTF4hQ'**
  String get hj11XBTF4hQ;

  /// No description provided for @kzB7eE7CFc.
  ///
  /// In en, this message translates to:
  /// **'Kz_B7eE7CFc'**
  String get kzB7eE7CFc;

  /// No description provided for @m5bbHdJrE.
  ///
  /// In en, this message translates to:
  /// **'-m5bb_HdJrE'**
  String get m5bbHdJrE;

  /// No description provided for @vl9SPb3Hs.
  ///
  /// In en, this message translates to:
  /// **'Vl9_s-Pb3Hs'**
  String get vl9SPb3Hs;

  /// No description provided for @y1y6xz0xM2I.
  ///
  /// In en, this message translates to:
  /// **'Y1y6xz0xM2I'**
  String get y1y6xz0xM2I;

  /// No description provided for @label8HxijD19OI.
  ///
  /// In en, this message translates to:
  /// **'8HxijD19O-I'**
  String get label8HxijD19OI;

  /// No description provided for @nj33Wy40VXU.
  ///
  /// In en, this message translates to:
  /// **'Nj33Wy40VXU'**
  String get nj33Wy40VXU;

  /// No description provided for @eDGFBue80s.
  ///
  /// In en, this message translates to:
  /// **'EDGF_Bue80s'**
  String get eDGFBue80s;

  /// No description provided for @label19zBynsjTk.
  ///
  /// In en, this message translates to:
  /// **'19z-BynsjTk'**
  String get label19zBynsjTk;

  /// No description provided for @oJmIfnNd8s.
  ///
  /// In en, this message translates to:
  /// **'oJmIfnNd-8s'**
  String get oJmIfnNd8s;

  /// No description provided for @yVp1Ms3ZE8.
  ///
  /// In en, this message translates to:
  /// **'YVp1_Ms3ZE8'**
  String get yVp1Ms3ZE8;

  /// No description provided for @foreverYoungE23.
  ///
  /// In en, this message translates to:
  /// **'【轻年 Forever Young】E23 马丁回到胡同被兄弟硬控（霍建华, 田雨, 张雪迎, 乔振宇）'**
  String get foreverYoungE23;

  /// No description provided for @foreverYoungE25.
  ///
  /// In en, this message translates to:
  /// **'【轻年 Forever Young】E25 稳准狠！马丁教嫂子拿捏丈夫（霍建华, 田雨, 张雪迎, 乔振宇）'**
  String get foreverYoungE25;

  /// No description provided for @foreverYoungE24.
  ///
  /// In en, this message translates to:
  /// **'【轻年 Forever Young】E24 有情敌？马丁被毛头小子喊大叔（霍建华, 田雨, 张雪迎, 乔振宇）'**
  String get foreverYoungE24;

  /// No description provided for @fEYoHxyxzQ.
  ///
  /// In en, this message translates to:
  /// **'FEYo_hxyxzQ'**
  String get fEYoHxyxzQ;

  /// No description provided for @zF8OR9onddY.
  ///
  /// In en, this message translates to:
  /// **'ZF8OR9onddY'**
  String get zF8OR9onddY;

  /// No description provided for @b1FJGDAKV8.
  ///
  /// In en, this message translates to:
  /// **'B1FJ-GDAKV8'**
  String get b1FJGDAKV8;

  /// No description provided for @pLL3q9saUp1GZjNkX3Zxfr4y8rZhaZ0jV.
  ///
  /// In en, this message translates to:
  /// **'PLL3q9saUp1GZj-nkX3Zxfr4y8rZhaZ0jV'**
  String get pLL3q9saUp1GZjNkX3Zxfr4y8rZhaZ0jV;

  /// No description provided for @hOMELANDGUARDIAN.
  ///
  /// In en, this message translates to:
  /// **'守诚者|HOMELAND GUARDIAN🚔'**
  String get hOMELANDGUARDIAN;

  /// No description provided for @iQIYIGetTheIQIYIAPP.
  ///
  /// In en, this message translates to:
  /// **'iQIYI 悬疑社 - Get the iQIYI APP'**
  String get iQIYIGetTheIQIYIAPP;

  /// No description provided for @label8QBlaWEtbw.
  ///
  /// In en, this message translates to:
  /// **'8Q-blaWEtbw'**
  String get label8QBlaWEtbw;

  /// No description provided for @label0XrMBoHTsY.
  ///
  /// In en, this message translates to:
  /// **'0XrMBoH-TsY'**
  String get label0XrMBoHTsY;

  /// No description provided for @zBzbg0Nu84.
  ///
  /// In en, this message translates to:
  /// **'zBzbg0-Nu84'**
  String get zBzbg0Nu84;

  /// No description provided for @label7ItX7Vt8Qc.
  ///
  /// In en, this message translates to:
  /// **'7ItX7Vt8-qc'**
  String get label7ItX7Vt8Qc;

  /// No description provided for @zx5XvNKhXo.
  ///
  /// In en, this message translates to:
  /// **'zx5Xv-NKhXo'**
  String get zx5XvNKhXo;

  /// No description provided for @nigVK5Ing.
  ///
  /// In en, this message translates to:
  /// **'-Nig_vK5Ing'**
  String get nigVK5Ing;

  /// No description provided for @loveHasFireworks.
  ///
  /// In en, this message translates to:
  /// **'爱情有烟火 Love Has Fireworks'**
  String get loveHasFireworks;

  /// No description provided for @getTheWeTVAPP3.
  ///
  /// In en, this message translates to:
  /// **'腾讯视频 - 青春剧场 - Get the WeTV APP'**
  String get getTheWeTVAPP3;

  /// No description provided for @oMOcpoXhYw.
  ///
  /// In en, this message translates to:
  /// **'OMOcpoXh-yw'**
  String get oMOcpoXhYw;

  /// No description provided for @xwTcCP8TsU.
  ///
  /// In en, this message translates to:
  /// **'XwTc-CP8TsU'**
  String get xwTcCP8TsU;

  /// No description provided for @t4dBHQH9F0I.
  ///
  /// In en, this message translates to:
  /// **'T4dBHQH9F0I'**
  String get t4dBHQH9F0I;

  /// No description provided for @jZP3R3khZMk.
  ///
  /// In en, this message translates to:
  /// **'JZP3R3khZMk'**
  String get jZP3R3khZMk;

  /// No description provided for @cLBYyAU0AU.
  ///
  /// In en, this message translates to:
  /// **'-CLBYyAU0AU'**
  String get cLBYyAU0AU;

  /// No description provided for @x1F7qp1cZo.
  ///
  /// In en, this message translates to:
  /// **'X-1F7qp1cZo'**
  String get x1F7qp1cZo;

  /// No description provided for @jJ5X6yEpiI.
  ///
  /// In en, this message translates to:
  /// **'J-j5X6yEpiI'**
  String get jJ5X6yEpiI;

  /// No description provided for @label8JmxrnwT0.
  ///
  /// In en, this message translates to:
  /// **'8-jmxrnwT-0'**
  String get label8JmxrnwT0;

  /// No description provided for @gWvOJODRXU.
  ///
  /// In en, this message translates to:
  /// **'gWvOJO-dRXU'**
  String get gWvOJODRXU;

  /// No description provided for @t1VyWJTB2A.
  ///
  /// In en, this message translates to:
  /// **'t1VyWJT-b2A'**
  String get t1VyWJTB2A;

  /// No description provided for @e00xfXWql4Q.
  ///
  /// In en, this message translates to:
  /// **'E00xfXWql4Q'**
  String get e00xfXWql4Q;

  /// No description provided for @theHiddenHeirYeChen2.
  ///
  /// In en, this message translates to:
  /// **'进击的叶辰 The Hidden Heir Ye Chen'**
  String get theHiddenHeirYeChen2;

  /// No description provided for @xtTr8ZBDpG.
  ///
  /// In en, this message translates to:
  /// **'XtTr8ZBDp-g'**
  String get xtTr8ZBDpG;

  /// No description provided for @dresmsNeverEnd.
  ///
  /// In en, this message translates to:
  /// **'去听旷野的风 Dresms Never End'**
  String get dresmsNeverEnd;

  /// No description provided for @mamaGo.
  ///
  /// In en, this message translates to:
  /// **'我的妈妈是校花 Mama Go!'**
  String get mamaGo;

  /// No description provided for @o4rwrV9yv0.
  ///
  /// In en, this message translates to:
  /// **'O4rwr_v9yv0'**
  String get o4rwrV9yv0;

  /// No description provided for @x5Cm37j3g0.
  ///
  /// In en, this message translates to:
  /// **'X5Cm37j_3g0'**
  String get x5Cm37j3g0;

  /// No description provided for @jTqQ3t6gg.
  ///
  /// In en, this message translates to:
  /// **'_jTqQ3t-6gg'**
  String get jTqQ3t6gg;

  /// No description provided for @cNIRYF7Ig4.
  ///
  /// In en, this message translates to:
  /// **'cNIR-yF7Ig4'**
  String get cNIRYF7Ig4;

  /// No description provided for @hr2GfDJNGg.
  ///
  /// In en, this message translates to:
  /// **'Hr2GfD-JNGg'**
  String get hr2GfDJNGg;

  /// No description provided for @yXXjFZcZw.
  ///
  /// In en, this message translates to:
  /// **'Y-X-xjFZcZw'**
  String get yXXjFZcZw;

  /// No description provided for @xrBNQazEsk.
  ///
  /// In en, this message translates to:
  /// **'xrBN-qazEsk'**
  String get xrBNQazEsk;

  /// No description provided for @fJDN8r3rcRw.
  ///
  /// In en, this message translates to:
  /// **'FJDN8r3rcRw'**
  String get fJDN8r3rcRw;

  /// No description provided for @jEXB1NMkHs.
  ///
  /// In en, this message translates to:
  /// **'JEXB1N-MkHs'**
  String get jEXB1NMkHs;

  /// No description provided for @d3dl69d81pQ.
  ///
  /// In en, this message translates to:
  /// **'D3dl69d81pQ'**
  String get d3dl69d81pQ;

  /// No description provided for @xGZPKLBH8Q.
  ///
  /// In en, this message translates to:
  /// **'XGZPK-LBH8Q'**
  String get xGZPKLBH8Q;

  /// No description provided for @x59A8sSoGs.
  ///
  /// In en, this message translates to:
  /// **'x59A8s-SoGs'**
  String get x59A8sSoGs;

  /// No description provided for @lo6iApMzI.
  ///
  /// In en, this message translates to:
  /// **'_lo6iAp-mzI'**
  String get lo6iApMzI;

  /// No description provided for @d4a9aQ7h18.
  ///
  /// In en, this message translates to:
  /// **'D4a9aQ7h1_8'**
  String get d4a9aQ7h18;

  /// No description provided for @zCt0on2nA9s.
  ///
  /// In en, this message translates to:
  /// **'ZCt0on2nA9s'**
  String get zCt0on2nA9s;

  /// No description provided for @b6BykN3fT4.
  ///
  /// In en, this message translates to:
  /// **'b6BykN3f-t4'**
  String get b6BykN3fT4;

  /// No description provided for @eMZrxHTajM.
  ///
  /// In en, this message translates to:
  /// **'EM-zrxHTajM'**
  String get eMZrxHTajM;

  /// No description provided for @t1RJnvl2RA.
  ///
  /// In en, this message translates to:
  /// **'T1RJnvl2R_A'**
  String get t1RJnvl2RA;

  /// No description provided for @hOE347NBAc.
  ///
  /// In en, this message translates to:
  /// **'hOE-347NBAc'**
  String get hOE347NBAc;

  /// No description provided for @loveStoryInThe1970s2.
  ///
  /// In en, this message translates to:
  /// **'《纯真年代的爱情 Love Story in the 1970s》双线编年史短片温暖来袭~'**
  String get loveStoryInThe1970s2;

  /// No description provided for @loveStoryInThe1970s3.
  ///
  /// In en, this message translates to:
  /// **'《纯真年代的爱情 Love Story in the 1970s》双人短片正式发布~让我们用感官书写一封情书'**
  String get loveStoryInThe1970s3;

  /// No description provided for @bTSLoveStoryInThe.
  ///
  /// In en, this message translates to:
  /// **'BTS｜全员杀青，期待下一次重逢【纯真年代的爱情 Love Story in the 1970s】'**
  String get bTSLoveStoryInThe;

  /// No description provided for @loveStoryInThe1970s4.
  ///
  /// In en, this message translates to:
  /// **'《纯真年代的爱情 Love Story in the 1970s》爱是藏在烟火里的诗～'**
  String get loveStoryInThe1970s4;

  /// No description provided for @sGX3zNIuzM.
  ///
  /// In en, this message translates to:
  /// **'SGX-3zNIuzM'**
  String get sGX3zNIuzM;

  /// No description provided for @loveStoryInThe1970s5.
  ///
  /// In en, this message translates to:
  /// **'《纯真年代的爱情 Love Story in the 1970s》正式定档2月21日播出啦~'**
  String get loveStoryInThe1970s5;

  /// No description provided for @dEZKlJqTo.
  ///
  /// In en, this message translates to:
  /// **'DE_ZKl_jqTo'**
  String get dEZKlJqTo;

  /// No description provided for @sc8aQLBntwk.
  ///
  /// In en, this message translates to:
  /// **'Sc8aQLBntwk'**
  String get sc8aQLBntwk;

  /// No description provided for @aDa3c9hGZA.
  ///
  /// In en, this message translates to:
  /// **'ADa_3c9hGZA'**
  String get aDa3c9hGZA;

  /// No description provided for @yj9xkfkxmpQ.
  ///
  /// In en, this message translates to:
  /// **'Yj9xkfkxmpQ'**
  String get yj9xkfkxmpQ;

  /// No description provided for @idjCqdRyYG.
  ///
  /// In en, this message translates to:
  /// **'idjCqdRyY-g'**
  String get idjCqdRyYG;

  /// No description provided for @sqwEl8o75U.
  ///
  /// In en, this message translates to:
  /// **'Sqw-El8o75U'**
  String get sqwEl8o75U;

  /// No description provided for @wbF6Wgzai4.
  ///
  /// In en, this message translates to:
  /// **'WbF-6Wgzai4'**
  String get wbF6Wgzai4;

  /// No description provided for @pLyX50Z72L2xpkH5SEO0XjQxJPO1sC.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2xpk_h5SEO0Xj_qx-jPO1sC'**
  String get pLyX50Z72L2xpkH5SEO0XjQxJPO1sC;

  /// No description provided for @theTruth.
  ///
  /// In en, this message translates to:
  /// **'风过留痕 The Truth'**
  String get theTruth;

  /// No description provided for @q4im6PPfcw.
  ///
  /// In en, this message translates to:
  /// **'Q4im6P_Pfcw'**
  String get q4im6PPfcw;

  /// No description provided for @tsyfcT6RG8.
  ///
  /// In en, this message translates to:
  /// **'Tsyfc-t6RG8'**
  String get tsyfcT6RG8;

  /// No description provided for @pHOAi3EJ6Cg.
  ///
  /// In en, this message translates to:
  /// **'PHOAi3EJ6Cg'**
  String get pHOAi3EJ6Cg;

  /// No description provided for @l2EHE50Bhlw.
  ///
  /// In en, this message translates to:
  /// **'L2EHE50Bhlw'**
  String get l2EHE50Bhlw;

  /// No description provided for @pVgnsUnNXw.
  ///
  /// In en, this message translates to:
  /// **'PVgnsUnN-Xw'**
  String get pVgnsUnNXw;

  /// No description provided for @pLyX50Z72L2wsEVLZsclrIke3z7FY8n.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2wsEVL-zsclrIke3z7F-Y8n'**
  String get pLyX50Z72L2wsEVLZsclrIke3z7FY8n;

  /// No description provided for @ugNrNd0OM8.
  ///
  /// In en, this message translates to:
  /// **'Ug_nrNd0OM8'**
  String get ugNrNd0OM8;

  /// No description provided for @b4hADbXtGo.
  ///
  /// In en, this message translates to:
  /// **'b4hADb-xtGo'**
  String get b4hADbXtGo;

  /// No description provided for @rQXFQTj6XY.
  ///
  /// In en, this message translates to:
  /// **'RQ_XFQTj6XY'**
  String get rQXFQTj6XY;

  /// No description provided for @a6TSVxp9x0.
  ///
  /// In en, this message translates to:
  /// **'A6TS_Vxp9x0'**
  String get a6TSVxp9x0;

  /// No description provided for @gwt9Y2ESIOA.
  ///
  /// In en, this message translates to:
  /// **'Gwt9Y2ESIOA'**
  String get gwt9Y2ESIOA;

  /// No description provided for @c2tVD8rhVMM.
  ///
  /// In en, this message translates to:
  /// **'C2tVD8rhVMM'**
  String get c2tVD8rhVMM;

  /// No description provided for @pLyX50Z72L2wshCDZ4cWBwWHjigU7av.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2wshCDZ4cW-BwWHjigU7av-'**
  String get pLyX50Z72L2wshCDZ4cWBwWHjigU7av;

  /// No description provided for @tW5f69bxL0.
  ///
  /// In en, this message translates to:
  /// **'TW_5f69bxL0'**
  String get tW5f69bxL0;

  /// No description provided for @l8T7Lz5VN44.
  ///
  /// In en, this message translates to:
  /// **'L8T7Lz5VN44'**
  String get l8T7Lz5VN44;

  /// No description provided for @cVLZ3AmkTE.
  ///
  /// In en, this message translates to:
  /// **'-cVLZ3AmkTE'**
  String get cVLZ3AmkTE;

  /// No description provided for @t4E2lf096yM.
  ///
  /// In en, this message translates to:
  /// **'T4E2lf096yM'**
  String get t4E2lf096yM;

  /// No description provided for @wHENTJCl9M.
  ///
  /// In en, this message translates to:
  /// **'WHENTJCl9-M'**
  String get wHENTJCl9M;

  /// No description provided for @bTSOutOfCharacterDuo.
  ///
  /// In en, this message translates to:
  /// **'BTS｜「Out of Character Duo Interview 」出戏双彩—高总和欢儿的抽象究竟谁更甚一筹？ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场'**
  String get bTSOutOfCharacterDuo;

  /// No description provided for @rEk9xALNODE.
  ///
  /// In en, this message translates to:
  /// **'REk9xALNODE'**
  String get rEk9xALNODE;

  /// No description provided for @label04MyPageInThe2.
  ///
  /// In en, this message translates to:
  /// **'精彩片段04 离谱系统强行加戏！纸巾变卫生棉？这下尴尬大了！ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场'**
  String get label04MyPageInThe2;

  /// No description provided for @label03MyPageInThe2.
  ///
  /// In en, this message translates to:
  /// **'精彩片段03 替闺蜜去相亲，结果相到了男主本尊？ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场'**
  String get label03MyPageInThe2;

  /// No description provided for @xsb7BJppy0.
  ///
  /// In en, this message translates to:
  /// **'Xsb7B-Jppy0'**
  String get xsb7BJppy0;

  /// No description provided for @label02MyPageInThe2.
  ///
  /// In en, this message translates to:
  /// **'精彩片段02 本想攻略男主，结果竟然认错人？ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场'**
  String get label02MyPageInThe2;

  /// No description provided for @label01MyPageInThe2.
  ///
  /// In en, this message translates to:
  /// **'精彩片段01 离谱！突然就穿书了？这剧情我该怎么演? 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场'**
  String get label01MyPageInThe2;

  /// No description provided for @zSpXoH9ok.
  ///
  /// In en, this message translates to:
  /// **'Z_SpXo-H9ok'**
  String get zSpXoH9ok;

  /// No description provided for @myPageInThe90s5.
  ///
  /// In en, this message translates to:
  /// **'《突然的喜欢 My Page in the 90s》BTS｜陈星旭王玉雯溜冰撞了个满'**
  String get myPageInThe90s5;

  /// No description provided for @myPageInThe90s6.
  ///
  /// In en, this message translates to:
  /// **'《突然的喜欢 My Page in the 90s》今日开播！陈星旭王玉雯玩转系统甜蜜热恋'**
  String get myPageInThe90s6;

  /// No description provided for @bTSMyPageInThe5.
  ///
  /// In en, this message translates to:
  /// **'BTS｜陈星旭王玉雯搞怪互动暧昧超标【突然的喜欢 My Page in the 90s】'**
  String get bTSMyPageInThe5;

  /// No description provided for @aYyrt0eGYw.
  ///
  /// In en, this message translates to:
  /// **'AYyrt0e-gYw'**
  String get aYyrt0eGYw;

  /// No description provided for @qM5S5tiCI0.
  ///
  /// In en, this message translates to:
  /// **'QM_5S5tiCI0'**
  String get qM5S5tiCI0;

  /// No description provided for @w1mYTU1AGkg.
  ///
  /// In en, this message translates to:
  /// **'W1mYTU1AGkg'**
  String get w1mYTU1AGkg;

  /// No description provided for @pLyX50Z72L2zuddUfGdIXCxO1jAzTlPd.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2zudd-ufGdIXCxO1jAzTlPd'**
  String get pLyX50Z72L2zuddUfGdIXCxO1jAzTlPd;

  /// No description provided for @jWEK0M59Ysk.
  ///
  /// In en, this message translates to:
  /// **'JWEK0M59Ysk'**
  String get jWEK0M59Ysk;

  /// No description provided for @p6l7C0ovRFM.
  ///
  /// In en, this message translates to:
  /// **'P6l7C0ovRFM'**
  String get p6l7C0ovRFM;

  /// No description provided for @vRYp5JmLwc.
  ///
  /// In en, this message translates to:
  /// **'-vRYp5JmLwc'**
  String get vRYp5JmLwc;

  /// No description provided for @dearSecretary.
  ///
  /// In en, this message translates to:
  /// **'我亲爱的秘书 Dear Secretary'**
  String get dearSecretary;

  /// No description provided for @pAoESWUjrI.
  ///
  /// In en, this message translates to:
  /// **'PAoES-wUjrI'**
  String get pAoESWUjrI;

  /// No description provided for @pLyX50Z72L2yOG39wBXIFJlA2GtbWheA.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2yOG39wBXIFJlA-2GtbWheA'**
  String get pLyX50Z72L2yOG39wBXIFJlA2GtbWheA;

  /// No description provided for @label0JQ43Tt8D4.
  ///
  /// In en, this message translates to:
  /// **'0J-q43Tt8D4'**
  String get label0JQ43Tt8D4;

  /// No description provided for @lIJJXYywPM.
  ///
  /// In en, this message translates to:
  /// **'LIJ-jXYywPM'**
  String get lIJJXYywPM;

  /// No description provided for @xLc3qBC5k.
  ///
  /// In en, this message translates to:
  /// **'XLc3qB_c-5k'**
  String get xLc3qBC5k;

  /// No description provided for @mKLZpubV04.
  ///
  /// In en, this message translates to:
  /// **'MKL_zpubV04'**
  String get mKLZpubV04;

  /// No description provided for @wXevXICxAQ.
  ///
  /// In en, this message translates to:
  /// **'wXevXICx-AQ'**
  String get wXevXICxAQ;

  /// No description provided for @xRRUT4fbgQ.
  ///
  /// In en, this message translates to:
  /// **'xRR-uT4fbgQ'**
  String get xRRUT4fbgQ;

  /// No description provided for @q5WMmVzsGQ.
  ///
  /// In en, this message translates to:
  /// **'q5-wMmVzsGQ'**
  String get q5WMmVzsGQ;

  /// No description provided for @dOFDys0lAJ0.
  ///
  /// In en, this message translates to:
  /// **'DOFDys0lAJ0'**
  String get dOFDys0lAJ0;

  /// No description provided for @wadaICY1qo.
  ///
  /// In en, this message translates to:
  /// **'WadaIC-Y1qo'**
  String get wadaICY1qo;

  /// No description provided for @label44PA4p4dXY.
  ///
  /// In en, this message translates to:
  /// **'44P-a4p4dXY'**
  String get label44PA4p4dXY;

  /// No description provided for @pLyX50Z72L2xbAikt1CHmEyvZrQv1XJu.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2xbAikt1CHmEyvZrQv1X-ju'**
  String get pLyX50Z72L2xbAikt1CHmEyvZrQv1XJu;

  /// No description provided for @foreverYoung2.
  ///
  /// In en, this message translates to:
  /// **'轻年 Forever Young'**
  String get foreverYoung2;

  /// No description provided for @omVSnG9O8g.
  ///
  /// In en, this message translates to:
  /// **'omVSn-G9O8g'**
  String get omVSnG9O8g;

  /// No description provided for @label2qKWcz2zU0.
  ///
  /// In en, this message translates to:
  /// **'2qKWcz2z-u0'**
  String get label2qKWcz2zU0;

  /// No description provided for @label1WMYcdS8oE.
  ///
  /// In en, this message translates to:
  /// **'1WMYcdS8o-E'**
  String get label1WMYcdS8oE;

  /// No description provided for @u0fCO4W9LHg.
  ///
  /// In en, this message translates to:
  /// **'U0fCO4W9LHg'**
  String get u0fCO4W9LHg;

  /// No description provided for @m9xLRZlwO.
  ///
  /// In en, this message translates to:
  /// **'M9xL-rZlw-o'**
  String get m9xLRZlwO;

  /// No description provided for @vo5jCUWPNAo.
  ///
  /// In en, this message translates to:
  /// **'Vo5jCUWPNAo'**
  String get vo5jCUWPNAo;

  /// No description provided for @vb1N5r3zZFo.
  ///
  /// In en, this message translates to:
  /// **'Vb1N5r3zZFo'**
  String get vb1N5r3zZFo;

  /// No description provided for @lightOfDawn.
  ///
  /// In en, this message translates to:
  /// **'人之初 Light of Dawn​'**
  String get lightOfDawn;

  /// No description provided for @teDx70IJcw.
  ///
  /// In en, this message translates to:
  /// **'Te_dx70IJcw'**
  String get teDx70IJcw;

  /// No description provided for @mF2299T610.
  ///
  /// In en, this message translates to:
  /// **'mF2299T-610'**
  String get mF2299T610;

  /// No description provided for @yLNGIsWlU.
  ///
  /// In en, this message translates to:
  /// **'YL_-NGIsWlU'**
  String get yLNGIsWlU;

  /// No description provided for @mUZMDrFnNw.
  ///
  /// In en, this message translates to:
  /// **'MUZMDrFn-Nw'**
  String get mUZMDrFnNw;

  /// No description provided for @pi2b8VYkM8.
  ///
  /// In en, this message translates to:
  /// **'Pi2b8VYk-m8'**
  String get pi2b8VYkM8;

  /// No description provided for @pLyX50Z72L2xDQ9d02geVDYSbkol6u9Z.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2xDQ9d02geVDYSbkol-6u9Z'**
  String get pLyX50Z72L2xDQ9d02geVDYSbkol6u9Z;

  /// No description provided for @wWy3IO1E9cw.
  ///
  /// In en, this message translates to:
  /// **'WWy3IO1E9cw'**
  String get wWy3IO1E9cw;

  /// No description provided for @wW9DI00Rx3w.
  ///
  /// In en, this message translates to:
  /// **'WW9DI00Rx3w'**
  String get wW9DI00Rx3w;

  /// No description provided for @a6Y3wzD0I.
  ///
  /// In en, this message translates to:
  /// **'A_6Y3wzD-0I'**
  String get a6Y3wzD0I;

  /// No description provided for @wXEkwsviSA.
  ///
  /// In en, this message translates to:
  /// **'-WXEkwsviSA'**
  String get wXEkwsviSA;

  /// No description provided for @uq15J34lYB0.
  ///
  /// In en, this message translates to:
  /// **'Uq15J34lYB0'**
  String get uq15J34lYB0;

  /// No description provided for @sc7Fg23kmUM.
  ///
  /// In en, this message translates to:
  /// **'Sc7Fg23kmUM'**
  String get sc7Fg23kmUM;

  /// No description provided for @kaJ2rw9Aqk.
  ///
  /// In en, this message translates to:
  /// **'ka-j2rw9Aqk'**
  String get kaJ2rw9Aqk;

  /// No description provided for @uLnBQ3TFuc.
  ///
  /// In en, this message translates to:
  /// **'ULnBQ3-TFuc'**
  String get uLnBQ3TFuc;

  /// No description provided for @t2Iwb6RA1A.
  ///
  /// In en, this message translates to:
  /// **'T2Iwb6-RA1A'**
  String get t2Iwb6RA1A;

  /// No description provided for @mug6zYTLTlc.
  ///
  /// In en, this message translates to:
  /// **'Mug6zYTLTlc'**
  String get mug6zYTLTlc;

  /// No description provided for @n2FDS8D8uu4.
  ///
  /// In en, this message translates to:
  /// **'N2FDS8D8uu4'**
  String get n2FDS8D8uu4;

  /// No description provided for @s8lCa09LCr8.
  ///
  /// In en, this message translates to:
  /// **'S8lCa09LCr8'**
  String get s8lCa09LCr8;

  /// No description provided for @cU6u6WUM.
  ///
  /// In en, this message translates to:
  /// **'C-u6u_6-WUM'**
  String get cU6u6WUM;

  /// No description provided for @oNNJqZYydM.
  ///
  /// In en, this message translates to:
  /// **'ONN-JqZYydM'**
  String get oNNJqZYydM;

  /// No description provided for @sniperButterfly.
  ///
  /// In en, this message translates to:
  /// **'狙击蝴蝶 Sniper Butterfly'**
  String get sniperButterfly;

  /// No description provided for @zExesh1IRe4.
  ///
  /// In en, this message translates to:
  /// **'ZExesh1IRe4'**
  String get zExesh1IRe4;

  /// No description provided for @ygyiJvBu0.
  ///
  /// In en, this message translates to:
  /// **'ygyi-JvBu-0'**
  String get ygyiJvBu0;

  /// No description provided for @label8lAlJTtlQw.
  ///
  /// In en, this message translates to:
  /// **'8lAlJ-ttlQw'**
  String get label8lAlJTtlQw;

  /// No description provided for @oi4cSib0SMU.
  ///
  /// In en, this message translates to:
  /// **'Oi4cSib0SMU'**
  String get oi4cSib0SMU;

  /// No description provided for @gBZIZ1syhRw.
  ///
  /// In en, this message translates to:
  /// **'GBZIZ1syhRw'**
  String get gBZIZ1syhRw;

  /// No description provided for @yOIsab02PVs.
  ///
  /// In en, this message translates to:
  /// **'YOIsab02PVs'**
  String get yOIsab02PVs;

  /// No description provided for @y3OhRM7dJg.
  ///
  /// In en, this message translates to:
  /// **'Y3Oh_RM7dJg'**
  String get y3OhRM7dJg;

  /// No description provided for @bqvORbC4cY.
  ///
  /// In en, this message translates to:
  /// **'BqvORbC4c-Y'**
  String get bqvORbC4cY;

  /// No description provided for @iE8MjgoaPY.
  ///
  /// In en, this message translates to:
  /// **'IE8Mjgoa-pY'**
  String get iE8MjgoaPY;

  /// No description provided for @sniperButterfly1204.
  ///
  /// In en, this message translates to:
  /// **'《狙击蝴蝶 Sniper Butterfly》定档1204！ 为爱越界'**
  String get sniperButterfly1204;

  /// No description provided for @sniperButterflyFullVersion1.
  ///
  /// In en, this message translates to:
  /// **'《狙击蝴蝶 Sniper Butterfly》Full Version 1-15｜主演：陈妍希，周柯宇 腾讯视频-青春剧场'**
  String get sniperButterflyFullVersion1;

  /// No description provided for @sniperButterflyFullVersion16.
  ///
  /// In en, this message translates to:
  /// **'《狙击蝴蝶 Sniper Butterfly》Full Version 16-30｜主演：陈妍希，周柯宇 腾讯视频-青春剧场'**
  String get sniperButterflyFullVersion16;

  /// No description provided for @imr0DFA4mNA.
  ///
  /// In en, this message translates to:
  /// **'Imr0DFA4mNA'**
  String get imr0DFA4mNA;

  /// No description provided for @iVGn2RlvnG.
  ///
  /// In en, this message translates to:
  /// **'IVGn2Rlvn_g'**
  String get iVGn2RlvnG;

  /// No description provided for @dIhValICo.
  ///
  /// In en, this message translates to:
  /// **'dIh-Val_ICo'**
  String get dIhValICo;

  /// No description provided for @u3CEzhnlaM.
  ///
  /// In en, this message translates to:
  /// **'U3C-EzhnlaM'**
  String get u3CEzhnlaM;

  /// No description provided for @bJ3HUIXyu04.
  ///
  /// In en, this message translates to:
  /// **'BJ3HUIXyu04'**
  String get bJ3HUIXyu04;

  /// No description provided for @g9lIyw6LKr8.
  ///
  /// In en, this message translates to:
  /// **'G9lIyw6LKr8'**
  String get g9lIyw6LKr8;

  /// No description provided for @xQhtl58Mg0.
  ///
  /// In en, this message translates to:
  /// **'x-qhtl58Mg0'**
  String get xQhtl58Mg0;

  /// No description provided for @emRj53N7q0.
  ///
  /// In en, this message translates to:
  /// **'emRj53N7q-0'**
  String get emRj53N7q0;

  /// No description provided for @g4LSe3sjJ1I.
  ///
  /// In en, this message translates to:
  /// **'G4LSe3sjJ1I'**
  String get g4LSe3sjJ1I;

  /// No description provided for @label7PpYIVmyaU.
  ///
  /// In en, this message translates to:
  /// **'7PpYI-vmyaU'**
  String get label7PpYIVmyaU;

  /// No description provided for @allRise.
  ///
  /// In en, this message translates to:
  /// **'即刻上场 All Rise'**
  String get allRise;

  /// No description provided for @label9AaKDIWNK8.
  ///
  /// In en, this message translates to:
  /// **'-9AaKDIWNK8'**
  String get label9AaKDIWNK8;

  /// No description provided for @cIY8AALMGA.
  ///
  /// In en, this message translates to:
  /// **'cIY8AAL-MGA'**
  String get cIY8AALMGA;

  /// No description provided for @mwHNJlgj0M.
  ///
  /// In en, this message translates to:
  /// **'-MwHNJlgj0M'**
  String get mwHNJlgj0M;

  /// No description provided for @lM6Siyziyfg.
  ///
  /// In en, this message translates to:
  /// **'LM6Siyziyfg'**
  String get lM6Siyziyfg;

  /// No description provided for @yUgNvqLkHo.
  ///
  /// In en, this message translates to:
  /// **'Y-ugNvqLkHo'**
  String get yUgNvqLkHo;

  /// No description provided for @loveIsAlwaysOnline2.
  ///
  /// In en, this message translates to:
  /// **'对的时间对的人 Love is Always Online'**
  String get loveIsAlwaysOnline2;

  /// No description provided for @bbu8Ct33WGY.
  ///
  /// In en, this message translates to:
  /// **'Bbu8Ct33WGY'**
  String get bbu8Ct33WGY;

  /// No description provided for @iW8gQdPQE.
  ///
  /// In en, this message translates to:
  /// **'iW-8g-qdPQE'**
  String get iW8gQdPQE;

  /// No description provided for @zKjqrbqqc74.
  ///
  /// In en, this message translates to:
  /// **'ZKjqrbqqc74'**
  String get zKjqrbqqc74;

  /// No description provided for @label1UbEkGEXNs.
  ///
  /// In en, this message translates to:
  /// **'1UbEkGE-xNs'**
  String get label1UbEkGEXNs;

  /// No description provided for @w8eDA1UJ5OY.
  ///
  /// In en, this message translates to:
  /// **'W8eDA1UJ5OY'**
  String get w8eDA1UJ5OY;

  /// No description provided for @hydT2kHzno.
  ///
  /// In en, this message translates to:
  /// **'-hydT2kHzno'**
  String get hydT2kHzno;

  /// No description provided for @fONOKBq7bLo.
  ///
  /// In en, this message translates to:
  /// **'FONOKBq7bLo'**
  String get fONOKBq7bLo;

  /// No description provided for @s4zCx2IlFE.
  ///
  /// In en, this message translates to:
  /// **'s4zCx2Il-fE'**
  String get s4zCx2IlFE;

  /// No description provided for @bA13fouCls.
  ///
  /// In en, this message translates to:
  /// **'BA_13fouCls'**
  String get bA13fouCls;

  /// No description provided for @pLyX50Z72L2xw1E6HhmF968YkX7BlZ9.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2xw1-e6HhmF968YkX7Bl_Z9'**
  String get pLyX50Z72L2xw1E6HhmF968YkX7BlZ9;

  /// No description provided for @loveOnTheTurquoiseLand.
  ///
  /// In en, this message translates to:
  /// **'枭起青壤 Love on the Turquoise Land'**
  String get loveOnTheTurquoiseLand;

  /// No description provided for @we5ry5kxdHE.
  ///
  /// In en, this message translates to:
  /// **'We5ry5kxdHE'**
  String get we5ry5kxdHE;

  /// No description provided for @emIUEma8Hg.
  ///
  /// In en, this message translates to:
  /// **'EmIUEma-8Hg'**
  String get emIUEma8Hg;

  /// No description provided for @wu6k5Xa3MM.
  ///
  /// In en, this message translates to:
  /// **'Wu-6k5Xa3MM'**
  String get wu6k5Xa3MM;

  /// No description provided for @label80SA571cW0.
  ///
  /// In en, this message translates to:
  /// **'80-SA571cW0'**
  String get label80SA571cW0;

  /// No description provided for @label4PdR5JPhcY.
  ///
  /// In en, this message translates to:
  /// **'4Pd-R5JPhcY'**
  String get label4PdR5JPhcY;

  /// No description provided for @fyB12Rr0V8.
  ///
  /// In en, this message translates to:
  /// **'fyB12-Rr0V8'**
  String get fyB12Rr0V8;

  /// No description provided for @ldKl7dOoRs.
  ///
  /// In en, this message translates to:
  /// **'ld-Kl7dOoRs'**
  String get ldKl7dOoRs;

  /// No description provided for @label3xjBMrz6iC.
  ///
  /// In en, this message translates to:
  /// **'3xjBMrz6i-c'**
  String get label3xjBMrz6iC;

  /// No description provided for @vt0403FhEU.
  ///
  /// In en, this message translates to:
  /// **'Vt0403Fh-eU'**
  String get vt0403FhEU;

  /// No description provided for @eCcqo2QsOI.
  ///
  /// In en, this message translates to:
  /// **'ECcqo2Qs-OI'**
  String get eCcqo2QsOI;

  /// No description provided for @syI7F7W2c8.
  ///
  /// In en, this message translates to:
  /// **'Sy-i7F7W2c8'**
  String get syI7F7W2c8;

  /// No description provided for @vxTWyvL1Ms.
  ///
  /// In en, this message translates to:
  /// **'VxTWyvL-1Ms'**
  String get vxTWyvL1Ms;

  /// No description provided for @yw8QK3SuW.
  ///
  /// In en, this message translates to:
  /// **'yw8QK-3Su-w'**
  String get yw8QK3SuW;

  /// No description provided for @o16uHD0kTS.
  ///
  /// In en, this message translates to:
  /// **'O16uHD0kT-s'**
  String get o16uHD0kTS;

  /// No description provided for @nHx9DZl4Q.
  ///
  /// In en, this message translates to:
  /// **'nHx9-D-Zl4Q'**
  String get nHx9DZl4Q;

  /// No description provided for @wMJrWKUN7w.
  ///
  /// In en, this message translates to:
  /// **'-WMJrWKUN7w'**
  String get wMJrWKUN7w;

  /// No description provided for @s9JU0L2RS4o.
  ///
  /// In en, this message translates to:
  /// **'S9JU0L2RS4o'**
  String get s9JU0L2RS4o;

  /// No description provided for @uJC6xna2PBM.
  ///
  /// In en, this message translates to:
  /// **'UJC6xna2PBM'**
  String get uJC6xna2PBM;

  /// No description provided for @rbvdnADd18.
  ///
  /// In en, this message translates to:
  /// **'Rbvdn-ADd18'**
  String get rbvdnADd18;

  /// No description provided for @iHHlxN0Swo.
  ///
  /// In en, this message translates to:
  /// **'i-HHlxN0Swo'**
  String get iHHlxN0Swo;

  /// No description provided for @zd8EBbfqs.
  ///
  /// In en, this message translates to:
  /// **'Zd8_-EBbfqs'**
  String get zd8EBbfqs;

  /// No description provided for @xUG53k1B4.
  ///
  /// In en, this message translates to:
  /// **'XUG_53k1-b4'**
  String get xUG53k1B4;

  /// No description provided for @whyIsHeStillSingle2.
  ///
  /// In en, this message translates to:
  /// **'《他为什么依然单身 Why Is He Still Single》定档1116！霍建华朱珠熟龄男女的爱情童话有！'**
  String get whyIsHeStillSingle2;

  /// No description provided for @whyIsHeStillSingle3.
  ///
  /// In en, this message translates to:
  /// **'《他为什么依然单身 Why Is He Still Single》Full Version｜主演：霍建华，朱珠 腾讯视频-青春剧场'**
  String get whyIsHeStillSingle3;

  /// No description provided for @ijgFlHRPHw.
  ///
  /// In en, this message translates to:
  /// **'Ijg-FlHRPHw'**
  String get ijgFlHRPHw;

  /// No description provided for @whyIsHeStillSingle4.
  ///
  /// In en, this message translates to:
  /// **'《他为什么依然单身 Why Is He Still Single》Full Version 1｜主演：霍建华，朱珠 腾讯视频-青春剧场'**
  String get whyIsHeStillSingle4;

  /// No description provided for @whyIsHeStillSingle5.
  ///
  /// In en, this message translates to:
  /// **'《他为什么依然单身 Why Is He Still Single》Full Version 2｜主演：霍建华，朱珠 腾讯视频-青春剧场'**
  String get whyIsHeStillSingle5;

  /// No description provided for @yVGKe9xonY.
  ///
  /// In en, this message translates to:
  /// **'YV-GKe9xonY'**
  String get yVGKe9xonY;

  /// No description provided for @qKftsk37mXo.
  ///
  /// In en, this message translates to:
  /// **'QKftsk37mXo'**
  String get qKftsk37mXo;

  /// No description provided for @ccxy931pac.
  ///
  /// In en, this message translates to:
  /// **'ccxy9-31pac'**
  String get ccxy931pac;

  /// No description provided for @uc5hawjBFU.
  ///
  /// In en, this message translates to:
  /// **'Uc5hawj_bFU'**
  String get uc5hawjBFU;

  /// No description provided for @fightForLove.
  ///
  /// In en, this message translates to:
  /// **'山河枕 Fight for Love'**
  String get fightForLove;

  /// No description provided for @lGP6TCHM.
  ///
  /// In en, this message translates to:
  /// **'l_g-p6TC_hM'**
  String get lGP6TCHM;

  /// No description provided for @wXKMI7kmY3Y.
  ///
  /// In en, this message translates to:
  /// **'WXKMI7kmY3Y'**
  String get wXKMI7kmY3Y;

  /// No description provided for @v0wqy1HUJJE.
  ///
  /// In en, this message translates to:
  /// **'V0wqy1HUJJE'**
  String get v0wqy1HUJJE;

  /// No description provided for @j24dJWDtyps.
  ///
  /// In en, this message translates to:
  /// **'J24dJWDtyps'**
  String get j24dJWDtyps;

  /// No description provided for @v937gFLg7QU.
  ///
  /// In en, this message translates to:
  /// **'V937gFLg7QU'**
  String get v937gFLg7QU;

  /// No description provided for @x4R4W9wwzY.
  ///
  /// In en, this message translates to:
  /// **'x4R-4W9wwzY'**
  String get x4R4W9wwzY;

  /// No description provided for @jV9KYnyvsg.
  ///
  /// In en, this message translates to:
  /// **'jV9-kYnyvsg'**
  String get jV9KYnyvsg;

  /// No description provided for @hQPFMP7zQO0.
  ///
  /// In en, this message translates to:
  /// **'HQPFMP7zQO0'**
  String get hQPFMP7zQO0;

  /// No description provided for @pLyX50Z72L2wHtPGkazV4LCGl20kRY4.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2w_HtPGkazV4-lCGl20kRY4'**
  String get pLyX50Z72L2wHtPGkazV4LCGl20kRY4;

  /// No description provided for @iMNobody.
  ///
  /// In en, this message translates to:
  /// **'我本无名  I\'m Nobody'**
  String get iMNobody;

  /// No description provided for @persona.
  ///
  /// In en, this message translates to:
  /// **'重影 Persona'**
  String get persona;

  /// No description provided for @d5CPVc0EIY.
  ///
  /// In en, this message translates to:
  /// **'D5CPVc0E-IY'**
  String get d5CPVc0EIY;

  /// No description provided for @pJsHXm9ZsC.
  ///
  /// In en, this message translates to:
  /// **'pJsHXm9Zs-c'**
  String get pJsHXm9ZsC;

  /// No description provided for @vYRvNE7Yk.
  ///
  /// In en, this message translates to:
  /// **'-VYRvNE-7Yk'**
  String get vYRvNE7Yk;

  /// No description provided for @lightBeyondTheReed.
  ///
  /// In en, this message translates to:
  /// **'余生有涯 Light Beyond the Reed'**
  String get lightBeyondTheReed;

  /// No description provided for @kqfhRrmmG.
  ///
  /// In en, this message translates to:
  /// **'Kqfh_Rrmm_g'**
  String get kqfhRrmmG;

  /// No description provided for @iKEYUsv14.
  ///
  /// In en, this message translates to:
  /// **'I-kE-YUsv14'**
  String get iKEYUsv14;

  /// No description provided for @hOC9mu9HVs.
  ///
  /// In en, this message translates to:
  /// **'HOC9mu_9HVs'**
  String get hOC9mu9HVs;

  /// No description provided for @x8jqt87WIuo.
  ///
  /// In en, this message translates to:
  /// **'X8jqt87WIuo'**
  String get x8jqt87WIuo;

  /// No description provided for @gb0Bk564EQ.
  ///
  /// In en, this message translates to:
  /// **'gb0Bk564-EQ'**
  String get gb0Bk564EQ;

  /// No description provided for @thePrisonerOfBeauty.
  ///
  /// In en, this message translates to:
  /// **'折腰精简版 The Prisoner of Beauty'**
  String get thePrisonerOfBeauty;

  /// No description provided for @wsGeYBRO.
  ///
  /// In en, this message translates to:
  /// **'wsGeYB_-r_o'**
  String get wsGeYBRO;

  /// No description provided for @thePrisonerOfBeauty2.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》小乔替姐嫁世仇，新婚头天就和夫君杠上了｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty2;

  /// No description provided for @thePrisonerOfBeauty3.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》小乔破刘琰炸渠阴谋，和魏劭从死磕变互相护着｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty3;

  /// No description provided for @thePrisonerOfBeauty4.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》小乔装病争主院，魏劭当众护妻拒纳妾｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty4;

  /// No description provided for @thePrisonerOfBeauty5.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》小乔破了木匣栽赃局，魏劭认她是自家女君了｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty5;

  /// No description provided for @thePrisonerOfBeauty6.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》小乔智破嫁祸局，魏劭认妻护妻婆媳掀桌｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty6;

  /// No description provided for @thePrisonerOfBeauty7.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》魏俨挑事传假信，小乔魏劭因玉坠闹信任危机｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty7;

  /// No description provided for @thePrisonerOfBeauty8.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》苏娥皇用熟麦坑小乔，魏劭护妻破案俩人更亲｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty8;

  /// No description provided for @thePrisonerOfBeauty9.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》小乔魏劭遇刺中毒，小乔智破阴谋救夫更亲｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty9;

  /// No description provided for @rNYFWNcb8o.
  ///
  /// In en, this message translates to:
  /// **'RNYFW-Ncb8o'**
  String get rNYFWNcb8o;

  /// No description provided for @thePrisonerOfBeauty10.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》魏劭送战马后补发簪，护妻失踪急得抓耳挠腮｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty10;

  /// No description provided for @thePrisonerOfBeauty11.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》魏劭怕小乔跑了吃醋护妻，搬出又后悔想她｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty11;

  /// No description provided for @thePrisonerOfBeauty12.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》魏劭吃醋背小乔，解木匣疑云俩人更亲｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty12;

  /// No description provided for @thePrisonerOfBeauty13.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》乔慈探姐引魏劭吃醋，小乔俩口子掏心定终身｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty13;

  /// No description provided for @thePrisonerOfBeauty14.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》魏俨为小乔离乡，劭乔吵架后和好｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty14;

  /// No description provided for @ry1BWClaV0.
  ///
  /// In en, this message translates to:
  /// **'ry1BWCla-V0'**
  String get ry1BWClaV0;

  /// No description provided for @thePrisonerOfBeauty15.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》新婚夜兵变姐妹反目，小乔智退敌魏劭认错｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty15;

  /// No description provided for @o8nFcvzyvM.
  ///
  /// In en, this message translates to:
  /// **'O8n-FcvzyvM'**
  String get o8nFcvzyvM;

  /// No description provided for @thePrisonerOfBeauty16.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》魏劭陪小乔回康郡解心结，乔父认婿俩口子圆房｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty16;

  /// No description provided for @krsrk6wSAy8.
  ///
  /// In en, this message translates to:
  /// **'Krsrk6wSAy8'**
  String get krsrk6wSAy8;

  /// No description provided for @thePrisonerOfBeauty17.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》乔越叛变魏梁丧命，大乔被劫比彘拼命反杀｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty17;

  /// No description provided for @v26fn6w270.
  ///
  /// In en, this message translates to:
  /// **'V-26fn6w270'**
  String get v26fn6w270;

  /// No description provided for @thePrisonerOfBeauty18.
  ///
  /// In en, this message translates to:
  /// **'《折腰精简版 The Prisoner of Beauty》魏梁战死魏渠断臂，大乔坠楼刘琰覆灭｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场'**
  String get thePrisonerOfBeauty18;

  /// No description provided for @pLyX50Z72L2zD8aIumtBOoc0OWrwUUSe.
  ///
  /// In en, this message translates to:
  /// **'PLyX_50Z72L2zD-8aIumtBOoc0OWrwUUSe'**
  String get pLyX50Z72L2zD8aIumtBOoc0OWrwUUSe;

  /// No description provided for @ahjr3KPEXv4.
  ///
  /// In en, this message translates to:
  /// **'Ahjr3KPEXv4'**
  String get ahjr3KPEXv4;

  /// No description provided for @igijfp2Q8BY.
  ///
  /// In en, this message translates to:
  /// **'Igijfp2Q8BY'**
  String get igijfp2Q8BY;

  /// No description provided for @kIy3O9LyJQ.
  ///
  /// In en, this message translates to:
  /// **'kIy3-o9LyJQ'**
  String get kIy3O9LyJQ;

  /// No description provided for @g40pz8IOI.
  ///
  /// In en, this message translates to:
  /// **'G-40pz8I_oI'**
  String get g40pz8IOI;

  /// No description provided for @label4LTdKzOI54.
  ///
  /// In en, this message translates to:
  /// **'4LTdKzO-I54'**
  String get label4LTdKzOI54;

  /// No description provided for @pPT.
  ///
  /// In en, this message translates to:
  /// **'小组作业嫌我慢？霸总半夜爬窗送PPT，保安追着他跑 腾讯视频-青春剧场'**
  String get pPT;

  /// No description provided for @zPBZ1KRQ3hY.
  ///
  /// In en, this message translates to:
  /// **'ZPBZ1KRQ3hY'**
  String get zPBZ1KRQ3hY;

  /// No description provided for @aThousandMilesToYour.
  ///
  /// In en, this message translates to:
  /// **'过遍千城才识君 A Thousand Miles to Your Heart'**
  String get aThousandMilesToYour;

  /// No description provided for @getTheWeTVAPP4.
  ///
  /// In en, this message translates to:
  /// **'腾讯视频 - 古装剧场 - Get the WeTV APP'**
  String get getTheWeTVAPP4;

  /// No description provided for @jnz1S8Qb5xE.
  ///
  /// In en, this message translates to:
  /// **'Jnz1S8Qb5xE'**
  String get jnz1S8Qb5xE;

  /// No description provided for @nf5tvYU1W5A.
  ///
  /// In en, this message translates to:
  /// **'Nf5tvYU1W5A'**
  String get nf5tvYU1W5A;

  /// No description provided for @jRzsIK84C0.
  ///
  /// In en, this message translates to:
  /// **'jRzsIK84C-0'**
  String get jRzsIK84C0;

  /// No description provided for @label9TcXQyaUAC.
  ///
  /// In en, this message translates to:
  /// **'9TcXQyaUA-c'**
  String get label9TcXQyaUAC;

  /// No description provided for @mG6d7wN6fg.
  ///
  /// In en, this message translates to:
  /// **'M-g6d7wN6fg'**
  String get mG6d7wN6fg;

  /// No description provided for @theInescapable.
  ///
  /// In en, this message translates to:
  /// **'锁簪 The Inescapable'**
  String get theInescapable;

  /// No description provided for @label2TF7nb09WM.
  ///
  /// In en, this message translates to:
  /// **'2TF7nb09W-M'**
  String get label2TF7nb09WM;

  /// No description provided for @xG7qBdDRn0.
  ///
  /// In en, this message translates to:
  /// **'-XG7qBdDRn0'**
  String get xG7qBdDRn0;

  /// No description provided for @zeFO2XDbA4.
  ///
  /// In en, this message translates to:
  /// **'zeFO2XDb-A4'**
  String get zeFO2XDbA4;

  /// No description provided for @pLs3DOuT3JlGR2nMcuGW2139rVVeHcWIs.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGR2nMcuGW2139rV-veHcWIs'**
  String get pLs3DOuT3JlGR2nMcuGW2139rVVeHcWIs;

  /// No description provided for @pursuitOfJade2.
  ///
  /// In en, this message translates to:
  /// **'逐玉 Pursuit of Jade'**
  String get pursuitOfJade2;

  /// No description provided for @tBj7OHjb2tI.
  ///
  /// In en, this message translates to:
  /// **'TBj7OHjb2tI'**
  String get tBj7OHjb2tI;

  /// No description provided for @vWOECNVUlQ.
  ///
  /// In en, this message translates to:
  /// **'VWOE-cNVUlQ'**
  String get vWOECNVUlQ;

  /// No description provided for @label5NKgOE5DPQ.
  ///
  /// In en, this message translates to:
  /// **'5NKgOE5D-pQ'**
  String get label5NKgOE5DPQ;

  /// No description provided for @ipim7l2LZg.
  ///
  /// In en, this message translates to:
  /// **'ipim7l2L-Zg'**
  String get ipim7l2LZg;

  /// No description provided for @vmuf05J8Vc.
  ///
  /// In en, this message translates to:
  /// **'-Vmuf05J8Vc'**
  String get vmuf05J8Vc;

  /// No description provided for @label2M3Ls74gZY.
  ///
  /// In en, this message translates to:
  /// **'2M3Ls74gZ-Y'**
  String get label2M3Ls74gZY;

  /// No description provided for @p8DW4Gef70o.
  ///
  /// In en, this message translates to:
  /// **'P8DW4Gef70o'**
  String get p8DW4Gef70o;

  /// No description provided for @d4duxTP0FDE.
  ///
  /// In en, this message translates to:
  /// **'D4duxTP0FDE'**
  String get d4duxTP0FDE;

  /// No description provided for @b1T03rs9WGI.
  ///
  /// In en, this message translates to:
  /// **'B1T03rs9WGI'**
  String get b1T03rs9WGI;

  /// No description provided for @ruBRX68XPg.
  ///
  /// In en, this message translates to:
  /// **'Ru-BRX68XPg'**
  String get ruBRX68XPg;

  /// No description provided for @aX5eShfmFk.
  ///
  /// In en, this message translates to:
  /// **'AX5eShfm_fk'**
  String get aX5eShfmFk;

  /// No description provided for @fCsjHXbBlE.
  ///
  /// In en, this message translates to:
  /// **'f-CsjHXbBlE'**
  String get fCsjHXbBlE;

  /// No description provided for @m9xKlm95oc.
  ///
  /// In en, this message translates to:
  /// **'M9xKlm-95oc'**
  String get m9xKlm95oc;

  /// No description provided for @xh0z4YV9v2s.
  ///
  /// In en, this message translates to:
  /// **'Xh0z4YV9v2s'**
  String get xh0z4YV9v2s;

  /// No description provided for @iufzj2MLPs.
  ///
  /// In en, this message translates to:
  /// **'iufzj2M-LPs'**
  String get iufzj2MLPs;

  /// No description provided for @x6uXEQgWuM.
  ///
  /// In en, this message translates to:
  /// **'-X6uXEQgWuM'**
  String get x6uXEQgWuM;

  /// No description provided for @wlz3IhZptM.
  ///
  /// In en, this message translates to:
  /// **'Wlz3Ih-ZptM'**
  String get wlz3IhZptM;

  /// No description provided for @p10GCq30oNI.
  ///
  /// In en, this message translates to:
  /// **'P10GCq30oNI'**
  String get p10GCq30oNI;

  /// No description provided for @b65UYuRtpE.
  ///
  /// In en, this message translates to:
  /// **'B65-uYuRtpE'**
  String get b65UYuRtpE;

  /// No description provided for @generationToGeneration222.
  ///
  /// In en, this message translates to:
  /// **'《江湖夜雨十年灯 Generation to Generation》定档2月22日！看江湖最强新生代慕慕昭昭一起闯江湖'**
  String get generationToGeneration222;

  /// No description provided for @label6yOPycBAyU.
  ///
  /// In en, this message translates to:
  /// **'6y-oPycBAyU'**
  String get label6yOPycBAyU;

  /// No description provided for @lIAUBGNQM.
  ///
  /// In en, this message translates to:
  /// **'LI-AUBGN-QM'**
  String get lIAUBGNQM;

  /// No description provided for @sU12uaTtBg.
  ///
  /// In en, this message translates to:
  /// **'SU-12uaTtBg'**
  String get sU12uaTtBg;

  /// No description provided for @label05nLbIKPkQ.
  ///
  /// In en, this message translates to:
  /// **'05nLb-iKPkQ'**
  String get label05nLbIKPkQ;

  /// No description provided for @rKGFPIzgpO.
  ///
  /// In en, this message translates to:
  /// **'rKGFPIzgp-o'**
  String get rKGFPIzgpO;

  /// No description provided for @shO2wXA6U.
  ///
  /// In en, this message translates to:
  /// **'Sh-o2w-xA6U'**
  String get shO2wXA6U;

  /// No description provided for @dNsDNXcJgM.
  ///
  /// In en, this message translates to:
  /// **'d-nsDNXcJgM'**
  String get dNsDNXcJgM;

  /// No description provided for @w0NMLE9Hw.
  ///
  /// In en, this message translates to:
  /// **'W_0N-mLE9Hw'**
  String get w0NMLE9Hw;

  /// No description provided for @lTtwLNkDHY.
  ///
  /// In en, this message translates to:
  /// **'LTtwLNkD-HY'**
  String get lTtwLNkDHY;

  /// No description provided for @the300LoyalGhosts2.
  ///
  /// In en, this message translates to:
  /// **'大明暗影三百忠魂 The 300 Loyal Ghosts'**
  String get the300LoyalGhosts2;

  /// No description provided for @zj1Mh0bRE.
  ///
  /// In en, this message translates to:
  /// **'zj1Mh_0b-rE'**
  String get zj1Mh0bRE;

  /// No description provided for @kj6122rOzW.
  ///
  /// In en, this message translates to:
  /// **'kj6122rOz-w'**
  String get kj6122rOzW;

  /// No description provided for @ftgF1Hu9Ko.
  ///
  /// In en, this message translates to:
  /// **'Ftg-f1Hu9Ko'**
  String get ftgF1Hu9Ko;

  /// No description provided for @cnFIQ9QT4M.
  ///
  /// In en, this message translates to:
  /// **'-CnFIQ9QT4M'**
  String get cnFIQ9QT4M;

  /// No description provided for @ajdFKQ4uq8.
  ///
  /// In en, this message translates to:
  /// **'AjdF-kQ4uq8'**
  String get ajdFKQ4uq8;

  /// No description provided for @danceOfThePhoenix.
  ///
  /// In en, this message translates to:
  /// **'且听凤鸣 Dance of The Phoenix'**
  String get danceOfThePhoenix;

  /// No description provided for @f0uIRYSOwo.
  ///
  /// In en, this message translates to:
  /// **'F0uIRY_SOwo'**
  String get f0uIRYSOwo;

  /// No description provided for @extraordinary2.
  ///
  /// In en, this message translates to:
  /// **'非凡 Extraordinary'**
  String get extraordinary2;

  /// No description provided for @mIOS6JeeMU.
  ///
  /// In en, this message translates to:
  /// **'mIOS6Jee-mU'**
  String get mIOS6JeeMU;

  /// No description provided for @d8CsUqEy4.
  ///
  /// In en, this message translates to:
  /// **'d8CsUq-ey_4'**
  String get d8CsUqEy4;

  /// No description provided for @oZpINX3A.
  ///
  /// In en, this message translates to:
  /// **'-o_zpI-NX3A'**
  String get oZpINX3A;

  /// No description provided for @hyKy6aEDmo.
  ///
  /// In en, this message translates to:
  /// **'HyKy6aE-Dmo'**
  String get hyKy6aEDmo;

  /// No description provided for @nkAYc4ZSW8.
  ///
  /// In en, this message translates to:
  /// **'NkAYc4Z-sW8'**
  String get nkAYc4ZSW8;

  /// No description provided for @ovTXZjh2M.
  ///
  /// In en, this message translates to:
  /// **'ov-T_XZjh2M'**
  String get ovTXZjh2M;

  /// No description provided for @label2TheImperialCoronerS22.
  ///
  /// In en, this message translates to:
  /// **'《御赐小仵作2 The Imperial Coroner S2》定档0115，楚瑜夫妇暖心回归！'**
  String get label2TheImperialCoronerS22;

  /// No description provided for @kvFDYYmg.
  ///
  /// In en, this message translates to:
  /// **'KvF__d-YYmg'**
  String get kvFDYYmg;

  /// No description provided for @llaTO7muek.
  ///
  /// In en, this message translates to:
  /// **'llaT-O7muek'**
  String get llaTO7muek;

  /// No description provided for @label3r4Qw60AhM.
  ///
  /// In en, this message translates to:
  /// **'3r4Qw60Ah-M'**
  String get label3r4Qw60AhM;

  /// No description provided for @nwb6rTXjAs.
  ///
  /// In en, this message translates to:
  /// **'Nwb6rTXj-As'**
  String get nwb6rTXjAs;

  /// No description provided for @label87A7F8yq94.
  ///
  /// In en, this message translates to:
  /// **'87A7F-8yq94'**
  String get label87A7F8yq94;

  /// No description provided for @yJPJ6RWgyg.
  ///
  /// In en, this message translates to:
  /// **'yJP-j6RWgyg'**
  String get yJPJ6RWgyg;

  /// No description provided for @rebirthForYou.
  ///
  /// In en, this message translates to:
  /// **'嘉南传 Rebirth For You'**
  String get rebirthForYou;

  /// No description provided for @f9eLAZQDUds.
  ///
  /// In en, this message translates to:
  /// **'F9eLAZQDUds'**
  String get f9eLAZQDUds;

  /// No description provided for @aVowInTheDark2.
  ///
  /// In en, this message translates to:
  /// **'恋恋风陵渡 A Vow in the Dark'**
  String get aVowInTheDark2;

  /// No description provided for @theUltimateVowUnknownTo.
  ///
  /// In en, this message translates to:
  /// **'君不知 The Ultimate Vow, Unknown to You'**
  String get theUltimateVowUnknownTo;

  /// No description provided for @duMRGzTeKs.
  ///
  /// In en, this message translates to:
  /// **'DuM-rGzTeKs'**
  String get duMRGzTeKs;

  /// No description provided for @pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf'**
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf;

  /// No description provided for @theChangAnYouth.
  ///
  /// In en, this message translates to:
  /// **'长安少年行 The Chang\'An Youth'**
  String get theChangAnYouth;

  /// No description provided for @jg0aX6eEK4.
  ///
  /// In en, this message translates to:
  /// **'Jg0aX6e_EK4'**
  String get jg0aX6eEK4;

  /// No description provided for @adbjo5emA.
  ///
  /// In en, this message translates to:
  /// **'Adbjo5em__A'**
  String get adbjo5emA;

  /// No description provided for @label2QO1c7aWBE.
  ///
  /// In en, this message translates to:
  /// **'2QO1c7aW-bE'**
  String get label2QO1c7aWBE;

  /// No description provided for @x75eul0gjYM.
  ///
  /// In en, this message translates to:
  /// **'X75eul0gjYM'**
  String get x75eul0gjYM;

  /// No description provided for @dN6c2uB2cF4.
  ///
  /// In en, this message translates to:
  /// **'DN6c2uB2cF4'**
  String get dN6c2uB2cF4;

  /// No description provided for @label1xqkI5jRsc.
  ///
  /// In en, this message translates to:
  /// **'1xqkI5j-rsc'**
  String get label1xqkI5jRsc;

  /// No description provided for @jRRXVJblrk.
  ///
  /// In en, this message translates to:
  /// **'JRR-XVJblrk'**
  String get jRRXVJblrk;

  /// No description provided for @thePrincessDecree2.
  ///
  /// In en, this message translates to:
  /// **'平凝有令 The Princess Decree'**
  String get thePrincessDecree2;

  /// No description provided for @ppiNYsUwOA.
  ///
  /// In en, this message translates to:
  /// **'PpiNYs-uwOA'**
  String get ppiNYsUwOA;

  /// No description provided for @label83tIjIiqM.
  ///
  /// In en, this message translates to:
  /// **'-_83tIjIiqM'**
  String get label83tIjIiqM;

  /// No description provided for @p4cKjzSHFw.
  ///
  /// In en, this message translates to:
  /// **'P4cKjz-sHFw'**
  String get p4cKjzSHFw;

  /// No description provided for @babysitter.
  ///
  /// In en, this message translates to:
  /// **'我在冷宫做月嫂 Babysitter'**
  String get babysitter;

  /// No description provided for @label0MjfIXHKOM.
  ///
  /// In en, this message translates to:
  /// **'0MjfIXHKO-M'**
  String get label0MjfIXHKOM;

  /// No description provided for @zEOhv9GVlao.
  ///
  /// In en, this message translates to:
  /// **'ZEOhv9GVlao'**
  String get zEOhv9GVlao;

  /// No description provided for @pLs3DOuT3JlGRa8QmAVS9qfbbZS7afa0x.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGRa8Qm-AVS9qfbbZS7afa0x'**
  String get pLs3DOuT3JlGRa8QmAVS9qfbbZS7afa0x;

  /// No description provided for @xUjdpB74DU.
  ///
  /// In en, this message translates to:
  /// **'XUjdp_B74DU'**
  String get xUjdpB74DU;

  /// No description provided for @ddcGbI27AE.
  ///
  /// In en, this message translates to:
  /// **'DdcGbI-27AE'**
  String get ddcGbI27AE;

  /// No description provided for @herPhoenixMajesty2.
  ///
  /// In en, this message translates to:
  /// **'凤皇传 Her Phoenix Majesty'**
  String get herPhoenixMajesty2;

  /// No description provided for @pzXvIZTfw.
  ///
  /// In en, this message translates to:
  /// **'Pz_xvIZ-Tfw'**
  String get pzXvIZTfw;

  /// No description provided for @lXojyPTBzS.
  ///
  /// In en, this message translates to:
  /// **'lXojyPTBz-s'**
  String get lXojyPTBzS;

  /// No description provided for @pLs3DOuT3JlGQtL9S4u2QaRJty8BDrUk6.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGQtL9S4u2QaRJty8BDrUk6-'**
  String get pLs3DOuT3JlGQtL9S4u2QaRJty8BDrUk6;

  /// No description provided for @ntuwtDMChw.
  ///
  /// In en, this message translates to:
  /// **'ntuwtD-MChw'**
  String get ntuwtDMChw;

  /// No description provided for @bGXUzqodupo.
  ///
  /// In en, this message translates to:
  /// **'BGXUzqodupo'**
  String get bGXUzqodupo;

  /// No description provided for @plePvm344k.
  ///
  /// In en, this message translates to:
  /// **'plePvm-344k'**
  String get plePvm344k;

  /// No description provided for @f0OIk6BUbo.
  ///
  /// In en, this message translates to:
  /// **'F0OIk6-BUbo'**
  String get f0OIk6BUbo;

  /// No description provided for @kZZnmxJGHw.
  ///
  /// In en, this message translates to:
  /// **'KZZnmx_jGHw'**
  String get kZZnmxJGHw;

  /// No description provided for @eIuk7EPq2hg.
  ///
  /// In en, this message translates to:
  /// **'EIuk7EPq2hg'**
  String get eIuk7EPq2hg;

  /// No description provided for @label2H0pqyiPdk.
  ///
  /// In en, this message translates to:
  /// **'2H0pqyi-Pdk'**
  String get label2H0pqyiPdk;

  /// No description provided for @j6Xs9w4Elw.
  ///
  /// In en, this message translates to:
  /// **'J6_Xs9w4Elw'**
  String get j6Xs9w4Elw;

  /// No description provided for @xMtNosSw0.
  ///
  /// In en, this message translates to:
  /// **'X_-mtNosSw0'**
  String get xMtNosSw0;

  /// No description provided for @bienjpo0UFM.
  ///
  /// In en, this message translates to:
  /// **'Bienjpo0UFM'**
  String get bienjpo0UFM;

  /// No description provided for @oJOso5tVBek.
  ///
  /// In en, this message translates to:
  /// **'OJOso5tVBek'**
  String get oJOso5tVBek;

  /// No description provided for @eRxWzG9p7U.
  ///
  /// In en, this message translates to:
  /// **'eRxWzG9p7-U'**
  String get eRxWzG9p7U;

  /// No description provided for @iusgk4UlU.
  ///
  /// In en, this message translates to:
  /// **'iusgk-4Ul-U'**
  String get iusgk4UlU;

  /// No description provided for @pUV3TRgebig.
  ///
  /// In en, this message translates to:
  /// **'PUV3TRgebig'**
  String get pUV3TRgebig;

  /// No description provided for @lr4EpeONCw.
  ///
  /// In en, this message translates to:
  /// **'Lr4Epe-oNCw'**
  String get lr4EpeONCw;

  /// No description provided for @o3jzt2IlGU.
  ///
  /// In en, this message translates to:
  /// **'o3jzt2IlG-U'**
  String get o3jzt2IlGU;

  /// No description provided for @kKJPm6qb54A.
  ///
  /// In en, this message translates to:
  /// **'KKJPm6qb54A'**
  String get kKJPm6qb54A;

  /// No description provided for @qlWNAIqlvw.
  ///
  /// In en, this message translates to:
  /// **'Ql_WNAIqlvw'**
  String get qlWNAIqlvw;

  /// No description provided for @label0miWUBl3ZA.
  ///
  /// In en, this message translates to:
  /// **'0miWUBl3-zA'**
  String get label0miWUBl3ZA;

  /// No description provided for @jQMZbtl7b2w.
  ///
  /// In en, this message translates to:
  /// **'JQMZbtl7b2w'**
  String get jQMZbtl7b2w;

  /// No description provided for @qAw54adzTQ.
  ///
  /// In en, this message translates to:
  /// **'QAw5_4adzTQ'**
  String get qAw54adzTQ;

  /// No description provided for @eSL64O0EfI.
  ///
  /// In en, this message translates to:
  /// **'eSL-64O0EfI'**
  String get eSL64O0EfI;

  /// No description provided for @eYC4j7ky8pg.
  ///
  /// In en, this message translates to:
  /// **'EYC4j7ky8pg'**
  String get eYC4j7ky8pg;

  /// No description provided for @hGDl1nDeqE.
  ///
  /// In en, this message translates to:
  /// **'h-gDl1nDeqE'**
  String get hGDl1nDeqE;

  /// No description provided for @oAHE5vyYQg.
  ///
  /// In en, this message translates to:
  /// **'-oAHE5vyYQg'**
  String get oAHE5vyYQg;

  /// No description provided for @gbFQy8CqEo.
  ///
  /// In en, this message translates to:
  /// **'GbFQy8Cq-Eo'**
  String get gbFQy8CqEo;

  /// No description provided for @izi1KFUxPk.
  ///
  /// In en, this message translates to:
  /// **'Izi1KFUx-Pk'**
  String get izi1KFUxPk;

  /// No description provided for @i3qxA2cr8kA.
  ///
  /// In en, this message translates to:
  /// **'I3qxA2cr8kA'**
  String get i3qxA2cr8kA;

  /// No description provided for @oFI5pek3lvY.
  ///
  /// In en, this message translates to:
  /// **'OFI5pek3lvY'**
  String get oFI5pek3lvY;

  /// No description provided for @obuu6ZaIA8.
  ///
  /// In en, this message translates to:
  /// **'obuu6ZaIA-8'**
  String get obuu6ZaIA8;

  /// No description provided for @xIf4aL45npQ.
  ///
  /// In en, this message translates to:
  /// **'XIf4aL45npQ'**
  String get xIf4aL45npQ;

  /// No description provided for @aGirlLikeMe2.
  ///
  /// In en, this message translates to:
  /// **'我就是这般女子 A Girl Like Me'**
  String get aGirlLikeMe2;

  /// No description provided for @p4YsJ5WtBw.
  ///
  /// In en, this message translates to:
  /// **'p4YsJ5Wt-bw'**
  String get p4YsJ5WtBw;

  /// No description provided for @pIg2oXFWS8.
  ///
  /// In en, this message translates to:
  /// **'pIg2oXFWS-8'**
  String get pIg2oXFWS8;

  /// No description provided for @hrJz2C0Fxs.
  ///
  /// In en, this message translates to:
  /// **'hrJz-2C0Fxs'**
  String get hrJz2C0Fxs;

  /// No description provided for @mL0phSCWJY.
  ///
  /// In en, this message translates to:
  /// **'mL0phSC-wJY'**
  String get mL0phSCWJY;

  /// No description provided for @sideStoryOfFoxVolant2.
  ///
  /// In en, this message translates to:
  /// **'飞狐外传 Side Story of Fox Volant'**
  String get sideStoryOfFoxVolant2;

  /// No description provided for @pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q'**
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q;

  /// No description provided for @aFlowerOnTheContinent2.
  ///
  /// In en, this message translates to:
  /// **'有花在洲 A Flower On The Continent'**
  String get aFlowerOnTheContinent2;

  /// No description provided for @aFlowerOnTheContinent3.
  ///
  /// In en, this message translates to:
  /// **'【有花在洲 A Flower On The Continent】 小王爷当质子被花姑娘硬当公主，还挤一块住'**
  String get aFlowerOnTheContinent3;

  /// No description provided for @aFlowerOnTheContinent4.
  ///
  /// In en, this message translates to:
  /// **'【有花在洲 A Flower On The Continent】 花姑娘女装露馅，小王爷舍命护她还反被诬陷'**
  String get aFlowerOnTheContinent4;

  /// No description provided for @aFlowerOnTheContinent5.
  ///
  /// In en, this message translates to:
  /// **'【有花在洲 A Flower On The Continent】 花惜玉发现杀父仇人是宁玄洲的爹当场翻脸'**
  String get aFlowerOnTheContinent5;

  /// No description provided for @aFlowerOnTheContinent6.
  ///
  /// In en, this message translates to:
  /// **'【有花在洲 A Flower On The Continent】 花惜玉穿嫁衣闯敌营，拼了命救宁玄洲差点没命'**
  String get aFlowerOnTheContinent6;

  /// No description provided for @aFlowerOnTheContinent7.
  ///
  /// In en, this message translates to:
  /// **'【有花在洲 A Flower On The Continent】 两国签和约，宁玄洲撕诏书非要娶花惜玉'**
  String get aFlowerOnTheContinent7;

  /// No description provided for @aFlowerOnTheContinent8.
  ///
  /// In en, this message translates to:
  /// **'【有花在洲 A Flower On The Continent】 花惜玉割腕放血制药，宁玄洲告发父皇杀了她爹'**
  String get aFlowerOnTheContinent8;

  /// No description provided for @aFlowerOnTheContinent9.
  ///
  /// In en, this message translates to:
  /// **'【有花在洲 A Flower On The Continent】 花惜玉知道爹是宁玄洲爹杀的，在花海砍断定情树枝'**
  String get aFlowerOnTheContinent9;

  /// No description provided for @pLs3DOuT3JlGS2bplCB41Z0150Kb9oQdn.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGS2bplCB41Z0150-Kb9oQdn'**
  String get pLs3DOuT3JlGS2bplCB41Z0150Kb9oQdn;

  /// No description provided for @t1D3w33qTG8.
  ///
  /// In en, this message translates to:
  /// **'T1D3w33qTG8'**
  String get t1D3w33qTG8;

  /// No description provided for @fLoEBicAD0.
  ///
  /// In en, this message translates to:
  /// **'fLoEBicA-D0'**
  String get fLoEBicAD0;

  /// No description provided for @pLs3DOuT3JlGTeaxmA97G31cUKERfzNgN.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGTeaxmA97G31cUK-eRfzNgN'**
  String get pLs3DOuT3JlGTeaxmA97G31cUKERfzNgN;

  /// No description provided for @d3UOh8aqKE.
  ///
  /// In en, this message translates to:
  /// **'D3UOh_8aqKE'**
  String get d3UOh8aqKE;

  /// No description provided for @hcEA13KgnE.
  ///
  /// In en, this message translates to:
  /// **'hcEA13Kgn-E'**
  String get hcEA13KgnE;

  /// No description provided for @pbC7hP30zU.
  ///
  /// In en, this message translates to:
  /// **'PbC7h-P30zU'**
  String get pbC7hP30zU;

  /// No description provided for @hilariousFamily22.
  ///
  /// In en, this message translates to:
  /// **'芬芳喜事 Hilarious Family 2'**
  String get hilariousFamily22;

  /// No description provided for @sliceOfLife.
  ///
  /// In en, this message translates to:
  /// **'Slice of Life'**
  String get sliceOfLife;

  /// No description provided for @p6Og4b7SEiw.
  ///
  /// In en, this message translates to:
  /// **'P6Og4b7SEiw'**
  String get p6Og4b7SEiw;

  /// No description provided for @label6TOkoVJcus.
  ///
  /// In en, this message translates to:
  /// **'6-tOkoVJcus'**
  String get label6TOkoVJcus;

  /// No description provided for @xKUz23x2pOo.
  ///
  /// In en, this message translates to:
  /// **'XKUz23x2pOo'**
  String get xKUz23x2pOo;

  /// No description provided for @fTuSIxeFUY.
  ///
  /// In en, this message translates to:
  /// **'FTuSIxe-fUY'**
  String get fTuSIxeFUY;

  /// No description provided for @kdow9dKN0.
  ///
  /// In en, this message translates to:
  /// **'_Kdow9dKN-0'**
  String get kdow9dKN0;

  /// No description provided for @y4eB2fuCNs.
  ///
  /// In en, this message translates to:
  /// **'Y4e_b2fuCNs'**
  String get y4eB2fuCNs;

  /// No description provided for @sVClNTSRcQ.
  ///
  /// In en, this message translates to:
  /// **'SV-clNTSRcQ'**
  String get sVClNTSRcQ;

  /// No description provided for @xQtiANGe8.
  ///
  /// In en, this message translates to:
  /// **'x-qtiA-NGe8'**
  String get xQtiANGe8;

  /// No description provided for @obESRYh3NU.
  ///
  /// In en, this message translates to:
  /// **'obESRYh3-NU'**
  String get obESRYh3NU;

  /// No description provided for @pLs3DOuT3JlGShdDzo52tfDOSU1UkUcHX.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGShdDzo52tfDOSU1UkUc-hX'**
  String get pLs3DOuT3JlGShdDzo52tfDOSU1UkUcHX;

  /// No description provided for @legendOfTheFemaleGeneral.
  ///
  /// In en, this message translates to:
  /// **'锦月如歌 Legend of The Female General'**
  String get legendOfTheFemaleGeneral;

  /// No description provided for @highlightLegendOfTheFemale.
  ///
  /// In en, this message translates to:
  /// **'Highlight高光合集 【锦月如歌 Legend of The Female General】'**
  String get highlightLegendOfTheFemale;

  /// No description provided for @a40F2TEZrms.
  ///
  /// In en, this message translates to:
  /// **'A40F2TEZrms'**
  String get a40F2TEZrms;

  /// No description provided for @lYQ5iND4.
  ///
  /// In en, this message translates to:
  /// **'lYQ5iN-d-_4'**
  String get lYQ5iND4;

  /// No description provided for @bTSLegendOfTheFemale.
  ///
  /// In en, this message translates to:
  /// **'BTS 周也的生日大放送 🎂！【锦月如歌 Legend of The Female General】'**
  String get bTSLegendOfTheFemale;

  /// No description provided for @bTSLegendOfTheFemale2.
  ///
  /// In en, this message translates to:
  /// **'BTS 肖都督丞磊生日大放送 🎂！【锦月如歌 Legend of The Female General】'**
  String get bTSLegendOfTheFemale2;

  /// No description provided for @bTSLegendOfTheFemale3.
  ///
  /// In en, this message translates to:
  /// **'BTS 战场上帅气合体打斗，没人能拒绝飒感拉满的大魏双星【锦月如歌 Legend of The Female General】'**
  String get bTSLegendOfTheFemale3;

  /// No description provided for @bTS520LegendOfThe.
  ///
  /// In en, this message translates to:
  /// **'BTS 喜肖晏开的520约会方案【锦月如歌 Legend of The Female General】'**
  String get bTS520LegendOfThe;

  /// No description provided for @bTSLegendOfTheFemale4.
  ///
  /// In en, this message translates to:
  /// **'BTS 醉酒的周也可爱到犯规~舞剑反差萌拉满~一旁的丞磊嘴角笑意真藏不住一点！【锦月如歌 Legend of The Female General】'**
  String get bTSLegendOfTheFemale4;

  /// No description provided for @pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP.
  ///
  /// In en, this message translates to:
  /// **'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP'**
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP;

  /// No description provided for @thePrincessSGambit.
  ///
  /// In en, this message translates to:
  /// **'桃花映江山 The Princess\'s Gambit'**
  String get thePrincessSGambit;

  /// No description provided for @highlightThePrincessSGambit.
  ///
  /// In en, this message translates to:
  /// **'Highlight高光合集 【桃花映江山 The Princess\'s Gambit】'**
  String get highlightThePrincessSGambit;

  /// No description provided for @qJRbuw2hJ3s.
  ///
  /// In en, this message translates to:
  /// **'QJRbuw2hJ3s'**
  String get qJRbuw2hJ3s;

  /// No description provided for @cGtKgr7X4o.
  ///
  /// In en, this message translates to:
  /// **'cGt-Kgr7X4o'**
  String get cGtKgr7X4o;

  /// No description provided for @iZe4HBUZQ.
  ///
  /// In en, this message translates to:
  /// **'IZe4_HBU_ZQ'**
  String get iZe4HBUZQ;

  /// No description provided for @zGgyp0sbyDM.
  ///
  /// In en, this message translates to:
  /// **'ZGgyp0sbyDM'**
  String get zGgyp0sbyDM;

  /// No description provided for @label2BI4oU8Rwo.
  ///
  /// In en, this message translates to:
  /// **'2BI4o-u8Rwo'**
  String get label2BI4oU8Rwo;

  /// No description provided for @zNZAQZZQ.
  ///
  /// In en, this message translates to:
  /// **'-ZN-zAQZZ-Q'**
  String get zNZAQZZQ;

  /// No description provided for @uma3ppi4wiM.
  ///
  /// In en, this message translates to:
  /// **'Uma3ppi4wiM'**
  String get uma3ppi4wiM;

  /// No description provided for @clipThePrincessSGambit.
  ///
  /// In en, this message translates to:
  /// **'Clip 一袭红衣染白雪！姜桃花为保护幼弟诀别故土远嫁祈国【桃花映江山 The Princess\'s Gambit】'**
  String get clipThePrincessSGambit;

  /// No description provided for @clipThePrincessSGambit2.
  ///
  /// In en, this message translates to:
  /// **'Clip 新婚日沈府妻妾集体作妖？桃花以退为进淡定接招【桃花映江山 The Princess\'s Gambit】'**
  String get clipThePrincessSGambit2;

  /// No description provided for @clipThePrincessSGambit3.
  ///
  /// In en, this message translates to:
  /// **'Clip 桃花自缢装晕被拆穿，沈在野一针扎醒：演，接着演！【桃花映江山 The Princess\'s Gambit】'**
  String get clipThePrincessSGambit3;

  /// No description provided for @clipThePrincessSGambit4.
  ///
  /// In en, this message translates to:
  /// **'Clip 沈相办案好狠的心！雷霆手段彻查恶钱案，贪官们瑟瑟发抖【桃花映江山 The Princess\'s Gambit】'**
  String get clipThePrincessSGambit4;

  /// No description provided for @eDrJjtCRF0.
  ///
  /// In en, this message translates to:
  /// **'eDr-jjtCRF0'**
  String get eDrJjtCRF0;

  /// No description provided for @clipThePrincessSGambit5.
  ///
  /// In en, this message translates to:
  /// **'Clip 面具刺客完美伪装难逃制裁，神探桃花：你的脚出卖了你！【桃花映江山 The Princess\'s Gambit】'**
  String get clipThePrincessSGambit5;

  /// No description provided for @clipPlayThePrincessS.
  ///
  /// In en, this message translates to:
  /// **'Clip 发簪审讯play！沈在野执簪挑起桃花下巴冷声逼问【桃花映江山 The Princess\'s Gambit】'**
  String get clipPlayThePrincessS;

  /// No description provided for @label58K8GxhXlQ.
  ///
  /// In en, this message translates to:
  /// **'58K8-gxhXlQ'**
  String get label58K8GxhXlQ;

  /// No description provided for @clipThePrincessSGambit6.
  ///
  /// In en, this message translates to:
  /// **'Clip 初次相见就玩这么大！沈在野桃花身中合欢散四目相对【桃花映江山 The Princess\'s Gambit】'**
  String get clipThePrincessSGambit6;

  /// No description provided for @pLIPiKkSFpK8B6r2izKyYYiYdbkYSBbd.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8B6r2izKyY-yiYdbkYSBbd'**
  String get pLIPiKkSFpK8B6r2izKyYYiYdbkYSBbd;

  /// No description provided for @reqdatIdS.
  ///
  /// In en, this message translates to:
  /// **'Reqdat_id-s'**
  String get reqdatIdS;

  /// No description provided for @label72zyHSuRDM.
  ///
  /// In en, this message translates to:
  /// **'72zyHSuR-dM'**
  String get label72zyHSuRDM;

  /// No description provided for @zQDc6PfC0.
  ///
  /// In en, this message translates to:
  /// **'z-q_Dc6PfC0'**
  String get zQDc6PfC0;

  /// No description provided for @hfcLvnUQqA.
  ///
  /// In en, this message translates to:
  /// **'-hfcLvnUQqA'**
  String get hfcLvnUQqA;

  /// No description provided for @y5CHMfB8dw.
  ///
  /// In en, this message translates to:
  /// **'Y5C-HMfB8dw'**
  String get y5CHMfB8dw;

  /// No description provided for @p28HP1H4Vc.
  ///
  /// In en, this message translates to:
  /// **'P28HP_1H4Vc'**
  String get p28HP1H4Vc;

  /// No description provided for @yBclY6CaTw.
  ///
  /// In en, this message translates to:
  /// **'yBclY6-caTw'**
  String get yBclY6CaTw;

  /// No description provided for @bGIAtDEdlk.
  ///
  /// In en, this message translates to:
  /// **'B-gIAtDEdlk'**
  String get bGIAtDEdlk;

  /// No description provided for @mWKB6zDZwc.
  ///
  /// In en, this message translates to:
  /// **'mWKB6zD-zwc'**
  String get mWKB6zDZwc;

  /// No description provided for @q8N3LJ0A9Bk.
  ///
  /// In en, this message translates to:
  /// **'Q8N3LJ0A9Bk'**
  String get q8N3LJ0A9Bk;

  /// No description provided for @yR6T2qwwRJ0.
  ///
  /// In en, this message translates to:
  /// **'YR6T2qwwRJ0'**
  String get yR6T2qwwRJ0;

  /// No description provided for @oOgqhGuLE.
  ///
  /// In en, this message translates to:
  /// **'-o_ogqhGuLE'**
  String get oOgqhGuLE;

  /// No description provided for @sk2MR0LGf0E.
  ///
  /// In en, this message translates to:
  /// **'Sk2MR0LGf0E'**
  String get sk2MR0LGf0E;

  /// No description provided for @rodBx023QQ.
  ///
  /// In en, this message translates to:
  /// **'rodBx023-qQ'**
  String get rodBx023QQ;

  /// No description provided for @zPVcOAzByY.
  ///
  /// In en, this message translates to:
  /// **'z-pVcOAzByY'**
  String get zPVcOAzByY;

  /// No description provided for @nWM1Ceq5oyE.
  ///
  /// In en, this message translates to:
  /// **'NWM1Ceq5oyE'**
  String get nWM1Ceq5oyE;

  /// No description provided for @pLIPiKkSFpKIRCE5jKV6WuMHd3ba79JP.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK_IRCE5jKV6WuMHd3ba79JP'**
  String get pLIPiKkSFpKIRCE5jKV6WuMHd3ba79JP;

  /// No description provided for @label7yLGOh2ABg.
  ///
  /// In en, this message translates to:
  /// **'7y-lGOh2ABg'**
  String get label7yLGOh2ABg;

  /// No description provided for @yr5pUONS3c.
  ///
  /// In en, this message translates to:
  /// **'-Yr5pUONS3c'**
  String get yr5pUONS3c;

  /// No description provided for @svE0DPJGYA.
  ///
  /// In en, this message translates to:
  /// **'SvE0DPJ-gYA'**
  String get svE0DPJGYA;

  /// No description provided for @i709WD0cVs.
  ///
  /// In en, this message translates to:
  /// **'I_709WD0cVs'**
  String get i709WD0cVs;

  /// No description provided for @mgWNgw9MQ.
  ///
  /// In en, this message translates to:
  /// **'MgWNgw_9-MQ'**
  String get mgWNgw9MQ;

  /// No description provided for @xs2k2nlJYYc.
  ///
  /// In en, this message translates to:
  /// **'Xs2k2nlJYYc'**
  String get xs2k2nlJYYc;

  /// No description provided for @fdXXdYB6Vo.
  ///
  /// In en, this message translates to:
  /// **'FdXXd-YB6Vo'**
  String get fdXXdYB6Vo;

  /// No description provided for @pKG6QKF6Og.
  ///
  /// In en, this message translates to:
  /// **'p-KG6QKF6Og'**
  String get pKG6QKF6Og;

  /// No description provided for @limitedFULLTheIngeniousOne.
  ///
  /// In en, this message translates to:
  /// **'【Limited FULL】云襄传 | The Ingenious One | iQIYI 👑Join the Membership and enjoy full episodes now!'**
  String get limitedFULLTheIngeniousOne;

  /// No description provided for @iQIYIGetTheIQIYIAPP2.
  ///
  /// In en, this message translates to:
  /// **'iQIYI 爱奇艺 - Get the iQIYI APP'**
  String get iQIYIGetTheIQIYIAPP2;

  /// No description provided for @aky3021PW.
  ///
  /// In en, this message translates to:
  /// **'_Aky3021P-w'**
  String get aky3021PW;

  /// No description provided for @hMaBvO3nkM.
  ///
  /// In en, this message translates to:
  /// **'hMaBv-O3nkM'**
  String get hMaBvO3nkM;

  /// No description provided for @r2YEAXZFxp4.
  ///
  /// In en, this message translates to:
  /// **'R2YEAXZFxp4'**
  String get r2YEAXZFxp4;

  /// No description provided for @iTLYG63GDc.
  ///
  /// In en, this message translates to:
  /// **'ITLYG-63GDc'**
  String get iTLYG63GDc;

  /// No description provided for @label1TyTz8z1vK.
  ///
  /// In en, this message translates to:
  /// **'1TyTz8z1v-k'**
  String get label1TyTz8z1vK;

  /// No description provided for @jIq5a7yEd8c.
  ///
  /// In en, this message translates to:
  /// **'JIq5a7yEd8c'**
  String get jIq5a7yEd8c;

  /// No description provided for @tDMpSBCf5k.
  ///
  /// In en, this message translates to:
  /// **'tDMp-sBCf5k'**
  String get tDMpSBCf5k;

  /// No description provided for @iPWSYbG6s4.
  ///
  /// In en, this message translates to:
  /// **'IPW-sYbG6s4'**
  String get iPWSYbG6s4;

  /// No description provided for @label6GjFP04aw.
  ///
  /// In en, this message translates to:
  /// **'6Gj-FP-04aw'**
  String get label6GjFP04aw;

  /// No description provided for @pL6xVgUZ4UP2Ps7N0b2CUMkQ49aAX3xlw.
  ///
  /// In en, this message translates to:
  /// **'PL6xVgUZ4UP2Ps7N0b2-cUMkQ49aAX3xlw'**
  String get pL6xVgUZ4UP2Ps7N0b2CUMkQ49aAX3xlw;

  /// No description provided for @f8ilmFb30.
  ///
  /// In en, this message translates to:
  /// **'f8ilm_Fb-30'**
  String get f8ilmFb30;

  /// No description provided for @dQt4Zorb4gE.
  ///
  /// In en, this message translates to:
  /// **'DQt4Zorb4gE'**
  String get dQt4Zorb4gE;

  /// No description provided for @t9XDOuWLc.
  ///
  /// In en, this message translates to:
  /// **'t9XD-OuW-Lc'**
  String get t9XDOuWLc;

  /// No description provided for @vcEgRd08.
  ///
  /// In en, this message translates to:
  /// **'-vc_egRd_08'**
  String get vcEgRd08;

  /// No description provided for @b0b1dFL9Nc.
  ///
  /// In en, this message translates to:
  /// **'B0b1dF-l9Nc'**
  String get b0b1dFL9Nc;

  /// No description provided for @pLIPiKkSFpK8VhfSNo7Vsx4lCMTKbcOm.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8_VhfSNo7Vsx4lCMTKbcOm'**
  String get pLIPiKkSFpK8VhfSNo7Vsx4lCMTKbcOm;

  /// No description provided for @aMeUFNq1m8.
  ///
  /// In en, this message translates to:
  /// **'AMe-uFNq1m8'**
  String get aMeUFNq1m8;

  /// No description provided for @dJUpKoPRtg.
  ///
  /// In en, this message translates to:
  /// **'DJ-UpKoPRtg'**
  String get dJUpKoPRtg;

  /// No description provided for @oQMLDVlb7g.
  ///
  /// In en, this message translates to:
  /// **'OQML_DVlb7g'**
  String get oQMLDVlb7g;

  /// No description provided for @aUeypfRL24.
  ///
  /// In en, this message translates to:
  /// **'aUeypfRL-24'**
  String get aUeypfRL24;

  /// No description provided for @uB9ycPhk1mg.
  ///
  /// In en, this message translates to:
  /// **'UB9ycPhk1mg'**
  String get uB9ycPhk1mg;

  /// No description provided for @pLIPiKkSFpK8Pesmyu9gzK2jXpplqUn9d.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8Pesmyu9gzK2jXpplqUn9d'**
  String get pLIPiKkSFpK8Pesmyu9gzK2jXpplqUn9d;

  /// No description provided for @i5TQ4zJDUs.
  ///
  /// In en, this message translates to:
  /// **'I5TQ4z_jDUs'**
  String get i5TQ4zJDUs;

  /// No description provided for @goft2N911yE.
  ///
  /// In en, this message translates to:
  /// **'Goft2N911yE'**
  String get goft2N911yE;

  /// No description provided for @sraEP5hG98.
  ///
  /// In en, this message translates to:
  /// **'sraEP5hG-98'**
  String get sraEP5hG98;

  /// No description provided for @axhDRyKII.
  ///
  /// In en, this message translates to:
  /// **'_AxhDRy-kII'**
  String get axhDRyKII;

  /// No description provided for @j1z4azTG40.
  ///
  /// In en, this message translates to:
  /// **'J-1z4azTG40'**
  String get j1z4azTG40;

  /// No description provided for @m87V7kOvg.
  ///
  /// In en, this message translates to:
  /// **'-m_87V7kOvg'**
  String get m87V7kOvg;

  /// No description provided for @g2ASv4fOuc.
  ///
  /// In en, this message translates to:
  /// **'G2-aSv4fOuc'**
  String get g2ASv4fOuc;

  /// No description provided for @tONKwUFYQ.
  ///
  /// In en, this message translates to:
  /// **'-TONKwU_FYQ'**
  String get tONKwUFYQ;

  /// No description provided for @mw7OlvkWDg.
  ///
  /// In en, this message translates to:
  /// **'-Mw7OlvkWDg'**
  String get mw7OlvkWDg;

  /// No description provided for @pLIPiKkSFpK8KCCeSQTpodI0VqMejybr9.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8KCCeSQTpodI0VqMejybr9'**
  String get pLIPiKkSFpK8KCCeSQTpodI0VqMejybr9;

  /// No description provided for @label4GJqLnsV6c.
  ///
  /// In en, this message translates to:
  /// **'4G-jqLnsV6c'**
  String get label4GJqLnsV6c;

  /// No description provided for @b36gveSPqI.
  ///
  /// In en, this message translates to:
  /// **'B36gveS-pqI'**
  String get b36gveSPqI;

  /// No description provided for @da6GLS11sDg.
  ///
  /// In en, this message translates to:
  /// **'Da6GLS11sDg'**
  String get da6GLS11sDg;

  /// No description provided for @r7Jzgv6XuM.
  ///
  /// In en, this message translates to:
  /// **'-r7Jzgv6XuM'**
  String get r7Jzgv6XuM;

  /// No description provided for @fULLROADHOMEBoranJingSeven.
  ///
  /// In en, this message translates to:
  /// **'【FULL】👮ROAD HOME💕 | BoranJing, Seven Tan | iQIYI Philippines'**
  String get fULLROADHOMEBoranJingSeven;

  /// No description provided for @iQIYIPhilippinesGetTheIQIYI.
  ///
  /// In en, this message translates to:
  /// **'iQIYI Philippines - Get the iQIYI APP'**
  String get iQIYIPhilippinesGetTheIQIYI;

  /// No description provided for @lKuff6Nfwp8.
  ///
  /// In en, this message translates to:
  /// **'LKuff6Nfwp8'**
  String get lKuff6Nfwp8;

  /// No description provided for @n3oPG8EusI.
  ///
  /// In en, this message translates to:
  /// **'N3oPG8Eus-I'**
  String get n3oPG8EusI;

  /// No description provided for @jEq6lPG1rus.
  ///
  /// In en, this message translates to:
  /// **'JEq6lPG1rus'**
  String get jEq6lPG1rus;

  /// No description provided for @uwhhmc98HX8.
  ///
  /// In en, this message translates to:
  /// **'Uwhhmc98HX8'**
  String get uwhhmc98HX8;

  /// No description provided for @k3KVVNRjgw.
  ///
  /// In en, this message translates to:
  /// **'K3KVV-NRjgw'**
  String get k3KVVNRjgw;

  /// No description provided for @aIEnglishDubMrBAD.
  ///
  /// In en, this message translates to:
  /// **'【AI English Dub】Mr. BAD | Chen Zheyuan, Yue Shen | iQIYI Philippines'**
  String get aIEnglishDubMrBAD;

  /// No description provided for @h7d38oiW4.
  ///
  /// In en, this message translates to:
  /// **'-h7d38oi_w4'**
  String get h7d38oiW4;

  /// No description provided for @tIjEEDlLPY.
  ///
  /// In en, this message translates to:
  /// **'-TIjEEDlLPY'**
  String get tIjEEDlLPY;

  /// No description provided for @label6P746xQE1E.
  ///
  /// In en, this message translates to:
  /// **'6P746xQE1-E'**
  String get label6P746xQE1E;

  /// No description provided for @wJo20fh1ovU.
  ///
  /// In en, this message translates to:
  /// **'WJo20fh1ovU'**
  String get wJo20fh1ovU;

  /// No description provided for @aUci4B6qoIY.
  ///
  /// In en, this message translates to:
  /// **'AUci4B6qoIY'**
  String get aUci4B6qoIY;

  /// No description provided for @loveOfTheDivineTree2.
  ///
  /// In en, this message translates to:
  /// **'🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | FULL正片 | iQIYI 👑Join the Membership and enjoy full episodes now!'**
  String get loveOfTheDivineTree2;

  /// No description provided for @uFSyFzIASM.
  ///
  /// In en, this message translates to:
  /// **'UFSyFzIA-sM'**
  String get uFSyFzIASM;

  /// No description provided for @c8THRSSU6M.
  ///
  /// In en, this message translates to:
  /// **'c8-tHRSSU6M'**
  String get c8THRSSU6M;

  /// No description provided for @cxx0rl8JJnc.
  ///
  /// In en, this message translates to:
  /// **'Cxx0rl8JJnc'**
  String get cxx0rl8JJnc;

  /// No description provided for @o5Mn9URF3uE.
  ///
  /// In en, this message translates to:
  /// **'O5Mn9URF3uE'**
  String get o5Mn9URF3uE;

  /// No description provided for @eE1jl4dzrg8.
  ///
  /// In en, this message translates to:
  /// **'EE1jl4dzrg8'**
  String get eE1jl4dzrg8;

  /// No description provided for @label6GeLMiukHC.
  ///
  /// In en, this message translates to:
  /// **'6GeLMiukH-c'**
  String get label6GeLMiukHC;

  /// No description provided for @eAhVaQ2RA.
  ///
  /// In en, this message translates to:
  /// **'e_ahVaQ2-rA'**
  String get eAhVaQ2RA;

  /// No description provided for @h9VQfSPUzs.
  ///
  /// In en, this message translates to:
  /// **'H9VQfS-pUzs'**
  String get h9VQfSPUzs;

  /// No description provided for @pLIPiKkSFpKUBrffjChZ310g2OtsQfLf.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK-uBrffjChZ310g2OtsQfLf'**
  String get pLIPiKkSFpKUBrffjChZ310g2OtsQfLf;

  /// No description provided for @k8DtfAAU4U.
  ///
  /// In en, this message translates to:
  /// **'K8-DtfAAU4U'**
  String get k8DtfAAU4U;

  /// No description provided for @pLIPiKkSFpK9TcBapXhwwF9nCt2DZu9k.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK9-TcBapXhwwF9nCt2DZu9k'**
  String get pLIPiKkSFpK9TcBapXhwwF9nCt2DZu9k;

  /// No description provided for @vP12XNOv5eM.
  ///
  /// In en, this message translates to:
  /// **'VP12XNOv5eM'**
  String get vP12XNOv5eM;

  /// No description provided for @yTp22S1oA5Q.
  ///
  /// In en, this message translates to:
  /// **'YTp22S1oA5Q'**
  String get yTp22S1oA5Q;

  /// No description provided for @rxgy49XHTbs.
  ///
  /// In en, this message translates to:
  /// **'Rxgy49XHTbs'**
  String get rxgy49XHTbs;

  /// No description provided for @hHw9RaWByc.
  ///
  /// In en, this message translates to:
  /// **'hHw9-RaWByc'**
  String get hHw9RaWByc;

  /// No description provided for @wwoz6JPu2Yg.
  ///
  /// In en, this message translates to:
  /// **'Wwoz6JPu2Yg'**
  String get wwoz6JPu2Yg;

  /// No description provided for @lW32xQCoqs.
  ///
  /// In en, this message translates to:
  /// **'LW32x_QCoqs'**
  String get lW32xQCoqs;

  /// No description provided for @gb414C2O3w.
  ///
  /// In en, this message translates to:
  /// **'Gb414C2_O3w'**
  String get gb414C2O3w;

  /// No description provided for @k7iTvKzZyQ.
  ///
  /// In en, this message translates to:
  /// **'K7iTv-KzZyQ'**
  String get k7iTvKzZyQ;

  /// No description provided for @npbhgWJePE.
  ///
  /// In en, this message translates to:
  /// **'npbhgWJe-PE'**
  String get npbhgWJePE;

  /// No description provided for @knWpROE9xU.
  ///
  /// In en, this message translates to:
  /// **'kn-WpROE9xU'**
  String get knWpROE9xU;

  /// No description provided for @eT8okyktVok.
  ///
  /// In en, this message translates to:
  /// **'ET8okyktVok'**
  String get eT8okyktVok;

  /// No description provided for @pLIPiKkSFpK8Q5DyWQXPpAdGsyH8BPUYA.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8Q5DyWQXPpAdGsyH8BPUYA'**
  String get pLIPiKkSFpK8Q5DyWQXPpAdGsyH8BPUYA;

  /// No description provided for @rD40VQSYnjo.
  ///
  /// In en, this message translates to:
  /// **'RD40VQSYnjo'**
  String get rD40VQSYnjo;

  /// No description provided for @bmdZBo8HoE.
  ///
  /// In en, this message translates to:
  /// **'BmdZ-Bo8HoE'**
  String get bmdZBo8HoE;

  /// No description provided for @pLIPiKkSFpK9MiE3quPZjNnu7RgviYDy.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK9MiE3quPZjNnu7-RgviYDy'**
  String get pLIPiKkSFpK9MiE3quPZjNnu7RgviYDy;

  /// No description provided for @fYFcg3qNJE.
  ///
  /// In en, this message translates to:
  /// **'fYFcg3qN-jE'**
  String get fYFcg3qNJE;

  /// No description provided for @uWRVG89Kn8M.
  ///
  /// In en, this message translates to:
  /// **'UWRVG89Kn8M'**
  String get uWRVG89Kn8M;

  /// No description provided for @iBUh0B2XAMQ.
  ///
  /// In en, this message translates to:
  /// **'IBUh0B2XAMQ'**
  String get iBUh0B2XAMQ;

  /// No description provided for @wQlTnSp5s.
  ///
  /// In en, this message translates to:
  /// **'W-ql-tnSp5s'**
  String get wQlTnSp5s;

  /// No description provided for @edAqyr6ieU.
  ///
  /// In en, this message translates to:
  /// **'-EdAqyr6ieU'**
  String get edAqyr6ieU;

  /// No description provided for @pLIPiKkSFpK8wb8Yzzh4eptkOEn2LPtDf.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8wb8Yzzh4eptkOEn2LPtDf'**
  String get pLIPiKkSFpK8wb8Yzzh4eptkOEn2LPtDf;

  /// No description provided for @label93ckJe0R6c.
  ///
  /// In en, this message translates to:
  /// **'-93ckJe0R6c'**
  String get label93ckJe0R6c;

  /// No description provided for @vzb1BHRshM.
  ///
  /// In en, this message translates to:
  /// **'Vzb1B-hRshM'**
  String get vzb1BHRshM;

  /// No description provided for @yC69yjVyOo.
  ///
  /// In en, this message translates to:
  /// **'y-C69yjVyOo'**
  String get yC69yjVyOo;

  /// No description provided for @pLIPiKkSFpK8MdPQg72ceDNUGjf0mhENz.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8MdPQg72ceDNUGjf0mhENz'**
  String get pLIPiKkSFpK8MdPQg72ceDNUGjf0mhENz;

  /// No description provided for @iEC4DBbzBI.
  ///
  /// In en, this message translates to:
  /// **'iEC4DBbzB-I'**
  String get iEC4DBbzBI;

  /// No description provided for @yf7VWSAbOU.
  ///
  /// In en, this message translates to:
  /// **'yf7VW-sAbOU'**
  String get yf7VWSAbOU;

  /// No description provided for @sF0QfbuHtQ.
  ///
  /// In en, this message translates to:
  /// **'S-F0QfbuHtQ'**
  String get sF0QfbuHtQ;

  /// No description provided for @yPcsflr52s.
  ///
  /// In en, this message translates to:
  /// **'yPcsflr-52s'**
  String get yPcsflr52s;

  /// No description provided for @md04meyJlA.
  ///
  /// In en, this message translates to:
  /// **'md0-4meyJlA'**
  String get md04meyJlA;

  /// No description provided for @iof4jeN6LG4.
  ///
  /// In en, this message translates to:
  /// **'Iof4jeN6LG4'**
  String get iof4jeN6LG4;

  /// No description provided for @label8FjmZttLM.
  ///
  /// In en, this message translates to:
  /// **'-8_fjmZttLM'**
  String get label8FjmZttLM;

  /// No description provided for @cCnli0HQ3IE.
  ///
  /// In en, this message translates to:
  /// **'CCnli0HQ3IE'**
  String get cCnli0HQ3IE;

  /// No description provided for @label8EXPB74Dyc.
  ///
  /// In en, this message translates to:
  /// **'8-EXPB74Dyc'**
  String get label8EXPB74Dyc;

  /// No description provided for @fULLMyDearGuardianJohnny.
  ///
  /// In en, this message translates to:
  /// **'【FULL】🕊️My Dear Guardian |  Johnny Huang, Li Qin | iQIYI Philippines'**
  String get fULLMyDearGuardianJohnny;

  /// No description provided for @fN0lxPL4Qa0.
  ///
  /// In en, this message translates to:
  /// **'FN0lxPL4Qa0'**
  String get fN0lxPL4Qa0;

  /// No description provided for @bjlqxe76Cc.
  ///
  /// In en, this message translates to:
  /// **'bjlqxe76-cc'**
  String get bjlqxe76Cc;

  /// No description provided for @pLIPiKkSFpKHKjDQgjOj98MaZq0gm.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK-_h-KjD_qgjOj98MaZq0gm'**
  String get pLIPiKkSFpKHKjDQgjOj98MaZq0gm;

  /// No description provided for @tcWqflGCUY.
  ///
  /// In en, this message translates to:
  /// **'TcWqflG-CUY'**
  String get tcWqflGCUY;

  /// No description provided for @rZfxh4rSg.
  ///
  /// In en, this message translates to:
  /// **'--rZfxh4rSg'**
  String get rZfxh4rSg;

  /// No description provided for @label1ORyfeHBGG.
  ///
  /// In en, this message translates to:
  /// **'1ORyfeHBG-g'**
  String get label1ORyfeHBGG;

  /// No description provided for @pLIPiKkSFpK9cwfQqamjvymbElQlrV6do.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK9cwfQqamjvymbElQlrV6do'**
  String get pLIPiKkSFpK9cwfQqamjvymbElQlrV6do;

  /// No description provided for @vKvu1urDSps.
  ///
  /// In en, this message translates to:
  /// **'VKvu1urDSps'**
  String get vKvu1urDSps;

  /// No description provided for @dB2fAHAIw30.
  ///
  /// In en, this message translates to:
  /// **'DB2fAHAIw30'**
  String get dB2fAHAIw30;

  /// No description provided for @pLlCrV9TCfzMYJebfwvzDDQzDFbY9XqvE.
  ///
  /// In en, this message translates to:
  /// **'PLlCrV9TCfzMYJebfwvzDDQzDFbY-9XqvE'**
  String get pLlCrV9TCfzMYJebfwvzDDQzDFbY9XqvE;

  /// No description provided for @theBestThingZhangLinghe.
  ///
  /// In en, this message translates to:
  /// **'🌸【治愈爱情】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | FULL正片 | iQIYI 👑Join the Membership and enjoy full episodes now!'**
  String get theBestThingZhangLinghe;

  /// No description provided for @h22R4lYT0QQ.
  ///
  /// In en, this message translates to:
  /// **'H22R4lYT0QQ'**
  String get h22R4lYT0QQ;

  /// No description provided for @a4CMqC9Hg.
  ///
  /// In en, this message translates to:
  /// **'A-4C-mqC9Hg'**
  String get a4CMqC9Hg;

  /// No description provided for @jJvSIEUsWY.
  ///
  /// In en, this message translates to:
  /// **'jJvSI-EUsWY'**
  String get jJvSIEUsWY;

  /// No description provided for @label94M1y8ivG.
  ///
  /// In en, this message translates to:
  /// **'94M1y8iv--g'**
  String get label94M1y8ivG;

  /// No description provided for @k50lO8uGHM.
  ///
  /// In en, this message translates to:
  /// **'K_50lO8uGHM'**
  String get k50lO8uGHM;

  /// No description provided for @eP012026RebirthChineseDrama.
  ///
  /// In en, this message translates to:
  /// **'📽️【EP01 2026】Rebirth Chinese Drama  ENGSUB | Li Yunrui / Huangyang Tiantian /Zhang Kangle ⛵😍 Historical Drama 2026 #冰湖重生'**
  String get eP012026RebirthChineseDrama;

  /// No description provided for @soRNQqVHiE.
  ///
  /// In en, this message translates to:
  /// **'SoRN-qqVHiE'**
  String get soRNQqVHiE;

  /// No description provided for @label0WKj11GO1k.
  ///
  /// In en, this message translates to:
  /// **'0WKj11G-O1k'**
  String get label0WKj11GO1k;

  /// No description provided for @mckn8scIT9M.
  ///
  /// In en, this message translates to:
  /// **'Mckn8scIT9M'**
  String get mckn8scIT9M;

  /// No description provided for @label3ouJb1XcvO.
  ///
  /// In en, this message translates to:
  /// **'3ouJb1Xcv-o'**
  String get label3ouJb1XcvO;

  /// No description provided for @oGOi5zR5GE.
  ///
  /// In en, this message translates to:
  /// **'OGOi5z-R5GE'**
  String get oGOi5zR5GE;

  /// No description provided for @oSCmrPPTm8.
  ///
  /// In en, this message translates to:
  /// **'oSCmrPPTm-8'**
  String get oSCmrPPTm8;

  /// No description provided for @fSBy5hig8pk.
  ///
  /// In en, this message translates to:
  /// **'FSBy5hig8pk'**
  String get fSBy5hig8pk;

  /// No description provided for @sC1tGve5Nr0.
  ///
  /// In en, this message translates to:
  /// **'SC1tGve5Nr0'**
  String get sC1tGve5Nr0;

  /// No description provided for @lYWUkqJk2E.
  ///
  /// In en, this message translates to:
  /// **'LYW-ukqJk2E'**
  String get lYWUkqJk2E;

  /// No description provided for @iXwhs66r7C.
  ///
  /// In en, this message translates to:
  /// **'IXwhs66r7_c'**
  String get iXwhs66r7C;

  /// No description provided for @hJ1qGBGVF14.
  ///
  /// In en, this message translates to:
  /// **'HJ1qGBGVF14'**
  String get hJ1qGBGVF14;

  /// No description provided for @xz1ZaLRTo.
  ///
  /// In en, this message translates to:
  /// **'xz1-Za_LRTo'**
  String get xz1ZaLRTo;

  /// No description provided for @pL6xVgUZ4UP2OaE8yjLqTIxq2XKePI7m7.
  ///
  /// In en, this message translates to:
  /// **'PL6xVgUZ4UP2OaE8yjLqTIxq2XKe-PI7m7'**
  String get pL6xVgUZ4UP2OaE8yjLqTIxq2XKePI7m7;

  /// No description provided for @xi7IXdkzYg.
  ///
  /// In en, this message translates to:
  /// **'Xi7IXdkz-yg'**
  String get xi7IXdkzYg;

  /// No description provided for @xMUzyFFGBS.
  ///
  /// In en, this message translates to:
  /// **'xMUzyFFGB-s'**
  String get xMUzyFFGBS;

  /// No description provided for @cAPUf0NVjfg.
  ///
  /// In en, this message translates to:
  /// **'CAPUf0NVjfg'**
  String get cAPUf0NVjfg;

  /// No description provided for @jObgd77gRVI.
  ///
  /// In en, this message translates to:
  /// **'JObgd77gRVI'**
  String get jObgd77gRVI;

  /// No description provided for @zAh5l4TSL44.
  ///
  /// In en, this message translates to:
  /// **'ZAh5l4TSL44'**
  String get zAh5l4TSL44;

  /// No description provided for @iH5Dhymb50.
  ///
  /// In en, this message translates to:
  /// **'IH-5Dhymb50'**
  String get iH5Dhymb50;

  /// No description provided for @pLIPiKkSFpKBxGpxeLaoE3RK1B27J2K.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK-BxGpxeLaoE3RK1-B27J2K'**
  String get pLIPiKkSFpKBxGpxeLaoE3RK1B27J2K;

  /// No description provided for @label5iTVfTFX1c.
  ///
  /// In en, this message translates to:
  /// **'5i-tVfTFX1c'**
  String get label5iTVfTFX1c;

  /// No description provided for @label2jKJSKqQlI.
  ///
  /// In en, this message translates to:
  /// **'2jKJSKq-qlI'**
  String get label2jKJSKqQlI;

  /// No description provided for @xTqeH63puw.
  ///
  /// In en, this message translates to:
  /// **'xTqe-h63puw'**
  String get xTqeH63puw;

  /// No description provided for @oazvgr9cyow.
  ///
  /// In en, this message translates to:
  /// **'Oazvgr9cyow'**
  String get oazvgr9cyow;

  /// No description provided for @fULLFatedHeartsLiQin.
  ///
  /// In en, this message translates to:
  /// **'【FULL】🏹Fated Hearts | Li Qin, Chen Zheyuan | iQIYI Philippines'**
  String get fULLFatedHeartsLiQin;

  /// No description provided for @kCYYUs6wGOY.
  ///
  /// In en, this message translates to:
  /// **'KCYYUs6wGOY'**
  String get kCYYUs6wGOY;

  /// No description provided for @tm2SyrqoQg.
  ///
  /// In en, this message translates to:
  /// **'tm2-SyrqoQg'**
  String get tm2SyrqoQg;

  /// No description provided for @qZ5uUGk9gmg.
  ///
  /// In en, this message translates to:
  /// **'QZ5uUGk9gmg'**
  String get qZ5uUGk9gmg;

  /// No description provided for @xETV6qEPY.
  ///
  /// In en, this message translates to:
  /// **'XETV6qE-P_Y'**
  String get xETV6qEPY;

  /// No description provided for @label8rWW83nQVE.
  ///
  /// In en, this message translates to:
  /// **'-8rWW83nQVE'**
  String get label8rWW83nQVE;

  /// No description provided for @zd4MuxKNDE.
  ///
  /// In en, this message translates to:
  /// **'zd-4MuxKNDE'**
  String get zd4MuxKNDE;

  /// No description provided for @s2pk7pn3go4.
  ///
  /// In en, this message translates to:
  /// **'S2pk7pn3go4'**
  String get s2pk7pn3go4;

  /// No description provided for @hQvrj4X9Frg.
  ///
  /// In en, this message translates to:
  /// **'HQvrj4X9Frg'**
  String get hQvrj4X9Frg;

  /// No description provided for @fc8AWtgpGY.
  ///
  /// In en, this message translates to:
  /// **'fc-8AWtgpGY'**
  String get fc8AWtgpGY;

  /// No description provided for @zPgeg1zFU1s.
  ///
  /// In en, this message translates to:
  /// **'ZPgeg1zFU1s'**
  String get zPgeg1zFU1s;

  /// No description provided for @iYjOKBPzxE.
  ///
  /// In en, this message translates to:
  /// **'iYjOK-bPzxE'**
  String get iYjOKBPzxE;

  /// No description provided for @label6DmBfkWs4I.
  ///
  /// In en, this message translates to:
  /// **'-6DmBfkWs4I'**
  String get label6DmBfkWs4I;

  /// No description provided for @label3JUCW6WIY.
  ///
  /// In en, this message translates to:
  /// **'-3JUC-w6WIY'**
  String get label3JUCW6WIY;

  /// No description provided for @sJ22yMn4qfY.
  ///
  /// In en, this message translates to:
  /// **'SJ22yMn4qfY'**
  String get sJ22yMn4qfY;

  /// No description provided for @ono7fMWcfcg.
  ///
  /// In en, this message translates to:
  /// **'Ono7fMWcfcg'**
  String get ono7fMWcfcg;

  /// No description provided for @txW0Ss7D50.
  ///
  /// In en, this message translates to:
  /// **'txW-0Ss7D50'**
  String get txW0Ss7D50;

  /// No description provided for @pLIPiKkSFpK9dJRiyjRahGpG8woGS9Sl2.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK9dJRiyjRahGpG8woGS9Sl2'**
  String get pLIPiKkSFpK9dJRiyjRahGpG8woGS9Sl2;

  /// No description provided for @mVab12IKYMA.
  ///
  /// In en, this message translates to:
  /// **'MVab12IKYMA'**
  String get mVab12IKYMA;

  /// No description provided for @zLABLPu8ik.
  ///
  /// In en, this message translates to:
  /// **'Z-lABLPu8ik'**
  String get zLABLPu8ik;

  /// No description provided for @hCoJMcrjQ.
  ///
  /// In en, this message translates to:
  /// **'hCoJ_-McrjQ'**
  String get hCoJMcrjQ;

  /// No description provided for @eRyFDWPR4.
  ///
  /// In en, this message translates to:
  /// **'e_ry-fDWPR4'**
  String get eRyFDWPR4;

  /// No description provided for @mAvoRUd3wU.
  ///
  /// In en, this message translates to:
  /// **'MAvoRUd-3wU'**
  String get mAvoRUd3wU;

  /// No description provided for @dWExvMyVU.
  ///
  /// In en, this message translates to:
  /// **'dW-ExvMyV-U'**
  String get dWExvMyVU;

  /// No description provided for @bPKuepfUA.
  ///
  /// In en, this message translates to:
  /// **'-bPKuepf_UA'**
  String get bPKuepfUA;

  /// No description provided for @fBj8DL4EF0.
  ///
  /// In en, this message translates to:
  /// **'fBj8D-L4EF0'**
  String get fBj8DL4EF0;

  /// No description provided for @pLIPiKkSFpK87slgXbMjH686D5Y9P0EuG.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK87slgXbMjH686D5Y9P0EuG'**
  String get pLIPiKkSFpK87slgXbMjH686D5Y9P0EuG;

  /// No description provided for @k0Gl3FEW4s.
  ///
  /// In en, this message translates to:
  /// **'K0Gl-3FEW4s'**
  String get k0Gl3FEW4s;

  /// No description provided for @shHZmbjrqI.
  ///
  /// In en, this message translates to:
  /// **'-shHZmbjrqI'**
  String get shHZmbjrqI;

  /// No description provided for @label7X5IzmrLCw.
  ///
  /// In en, this message translates to:
  /// **'7-X5IzmrLCw'**
  String get label7X5IzmrLCw;

  /// No description provided for @nI1kp3v97O.
  ///
  /// In en, this message translates to:
  /// **'nI1kp3v97-o'**
  String get nI1kp3v97O;

  /// No description provided for @ea8enhWKTo0.
  ///
  /// In en, this message translates to:
  /// **'Ea8enhWKTo0'**
  String get ea8enhWKTo0;

  /// No description provided for @yL0RBWIo2iw.
  ///
  /// In en, this message translates to:
  /// **'YL0RBWIo2iw'**
  String get yL0RBWIo2iw;

  /// No description provided for @hX1u0R19FY.
  ///
  /// In en, this message translates to:
  /// **'H_x1u0R19FY'**
  String get hX1u0R19FY;

  /// No description provided for @cEGtoc5chDc.
  ///
  /// In en, this message translates to:
  /// **'CEGtoc5chDc'**
  String get cEGtoc5chDc;

  /// No description provided for @qXKk36teGLc.
  ///
  /// In en, this message translates to:
  /// **'QXKk36teGLc'**
  String get qXKk36teGLc;

  /// No description provided for @pLIPiKkSFpKZTWsxZO5xUAlAsUEFOl3K.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK-zTWsxZO5xUAlAsUEFOl3K'**
  String get pLIPiKkSFpKZTWsxZO5xUAlAsUEFOl3K;

  /// No description provided for @mtO6K9Y59Q.
  ///
  /// In en, this message translates to:
  /// **'Mt_o6K9Y59Q'**
  String get mtO6K9Y59Q;

  /// No description provided for @kVop5QZCM.
  ///
  /// In en, this message translates to:
  /// **'kVop_5QZ-cM'**
  String get kVop5QZCM;

  /// No description provided for @lX8cA1yLAg.
  ///
  /// In en, this message translates to:
  /// **'l-X8cA1yLAg'**
  String get lX8cA1yLAg;

  /// No description provided for @v7m8WNX1gxE.
  ///
  /// In en, this message translates to:
  /// **'V7m8WNX1gxE'**
  String get v7m8WNX1gxE;

  /// No description provided for @bGf1clBUq0.
  ///
  /// In en, this message translates to:
  /// **'BGf1clB_uq0'**
  String get bGf1clBUq0;

  /// No description provided for @lPA6cWd9vqA.
  ///
  /// In en, this message translates to:
  /// **'LPA6cWd9vqA'**
  String get lPA6cWd9vqA;

  /// No description provided for @pfckLVY64.
  ///
  /// In en, this message translates to:
  /// **'-Pfck_LVY64'**
  String get pfckLVY64;

  /// No description provided for @pLIPiKkSFpKN3T51FbkSIbF5IQ0RxhVm.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK_n3T51FbkSIbF5IQ0RxhVm'**
  String get pLIPiKkSFpKN3T51FbkSIbF5IQ0RxhVm;

  /// No description provided for @aH80GizsvY.
  ///
  /// In en, this message translates to:
  /// **'AH8-0GizsvY'**
  String get aH80GizsvY;

  /// No description provided for @jI2ISWehQ.
  ///
  /// In en, this message translates to:
  /// **'jI2IS-Weh_Q'**
  String get jI2ISWehQ;

  /// No description provided for @label7rwGdyAl0g.
  ///
  /// In en, this message translates to:
  /// **'7rw-gdyAl0g'**
  String get label7rwGdyAl0g;

  /// No description provided for @kF4rfnm9qdo.
  ///
  /// In en, this message translates to:
  /// **'KF4rfnm9qdo'**
  String get kF4rfnm9qdo;

  /// No description provided for @v1ae2rgrl70.
  ///
  /// In en, this message translates to:
  /// **'V1ae2rgrl70'**
  String get v1ae2rgrl70;

  /// No description provided for @c9D8kCt3k.
  ///
  /// In en, this message translates to:
  /// **'C9D8k_-Ct3k'**
  String get c9D8kCt3k;

  /// No description provided for @zY4ALWb5lw.
  ///
  /// In en, this message translates to:
  /// **'ZY4AL-wb5lw'**
  String get zY4ALWb5lw;

  /// No description provided for @qUvwUdI73Y.
  ///
  /// In en, this message translates to:
  /// **'q-UvwUdI73Y'**
  String get qUvwUdI73Y;

  /// No description provided for @iT670fTpFQ.
  ///
  /// In en, this message translates to:
  /// **'iT-670fTpFQ'**
  String get iT670fTpFQ;

  /// No description provided for @b6t7LGBPK.
  ///
  /// In en, this message translates to:
  /// **'b6t_7LGBP-k'**
  String get b6t7LGBPK;

  /// No description provided for @w9QYDN3nxTc.
  ///
  /// In en, this message translates to:
  /// **'W9QYDN3nxTc'**
  String get w9QYDN3nxTc;

  /// No description provided for @w9NPQe4Z5kE.
  ///
  /// In en, this message translates to:
  /// **'W9NPQe4Z5kE'**
  String get w9NPQe4Z5kE;

  /// No description provided for @tQSHAlsaxqw.
  ///
  /// In en, this message translates to:
  /// **'TQSHAlsaxqw'**
  String get tQSHAlsaxqw;

  /// No description provided for @tN0ATkrc2zw.
  ///
  /// In en, this message translates to:
  /// **'TN0ATkrc2zw'**
  String get tN0ATkrc2zw;

  /// No description provided for @label7tsZeZfLtI.
  ///
  /// In en, this message translates to:
  /// **'7tsZeZfLt-I'**
  String get label7tsZeZfLtI;

  /// No description provided for @w59SaAa6Ck.
  ///
  /// In en, this message translates to:
  /// **'W59Sa_Aa6Ck'**
  String get w59SaAa6Ck;

  /// No description provided for @lSBiko45p8U.
  ///
  /// In en, this message translates to:
  /// **'LSBiko45p8U'**
  String get lSBiko45p8U;

  /// No description provided for @t2PwfV1JIE.
  ///
  /// In en, this message translates to:
  /// **'T2PwfV1J-iE'**
  String get t2PwfV1JIE;

  /// No description provided for @bz75CXZ3c.
  ///
  /// In en, this message translates to:
  /// **'Bz75CX-z_3c'**
  String get bz75CXZ3c;

  /// No description provided for @nEEt9D9uR4g.
  ///
  /// In en, this message translates to:
  /// **'NEEt9D9uR4g'**
  String get nEEt9D9uR4g;

  /// No description provided for @dFv86C0wEg8.
  ///
  /// In en, this message translates to:
  /// **'DFv86C0wEg8'**
  String get dFv86C0wEg8;

  /// No description provided for @nWijSsYBUI.
  ///
  /// In en, this message translates to:
  /// **'nWijSsYBU-I'**
  String get nWijSsYBUI;

  /// No description provided for @ui2O9fffvWM.
  ///
  /// In en, this message translates to:
  /// **'Ui2O9fffvWM'**
  String get ui2O9fffvWM;

  /// No description provided for @kMK9ZIL5vIE.
  ///
  /// In en, this message translates to:
  /// **'KMK9ZIL5vIE'**
  String get kMK9ZIL5vIE;

  /// No description provided for @pZxPXGSNk.
  ///
  /// In en, this message translates to:
  /// **'pZx_pXG-sNk'**
  String get pZxPXGSNk;

  /// No description provided for @lGe1BEo7wL8.
  ///
  /// In en, this message translates to:
  /// **'LGe1BEo7wL8'**
  String get lGe1BEo7wL8;

  /// No description provided for @wtVVEt4NxI.
  ///
  /// In en, this message translates to:
  /// **'WtVVEt4Nx-I'**
  String get wtVVEt4NxI;

  /// No description provided for @ggXL7dEPA.
  ///
  /// In en, this message translates to:
  /// **'Gg-xL7d-ePA'**
  String get ggXL7dEPA;

  /// No description provided for @mPO0drxj4XI.
  ///
  /// In en, this message translates to:
  /// **'MPO0drxj4XI'**
  String get mPO0drxj4XI;

  /// No description provided for @qYkUzAJo.
  ///
  /// In en, this message translates to:
  /// **'--q_ykUzAJo'**
  String get qYkUzAJo;

  /// No description provided for @mU4PJGdOxg.
  ///
  /// In en, this message translates to:
  /// **'mU4PJGd-oxg'**
  String get mU4PJGdOxg;

  /// No description provided for @hOWSRDXSjb4.
  ///
  /// In en, this message translates to:
  /// **'HOWSRDXSjb4'**
  String get hOWSRDXSjb4;

  /// No description provided for @nttqxJL3ES.
  ///
  /// In en, this message translates to:
  /// **'nttqxJL3E-s'**
  String get nttqxJL3ES;

  /// No description provided for @tJCmewUT4O.
  ///
  /// In en, this message translates to:
  /// **'tJCmewUT4-o'**
  String get tJCmewUT4O;

  /// No description provided for @sp7QFdPm3o.
  ///
  /// In en, this message translates to:
  /// **'Sp7Q-FdPm3o'**
  String get sp7QFdPm3o;

  /// No description provided for @qI7c50Jcxbk.
  ///
  /// In en, this message translates to:
  /// **'QI7c50Jcxbk'**
  String get qI7c50Jcxbk;

  /// No description provided for @tM0RxsWCms.
  ///
  /// In en, this message translates to:
  /// **'tM0Rxs-wCms'**
  String get tM0RxsWCms;

  /// No description provided for @pLIPiKkSFpK6Iyv3Gsa1hZqwSLQ4z34u.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK_6Iyv3Gsa1hZqwSLQ4z34u'**
  String get pLIPiKkSFpK6Iyv3Gsa1hZqwSLQ4z34u;

  /// No description provided for @p1c9AW9VNY.
  ///
  /// In en, this message translates to:
  /// **'p1c9-aW9VNY'**
  String get p1c9AW9VNY;

  /// No description provided for @eTwGAe5RiM.
  ///
  /// In en, this message translates to:
  /// **'e-TwGAe5RiM'**
  String get eTwGAe5RiM;

  /// No description provided for @vSDFc4ivKU.
  ///
  /// In en, this message translates to:
  /// **'VSD-Fc4ivKU'**
  String get vSDFc4ivKU;

  /// No description provided for @label2UNAa30mF0.
  ///
  /// In en, this message translates to:
  /// **'2U-nAa30mF0'**
  String get label2UNAa30mF0;

  /// No description provided for @iLP6X3nSYE.
  ///
  /// In en, this message translates to:
  /// **'I-LP6X3nSYE'**
  String get iLP6X3nSYE;

  /// No description provided for @mo4kd8rg3yU.
  ///
  /// In en, this message translates to:
  /// **'Mo4kd8rg3yU'**
  String get mo4kd8rg3yU;

  /// No description provided for @xt8m39rI9o.
  ///
  /// In en, this message translates to:
  /// **'Xt8m_39rI9o'**
  String get xt8m39rI9o;

  /// No description provided for @oFLWTHOJJo.
  ///
  /// In en, this message translates to:
  /// **'OFLWTHO-jJo'**
  String get oFLWTHOJJo;

  /// No description provided for @pLlRMBKO6RkY69nj6AJ051lj7vSGrkNxZ.
  ///
  /// In en, this message translates to:
  /// **'PLlRMBK-O6RkY69nj6AJ051lj7vSGrkNxZ'**
  String get pLlRMBKO6RkY69nj6AJ051lj7vSGrkNxZ;

  /// No description provided for @label3gTpyQenT0.
  ///
  /// In en, this message translates to:
  /// **'3gTpy-qenT0'**
  String get label3gTpyQenT0;

  /// No description provided for @nM3BDMI4YS.
  ///
  /// In en, this message translates to:
  /// **'nM3BDMI4Y-s'**
  String get nM3BDMI4YS;

  /// No description provided for @hudgy0oFTz4.
  ///
  /// In en, this message translates to:
  /// **'Hudgy0oFTz4'**
  String get hudgy0oFTz4;

  /// No description provided for @lVc0U1sJIBU.
  ///
  /// In en, this message translates to:
  /// **'LVc0U1sJIBU'**
  String get lVc0U1sJIBU;

  /// No description provided for @gBTqOwTPTU.
  ///
  /// In en, this message translates to:
  /// **'G-BTqOwTPTU'**
  String get gBTqOwTPTU;

  /// No description provided for @tN0iGRSk.
  ///
  /// In en, this message translates to:
  /// **'_T-N-0iGRSk'**
  String get tN0iGRSk;

  /// No description provided for @gkEBMyB9TM.
  ///
  /// In en, this message translates to:
  /// **'gkEBMy-B9TM'**
  String get gkEBMyB9TM;

  /// No description provided for @bw3XWYzoI.
  ///
  /// In en, this message translates to:
  /// **'-bw3XWYzo-I'**
  String get bw3XWYzoI;

  /// No description provided for @fullBrightEyesInThe.
  ///
  /// In en, this message translates to:
  /// **'【Full】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Philippines'**
  String get fullBrightEyesInThe;

  /// No description provided for @jalmOqeImY.
  ///
  /// In en, this message translates to:
  /// **'JalmOqeIm-Y'**
  String get jalmOqeImY;

  /// No description provided for @vUuzPUBkas.
  ///
  /// In en, this message translates to:
  /// **'V-UuzPUBkas'**
  String get vUuzPUBkas;

  /// No description provided for @ni1jN2ECMY.
  ///
  /// In en, this message translates to:
  /// **'Ni1j-N2ECMY'**
  String get ni1jN2ECMY;

  /// No description provided for @v5qeq2caORg.
  ///
  /// In en, this message translates to:
  /// **'V5qeq2caORg'**
  String get v5qeq2caORg;

  /// No description provided for @cB64rYJ2tX4.
  ///
  /// In en, this message translates to:
  /// **'CB64rYJ2tX4'**
  String get cB64rYJ2tX4;

  /// No description provided for @qwyz2k6oymc.
  ///
  /// In en, this message translates to:
  /// **'Qwyz2k6oymc'**
  String get qwyz2k6oymc;

  /// No description provided for @gQYaqUf4.
  ///
  /// In en, this message translates to:
  /// **'GQ_-_YaqUf4'**
  String get gQYaqUf4;

  /// No description provided for @tqHC6KtyoI.
  ///
  /// In en, this message translates to:
  /// **'tqHC6-ktyoI'**
  String get tqHC6KtyoI;

  /// No description provided for @hvsJOV10Q.
  ///
  /// In en, this message translates to:
  /// **'hvsJOV-_10Q'**
  String get hvsJOV10Q;

  /// No description provided for @label9LFPEXffyQ.
  ///
  /// In en, this message translates to:
  /// **'-9LFPEXffyQ'**
  String get label9LFPEXffyQ;

  /// No description provided for @bMbhR77eps.
  ///
  /// In en, this message translates to:
  /// **'b-MbhR77eps'**
  String get bMbhR77eps;

  /// No description provided for @olkxX4m0m4.
  ///
  /// In en, this message translates to:
  /// **'OlkxX-4m0m4'**
  String get olkxX4m0m4;

  /// No description provided for @vE8nY1UC2zo.
  ///
  /// In en, this message translates to:
  /// **'VE8nY1UC2zo'**
  String get vE8nY1UC2zo;

  /// No description provided for @pLIPiKkSFpKZjc5dsVYfFD44oWYA1YZ.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK-Zjc5dsVYfFD44oWYA-1YZ'**
  String get pLIPiKkSFpKZjc5dsVYfFD44oWYA1YZ;

  /// No description provided for @gZDlH6PN3M.
  ///
  /// In en, this message translates to:
  /// **'gZDlH6P-n3M'**
  String get gZDlH6PN3M;

  /// No description provided for @iw4jJBB5z7A.
  ///
  /// In en, this message translates to:
  /// **'Iw4jJBB5z7A'**
  String get iw4jJBB5z7A;

  /// No description provided for @hOTu6yklewA.
  ///
  /// In en, this message translates to:
  /// **'HOTu6yklewA'**
  String get hOTu6yklewA;

  /// No description provided for @vJqSl1U6CE.
  ///
  /// In en, this message translates to:
  /// **'-VJqSl1U6CE'**
  String get vJqSl1U6CE;

  /// No description provided for @yF3ZBEnNaA.
  ///
  /// In en, this message translates to:
  /// **'YF-3ZBEnNaA'**
  String get yF3ZBEnNaA;

  /// No description provided for @at8v7Xp7XX4.
  ///
  /// In en, this message translates to:
  /// **'At8v7Xp7XX4'**
  String get at8v7Xp7XX4;

  /// No description provided for @ctXWz6p3RI.
  ///
  /// In en, this message translates to:
  /// **'-CtXWz6p3RI'**
  String get ctXWz6p3RI;

  /// No description provided for @gsuEr3Rwo.
  ///
  /// In en, this message translates to:
  /// **'GsuEr3--Rwo'**
  String get gsuEr3Rwo;

  /// No description provided for @cvkAplxMt0.
  ///
  /// In en, this message translates to:
  /// **'-CvkAplxMt0'**
  String get cvkAplxMt0;

  /// No description provided for @ssQiWv0MEA.
  ///
  /// In en, this message translates to:
  /// **'SsQiWv0M-eA'**
  String get ssQiWv0MEA;

  /// No description provided for @aaDlYQswEc.
  ///
  /// In en, this message translates to:
  /// **'aaDl-YQswEc'**
  String get aaDlYQswEc;

  /// No description provided for @oaDLF7MQF0.
  ///
  /// In en, this message translates to:
  /// **'Oa_DLF7MQF0'**
  String get oaDLF7MQF0;

  /// No description provided for @pLIPiKkSFpK9jSaLiXXKZUvwfh7ROuLy.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK9jSaLiXX_KZUvwfh7ROuLy'**
  String get pLIPiKkSFpK9jSaLiXXKZUvwfh7ROuLy;

  /// No description provided for @g0nqbugnDI.
  ///
  /// In en, this message translates to:
  /// **'G_0nqbugnDI'**
  String get g0nqbugnDI;

  /// No description provided for @tnHgUzjPNQ.
  ///
  /// In en, this message translates to:
  /// **'TnHgUzj-pNQ'**
  String get tnHgUzjPNQ;

  /// No description provided for @nM7ZeWM1g.
  ///
  /// In en, this message translates to:
  /// **'n-m7ZeW-m1g'**
  String get nM7ZeWM1g;

  /// No description provided for @sUqbEIap2M.
  ///
  /// In en, this message translates to:
  /// **'-sUqbEIap2M'**
  String get sUqbEIap2M;

  /// No description provided for @x0qW6MwABw.
  ///
  /// In en, this message translates to:
  /// **'X0qW6Mw-ABw'**
  String get x0qW6MwABw;

  /// No description provided for @lANXfM0Hmc.
  ///
  /// In en, this message translates to:
  /// **'L-aNXfM0Hmc'**
  String get lANXfM0Hmc;

  /// No description provided for @y84UUFKMZf4.
  ///
  /// In en, this message translates to:
  /// **'Y84UUFKMZf4'**
  String get y84UUFKMZf4;

  /// No description provided for @mGPFI2bfKPE.
  ///
  /// In en, this message translates to:
  /// **'MGPFI2bfKPE'**
  String get mGPFI2bfKPE;

  /// No description provided for @f3wSwhf0z8.
  ///
  /// In en, this message translates to:
  /// **'F3w_swhf0z8'**
  String get f3wSwhf0z8;

  /// No description provided for @qFITVBXVj2g.
  ///
  /// In en, this message translates to:
  /// **'QFITVBXVj2g'**
  String get qFITVBXVj2g;

  /// No description provided for @pLyT8L9yeLXCR7t2xuK0L7L4qIRBTnA2n.
  ///
  /// In en, this message translates to:
  /// **'PLyT8L9yeLXCR7t2xuK0-L7L4qIRBTnA2n'**
  String get pLyT8L9yeLXCR7t2xuK0L7L4qIRBTnA2n;

  /// No description provided for @aY1Wv805lUw.
  ///
  /// In en, this message translates to:
  /// **'AY1Wv805lUw'**
  String get aY1Wv805lUw;

  /// No description provided for @w44Q3K2QJY.
  ///
  /// In en, this message translates to:
  /// **'W44-q3K2QJY'**
  String get w44Q3K2QJY;

  /// No description provided for @kJn1gifAmok.
  ///
  /// In en, this message translates to:
  /// **'KJn1gifAmok'**
  String get kJn1gifAmok;

  /// No description provided for @xwEsWU6WI.
  ///
  /// In en, this message translates to:
  /// **'xwEs-WU6_wI'**
  String get xwEsWU6WI;

  /// No description provided for @gt93TaUaco.
  ///
  /// In en, this message translates to:
  /// **'gt9-3TaUaco'**
  String get gt93TaUaco;

  /// No description provided for @label0C62qBO6o.
  ///
  /// In en, this message translates to:
  /// **'0_c62q-bO6o'**
  String get label0C62qBO6o;

  /// No description provided for @label7DqIz7YqcA.
  ///
  /// In en, this message translates to:
  /// **'7Dq-iz7YqcA'**
  String get label7DqIz7YqcA;

  /// No description provided for @xh5K9iCMoo.
  ///
  /// In en, this message translates to:
  /// **'xh5K9iC-Moo'**
  String get xh5K9iCMoo;

  /// No description provided for @aKGp1lOCRTI.
  ///
  /// In en, this message translates to:
  /// **'AKGp1lOCRTI'**
  String get aKGp1lOCRTI;

  /// No description provided for @jWYI2dtDE0.
  ///
  /// In en, this message translates to:
  /// **'JWY_i2dtDE0'**
  String get jWYI2dtDE0;

  /// No description provided for @yWHZCsskuvo.
  ///
  /// In en, this message translates to:
  /// **'YWHZCsskuvo'**
  String get yWHZCsskuvo;

  /// No description provided for @label76Z43cwXKQ.
  ///
  /// In en, this message translates to:
  /// **'76Z43cw-xKQ'**
  String get label76Z43cwXKQ;

  /// No description provided for @cINtsiKIx4.
  ///
  /// In en, this message translates to:
  /// **'CINtsi-kIx4'**
  String get cINtsiKIx4;

  /// No description provided for @eNGSUBChineseFantasyMovie.
  ///
  /// In en, this message translates to:
  /// **'🎥✨【ENG SUB】Chinese Fantasy Movie | Fantasy、Adventure【 iQIYI MOVIE THEATER-Welcome to subscribe】'**
  String get eNGSUBChineseFantasyMovie;

  /// No description provided for @iQIYIMOVIETHEATERGetThe.
  ///
  /// In en, this message translates to:
  /// **'爱奇艺大电影 iQIYI MOVIE THEATER - Get the iQIYI APP'**
  String get iQIYIMOVIETHEATERGetThe;

  /// No description provided for @oNi1Mh97lYo.
  ///
  /// In en, this message translates to:
  /// **'ONi1Mh97lYo'**
  String get oNi1Mh97lYo;

  /// No description provided for @sF74vcQwZE.
  ///
  /// In en, this message translates to:
  /// **'sF74vc-qwZE'**
  String get sF74vcQwZE;

  /// No description provided for @qBQ1xvkvQHw.
  ///
  /// In en, this message translates to:
  /// **'QBQ1xvkvQHw'**
  String get qBQ1xvkvQHw;

  /// No description provided for @s2HdHtZAU.
  ///
  /// In en, this message translates to:
  /// **'S2HdHtZ_A-U'**
  String get s2HdHtZAU;

  /// No description provided for @pyt8OISpH0.
  ///
  /// In en, this message translates to:
  /// **'Pyt8O-ISpH0'**
  String get pyt8OISpH0;

  /// No description provided for @x5oUtpXWQ.
  ///
  /// In en, this message translates to:
  /// **'X5oUtp_X_wQ'**
  String get x5oUtpXWQ;

  /// No description provided for @miniDramaENGSUBFull.
  ///
  /// In en, this message translates to:
  /// **'🎀【微短剧 Mini Drama】ENG SUB | Full Version Collection | Download WeTV / Tencent Video APP to Watch More'**
  String get miniDramaENGSUBFull;

  /// No description provided for @vZysxG7Jdg.
  ///
  /// In en, this message translates to:
  /// **'V-zysxG7Jdg'**
  String get vZysxG7Jdg;

  /// No description provided for @aLCm1V4uj8.
  ///
  /// In en, this message translates to:
  /// **'aL-Cm1V4uj8'**
  String get aLCm1V4uj8;

  /// No description provided for @xk8guI5XC7I.
  ///
  /// In en, this message translates to:
  /// **'Xk8guI5XC7I'**
  String get xk8guI5XC7I;

  /// No description provided for @woIZMiblY.
  ///
  /// In en, this message translates to:
  /// **'Wo--IZMiblY'**
  String get woIZMiblY;

  /// No description provided for @e0Z1n9lVyg.
  ///
  /// In en, this message translates to:
  /// **'E0Z1n-9lVyg'**
  String get e0Z1n9lVyg;

  /// No description provided for @rakZAuY6Xc.
  ///
  /// In en, this message translates to:
  /// **'RakZ-auY6Xc'**
  String get rakZAuY6Xc;

  /// No description provided for @rW5f3p84.
  ///
  /// In en, this message translates to:
  /// **'RW_5f-_3p84'**
  String get rW5f3p84;

  /// No description provided for @wMtyXWrQRY.
  ///
  /// In en, this message translates to:
  /// **'wMtyXWrQ-rY'**
  String get wMtyXWrQRY;

  /// No description provided for @bQj9Q1GRnrk.
  ///
  /// In en, this message translates to:
  /// **'BQj9Q1GRnrk'**
  String get bQj9Q1GRnrk;

  /// No description provided for @ezD9rGwMk.
  ///
  /// In en, this message translates to:
  /// **'-EzD9r_GwMk'**
  String get ezD9rGwMk;

  /// No description provided for @pLIPiKkSFpK8hfRCOdc3tpxnj6JmGAZoc.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8hfRCOdc3tpxnj6JmGAZoc'**
  String get pLIPiKkSFpK8hfRCOdc3tpxnj6JmGAZoc;

  /// No description provided for @bSt0NgJemE.
  ///
  /// In en, this message translates to:
  /// **'-bSt0NgJemE'**
  String get bSt0NgJemE;

  /// No description provided for @zwSSFibKM.
  ///
  /// In en, this message translates to:
  /// **'zwSSFib-_kM'**
  String get zwSSFibKM;

  /// No description provided for @rFPkjQgdwQ.
  ///
  /// In en, this message translates to:
  /// **'rFPkjQgdw-Q'**
  String get rFPkjQgdwQ;

  /// No description provided for @label0BgIjnISU.
  ///
  /// In en, this message translates to:
  /// **'0BgIjnIS-_U'**
  String get label0BgIjnISU;

  /// No description provided for @o1mRObiOog.
  ///
  /// In en, this message translates to:
  /// **'O-1mRObiOog'**
  String get o1mRObiOog;

  /// No description provided for @yHkKXeRbbk.
  ///
  /// In en, this message translates to:
  /// **'YHk-KXeRbbk'**
  String get yHkKXeRbbk;

  /// No description provided for @label0E4CVmwEv0.
  ///
  /// In en, this message translates to:
  /// **'0E4-CVmwEv0'**
  String get label0E4CVmwEv0;

  /// No description provided for @n220nwxfsgY.
  ///
  /// In en, this message translates to:
  /// **'N220nwxfsgY'**
  String get n220nwxfsgY;

  /// No description provided for @rZQc0wk8Y4c.
  ///
  /// In en, this message translates to:
  /// **'RZQc0wk8Y4c'**
  String get rZQc0wk8Y4c;

  /// No description provided for @uIV6jneTw.
  ///
  /// In en, this message translates to:
  /// **'U_i-v6jneTw'**
  String get uIV6jneTw;

  /// No description provided for @fullBeautyOfResilienceJu.
  ///
  /// In en, this message translates to:
  /// **'【Full】Beauty of Resilience | Ju Jing Yi, Fiction | iQIYI Philippines'**
  String get fullBeautyOfResilienceJu;

  /// No description provided for @tT8V4eOewkc.
  ///
  /// In en, this message translates to:
  /// **'TT8V4eOewkc'**
  String get tT8V4eOewkc;

  /// No description provided for @a6D40BKYc9Y.
  ///
  /// In en, this message translates to:
  /// **'A6D40BKYc9Y'**
  String get a6D40BKYc9Y;

  /// No description provided for @gd5lvL1Y3UI.
  ///
  /// In en, this message translates to:
  /// **'Gd5lvL1Y3UI'**
  String get gd5lvL1Y3UI;

  /// No description provided for @bhrmf6kUnc.
  ///
  /// In en, this message translates to:
  /// **'Bhrmf6k_Unc'**
  String get bhrmf6kUnc;

  /// No description provided for @zajsQ18HyM.
  ///
  /// In en, this message translates to:
  /// **'Zajs-Q18HyM'**
  String get zajsQ18HyM;

  /// No description provided for @za9iO7xrdhU.
  ///
  /// In en, this message translates to:
  /// **'Za9iO7xrdhU'**
  String get za9iO7xrdhU;

  /// No description provided for @cCi69c44BTY.
  ///
  /// In en, this message translates to:
  /// **'CCi69c44BTY'**
  String get cCi69c44BTY;

  /// No description provided for @c5Lnqm4FI5s.
  ///
  /// In en, this message translates to:
  /// **'C5Lnqm4FI5s'**
  String get c5Lnqm4FI5s;

  /// No description provided for @bXr6Zu7EH3g.
  ///
  /// In en, this message translates to:
  /// **'BXr6Zu7EH3g'**
  String get bXr6Zu7EH3g;

  /// No description provided for @pLIPiKkSFpK85Ldm2HSl0Xwj2hN7T59g.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK85Ldm2HSl-0Xwj2hN7T59g'**
  String get pLIPiKkSFpK85Ldm2HSl0Xwj2hN7T59g;

  /// No description provided for @pLWIh6wofY4.
  ///
  /// In en, this message translates to:
  /// **'PLWIh6wofY4'**
  String get pLWIh6wofY4;

  /// No description provided for @label3YVDQD5Onc.
  ///
  /// In en, this message translates to:
  /// **'3-yVDQD5Onc'**
  String get label3YVDQD5Onc;

  /// No description provided for @iPxGP1UGnM.
  ///
  /// In en, this message translates to:
  /// **'IPx-GP1UGnM'**
  String get iPxGP1UGnM;

  /// No description provided for @hotTrendingMoonlitReunionFull.
  ///
  /// In en, this message translates to:
  /// **'🔥Hot Trending【子夜归 Moonlit Reunion】Full EPS | Human and Demon fall in love while solving mysteries | Xu Kai, Tian Xiwei | ENG SUB'**
  String get hotTrendingMoonlitReunionFull;

  /// No description provided for @v7niIXnWWM.
  ///
  /// In en, this message translates to:
  /// **'v7ni-iXnWWM'**
  String get v7niIXnWWM;

  /// No description provided for @vQ5PKKJSVHc.
  ///
  /// In en, this message translates to:
  /// **'VQ5PKKJSVHc'**
  String get vQ5PKKJSVHc;

  /// No description provided for @hWuKG1vJe0.
  ///
  /// In en, this message translates to:
  /// **'hWu-kG1vJe0'**
  String get hWuKG1vJe0;

  /// No description provided for @ydHHEma2Q.
  ///
  /// In en, this message translates to:
  /// **'-ydHH-ema2Q'**
  String get ydHHEma2Q;

  /// No description provided for @w6SB0R7W1U.
  ///
  /// In en, this message translates to:
  /// **'W6-SB0R7W1U'**
  String get w6SB0R7W1U;

  /// No description provided for @kwjhz1XOLhs.
  ///
  /// In en, this message translates to:
  /// **'Kwjhz1XOLhs'**
  String get kwjhz1XOLhs;

  /// No description provided for @cmyjS5zTQ.
  ///
  /// In en, this message translates to:
  /// **'-cmyjS-5zTQ'**
  String get cmyjS5zTQ;

  /// No description provided for @label8DzphxFJPI.
  ///
  /// In en, this message translates to:
  /// **'8-DzphxFJPI'**
  String get label8DzphxFJPI;

  /// No description provided for @gzjc1eGV22g.
  ///
  /// In en, this message translates to:
  /// **'Gzjc1eGV22g'**
  String get gzjc1eGV22g;

  /// No description provided for @y9ZHRA9lxcg.
  ///
  /// In en, this message translates to:
  /// **'Y9ZHRA9lxcg'**
  String get y9ZHRA9lxcg;

  /// No description provided for @mnfa5S7KO8.
  ///
  /// In en, this message translates to:
  /// **'Mnfa5_S7KO8'**
  String get mnfa5S7KO8;

  /// No description provided for @gNiRWpeMws.
  ///
  /// In en, this message translates to:
  /// **'gNiRWpe-mws'**
  String get gNiRWpeMws;

  /// No description provided for @cVO0hA3P8O.
  ///
  /// In en, this message translates to:
  /// **'CVO0hA3P8-o'**
  String get cVO0hA3P8O;

  /// No description provided for @label9afZnkZaPs.
  ///
  /// In en, this message translates to:
  /// **'9afZnk-zaPs'**
  String get label9afZnkZaPs;

  /// No description provided for @pLIPiKkSFpK9cUoS9l5spDGFvN2Crmdn.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK9cUoS9l_5spDGFvN2Crmdn'**
  String get pLIPiKkSFpK9cUoS9l5spDGFvN2Crmdn;

  /// No description provided for @nLMKI6PT3o.
  ///
  /// In en, this message translates to:
  /// **'NL_MKI6PT3o'**
  String get nLMKI6PT3o;

  /// No description provided for @zR7i5LASYI.
  ///
  /// In en, this message translates to:
  /// **'ZR7i5_lASYI'**
  String get zR7i5LASYI;

  /// No description provided for @keKMrR1Yss.
  ///
  /// In en, this message translates to:
  /// **'KeK-mrR1Yss'**
  String get keKMrR1Yss;

  /// No description provided for @juRTPVpVXA.
  ///
  /// In en, this message translates to:
  /// **'juRTPVp-VXA'**
  String get juRTPVpVXA;

  /// No description provided for @yzSy3klEQU.
  ///
  /// In en, this message translates to:
  /// **'yzSy3kl-eQU'**
  String get yzSy3klEQU;

  /// No description provided for @label8A7WTDaaGs.
  ///
  /// In en, this message translates to:
  /// **'8A7W-tDaaGs'**
  String get label8A7WTDaaGs;

  /// No description provided for @pLIPiKkSFpK8hIu32ZhKKsO2wlADWaCBU.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK8hIu32ZhKKsO2wlADWaCBU'**
  String get pLIPiKkSFpK8hIu32ZhKKsO2wlADWaCBU;

  /// No description provided for @oVN1y6LPWD4.
  ///
  /// In en, this message translates to:
  /// **'OVN1y6LPWD4'**
  String get oVN1y6LPWD4;

  /// No description provided for @qU7t6C4Gc.
  ///
  /// In en, this message translates to:
  /// **'qU7t6-c4_gc'**
  String get qU7t6C4Gc;

  /// No description provided for @fk9JXDCOG4.
  ///
  /// In en, this message translates to:
  /// **'Fk9_JXDCOG4'**
  String get fk9JXDCOG4;

  /// No description provided for @uC7Mnd3qJc.
  ///
  /// In en, this message translates to:
  /// **'UC7Mnd3q_Jc'**
  String get uC7Mnd3qJc;

  /// No description provided for @glHm8Zs8Ac.
  ///
  /// In en, this message translates to:
  /// **'glHm8Zs8-Ac'**
  String get glHm8Zs8Ac;

  /// No description provided for @l2w4TUDxmsg.
  ///
  /// In en, this message translates to:
  /// **'L2w4TUDxmsg'**
  String get l2w4TUDxmsg;

  /// No description provided for @cPLU864rP14.
  ///
  /// In en, this message translates to:
  /// **'CPLU864rP14'**
  String get cPLU864rP14;

  /// No description provided for @a4mUs48UAU.
  ///
  /// In en, this message translates to:
  /// **'a4mUs4-8UAU'**
  String get a4mUs48UAU;

  /// No description provided for @bVmda5m2mN4.
  ///
  /// In en, this message translates to:
  /// **'BVmda5m2mN4'**
  String get bVmda5m2mN4;

  /// No description provided for @mZUf8J2gZA4.
  ///
  /// In en, this message translates to:
  /// **'MZUf8J2gZA4'**
  String get mZUf8J2gZA4;

  /// No description provided for @tQiZtftwY.
  ///
  /// In en, this message translates to:
  /// **'TQi--ZtftwY'**
  String get tQiZtftwY;

  /// No description provided for @bR38d9KJoos.
  ///
  /// In en, this message translates to:
  /// **'BR38d9KJoos'**
  String get bR38d9KJoos;

  /// No description provided for @pLIPiKkSFpKOHffjOp4RqWHtE2OYq.
  ///
  /// In en, this message translates to:
  /// **'PLIPiKkS-FpK-oHffjOp4-rq__WHtE2OYq'**
  String get pLIPiKkSFpKOHffjOp4RqWHtE2OYq;

  /// No description provided for @fyuHVqsXMI.
  ///
  /// In en, this message translates to:
  /// **'fyuHVqs-XMI'**
  String get fyuHVqsXMI;

  /// No description provided for @yJB0nFJNw0.
  ///
  /// In en, this message translates to:
  /// **'YJB0nFJNw_0'**
  String get yJB0nFJNw0;

  /// No description provided for @label21RxwDPr8k.
  ///
  /// In en, this message translates to:
  /// **'21Rxw-DPr8k'**
  String get label21RxwDPr8k;

  /// No description provided for @zZTZ149pQ.
  ///
  /// In en, this message translates to:
  /// **'ZZ-_tZ149pQ'**
  String get zZTZ149pQ;

  /// No description provided for @o5qvwYEyQ0.
  ///
  /// In en, this message translates to:
  /// **'o5qvwY-EyQ0'**
  String get o5qvwYEyQ0;

  /// No description provided for @bGGDIBw4TIw.
  ///
  /// In en, this message translates to:
  /// **'BGGDIBw4TIw'**
  String get bGGDIBw4TIw;

  /// No description provided for @gU0lbFUBwg8.
  ///
  /// In en, this message translates to:
  /// **'GU0lbFUBwg8'**
  String get gU0lbFUBwg8;

  /// No description provided for @yTfshUkXmG.
  ///
  /// In en, this message translates to:
  /// **'yTfshUkXm-g'**
  String get yTfshUkXmG;

  /// No description provided for @yOUTUBEAPIKEY.
  ///
  /// In en, this message translates to:
  /// **'YOUTUBE_API_KEY='**
  String get yOUTUBEAPIKEY;

  /// No description provided for @partContentDetails.
  ///
  /// In en, this message translates to:
  /// **'?part=contentDetails'**
  String get partContentDetails;

  /// No description provided for @fallInLove.
  ///
  /// In en, this message translates to:
  /// **'fall in love'**
  String get fallInLove;

  /// No description provided for @myGirl.
  ///
  /// In en, this message translates to:
  /// **'my girl'**
  String get myGirl;

  /// No description provided for @firstRomance2.
  ///
  /// In en, this message translates to:
  /// **'first romance'**
  String get firstRomance2;

  /// No description provided for @fallFor.
  ///
  /// In en, this message translates to:
  /// **'fall for'**
  String get fallFor;

  /// No description provided for @uCD83JhUFQXRDwC6S8caCQ.
  ///
  /// In en, this message translates to:
  /// **'UCD_83Jh-UFQXRDwC6S8caCQ'**
  String get uCD83JhUFQXRDwC6S8caCQ;

  /// No description provided for @uCFh5x5AZHQQ6FaGKnGQXDA.
  ///
  /// In en, this message translates to:
  /// **'UCFh5x5AZHQQ6FaGKnG-QXDA'**
  String get uCFh5x5AZHQQ6FaGKnGQXDA;

  /// No description provided for @uCRABdhiBHX4BieJfPCd2pg.
  ///
  /// In en, this message translates to:
  /// **'UCRABdhiBHX4Bie-jfPCd2pg'**
  String get uCRABdhiBHX4BieJfPCd2pg;

  /// No description provided for @hiddenLove2.
  ///
  /// In en, this message translates to:
  /// **'Hidden Love'**
  String get hiddenLove2;

  /// No description provided for @loveBetweenFairyAndDevil2.
  ///
  /// In en, this message translates to:
  /// **'Love Between Fairy and Devil'**
  String get loveBetweenFairyAndDevil2;

  /// No description provided for @loveLikeTheGalaxy2.
  ///
  /// In en, this message translates to:
  /// **'Love Like The Galaxy'**
  String get loveLikeTheGalaxy2;

  /// No description provided for @myJourneyToYou2.
  ///
  /// In en, this message translates to:
  /// **'My Journey to You'**
  String get myJourneyToYou2;

  /// No description provided for @mysteriousLotusCasebook2.
  ///
  /// In en, this message translates to:
  /// **'Mysterious Lotus Casebook'**
  String get mysteriousLotusCasebook2;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @theLongBallad2.
  ///
  /// In en, this message translates to:
  /// **'The Long Ballad'**
  String get theLongBallad2;

  /// No description provided for @theUntamed2.
  ///
  /// In en, this message translates to:
  /// **'The Untamed'**
  String get theUntamed2;

  /// No description provided for @wordOfHonor2.
  ///
  /// In en, this message translates to:
  /// **'Word of Honor'**
  String get wordOfHonor2;

  /// No description provided for @lightOfDawn2.
  ///
  /// In en, this message translates to:
  /// **'人之初 Light of Dawn'**
  String get lightOfDawn2;

  /// No description provided for @hOMELANDGUARDIAN2.
  ///
  /// In en, this message translates to:
  /// **'守诚者|HOMELAND GUARDIAN'**
  String get hOMELANDGUARDIAN2;

  /// No description provided for @searching2.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching2;

  /// No description provided for @verse.
  ///
  /// In en, this message translates to:
  /// **'Verse'**
  String get verse;

  /// No description provided for @allStories2.
  ///
  /// In en, this message translates to:
  /// **'All Stories'**
  String get allStories2;

  /// No description provided for @bbcComZhongwenTrad.
  ///
  /// In en, this message translates to:
  /// **'bbc.com/zhongwen/trad'**
  String get bbcComZhongwenTrad;

  /// No description provided for @hanziClickable.
  ///
  /// In en, this message translates to:
  /// **'.hanzi-clickable'**
  String get hanziClickable;

  /// No description provided for @sentenceText.
  ///
  /// In en, this message translates to:
  /// **'sentence-text'**
  String get sentenceText;

  /// No description provided for @sentenceWrapper.
  ///
  /// In en, this message translates to:
  /// **'sentence-wrapper'**
  String get sentenceWrapper;

  /// No description provided for @hanziClickable2.
  ///
  /// In en, this message translates to:
  /// **'hanzi-clickable'**
  String get hanziClickable2;

  /// No description provided for @char2.
  ///
  /// In en, this message translates to:
  /// **'+ char +'**
  String get char2;

  /// No description provided for @sentenceText2.
  ///
  /// In en, this message translates to:
  /// **'.sentence-text'**
  String get sentenceText2;

  /// No description provided for @ttsBtn.
  ///
  /// In en, this message translates to:
  /// **'tts-btn'**
  String get ttsBtn;

  /// No description provided for @hanziTranslateBtn.
  ///
  /// In en, this message translates to:
  /// **'hanzi-translate-btn'**
  String get hanziTranslateBtn;

  /// No description provided for @label10px16px.
  ///
  /// In en, this message translates to:
  /// **'10px 16px'**
  String get label10px16px;

  /// No description provided for @articleArticlePostContentMain.
  ///
  /// In en, this message translates to:
  /// **'article, .article, .post, .content, main'**
  String get articleArticlePostContentMain;

  /// No description provided for @ttsActiveWord.
  ///
  /// In en, this message translates to:
  /// **'.tts-active-word'**
  String get ttsActiveWord;

  /// No description provided for @ttsActiveWord2.
  ///
  /// In en, this message translates to:
  /// **'tts-active-word'**
  String get ttsActiveWord2;

  /// No description provided for @upperIntermediate2.
  ///
  /// In en, this message translates to:
  /// **'Upper-Intermediate'**
  String get upperIntermediate2;

  /// No description provided for @hanziDarkModeStyle.
  ///
  /// In en, this message translates to:
  /// **'hanzi-dark-mode-style'**
  String get hanziDarkModeStyle;

  /// No description provided for @sharedaddyJpPostFlairEntry.
  ///
  /// In en, this message translates to:
  /// **'.sharedaddy, #jp-post-flair, .entry-meta, .wpcnt, .author-info, #comments, .comments, .post-footer, footer, .related-posts, .share-buttons'**
  String get sharedaddyJpPostFlairEntry;

  /// No description provided for @aiInsightBanner.
  ///
  /// In en, this message translates to:
  /// **'ai-insight-banner'**
  String get aiInsightBanner;

  /// No description provided for @summaryToggleBtn.
  ///
  /// In en, this message translates to:
  /// **'summary-toggle-btn'**
  String get summaryToggleBtn;

  /// No description provided for @toggleChevron.
  ///
  /// In en, this message translates to:
  /// **'toggle-chevron'**
  String get toggleChevron;

  /// No description provided for @summaryText.
  ///
  /// In en, this message translates to:
  /// **'summary-text'**
  String get summaryText;

  /// No description provided for @documentBodyInnerText.
  ///
  /// In en, this message translates to:
  /// **'document.body.innerText'**
  String get documentBodyInnerText;

  /// No description provided for @documentTitle.
  ///
  /// In en, this message translates to:
  /// **'document.title'**
  String get documentTitle;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processingâ€¦'**
  String get processing;

  /// No description provided for @keepItUp.
  ///
  /// In en, this message translates to:
  /// **'好！Keep it up'**
  String get keepItUp;

  /// No description provided for @minutesDay.
  ///
  /// In en, this message translates to:
  /// **'Minutes / Day'**
  String get minutesDay;

  /// No description provided for @consistencyIsTheInkThat.
  ///
  /// In en, this message translates to:
  /// **'\"Consistency is the ink that builds the character.\"'**
  String get consistencyIsTheInkThat;

  /// No description provided for @businessCareer.
  ///
  /// In en, this message translates to:
  /// **'Business & Career'**
  String get businessCareer;

  /// No description provided for @travelSurvival.
  ///
  /// In en, this message translates to:
  /// **'Travel & Survival'**
  String get travelSurvival;

  /// No description provided for @label05MinDay.
  ///
  /// In en, this message translates to:
  /// **'05 Min / Day'**
  String get label05MinDay;

  /// No description provided for @label10MinDay.
  ///
  /// In en, this message translates to:
  /// **'10 Min / Day'**
  String get label10MinDay;

  /// No description provided for @label20MinDay.
  ///
  /// In en, this message translates to:
  /// **'20 Min / Day'**
  String get label20MinDay;

  /// No description provided for @label30MinDay.
  ///
  /// In en, this message translates to:
  /// **'30 Min / Day'**
  String get label30MinDay;

  /// No description provided for @dynamicDecksStrokeAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Decks & Stroke Analysis'**
  String get dynamicDecksStrokeAnalysis;

  /// No description provided for @subscriptionsAreTemporarilyUnavailablePl.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions are temporarily unavailable. Please try again.'**
  String get subscriptionsAreTemporarilyUnavailablePl;

  /// No description provided for @trialReminder.
  ///
  /// In en, this message translates to:
  /// **'Trial Reminder'**
  String get trialReminder;

  /// No description provided for @turnOnNotificationsIfYou.
  ///
  /// In en, this message translates to:
  /// **'Turn on notifications if you would like a reminder before your eligible trial expires. Your App Store subscription settings remain the source of truth.'**
  String get turnOnNotificationsIfYou;

  /// No description provided for @label2Months.
  ///
  /// In en, this message translates to:
  /// **'2 months'**
  String get label2Months;

  /// No description provided for @label3Months.
  ///
  /// In en, this message translates to:
  /// **'3 months'**
  String get label3Months;

  /// No description provided for @label6Months.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get label6Months;

  /// No description provided for @billingPeriod.
  ///
  /// In en, this message translates to:
  /// **'billing period'**
  String get billingPeriod;

  /// No description provided for @chooseASubscription.
  ///
  /// In en, this message translates to:
  /// **'Choose a subscription'**
  String get chooseASubscription;

  /// No description provided for @startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start free trial'**
  String get startFreeTrial;

  /// No description provided for @smartNewsDict.
  ///
  /// In en, this message translates to:
  /// **'Smart News & Dict'**
  String get smartNewsDict;

  /// No description provided for @hSK16AIDecks.
  ///
  /// In en, this message translates to:
  /// **'HSK 1-6 & AI Decks'**
  String get hSK16AIDecks;

  /// No description provided for @continueWithTemporaryPremium.
  ///
  /// In en, this message translates to:
  /// **'Continue with temporary Premium'**
  String get continueWithTemporaryPremium;

  /// No description provided for @testProductUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Test product unavailable'**
  String get testProductUnavailable;

  /// No description provided for @paymentIsChargedToYour.
  ///
  /// In en, this message translates to:
  /// **'Payment is charged to your App Store account.'**
  String get paymentIsChargedToYour;

  /// No description provided for @subscriptionsRenewAutomaticallyUnlessCan.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions renew automatically unless canceled'**
  String get subscriptionsRenewAutomaticallyUnlessCan;

  /// No description provided for @atLeast24HoursBefore.
  ///
  /// In en, this message translates to:
  /// **'at least 24 hours before the end of the current period.'**
  String get atLeast24HoursBefore;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @closePurchaseOffer.
  ///
  /// In en, this message translates to:
  /// **'Close purchase offer'**
  String get closePurchaseOffer;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @analyzingImage2.
  ///
  /// In en, this message translates to:
  /// **'Analyzing image…'**
  String get analyzingImage2;

  /// No description provided for @extractingChineseText2.
  ///
  /// In en, this message translates to:
  /// **'Extracting Chinese text…'**
  String get extractingChineseText2;

  /// No description provided for @lookingUpVocabulary2.
  ///
  /// In en, this message translates to:
  /// **'Looking up vocabulary…'**
  String get lookingUpVocabulary2;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselectAll;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @worldChineseLiteraryMasterpiece.
  ///
  /// In en, this message translates to:
  /// **'World & Chinese literary masterpiece.'**
  String get worldChineseLiteraryMasterpiece;

  /// No description provided for @classic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get classic;

  /// No description provided for @literature.
  ///
  /// In en, this message translates to:
  /// **'Literature'**
  String get literature;

  /// No description provided for @theOriginAwakening.
  ///
  /// In en, this message translates to:
  /// **'The Origin & Awakening'**
  String get theOriginAwakening;

  /// No description provided for @turbulentHorizonsTheJourney.
  ///
  /// In en, this message translates to:
  /// **'Turbulent Horizons & The Journey'**
  String get turbulentHorizonsTheJourney;

  /// No description provided for @trialsTribulationsDevotion.
  ///
  /// In en, this message translates to:
  /// **'Trials, Tribulations & Devotion'**
  String get trialsTribulationsDevotion;

  /// No description provided for @theClashOfWitsBravery.
  ///
  /// In en, this message translates to:
  /// **'The Clash of Wits & Bravery'**
  String get theClashOfWitsBravery;

  /// No description provided for @theGrandClimaxResolution.
  ///
  /// In en, this message translates to:
  /// **'The Grand Climax & Resolution'**
  String get theGrandClimaxResolution;

  /// No description provided for @everlastingLegacyEpilogue.
  ///
  /// In en, this message translates to:
  /// **'Everlasting Legacy & Epilogue'**
  String get everlastingLegacyEpilogue;

  /// No description provided for @acrossTheVastExpanseOf.
  ///
  /// In en, this message translates to:
  /// **'Across the vast expanse of heaven and earth, characters pursue their destiny and convictions through profound trials.'**
  String get acrossTheVastExpanseOf;

  /// No description provided for @everyDialogueAndEncounterWithin.
  ///
  /// In en, this message translates to:
  /// **'Every dialogue and encounter within the tale carries the brilliance of the human spirit and the imprint of its era.'**
  String get everyDialogueAndEncounterWithin;

  /// No description provided for @followingTheFlowOfProse.
  ///
  /// In en, this message translates to:
  /// **'Following the flow of prose, readers traverse centuries of time to share in the triumphs and sorrows of legendary figures.'**
  String get followingTheFlowOfProse;

  /// No description provided for @preQin.
  ///
  /// In en, this message translates to:
  /// **'pre-qin'**
  String get preQin;

  /// No description provided for @theGoddessNWaRepairing.
  ///
  /// In en, this message translates to:
  /// **'The goddess Nüwa repairing the sky'**
  String get theGoddessNWaRepairing;

  /// No description provided for @artsTraditions.
  ///
  /// In en, this message translates to:
  /// **'Arts & Traditions'**
  String get artsTraditions;

  /// No description provided for @femaleWarm.
  ///
  /// In en, this message translates to:
  /// **'Female, warm'**
  String get femaleWarm;

  /// No description provided for @femaleCheerful.
  ///
  /// In en, this message translates to:
  /// **'Female, cheerful'**
  String get femaleCheerful;

  /// No description provided for @maleUpbeat.
  ///
  /// In en, this message translates to:
  /// **'Male, upbeat'**
  String get maleUpbeat;

  /// No description provided for @maleNewsStyle.
  ///
  /// In en, this message translates to:
  /// **'Male, news-style'**
  String get maleNewsStyle;

  /// No description provided for @maleSporty.
  ///
  /// In en, this message translates to:
  /// **'Male, sporty'**
  String get maleSporty;

  /// No description provided for @onDevice.
  ///
  /// In en, this message translates to:
  /// **'On-device'**
  String get onDevice;

  /// No description provided for @label15Minutes.
  ///
  /// In en, this message translates to:
  /// **'15 Minutes'**
  String get label15Minutes;

  /// No description provided for @label30Minutes.
  ///
  /// In en, this message translates to:
  /// **'30 Minutes'**
  String get label30Minutes;

  /// No description provided for @label45Minutes.
  ///
  /// In en, this message translates to:
  /// **'45 Minutes'**
  String get label45Minutes;

  /// No description provided for @selectChapter.
  ///
  /// In en, this message translates to:
  /// **'Select Chapter'**
  String get selectChapter;

  /// No description provided for @andContinuesToBeStudied.
  ///
  /// In en, this message translates to:
  /// **'and continues to be studied and celebrated by readers across generations.'**
  String get andContinuesToBeStudied;

  /// No description provided for @label1Poem.
  ///
  /// In en, this message translates to:
  /// **'1 Poem'**
  String get label1Poem;

  /// No description provided for @label1Chapter.
  ///
  /// In en, this message translates to:
  /// **'1 Chapter'**
  String get label1Chapter;

  /// No description provided for @localDeviceVoice2.
  ///
  /// In en, this message translates to:
  /// **'Local device voice'**
  String get localDeviceVoice2;

  /// No description provided for @weeklyAzureQuotaReachedSwitching.
  ///
  /// In en, this message translates to:
  /// **'Weekly Azure quota reached — switching to local voice'**
  String get weeklyAzureQuotaReachedSwitching;

  /// No description provided for @sleepTimer2.
  ///
  /// In en, this message translates to:
  /// **'定时关闭 · Sleep Timer'**
  String get sleepTimer2;

  /// No description provided for @tableOfContents2.
  ///
  /// In en, this message translates to:
  /// **'目录 · Table of Contents'**
  String get tableOfContents2;

  /// No description provided for @hanziMaster10.
  ///
  /// In en, this message translates to:
  /// **'HanziMaster/1.0'**
  String get hanziMaster10;

  /// No description provided for @spanishItalianRussianClassics.
  ///
  /// In en, this message translates to:
  /// **'Spanish, Italian & Russian Classics'**
  String get spanishItalianRussianClassics;

  /// No description provided for @englishAmericanGlobalClassics.
  ///
  /// In en, this message translates to:
  /// **'English, American & Global Classics'**
  String get englishAmericanGlobalClassics;

  /// No description provided for @whileStrategicallyEmbeddingWordsYou.
  ///
  /// In en, this message translates to:
  /// **'while strategically embedding words you are currently struggling with so you can learn them in context.'**
  String get whileStrategicallyEmbeddingWordsYou;

  /// No description provided for @poetryPainting.
  ///
  /// In en, this message translates to:
  /// **'poetry-painting'**
  String get poetryPainting;

  /// No description provided for @contactSinosparkCom.
  ///
  /// In en, this message translates to:
  /// **'contact@sinospark.com'**
  String get contactSinosparkCom;

  /// No description provided for @shadowingStudioIsADedicated.
  ///
  /// In en, this message translates to:
  /// **'Shadowing Studio is a dedicated space to practice mimicking native speakers. You listen to a phrase, record yourself repeating it, and compare the waveforms and pronunciation scores to refine your accent.'**
  String get shadowingStudioIsADedicated;

  /// No description provided for @theVoicesInAIStories.
  ///
  /// In en, this message translates to:
  /// **'The voices in AI Stories and Echo Hall are powered by advanced Neural Text-to-Speech models. They are specifically tuned to provide authentic native Chinese accents, appropriate emotional inflection, and natural pacing.'**
  String get theVoicesInAIStories;

  /// No description provided for @theWebExplorerAllowsYou.
  ///
  /// In en, this message translates to:
  /// **'The Web Explorer allows you to browse any Chinese website. When you encounter a difficult word, simply tap it to open the Quick Look card, which provides instant pinyin, translation, and HSK level.'**
  String get theWebExplorerAllowsYou;

  /// No description provided for @zenModeStripsAwayDistracting.
  ///
  /// In en, this message translates to:
  /// **'Zen Mode strips away distracting web elements, ads, and complex layouts from articles, presenting you with a clean, calligraphic reading environment focused purely on the text.'**
  String get zenModeStripsAwayDistracting;

  /// No description provided for @weUseAnIntelligentAlgorithm.
  ///
  /// In en, this message translates to:
  /// **'We use an intelligent algorithm that predicts when you are about to forget a word. Words you struggle with will appear more frequently, while words you know well will be scheduled further into the future.'**
  String get weUseAnIntelligentAlgorithm;

  /// No description provided for @usage3.
  ///
  /// In en, this message translates to:
  /// **'Usage:'**
  String get usage3;
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
        'th',
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
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
