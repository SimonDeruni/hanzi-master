import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';

class PaywallSheet extends ConsumerStatefulWidget {
  const PaywallSheet({super.key});

  /// Helper to show the paywall easily from anywhere
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PaywallSheet(),
    );
  }

  @override
  ConsumerState<PaywallSheet> createState() => _PaywallSheetState();
}

class _PaywallSheetState extends ConsumerState<PaywallSheet> {
  List<dynamic> _packages = [];
  bool _isLoading = true;
  bool _isPurchasing = false;

  @override
  void initState() {
    super.initState();
    _fetchOffers();
  }

  Future<void> _fetchOffers() async {
    final packages = await MonetizationService.getOfferings();
    if (mounted) {
      setState(() {
        _packages = packages;
        _isLoading = false;
      });
    }
  }

  Future<void> _handlePurchase(dynamic package) async {
    setState(() => _isPurchasing = true);
    HapticsManager.light();
    
    final success = await MonetizationService.purchasePackage(package);
    
    if (mounted) {
      setState(() => _isPurchasing = false);
      if (success) {
        HapticsManager.success();
        ref.read(premiumControllerProvider.notifier).refreshStatus();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Welcome, Scholar. The scroll is fully open to you.")),
        );
      }
    }
  }

  Future<void> _handleRestore() async {
    setState(() => _isPurchasing = true);
    final success = await MonetizationService.restorePurchases();
    if (mounted) {
      setState(() => _isPurchasing = false);
      if (success) {
        ref.read(premiumControllerProvider.notifier).refreshStatus();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Purchases restored successfully.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No previous purchases found on this account.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFFFDF5E6), // Xuan paper color
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.brown.shade300, borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 32),
          
          const Icon(Icons.menu_book_rounded, size: 64, color: Colors.indigo),
          const SizedBox(height: 16),
          const Text(
            "The Scholar's Edition",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Unlock the full potential of your journey. One time purchase, yours forever.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Future Features List (Placeholders for now)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              children: [
                _buildFeatureRow(Icons.map, "Beyond HSK 1", "Unlock the HSK 2 and HSK 3 galaxies."),
                _buildFeatureRow(Icons.brush, "Master Calligrapher Tools", "Unlock the Golden Brush and Midnight Ink."),
                _buildFeatureRow(Icons.auto_awesome, "AI Mnemonics", "Generate custom stories for tricky characters."),
                _buildFeatureRow(Icons.file_upload, "Custom Tomes", "Import your own JSON vocabulary decks."),
              ],
            ),
          ),
          
          // Pricing & Buttons
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5))],
            ),
            child: Column(
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_packages.isEmpty)
                  Column(
                    children: [
                      const Text("We are preparing the Scholar's Edition for launch.", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 16),
                      // Temporary Dev bypass button
                      ElevatedButton(
                        onPressed: () {
                          ref.read(premiumControllerProvider.notifier).debugUnlock();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, minimumSize: const Size(double.infinity, 56)),
                        child: const Text("DEV BYPASS: UNLOCK NOW", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                else
                  ..._packages.map((package) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: _isPurchasing ? null : () => _handlePurchase(package),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isPurchasing 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("Unlock Forever - \$9.99", 
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  )),
                
                TextButton(
                  onPressed: _isPurchasing ? null : _handleRestore,
                  child: const Text("Restore Purchases", style: TextStyle(color: Colors.indigo)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.indigo, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
