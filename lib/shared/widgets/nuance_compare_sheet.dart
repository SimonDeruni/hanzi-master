import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';

class NuanceCompareSheet extends ConsumerStatefulWidget {
  final List<Map<String, String>> words;
  final String groupLabel;

  const NuanceCompareSheet({
    super.key,
    required this.words,
    required this.groupLabel,
  });

  static void show(
    BuildContext context, {
    required List<Map<String, String>> words,
    required String groupLabel,
  }) {
    GlobalBlurredBottomSheet.show(
      context,
      child: NuanceCompareSheet(words: words, groupLabel: groupLabel),
    );
  }

  @override
  ConsumerState<NuanceCompareSheet> createState() => _NuanceCompareSheetState();
}

class _NuanceCompareSheetState extends ConsumerState<NuanceCompareSheet> {
  bool _isLoading = true;
  String _streamedText = '';
  String? _error;
  String _statusText = 'Analyzing word relationships...';
  bool _isChatMode = false;
  late final AiChatSession _chatSession;
  final List<_ChatMessage> _chatMessages = [];
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isChatLoading = false;
  StreamSubscription<String>? _streamSubscription;
  Timer? _statusTimer;
  Timer? _timeoutTimer;
  // Rotating status messages to show progress while streaming
  static const _statusMessages = [
    'Analyzing word relationships...',
    'Identifying usage contexts...',
    'Comparing formality levels...',
    'Finding common collocations...',
    'Generating comparison...',
  ];

  @override
  void initState() {
    super.initState();
    _loadExplanationStreaming();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _statusTimer?.cancel();
    _timeoutTimer?.cancel();
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startStatusRotation() {
    int index = 0;
    _statusTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      index = (index + 1) % _statusMessages.length;
      setState(() {
        _statusText = _statusMessages[index];
      });
    });
  }

  Future<void> _loadExplanationStreaming() async {
    final gemini = ref.read(geminiServiceProvider);

    // Start rotating status messages
    _startStatusRotation();

    // 30-second timeout — if no first token arrives by then, show timeout UI
    _timeoutTimer = Timer(const Duration(seconds: 30), () {
      if (mounted && _streamedText.isEmpty) {
        setState(() {
          _isLoading = false;
          _error = 'Generation is taking longer than expected. The AI may be overloaded.';
        });
        _statusTimer?.cancel();
        _streamSubscription?.cancel();
      }
    });

    try {
      _streamSubscription = gemini.streamCompareNuances(widget.words).listen(
        (token) {
          if (!mounted) return;
          _timeoutTimer?.cancel(); // Got data, cancel timeout
          setState(() {
            _streamedText += token;
            // Once we have content, switch status to indicate streaming
            if (_streamedText.length > 50 && _isLoading) {
              _statusText = 'Generating comparison...';
            }
          });
        },
        onDone: () {
          if (!mounted) return;
          _statusTimer?.cancel();
          _timeoutTimer?.cancel();
          setState(() {
            _isLoading = false;
            _statusText = '';
          });
        },
        onError: (e) {
          if (!mounted) return;
          _statusTimer?.cancel();
          _timeoutTimer?.cancel();
          setState(() {
            // If we got partial text, show it with an error banner
            if (_streamedText.isNotEmpty) {
              _error = 'Generation interrupted. Showing partial result.';
            } else {
              _error = e.toString();
            }
            _isLoading = false;
            _statusText = '';
          });
        },
        cancelOnError: true,
      );
    } catch (e) {
      if (!mounted) return;
      _statusTimer?.cancel();
      _timeoutTimer?.cancel();
      setState(() {
        _error = e.toString();
        _isLoading = false;
        _statusText = '';
      });
    }
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _streamedText = '';
      _error = null;
      _statusText = 'Analyzing word relationships...';
    });
    _loadExplanationStreaming();
  }

  void _enterChatMode() {
    final gemini = ref.read(geminiServiceProvider);
    final wordNames = widget.words.map((w) => w['hanzi'] ?? '').join(', ');
    _chatSession = gemini.startCharacterChat(wordNames, 'en');
    setState(() {
      _isChatMode = true;
    });
  }

  Future<void> _sendChatMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _chatMessages.add(_ChatMessage(isUser: true, text: text));
      _isChatLoading = true;
    });
    _chatController.clear();

    try {
      final reply = await _chatSession.sendMessage(text);
      if (mounted) {
        setState(() {
          _chatMessages.add(_ChatMessage(isUser: false, text: reply));
          _isChatLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _chatMessages.add(_ChatMessage(isUser: false, text: 'Sorry, something went wrong.'));
          _isChatLoading = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_isChatMode) {
      return _buildChatView(theme, isDark);
    }

    return _buildOneShotView(theme, isDark);
  }

  Widget _buildOneShotView(ThemeData theme, bool isDark) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                const Icon(Icons.compare_arrows, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Nuances: ${widget.groupLabel}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Word chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.words.map((w) {
                return Chip(
                  label: Text(
                    '${w['hanzi']} ${w['pinyin'] ?? ''}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ),
          // Content
          Flexible(
            child: _buildContent(theme, isDark),
          ),
          // Bottom bar
          if (!_isLoading && _error == null && _streamedText.isNotEmpty)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _enterChatMode,
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: const Text('Chat more'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormattedContent(String rawText, ThemeData theme, bool isDark) {
    if (rawText.isEmpty) return const SizedBox.shrink();

    // Fix Numerical Pinyin
    String processed = PinyinUtils.convertNumericToMarks(rawText);

    // Split by newlines
    final blocks = processed.split('\n');
    final children = <Widget>[];

    for (var block in blocks) {
      if (block.trim().isEmpty) continue;

      // Highlight Targets at start of bullets
      for (var w in widget.words) {
        final hanzi = w['hanzi'];
        if (hanzi != null && hanzi.isNotEmpty && block.startsWith('* $hanzi')) {
          block = block.replaceFirst('* $hanzi', '* **$hanzi**');
        } else if (hanzi != null && hanzi.isNotEmpty && block.startsWith('- $hanzi')) {
          block = block.replaceFirst('- $hanzi', '- **$hanzi**');
        } else if (hanzi != null && hanzi.isNotEmpty && block.startsWith('• $hanzi')) {
          block = block.replaceFirst('• $hanzi', '• **$hanzi**');
        } else if (hanzi != null && hanzi.isNotEmpty && block.startsWith(hanzi)) {
          block = block.replaceFirst(hanzi, '**$hanzi**');
        }
      }

      // Style Examples
      if (block.trim().startsWith('Usage:')) {
        children.add(
          Container(
            margin: const EdgeInsets.only(bottom: 16, left: 16, right: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border(left: BorderSide(color: Colors.indigo.shade300, width: 4)),
            ),
            child: TappableMarkdownHanziText(
              block.replaceFirst('Usage:', '').trim(),
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
                fontStyle: FontStyle.italic,
                fontSize: 13,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
              ),
            ),
          )
        );
      } else {
        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TappableMarkdownHanziText(
              block,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.7,
              ),
            ),
          )
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildContent(ThemeData theme, bool isDark) {
    // Error state with retry
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Show partial text if we have it
            if (_streamedText.isNotEmpty) ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Error banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.orange.shade700, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _error!,
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFormattedContent(_streamedText, theme, isDark),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // No partial text — full error
              Icon(Icons.cloud_off, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _retry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Loading / streaming state
    if (_isLoading) {
      return Column(
        children: [
          // Dynamic status text with spinner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _statusText,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Streaming text display (shows tokens as they arrive)
          if (_streamedText.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormattedContent(_streamedText, theme, isDark),
                    // Blinking cursor to indicate still generating
                    const SizedBox(height: 4),
                    _PulsingCursor(),
                  ],
                ),
              ),
            )
          else
            // Skeleton placeholder while waiting for first token
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSkeletonLines(isDark),
              ),
            ),
        ],
      );
    }

    // Completed — show full text
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: _buildFormattedContent(_streamedText, theme, isDark),
    );
  }

  /// Shimmer skeleton lines shown while waiting for the first streaming token.
  Widget _buildSkeletonLines(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(8, (index) {
        final widths = [0.9, 0.75, 0.85, 0.6, 0.95, 0.7, 0.8, 0.5];
        final width = widths[index % widths.length];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ShimmerLine(
            widthFactor: width,
            isDark: isDark,
          ),
        );
      }),
    );
  }

  Widget _buildChatView(ThemeData theme, bool isDark) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chat header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_outline, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Chat about: ${widget.groupLabel}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Chat messages
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _chatMessages.length + (_isChatLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isChatLoading && index == _chatMessages.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }
                final msg = _chatMessages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Align(
                    alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: msg.isUser
                            ? theme.colorScheme.primary.withValues(alpha: 0.15)
                            : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        msg.text,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Chat input
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: HanziTextField(
                      controller: _chatController,
                      decoration: InputDecoration(
                        hintText: 'Ask a follow-up...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        isDense: true,
                      ),
                      onSubmitted: _sendChatMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _isChatLoading
                        ? null
                        : () => _sendChatMessage(_chatController.text),
                    icon: const Icon(Icons.send, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Pulsing cursor shown at end of streaming text ───────────────────────────

class _PulsingCursor extends StatefulWidget {
  @override
  State<_PulsingCursor> createState() => _PulsingCursorState();
}

class _PulsingCursorState extends State<_PulsingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: 18,
        decoration: BoxDecoration(
          color: Colors.indigo.shade400,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

// ─── Shimmer skeleton line ───────────────────────────────────────────────────

class _ShimmerLine extends StatefulWidget {
  final double widthFactor;
  final bool isDark;
  const _ShimmerLine({required this.widthFactor, required this.isDark});

  @override
  State<_ShimmerLine> createState() => _ShimmerLineState();
}

class _ShimmerLineState extends State<_ShimmerLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final shimmer = Color.lerp(
          widget.isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          widget.isDark ? Colors.grey.shade600 : Colors.grey.shade400,
          _animation.value,
        )!;
        return FractionallySizedBox(
          widthFactor: widget.widthFactor,
          child: Container(
            height: 14,
            decoration: BoxDecoration(
              color: shimmer,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      },
    );
  }
}

// ─── Chat message model ──────────────────────────────────────────────────────

class _ChatMessage {
  final bool isUser;
  final String text;
  const _ChatMessage({required this.isUser, required this.text});
}