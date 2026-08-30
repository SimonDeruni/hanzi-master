import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// A unified, calligraphic search bar adhering to the Zen & Ink aesthetic.
/// Used across all screens (Dictionary, Reading Room, Media, Shows, Stories, Radicals, Scenarios, Decks).
class ZenSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;
  final bool enabled;
  final VoidCallback? onTap;

  const ZenSearchBar({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.focusNode,
    this.autofocus = false,
    this.leading,
    this.trailing,
    this.margin,
    this.enabled = true,
    this.onTap,
  });

  @override
  State<ZenSearchBar> createState() => _ZenSearchBarState();
}

class _ZenSearchBarState extends State<ZenSearchBar> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    widget.controller.addListener(_onTextChange);
  }

  @override
  void didUpdateWidget(covariant ZenSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTextChange);
      widget.controller.addListener(_onTextChange);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _onTextChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasText = widget.controller.text.isNotEmpty;

    // Zen & Ink Palette
    final bgColor = isDark ? const Color(0xFF222224) : Colors.white;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);
    final shadowColor = Colors.black.withValues(alpha: isDark ? 0.25 : 0.04);
    final textColor =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    final iconColor = isDark ? Colors.white54 : Colors.black45;

    Widget searchBarWidget = Container(
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 14),
          widget.leading ??
              Icon(
                Icons.search_rounded,
                size: 20,
                color: iconColor,
              ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              onTap: widget.onTap,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: isDark ? Colors.amber : const Color(0xFF1A1A1B),
              decoration: InputDecoration(
                hintText:
                    widget.hintText ?? AppLocalizations.of(context)!.searchHint,
                hintStyle: TextStyle(
                  color: hintColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          if (hasText)
            IconButton(
              icon: Icon(
                Icons.close_rounded,
                size: 18,
                color: iconColor,
              ),
              splashRadius: 18,
              tooltip: AppLocalizations.of(context)!.clear,
              onPressed: () {
                HapticFeedback.lightImpact();
                widget.controller.clear();
                widget.onChanged?.call('');
                widget.onClear?.call();
              },
            ),
          if (widget.trailing != null) ...[
            if (!hasText) const SizedBox(width: 4),
            widget.trailing!,
            const SizedBox(width: 8),
          ] else if (!hasText) ...[
            const SizedBox(width: 14),
          ],
        ],
      ),
    );

    if (widget.margin != null) {
      searchBarWidget = Padding(
        padding: widget.margin!,
        child: searchBarWidget,
      );
    }

    return searchBarWidget;
  }
}
