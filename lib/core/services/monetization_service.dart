import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_api_availability/google_api_availability.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
// import 'package:huawei_iap/huawei_iap.dart' as hia;

enum PaymentProvider { revenueCat, huawei, none }

class MonetizationService {
  static const String entitlementId = 'Hanzi AI Pro';
  static PaymentProvider _activeProvider = PaymentProvider.none;
  static bool _developerBackdoorUnlocked = false;
  static bool _isInitialized = false;

  /// Grants premium access for the current app session when the store cannot
  /// provide subscription offerings. This does not create a store purchase.
  static void grantTemporaryPremiumAccess() {
    _developerBackdoorUnlocked = true;
  }

  /// Unlocks developer / demo mode and persists it across app restarts.
  static Future<void> unlockDeveloperBackdoor() async {
    _developerBackdoorUnlocked = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('demo_account_unlocked', true);
      await prefs.setBool('has_seen_onboarding', true);
    } catch (e) {
      debugPrint('Failed to persist demo account unlock: $e');
    }
  }

  /// Locks developer / demo mode and removes persistent credentials on logout.
  static Future<void> lockDeveloperBackdoor() async {
    _developerBackdoorUnlocked = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('demo_account_unlocked');
    } catch (e) {
      debugPrint('Failed to clear demo account unlock: $e');
    }
  }

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
    try {
      if (_isInitialized || await Purchases.isConfigured) {
        _isInitialized = true;
        return;
      }
      await Purchases.setLogLevel(LogLevel.debug);

      late PurchasesConfiguration configuration;
      final androidKey = ApiKeyPool().revenueCatAndroidKey;
      final appleKey = ApiKeyPool().revenueCatAppleKey;

      if (Platform.isAndroid) {
        if (androidKey.isEmpty) {
          debugPrint('WARNING: RevenueCat Android key is empty');
        }
        configuration = PurchasesConfiguration(androidKey);
      } else {
        if (appleKey.isEmpty) {
          debugPrint('WARNING: RevenueCat Apple key is empty');
        }
        configuration = PurchasesConfiguration(appleKey);
      }

      await Purchases.configure(configuration);
      _isInitialized = true;
      debugPrint('MonetizationService: RevenueCat initialized');
    } catch (e) {
      debugPrint('MonetizationService: Failed to initialize RevenueCat: $e');
    }
  }

  static Future<bool> checkPremiumStatus({bool rethrowErrors = false}) async {
    if (_developerBackdoorUnlocked) return true;

    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('demo_account_unlocked') == true) {
        _developerBackdoorUnlocked = true;
        return true;
      }
    } catch (_) {}

    try {
      if (_activeProvider == PaymentProvider.revenueCat) {
        final customerInfo = await Purchases.getCustomerInfo();
        return customerInfo.entitlements.all[entitlementId]?.isActive == true;
      }
    } catch (e) {
      debugPrint("Failed to check premium status: $e");
      if (rethrowErrors) rethrow;
    }
    return false;
  }

  static Future<List<Package>> getOfferings() async {
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

  static Future<bool> purchasePackage(Package package) async {
    try {
      if (_activeProvider == PaymentProvider.revenueCat) {
        final result =
            await Purchases.purchase(PurchaseParams.package(package));
        return result.customerInfo.entitlements.all[entitlementId]?.isActive ==
            true;
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

  static Future<bool> identifyUser(String uid) async {
    if (_activeProvider != PaymentProvider.revenueCat) return false;
    final result = await Purchases.logIn(uid);
    return result.customerInfo.entitlements.all[entitlementId]?.isActive ==
        true;
  }

  static Future<void> clearUserIdentity() async {
    if (_activeProvider != PaymentProvider.revenueCat) return;
    try {
      if (!await Purchases.isAnonymous) await Purchases.logOut();
    } catch (error) {
      debugPrint('RevenueCat logout failed: $error');
    }
  }

  static Future<void> checkTrialAndScheduleReminder(
      dynamic notificationService) async {
    try {
      if (_activeProvider == PaymentProvider.revenueCat) {
        final customerInfo = await Purchases.getCustomerInfo();
        final entitlement = customerInfo.entitlements.all[entitlementId];

        // periodType in RevenueCat is usually 'TRIAL', 'NORMAL', 'INTRO'
        if (entitlement != null &&
            entitlement.isActive &&
            entitlement.periodType == PeriodType.trial) {
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
