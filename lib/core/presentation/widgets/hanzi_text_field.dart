import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HanziTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? style;
  final InputDecoration? decoration;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool autofocus;
  final bool expands;
  final bool showClearButton;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  const HanziTextField({
    super.key,
    required this.controller,
    this.hintText = 'Type Hanzi, Pinyin, or English...',
    this.style,
    this.decoration,
    this.onSubmitted,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.maxLines = 1,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.autofocus = false,
    this.expands = false,
    this.showClearButton = true,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
  });

  @override
  State<HanziTextField> createState() => _HanziTextFieldState();
}

class _HanziTextFieldState extends State<HanziTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    widget.controller.addListener(_onControllerChange);
  }

  @override
  void didUpdateWidget(covariant HanziTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onControllerChange);
      widget.controller.addListener(_onControllerChange);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _onControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget? _buildSuffix(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;

    if (widget.showClearButton && hasText) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final clearBtn = IconButton(
        icon: Icon(
          Icons.close_rounded,
          size: 18,
          color: isDark ? Colors.white54 : Colors.black45,
        ),
        splashRadius: 18,
        tooltip: 'Clear',
        onPressed: () {
          HapticFeedback.lightImpact();
          widget.controller.clear();
          widget.onChanged?.call('');
        },
      );

      if (widget.suffixIcon != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [clearBtn, widget.suffixIcon!],
        );
      }
      return clearBtn;
    }

    return widget.suffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final suffix = _buildSuffix(context);

    final defaultDeco = InputDecoration(
      hintText: widget.hintText,
      hintStyle: TextStyle(
        color: isDark ? Colors.white38 : Colors.black38,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: isDark
          ? const Color(0xFF252528)
          : const Color(0xFFF2EFE9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIcon: widget.prefixIcon,
      suffixIcon: suffix,
    );

    final finalDeco = widget.decoration != null
        ? widget.decoration!.copyWith(
            suffixIcon: suffix ?? widget.decoration!.suffixIcon,
            prefixIcon: widget.prefixIcon ?? widget.decoration!.prefixIcon,
          )
        : defaultDeco;

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: widget.style ??
          TextStyle(
            color: isDark ? Colors.white : const Color(0xFF1A1A1B),
            fontSize: 15,
          ),
      decoration: finalDeco,
      onFieldSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      validator: widget.validator,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      expands: widget.expands,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
    );
  }
}
