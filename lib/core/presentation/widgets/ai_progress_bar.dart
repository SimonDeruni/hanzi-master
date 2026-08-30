import 'package:flutter/material.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class AiProgressBar extends StatefulWidget {
  final String? label;

  const AiProgressBar({
    super.key,
    this.label,
  });

  @override
  State<AiProgressBar> createState() => _AiProgressBarState();
}

class _AiProgressBarState extends State<AiProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              height: 6,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.withValues(alpha: 0.3),
                    Colors.purpleAccent.withValues(alpha: 0.8),
                    Colors.blueAccent.withValues(alpha: 0.8),
                    Colors.indigo.withValues(alpha: 0.3),
                  ],
                  stops: [
                    0.0,
                    (_controller.value - 0.2).clamp(0.0, 1.0),
                    _controller.value,
                    1.0,
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome,
                size: 16, color: Colors.purpleAccent),
            const SizedBox(width: 8),
            Text(
              widget.label ?? AppLocalizations.of(context)!.aiIsThinking,
              style: const TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
