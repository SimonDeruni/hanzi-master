import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/monetization_service.dart';

part 'premium_controller.g.dart';

@Riverpod(keepAlive: true)
class PremiumController extends _$PremiumController {
  @override
  Future<bool> build() async {
    // Check local status on boot
    return await MonetizationService.checkPremiumStatus();
  }

  /// Call this after a successful purchase or restore
  Future<void> refreshStatus() async {
    state = const AsyncValue.loading();
    try {
      final isPremium = await MonetizationService.checkPremiumStatus();
      state = AsyncValue.data(isPremium);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  /// A debug tool to force unlock premium features locally during development
  void debugUnlock() {
    state = const AsyncValue.data(true);
  }
}
