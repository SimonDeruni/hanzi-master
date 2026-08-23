import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';

class CustomPaywallScreen extends StatefulWidget {
  const CustomPaywallScreen({super.key});

  @override
  State<CustomPaywallScreen> createState() => _CustomPaywallScreenState();
}

class _CustomPaywallScreenState extends State<CustomPaywallScreen> {
  Offerings? _offerings;
  bool _isLoading = true;
  bool _isPurchasing = false;
  Package? _selectedPackage;

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
            // Select the annual package by default if available, otherwise first
            _selectedPackage = offerings.current!.annual ?? offerings.current!.availablePackages.first;
          }
        });
      }
    } catch (e) {
      debugPrint("Error fetching offerings: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _purchasePackage() async {
    if (_selectedPackage == null) return;
    
    setState(() => _isPurchasing = true);
    try {
      await Purchases.purchasePackage(_selectedPackage!);
      final isPremium = await MonetizationService.checkPremiumStatus();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1B), // Deep Carbon Ink
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFFFDFCF0)))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Image / Mascot (Replace with your own premium asset if you want)
                    const SizedBox(height: 24),
                    const Icon(
                      Icons.auto_awesome, 
                      color: Color(0xFFD4C4A8), // Warm gold/brass
                      size: 64,
                    ),
                    const SizedBox(height: 32),
                    
                    // Title
                    const Text(
                      "Master Chinese with\nSinoSpark",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFDFCF0), // Warm Xuan Paper
                        fontSize: 32,
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    
                    const SizedBox(height: 48),

                    // Blinkist Timeline
                    _buildTimelineRow(
                      icon: Icons.lock_open,
                      title: "Today",
                      description: "Unlock all features instantly.",
                    ),
                    _buildTimelineDivider(),
                    _buildTimelineRow(
                      icon: Icons.notifications_active_outlined,
                      title: "Day 5",
                      description: "We'll send you a reminder.",
                    ),
                    _buildTimelineDivider(),
                    _buildTimelineRow(
                      icon: Icons.credit_card,
                      title: "Day 7",
                      description: "Your subscription begins. Cancel easily.",
                    ),
                    
                    const Spacer(),

                    // Packages
                    if (_offerings?.current != null)
                      Row(
                        children: _offerings!.current!.availablePackages.map((package) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: _buildPackageCard(package),
                            ),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 24),

                    // Main Button
                    GestureDetector(
                      onTap: _isPurchasing ? null : _purchasePackage,
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDFCF0),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFDFCF0).withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _isPurchasing
                              ? const CircularProgressIndicator(color: Color(0xFF1A1A1B))
                              : const Text(
                                  "Start 7-Day Free Trial",
                                  style: TextStyle(
                                    color: Color(0xFF1A1A1B),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    
                    // Footer Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _restorePurchases,
                          child: const Text("Restore", style: TextStyle(color: Colors.white54)),
                        ),
                        const Text("•", style: TextStyle(color: Colors.white24)),
                        TextButton(
                          onPressed: () {}, // Add Terms URL
                          child: const Text("Terms", style: TextStyle(color: Colors.white54)),
                        ),
                        const Text("•", style: TextStyle(color: Colors.white24)),
                        TextButton(
                          onPressed: () {}, // Add Privacy URL
                          child: const Text("Privacy", style: TextStyle(color: Colors.white54)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTimelineRow({required IconData icon, required String title, required String description}) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFDFCF0).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFD4C4A8), size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFFDFCF0),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: const Color(0xFFFDFCF0).withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, top: 4, bottom: 4),
      child: Container(
        width: 2,
        height: 24,
        color: const Color(0xFFFDFCF0).withOpacity(0.1),
      ),
    );
  }

  Widget _buildPackageCard(Package package) {
    final isSelected = _selectedPackage?.identifier == package.identifier;
    final isAnnual = package.packageType == PackageType.annual;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedPackage = package);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDFCF0).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFD4C4A8) : Colors.white12,
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
              package.storeProduct.title.split(' ').first, // Try to extract just "Monthly" / "Yearly"
              style: const TextStyle(
                color: Color(0xFFFDFCF0),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              package.storeProduct.priceString,
              style: const TextStyle(
                color: Color(0xFFFDFCF0),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
