import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/features/media/presentation/screens/media_search_screen.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_selection_sheet.dart';
import 'package:hanzi_master/features/media/domain/models/saved_article.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/media/presentation/screens/simplified_article_reader_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:ui';
import 'package:hanzi_master/features/flashcards/presentation/widgets/word_detail_dialog.dart';
import 'package:hanzi_master/core/presentation/widgets/ai_progress_bar.dart';

class WebBrowserScreen extends ConsumerStatefulWidget {
  final String initialUrl;
  final bool autoReadingMode;
  final bool isStoryMode;

  const WebBrowserScreen({
    super.key,
    this.initialUrl = 'https://www.bbc.com/zhongwen/simp',
    this.autoReadingMode = false,
    this.isStoryMode = false,
  });

  @override
  ConsumerState<WebBrowserScreen> createState() => _WebBrowserScreenState();
}

class _WebBrowserScreenState extends ConsumerState<WebBrowserScreen> with SingleTickerProviderStateMixin {
  late final WebViewController _controller;
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = true;
  bool _isZenMode = false;
  bool _isProcessingAi = false;
  String _selectedText = '';
  
  ArticleInsight? _currentInsight;
  bool _isReadingAloud = false;
  final FlutterTts _tts = FlutterTts();
  late AnimationController _pulseController;
  
  // Translation Panel State
  AiSentence? _activeTranslation;
  bool _isTranslationBlurred = true;
  bool _isTranslating = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
    _initTts();
    _urlController.text = widget.initialUrl;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
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
            _injectHanziInterceptor();
            // Auto-trigger Reading (Zen) Mode by default
            Future.delayed(const Duration(milliseconds: 800), () {
              if (mounted && !_isZenMode) {
                _toggleZenMode();
              }
            });
            // Auto-trigger simplify if requested
            if (widget.autoReadingMode) {
              Future.delayed(const Duration(milliseconds: 1500), () {
                if (mounted) _runAutoSimplify();
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
    super.dispose();
  }

  Future<void> _injectHanziInterceptor() async {
    final repo = ref.read(flashcardRepositoryProvider);
    final cardsResult = await repo.getFlashcards();
    final cards = cardsResult.fold((l) => <Flashcard>[], (r) => r);
    
    final masteredWords = cards.where((c) => c.globalMasteryLevel >= 0.8).map((c) => c.hanzi).toList();
    final learningWords = cards.where((c) => c.globalMasteryLevel > 0 && c.globalMasteryLevel < 0.8).map((c) => c.hanzi).toList();

    final String js = '''
      window.masteredWords = ${jsonEncode(masteredWords)};
      window.learningWords = ${jsonEncode(learningWords)};

      window.handleHanziClick = function(event, element, char) {
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
        if (element.parentNode && element.parentNode.parentNode) {
          contextText = element.parentNode.parentNode.innerText || '';
        }
        
        const payload = {
          char: char,
          context: contextText
        };
        HanziMasterChannel.postMessage(JSON.stringify(payload));
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
                let borderStyle = 'border-bottom: 1px dotted #ccc;'; // Unknown by default
                
                if (window.isWordInList(char, window.masteredWords)) {
                  colorStyle = 'color: #555;'; // Faded
                  borderStyle = ''; // No underline
                } else if (window.isWordInList(char, window.learningWords)) {
                  colorStyle = 'color: #D4AF37; font-weight: bold;'; // Gold
                  borderStyle = '';
                }

                newHtml += "<span class='hanzi-clickable' style='cursor: pointer; " + colorStyle + borderStyle + "' onclick='handleHanziClick(event, this, \\"" + char + "\\")'>" + char + "</span>";
              } else {
                newHtml += char;
              }
            }
            
            span.innerHTML = newHtml;
            node.parentNode.replaceChild(span, node);
          }
        } else if (node.nodeType === 1 && node.nodeName !== 'SCRIPT' && node.nodeName !== 'STYLE') {
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

          const parts = text.split(/([。！？.!?]+)/);
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
                
                const playBtn = document.createElement('span');
                playBtn.innerText = ' 🔊';
                playBtn.style.cursor = 'pointer';
                playBtn.style.fontSize = '14px';
                playBtn.style.opacity = '0.4';
                playBtn.style.marginLeft = '4px';
                playBtn.style.marginRight = '8px';
                playBtn.addEventListener('click', function(e) {
                   e.stopPropagation();
                   document.querySelectorAll('.sentence-text').forEach(el => el.style.backgroundColor = 'transparent');
                   textSpan.style.backgroundColor = 'rgba(212, 175, 55, 0.3)'; // Gold highlight
                   
                   HanziMasterChannel.postMessage(JSON.stringify({
                      type: 'play_sentence',
                      text: fullSentence.trim()
                   }));
                });
                
                wrapper.appendChild(textSpan);
                wrapper.appendChild(playBtn);
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
        translateBtn.innerText = '文 A';
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
    _tts.setLanguage("zh-CN");
    _tts.setSpeechRate(0.45);
    _tts.setVolume(1.0);
    _tts.setPitch(1.0);
    
    _tts.setStartHandler(() {
      if (mounted) setState(() => _isReadingAloud = true);
    });
    
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _isReadingAloud = false);
      _controller.runJavaScript('''
        if (window.removeTtsHighlight) window.removeTtsHighlight();
        const btn = document.getElementById('tts-btn');
        if (btn) {
          btn.innerText = '🔊';
          btn.style.boxShadow = '0 2px 5px rgba(0,0,0,0.2)';
        }
      ''');
    });
    
    _tts.setErrorHandler((msg) {
      if (mounted) setState(() => _isReadingAloud = false);
      _controller.runJavaScript('''
        const btn = document.getElementById('tts-btn');
        if (btn) {
          btn.innerText = '🔊';
          btn.style.boxShadow = '0 2px 5px rgba(0,0,0,0.2)';
        }
      ''');
    });

    _tts.setProgressHandler((text, startOffset, endOffset, word) {
      if (!mounted) return;
      // Inject JS to highlight the current word being spoken within the sentence
      final js = '''
        if (window.highlightTtsOffset) {
          window.highlightTtsOffset($startOffset, $endOffset);
        }
      ''';
      _controller.runJavaScript(js);
    });
  }

  Future<void> _playTts({String? text}) async {
    String parsedText = text ?? "";
    if (parsedText.isEmpty) {
      final jsResult = await _controller.runJavaScriptReturningResult('''
        (function() {
          let bestNode = document.body;
          const articles = document.querySelectorAll('article, .article, .post, .content, main');
          if (articles.length > 0) {
            bestNode = articles[0];
          }
          window.ttsRootNode = bestNode;
          
          // Inject TreeWalker highlighter
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
                // Ignore script and style elements
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
          
          // Extract text cleanly by skipping script/style text
          const walker = document.createTreeWalker(bestNode, NodeFilter.SHOW_TEXT, null, false);
          let text = '';
          while (walker.nextNode()) {
            const node = walker.currentNode;
            if (node.parentNode && (node.parentNode.nodeName === 'SCRIPT' || node.parentNode.nodeName === 'STYLE')) {
              continue;
            }
            text += node.textContent;
          }
          return text;
        })();
      ''');
      parsedText = jsResult.toString();
      
      // JSON decode if it's wrapped in quotes by JS bridge
      try {
        if (parsedText.startsWith('"') && parsedText.endsWith('"')) {
          parsedText = jsonDecode(parsedText);
        }
      } catch(_) {}
    }
    
    // Remove emojis
    parsedText = parsedText.replaceAll(RegExp(r'[\u{1F300}-\u{1F9FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}\u{1F600}-\u{1F64F}\u{1F680}-\u{1F6FF}\u{1F1E6}-\u{1F1FF}]', unicode: true), '');
    
    if (parsedText.trim().isNotEmpty) {
      await _tts.speak(parsedText);
      _controller.runJavaScript('''
        const btn = document.getElementById('tts-btn');
        if (btn) {
          btn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><rect x="6" y="4" width="4" height="16"/><rect x="14" y="4" width="4" height="16"/></svg> Stop`;
          btn.style.background = '#1A1A1B';
          btn.style.opacity = '0.75';
        }
      ''');
    }
  }

  Future<void> _stopTts() async {
    await _tts.stop();
    _controller.runJavaScript('''
      const btn = document.getElementById('tts-btn');
      if (btn) {
        btn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/><path d="M15.54 8.46a5 5 0 0 1 0 7.07"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/></svg> Listen`;
        btn.style.opacity = '1';
      }
    ''');
  }

  void _showAiToolsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "AI Reading Tools",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.playlist_add, color: Colors.blue, size: 32),
                  title: const Text("Extract to Deck", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text("Extract all unknown words to a new named Deck"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _runAddAllUnknowns();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.auto_fix_high, color: Colors.amber, size: 32),
                  title: const Text("Auto-Simplify", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text("Rewrite this article to HSK 3 level"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _runAutoSimplify();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _toggleZenMode() {
    setState(() {
      _isZenMode = !_isZenMode;
    });
    
    if (_isZenMode) {
      final js = '''
        if (!window.zenModeBackup) {
          window.zenModeBackup = document.body.innerHTML;
        }
        
        let bestNode = document.body;
        const articles = document.querySelectorAll('article, .article, .post, .content, main');
        if (articles.length > 0) {
          bestNode = articles[0];
        }
        
        // Add skeleton loader at the top
        const skeletonHtml = `
          <div id="ai-insight-banner" style="margin-bottom: 30px; font-family: sans-serif; opacity: 0.7;">
            <div style="display: flex; align-items: center; margin-bottom: 15px;">
               <div style="width: 20px; height: 20px; border: 2px solid #1A1A1B; border-top-color: transparent; border-radius: 50%; animation: spin 1s linear infinite;"></div>
               <span style="margin-left: 12px; font-size: 14px; font-weight: bold;">AI is reading...</span>
            </div>
            <div style="height: 12px; background-color: rgba(26,26,27,0.1); border-radius: 4px; margin-bottom: 8px;"></div>
            <div style="height: 12px; background-color: rgba(26,26,27,0.1); border-radius: 4px; width: 70%;"></div>
            <style>@keyframes spin { 100% { transform: rotate(360deg); } }</style>
          </div>
        `;
        
        document.body.innerHTML = '<div style="max-width: 800px; margin: 0 auto; padding: 20px; font-family: serif; font-size: 22px; line-height: 1.8; background-color: #FDFCF0; color: #1A1A1B;">' + skeletonHtml + bestNode.innerHTML + '</div>';
        
        window.makeChineseTextClickable(document.body);
      ''';
      _controller.runJavaScript(js);
      
      if (_currentInsight == null) {
        // Wait a tiny bit for the JS to finish extracting text before analyzing
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && _isZenMode) {
            _runAnalyzeArticle();
          }
        });
      }
    } else {
      final js = '''
        if (window.zenModeBackup) {
          document.body.innerHTML = window.zenModeBackup;
          window.makeChineseTextClickable(document.body);
        }
      ''';
      _controller.runJavaScript(js);
    }
  }
  Future<void> _runAnalyzeArticle() async {
    setState(() => _isProcessingAi = true);
    
    try {
      final text = await _controller.runJavaScriptReturningResult('document.body.innerText');
      
      final repo = ref.read(flashcardRepositoryProvider);
      final cardsResult = await repo.getFlashcards();
      final knownWords = cardsResult.fold(
        (l) => <String>[],
        (r) => r.map((c) => c.hanzi).toList(),
      );
      
      final gemini = ref.read(geminiServiceProvider);
      final langCode = Localizations.localeOf(context).languageCode;
      final insight = await gemini.generateArticleInsight(text.toString(), knownWords, langCode);
      
      if (mounted) {
        setState(() {
          _currentInsight = insight;
        });
        
        if (_isZenMode) {
          final js = '''
            const banner = document.getElementById('ai-insight-banner');
            if (banner) {
              const safeSummary = `${insight.summary.replaceAll('`', '\\`').replaceAll('\n', '<br>')} `;
              banner.innerHTML = `
                <div style="display: flex; align-items: center; gap: 8px; flex-wrap: wrap; margin-bottom: 16px;">
                   <div style="background: rgba(255, 193, 7, 0.15); border: 1px solid rgba(255, 193, 7, 0.4); color: #b38600; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; letter-spacing: 0.5px; font-family: sans-serif;">HSK ${insight.hskLevel}</div>
                   <div style="background: rgba(76, 175, 80, 0.12); border: 1px solid rgba(76, 175, 80, 0.35); color: #2e7d32; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; letter-spacing: 0.5px; font-family: sans-serif;">Readability ${insight.score}%</div>
                   <div style="flex-grow: 1;"></div>
                   <button id="tts-btn" style="display: inline-flex; align-items: center; gap: 6px; background: #1A1A1B; color: #FDFCF0; border: none; border-radius: 20px; padding: 6px 14px; font-size: 12px; font-weight: 600; cursor: pointer; font-family: sans-serif; letter-spacing: 0.3px; transition: opacity 0.2s;">
                     <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/><path d="M15.54 8.46a5 5 0 0 1 0 7.07"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/></svg>
                     Listen
                   </button>
                </div>
                <div>
                   <button id="summary-toggle-btn" style="display: inline-flex; align-items: center; gap: 5px; background: none; border: none; padding: 0; color: rgba(26,26,27,0.5); cursor: pointer; font-size: 13px; font-family: sans-serif; letter-spacing: 0.2px;">
                     <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" id="toggle-chevron"><polyline points="6 9 12 15 18 9"/></svg>
                     AI Summary
                   </button>
                   <div id="summary-text" style="display: none; margin-top: 12px; font-size: 15px; color: rgba(26,26,27,0.75); line-height: 1.6; font-family: sans-serif; border-left: 2px solid rgba(26,26,27,0.15); padding-left: 12px;">
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
              
              document.getElementById('tts-btn').addEventListener('click', function(e) {
                e.stopPropagation();
                HanziMasterChannel.postMessage(JSON.stringify({type: 'tts_toggle'}));
              });
            }
          ''';
          _controller.runJavaScript(js);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Analysis Failed: $e')));
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
      final text = await _controller.runJavaScriptReturningResult('document.body.innerText');
      final pageTitleRaw = await _controller.runJavaScriptReturningResult('document.title');
      final pageTitle = pageTitleRaw.toString().replaceAll('"', '');

      final repo = ref.read(flashcardRepositoryProvider);
      final cardsResult = await repo.getFlashcards();
      final knownWords = cardsResult.fold(
        (l) => <String>[],
        (r) => r.map((c) => c.hanzi).toList(),
      );
      
      final gemini = ref.read(geminiServiceProvider);
      final langCode = Localizations.localeOf(context).languageCode;
      final newWords = await gemini.extractAllUnknownWords(text.toString(), knownWords, langCode);
      final deckName = pageTitle.isNotEmpty ? 'Article: $pageTitle' : 'Web Extraction';
      
      if (newWords.isEmpty) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No new words found!')));
        return;
      }

      if (!mounted) return;
      final selectedWords = await showModalBottomSheet<List<AiWord>>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (context) => ExtractedWordsReviewSheet(deckName: deckName, words: newWords),
      );

      if (selectedWords == null || selectedWords.isEmpty) {
        return;
      }

      final List<Flashcard> flashcards = selectedWords.map((w) => Flashcard(
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
      )).toList();

      if (mounted) {
        setState(() => _isProcessingAi = false);
        DeckSelectionSheet.show(
          context,
          cards: flashcards,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Extraction Failed: \$e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingAi = false);
      }
    }
  }

  Future<void> _runAutoSimplify() async {
    setState(() => _isProcessingAi = true);
    
    try {
      final text = await _controller.runJavaScriptReturningResult('document.body.innerText');
      final gemini = ref.read(geminiServiceProvider);
      final simplifiedStory = await gemini.simplifyTextToHsk(text.toString(), 3);
      
      if (!mounted) return;
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SimplifiedArticleReaderScreen(story: simplifiedStory),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Simplify Failed: $e')));
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
      if (data['type'] == 'tts_toggle') {
        if (_isReadingAloud) {
          _stopTts();
        } else {
          _playTts();
        }
        return;
      }
      if (data['type'] == 'play_sentence') {
        final text = data['text'] as String;
        _playTts(text: text);
        return;
      }
      final char = data['char'] as String;
      final contextText = data['context'] as String;
      
      final dummyWord = AiWord(hanzi: char, pinyin: '', meaning: '');
      final dummySentence = AiSentence(chinese: contextText, english: '', words: []);
      WordDetailDialog.show(context, dummyWord, dummySentence);
    } catch (_) {
      // Fallback if not JSON
      showQuickLook(context, message);
    }
  }

  Future<void> _startTranslation(String sentence) async {
    setState(() {
      _isTranslating = true;
      _activeTranslation = null;
      _isTranslationBlurred = true;
    });
    
    try {
      final aiSentence = await ref.read(geminiServiceProvider).generateSentenceLesson(sentence);
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Translation Failed: $e")));
      }
    }
  }

  Widget _buildTranslationPanel() {
    if (!_isTranslating && _activeTranslation == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCF0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              ? const SizedBox(
                  height: 150,
                  child: Center(child: AiProgressBar(label: 'Translating text...')),
                )
              : Column(
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
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(_isTranslationBlurred ? Icons.visibility_off : Icons.visibility),
                              color: Colors.grey[700],
                              onPressed: () {
                                setState(() {
                                  _isTranslationBlurred = !_isTranslationBlurred;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              color: Colors.grey[700],
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
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => WordDetailDialog.show(context, w, _activeTranslation!),
                                        child: Text(
                                          w.hanzi,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => WordDetailDialog.show(context, w, _activeTranslation!),
                                      child: const Icon(Icons.add_circle_outline, size: 20, color: Colors.blue),
                                    ),
                                  ],
                                ),
                                ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: _isTranslationBlurred ? 4.0 : 0.0,
                                    sigmaY: _isTranslationBlurred ? 4.0 : 0.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(w.pinyin, style: const TextStyle(fontSize: 12, color: Colors.grey), overflow: TextOverflow.ellipsis),
                                      Text(w.meaning, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 1),
                                    ],
                                  ),
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
                        label: const Text('Extract & Simplify'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.withOpacity(0.1),
                          foregroundColor: Colors.blueAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {
                          final text = _activeTranslation!.chinese;
                          
                          // Show HSK level picker
                          final selectedLevel = await showModalBottomSheet<int>(
                            context: context,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Select Target HSK Level',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ...List.generate(6, (index) {
                                      final level = index + 1;
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.blueAccent.withOpacity(0.1),
                                          child: Text('$level', style: const TextStyle(color: Colors.blueAccent)),
                                        ),
                                        title: Text('HSK $level'),
                                        onTap: () => Navigator.pop(context, level),
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          );

                          if (selectedLevel == null) return; // User cancelled

                          setState(() {
                            _activeTranslation = null;
                            _isTranslating = false;
                            _isProcessingAi = true;
                          });
                          try {
                            final gemini = ref.read(geminiServiceProvider);
                            final simplifiedStory = await gemini.simplifyTextToHsk(text, selectedLevel);
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SimplifiedArticleReaderScreen(story: simplifiedStory),
                              ),
                            );
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Simplify Failed: $e')));
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              hintText: 'Search or enter website name',
              border: InputBorder.none,
              icon: Icon(Icons.search, size: 20),
            ),
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.go,
            onSubmitted: (url) {
              if (!url.startsWith('http')) {
                url = 'https://$url';
              }
              _controller.loadRequest(Uri.parse(url));
            },
          ),
        ),
        backgroundColor: const Color(0xFFFDFCF0),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'Save Article',
            onPressed: () async {
              final urlRaw = await _controller.runJavaScriptReturningResult('window.location.href');
              final url = urlRaw.toString().replaceAll('"', '');

              if (widget.isStoryMode) {
                final prefs = await SharedPreferences.getInstance();
                final savedUrls = prefs.getStringList('bookmarked_story_urls') ?? [];
                if (!savedUrls.contains(url)) {
                  savedUrls.add(url);
                  await prefs.setStringList('bookmarked_story_urls', savedUrls);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Story bookmarked in Library!')));
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Story already bookmarked!')));
                  }
                }
              } else {
                final titleRaw = await _controller.runJavaScriptReturningResult('document.title');
                final title = titleRaw.toString().replaceAll('"', '');
                
                final textRaw = await _controller.runJavaScriptReturningResult('document.body.innerText');
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Article saved to Media Hub!')));
                }
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.menu_book,
              color: _isZenMode ? Colors.indigo : Colors.black87,
            ),
            onPressed: _toggleZenMode,
            tooltip: 'Zen Mode',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
        bottom: _isProcessingAi
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: LinearProgressIndicator(color: Colors.blueAccent),
              )
            : null,
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFDFCF0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (await _controller.canGoBack()) {
                  _controller.goBack();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (await _controller.canGoForward()) {
                  _controller.goForward();
                }
              },
            ),
            // AI Reading Tools Button OR Translate Selection Button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _selectedText.isNotEmpty
                  ? ElevatedButton.icon(
                      icon: const Icon(Icons.translate),
                      label: const Text("Translate Selection", style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                         _startTranslation(_selectedText);
                         _controller.runJavaScript('window.getSelection().removeAllRanges();');
                         setState(() => _selectedText = '');
                      },
                    )
                  : ElevatedButton.icon(
                      icon: _isProcessingAi 
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.auto_awesome),
                      label: const Text("AI Reading Tools", style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _isProcessingAi ? null : () => _showAiToolsMenu(context),
                    ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (_isProcessingAi)
                  Container(
                    color: Colors.white.withOpacity(0.9),
                    child: const Center(
                      child: AiProgressBar(label: 'AI is thinking...'),
                    ),
                  ),
              ],
            ),
          ),
          _buildTranslationPanel(),
        ],
      ),
    );
  }
}

class ExtractedWordsReviewSheet extends StatefulWidget {
  final String deckName;
  final List<AiWord> words;

  const ExtractedWordsReviewSheet({super.key, required this.deckName, required this.words});

  @override
  State<ExtractedWordsReviewSheet> createState() => _ExtractedWordsReviewSheetState();
}

class _ExtractedWordsReviewSheetState extends State<ExtractedWordsReviewSheet> {
  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.generate(widget.words.length, (i) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFFFDFCF0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Review Extracted Deck", style: TextStyle(fontSize: 16, color: Colors.indigo, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(widget.deckName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            "${_selected.where((s) => s).length} of ${widget.words.length} words selected", 
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: ListView.separated(
                itemCount: widget.words.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final word = widget.words[index];
                  return CheckboxListTile(
                    value: _selected[index],
                    activeColor: Colors.indigo,
                    title: Text(word.hanzi, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    subtitle: Text("${word.pinyin} - ${word.meaning}", style: const TextStyle(fontSize: 15)),
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
                  onPressed: () => Navigator.pop(context, null),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.indigo),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Cancel", style: TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    final selectedWords = <AiWord>[];
                    for (int i = 0; i < widget.words.length; i++) {
                      if (_selected[i]) selectedWords.add(widget.words[i]);
                    }
                    Navigator.pop(context, selectedWords);
                  },
                  child: const Text("Create Deck", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
