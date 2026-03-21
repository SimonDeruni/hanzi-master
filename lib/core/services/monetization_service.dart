import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class MonetizationService {
  // --- CONFIGURATION ---
  // In a real production app, these should be injected via --dart-define or a config file.
  static const Map<TargetPlatform, String> _apiKeys = {
    TargetPlatform.android: 'goog_YOUR_GOOGLE_API_KEY',
    TargetPlatform.iOS: 'appl_YOUR_APPLE_API_KEY',
  };
  
  static const String entitlementId = 'scholars_edition';

  /// Initializes RevenueCat. Call this early in main.dart.
  static Future<void> init() async {
    try {
      if (kDebugMode) {
        await Purchases.setLogLevel(LogLevel.debug);
      }

      final apiKey = _apiKeys[defaultTargetPlatform];
      if (apiKey == null || apiKey.contains('YOUR_')) {
        debugPrint("RevenueCat: API Key for $defaultTargetPlatform is missing or placeholder.");
        // We continue in debug mode, but production will need real keys.
        if (!kDebugMode) return;
      }

      if (apiKey != null) {
        await Purchases.configure(PurchasesConfiguration(apiKey));
        debugPrint("RevenueCat: Initialized for $defaultTargetPlatform");
      }
    } catch (e) {
      debugPrint("RevenueCat Init Error: $e");
    }
  }

  /// Checks if the user currently has the 'scholars_edition' entitlement active.
  static Future<bool> checkPremiumStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive == true;
    } catch (e) {
      debugPrint("Error checking premium status: $e");
      return false;
    }
  }

  /// Fetches the available packages (products) to display on the paywall.
  static Future<List<Package>> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
        return offerings.current!.availablePackages;
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching offerings: $e");
      return [];
    }
  }

  /// Attempts to purchase a package. Returns true if successful.
  static Future<bool> purchasePackage(Package package) async {
    try {
      // ignore: deprecated_member_use
      await Purchases.purchasePackage(package);
      // v9 API: purchasePackage returns PurchaseResult (not CustomerInfo).
      // We must call getCustomerInfo() separately to check the entitlement status.
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive == true;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint("Purchase failed: $e");
      }
      return false;
    }
  }


  /// Restores previous purchases (essential for Apple App Store compliance).
  static Future<bool> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.all[entitlementId]?.isActive == true;
    } catch (e) {
      debugPrint("Error restoring purchases: $e");
      return false;
    }
  }
}
