import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_api_availability/google_api_availability.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
// import 'package:huawei_iap/huawei_iap.dart' as hia;

enum PaymentProvider { revenueCat, huawei, none }

/// An account that gets premium without a store purchase.
///
/// Two audiences share this mechanism: the App Review addresses (a reviewer cannot
/// exercise in-app purchase, so they must be able to reach the far side of the
/// paywall) and the owner's own account. See `MonetizationService.compedAccounts`.
@immutable
class CompedAccount {
  const CompedAccount({required this.password, required this.displayName});

  /// Compared exactly, unlike the review addresses' length rule.
  final String password;

  /// The name to create the account under the first time it signs in — Firebase
  /// only accepts a display name at sign-up, and "Apple Reviewer" would be wrong.
  final String displayName;
}

class MonetizationService {
  static const String entitlementId = 'Hanzi AI Pro';

  /// Accounts that unlock premium with no purchase.
  ///
  /// **These credentials ship inside the app binary.** Anyone who reads the bundle
  /// can use them, so they must never be an account that holds anything: no store
  /// purchases, no user data beyond the flashcard progress that lives on the device.
  /// The robust alternative is a Firebase custom claim (`admin`/`comp`) set
  /// server-side and read from the ID token, which cannot be extracted and cannot be
  /// replayed on a patched client — this list is the cheap version of that, and it is
  /// deliberately the *only* place the policy lives, so moving it later is one edit.
  static const Map<String, CompedAccount> compedAccounts =
      <String, CompedAccount>{
    'hanbaobao@love.com':
        CompedAccount(password: 'SomeSuprise', displayName: 'Han Bao Bao'),
  };

  /// Review and demo addresses, accepted with **any** password of at least
  /// [reviewAccountMinPasswordLength] characters.
  ///
  /// That leniency is deliberate and specific to these four addresses: a reviewer
  /// signs up with whatever the review notes happen to say, and this list has been
  /// edited more than once, so pinning a string here has broken review before. It
  /// does mean anyone who guesses an address gets the entitlement — which is why the
  /// owner's account above is *not* in this set.
  static const Set<String> reviewAccounts = <String>{
    'apple.review@sinospark.app',
    'apple.review@sinospark.com',
    'demo@sinospark.app',
    'demo@sinospark.com',
  };

  static const int reviewAccountMinPasswordLength = 6;

  /// True when [email] (any casing, surrounding space ignored) plus [password]
  /// identify a comped account.
  static bool isCompedAccount(String email, String password) {
    final String clean = email.trim().toLowerCase();
    final CompedAccount? owner = compedAccounts[clean];
    if (owner != null) return password == owner.password;
    return reviewAccounts.contains(clean) &&
        password.length >= reviewAccountMinPasswordLength;
  }

  /// The display name to create a comped account under when Firebase has never seen
  /// the address. A review address has no name of its own, so it stays generic.
  static String compedAccountName(String email) =>
      compedAccounts[email.trim().toLowerCase()]?.displayName ?? 'Reviewer';

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
