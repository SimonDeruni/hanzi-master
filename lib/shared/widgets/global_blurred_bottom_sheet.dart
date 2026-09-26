import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

class GlobalBlurredBottomSheet extends StatelessWidget {
  final Widget child;

  const GlobalBlurredBottomSheet({super.key, required this.child});

  static Future<T?> show<T>(BuildContext context, {required Widget child}) {
    return showModalBottomSheet<T>(
      context: context,
      // Tokenised sheet timing. Material's own default for a modal sheet is
      // 250ms on an easeOutQuad curve - neither is in the vocabulary - so every
      // sheet opened before this ran outside the durations and curves the
      // standard documents for "Sheet, dialog, panel open + close".
      sheetAnimationStyle: AnimationStyle(
        duration: ZenMotion.of(context, ZenMotion.quick),
        curve: ZenMotion.natural,
        reverseDuration: ZenMotion.of(context, ZenMotion.quick),
        reverseCurve: ZenMotion.natural,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: GlobalBlurredBottomSheet(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFDFCF0);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 32,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 6),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: isDark ? 0.4 : 0.28),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Flexible(child: child),
        ],
      ),
    );
  }
}
