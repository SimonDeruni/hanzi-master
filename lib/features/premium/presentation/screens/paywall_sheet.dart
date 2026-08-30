import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class PaywallSheet {
  /// Helper to show the RevenueCat paywall easily from anywhere
  static Future<bool> show(BuildContext context,
      {WidgetRef? ref, bool isHardPaywall = false}) async {
    final isPremium = await MonetizationService.checkPremiumStatus();
    if (isPremium) return true;
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current == null ||
          offerings.current!.availablePackages.isEmpty) {
        throw Exception(
            "RevenueCat is missing a Current Offering or Packages. Please configure your Dashboard.");
      }

      final paywallResult = isHardPaywall
          ? await RevenueCatUI.presentPaywall(
              offering: offerings.current, displayCloseButton: false)
          : await RevenueCatUI.presentPaywall(
              offering: offerings.current); // FORCE SHOW FOR TESTING

      if (paywallResult == PaywallResult.purchased ||
          paywallResult == PaywallResult.restored) {
        if (ref != null) {
          ref.read(premiumControllerProvider.notifier).refreshStatus();
        }
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error presenting RevenueCat UI: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.revenuecat_error(e.toString())),
            duration: const Duration(seconds: 5)));
      }
      return false;
    }
  }
}
