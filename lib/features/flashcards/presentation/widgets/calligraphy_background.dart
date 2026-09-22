import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';

class CalligraphyBackground extends StatelessWidget {
  final Widget child;
  const CalligraphyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        // Canonical surface: identical to the app bar / nav bar so there is no
        // visible seam between the header and the body.
        color: AppTheme.surfaceOf(context),
      ),
      child: Stack(
        children: [
          // 1. PAPER TEXTURE OVERLAY (Removed broken asset)
          Positioned.fill(
            child: Container(
              color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.brown.withValues(alpha: 0.02),
            ),
          ),
          
          // 2. SEPIA WASH (Subtle radial aging)
          if (!isDark)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.transparent,
                      const Color(0xFFE6D5B8).withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),

          // 3. MAIN CONTENT
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
