import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/revenuecat_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io';

class PaywallScreen extends ConsumerStatefulWidget {
  final VoidCallback? onClose;
  const PaywallScreen({super.key, this.onClose});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  bool _isLoading = true;
  List<Package> _packages = [];

  @override
  void initState() {
    super.initState();
    _fetchOfferings();
  }

  Future<void> _fetchOfferings() async {
    final offerings = await ref.read(revenueCatServiceProvider.notifier).getOfferings();
    if (offerings.isNotEmpty) {
      setState(() {
        _packages = offerings.first.availablePackages;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _purchasePackage(Package package) async {
    setState(() => _isLoading = true);
    final success = await ref.read(revenueCatServiceProvider.notifier).purchasePackage(package);
    if (success && mounted) {
      if (widget.onClose != null) {
        widget.onClose!();
      } else {
        Navigator.of(context).pop(true);
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1B), // Deep Carbon Ink
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.onClose != null
            ? IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: widget.onClose)
            : IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.of(context).pop(false)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.workspace_premium, size: 80, color: Color(0xFFFDFCF0)),
                  const SizedBox(height: 24),
                  const Text(
                    "Unlock SinoSpark Premium",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFDFCF0)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "• Unlimited Smart Dictionary AI\n• Live Voice Calls & Personas\n• YouTube Media Desk",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 40),
                  if (_packages.isEmpty)
                    const Text("No premium packages available at the moment.", style: TextStyle(color: Colors.white54))
                  else
                    ..._packages.map((pkg) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFDFCF0),
                              foregroundColor: const Color(0xFF1A1A1B),
                              minimumSize: const Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: () => _purchasePackage(pkg),
                            child: Text(
                              "Start 7-Day Free Trial\nthen ${pkg.storeProduct.priceString} / ${pkg.packageType == PackageType.monthly ? 'Month' : 'Year'}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        )),
                ],
              ),
            ),
    );
  }
}

