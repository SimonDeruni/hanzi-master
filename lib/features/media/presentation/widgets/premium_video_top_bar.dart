import 'dart:ui';
import 'package:flutter/material.dart';

class PremiumVideoTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onExitFullscreen;
  final bool showHanzi;
  final bool showPinyin;
  final bool showEnglish;
  final ValueChanged<bool> onToggleHanzi;
  final ValueChanged<bool> onTogglePinyin;
  final ValueChanged<bool> onToggleEnglish;
  final double playbackRate;
  final ValueChanged<double> onSpeedChanged;

  const PremiumVideoTopBar({
    super.key,
    required this.title,
    required this.onExitFullscreen,
    required this.showHanzi,
    required this.showPinyin,
    required this.showEnglish,
    required this.onToggleHanzi,
    required this.onTogglePinyin,
    required this.onToggleEnglish,
    required this.playbackRate,
    required this.onSpeedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.black.withValues(alpha: 0.4),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onExitFullscreen,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // CC Menu Button
              PopupMenuButton<String>(
                icon: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.closed_caption, color: Colors.white, size: 20),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
                    ],
                  ),
                ),
                color: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                itemBuilder: (context) {
                  bool localHanzi = showHanzi;
                  bool localPinyin = showPinyin;
                  bool localEnglish = showEnglish;
                  return [
                    PopupMenuItem(
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return SwitchListTile(
                            title: const Text('Show Hanzi', style: TextStyle(color: Colors.white)),
                            value: localHanzi,
                            activeThumbColor: Colors.white,
                            onChanged: (v) {
                              setState(() => localHanzi = v);
                              onToggleHanzi(v);
                            },
                          );
                        }
                      ),
                    ),
                    PopupMenuItem(
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return SwitchListTile(
                            title: const Text('Show Pinyin', style: TextStyle(color: Colors.white)),
                            value: localPinyin,
                            activeThumbColor: Colors.white,
                            onChanged: (v) {
                              setState(() => localPinyin = v);
                              onTogglePinyin(v);
                            },
                          );
                        }
                      ),
                    ),
                    PopupMenuItem(
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return SwitchListTile(
                            title: const Text('Show English', style: TextStyle(color: Colors.white)),
                            value: localEnglish,
                            activeThumbColor: Colors.white,
                            onChanged: (v) {
                              setState(() => localEnglish = v);
                              onToggleEnglish(v);
                            },
                          );
                        }
                      ),
                    ),
                  ];
                },
              ),
              const SizedBox(width: 8),
              // Speed Menu Button
              PopupMenuButton<double>(
                icon: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${playbackRate}x', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(width: 4),
                      const Icon(Icons.speed, color: Colors.white, size: 20),
                    ],
                  ),
                ),
                color: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onSelected: onSpeedChanged,
                itemBuilder: (context) => [
                  for (final speed in [0.5, 0.75, 1.0, 1.25, 1.5, 2.0])
                    PopupMenuItem(
                      value: speed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${speed}x', style: const TextStyle(color: Colors.white)),
                          if (playbackRate == speed)
                            const Icon(Icons.check, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
