import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/chat/presentation/providers/chat_controller.dart';
import 'package:hanzi_master/features/chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:intl/intl.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class EchoHallScreen extends ConsumerStatefulWidget {
  const EchoHallScreen({super.key});

  @override
  ConsumerState<EchoHallScreen> createState() => _EchoHallScreenState();
}

class _EchoHallScreenState extends ConsumerState<EchoHallScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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

  void _showPersonaSelectorSheet(BuildContext context, ChatState chatState, ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.95),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              border: Border(top: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.1))),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(width: 40, height: 4, decoration: BoxDecoration(color: theme.colorScheme.onSurface.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 24),
                Text(l10n.selectPersona, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: ScholarPersona.values.length,
                    itemBuilder: (context, index) {
                      final p = ScholarPersona.values[index];
                      final isSelected = chatState.activePersona == p;
                      
                      if (p == ScholarPersona.custom) {
                        return _buildCustomPersonaTile(p, isSelected, theme);
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InkWell(
                          onTap: () {
                            ref.read(chatControllerProvider.notifier).setPersona(p);
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.05),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(_getPersonaIcon(p), color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface, size: 24),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_getPersonaName(p, l10n), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text(_getPersonaShortName(p), style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Icon(Icons.check_circle, color: theme.colorScheme.primary),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomPersonaTile(ScholarPersona p, bool isSelected, ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, top: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.colorScheme.onSurface.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.1), style: BorderStyle.solid),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getPersonaIcon(p), color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(l10n.customPersona, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: HanziTextField(
                    controller: _customPromptController,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: l10n.customPersonaHint,
                      hintStyle: theme.textTheme.bodySmall,
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton.filled(
                  onPressed: () {
                    if (_customPromptController.text.isNotEmpty) {
                      ref.read(chatControllerProvider.notifier).setPersona(p, customPrompt: _customPromptController.text);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.check),
                  style: IconButton.styleFrom(backgroundColor: theme.colorScheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(chatState, theme, l10n),
      body: CalligraphyBackground(
        child: Stack(
          children: [
            // Chat Messages
            Positioned.fill(
              child: chatState.messages.isEmpty
                  ? _buildEmptyState(chatState.activePersona, theme, l10n)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 120, 16, 120), // Padding for floating input and appbar
                      itemCount: chatState.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatState.messages[index];
                        return _ChatBubble(message: message, theme: theme);
                      },
                    ),
            ),
            
            // Typing indicator floating at the bottom of the list
            if (chatState.isLoading) 
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: _buildTypingIndicator(theme)
              ),
              
            // Floating Input Area
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildInputArea(chatState, theme, l10n),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ChatState chatState, ThemeData theme, AppLocalizations l10n) {
    return AppBar(
      elevation: 0,
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.8),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.transparent),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface, size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      title: InkWell(
        onTap: () => _showPersonaSelectorSheet(context, chatState, theme),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getPersonaIcon(chatState.activePersona), size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                _getPersonaName(chatState.activePersona, l10n),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 20, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.cleaning_services_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.4), size: 22),
          onPressed: () {
            ref.read(chatControllerProvider.notifier).clearHistory();
          },
          tooltip: "Clear chat",
        ),
      ],
    );
  }

  Widget _buildEmptyState(ScholarPersona persona, ThemeData theme, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
                shape: BoxShape.circle,
              ),
              child: Icon(_getPersonaIcon(persona), size: 64, color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
            ),
            const SizedBox(height: 32),
            Text(
              "Speak with ${_getPersonaName(persona, l10n)}",
              style: theme.textTheme.headlineMedium?.copyWith(letterSpacing: 1.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              _getPersonaGreeting(persona),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 60), // Room for floating input
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
            boxShadow: [
               BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 3; i++)
                _BouncingDot(delay: Duration(milliseconds: i * 150), color: theme.colorScheme.primary.withValues(alpha: 0.6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(ChatState chatState, ThemeData theme, AppLocalizations l10n) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 32),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.6),
            border: Border(top: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.05))),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color?.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                      boxShadow: [
                         BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: HanziTextField(
                      controller: _textController,
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      Icons.arrow_upward_rounded,
                      color: chatState.isLoading ? theme.colorScheme.onSurface.withValues(alpha: 0.4) : theme.colorScheme.onPrimary,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helpers ---
  String _getPersonaName(ScholarPersona persona, AppLocalizations l10n) {
    if (persona == ScholarPersona.custom) return _customPromptController.text.isNotEmpty ? "Custom" : "Custom Persona";
    switch (persona) {
      case ScholarPersona.masterLin: return "Master Lin";
      case ScholarPersona.xiaoMei: return "Xiao Mei";
      case ScholarPersona.poet: return "The Poet";
      case ScholarPersona.gamer: return "A-Qiang";
      case ScholarPersona.shanghaiWoman: return "Vivian";
      case ScholarPersona.custom: return "Custom Persona";
    }
  }

  String _getPersonaShortName(ScholarPersona persona) {
    switch (persona) {
      case ScholarPersona.masterLin: return "Formal & wise";
      case ScholarPersona.xiaoMei: return "Casual & friendly";
      case ScholarPersona.poet: return "Poetic & ancient";
      case ScholarPersona.gamer: return "Slang & internet";
      case ScholarPersona.shanghaiWoman: return "Trendy & modern";
      case ScholarPersona.custom: return "Design your own";
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: isUser ? theme.colorScheme.primary : theme.cardTheme.color,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(24),
                topRight: const Radius.circular(24),
                bottomLeft: Radius.circular(isUser ? 24 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 24),
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
              left: isUser ? 0 : 8,
              right: isUser ? 8 : 0,
              bottom: 12,
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
