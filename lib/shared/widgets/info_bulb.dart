import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';

class InfoBulb extends StatefulWidget {
  final String id;
  final String title;
  final String message;
  final IconData icon;
  final Color? color;

  const InfoBulb({
    super.key,
    this.id = "",
    this.title = "",
    this.message = "",
    this.icon = Icons.info_outline,
    this.color,
  });

  @override
  State<InfoBulb> createState() => _InfoBulbState();
}

class _InfoBulbState extends State<InfoBulb> {
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('info_bulb_${widget.id}') ?? false;
    if (mounted) {
      setState(() => _dismissed = seen);
    }
  }

  Future<void> _dismiss() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('info_bulb_${widget.id}', true);
    if (mounted) {
      setState(() => _dismissed = true);
    }
  }

  void _showDialog() {
    HapticsManager.light();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(widget.icon, color: widget.color ?? Colors.brown, size: 24),
            const SizedBox(width: 10),
            Expanded(child: Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
          ],
        ),
        content: Text(widget.message, style: const TextStyle(fontSize: 15, height: 1.5)),
        actions: [
          TextButton(
            onPressed: () {
              _dismiss();
              Navigator.of(ctx).pop();
            },
            child: const Text("Got it", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return GestureDetector(
      onTap: _showDialog,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: (widget.color ?? Colors.brown).withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.icon,
          size: 16,
          color: widget.color ?? Colors.brown,
        ),
      ),
    );
  }
}