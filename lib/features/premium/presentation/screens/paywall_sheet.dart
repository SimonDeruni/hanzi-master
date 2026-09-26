import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';

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

      // Every purchase flow must have an obvious exit. In particular, do not
      // hide RevenueCat's close button for gated features: users must always
      // be able to decline an in-app purchase without being trapped.
      final paywallResult = await RevenueCatUI.presentPaywall(
        offering: offerings.current,
        displayCloseButton: true,
      );

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
        ZenToast.error(context, "Error presenting payment: $e");
      }
      return false;
    }
  }
}
