import 'dart:io';
import 'package:flutter/foundation.dart';
// import 'package:google_api_availability/google_api_availability.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:huawei_iap/huawei_iap.dart' as hia;

enum PaymentProvider { revenueCat, huawei, none }

class MonetizationService {
  static const String entitlementId = 'scholars_edition';
  static PaymentProvider _activeProvider = PaymentProvider.none;

  static Future<void> init() async {
    if (kIsWeb) {
      debugPrint('MonetizationService: Web not supported');
      return;
    }

    if (Platform.isIOS) {
      _activeProvider = PaymentProvider.revenueCat;
      await _initRevenueCat();
    } else if (Platform.isAndroid) {
      // Temporarily bypass GoogleApiAvailability while awaiting Huawei verification
      _activeProvider = PaymentProvider.revenueCat;
      await _initRevenueCat();
    }
  }

  static Future<void> _initRevenueCat() async {
    await Purchases.setLogLevel(LogLevel.debug);
    String apiKey = "test_hKUgycpfNjUxrrXUseinoYNCPRs";
    
    // RevenueCat actively shuts down release builds that use `test_` keys.
    // If we're in release mode and don't have a production key yet, we bypass
    // RevenueCat entirely so the app doesn't crash during TestFlight/AdHoc testing.
    if (kReleaseMode && apiKey.startsWith('test_')) {
      debugPrint('MonetizationService: Bypassing RevenueCat init in Release mode with test key');
      _activeProvider = PaymentProvider.none;
      return;
    }

    PurchasesConfiguration configuration = PurchasesConfiguration(apiKey);
    await Purchases.configure(configuration);
    debugPrint('MonetizationService: RevenueCat initialized');
  }

  static Future<void> _initHuaweiIAP() async {
    debugPrint('MonetizationService: Huawei IAP init temporarily disabled pending Developer Verification');
  }

  static Future<bool> checkPremiumStatus() async {
    // Auto-unlock premium for release testing if RevenueCat was bypassed due to a test key.
    if (kReleaseMode && _activeProvider == PaymentProvider.none) {
      return true;
    }
    
    try {
      if (_activeProvider == PaymentProvider.revenueCat) {
        final customerInfo = await Purchases.getCustomerInfo();
        return customerInfo.entitlements.all[entitlementId]?.isActive == true;
      }
    } catch (e) {
      debugPrint("Failed to check premium status: $e");
    }
    return false;
  }

  static Future<List<dynamic>> getOfferings() async {
    if (_activeProvider == PaymentProvider.revenueCat) {
      try {
        final offerings = await Purchases.getOfferings();
        return offerings.current?.availablePackages ?? [];
      } catch (e) {
        debugPrint("RevenueCat getOfferings error: $e");
      }
    }
    return [];
  }

  static Future<bool> purchasePackage(dynamic package) async {
    try {
      if (_activeProvider == PaymentProvider.revenueCat) {
        final result = await Purchases.purchasePackage(package as Package);
        return result.customerInfo.entitlements.all[entitlementId]?.isActive == true;
      }
    } catch (e) {
      debugPrint("Purchase failed: $e");
    }
    return false;
  }

  static Future<bool> restorePurchases() async {
    try {
      if (_activeProvider == PaymentProvider.revenueCat) {
        final customerInfo = await Purchases.restorePurchases();
        return customerInfo.entitlements.all[entitlementId]?.isActive == true;
      }
    } catch (e) {
      debugPrint("Restore failed: $e");
    }
    return false;
  }

  static Future<void> checkTrialAndScheduleReminder(dynamic notificationService) async {
    try {
      if (_activeProvider == PaymentProvider.revenueCat) {
        final customerInfo = await Purchases.getCustomerInfo();
        final entitlement = customerInfo.entitlements.all[entitlementId];
        
        // periodType in RevenueCat is usually 'TRIAL', 'NORMAL', 'INTRO'
        if (entitlement != null && entitlement.isActive && entitlement.periodType == PeriodType.trial) {
          if (entitlement.expirationDate != null) {
            final expDate = DateTime.parse(entitlement.expirationDate!);
            // Dynamic typing to avoid strong coupling/import loops
            await notificationService.scheduleTrialEndingReminder(expDate);
          }
        }
      }
    } catch (e) {
      debugPrint("Failed to check trial for reminders: $e");
    }
  }
}
