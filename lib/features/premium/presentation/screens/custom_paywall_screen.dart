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
    if (_usingMockFallback) {
       // Just let them in on emulator if using mock fallback
       if (mounted) {
         Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
         );
       }
       return;
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
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Icon(Icons.auto_awesome, color: accentColor, size: 56),
                      const SizedBox(height: 24),
                      
                      Text(
                        "Master Chinese with\nSinoSpark",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 32,
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Feature list
                      _buildFeatureRow(textColor, accentColor, Icons.draw, "Native Calligraphy Practice"),
                      const SizedBox(height: 12),
                      _buildFeatureRow(textColor, accentColor, Icons.memory, "AI Spaced Repetition"),
                      const SizedBox(height: 12),
                      _buildFeatureRow(textColor, accentColor, Icons.school, "HSK 1-6 Exam Prep"),
                      
                      const SizedBox(height: 32),

                      // Blinkist Timeline
                      _buildTimelineRow(
                        icon: Icons.lock_open,
                        title: "Today",
                        description: "Unlock all features instantly.",
                        textColor: textColor,
                        accentColor: accentColor,
                      ),
                      _buildTimelineDivider(textColor),
                      _buildTimelineRow(
                        icon: Icons.notifications_active_outlined,
                        title: "Day 5",
                        description: "We'll send you a reminder.",
                        textColor: textColor,
                        accentColor: accentColor,
                      ),
                      _buildTimelineDivider(textColor),
                      _buildTimelineRow(
                        icon: Icons.credit_card,
                        title: "Day 7",
                        description: "Your subscription begins. Cancel easily.",
                        textColor: textColor,
                        accentColor: accentColor,
                      ),
                      
                      const SizedBox(height: 48),

                      // Packages
                      if (_usingMockFallback)
                        Row(
                          children: [
                            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6.0), child: _buildMockPackageCard("Monthly", "\$9.99/mo", false, textColor, accentColor))),
                            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6.0), child: _buildMockPackageCard("Yearly", "\$59.99/yr", true, textColor, accentColor))),
                          ],
                        )
                      else if (_offerings?.current != null)
                        Row(
                          children: _offerings!.current!.availablePackages.map((package) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: _buildPackageCard(package, textColor, accentColor),
                              ),
                            );
                          }).toList(),
                        ),

                      const SizedBox(height: 24),

                      GestureDetector(
                        onTap: _isPurchasing ? null : _purchasePackage,
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: btnBgColor,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: btnBgColor.withOpacity(0.1),
                                blurRadius: 20,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _restorePurchases,
                            child: Text("Restore", style: TextStyle(color: textColor.withOpacity(0.6))),
                          ),
                          Text("•", style: TextStyle(color: textColor.withOpacity(0.3))),
                          TextButton(
                            onPressed: () => _launchURL('https://sinospark.app/terms.html'),
                            child: Text("Terms", style: TextStyle(color: textColor.withOpacity(0.6))),
                          ),
                          Text("•", style: TextStyle(color: textColor.withOpacity(0.3))),
                          TextButton(
                            onPressed: () => _launchURL('https://sinospark.app/privacy.html'),
                            child: Text("Privacy", style: TextStyle(color: textColor.withOpacity(0.6))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
  
  Widget _buildFeatureRow(Color textColor, Color accentColor, IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: accentColor, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(color: textColor.withOpacity(0.9), fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTimelineRow({required IconData icon, required String title, required String description, required Color textColor, required Color accentColor}) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: textColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineDivider(Color textColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 23.0, top: 4, bottom: 4),
        child: Container(
          width: 2,
          height: 24,
          color: textColor.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildMockPackageCard(String title, String price, bool isAnnual, Color textColor, Color accentColor) {
    final isSelected = isAnnual; // Just hardcode selection for mock
    return _buildPackageCardUI(title, price, isAnnual, isSelected, textColor, accentColor, () {});
  }

  Widget _buildPackageCard(Package package, Color textColor, Color accentColor) {
    final isSelected = _selectedPackage?.identifier == package.identifier;
    final isAnnual = package.packageType == PackageType.annual;
    return _buildPackageCardUI(package.storeProduct.title.split(' ').first, package.storeProduct.priceString, isAnnual, isSelected, textColor, accentColor, () {
      HapticFeedback.lightImpact();
      setState(() => _selectedPackage = package);
    });
  }
  
  Widget _buildPackageCardUI(String title, String price, bool isAnnual, bool isSelected, Color textColor, Color accentColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? textColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? accentColor : textColor.withOpacity(0.15),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            if (isAnnual)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B2E2E), // Seal Red
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Best Value",
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
