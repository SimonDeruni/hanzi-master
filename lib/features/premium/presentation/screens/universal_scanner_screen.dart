import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import '../../../../features/vision/presentation/screens/ar_lens_screen.dart';
import '../../../../core/services/ocr_service.dart';
import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../course/presentation/screens/lesson_screen.dart';
import '../../../course/presentation/widgets/mission_briefing_sheet.dart';
import '../../../course/presentation/providers/lesson_controller.dart';
import '../../../../core/services/gemini_service.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../../flashcards/presentation/widgets/deck_selection_sheet.dart';
import '../../../../shared/widgets/quick_look_sheet.dart';
import '../widgets/interactive_image_overlay.dart';

class UniversalScannerScreen extends ConsumerStatefulWidget {
  final bool returnTextMode;

  const UniversalScannerScreen({super.key, this.returnTextMode = false});

  @override
  ConsumerState<UniversalScannerScreen> createState() => _UniversalScannerScreenState();
}

class _UniversalScannerScreenState extends ConsumerState<UniversalScannerScreen> with WidgetsBindingObserver {
  final OcrService _ocrService = OcrService();
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  
  bool _isScanning = false;
  bool _isLookingUp = false;
  bool _showingResults = false;
  String _rawExtractedText = "";
  String _fullTranslation = "";
  List<AiWord> _matchedCharacters = [];

  bool _showingInteractiveImage = false;
  XFile? _capturedImage;
  RecognizedText? _recognizedText;
  Size? _imageSize;
  FlashMode _flashMode = FlashMode.off;

  double _minZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  double _currentZoomLevel = 1.0;
  double _baseZoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _cameraController = CameraController(
          _cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
        );

        try {
          await _cameraController!.initialize();
          _minZoomLevel = await _cameraController!.getMinZoomLevel();
          _maxZoomLevel = await _cameraController!.getMaxZoomLevel();
          if (mounted) {
            setState(() {
              _isCameraInitialized = true;
            });
          }
        } catch (e) {
          debugPrint("Camera Error: $e");
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera permission required for live scanning')),
        );
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _ocrService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      cameraController.dispose();
      _isCameraInitialized = false;
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseZoomLevel = _currentZoomLevel;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (_cameraController == null || !_isCameraInitialized) return;
    
    double zoom = (_baseZoomLevel * details.scale).clamp(_minZoomLevel, _maxZoomLevel);
    if (zoom != _currentZoomLevel) {
      setState(() => _currentZoomLevel = zoom);
      await _cameraController!.setZoomLevel(zoom);
    }
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized || _isScanning || _isLookingUp) return;
    
    HapticsManager.light();
    setState(() {
      _isScanning = true;
      _showingResults = false;
      _showingInteractiveImage = false;
    });

    try {
      final image = await _cameraController!.takePicture();
      await _processImageDetailed(image);
    } catch (e) {
      debugPrint("Take Photo Error: $e");
      setState(() => _isScanning = false);
    }
  }

  Future<void> _pickFromGallery() async {
    if (_isScanning || _isLookingUp) return;
    
    HapticsManager.light();
    setState(() {
      _isScanning = true;
      _showingResults = false;
      _showingInteractiveImage = false;
    });

    try {
      final result = await _ocrService.scanImageDetailed(fromCamera: false);
      if (result != null) {
        await _processImageDetailed(result.image, preRecognized: result.recognizedText);
      } else {
        setState(() => _isScanning = false);
      }
    } catch (e) {
      debugPrint("Pick Gallery Error: $e");
      setState(() => _isScanning = false);
    }
  }

  Future<void> _processImageDetailed(XFile image, {RecognizedText? preRecognized}) async {
    final recognizedText = preRecognized ?? await _ocrService.processImageFileDetailed(image);
    
    if (recognizedText != null && recognizedText.text.isNotEmpty) {
      // Get image dimensions for rendering bounding boxes correctly
      final decodedImage = await decodeImageFromList(await image.readAsBytes());
      
      setState(() {
        _isScanning = false;
        _capturedImage = image;
        _recognizedText = recognizedText;
        _imageSize = Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
        _showingInteractiveImage = true;
      });
    } else {
      setState(() => _isScanning = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.noChineseCharactersFound)),
        );
      }
    }
  }

  Future<void> _processExtractedText(String text) async {
    HapticsManager.success();
    setState(() {
      _isScanning = false;
      _rawExtractedText = text;
      _isLookingUp = true;
      _showingInteractiveImage = false; // Hide interactive image when going to list
    });

    final gemini = ref.read(geminiServiceProvider);
    
    try {
      final extraction = await gemini.extractVocabularyFromScan(text);
      if (mounted) {
        setState(() {
          _fullTranslation = extraction['fullTranslation'] as String;
          _matchedCharacters = extraction['words'] as List<AiWord>;
          _isLookingUp = false;
          _showingResults = true;
        });
      }
    } catch (e) {
      debugPrint("Gemini Error: $e");
      if (mounted) {
        setState(() {
          _isLookingUp = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('AI Analysis Failed')),
        );
      }
    }
  }

  Future<void> _lookupSingleWord(String word) async {
    HapticsManager.light();
    // Use QuickLookSheet to show details for this word.
    showQuickLook(context, word);
  }

  Future<void> _createDeck() async {
    if (_matchedCharacters.isEmpty) return;
    HapticsManager.light();

    final List<Flashcard> cards = _matchedCharacters.map((info) => Flashcard(
      id: '',
      hanzi: info.hanzi,
      pinyin: info.pinyin,
      definition: info.meaning,
      hskLevel: info.hskLevel,
      strokePaths: const [],
      modeStats: const {},
    )).toList();

    await DeckSelectionSheet.show(
      context,
      cards: cards,
      onAdded: () {
        setState(() {
          _showingResults = false;
          _matchedCharacters = [];
        });
      },
    );
  }

  Future<void> _addSingleCard(AiWord info) async {
    HapticsManager.light();
    
    final card = Flashcard(
      id: '',
      hanzi: info.hanzi,
      pinyin: info.pinyin,
      definition: info.meaning,
      hskLevel: info.hskLevel,
      strokePaths: const [],
      modeStats: const {},
    );

    await DeckSelectionSheet.show(
      context,
      card: card,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.universalScanner, style: const TextStyle(color: Colors.white, shadows: [Shadow(blurRadius: 10, color: Colors.black54)])),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (_isCameraInitialized && !_showingInteractiveImage && !_showingResults)
            IconButton(
              icon: Icon(
                _flashMode == FlashMode.always ? Icons.flash_on :
                _flashMode == FlashMode.auto ? Icons.flash_auto : Icons.flash_off,
                color: Colors.white,
                shadows: const [Shadow(blurRadius: 10, color: Colors.black54)],
              ),
              onPressed: () async {
                HapticsManager.light();
                FlashMode newMode;
                if (_flashMode == FlashMode.off) {
                  newMode = FlashMode.auto;
                } else if (_flashMode == FlashMode.auto) {
                  newMode = FlashMode.always;
                } else {
                  newMode = FlashMode.off;
                }
                
                try {
                  await _cameraController!.setFlashMode(newMode);
                  setState(() {
                    _flashMode = newMode;
                  });
                } catch (e) {
                  debugPrint("Failed to set flash mode: $e");
                }
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          // Camera Preview Background or Interactive Image
          if (_showingInteractiveImage && _capturedImage != null && _recognizedText != null)
            Positioned.fill(
              child: InteractiveImageOverlay(
                image: _capturedImage!,
                recognizedText: _recognizedText!,
                imageSize: _imageSize ?? const Size(1000, 1000),
                onWordTapped: (word) {
                  _lookupSingleWord(word);
                },
              ),
            )
          else if (_isCameraInitialized && _cameraController != null)
            Positioned.fill(
              child: GestureDetector(
                onScaleStart: _handleScaleStart,
                onScaleUpdate: _handleScaleUpdate,
                child: Builder(
                  builder: (context) {
                    final size = MediaQuery.of(context).size;
                    // Handle potential zero or null values safely
                    final previewWidth = _cameraController!.value.previewSize?.width ?? 1.0;
                    final previewHeight = _cameraController!.value.previewSize?.height ?? 1.0;
                    final cameraAspectRatio = previewWidth > 0 && previewHeight > 0 ? previewHeight / previewWidth : 1.0;
                    
                    var scale = size.aspectRatio * cameraAspectRatio;
                    if (scale < 1) scale = 1 / scale;

                    return Transform.scale(
                      scale: scale,
                      child: Center(
                        child: CameraPreview(_cameraController!),
                      ),
                    );
                  },
                ),
              ),
            )
          else
            Container(color: Colors.black),
            
          // Blur overlay during loading or results
          if (_isScanning || _isLookingUp || _showingResults)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ),
            ),
            
          // Main UI Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                
                // Content Area
                Expanded(
                  child: _buildMainContent(theme, l10n),
                ),
                
                // Bottom Control Panel
                if (!_showingResults)
                  _buildBottomControls(theme, l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMainContent(ThemeData theme, AppLocalizations l10n) {
    if (_isScanning || _isLookingUp) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 16),
            Text(
              _isScanning ? l10n.extractingTextAndObjects : l10n.lookingUpCharacters,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      );
    }
    
    if (_showingResults) {
      return Column(
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _showingResults = false;
                        _showingInteractiveImage = true; // Go back to interactive image
                      });
                    }
                  ),
                  Text("Results", style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                  const SizedBox(width: 48), // balance
               ]
            ),
          ),
          Expanded(child: _buildResultsList(theme, l10n)),
        ],
      );
    }

    if (_showingInteractiveImage) {
       return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _showingInteractiveImage = false;
                          _capturedImage = null;
                        });
                      }
                    ),
                    const SizedBox(width: 48), // balance
                 ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (_recognizedText != null) {
                    _processExtractedText(_recognizedText!.text);
                  }
                },
                icon: const Icon(Icons.list),
                label: const Text('View as List'),
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
       );
    }
    
    // Default state: Custom Premium Viewfinder
    return CustomPaint(
      painter: ScannerOverlayPainter(),
      child: const SizedBox.expand(),
    );
  }
  
  Widget _buildBottomControls(ThemeData theme, AppLocalizations l10n) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 32.0, left: 32.0, right: 32.0),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(40),
         child: BackdropFilter(
           filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
           child: Container(
             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
             decoration: BoxDecoration(
               color: Colors.black.withValues(alpha: 0.2),
               border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
               borderRadius: BorderRadius.circular(40),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 // Gallery Button
                 _buildSideButton(
                   icon: Icons.photo_library_outlined,
                   onTap: _pickFromGallery,
                 ),
                 
                 // Premium Shutter Button
                 GestureDetector(
                   onTap: _takePhoto,
                   child: Container(
                     width: 76,
                     height: 76,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 3),
                       color: Colors.transparent,
                     ),
                     child: Center(
                       child: Container(
                         width: 62,
                         height: 62,
                         decoration: const BoxDecoration(
                           shape: BoxShape.circle,
                           color: Colors.white,
                         ),
                       ),
                     ),
                   ),
                 ),
                 
                 // AR Lens Button
                 _buildSideButton(
                   icon: Icons.view_in_ar,
                   onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ARLensScreen()),
                      );
                   },
                 ),
               ],
             ),
           ),
         ),
       ),
     );
  }
  
  Widget _buildSideButton({required IconData icon, required VoidCallback onTap}) {
     return InkWell(
       onTap: onTap,
       borderRadius: BorderRadius.circular(30),
       child: Container(
         padding: const EdgeInsets.all(16),
         decoration: BoxDecoration(
           color: Colors.white.withValues(alpha: 0.15),
           shape: BoxShape.circle,
         ),
         child: Icon(icon, color: Colors.white, size: 28),
       ),
     );
  }

  Widget _buildResultsList(ThemeData theme, AppLocalizations l10n) {
    if (widget.returnTextMode) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.extractedText, style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white)),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Text(_rawExtractedText, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                HapticsManager.success();
                Navigator.pop(context, _rawExtractedText);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: Icon(Icons.check_circle_outline, color: theme.colorScheme.onPrimary),
              label: Text(l10n.useText, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    }

    if (_matchedCharacters.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off_rounded, size: 64, color: Colors.white54),
              const SizedBox(height: 16),
              Text(
                l10n.noMatchingDictionaryEntries,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        if (_fullTranslation.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFCF0),
                borderRadius: BorderRadius.circular(16),
                border: Border(left: BorderSide(color: theme.colorScheme.primary, width: 4)),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.translate, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text("Full Translation", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(_fullTranslation, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, color: const Color(0xFF1A1A1B), fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.foundNCharacters(_matchedCharacters.length),
                style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
                  IconButton(
                    onPressed: _createDeck,
                    style: IconButton.styleFrom(backgroundColor: Colors.white24),
                    icon: const Icon(Icons.library_add, color: Colors.white),
                    tooltip: l10n.importAll,
                  ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _matchedCharacters.length,
            itemBuilder: (context, index) {
              final info = _matchedCharacters[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    showQuickLook(context, info.hanzi);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFCF0),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        Text(info.hanzi, style: theme.textTheme.displaySmall?.copyWith(fontSize: 40, color: const Color(0xFF1A1A1B))),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: PinyinText(
                                  text: info.pinyin,
                                  style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(info.meaning, style: theme.textTheme.bodyMedium?.copyWith(color: const Color(0xFF1A1A1B)), maxLines: 2, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // HSK badge
                        if (info.hskLevel > 0)
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'HSK${info.hskLevel}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.bookmark_add, color: theme.colorScheme.primary),
                            onPressed: () => _addSingleCard(info),
                            tooltip: l10n.addToStudyDeck,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  
  ScannerOverlayPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 280,
      height: 280,
    );
    
    final radius = 24.0;

    // Dimmed background outside the rect
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..fillType = PathFillType.evenOdd;
      
    canvas.drawPath(backgroundPath, Paint()..color = Colors.black.withValues(alpha: 0.7));
    
    // Sleek Curved Brackets
    final bracketPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
      
    final bracketLength = 40.0;
    
    // Top Left
    canvas.drawPath(Path()
      ..moveTo(rect.left, rect.top + bracketLength)
      ..lineTo(rect.left, rect.top + radius)
      ..arcToPoint(Offset(rect.left + radius, rect.top), radius: Radius.circular(radius))
      ..lineTo(rect.left + bracketLength, rect.top), bracketPaint);
      
    // Top Right
    canvas.drawPath(Path()
      ..moveTo(rect.right, rect.top + bracketLength)
      ..lineTo(rect.right, rect.top + radius)
      ..arcToPoint(Offset(rect.right - radius, rect.top), radius: Radius.circular(radius), clockwise: false)
      ..lineTo(rect.right - bracketLength, rect.top), bracketPaint);
      
    // Bottom Left
    canvas.drawPath(Path()
      ..moveTo(rect.left, rect.bottom - bracketLength)
      ..lineTo(rect.left, rect.bottom - radius)
      ..arcToPoint(Offset(rect.left + radius, rect.bottom), radius: Radius.circular(radius), clockwise: false)
      ..lineTo(rect.left + bracketLength, rect.bottom), bracketPaint);
      
    // Bottom Right
    canvas.drawPath(Path()
      ..moveTo(rect.right, rect.bottom - bracketLength)
      ..lineTo(rect.right, rect.bottom - radius)
      ..arcToPoint(Offset(rect.right - radius, rect.bottom), radius: Radius.circular(radius))
      ..lineTo(rect.right - bracketLength, rect.bottom), bracketPaint);

    // Guidance Text
    final textPainter = TextPainter(
      text: TextSpan(
        text: "Align Chinese text within frame",
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas, 
      Offset(size.width / 2 - textPainter.width / 2, rect.bottom + 32)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
