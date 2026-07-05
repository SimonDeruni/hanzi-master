import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_key_pool.dart';

part 'revenuecat_service.g.dart';

@riverpod
class RevenueCatService extends _$RevenueCatService {
  @override
  bool build() {
    // Initial state is free tier
    _initRevenueCat();
    return false; // returns true if user is premium
  }

  Future<void> _initRevenueCat() async {
    try {
      await Purchases.setLogLevel(LogLevel.debug);
      
      late PurchasesConfiguration configuration;
      if (Platform.isAndroid) {
        configuration = PurchasesConfiguration(ApiKeyPool().revenueCatAndroidKey);
      } else if (Platform.isIOS) {
        configuration = PurchasesConfiguration(ApiKeyPool().revenueCatAppleKey);
      }
      
      await Purchases.configure(configuration);
      
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      _checkEntitlements(customerInfo);

      // Listen for purchase updates
      Purchases.addCustomerInfoUpdateListener((customerInfo) {
        _checkEntitlements(customerInfo);
      });
    } catch (e) {
      debugPrint("Error initializing RevenueCat: $e");
    }
  }

  void _checkEntitlements(CustomerInfo customerInfo) {
    if (customerInfo.entitlements.all["premium"]?.isActive == true) {
      state = true;
    } else {
      state = false;
    }
  }

  Future<bool> purchasePackage(Package package) async {
    try {
      final result = await Purchases.purchasePackage(package);
      _checkEntitlements(result.customerInfo);
      return state;
    } catch (e) {
      debugPrint("Purchase failed: $e");
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      _checkEntitlements(customerInfo);
      return state;
    } catch (e) {
      debugPrint("Restore failed: $e");
      return false;
    }
  }

  Future<List<Offering>> getOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
        return [offerings.current!];
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching offerings: $e");
      return [];
    }
  }
}
