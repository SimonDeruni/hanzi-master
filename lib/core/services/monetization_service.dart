import 'package:flutter/foundation.dart';

/// Stub MonetizationService — purchases_flutter removed to prevent iOS SIGTRAP
/// on sideloaded builds. Re-add when deploying to App Store with real API keys.
class MonetizationService {
  static const String entitlementId = 'scholars_edition';

  static Future<void> init() async {
    debugPrint('MonetizationService: stub mode (purchases_flutter not linked)');
  }

  static Future<bool> checkPremiumStatus() async => false;

  static Future<List<dynamic>> getOfferings() async => [];

  static Future<bool> purchasePackage(dynamic package) async => false;

  static Future<bool> restorePurchases() async => false;
}
