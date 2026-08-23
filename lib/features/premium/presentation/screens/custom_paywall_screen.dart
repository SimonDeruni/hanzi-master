import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';

class CustomPaywallScreen extends ConsumerStatefulWidget {
  const CustomPaywallScreen({super.key});

  @override
  ConsumerState<CustomPaywallScreen> createState() => _CustomPaywallScreenState();
}

class _CustomPaywallScreenState extends ConsumerState<CustomPaywallScreen> {
  Offerings? _offerings;
  bool _isLoading = true;
  bool _isPurchasing = false;
  Package? _selectedPackage;
  bool _usingMockFallback = false;

  @override
  void initState() {
    super.initState();
    _fetchOfferings();
  }

  Future<void> _fetchOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      if (mounted) {
        setState(() {
          _offerings = offerings;
          _isLoading = false;
          if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
            _selectedPackage = offerings.current!.annual ?? offerings.current!.availablePackages.first;
          } else {
            // Simulator fallback
            _usingMockFallback = true;
          }
        });
      }
    } catch (e) {
      debugPrint("Error fetching offerings: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _usingMockFallback = true;
        });
      }
    }
  }

  Future<void> _purchasePackage() async {
    HapticFeedback.mediumImpact();
    if (_usingMockFallback) {
       setState(() => _isPurchasing = true);
       await Future.delayed(const Duration(milliseconds: 300));
       if (mounted) {
         Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
         );
       }
       return;
    }
    
    if (_selectedPackage == null && _offerings?.current != null && _offerings!.current!.availablePackages.isNotEmpty) {
      _selectedPackage = _offerings!.current!.annual ?? _offerings!.current!.availablePackages.first;
    }
    
    if (_selectedPackage == null) return;
    
    setState(() => _isPurchasing = true);
    try {
      final purchaseResult = await Purchases.purchasePackage(_selectedPackage!);
      final isPremium = await MonetizationService.checkPremiumStatus();
      
      final entitlement = purchaseResult.customerInfo.entitlements.all["Hanzi AI Pro"];
      if (entitlement != null && entitlement.periodType == PeriodType.trial && entitlement.expirationDate != null) {
        try {
          final expirationDate = DateTime.parse(entitlement.expirationDate!);
          await ref.read(notificationServiceProvider).scheduleTrialEndingReminder(expirationDate);
        } catch (e) {
          debugPrint("Failed to schedule trial reminder: $e");
        }
      }

      if (isPremium && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      }
    } catch (e) {
      debugPrint("Purchase error: $e");
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
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
            const SnackBar(content: Text('No active subscription found.')),
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
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  String _mockSelectedPackage = "Yearly";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final accentColor = const Color(0xFFD4C4A8);
    final btnBgColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final btnTextColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator(color: textColor))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 1),
                    Center(
                      child: Image.asset(
                        'assets/images/mascot.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Text(
                      "Master Chinese with\nSinoSpark",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 27,
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),
                    
                    const Spacer(flex: 1),
                    
                    // 2-Column Features Grid
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: textColor.withValues(alpha: 0.06)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: _buildCompactFeature(Icons.gesture, "Precision Strokes", textColor, accentColor)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildCompactFeature(Icons.document_scanner, "Universal Scanner", textColor, accentColor)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(child: _buildCompactFeature(Icons.mic_none, "AI Pronunciation", textColor, accentColor)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildCompactFeature(Icons.translate, "Live Translation", textColor, accentColor)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(child: _buildCompactFeature(Icons.travel_explore, "Smart News & Dict", textColor, accentColor)),
                              const SizedBox(width: 12),
                              Expanded(child: _buildCompactFeature(Icons.menu_book, "HSK 1-6 & AI Decks", textColor, accentColor)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Horizontal Blinkist Timeline
                    _buildHorizontalTimeline(textColor, accentColor),
                    
                    const Spacer(flex: 2),

                    // Packages
                    if (_usingMockFallback)
                      Row(
                        children: [
                          Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: _buildMockPackageCard("Monthly", "\$9.99/mo", false, textColor, accentColor, null))),
                          Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: _buildMockPackageCard("Yearly", "\$59.99/yr", true, textColor, accentColor, 59.99))),
                        ],
                      )
                    else if (_offerings?.current != null)
                      Row(
                        children: _offerings!.current!.availablePackages.map((package) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: _buildPackageCard(package, textColor, accentColor),
                            ),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 16),

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _isPurchasing ? null : _purchasePackage,
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
                              ? CircularProgressIndicator(color: btnTextColor)
                              : Text(
                                  "Start 7-Day Free Trial",
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
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _restorePurchases,
                          child: Text("Restore", style: TextStyle(color: textColor.withValues(alpha: 0.6), fontSize: 12)),
                        ),
                        Text("•", style: TextStyle(color: textColor.withValues(alpha: 0.3))),
                        TextButton(
                          onPressed: () => _launchURL('https://sinospark.app/terms.html'),
                          child: Text("Terms", style: TextStyle(color: textColor.withValues(alpha: 0.6), fontSize: 12)),
                        ),
                        Text("•", style: TextStyle(color: textColor.withValues(alpha: 0.3))),
                        TextButton(
                          onPressed: () => _launchURL('https://sinospark.app/privacy.html'),
                          child: Text("Privacy", style: TextStyle(color: textColor.withValues(alpha: 0.6), fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
      ),
    );
  }
  
  Widget _buildCompactFeature(IconData icon, String text, Color textColor, Color accentColor) {
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

  Widget _buildHorizontalTimeline(Color textColor, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: textColor.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor.withValues(alpha: 0.06)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTimelineNode(Icons.lock_open, "Today", "Full Access", textColor, accentColor),
          Icon(Icons.arrow_forward, size: 16, color: textColor.withValues(alpha: 0.25)),
          _buildTimelineNode(Icons.notifications_none, "Day 5", "Reminder", textColor, accentColor),
          Icon(Icons.arrow_forward, size: 16, color: textColor.withValues(alpha: 0.25)),
          _buildTimelineNode(Icons.credit_card, "Day 7", "Trial Begins", textColor, accentColor),
        ],
      ),
    );
  }

  Widget _buildTimelineNode(IconData icon, String title, String subtitle, Color textColor, Color accentColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: accentColor),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.65),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMockPackageCard(String title, String price, bool isAnnual, Color textColor, Color accentColor, double? numericPrice) {
    final isSelected = _mockSelectedPackage == title;
    return _buildPackageCardUI(title, price, isAnnual, isSelected, textColor, accentColor, numericPrice, () {
      HapticFeedback.selectionClick();
      setState(() => _mockSelectedPackage = title);
    });
  }

  Widget _buildPackageCard(Package package, Color textColor, Color accentColor) {
    final isSelected = _selectedPackage?.identifier == package.identifier;
    final isAnnual = package.packageType == PackageType.annual;
    final title = isAnnual ? "Yearly" : "Monthly";
    return _buildPackageCardUI(title, package.storeProduct.priceString, isAnnual, isSelected, textColor, accentColor, package.storeProduct.price, () {
      HapticFeedback.selectionClick();
      setState(() => _selectedPackage = package);
    });
  }
  
  Widget _buildPackageCardUI(String title, String price, bool isAnnual, bool isSelected, Color textColor, Color accentColor, double? numericPrice, VoidCallback onTap) {
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
          boxShadow: isSelected ? [
            BoxShadow(
              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : null,
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
                child: const Text(
                  "Best Value",
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
              price,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isAnnual && numericPrice != null) ...[
              const SizedBox(height: 3),
              Text(
                "Just \$${(numericPrice / 12).toStringAsFixed(2)}/mo",
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.55),
                  fontSize: 10,
                ),
              ),
            ] else ...[
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
