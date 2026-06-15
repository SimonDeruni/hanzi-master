import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/chat/presentation/providers/chat_controller.dart';
import 'package:hanzi_master/features/chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:intl/intl.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

class EchoHallScreen extends ConsumerStatefulWidget {
  const EchoHallScreen({super.key});

  @override
  ConsumerState<EchoHallScreen> createState() => _EchoHallScreenState();
}

class _EchoHallScreenState extends ConsumerState<EchoHallScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showCustomPromptField = false;
  final TextEditingController _customPromptController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _customPromptController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final theme = Theme.of(context);

    ref.listen(chatControllerProvider, (previous, next) {
      if (next.messages.length != (previous?.messages.length ?? 0)) {
        final lastMessage = next.messages.last;
        if (lastMessage.role == ChatRole.scholar) {
          ref.read(audioServiceProvider).playSentence(lastMessage.content);
        }
        _scrollToBottom();
      }
    });

    return Scaffold(
      appBar: _buildAppBar(chatState, theme),
      body: CalligraphyBackground(
        child: Column(
          children: [
            // Horizontal Persona Selector
            _buildPersonaSelector(chatState, theme),
            if (_showCustomPromptField) _buildCustomPromptArea(theme),
            // Chat Messages
            Expanded(
              child: chatState.messages.isEmpty
                  ? _buildEmptyState(chatState.activePersona, theme)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      itemCount: chatState.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatState.messages[index];
                        return _ChatBubble(message: message, theme: theme);
                      },
                    ),
            ),
            // Typing indicator
            if (chatState.isLoading) _buildTypingIndicator(theme),
            // Input area
            _buildInputArea(chatState, theme),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ChatState chatState, ThemeData theme) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface, size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getPersonaName(chatState.activePersona),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Container(
            height: 1.5,
            width: 40,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.onSurface.withValues(alpha: 0), theme.colorScheme.onSurface.withValues(alpha: 0.4), theme.colorScheme.onSurface.withValues(alpha: 0)],
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.onSurface.withValues(alpha: 0.4), size: 22),
          onPressed: () {
            ref.read(chatControllerProvider.notifier).clearHistory();
          },
          tooltip: "Clear chat",
        ),
      ],
    );
  }

  Widget _buildPersonaSelector(ChatState chatState, ThemeData theme) {
    return Container(
      color: theme.colorScheme.surface.withValues(alpha: 0.8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ScholarPersona.values.map((p) {
            final isSelected = chatState.activePersona == p;
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () {
                  if (p == ScholarPersona.custom) {
                    setState(() => _showCustomPromptField = !_showCustomPromptField);
                  } else {
                    setState(() => _showCustomPromptField = false);
                    ref.read(chatControllerProvider.notifier).setPersona(p);
                  }
                },
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.15),
                          width: 1.5,
                        ),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ] : null,
                      ),
                      child: Icon(
                        _getPersonaIcon(p), 
                        size: 20, 
                        color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface.withValues(alpha: 0.5)
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _getPersonaShortName(p),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCustomPromptArea(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surface.withValues(alpha: 0.8),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _customPromptController,
              maxLines: 2,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: "Describe your persona... (e.g. a sarcastic Beijing taxi driver)",
                hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton.filled(
            onPressed: () {
              if (_customPromptController.text.isNotEmpty) {
                ref.read(chatControllerProvider.notifier).setPersona(
                  ScholarPersona.custom,
                  customPrompt: _customPromptController.text,
                );
                setState(() => _showCustomPromptField = false);
              }
            },
            icon: Icon(Icons.send_rounded, color: theme.colorScheme.onPrimary, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ScholarPersona persona, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getPersonaIcon(persona), size: 80, color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          const SizedBox(height: 24),
          Text(
            _getPersonaName(persona),
            style: theme.textTheme.headlineMedium?.copyWith(letterSpacing: 1.5),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              _getPersonaGreeting(persona),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                height: 1.8,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            height: 1,
            width: 100,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(4),
            ),
            border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 3; i++)
                _BouncingDot(delay: Duration(milliseconds: i * 150), color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(ChatState chatState, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
              ),
              child: TextField(
                controller: _textController,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: "Speak with the Scholar...",
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                onSubmitted: (val) {
                  if (val.trim().isNotEmpty) {
                    ref.read(chatControllerProvider.notifier).sendMessage(val);
                    _textController.clear();
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: chatState.isLoading ? null : () {
              if (_textController.text.trim().isNotEmpty) {
                ref.read(chatControllerProvider.notifier).sendMessage(_textController.text);
                _textController.clear();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chatState.isLoading ? theme.colorScheme.onSurface.withValues(alpha: 0.1) : theme.colorScheme.primary,
                boxShadow: chatState.isLoading ? null : [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Icon(
                Icons.send_rounded,
                color: chatState.isLoading ? theme.colorScheme.onSurface.withValues(alpha: 0.4) : theme.colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers ---
  String _getPersonaName(ScholarPersona persona) {
    switch (persona) {
      case ScholarPersona.masterLin: return "Master Lin";
      case ScholarPersona.xiaoMei: return "Xiao Mei";
      case ScholarPersona.poet: return "The Poet";
      case ScholarPersona.gamer: return "A-Qiang";
      case ScholarPersona.shanghaiWoman: return "Vivian";
      case ScholarPersona.custom: return "Custom";
    }
  }

  String _getPersonaShortName(ScholarPersona persona) {
    switch (persona) {
      case ScholarPersona.masterLin: return "Formal";
      case ScholarPersona.xiaoMei: return "Casual";
      case ScholarPersona.poet: return "Poetic";
      case ScholarPersona.gamer: return "Gamer";
      case ScholarPersona.shanghaiWoman: return "Trendy";
      case ScholarPersona.custom: return "Custom ✨";
    }
  }

  String _getPersonaGreeting(ScholarPersona persona) {
    switch (persona) {
      case ScholarPersona.masterLin: return "Greetings, student. The ink is ready. What character or phrase shall we examine today?";
      case ScholarPersona.xiaoMei: return "嘿！来啦？我刚点了杯茶，咱们聊点啥？";
      case ScholarPersona.poet: return "The bamboo sways, and the scholar awaits your words like morning rain...";
      case ScholarPersona.gamer: return "哟！上线了啊兄弟？今天学啥？冲！";
      case ScholarPersona.shanghaiWoman: return "嗨！练中文呀？来来来，我帮你！";
      case ScholarPersona.custom: return "Your custom persona is active. Type to start the conversation.";
    }
  }

  IconData _getPersonaIcon(ScholarPersona persona) {
    switch (persona) {
      case ScholarPersona.masterLin: return Icons.history_edu;
      case ScholarPersona.xiaoMei: return Icons.coffee;
      case ScholarPersona.poet: return Icons.auto_stories;
      case ScholarPersona.gamer: return Icons.videogame_asset;
      case ScholarPersona.shanghaiWoman: return Icons.shopping_bag;
      case ScholarPersona.custom: return Icons.settings_suggest;
    }
  }
}

// --- Chat Bubble ---
class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final ThemeData theme;
  const _ChatBubble({required this.message, required this.theme});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 8,
              bottom: 2,
              left: isUser ? 60 : 0,
              right: isUser ? 0 : 60,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: isUser ? theme.colorScheme.primary : theme.cardTheme.color,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isUser ? 20 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 20),
              ),
              border: isUser ? null : Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: isUser ? theme.colorScheme.primary.withValues(alpha: 0.2) : theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message.content,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isUser ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: isUser ? 0 : 4,
              right: isUser ? 4 : 0,
              bottom: 6,
            ),
            child: Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Bouncing Dot Animation ---
class _BouncingDot extends StatefulWidget {
  final Duration delay;
  final Color? color;
  const _BouncingDot({required this.delay, this.color});
  @override
  State<_BouncingDot> createState() => _BouncingDotState();
}

class _BouncingDotState extends State<_BouncingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: -6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(widget.delay, () {
      if (mounted) _controller.repeat(reverse: true);
    });
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
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _animation.value),
        child: Container(
          width: 6, height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
