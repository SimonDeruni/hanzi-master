import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:hanzi_master/core/widgets/ltr_sanctuary.dart';
import 'package:hanzi_master/features/auth/presentation/screens/auth_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class CustomPaywallScreen extends ConsumerStatefulWidget {
  const CustomPaywallScreen({
    super.key,
    this.useMockOfferingsForTesting = false,
    this.simulateUnavailableOfferingsForTesting = false,
  });

  @visibleForTesting
  final bool useMockOfferingsForTesting;

  @visibleForTesting
  final bool simulateUnavailableOfferingsForTesting;

  @override
  ConsumerState<CustomPaywallScreen> createState() =>
      _CustomPaywallScreenState();
}

class _CustomPaywallScreenState extends ConsumerState<CustomPaywallScreen> {
  Offerings? _offerings;
  bool _isLoading = true;
  bool _isPurchasing = false;
  Package? _selectedPackage;
  bool _usingTestOfferings = false;
  String? _offeringsError;
  final Map<String, IntroEligibility> _introEligibility = {};

  void _closePaywall() {
    HapticFeedback.selectionClick();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const AuthScreen(requireSubscription: true),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.useMockOfferingsForTesting) {
      _isLoading = false;
      _usingTestOfferings = true;
      return;
    }
    if (widget.simulateUnavailableOfferingsForTesting) {
      _isLoading = false;
      _offeringsError =
          'Subscriptions are temporarily unavailable. Please try again.';
      return;
    }
    _fetchOfferings();
  }

  void _continueWithTemporaryPremium() {
    HapticFeedback.selectionClick();
    MonetizationService.grantTemporaryPremiumAccess();
    ref.read(premiumControllerProvider.notifier).grantTemporaryAccess();
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => const MainNavigationScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (route) => false,
    );
  }

  Future<void> _fetchOfferings() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _offeringsError = null;
      });
    }
    try {
      final offerings = await Purchases.getOfferings();
      final packages =
          offerings.current?.availablePackages ?? const <Package>[];
      Map<String, IntroEligibility> eligibility = {};
      if (packages.isNotEmpty) {
        eligibility = await Purchases.checkTrialOrIntroductoryPriceEligibility(
          packages.map((package) => package.storeProduct.identifier).toList(),
        );
      }
      if (mounted) {
        setState(() {
          _offerings = offerings;
          _introEligibility
            ..clear()
            ..addAll(eligibility);
          _isLoading = false;
          if (packages.isNotEmpty) {
            _selectedPackage = offerings.current!.annual ?? packages.first;
          } else {
            _offeringsError =
                'Subscriptions are temporarily unavailable. Please try again.';
          }
        });
      }
    } catch (e) {
      debugPrint("Error fetching offerings: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _offeringsError =
              'Subscriptions are temporarily unavailable. Please try again.';
        });
      }
    }
  }

  Future<void> _purchasePackage() async {
    HapticFeedback.mediumImpact();

    if (_selectedHasEligibleTrial) {
      final status = await Permission.notification.status;
      if (!status.isGranted && mounted) {
        final shouldProceed = await _showReminderProtectionDialog();
        if (!shouldProceed) return;
      }
    }

    if (_selectedPackage == null &&
        _offerings?.current != null &&
        _offerings!.current!.availablePackages.isNotEmpty) {
      _selectedPackage = _offerings!.current!.annual ??
          _offerings!.current!.availablePackages.first;
    }

    if (_selectedPackage == null) return;

    setState(() => _isPurchasing = true);
    try {
      final purchaseResult =
          await Purchases.purchase(PurchaseParams.package(_selectedPackage!));
      final isPremium = await MonetizationService.checkPremiumStatus();

      final entitlement =
          purchaseResult.customerInfo.entitlements.all["Hanzi AI Pro"];
      if (entitlement != null &&
          entitlement.periodType == PeriodType.trial &&
          entitlement.expirationDate != null) {
        try {
          final expirationDate = DateTime.parse(entitlement.expirationDate!);
          await ref
              .read(notificationServiceProvider)
              .scheduleTrialEndingReminder(expirationDate);
        } catch (e) {
          debugPrint("Failed to schedule trial reminder: $e");
        }
      }

      if (isPremium && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint("Purchase error: $e");
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  Future<bool> _showReminderProtectionDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF222223) : const Color(0xFFFDFCF0);
    final textColor =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final btnBgColor =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final btnTextColor =
        isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return await showDialog<bool>(
          context: context,
          barrierDismissible: true,
          builder: (ctx) => AlertDialog(
            backgroundColor: dialogBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: textColor.withValues(alpha: 0.08)),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4C4A8).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_active_outlined,
                      color: Color(0xFFD4C4A8), size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.trialReminder,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontFamily: 'Serif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              l10n.turnOnNotificationsIfYou,
              style: TextStyle(
                color: textColor.withValues(alpha: 0.75),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(
                  l10n.continueWithoutReminder,
                  style: TextStyle(
                      color: textColor.withValues(alpha: 0.5), fontSize: 13),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnBgColor,
                  foregroundColor: btnTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () async {
                  Navigator.of(ctx).pop(true);
                  try {
                    final service = ref.read(notificationServiceProvider);
                    await service.init();
                    final granted = await service.requestPermissions();
                    if (!granted) {
                      await openAppSettings();
                    }
                  } catch (e) {
                    debugPrint("Permission request error: $e");
                  }
                },
                child: Text(AppLocalizations.of(context)!.turnOn,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _restorePurchases() async {
    setState(() => _isPurchasing = true);
    try {
      await Purchases.restorePurchases();
      final isPremium = await MonetizationService.checkPremiumStatus();
      if (isPremium && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.noActiveSubscriptionFound)),
          );
        }
      }
    } catch (e) {
      debugPrint("Restore error: $e");
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Could not launch $url: $e");
    }
  }

  bool _mockIsAnnual = true;

  bool get _selectedHasEligibleTrial {
    if (_usingTestOfferings || _selectedPackage == null) return false;
    final product = _selectedPackage!.storeProduct;
    final eligibility = _introEligibility[product.identifier];
    final hasFreeOffer = product.introductoryPrice?.price == 0 ||
        product.defaultOption?.freePhase != null;
    return hasFreeOffer &&
        eligibility?.status ==
            IntroEligibilityStatus.introEligibilityStatusEligible;
  }

  String _periodLabel(Package package) {
    final l10n = AppLocalizations.of(context)!;
    final period = package.storeProduct.subscriptionPeriod;
    if (period != null) {
      final match = RegExp(r'^P(\d+)([DWMY])$').firstMatch(period);
      if (match != null) {
        final count = int.parse(match.group(1)!);
        return switch (match.group(2)) {
          'D' => l10n.billingDays(count),
          'W' => l10n.billingWeeks(count),
          'M' => l10n.billingMonths(count),
          'Y' => l10n.billingYears(count),
          _ => l10n.billingPeriod,
        };
      }
    }
    return switch (package.packageType) {
      PackageType.weekly => l10n.billingWeeks(1),
      PackageType.monthly => l10n.billingMonths(1),
      PackageType.twoMonth => l10n.billingMonths(2),
      PackageType.threeMonth => l10n.billingMonths(3),
      PackageType.sixMonth => l10n.billingMonths(6),
      PackageType.annual => l10n.billingYears(1),
      _ => l10n.billingPeriod,
    };
  }

  String get _purchaseButtonLabel {
    final l10n = AppLocalizations.of(context)!;
    final package = _selectedPackage;
    if (package == null) return l10n.chooseASubscription;
    if (_selectedHasEligibleTrial) {
      final period = package.storeProduct.introductoryPrice?.period ??
          package.storeProduct.defaultOption?.freePhase?.billingPeriod?.iso8601;
      return period == null
          ? l10n.startFreeTrial
          : l10n.startPeriodFreeTrial(_humanizeIsoPeriod(period));
    }
    return l10n.subscribeForPricePeriod(
      package.storeProduct.priceString,
      _periodLabel(package),
    );
  }

  String _humanizeIsoPeriod(String period) {
    final l10n = AppLocalizations.of(context)!;
    final match = RegExp(r'^P(\d+)([DWMY])$').firstMatch(period);
    if (match == null) return period;
    final count = int.parse(match.group(1)!);
    return switch (match.group(2)) {
      'D' => l10n.billingDays(count),
      'W' => l10n.billingWeeks(count),
      'M' => l10n.billingMonths(count),
      'Y' => l10n.billingYears(count),
      _ => l10n.billingPeriod,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? OnboardingDesign.backgroundDark
        : OnboardingDesign.backgroundLight;
    final textColor =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    const accentColor = Color(0xFFD4C4A8);
    final btnBgColor =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final btnTextColor =
        isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !_isPurchasing) _closePaywall();
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: CalligraphyBackground(
          key: const Key('paywall_calligraphy_background'),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Positioned.fill(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: textColor))
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 54, 20, 36),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildHero(textColor),
                              const SizedBox(height: 24),
                              _buildEverythingIncluded(textColor, accentColor),
                              const SizedBox(height: 24),
                              _buildPackages(textColor, accentColor),
                              if (_selectedHasEligibleTrial) ...[
                                const SizedBox(height: 12),
                                _buildTrialNotice(textColor, accentColor),
                              ],
                              if (_offeringsError != null) ...[
                                const SizedBox(height: 16),
                                Text(
                                  AppLocalizations.of(context)!
                                      .subscriptionsAreTemporarilyUnavailablePl,
                                  key: const Key('paywall_offerings_error'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                TextButton(
                                  onPressed: _fetchOfferings,
                                  child: Text(
                                    AppLocalizations.of(context)!.retry,
                                  ),
                                ),
                                OutlinedButton(
                                  key: const Key(
                                      'paywall_temporary_premium_button'),
                                  onPressed: _continueWithTemporaryPremium,
                                  child: Text(AppLocalizations.of(context)!
                                      .continueWithTemporaryPremium),
                                ),
                              ],
                              if (_offeringsError == null) ...[
                                const SizedBox(height: 36),
                                _buildExploreHeading(textColor),
                                const SizedBox(height: 24),
                                _buildFeatureStory(
                                  category: l10n.read,
                                  title: l10n.turnAnyBookIntoA,
                                  description:
                                      l10n.readNaturallyWithPronunciationDefinition,
                                  icon: Icons.auto_stories_outlined,
                                  imageAsset:
                                      'assets/images/paywall/paywall_read.png',
                                  placeholderLabel: l10n.bookReaderScreenshot,
                                  textColor: textColor,
                                  accentColor: accentColor,
                                  index: 0,
                                ),
                                _buildFeatureStory(
                                  category: l10n.shadow,
                                  title: l10n.speakWithTheRightRhythm,
                                  description: l10n.shadowNativeAudioAndVisualize,
                                  icon: Icons.graphic_eq,
                                  imageAsset:
                                      'assets/images/paywall/paywall_speak.png',
                                  placeholderLabel:
                                      l10n.shadowingAndTonesScreenshot,
                                  textColor: textColor,
                                  accentColor: accentColor,
                                  index: 1,
                                ),
                                _buildFeatureStory(
                                  category: l10n.explore,
                                  title: l10n.understandEveryCharacter,
                                  description:
                                      l10n.exploreMeaningPronunciationComponentsStr,
                                  icon: Icons.search,
                                  imageAsset:
                                      'assets/images/paywall/paywall_explore.png',
                                  placeholderLabel:
                                      l10n.characterDictionaryScreenshot,
                                  textColor: textColor,
                                  accentColor: accentColor,
                                  index: 2,
                                ),
                                _buildFeatureStory(
                                  category: l10n.learn,
                                  title: l10n.learnThroughRealVideos,
                                  description: l10n.followInteractiveSubtitlesLookUp,
                                  icon: Icons.play_circle_outline,
                                  imageAsset:
                                      'assets/images/paywall/paywall_watch.png',
                                  placeholderLabel: l10n.videoLearningScreenshot,
                                  textColor: textColor,
                                  accentColor: accentColor,
                                  index: 3,
                                ),
                                _buildFeatureStory(
                                  category: l10n.write,
                                  title: l10n.masterEveryStroke,
                                  description: l10n.dynamicDecksStrokeAnalysis,
                                  icon: Icons.gesture,
                                  imageAsset:
                                      'assets/images/paywall/paywall_write.png',
                                  placeholderLabel:
                                      l10n.guidedHandwritingPractice,
                                  textColor: textColor,
                                  accentColor: accentColor,
                                  index: 4,
                                ),
                                _buildFeatureStory(
                                  category: l10n.web,
                                  title: l10n.exploreTheChineseWeb,
                                  description: l10n.theWebExplorerAllowsYou,
                                  icon: Icons.language,
                                  imageAsset:
                                      'assets/images/paywall/paywall_web.png',
                                  placeholderLabel: l10n.webExplorer,
                                  textColor: textColor,
                                  accentColor: accentColor,
                                  index: 5,
                                ),
                              ],
                            ],
                          ),
                        ),
                ),
                Positioned(
                  top: 4,
                  right: 8,
                  child: IconButton(
                    key: const Key('paywall_close_button'),
                    tooltip: l10n.closePurchaseOffer,
                    onPressed: _isPurchasing ? null : _closePaywall,
                    icon: const Icon(Icons.close),
                    color: textColor,
                    style: IconButton.styleFrom(
                      backgroundColor: bgColor.withValues(alpha: 0.92),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            _isLoading || (!_usingTestOfferings && _selectedPackage == null)
                ? null
                : _buildStickyPurchasePanel(
                    bgColor,
                    textColor,
                    btnBgColor,
                    btnTextColor,
                  ),
      ),
    );
  }

  Widget _buildHero(Color textColor) {
    return Column(
      children: [
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: textColor.withValues(alpha: 0.035),
          ),
          child: Image.asset('assets/images/mascot.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.sinospark_premium,
          style: const TextStyle(
            color: Color(0xFF8B2E2E),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.learnChineseWithoutLimits,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 29,
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
            height: 1.12,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.watchReadSpeakAndUnderstand,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.65),
            fontSize: 14,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildPackages(Color textColor, Color accentColor) {
    if (_usingTestOfferings) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildMockPackageCard(
                AppLocalizations.of(context)!.monthly,
                '\$9.99',
                false,
                textColor,
                accentColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildMockPackageCard(
                AppLocalizations.of(context)!.yearly,
                '\$59.99',
                true,
                textColor,
                accentColor,
              ),
            ),
          ),
        ],
      );
    }

    if (_offerings?.current == null) return const SizedBox.shrink();
    return Row(
      children: _offerings!.current!.availablePackages.map((package) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildPackageCard(package, textColor, accentColor),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExploreHeading(Color textColor) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.seeWhatPremiumUnlocks,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Serif',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.scrollToExploreTheComplete,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.55),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        Icon(Icons.keyboard_arrow_down,
            color: textColor.withValues(alpha: 0.4)),
      ],
    );
  }

  Widget _buildFeatureStory({
    required String category,
    required String title,
    required String description,
    required IconData icon,
    required String imageAsset,
    required String placeholderLabel,
    required Color textColor,
    required Color accentColor,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeatureScreenshotCard(
            imageAsset: imageAsset,
            icon: icon,
            label: placeholderLabel,
            textColor: textColor,
            accentColor: accentColor,
            index: index,
          ),
          const SizedBox(height: 18),
          Text(
            category,
            style: const TextStyle(
              color: Color(0xFF8B2E2E),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Serif',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.65),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureScreenshotCard({
    required String imageAsset,
    required IconData icon,
    required String label,
    required Color textColor,
    required Color accentColor,
    required int index,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF252526) : Colors.white;

    return AspectRatio(
      aspectRatio: 1.35,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: textColor.withValues(alpha: 0.10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.09),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              key: ValueKey('paywall_screenshot_inset_$index'),
              padding: const EdgeInsets.all(10),
              child: LtrSanctuary(
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    final previewColor = index.isEven
                        ? const Color(0xFF8B2E2E)
                        : const Color(0xFF4C6673);
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            previewColor.withValues(alpha: isDark ? 0.30 : 0.13),
                            surface,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(icon, color: accentColor, size: 48),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      surface.withValues(alpha: 0.4),
                      surface.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEverythingIncluded(Color textColor, Color accentColor) {
    final l10n = AppLocalizations.of(context)!;
    final features = [
      (Icons.auto_stories_outlined, l10n.booksAndStudioQualityAudiobooks),
      (Icons.graphic_eq, l10n.aiConversationsAndLiveToneFeedback),
      (Icons.play_circle_outline, l10n.interactiveVideoAndWebImmersion),
      (Icons.gesture, l10n.characterInsightsAndHandwritingPractice),
      (Icons.school_outlined, l10n.hskDecksAndSmartSpacedRepetition),
      (Icons.insights_outlined, l10n.progressAndStreakTracking),
      (Icons.document_scanner_outlined, l10n.scannerAndLiveTranslation),
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: textColor.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.everythingIncluded,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Serif',
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(feature.$1, color: accentColor, size: 17),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature.$2,
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.82),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(Icons.check, color: accentColor, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLinks(Color textColor) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TextButton(
          key: const Key('paywall_restore_button'),
          onPressed: _restorePurchases,
          child: Text(
            AppLocalizations.of(context)!.restorePurchases,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.62),
              fontSize: 12,
            ),
          ),
        ),
        Text('•', style: TextStyle(color: textColor.withValues(alpha: 0.3))),
        TextButton(
          key: const Key('paywall_terms_button'),
          onPressed: () => _launchURL('https://sinospark.app/terms.html'),
          child: Text(
            AppLocalizations.of(context)!.termsOfUseEula,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.62),
              fontSize: 12,
            ),
          ),
        ),
        Text('•', style: TextStyle(color: textColor.withValues(alpha: 0.3))),
        TextButton(
          key: const Key('paywall_privacy_button'),
          onPressed: () => _launchURL('https://sinospark.app/privacy.html'),
          child: Text(
            AppLocalizations.of(context)!.privacyPolicy,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.62),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyPurchasePanel(
    Color bgColor,
    Color textColor,
    Color btnBgColor,
    Color btnTextColor,
  ) {
    final canPurchase =
        !_isPurchasing && (_usingTestOfferings || _selectedPackage != null);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(color: textColor.withValues(alpha: 0.09)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        10 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: canPurchase ? _purchasePackage : null,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: canPurchase ? 1 : 0.55,
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: btnBgColor,
                  borderRadius: BorderRadius.circular(27),
                  boxShadow: [
                    BoxShadow(
                      color: btnBgColor.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _isPurchasing
                      ? CircularProgressIndicator(color: btnTextColor)
                      : Text(
                          _usingTestOfferings
                              ? AppLocalizations.of(context)!.testProductUnavailable
                              : _purchaseButtonLabel,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: btnTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            AppLocalizations.of(context)!.paymentIsChargedToYour2,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.52),
              fontSize: 10.5,
              height: 1.25,
            ),
          ),
          _buildLegalLinks(textColor),
        ],
      ),
    );
  }

  Widget _buildTrialNotice(Color textColor, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: textColor.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Icon(Icons.card_giftcard, color: accentColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.eligibleTrialRenewalNotice(
                    _selectedPackage!.storeProduct.priceString,
                    _periodLabel(_selectedPackage!),
                  ),
              style: TextStyle(color: textColor, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockPackageCard(String title, String price, bool isAnnual,
      Color textColor, Color accentColor) {
    final isSelected = _mockIsAnnual == isAnnual;
    final l10n = AppLocalizations.of(context)!;
    return _buildPackageCardUI(
        title,
        price,
        isAnnual ? l10n.billingYears(1) : l10n.billingMonths(1),
        isAnnual, isSelected, textColor, accentColor, () {
      HapticFeedback.selectionClick();
      setState(() => _mockIsAnnual = isAnnual);
    });
  }

  Widget _buildPackageCard(
      Package package, Color textColor, Color accentColor) {
    final isSelected = _selectedPackage?.identifier == package.identifier;
    final isAnnual = package.packageType == PackageType.annual;
    final title = package.storeProduct.title.trim().isEmpty
        ? package.identifier
        : package.storeProduct.title;
    return _buildPackageCardUI(
        title,
        package.storeProduct.priceString,
        _periodLabel(package),
        isAnnual,
        isSelected,
        textColor,
        accentColor, () {
      HapticFeedback.selectionClick();
      setState(() => _selectedPackage = package);
    });
  }

  Widget _buildPackageCardUI(
      String title,
      String price,
      String period,
      bool isAnnual,
      bool isSelected,
      Color textColor,
      Color accentColor,
      VoidCallback onTap) {
    final isDark = textColor == const Color(0xFFFDFCF0);
    final cardBg = isSelected
        ? (isDark ? const Color(0xFF2E2E30) : Colors.white)
        : (isDark ? const Color(0xFF222223) : const Color(0xFFF5F4E8));
    final borderColor = isSelected
        ? (isDark ? Colors.white : const Color(0xFF1A1A1B))
        : (isDark ? Colors.white12 : Colors.black12);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (isDark ? Colors.white : Colors.black)
                        .withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            if (isAnnual)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B2E2E), // Seal Red
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  AppLocalizations.of(context)!.bestValue,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              )
            else
              const SizedBox(height: 19),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              AppLocalizations.of(context)!.pricePerPeriod(price, period),
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
