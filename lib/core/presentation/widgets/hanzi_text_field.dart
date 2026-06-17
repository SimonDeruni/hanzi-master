import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/handwriting_keyboard.dart';

class HanziTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? style;
  final InputDecoration? decoration;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int? maxLines;

  const HanziTextField({
    super.key,
    required this.controller,
    this.hintText = 'Type or draw Hanzi...',
    this.style,
    this.decoration,
    this.onSubmitted,
    this.validator,
    this.focusNode,
    this.maxLines = 1,
  });

  @override
  State<HanziTextField> createState() => _HanziTextFieldState();
}

class _HanziTextFieldState extends State<HanziTextField> {
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    _focusNode.removeListener(_onFocusChange);
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    // If the system keyboard appears, hide our custom overlay
    if (_focusNode.hasFocus && _overlayEntry != null) {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showHandwritingOverlay() {
    if (_overlayEntry != null) return;

    // Unfocus the system keyboard first
    _focusNode.unfocus();

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Material(
            elevation: 10,
            child: HandwritingKeyboard(
              textController: widget.controller,
              onDismiss: () {
                _removeOverlay();
                _focusNode.requestFocus(); // Bring back system keyboard optionally, or just close
              },
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final defaultDeco = InputDecoration(
      hintText: widget.hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    final finalDeco = widget.decoration?.copyWith(
      suffixIcon: IconButton(
        icon: const Icon(Icons.draw),
        onPressed: () {
          if (_overlayEntry != null) {
            _removeOverlay();
            _focusNode.requestFocus();
          } else {
            _showHandwritingOverlay();
          }
        },
      ),
    ) ?? defaultDeco.copyWith(
      suffixIcon: IconButton(
        icon: const Icon(Icons.draw),
        onPressed: () {
          if (_overlayEntry != null) {
            _removeOverlay();
            _focusNode.requestFocus();
          } else {
            _showHandwritingOverlay();
          }
        },
      ),
    );

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: widget.style,
      decoration: finalDeco,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      maxLines: widget.maxLines,
    );
  }
}
