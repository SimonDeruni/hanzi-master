import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:hanzi_master/features/media/domain/models/saved_article.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/media/presentation/screens/simplified_article_reader_screen.dart';
import 'dart:ui';

class WebBrowserScreen extends ConsumerStatefulWidget {
  final String initialUrl;

  const WebBrowserScreen({
    super.key,
    this.initialUrl = 'https://www.bbc.com/zhongwen/simp',
  });

  @override
  ConsumerState<WebBrowserScreen> createState() => _WebBrowserScreenState();
}

class _WebBrowserScreenState extends ConsumerState<WebBrowserScreen> {
  late final WebViewController _controller;
  late final TextEditingController _urlController;
  bool _isLoading = true;
  bool _isZenMode = false;
  bool _isProcessingAi = false;
  
  // Translation Panel State
  AiSentence? _activeTranslation;
  bool _isTranslationBlurred = true;
  bool _isTranslating = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.initialUrl);
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
        if (text.length > 0 && text.length <= 150) { // Limit length to avoid massive payloads
          const range = selection.getRangeAt(0);
          const rect = range.getBoundingClientRect();
          translateBtn.style.left = Math.max(10, rect.left) + 'px';
          translateBtn.style.top = Math.max(10, rect.bottom + 10) + 'px';
          translateBtn.style.display = 'block';
        } else {
          translateBtn.style.display = 'none';
        }
      });
      // -----------------------------------
    ''';
    
    _controller.runJavaScript(js);
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
                  leading: const Icon(Icons.troubleshoot, color: Colors.purple, size: 32),
                  title: const Text("X-Ray Scanner", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text("Generate pre-flight vocabulary list from this article"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _runXRayScanner();
                  },
                ),
                const Divider(),
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
        
        document.body.innerHTML = '<div style="max-width: 800px; margin: 0 auto; padding: 20px; font-family: serif; font-size: 22px; line-height: 1.8; background-color: #FDFCF0; color: #1A1A1B;">' + bestNode.innerHTML + '</div>';
        
        window.makeChineseTextClickable(document.body);
      ''';
      _controller.runJavaScript(js);
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

  Future<void> _runXRayScanner() async {
    setState(() => _isProcessingAi = true);
    
    try {
      final text = await _controller.runJavaScriptReturningResult('document.body.innerText');
      final repo = ref.read(flashcardRepositoryProvider);
      final cardsResult = await repo.getFlashcards();
      final masteredWords = cardsResult.fold(
        (l) => <String>[],
        (r) => r.where((c) => c.globalMasteryLevel >= 0.8).map((c) => c.hanzi).toList(),
      );
      
      final gemini = ref.read(geminiServiceProvider);
      final preFlightVocab = await gemini.generatePreFlightVocab(text.toString(), masteredWords);
      
      if (!mounted) return;
      
      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFFFDFCF0),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.troubleshoot, color: Colors.purple),
                    SizedBox(width: 8),
                    Text("Pre-Flight Vocabulary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                ...preFlightVocab.map((w) => ListTile(
                  title: Text("${w.hanzi} (${w.pinyin})", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(w.meaning),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      Navigator.pop(context);
                      showQuickLook(context, w.hanzi);
                    },
                  ),
                )).toList(),
              ],
            ),
          );
        }
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('X-Ray Failed: $e')));
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
      final extractedData = await gemini.extractAllUnknownWords(text.toString(), knownWords);
      final newWords = extractedData['words'] as List<AiWord>;
      final deckName = extractedData['deckName'] as String;
      
      if (newWords.isEmpty) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No new words found!')));
        return;
      }

      final deckRepo = ref.read(deckRepositoryProvider);
      final createdDeckResult = await deckRepo.createDeck(deckName, description: 'Extracted automatically from Web Explorer ($pageTitle)');
      final createdDeck = createdDeckResult.fold((l) => null, (r) => r);
      if (createdDeck == null) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to create deck')));
        return;
      }
      
      for (final w in newWords) {
        final card = Flashcard(
          id: const Uuid().v4(),
          deckId: createdDeck.id,
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
        await repo.saveFlashcard(card);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${newWords.length} words to "$deckName"')));
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
      final char = data['char'] as String;
      final contextText = data['context'] as String;
      showQuickLook(context, char, contextText: contextText);
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
                  child: Center(child: CircularProgressIndicator()),
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
                                      child: Text(
                                        w.hanzi,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => showQuickLook(context, w.hanzi),
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
                          setState(() {
                            _activeTranslation = null;
                            _isTranslating = false;
                            _isProcessingAi = true;
                          });
                          try {
                            final gemini = ref.read(geminiServiceProvider);
                            final simplifiedStory = await gemini.simplifyTextToHsk(text, 3);
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
              final titleRaw = await _controller.runJavaScriptReturningResult('document.title');
              final title = titleRaw.toString().replaceAll('"', '');
              
              final urlRaw = await _controller.runJavaScriptReturningResult('window.location.href');
              final url = urlRaw.toString().replaceAll('"', '');
              
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Article saved!')));
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
            // AI Reading Tools Button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton.icon(
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
              ],
            ),
          ),
          _buildTranslationPanel(),
        ],
      ),
    );
  }
}
