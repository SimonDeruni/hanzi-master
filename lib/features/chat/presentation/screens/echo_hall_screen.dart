import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/chat/presentation/providers/chat_controller.dart';
import 'package:hanzi_master/features/chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:intl/intl.dart';

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
      backgroundColor: const Color(0xFF111118), // Deep dark background
      appBar: _buildAppBar(chatState),
      body: Column(
        children: [
          // Horizontal Persona Selector
          _buildPersonaSelector(chatState),
          if (_showCustomPromptField) _buildCustomPromptArea(),
          // Chat Messages
          Expanded(
            child: chatState.messages.isEmpty
                ? _buildEmptyState(chatState.activePersona)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    itemCount: chatState.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatState.messages[index];
                      return _ChatBubble(message: message);
                    },
                  ),
          ),
          // Typing indicator
          if (chatState.isLoading) _buildTypingIndicator(),
          // Input area
          _buildInputArea(chatState),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ChatState chatState) {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A24),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white70, size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getPersonaName(chatState.activePersona),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            _getPersonaTagline(chatState.activePersona),
            style: TextStyle(
              color: Colors.white.withAlpha(128),
              fontSize: 11,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.white54, size: 20),
          onPressed: () {
            ref.read(chatControllerProvider.notifier).clearHistory();
          },
          tooltip: "Clear chat",
        ),
      ],
    );
  }

  Widget _buildPersonaSelector(ChatState chatState) {
    return Container(
      color: const Color(0xFF1A1A24),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ScholarPersona.values.map((p) {
            final isSelected = chatState.activePersona == p;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  if (p == ScholarPersona.custom) {
                    setState(() => _showCustomPromptField = !_showCustomPromptField);
                  } else {
                    setState(() => _showCustomPromptField = false);
                    ref.read(chatControllerProvider.notifier).setPersona(p);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.indigo.shade400 : const Color(0xFF252535),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.indigo.shade300 : Colors.white12,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_getPersonaIcon(p), size: 14, color: isSelected ? Colors.white : Colors.white60),
                      const SizedBox(width: 6),
                      Text(
                        _getPersonaShortName(p),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white60,
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCustomPromptArea() {
    return Container(
      color: const Color(0xFF1A1A24),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _customPromptController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Describe your persona... (e.g. a sarcastic Beijing taxi driver)",
                hintStyle: TextStyle(color: Colors.white.withAlpha(77), fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF252535),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (_customPromptController.text.isNotEmpty) {
                ref.read(chatControllerProvider.notifier).setPersona(
                  ScholarPersona.custom,
                  customPrompt: _customPromptController.text,
                );
                setState(() => _showCustomPromptField = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade400,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ScholarPersona persona) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getPersonaIcon(persona), size: 64, color: Colors.white.withAlpha(51)),
          const SizedBox(height: 16),
          Text(
            _getPersonaName(persona),
            style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              _getPersonaGreeting(persona),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withAlpha(77), fontSize: 14, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF252535),
            borderRadius: BorderRadius.circular(16).copyWith(
              bottomLeft: const Radius.circular(4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 3; i++)
                _BouncingDot(delay: Duration(milliseconds: i * 120)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(ChatState chatState) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      color: const Color(0xFF1A1A24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: "Write in Chinese or English...",
                hintStyle: TextStyle(color: Colors.white.withAlpha(77), fontSize: 14),
                filled: true,
                fillColor: const Color(0xFF252535),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onSubmitted: (val) {
                if (val.trim().isNotEmpty) {
                  ref.read(chatControllerProvider.notifier).sendMessage(val);
                  _textController.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: chatState.isLoading ? null : () {
              if (_textController.text.trim().isNotEmpty) {
                ref.read(chatControllerProvider.notifier).sendMessage(_textController.text);
                _textController.clear();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: chatState.isLoading
                    ? null
                    : LinearGradient(
                        colors: [Colors.indigo.shade600, Colors.indigo.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: chatState.isLoading ? Colors.grey.shade800 : null,
              ),
              child: Icon(
                Icons.send_rounded,
                color: chatState.isLoading ? Colors.white24 : Colors.white,
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

  String _getPersonaTagline(ScholarPersona persona) {
    switch (persona) {
      case ScholarPersona.masterLin: return "Traditional Calligrapher · Formal";
      case ScholarPersona.xiaoMei: return "Teahouse Regular · Casual Chats";
      case ScholarPersona.poet: return "Classical Scholar · Metaphorical";
      case ScholarPersona.gamer: return "Gaming Enthusiast · Slang";
      case ScholarPersona.shanghaiWoman: return "Shanghai Trendsetter · Modern";
      case ScholarPersona.custom: return "Your custom partner";
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
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 4, bottom: 4,
          left: isUser ? 48 : 0,
          right: isUser ? 0 : 48,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isUser
              ? LinearGradient(
                  colors: [Colors.indigo.shade700, Colors.indigo.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isUser ? null : const Color(0xFF252535),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                fontSize: 15,
                color: isUser ? Colors.white : Colors.white.withAlpha(230),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: TextStyle(
                fontSize: 10,
                color: isUser ? Colors.white.withAlpha(153) : Colors.white.withAlpha(77),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Bouncing Dot Animation ---
class _BouncingDot extends StatefulWidget {
  final Duration delay;
  const _BouncingDot({required this.delay});
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
          width: 7, height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withAlpha(153),
          ),
        ),
      ),
    );
  }
}
