import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';

class PaywallSheet {
  /// Helper to show the RevenueCat paywall easily from anywhere
  static Future<bool> show(BuildContext context, {WidgetRef? ref, bool isHardPaywall = false}) async {
    final isPremium = await MonetizationService.checkPremiumStatus();
    if (isPremium) return true;
      try {
        final paywallResult = isHardPaywall 
            ? await RevenueCatUI.presentPaywall(displayCloseButton: false)
            : await RevenueCatUI.presentPaywallIfNeeded(MonetizationService.entitlementId);
        
        if (paywallResult == PaywallResult.purchased || paywallResult == PaywallResult.restored) {
          if (ref != null) {
            ref.read(premiumControllerProvider.notifier).refreshStatus();
          }
          return true;
        }
        return false;
      } catch (e) {
        debugPrint("Error presenting RevenueCat UI: $e");
        return false;
      }
    }
  }
