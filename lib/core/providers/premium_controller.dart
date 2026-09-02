import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/monetization_service.dart';
import '../services/notification_service.dart';

part 'premium_controller.g.dart';

@Riverpod(keepAlive: true)
class PremiumController extends _$PremiumController {
  @override
  Future<bool> build() async {
    // Check local status on boot
    final isPremium = await MonetizationService.checkPremiumStatus();
    if (isPremium) {
      final notificationService = ref.read(notificationServiceProvider);
      await MonetizationService.checkTrialAndScheduleReminder(
          notificationService);
    }
    return isPremium;
  }

  /// Call this after a successful purchase or restore
  Future<void> refreshStatus() async {
    state = const AsyncValue.loading();
    try {
      final isPremium = await MonetizationService.checkPremiumStatus();
      if (isPremium) {
        final notificationService = ref.read(notificationServiceProvider);
        await MonetizationService.checkTrialAndScheduleReminder(
            notificationService);
      }
      state = AsyncValue.data(isPremium);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Reflects a temporary premium grant immediately in the current UI.
  void grantTemporaryAccess() {
    state = const AsyncValue.data(true);
  }

  /// A debug tool to force unlock premium features locally during development
  void debugUnlock() {
    grantTemporaryAccess();
  }
}
