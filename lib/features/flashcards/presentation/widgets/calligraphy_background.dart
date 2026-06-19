import 'package:flutter/material.dart';

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
        color: isDark 
            ? const Color(0xFF1A1A1A) 
            : const Color(0xFFFDF5E6), // Old Lace / Parchment
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
