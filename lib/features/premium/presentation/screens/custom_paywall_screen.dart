import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/auth/presentation/screens/auth_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class CustomPaywallScreen extends ConsumerStatefulWidget {
  const CustomPaywallScreen({
    super.key,
    this.useMockOfferingsForTesting = false,
  });

  @visibleForTesting
  final bool useMockOfferingsForTesting;

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
    _fetchOfferings();
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
                    "Trial Reminder",
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
              "Turn on notifications if you would like a reminder before your eligible trial expires. Your App Store subscription settings remain the source of truth.",
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
                  "Continue without reminder",
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

  String _mockSelectedPackage = 'Yearly';

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
    final period = package.storeProduct.subscriptionPeriod;
    if (period != null) {
      final match = RegExp(r'^P(\d+)([DWMY])$').firstMatch(period);
      if (match != null) {
        final count = int.parse(match.group(1)!);
        final unit = switch (match.group(2)) {
          'D' => 'day',
          'W' => 'week',
          'M' => 'month',
          'Y' => 'year',
          _ => 'period',
        };
        return count == 1 ? unit : '$count ${unit}s';
      }
    }
    return switch (package.packageType) {
      PackageType.weekly => 'week',
      PackageType.monthly => 'month',
      PackageType.twoMonth => '2 months',
      PackageType.threeMonth => '3 months',
      PackageType.sixMonth => '6 months',
      PackageType.annual => 'year',
      _ => 'billing period',
    };
  }

  String get _purchaseButtonLabel {
    final package = _selectedPackage;
    if (package == null) return 'Choose a subscription';
    if (_selectedHasEligibleTrial) {
      final period = package.storeProduct.introductoryPrice?.period ??
          package.storeProduct.defaultOption?.freePhase?.billingPeriod?.iso8601;
      return period == null
          ? 'Start free trial'
          : 'Start ${_humanizeIsoPeriod(period)} free trial';
    }
    return 'Subscribe for ${package.storeProduct.priceString} / ${_periodLabel(package)}';
  }

  String _humanizeIsoPeriod(String period) {
    final match = RegExp(r'^P(\d+)([DWMY])$').firstMatch(period);
    if (match == null) return period;
    final count = int.parse(match.group(1)!);
    final unit = switch (match.group(2)) {
      'D' => 'day',
      'W' => 'week',
      'M' => 'month',
      'Y' => 'year',
      _ => 'period',
    };
    return '$count $unit${count == 1 ? '' : 's'}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
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
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator(color: textColor))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 8),
                            Center(
                              child: Image.asset(
                                'assets/images/mascot.png',
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Text(
                              "SinoSpark Premium",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 27,
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.bold,
                                height: 1.15,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // 2-Column Features Grid
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: textColor.withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: textColor.withValues(alpha: 0.06)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: _buildCompactFeature(
                                              Icons.gesture,
                                              "Precision Strokes",
                                              textColor,
                                              accentColor)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildCompactFeature(
                                              Icons.document_scanner,
                                              "Universal Scanner",
                                              textColor,
                                              accentColor)),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: _buildCompactFeature(
                                              Icons.mic_none,
                                              "AI Pronunciation",
                                              textColor,
                                              accentColor)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildCompactFeature(
                                              Icons.translate,
                                              "Live Translation",
                                              textColor,
                                              accentColor)),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: _buildCompactFeature(
                                              Icons.travel_explore,
                                              "Smart News & Dict",
                                              textColor,
                                              accentColor)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                          child: _buildCompactFeature(
                                              Icons.menu_book,
                                              "HSK 1-6 & AI Decks",
                                              textColor,
                                              accentColor)),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 14),

                            if (_selectedHasEligibleTrial)
                              _buildTrialNotice(textColor, accentColor),

                            const SizedBox(height: 24),

                            // Packages
                            if (_usingTestOfferings)
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: _buildMockPackageCard(
                                              AppLocalizations.of(context)!
                                                  .monthly,
                                              "\$9.99",
                                              false,
                                              textColor,
                                              accentColor))),
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: _buildMockPackageCard(
                                              AppLocalizations.of(context)!
                                                  .yearly,
                                              "\$59.99",
                                              true,
                                              textColor,
                                              accentColor))),
                                ],
                              )
                            else if (_offerings?.current != null)
                              Row(
                                children: _offerings!.current!.availablePackages
                                    .map((package) {
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: _buildPackageCard(
                                          package, textColor, accentColor),
                                    ),
                                  );
                                }).toList(),
                              ),

                            if (_offeringsError != null) ...[
                              Text(
                                _offeringsError!,
                                key: const Key('paywall_offerings_error'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                              TextButton(
                                onPressed: _fetchOfferings,
                                child: const Text('Retry'),
                              ),
                            ],

                            const SizedBox(height: 16),

                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: _isPurchasing ||
                                      (!_usingTestOfferings &&
                                          _selectedPackage == null)
                                  ? null
                                  : _purchasePackage,
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  color: btnBgColor,
                                  borderRadius: BorderRadius.circular(27),
                                  boxShadow: [
                                    BoxShadow(
                                      color: btnBgColor.withValues(alpha: 0.1),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: _isPurchasing
                                      ? CircularProgressIndicator(
                                          color: btnTextColor)
                                      : Text(
                                          _usingTestOfferings
                                              ? 'Test product unavailable'
                                              : _purchaseButtonLabel,
                                          style: TextStyle(
                                            color: btnTextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "Payment is charged to your App Store account. "
                              "Subscriptions renew automatically unless canceled "
                              "at least 24 hours before the end of the current period.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor.withValues(alpha: 0.55),
                                fontSize: 10,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: _restorePurchases,
                                  child: Text(
                                      AppLocalizations.of(context)!.restore,
                                      style: TextStyle(
                                          color:
                                              textColor.withValues(alpha: 0.6),
                                          fontSize: 12)),
                                ),
                                Text("•",
                                    style: TextStyle(
                                        color:
                                            textColor.withValues(alpha: 0.3))),
                                TextButton(
                                  onPressed: () => _launchURL(
                                      'https://sinospark.app/terms.html'),
                                  child: Text("Terms of Use (EULA)",
                                      style: TextStyle(
                                          color:
                                              textColor.withValues(alpha: 0.6),
                                          fontSize: 12)),
                                ),
                                Text("•",
                                    style: TextStyle(
                                        color:
                                            textColor.withValues(alpha: 0.3))),
                                TextButton(
                                  onPressed: () => _launchURL(
                                      'https://sinospark.app/privacy.html'),
                                  child: Text("Privacy Policy",
                                      style: TextStyle(
                                          color:
                                              textColor.withValues(alpha: 0.6),
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
              ),
              Positioned(
                top: 4,
                right: 8,
                child: IconButton(
                  key: const Key('paywall_close_button'),
                  tooltip: 'Close purchase offer',
                  onPressed: _isPurchasing ? null : _closePaywall,
                  icon: const Icon(Icons.close),
                  color: textColor,
                  style: IconButton.styleFrom(
                    backgroundColor: bgColor.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactFeature(
      IconData icon, String text, Color textColor, Color accentColor) {
    return Row(
      children: [
        Icon(icon, color: accentColor, size: 21),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.95),
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
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
              'Your selected StoreKit product includes an eligible free trial. '
              'After the trial, it renews for ${_selectedPackage!.storeProduct.priceString} '
              'per ${_periodLabel(_selectedPackage!)} unless canceled.',
              style: TextStyle(color: textColor, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockPackageCard(String title, String price, bool isAnnual,
      Color textColor, Color accentColor) {
    final isSelected = _mockSelectedPackage == title;
    return _buildPackageCardUI(title, price, isAnnual ? 'year' : 'month',
        isAnnual, isSelected, textColor, accentColor, () {
      HapticFeedback.selectionClick();
      setState(() => _mockSelectedPackage = title);
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
              "$price / $period",
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
