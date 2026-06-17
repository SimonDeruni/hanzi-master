import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/digital_ink_service.dart';
import 'package:hanzi_master/core/presentation/widgets/handwriting_canvas.dart';

class HandwritingKeyboard extends ConsumerStatefulWidget {
  final TextEditingController textController;
  final VoidCallback onDismiss;

  const HandwritingKeyboard({
    super.key,
    required this.textController,
    required this.onDismiss,
  });

  @override
  ConsumerState<HandwritingKeyboard> createState() => _HandwritingKeyboardState();
}

class _HandwritingKeyboardState extends ConsumerState<HandwritingKeyboard> {
  List<String> _candidates = [];
  final GlobalKey<HandwritingCanvasState> _canvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Pre-warm the model
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(digitalInkServiceProvider).initialize();
    });
  }

  Future<void> _handleInkChanged(ink) async {
    if (ink.strokes.isEmpty) {
      setState(() => _candidates = []);
      return;
    }
    
    final candidates = await ref.read(digitalInkServiceProvider).recognizeStrokes(ink);
    if (mounted) {
      setState(() {
        _candidates = candidates.take(5).toList();
      });
    }
  }

  void _insertCandidate(String char) {
    final text = widget.textController.text;
    final selection = widget.textController.selection;
    
    if (selection.baseOffset >= 0 && selection.extentOffset >= 0) {
      final newText = text.replaceRange(selection.baseOffset, selection.extentOffset, char);
      widget.textController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.baseOffset + char.length),
      );
    } else {
      widget.textController.text = text + char;
    }
    
    _canvasKey.currentState?.clear();
    setState(() => _candidates = []);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDownloaded = ref.watch(digitalInkServiceProvider).isModelDownloaded;

    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Column(
        children: [
          // Toolbar / Candidates row
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_hide),
                  onPressed: widget.onDismiss,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _candidates.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => _insertCandidate(_candidates[index]),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(color: theme.colorScheme.outlineVariant)),
                          ),
                          child: Text(
                            _candidates[index],
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (!isDownloaded)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Downloading model...", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary)),
                  ),
              ],
            ),
          ),
          // Canvas area
          Expanded(
            child: HandwritingCanvas(
              key: _canvasKey,
              onInkChanged: _handleInkChanged,
              strokeColor: theme.colorScheme.onSurface,
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}
