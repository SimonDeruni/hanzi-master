/// Who gets premium without a purchase, and who merely looks like they might.
///
/// The policy lives in one table so this can be asserted without pumping a screen:
/// `auth_screen` is only the first entry point that asks.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';

void main() {
  group('the comped account table', () {
    test('accepts the owner account with its own password', () {
      expect(
        MonetizationService.isCompedAccount('hanbaobao@love.com', 'SomeSuprise'),
        isTrue,
      );
    });

    test('ignores the casing and padding a phone keyboard adds', () {
      expect(
        MonetizationService.isCompedAccount(' HanBaoBao@Love.com ', 'SomeSuprise'),
        isTrue,
      );
    });

    test('refuses a near miss, because this one is compared exactly', () {
      // The review addresses accept any 6+ character password; the owner's account
      // must not, or guessing the address would be enough — and the address is in the
      // app binary like everything else here.
      for (final String password in <String>[
        'someSuprise',
        'somesuprise',
        'SomeSurprise',
        'SomeSuprise ',
        'SomeSupris',
        'SomeSuprise1',
        '',
      ]) {
        expect(
          MonetizationService.isCompedAccount('hanbaobao@love.com', password),
          isFalse,
          reason: '"$password" must not open the comped account',
        );
      }
    });

    test('does not leak the entitlement to other addresses', () {
      expect(
        MonetizationService.isCompedAccount('someone.else@love.com', 'SomeSuprise'),
        isFalse,
      );
      expect(
        MonetizationService.isCompedAccount('hanbaobao@love.com.evil.com', 'SomeSuprise'),
        isFalse,
      );
      // And the owner's address is deliberately *not* in the lenient review set.
      expect(
        MonetizationService.reviewAccounts.contains('hanbaobao@love.com'),
        isFalse,
      );
    });
  });

  group('the review addresses', () {
    test('keep their leniency, because a reviewer signs up with what review says', () {
      for (final String email in MonetizationService.reviewAccounts) {
        expect(MonetizationService.isCompedAccount(email, 'AppleReview2026!'), isTrue,
            reason: email);
        expect(MonetizationService.isCompedAccount(email, 'demo1234'), isTrue,
            reason: email);
        // Still not a one-character password.
        expect(MonetizationService.isCompedAccount(email, 'short'), isFalse,
            reason: email);
      }
      expect(MonetizationService.reviewAccountMinPasswordLength, 6);
    });

    test('are created under a generic name, the owner account under its own', () {
      expect(MonetizationService.compedAccountName('hanbaobao@love.com'),
          'Han Bao Bao');
      expect(MonetizationService.compedAccountName('Apple.Review@SinoSpark.app'),
          'Reviewer');
      expect(MonetizationService.compedAccountName('nobody@example.com'), 'Reviewer');
    });
  });
}
