import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_selection_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/media/domain/models/saved_article.dart';

import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/media/presentation/screens/simplified_article_reader_screen.dart';
import 'dart:ui';
import 'package:hanzi_master/core/presentation/widgets/ai_progress_bar.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class WebBrowserScreen extends ConsumerStatefulWidget {
  final String initialUrl;
  final bool autoReadingMode;
  final bool isStoryMode;
  final bool showBackButton;

  const WebBrowserScreen({
    super.key,
    this.initialUrl = 'https://www.bbc.com/zhongwen/simp',
    this.autoReadingMode = false,
    this.isStoryMode = false,
    this.showBackButton = true,
  });

  @override
  ConsumerState<WebBrowserScreen> createState() => _WebBrowserScreenState();
}

class _WebBrowserScreenState extends ConsumerState<WebBrowserScreen>
    with SingleTickerProviderStateMixin {
  late final WebViewController _controller;
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = true;
  bool _isZenMode = false;
  bool _isProcessingAi = false;
  String _selectedText = '';
  bool _isArticleSaved = false;

  ArticleInsight? _currentInsight;
  late AnimationController _pulseController;

  // Translation Panel State
  AiSentence? _activeTranslation;
  bool _isTranslationBlurred = true;
  bool _isTranslating = false;

  StreamSubscription? _boundarySub;
  StreamSubscription? _ttsCompleteSub;
  List<String> _ttsSentences = [];
  List<int> _ttsSentenceOffsets = [];
  int _currentSentenceIndex = 0;

  @override
  void initState() {
    super.initState();
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    _initTts();
    _urlController.text = widget.initialUrl;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // Force BBC traditional links to use simplified
            if (request.url.contains('bbc.com/zhongwen/trad')) {
              _controller.loadRequest(
                  Uri.parse(request.url.replaceAll('/trad', '/simp')));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _urlController.text = url;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _urlController.text = url;
            });
            _checkArticleSaved(url);
            _injectHanziInterceptor();
            // Auto-trigger Reading (Zen) Mode by default
            Future.delayed(const Duration(milliseconds: 800), () {
              if (mounted) {
                if (!_isZenMode) {
                  _toggleZenMode();
                } else {
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;
                  _applyZenMode(darkMode: isDark);
                }
              }
            });
            // Auto-trigger simplify if requested
            if (widget.autoReadingMode) {
              Future.delayed(const Duration(milliseconds: 1500), () {
                if (mounted) _runAutoSimplify(3);
              });
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'HanziMasterChannel',
        onMessageReceived: (JavaScriptMessage message) {
          _onHanziTapped(message.message);
        },
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _urlController.dispose();
    _boundarySub?.cancel();
    _ttsCompleteSub?.cancel();
    unawaited(_stopTts());
    super.dispose();
  }

  Future<void> _injectHanziInterceptor() async {
    final repo = ref.read(flashcardRepositoryProvider);
    final cardsResult = await repo.getFlashcards();
    final cards = cardsResult.fold((l) => <Flashcard>[], (r) => r);

    final masteredWords = cards
        .where((c) => c.globalMasteryLevel >= 0.8)
        .map((c) => c.hanzi)
        .toList();
    final learningWords = cards
        .where((c) => c.globalMasteryLevel > 0 && c.globalMasteryLevel < 0.8)
        .map((c) => c.hanzi)
        .toList();

    final String js = '''
      window.masteredWords = ${jsonEncode(masteredWords)};
      window.learningWords = ${jsonEncode(learningWords)};

      window.handleHanziClick = function(event, element, char) {
        // If inside anchor, let the link navigate normally
        let p = element.parentNode;
        while (p) {
          if (p.nodeName === 'A') return;
          p = p.parentNode;
        }
        event.preventDefault();
        event.stopPropagation();
        
        document.querySelectorAll('.hanzi-clickable').forEach(function(el) {
          if (!el.dataset.originalColor) return;
          el.style.backgroundColor = el.dataset.originalColor;
        });
        
        element.dataset.originalColor = element.style.backgroundColor || 'transparent';
        element.style.backgroundColor = '#FFEB3B';
        
        // Get surrounding paragraph text as context
        let contextText = '';
        let pNode = element.parentNode;
        while (pNode) {
          if (pNode.nodeName === 'P' || pNode.nodeName === 'DIV' || pNode.className === 'sentence-text' || pNode.className === 'sentence-wrapper') {
            contextText = pNode.textContent || '';
            break;
          }
          pNode = pNode.parentNode;
        }
        
        const payload = {
          char: char,
          context: contextText
        };
        HanziMasterChannel.postMessage(JSON.stringify(payload));
      };

      window.handleHanziLongPress = function(event, element, char) {
        event.preventDefault();
        let contextText = '';
        let p = element.parentNode;
        while (p) {
          if (p.nodeName === 'P' || p.nodeName === 'DIV') {
            contextText = p.textContent || '';
            break;
          }
          p = p.parentNode;
        }
        HanziMasterChannel.postMessage(JSON.stringify({char: char, context: contextText}));
      };

      window.isWordInList = function(word, list) {
        return list.includes(word);
      };

      window.makeChineseTextClickable = function(node) {
        if (node.nodeType === 3) { 
          const text = node.nodeValue;
          const chineseRegex = /[\\u4e00-\\u9fff]/;
          
          if (chineseRegex.test(text) && node.parentNode.className !== 'hanzi-clickable') {
            const span = document.createElement('span');
            
            let newHtml = '';
            for (let i = 0; i < text.length; i++) {
              const char = text[i];
              if (chineseRegex.test(char)) {
                let colorStyle = '';
                let borderStyle = 'text-decoration: underline; text-decoration-style: dotted; text-decoration-color: rgba(150,150,150,0.5); text-underline-offset: 4px;'; // Unknown by default
                
                if (window.isWordInList(char, window.masteredWords)) {
                  colorStyle = 'color: #555;'; // Faded
                  borderStyle = ''; // No underline
                } else if (window.isWordInList(char, window.learningWords)) {
                  colorStyle = 'color: #D4AF37; font-weight: bold;'; // Gold
                  borderStyle = '';
                }

                newHtml += "<span class='hanzi-clickable' style='cursor: pointer; " + colorStyle + borderStyle + "' onclick='handleHanziClick(event, this, \\"" + char + "\\")' oncontextmenu='handleHanziLongPress(event, this, \\"" + char + "\\")'>" + char + "</span>";
              } else {
                newHtml += char;
              }
            }
            
            span.innerHTML = newHtml;
            node.parentNode.replaceChild(span, node);
          }
        } else if (node.nodeType === 1 && node.nodeName !== 'SCRIPT' && node.nodeName !== 'STYLE' && node.nodeName !== 'A') {
          const children = Array.from(node.childNodes);
          for (let child of children) {
            window.makeChineseTextClickable(child);
          }
        }
      };

      window.wrapSentences = function(node) {
        if (node.nodeType === 3) {
          const text = node.nodeValue;
          if (!/[\\u4e00-\\u9fff]/.test(text)) return;
          
          if (node.parentNode && node.parentNode.className === 'sentence-text') return;

          const parts = text.split(/([ã€‚ï¼ï¼Ÿ.!?]+)/);
          if (parts.length <= 1) return;

          const frag = document.createDocumentFragment();
          for (let i = 0; i < parts.length; i+=2) {
             const sentence = parts[i];
             const punc = parts[i+1] || '';
             const fullSentence = sentence + punc;
             
             if (fullSentence.trim().length > 0) {
                const wrapper = document.createElement('span');
                wrapper.className = 'sentence-wrapper';
                
                const textSpan = document.createElement('span');
                textSpan.className = 'sentence-text';
                textSpan.innerText = fullSentence;
                textSpan.style.cursor = 'pointer';
                
                textSpan.addEventListener('click', function(e) {
                   e.stopPropagation();
                   document.querySelectorAll('.sentence-text').forEach(el => el.style.backgroundColor = 'transparent');
                   textSpan.style.backgroundColor = 'rgba(212, 175, 55, 0.3)'; // Gold highlight
                   
                   HanziMasterChannel.postMessage(JSON.stringify({
                      type: 'play_sentence',
                      text: fullSentence.trim()
                   }));
                });
                
                wrapper.appendChild(textSpan);
                frag.appendChild(wrapper);
             }
          }
          node.parentNode.replaceChild(frag, node);
        } else if (node.nodeType === 1 && node.nodeName !== 'SCRIPT' && node.nodeName !== 'STYLE' && node.className !== 'sentence-wrapper' && node.id !== 'tts-btn') {
          const children = Array.from(node.childNodes);
          for (let child of children) {
            window.wrapSentences(child);
          }
        }
      };

      window.wrapSentences(document.body);
      window.makeChineseTextClickable(document.body);

      // --- Selection Translation Logic ---
      let translateBtn = document.getElementById('hanzi-translate-btn');
      if (!translateBtn) {
        translateBtn = document.createElement('button');
        translateBtn.id = 'hanzi-translate-btn';
        translateBtn.innerText = 'æ–‡ A';
        translateBtn.style.position = 'fixed';
        translateBtn.style.display = 'none';
        translateBtn.style.zIndex = '2147483647'; // Max z-index to be on top of everything
        translateBtn.style.padding = '10px 16px';
        translateBtn.style.background = '#673AB7';
        translateBtn.style.color = '#fff';
        translateBtn.style.border = 'none';
        translateBtn.style.borderRadius = '12px';
        translateBtn.style.cursor = 'pointer';
        translateBtn.style.fontSize = '16px';
        translateBtn.style.fontWeight = 'bold';
        translateBtn.style.boxShadow = '0 8px 16px rgba(0,0,0,0.3)';
        document.body.appendChild(translateBtn);
        
        translateBtn.addEventListener('touchstart', function(e) { e.stopPropagation(); }, {passive: false});
        translateBtn.addEventListener('mousedown', function(e) { e.stopPropagation(); });
        
        translateBtn.addEventListener('click', function(e) {
          e.preventDefault();
          e.stopPropagation();
          const text = window.getSelection().toString().trim();
          if (text.length > 0) {
            HanziMasterChannel.postMessage(JSON.stringify({
              type: 'selection',
              text: text
            }));
          }
          translateBtn.style.display = 'none';
          window.getSelection().removeAllRanges();
        });
      }

      document.addEventListener('selectionchange', function() {
        const selection = window.getSelection();
        const text = selection.toString().trim();
        HanziMasterChannel.postMessage(JSON.stringify({
          type: 'selection_changed',
          text: text.substring(0, 300)
        }));
      });
      // -----------------------------------
    ''';

    _controller.runJavaScript(js);
  }

  void _initTts() {
    final audioService = ref.read(audioServiceProvider);

    _ttsCompleteSub = audioService.onPlayerComplete.listen((_) {
      _playNextSentence();
    });

    _boundarySub = audioService.onWordBoundary.listen((boundary) {
      if (!mounted) return;
      int startOffset = -1;
      int endOffset = -1;
      if (boundary.containsKey('TextOffset')) {
        startOffset = boundary['TextOffset'];
        endOffset = startOffset + (boundary['WordLength'] as int? ?? 1);
      } else if (boundary['text'] != null) {
        startOffset = boundary['text']['TextOffset'] ?? -1;
        endOffset = startOffset + (boundary['text']['Length'] as int? ?? 1);
      }

      if (startOffset != -1) {
        final offset = _ttsSentenceOffsets.isNotEmpty
            ? _ttsSentenceOffsets[_currentSentenceIndex]
            : 0;
        final js = '''
          if (window.highlightTtsOffset) {
            window.highlightTtsOffset(${startOffset + offset}, ${endOffset + offset});
          }
        ''';
        _controller.runJavaScript(js);
      }
    });
  }

  void _playNextSentence() {
    if (_ttsSentences.isEmpty) return;
    _currentSentenceIndex++;
    if (_currentSentenceIndex < _ttsSentences.length) {
      _playCurrentSentence();
    } else {
      _ttsSentences = [];
      _currentSentenceIndex = 0;
      _ttsSentenceOffsets = [];
      if (mounted) {
        _controller.runJavaScript('''
          if (window.removeTtsHighlight) window.removeTtsHighlight();
        ''');
      }
    }
  }

  Future<void> _playTts({String? text}) async {
    if (text != null && text.isNotEmpty) {
      _ttsSentences = [text];
      _ttsSentenceOffsets = [0];
      _currentSentenceIndex = 0;
      if (mounted) {
        _updateTtsButton(true);
      }
      await ref.read(audioServiceProvider).playSentence(text);
      return;
    }

    final jsResult = await _controller.runJavaScriptReturningResult('''
      (function() {
        let bestNode = document.body;
        const articles = document.querySelectorAll('article, .article, .post, .content, main');
        if (articles.length > 0) {
          bestNode = articles[0];
        }
        window.ttsRootNode = bestNode;

        if (!window.highlightTtsOffset) {
          window.removeTtsHighlight = function() {
            const prev = document.querySelectorAll('.tts-active-word');
            prev.forEach(el => {
              const parent = el.parentNode;
              parent.replaceChild(document.createTextNode(el.textContent), el);
              parent.normalize();
            });
          };

          window.highlightTtsOffset = function(startOffset, endOffset) {
            window.removeTtsHighlight();
            if (!window.ttsRootNode) return;

            const walker = document.createTreeWalker(window.ttsRootNode, NodeFilter.SHOW_TEXT, null, false);
            let currentOffset = 0;
            let startNode = null, startNodeOffset = 0;
            let endNode = null, endNodeOffset = 0;

            while (walker.nextNode()) {
              const node = walker.currentNode;
              if (node.parentNode && (node.parentNode.nodeName === 'SCRIPT' || node.parentNode.nodeName === 'STYLE')) {
                continue;
              }
              const len = node.textContent.length;
              if (!startNode && currentOffset + len > startOffset) {
                startNode = node;
                startNodeOffset = startOffset - currentOffset;
              }
              if (startNode && currentOffset + len >= endOffset) {
                endNode = node;
                endNodeOffset = endOffset - currentOffset;
                break;
              }
              currentOffset += len;
            }

            if (startNode && endNode) {
              try {
                const range = document.createRange();
                range.setStart(startNode, startNodeOffset);
                range.setEnd(endNode, endNodeOffset);
                const span = document.createElement('span');
                span.className = 'tts-active-word';
                span.style.backgroundColor = '#FFEB3B';
                span.style.color = '#000';
                span.style.borderRadius = '2px';
                range.surroundContents(span);
                span.scrollIntoView({ behavior: 'smooth', block: 'center' });
              } catch(e) {}
            }
          };
        }

        const sentenceNodes = bestNode.querySelectorAll('.sentence-text');
        const result = [];
        sentenceNodes.forEach(node => {
          result.push(node.innerText.trim());
        });
        return JSON.stringify(result);
      })();
    ''');

    String raw = jsResult.toString();
    try {
      if (raw.startsWith('"') && raw.endsWith('"')) {
        raw = jsonDecode(raw);
      }
    } catch (_) {}

    List<String> sentences = [];
    try {
      sentences = (jsonDecode(raw) as List).cast<String>();
    } catch (_) {
      return;
    }

    final emojiRegex = RegExp(
        r'[\u{1F300}-\u{1F9FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{1F600}-\u{1F64F}\u{1F680}-\u{1F6FF}\u{1F1E6}-\u{1F1FF}]',
        unicode: true);
    sentences = sentences
        .map((s) => s.replaceAll(emojiRegex, '').trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (sentences.isEmpty) return;

    _ttsSentences = sentences;
    _ttsSentenceOffsets = [];
    int offset = 0;
    for (final s in sentences) {
      _ttsSentenceOffsets.add(offset);
      offset += s.length + 1;
    }
    _currentSentenceIndex = 0;

    if (mounted) {
      _updateTtsButton(true);
    }
    await ref.read(audioServiceProvider).playSentence(sentences[0]);
  }

  void _updateTtsButton(bool isPlaying) {
    if (isPlaying) {
      _controller.runJavaScript('''
        const btn = document.getElementById('tts-btn');
        if (btn) {
          btn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><rect x="6" y="4" width="4" height="16"/><rect x="14" y="4" width="4" height="16"/></svg> Stop`;
          btn.style.background = '#1A1A1B';
          btn.style.opacity = '0.75';
        }
      ''');
    } else {
      _controller.runJavaScript('''
        const btn = document.getElementById('tts-btn');
        if (btn) {
          btn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/><path d="M15.54 8.46a5 5 0 0 1 0 7.07"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/></svg> Listen`;
          btn.style.opacity = '1';
        }
      ''');
    }
  }

  Future<void> _playCurrentSentence() async {
    if (!mounted || _currentSentenceIndex >= _ttsSentences.length) return;
    final sentence = _ttsSentences[_currentSentenceIndex].trim();
    if (sentence.isEmpty) {
      _playNextSentence();
      return;
    }

    // Pre-fetch the next sentence to warm the cache while current plays
    final nextIdx = _currentSentenceIndex + 1;
    if (nextIdx < _ttsSentences.length) {
      final nextSentence = _ttsSentences[nextIdx].trim();
      if (nextSentence.isNotEmpty) {
        // Fire-and-forget: start downloading the next sentence in the background
        ref
            .read(audioServiceProvider)
            .playSentence(nextSentence)
            .catchError((_) => false);
      }
    }

    await ref.read(audioServiceProvider).playSentence(sentence);
  }

  Future<void> _stopTts() async {
    _ttsSentences = [];
    _currentSentenceIndex = 0;
    _ttsSentenceOffsets = [];
    await ref.read(audioServiceProvider).stop();
    _controller.runJavaScript('''
      const btn = document.getElementById('tts-btn');
      if (btn) {
        btn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/><path d="M15.54 8.46a5 5 0 0 1 0 7.07"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/></svg> Listen`;
        btn.style.opacity = '1';
      }
    ''');
  }

  void _showAiToolsMenu(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardBg = isDark ? const Color(0xFF2A2A2B) : Colors.white;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    showModalBottomSheet(
        context: context,
        backgroundColor: bgColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (ctx) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.black12,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "AI Reading Tools",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      letterSpacing: -0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enhance your reading with AI-powered tools",
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Extract to Deck card
                  _AiToolTile(
                    icon: Icons.playlist_add,
                    iconColor: const Color(0xFF4A90D9),
                    iconBgColor:
                        const Color(0xFF4A90D9).withValues(alpha: 0.12),
                    title: 'Extract to Deck',
                    subtitle:
                        'Extract all unknown words to a new flashcard deck',
                    isDark: isDark,
                    cardBg: cardBg,
                    borderColor: borderColor,
                    textColor: textColor,
                    onTap: () {
                      HapticsManager.medium();
                      Navigator.pop(ctx);
                      _runAddAllUnknowns();
                    },
                  ),
                  const SizedBox(height: 12),
                  // Auto-Simplify card
                  _AiToolTile(
                    icon: Icons.auto_fix_high,
                    iconColor: const Color(0xFFFFB300),
                    iconBgColor:
                        const Color(0xFFFFB300).withValues(alpha: 0.12),
                    title: 'Auto-Simplify',
                    subtitle: 'Rewrite this article to match your HSK level',
                    isDark: isDark,
                    cardBg: cardBg,
                    borderColor: borderColor,
                    textColor: textColor,
                    onTap: () {
                      HapticsManager.medium();
                      Navigator.pop(ctx);
                      _showAutoSimplifyLevelPicker(
                          context, isDark, bgColor, textColor);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showAutoSimplifyLevelPicker(
      BuildContext context, bool isDark, Color bgColor, Color textColor) {
    const amberColor = Color(0xFFFFB300);
    final amberLight = amberColor.withValues(alpha: 0.12);
    final amberBorder = amberColor.withValues(alpha: 0.30);

    showModalBottomSheet(
        context: context,
        backgroundColor: bgColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (ctx) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.black12,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: amberLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.auto_fix_high,
                            color: amberColor, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select HSK Level",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Choose the target difficulty for simplification",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white54 : Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: List.generate(6, (index) {
                      final level = index + 1;
                      final descriptions = [
                        'Beginner',
                        'Elementary',
                        'Intermediate',
                        'Upper-Intermediate',
                        'Advanced',
                        'Master',
                      ];
                      return GestureDetector(
                        onTap: () {
                          HapticsManager.medium();
                          Navigator.pop(ctx);
                          _runAutoSimplify(level);
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 60) / 3,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 8),
                          decoration: BoxDecoration(
                            color: amberLight,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: amberBorder,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'HSK $level',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: amberColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                descriptions[index],
                                style: TextStyle(
                                  fontSize: 11,
                                  color:
                                      isDark ? Colors.white54 : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _toggleZenMode() {
    setState(() {
      _isZenMode = !_isZenMode;
    });

    if (_isZenMode) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      _applyZenMode(darkMode: isDark);
    } else {
      _removeZenMode();
    }
  }

  void _applyZenMode({bool darkMode = false}) {
    final isStoryMode = widget.isStoryMode;

    // Theme-aware colors
    final bgColor = darkMode ? '#1A1A1B' : '#FDFCF0';
    final textColor = darkMode ? '#DADADA' : '#1A1A1B';
    final skeletonBorderColor = darkMode ? '#DADADA' : '#1A1A1B';
    final skeletonBgColor =
        darkMode ? 'rgba(218,218,218,0.1)' : 'rgba(26,26,27,0.1)';
    final aiLoadingTextColor = darkMode ? '#DADADA' : '#1A1A1B';

    final colorCss = darkMode ? '#DADADA' : '#1A1A1B';
    final darkGlobalCss = '''
      ${darkMode ? 'html { color-scheme: dark; }' : ''}
      body, div, p, h1, h2, h3, h4, h5, h6, span:not(.hanzi-clickable), a, li, td, th, article, main, section, aside, nav, header, footer {
        color: $colorCss !important;
      }
      ${darkMode ? 'body, div, article, main, section, aside, nav, header, footer, table, tbody, tr, td, th, ul, ol, li, iframe { background-color: $bgColor !important; }' : ''}
      ${darkMode ? 'img, video, embed, object { opacity: 0.85; }' : ''}
    ''';

    final js = '''
      if (!window.zenModeBackup) {
        window.zenModeBackup = document.body.innerHTML;
      }
      
      if (!document.getElementById('hanzi-dark-mode-style')) {
        const style = document.createElement('style');
        style.id = 'hanzi-dark-mode-style';
        style.textContent = `${darkGlobalCss.replaceAll('\n', ' ')}`;
        document.head.appendChild(style);
      }
      
      let bestNode = document.body;
      const articles = document.querySelectorAll('article, .article, .post, .content, main');
      if (articles.length > 0) {
        bestNode = articles[0];
      }
      
      // Remove common footers and related items that come after the story
      const elementsToRemove = bestNode.querySelectorAll('.sharedaddy, #jp-post-flair, .entry-meta, .wpcnt, .author-info, #comments, .comments, .post-footer, footer, .related-posts, .share-buttons');
      elementsToRemove.forEach(el => el.remove());
      
      if ($isStoryMode) {
        // Aggressively cut off everything after the last paragraph
        const paragraphs = Array.from(bestNode.querySelectorAll('p'));
        if (paragraphs.length > 0) {
           const lastP = paragraphs[paragraphs.length - 1];
           let next = lastP.nextSibling;
           while(next) {
             let toRemove = next;
             next = next.nextSibling;
             if (toRemove.parentNode) {
               toRemove.parentNode.removeChild(toRemove);
             }
           }
        }
      }
      
      // Add skeleton loader at the top
      const skeletonHtml = `
        <div id="ai-insight-banner" style="margin-bottom: 30px; font-family: sans-serif; opacity: 0.7;">
          <div style="display: flex; align-items: center; margin-bottom: 15px;">
             <div style="width: 20px; height: 20px; border: 2px solid $skeletonBorderColor; border-top-color: transparent; border-radius: 50%; animation: spin 1s linear infinite;"></div>
             <span style="margin-left: 12px; font-size: 14px; font-weight: bold; color: $aiLoadingTextColor;">AI is reading...</span>
          </div>
          <div style="height: 12px; background-color: $skeletonBgColor; border-radius: 4px; margin-bottom: 8px;"></div>
          <div style="height: 12px; background-color: $skeletonBgColor; border-radius: 4px; width: 70%;"></div>
          <style>@keyframes spin { 100% { transform: rotate(360deg); } }</style>
        </div>
      `;
      
      document.body.innerHTML = '<div style="max-width: 800px; margin: 0 auto; padding: 20px; font-family: serif; font-size: 22px; line-height: 1.8; background-color: $bgColor; color: $textColor;">' + skeletonHtml + bestNode.innerHTML + '</div>';
      
      document.body.style.overflow = 'auto';
      document.documentElement.style.overflow = 'auto';
      document.body.style.position = 'static';
      document.documentElement.style.position = 'static';
      document.body.style.height = 'auto';
      document.documentElement.style.height = 'auto';
      document.body.style.backgroundColor = '$bgColor';
      document.documentElement.style.backgroundColor = '$bgColor';
      
      window.makeChineseTextClickable(document.body);
    ''';
    _controller.runJavaScript(js);

    if (_currentInsight == null) {
      if (mounted && _isZenMode) {
        _runAnalyzeArticle();
      }
    }
  }

  void _removeZenMode() {
    setState(() => _isProcessingAi = false);
    _currentInsight = null;
    const js = '''
      if (window.zenModeBackup) {
        document.body.innerHTML = window.zenModeBackup;
        window.makeChineseTextClickable(document.body);
      }
    ''';
    _controller.runJavaScript(js);
  }

  Future<void> _runAnalyzeArticle() async {
    setState(() => _isProcessingAi = true);

    try {
      // Extract only what Gemini needs to save platform channel overhead
      final text = await _controller.runJavaScriptReturningResult(
          'document.body.innerText.substring(0, 3000)');

      // Use synchronous cached provider instead of hitting the database
      final allCards = ref.read(flashcardControllerProvider).value ?? [];
      final knownWords = allCards.map((c) => c.hanzi).toList();

      if (!mounted) return;
      final gemini = ref.read(geminiServiceProvider);
      final langCode = Localizations.localeOf(context).languageCode;
      final insight = await gemini.generateArticleInsight(
          text.toString(), knownWords, langCode);

      if (mounted && _isZenMode) {
        setState(() {
          _currentInsight = insight;
        });

        if (_isZenMode) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final toggleBtnColor =
              isDark ? 'rgba(218,218,218,0.5)' : 'rgba(26,26,27,0.5)';
          final summaryTextColor =
              isDark ? 'rgba(218,218,218,0.75)' : 'rgba(26,26,27,0.75)';
          final summaryBorderColor =
              isDark ? 'rgba(218,218,218,0.15)' : 'rgba(26,26,27,0.15)';
          final js = '''
            const banner = document.getElementById('ai-insight-banner');
            if (banner) {
              const safeSummary = `${insight.summary.replaceAll('`', '\\`').replaceAll('\n', '<br>')} `;
              banner.innerHTML = `
                <div style="display: flex; align-items: center; gap: 8px; flex-wrap: wrap; margin-bottom: 16px;">
                   <div style="background: rgba(255, 193, 7, 0.15); border: 1px solid rgba(255, 193, 7, 0.4); color: #b38600; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; letter-spacing: 0.5px; font-family: sans-serif;">HSK ${insight.hskLevel}</div>
                   <div style="background: rgba(76, 175, 80, 0.12); border: 1px solid rgba(76, 175, 80, 0.35); color: #2e7d32; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; letter-spacing: 0.5px; font-family: sans-serif;">Readability ${insight.score}%</div>
                </div>
                <div>
                   <button id="summary-toggle-btn" style="display: inline-flex; align-items: center; gap: 5px; background: none; border: none; padding: 0; color: $toggleBtnColor; cursor: pointer; font-size: 13px; font-family: sans-serif; letter-spacing: 0.2px;">
                     <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" id="toggle-chevron"><polyline points="6 9 12 15 18 9"/></svg>
                     AI Summary
                   </button>
                   <div id="summary-text" style="display: none; margin-top: 12px; font-size: 15px; color: $summaryTextColor; line-height: 1.6; font-family: sans-serif; border-left: 2px solid $summaryBorderColor; padding-left: 12px;">
                     \${safeSummary}
                   </div>
                </div>
              `;
              banner.style.opacity = '1';
              
              document.getElementById('summary-toggle-btn').addEventListener('click', function() {
                const textDiv = document.getElementById('summary-text');
                const chevron = document.getElementById('toggle-chevron');
                if (textDiv.style.display === 'none') {
                  textDiv.style.display = 'block';
                  chevron.style.transform = 'rotate(180deg)';
                } else {
                  textDiv.style.display = 'none';
                  chevron.style.transform = 'rotate(0deg)';
                }
              });
            }
          ''';
          _controller.runJavaScript(js);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.analysis_failed(e.toString()))));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingAi = false);
      }
    }
  }

  Future<void> _runAddAllUnknowns() async {
    setState(() => _isProcessingAi = true);

    try {
      final text = await _controller
          .runJavaScriptReturningResult('document.body.innerText');
      final pageTitleRaw =
          await _controller.runJavaScriptReturningResult('document.title');
      final pageTitle = pageTitleRaw.toString().replaceAll('"', '');

      final repo = ref.read(flashcardRepositoryProvider);
      final cardsResult = await repo.getFlashcards();
      final knownWords = cardsResult.fold(
        (l) => <String>[],
        (r) => r.map((c) => c.hanzi).toList(),
      );

      if (!mounted) return;
      final gemini = ref.read(geminiServiceProvider);
      final langCode = Localizations.localeOf(context).languageCode;
      final newWords = await gemini.extractAllUnknownWords(
          text.toString(), knownWords, langCode);
      final deckName =
          pageTitle.isNotEmpty ? 'Article: $pageTitle' : 'Web Extraction';

      if (newWords.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.noNewWordsFound)));
        }
        return;
      }

      if (!mounted) return;
      final selectedWords = await showModalBottomSheet<List<AiWord>>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (context) =>
            ExtractedWordsReviewSheet(deckName: deckName, words: newWords),
      );

      if (selectedWords == null || selectedWords.isEmpty) {
        return;
      }

      final List<Flashcard> flashcards = selectedWords
          .map((w) => Flashcard(
                id: const Uuid().v4(),
                deckId: '', // Will be assigned by DeckSelectionSheet
                hanzi: w.hanzi,
                pinyin: w.pinyin,
                definition: w.meaning,
                hskLevel: 0,
                strokePaths: const [],
                medianPaths: const [],
                isFlipped: false,
                modeStats: const {},
                inkPoints: 0,
              ))
          .toList();

      if (mounted) {
        setState(() => _isProcessingAi = false);
        DeckSelectionSheet.show(
          context,
          cards: flashcards,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.extraction_failed(e.toString()))));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingAi = false);
      }
    }
  }

  Future<void> _runAutoSimplify(int level) async {
    setState(() => _isProcessingAi = true);

    try {
      final text = await _controller
          .runJavaScriptReturningResult('document.body.innerText');
      final gemini = ref.read(geminiServiceProvider);
      final simplifiedStory =
          await gemini.simplifyTextToHsk(text.toString(), level);

      if (!mounted) return;

      Navigator.push(
        context,
        SwipeBackPageRoute(
          builder: (_) => SimplifiedArticleReaderScreen(story: simplifiedStory),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.simplify_failed(e.toString()))));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingAi = false);
      }
    }
  }

  void _onHanziTapped(String message) {
    try {
      final data = jsonDecode(message);
      if (data['type'] == 'selection') {
        final text = data['text'] as String;
        _startTranslation(text);
        return;
      }
      if (data['type'] == 'selection_changed') {
        final text = data['text'] as String;
        if (_selectedText != text && mounted) {
          setState(() => _selectedText = text);
        }
        return;
      }
      // [TTS DISABLED] tts_toggle handler removed - restore when TTS engine is ready
      if (data['type'] == 'play_sentence') {
        final text = data['text'] as String;
        _playTts(text: text);
        return;
      }
      final char = data['char'] as String;
      final contextText = data['context'] as String;

      final dummyWord = AiWord(hanzi: char, pinyin: '', meaning: '');
      final dummySentence =
          AiSentence(chinese: contextText, english: '', words: []);
      showQuickLook(context, dummyWord.hanzi,
          contextText: dummySentence.chinese);
    } catch (_) {
      // Fallback if not JSON
      showQuickLook(context, message);
    }
  }

  Future<void> _checkArticleSaved(String url) async {
    try {
      if (widget.isStoryMode) {
        final prefs = await SharedPreferences.getInstance();
        final savedUrls = prefs.getStringList('bookmarked_story_urls') ?? [];
        if (mounted) {
          setState(() => _isArticleSaved = savedUrls.contains(url));
        }
      } else {
        final box = Hive.box<SavedArticle>('saved_articles');
        final isSaved = box.values.any((a) => a.url == url);
        if (mounted) {
          setState(() => _isArticleSaved = isSaved);
        }
      }
    } catch (_) {
      // Silently ignore â€” if we can't check, just assume not saved
    }
  }

  Future<void> _startTranslation(String sentence) async {
    setState(() {
      _isTranslating = true;
      _activeTranslation = null;
      _isTranslationBlurred = true;
    });

    try {
      // Remove any pinyin/latin characters that might have been copied from ruby tags
      final cleanSentence = sentence
          .replaceAll(
              RegExp(
                  r'[a-zA-ZÄÃ¡ÇŽÃ Ä“Ã©Ä›Ã¨Ä«Ã­ÇÃ¬ÅÃ³Ç’Ã²Å«ÃºÇ”Ã¹Ç–Ç˜ÇšÇœÃ¼]+'),
              '')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
      final aiSentence = await ref
          .read(geminiServiceProvider)
          .generateSentenceLesson(cleanSentence);
      if (mounted) {
        setState(() {
          _activeTranslation = aiSentence;
          _isTranslating = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTranslating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.translation_failed(e.toString()))));
      }
    }
  }

  Widget _buildTranslationPanel() {
    if (!_isTranslating && _activeTranslation == null) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBgColor = isDark ? const Color(0xFF2A2A2B) : Colors.white;
    final cardBorderColor = isDark ? Colors.white12 : Colors.black12;
    final englishTextColor = isDark ? Colors.white70 : Colors.black87;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFDFCF0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isTranslating
              ? SizedBox(
                  height: 150,
                  child: Center(
                      child: AiProgressBar(
                          label:
                              AppLocalizations.of(context)!.translatingText)),
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.45,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                _activeTranslation!.chinese,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(_isTranslationBlurred
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.grey[700],
                                  onPressed: () {
                                    setState(() {
                                      _isTranslationBlurred =
                                          !_isTranslationBlurred;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.grey[700],
                                  onPressed: () {
                                    setState(() {
                                      _activeTranslation = null;
                                      _isTranslating = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: _isTranslationBlurred ? 5.0 : 0.0,
                            sigmaY: _isTranslationBlurred ? 5.0 : 0.0,
                          ),
                          child: Text(
                            _activeTranslation!.english,
                            style: TextStyle(
                                fontSize: 16, color: englishTextColor),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _activeTranslation!.words.length,
                            itemBuilder: (context, index) {
                              final w = _activeTranslation!.words[index];
                              return Container(
                                width: 140,
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: cardBgColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: cardBorderColor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => showQuickLook(
                                                context, w.hanzi,
                                                contextText: _activeTranslation!
                                                    .chinese),
                                            child: Text(
                                              w.hanzi,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: isDark
                                                      ? Colors.white
                                                      : Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => showQuickLook(
                                              context, w.hanzi,
                                              contextText:
                                                  _activeTranslation!.chinese),
                                          child: const Icon(
                                              Icons.add_circle_outline,
                                              size: 20,
                                              color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                    ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                        sigmaX:
                                            _isTranslationBlurred ? 4.0 : 0.0,
                                        sigmaY:
                                            _isTranslationBlurred ? 4.0 : 0.0,
                                      ),
                                      child: TranslatedDefinition(
                                          definition: w.meaning,
                                          originalStyle: TextStyle(
                                              fontSize: 12,
                                              color: isDark
                                                  ? Colors.white54
                                                  : Colors.black54),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.auto_awesome),
                            label: Text(AppLocalizations.of(context)!
                                .extractAndSimplify),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.blueAccent.withValues(alpha: 0.1),
                              foregroundColor: Colors.blueAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () async {
                              final text = _activeTranslation!.chinese;

                              // Show HSK level picker
                              final selectedLevel =
                                  await showModalBottomSheet<int>(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                builder: (context) {
                                  final isDark = Theme.of(context).brightness ==
                                      Brightness.dark;
                                  return SafeArea(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xFF1A1A1B)
                                              : const Color(0xFFFDFCF0),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24, horizontal: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            // Drag handle
                                            Center(
                                              child: Container(
                                                width: 36,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: isDark
                                                      ? Colors.white24
                                                      : Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFFB300)
                                                            .withValues(
                                                                alpha: 0.12),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: const Icon(
                                                      Icons.auto_fix_high,
                                                      color: Color(0xFFFFB300),
                                                      size: 22),
                                                ),
                                                const SizedBox(width: 12),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Select Target HSK Level',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: isDark
                                                            ? Colors.white
                                                            : Colors.black87,
                                                        letterSpacing: -0.3,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      'Choose difficulty for simplification',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: isDark
                                                            ? Colors.white54
                                                            : Colors.black38,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                            Wrap(
                                              spacing: 10,
                                              runSpacing: 10,
                                              alignment: WrapAlignment.center,
                                              children:
                                                  List.generate(6, (index) {
                                                final level = index + 1;
                                                final descriptions = [
                                                  'Beginner',
                                                  'Elementary',
                                                  'Intermediate',
                                                  'Upper-Intermediate',
                                                  'Advanced',
                                                  'Master',
                                                ];
                                                return GestureDetector(
                                                  onTap: () => Navigator.pop(
                                                      context, level),
                                                  child: Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            3,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 14,
                                                        horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFFFFB300)
                                                          .withValues(
                                                              alpha: 0.12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      border: Border.all(
                                                        color: const Color(
                                                                0xFFFFB300)
                                                            .withValues(
                                                                alpha: 0.30),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'HSK $level',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFFFFB300),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Text(
                                                          descriptions[index],
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: isDark
                                                                ? Colors.white54
                                                                : Colors
                                                                    .black45,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              if (selectedLevel == null) {
                                return; // User cancelled
                              }

                              setState(() {
                                _activeTranslation = null;
                                _isTranslating = false;
                                _isProcessingAi = true;
                              });
                              try {
                                final gemini = ref.read(geminiServiceProvider);
                                final simplifiedStory = await gemini
                                    .simplifyTextToHsk(text, selectedLevel);
                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  SwipeBackPageRoute(
                                    builder: (_) =>
                                        SimplifiedArticleReaderScreen(
                                            story: simplifiedStory),
                                  ),
                                );
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)!
                                                  .simplify_failed(e.toString()))));
                                }
                              } finally {
                                if (mounted) {
                                  setState(() => _isProcessingAi = false);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      body: Column(
        children: [
          _buildOmnibox(context),
          if (_isLoading) const LinearProgressIndicator(minHeight: 2),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isProcessingAi && _isZenMode)
                  Container(
                    color: Colors.white.withValues(alpha: 0.9),
                    child: Center(
                      child: AiProgressBar(
                          label: AppLocalizations.of(context)!.aiIsThinking),
                    ),
                  ),
              ],
            ),
          ),
          _buildTranslationPanel(),
          _buildCommandDock(context),
        ],
      ),
    );
  }

  Widget _buildOmnibox(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Material(
          color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
          elevation: 1,
          shadowColor: Colors.black.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                if (widget.showBackButton)
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: () => Navigator.of(context).maybePop(),
                    tooltip: AppLocalizations.of(context)!.back,
                  ),
                Icon(Icons.language,
                    size: 18, color: isDark ? Colors.white54 : Colors.black54),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: HanziTextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.searchOrEnterUrl,
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                      ),
                      style: theme.textTheme.bodySmall,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (url) {
                        if (!url.startsWith('http')) url = 'https://$url';
                        _controller.loadRequest(Uri.parse(url));
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _urlController.text.isNotEmpty
                        ? Icons.close
                        : Icons.refresh,
                    size: 20,
                  ),
                  onPressed: () {
                    if (_urlController.text.isNotEmpty) {
                      _urlController.clear();
                    } else {
                      _controller.reload();
                    }
                  },
                  tooltip: _urlController.text.isNotEmpty
                      ? AppLocalizations.of(context)!.clear
                      : AppLocalizations.of(context)!.refresh,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommandDock(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SafeArea(
      top: false,
      child: Material(
        color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              _DockIcon(
                  icon: Icons.arrow_back,
                  tooltip: AppLocalizations.of(context)!.back,
                  onTap: () async {
                    if (await _controller.canGoBack()) _controller.goBack();
                  }),
              _DockIcon(
                  icon: Icons.arrow_forward,
                  tooltip: AppLocalizations.of(context)!.forward,
                  onTap: () async {
                    if (await _controller.canGoForward()) {
                      _controller.goForward();
                    }
                  }),
              const SizedBox(width: 12),
              Expanded(
                child: _selectedText.isNotEmpty
                    ? FilledButton.icon(
                        onPressed: () {
                          HapticsManager.light();
                          _startTranslation(_selectedText);
                          _controller.runJavaScript(
                              'window.getSelection().removeAllRanges();');
                          setState(() => _selectedText = '');
                        },
                        icon: const Icon(Icons.translate, size: 18),
                        label: Text(AppLocalizations.of(context)!.translate),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB300),
                          foregroundColor: const Color(0xFF1A1A1B),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: theme.textTheme.labelMedium,
                        ),
                      )
                    : GestureDetector(
                        onTap: _isProcessingAi
                            ? null
                            : () {
                                HapticsManager.selection();
                                _showAiToolsMenu(context);
                              },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOutQuad,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFFFFB300)
                                    .withValues(alpha: 0.15)
                                : const Color(0xFFFFB300)
                                    .withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFFFFB300)
                                      .withValues(alpha: 0.35)
                                  : const Color(0xFFFFB300)
                                      .withValues(alpha: 0.30),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_isProcessingAi)
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFFFB300),
                                  ),
                                )
                              else
                                Icon(
                                  Icons.auto_awesome,
                                  size: 16,
                                  color: isDark
                                      ? const Color(0xFFFFD54F)
                                      : const Color(0xFFB8860B),
                                ),
                              const SizedBox(width: 6),
                              Text(
                                _isProcessingAi ? 'Processingâ€¦' : 'AI Tools',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                  color: isDark
                                      ? const Color(0xFFFFD54F)
                                      : const Color(0xFFB8860B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              _DockIcon(
                icon: _isArticleSaved ? Icons.bookmark : Icons.bookmark_border,
                tooltip: _isArticleSaved
                    ? AppLocalizations.of(context)!.saved
                    : AppLocalizations.of(context)!.save,
                onTap: _isArticleSaved ? null : () => _saveArticle(),
              ),
              _DockIcon(
                icon: _isZenMode ? Icons.wb_sunny : Icons.menu_book,
                tooltip: _isZenMode
                    ? AppLocalizations.of(context)!.exitFocus
                    : AppLocalizations.of(context)!.focus,
                onTap: _toggleZenMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveArticle() async {
    HapticsManager.light();
    final urlRaw =
        await _controller.runJavaScriptReturningResult('window.location.href');
    final url = urlRaw.toString().replaceAll('"', '');
    if (widget.isStoryMode) {
      final prefs = await SharedPreferences.getInstance();
      final savedUrls = prefs.getStringList('bookmarked_story_urls') ?? [];
      if (!savedUrls.contains(url)) {
        savedUrls.add(url);
        await prefs.setStringList('bookmarked_story_urls', savedUrls);
        if (mounted) {
          setState(() => _isArticleSaved = true);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    AppLocalizations.of(context)!.storyBookmarkedInLibrary)));
          }
        }
      }
      return;
    }
    final titleRaw =
        await _controller.runJavaScriptReturningResult('document.title');
    final title = titleRaw.toString().replaceAll('"', '');
    final textRaw = await _controller
        .runJavaScriptReturningResult('document.body.innerText');
    final text = textRaw.toString().replaceAll('"', '');
    final article = SavedArticle(
      title: title,
      url: url,
      extractedText: text,
      timestamp: DateTime.now(),
    );
    final box = Hive.box<SavedArticle>('saved_articles');
    await box.add(article);
    if (mounted) {
      setState(() => _isArticleSaved = true);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(AppLocalizations.of(context)!.articleSavedToMediaHub)));
      }
    }
  }
}

class _AiToolTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final bool isDark;
  final Color cardBg;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;

  const _AiToolTile({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.isDark,
    required this.cardBg,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            // Icon circle
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            // Chevron
            Icon(
              Icons.chevron_right,
              size: 20,
              color: isDark ? Colors.white38 : Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

class _DockIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  const _DockIcon({required this.icon, this.tooltip = '', this.onTap});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 22),
      onPressed: onTap,
      tooltip: tooltip,
      splashRadius: 20,
    );
  }
}

class ExtractedWordsReviewSheet extends ConsumerStatefulWidget {
  final String deckName;
  final List<AiWord> words;

  const ExtractedWordsReviewSheet(
      {super.key, required this.deckName, required this.words});

  @override
  ConsumerState<ExtractedWordsReviewSheet> createState() =>
      _ExtractedWordsReviewSheetState();
}

class _ExtractedWordsReviewSheetState
    extends ConsumerState<ExtractedWordsReviewSheet> {
  late List<bool> _selected;
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _selected = List.generate(widget.words.length, (i) => true);
  }

  Future<void> _createNewDeck() async {
    if (!_selected.any((isSelected) => isSelected)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.noWordsSelected)));
      return;
    }

    final deckName = await _showCreateDeckDialog();
    if (!mounted || deckName == null || deckName.trim().isEmpty) return;

    setState(() => _isCreating = true);
    try {
      final deckCtrl = ref.read(deckControllerProvider.notifier);
      final newDeck = await deckCtrl.createDeck(deckName.trim());
      if (newDeck == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.failedToCreateDeck)));
        }
        return;
      }

      await _addWordsToDeck(newDeck.id, deckName.trim());
    } catch (error) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.failedToSaveExtractedWords(error.toString()) ?? "Failed to save extracted words: $error")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }

  Future<void> _addWordsToDeck(String deckId, String deckName) async {
    final selectedWords = <AiWord>[];
    for (int i = 0; i < widget.words.length; i++) {
      if (_selected[i]) selectedWords.add(widget.words[i]);
    }
    if (selectedWords.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.noWordsSelected)));
      }
      return;
    }

    final cardCtrl = ref.read(flashcardControllerProvider.notifier);
    final existingCards = ref.read(flashcardControllerProvider).value ?? [];
    final existingHanzi = existingCards.map((c) => c.hanzi).toSet();

    int addedCount = 0;
    int updatedCount = 0;
    for (final w in selectedWords) {
      final card = Flashcard(
        id: const Uuid().v4(),
        deckId: deckId,
        hanzi: w.hanzi,
        pinyin: w.pinyin,
        definition: w.meaning,
        hskLevel: 0,
        strokePaths: const [],
        medianPaths: const [],
        isFlipped: false,
        modeStats: const {},
        inkPoints: 0,
      );
      if (existingHanzi.contains(w.hanzi)) {
        updatedCount++;
      } else {
        addedCount++;
        existingHanzi.add(w.hanzi);
      }
      await cardCtrl.addFlashcard(card);
    }

    if (mounted) {
      String message;
      if (updatedCount > 0 && addedCount > 0) {
        message =
            'Added $addedCount new words, updated $updatedCount existing words in $deckName';
      } else if (updatedCount > 0) {
        message = 'Updated $updatedCount existing words in $deckName';
      } else {
        message = 'Added $addedCount words to $deckName';
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green));
      // A null result tells the browser that this flow is complete. Returning
      // the words would incorrectly open DeckSelectionSheet after the new deck
      // and its cards have already been created.
      Navigator.pop(context);
    }
  }

  Future<String?> _showCreateDeckDialog() async {
    return showDialog<String>(
      context: context,
      builder: (context) => _CreateExtractedDeckDialog(
        initialName: widget.deckName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFFDFCF0),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.reviewExtractedDeck,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(widget.deckName,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            "${_selected.where((s) => s).length} of ${widget.words.length} words selected",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white54
                  : Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white12
                      : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2A2A2B)
                    : Colors.white,
              ),
              child: ListView.separated(
                itemCount: widget.words.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final word = widget.words[index];
                  return CheckboxListTile(
                    value: _selected[index],
                    activeColor: Colors.indigo,
                    title: Text(word.hanzi,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    subtitle: Row(
                      children: [
                        Text(
                          '${PinyinUtils.convertNumericToMarks(word.pinyin)} - ',
                          style: const TextStyle(fontSize: 15),
                        ),
                        Expanded(
                          child: TranslatedDefinition(
                            definition: word.meaning,
                            originalStyle: const TextStyle(fontSize: 15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    onChanged: (val) {
                      setState(() => _selected[index] = val ?? false);
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      _isCreating ? null : () => Navigator.pop(context, null),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.indigo),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(AppLocalizations.of(context)!.cancelAction,
                      style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              // AppLocalizations.of(context)!.createNewDeck â€” direct creation
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isCreating ? null : () => _createNewDeck(),
                  child: _isCreating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Text(AppLocalizations.of(context)!.createNewDeck,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              // "Add to Deck" â€” returns selected words to caller
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isCreating
                      ? null
                      : () {
                          final selectedWords = <AiWord>[];
                          for (int i = 0; i < widget.words.length; i++) {
                            if (_selected[i]) {
                              selectedWords.add(widget.words[i]);
                            }
                          }
                          Navigator.pop(context, selectedWords);
                        },
                  child: const Text("Add to Deck",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _CreateExtractedDeckDialog extends StatefulWidget {
  final String initialName;

  const _CreateExtractedDeckDialog({required this.initialName});

  @override
  State<_CreateExtractedDeckDialog> createState() =>
      _CreateExtractedDeckDialogState();
}

class _CreateExtractedDeckDialogState
    extends State<_CreateExtractedDeckDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.newDeck),
      content: HanziTextField(
        controller: _controller,
        decoration:
            InputDecoration(hintText: AppLocalizations.of(context)!.deckName),
        autofocus: true,
        onSubmitted: (value) => Navigator.pop(context, value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelAction),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: Text(AppLocalizations.of(context)!.createAction),
        ),
      ],
    );
  }
}
