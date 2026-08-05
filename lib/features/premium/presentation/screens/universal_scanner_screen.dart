import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'dart:io';
import '../../../../core/services/ocr_service.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/services/vision_service.dart';
import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/providers/deck_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../flashcards/presentation/widgets/deck_selection_sheet.dart';
import '../../../../shared/widgets/quick_look_sheet.dart';
import '../../../../shared/widgets/tappable_hanzi_text.dart';
import '../widgets/ar_bounding_box_painter.dart';
import '../widgets/interactive_image_overlay.dart';

enum CameraIntent {
  dictionary,
  translationHub,
  travelAR,
  textExtraction
}

class UniversalScannerScreen extends ConsumerStatefulWidget {
  final CameraIntent intent;

  const UniversalScannerScreen({
    super.key, 
    this.intent = CameraIntent.translationHub,
  });

  @override
  ConsumerState<UniversalScannerScreen> createState() => _UniversalScannerScreenState();
}

class _UniversalScannerScreenState extends ConsumerState<UniversalScannerScreen> with WidgetsBindingObserver {
  late final OcrService _ocrService;
  late final GeminiService _geminiService;
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  
  bool _isScanning = false;
  bool _isLookingUp = false;
  bool _showingResults = false;
  int _scanPhase = 0; // 0=idle, 1=analyzing, 2=extracting, 3=looking up
  String _rawExtractedText = "";
  String _fullTranslation = "";
  String _smartDeckName = "";
  List<AiWord> _matchedCharacters = [];
  Set<int> _selectedWordIndices = {};
  bool _isCreatingSmartDeck = false;

  FlashMode _flashMode = FlashMode.off;

  double _minZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  double _currentZoomLevel = 1.0;
  double _baseZoomLevel = 1.0;

  bool _isArLensMode = false;
  bool _isProcessingAr = false;
  late final VisionService _visionService;
  List<DetectedObject> _detectedObjects = [];
  Map<String, Flashcard> _translationCache = {};

  bool _showingInteractiveImage = false;
  XFile? _capturedImage;
  String? _recognizedText;
  Size? _imageSize;
  List<AiTextBlock> _aiTextBlocks = [];
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.chinese);
  List<TranslatedTextBlock> _translatedBlocks = [];
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _isArLensMode = widget.intent == CameraIntent.travelAR;
    WidgetsBinding.instance.addObserver(this);
    _geminiService = ref.read(geminiServiceProvider);
    _visionService = ref.read(visionServiceProvider);
    _ocrService = OcrService(geminiService: _geminiService);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    
    if (status.isGranted) {
      if (mounted) setState(() => _permissionDenied = false);
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _cameraController = CameraController(
          _cameras.first,
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
        );

        try {
          await _cameraController!.initialize();
          _minZoomLevel = await _cameraController!.getMinZoomLevel();
          _maxZoomLevel = await _cameraController!.getMaxZoomLevel();
          if (mounted) {
            setState(() {
              _isCameraInitialized = true;
            });
            if (_isArLensMode) {
              _cameraController!.startImageStream(_processCameraImage);
            }
          }
        } catch (e) {
          debugPrint("Camera Error: $e");
        }
      }
    } else {
      if (mounted) {
        setState(() => _permissionDenied = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Camera permission required for live scanning.',
              style: TextStyle(color: Color(0xFFFDFCF0), fontWeight: FontWeight.w500),
            ),
            backgroundColor: const Color(0xFF1A1A1B),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            action: SnackBarAction(
              label: 'Settings',
              textColor: const Color(0xFFFDFCF0),
              onPressed: () => openAppSettings(),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
    _cameraController?.stopImageStream();
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    } else if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        _cameraController!.dispose();
        _isCameraInitialized = false;
      }
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

  void _setMode(bool isAr) async {
    if (_isArLensMode == isAr) return;
    setState(() => _isArLensMode = isAr);

    if (isAr) {
      if (_cameraController?.value.isStreamingImages == false) {
        await _cameraController?.startImageStream(_processCameraImage);
      }
    } else {
      if (_cameraController?.value.isStreamingImages == true) {
        await _cameraController?.stopImageStream();
      }
    }
  }

  Future<void> _fetchTranslation(String label) async {
    try {
      final flashcard = await _geminiService.translateObject(label);
      final newCache = Map<String, Flashcard>.from(_translationCache);
      newCache[label] = flashcard;
      if (mounted) setState(() => _translationCache = newCache);
    } catch (e) {
      debugPrint('Error fetching translation for $label: $e');
      final newCache = Map<String, Flashcard>.from(_translationCache);
      newCache.remove(label);
      if (mounted) setState(() => _translationCache = newCache);
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessingAr || !_isArLensMode) return;
    _isProcessingAr = true;

    try {
      final inputImage = _inputImageFromCameraImage(image);
      if (inputImage == null) {
        _isProcessingAr = false;
        return;
      }

      // Run detectors independently so one failure doesn't kill the other
      RecognizedText? recognizedText;
      List<DetectedObject> objects = [];
      try {
        recognizedText = await _textRecognizer.processImage(inputImage);
      } catch (e) {
        debugPrint("Text recognition error: $e");
      }
      try {
        objects = await _visionService.processImage(inputImage);
      } catch (e) {
        debugPrint("Object detection error: $e");
      }

      final chineseRegex = RegExp(r'[\u4e00-\u9fa5]');
      final List<TranslatedTextBlock> newBlocks = [];
      if (recognizedText != null) {
        for (final block in recognizedText.blocks) {
          if (block.text.trim().length > 1 && chineseRegex.hasMatch(block.text)) {
            newBlocks.add(TranslatedTextBlock(
              boundingBox: block.boundingBox,
              originalText: block.text,
              translatedText: block.text,
            ));
          }
        }
      }

      final currentCache = Map<String, Flashcard>.from(_translationCache);
      bool cacheUpdated = false;

      for (final obj in objects) {
        for (final label in obj.labels) {
          final text = label.text;
          if (!currentCache.containsKey(text)) {
            currentCache[text] = Flashcard(hanzi: '...', pinyin: '...', definition: 'Loading...', id: 'temp_$text', hskLevel: 0, strokePaths: const [], modeStats: const {});
            cacheUpdated = true;
            _fetchTranslation(text);
          }
        }
      }

      if (mounted && _isArLensMode) {
        setState(() {
          _detectedObjects = objects;
          _translatedBlocks = newBlocks;
          if (cacheUpdated) _translationCache = currentCache;
        });
      }
    } catch (e) {
      debugPrint("Error processing image: $e");
    } finally {
      _isProcessingAr = false;
    }
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_cameraController == null) return null;
    final camera = _cameraController!.description;
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = _cameraController!.value.deviceOrientation.index;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }

    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;

    if (image.planes.isEmpty) return null;

    return InputImage.fromBytes(
      bytes: Platform.isAndroid ? image.planes[0].bytes : image.planes.first.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized || _isScanning || _isLookingUp) return;
    
    HapticsManager.light();
    setState(() {
      _isScanning = true;
      _scanPhase = 1;
      _showingResults = false;
      _showingInteractiveImage = false;
    });

    try {
      final image = await _cameraController!.takePicture();
      await _processImageDetailed(image);
    } catch (e) {
      debugPrint("Take Photo Error: $e");
      setState(() {
        _isScanning = false;
        _scanPhase = 0;
      });
    }
  }

  Future<void> _pickFromGallery() async {
    if (_isScanning || _isLookingUp) return;
    
    HapticsManager.light();
    setState(() {
      _isScanning = true;
      _scanPhase = 1;
      _showingResults = false;
      _showingInteractiveImage = false;
    });

    try {
      final result = await _ocrService.scanImageDetailed(fromCamera: false);
      if (result != null) {
        await _processImageDetailed(result.image, preRecognized: result.text, preBlocks: result.blocks);
      } else {
        setState(() {
          _isScanning = false;
          _scanPhase = 0;
        });
      }
    } catch (e) {
      debugPrint("Pick Gallery Error: $e");
      setState(() {
        _isScanning = false;
        _scanPhase = 0;
      });
    }
  }

  Future<void> _processImageDetailed(XFile image, {String? preRecognized, List<AiTextBlock>? preBlocks}) async {
    ({String text, List<AiTextBlock> blocks})? result;
    if (preRecognized != null) {
      result = (text: preRecognized, blocks: preBlocks ?? <AiTextBlock>[]);
    } else {
      result = await _ocrService.processImageFileDetailed(image);
      // Offline fallback: if AI OCR fails, use ML Kit TextRecognizer
      if (result == null || result.text.isEmpty) {
        try {
          final inputImage = InputImage.fromFilePath(image.path);
          final recognizedText = await _textRecognizer.processImage(inputImage);
          final text = recognizedText.text.trim();
          if (text.isNotEmpty) {
            result = (text: text, blocks: <AiTextBlock>[]);
          }
        } catch (e) {
          debugPrint("ML Kit fallback error: $e");
        }
      }

      // Always run ML Kit to get pixel-accurate bounding boxes,
      // replacing Gemini-hallucinated coordinates with real measurements.
      try {
        final inputImage = InputImage.fromFilePath(image.path);
        final recognizedText = await _textRecognizer.processImage(inputImage);
        if (recognizedText.blocks.isNotEmpty && result != null) {
          final mlBlocks = recognizedText.blocks
              .where((b) => b.text.trim().isNotEmpty && b.boundingBox.width > 0 && b.boundingBox.height > 0)
              .map((b) => AiTextBlock(
                    text: b.text.trim(),
                    x: b.boundingBox.left,
                    y: b.boundingBox.top,
                    width: b.boundingBox.width,
                    height: b.boundingBox.height,
                  ))
              .toList();
          if (mlBlocks.isNotEmpty) {
            result = (text: result.text, blocks: mlBlocks);
          }
        }
      } catch (e) {
        debugPrint("ML Kit bounding box extraction error: $e");
      }
    }

    final processed = result;
    if (processed != null && processed.text.isNotEmpty) {
      // Read image dimensions from raw bytes to match ML Kit coordinate space.
      // decodeImageFromList may apply EXIF rotation, causing coordinate mismatch.
      final imageBytes = await image.readAsBytes();
      var imageWidth = 0.0;
      var imageHeight = 0.0;
      try {
        final codec = await ui.instantiateImageCodec(imageBytes);
        final frame = await codec.getNextFrame();
        imageWidth = frame.image.width.toDouble();
        imageHeight = frame.image.height.toDouble();
        frame.image.dispose();
        codec.dispose();
      } catch (_) {
        // Fallback: use decodeImageFromList dimensions
        final decodedImage = await decodeImageFromList(imageBytes);
        imageWidth = decodedImage.width.toDouble();
        imageHeight = decodedImage.height.toDouble();
      }

      setState(() {
        _isScanning = false;
        _scanPhase = 2;
        _capturedImage = image;
        _recognizedText = processed.text;
        _aiTextBlocks = processed.blocks;
        _imageSize = Size(imageWidth, imageHeight);
        _showingInteractiveImage = true;
      });
      _cameraController?.stopImageStream();
    } else {
      setState(() {
        _isScanning = false;
        _scanPhase = 0;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.noChineseCharactersFound)),
        );
      }
    }
  }

  Future<void> _processExtractedText(String text) async {
    HapticsManager.success();
    
    if (widget.intent == CameraIntent.textExtraction) {
      Navigator.pop(context, text);
      return;
    }

    setState(() {
      _isScanning = false;
      _rawExtractedText = text;
      _isLookingUp = true;
      _scanPhase = 3;
      _showingInteractiveImage = false;
    });

    final gemini = ref.read(geminiServiceProvider);
    
    try {
      final extraction = await gemini.extractVocabularyFromScan(text);
      if (mounted) {
        setState(() {
          _scanPhase = 0;
          _fullTranslation = extraction['fullTranslation'] as String;
          _smartDeckName = extraction['deckName'] as String? ?? 'Scan Results';
          _matchedCharacters = extraction['words'] as List<AiWord>;
          _selectedWordIndices.clear();
          _isLookingUp = false;
          _showingResults = true;
        });
      }
    } catch (e) {
      debugPrint("Gemini Error: $e");
      if (mounted) {
        setState(() {
          _scanPhase = 0;
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
          // Camera Preview (hidden when gallery image is shown)
          if (_isCameraInitialized && _cameraController != null && !_showingInteractiveImage)
            Positioned.fill(
              child: GestureDetector(
                onScaleStart: _handleScaleStart,
                onScaleUpdate: _handleScaleUpdate,
                child: Builder(
                  builder: (context) {
                    final orientation = MediaQuery.of(context).orientation;
                    final previewSize = _cameraController!.value.previewSize!;
                    final double maxDim = math.max(previewSize.width, previewSize.height);
                    final double minDim = math.min(previewSize.width, previewSize.height);
                    
                    final bool isPortrait = orientation == Orientation.portrait;
                    final double childWidth = isPortrait ? minDim : maxDim;
                    final double childHeight = isPortrait ? maxDim : minDim;
                    return ClipRect(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: childWidth,
                          height: childHeight,
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          else
            Positioned.fill(child: Container(color: Colors.black)),
            
          // Blur overlay during loading or results
          if (_isScanning || _isLookingUp || _showingResults)
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
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
                
                // Zoom Slider
                if (!_showingResults && !_showingInteractiveImage && _isCameraInitialized)
                  _buildZoomSlider(),

                // Deep Analysis button for AR mode
                if (_isArLensMode && !_showingResults && !_showingInteractiveImage && _isCameraInitialized)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: FloatingActionButton.extended(
                      onPressed: _deepAnalyzeScene,
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Deep Analysis'),
                      backgroundColor: theme.colorScheme.primaryContainer,
                      foregroundColor: theme.colorScheme.onPrimaryContainer,
                    ),
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
  
  Future<void> _deepAnalyzeScene() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized || _isScanning || _isLookingUp) return;

    HapticsManager.light();
    setState(() {
      _isLookingUp = true;
    });

    try {
      if (_cameraController!.value.isStreamingImages) {
        await _cameraController!.stopImageStream();
      }

      final image = await _cameraController!.takePicture();
      final bytes = await image.readAsBytes();

      final langCode = ref.read(translationLanguageProvider);

      final Set<String> currentLabels = {};
      for (final obj in _detectedObjects) {
        if (obj.labels.isNotEmpty) {
          currentLabels.add(obj.labels.first.text);
        }
      }

      final result = await _geminiService.analyzeSceneObjects(bytes, currentLabels.toList(), langCode);

      final updatedLabels = result['updatedLabels'] as Map<String, AiWord>;
      final allObjects = result['allObjects'] as List<AiWord>;

      if (mounted) {
        setState(() {
          _isLookingUp = false;
          _showingResults = true;
          _matchedCharacters = allObjects;

          final newCache = Map<String, Flashcard>.from(_translationCache);
          updatedLabels.forEach((label, aiWord) {
            newCache[label] = Flashcard(
              id: '',
              hanzi: aiWord.hanzi,
              pinyin: aiWord.pinyin,
              definition: aiWord.meaning,
              hskLevel: aiWord.hskLevel,
              strokePaths: const [],
              modeStats: const {},
            );
          });
          _translationCache = newCache;
        });

        if (_isArLensMode) {
          _cameraController!.startImageStream(_processCameraImage);
        }
      }
    } catch (e) {
      debugPrint("Deep Analyze Error: $e");
      if (mounted) {
        setState(() => _isLookingUp = false);
        if (_isArLensMode) {
          _cameraController!.startImageStream(_processCameraImage);
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI Scene Analysis Failed')));
      }
    }
  }

  Widget _buildMainContent(ThemeData theme, AppLocalizations l10n) {
    if (_permissionDenied) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.no_photography_outlined, size: 64, color: Colors.white.withValues(alpha: 0.5)),
              const SizedBox(height: 16),
              const Text(
                'Camera Access Required',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enable camera access in your device settings to use this feature.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.7)),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => openAppSettings(),
                icon: const Icon(Icons.settings),
                label: const Text('Open Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_isScanning || _isLookingUp) {
      final phase = _isScanning ? _scanPhase : 3;
      final steps = ['Analyzing image…', 'Extracting Chinese text…', 'Looking up vocabulary…'];
      final currentStep = phase.clamp(1, 3) - 1;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 48, height: 48,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            ),
            const SizedBox(height: 24),
            ...List.generate(steps.length, (i) {
              final isActive = i == currentStep;
              final isDone = i < currentStep;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isDone ? Icons.check_circle : (isActive ? Icons.circle : Icons.radio_button_unchecked),
                      color: isDone ? Colors.green : (isActive ? Colors.white : Colors.white38),
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      steps[i],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDone ? Colors.green : (isActive ? Colors.white : Colors.white38),
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
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
                          if (_capturedImage != null && !_isArLensMode) {
                            _showingInteractiveImage = true;
                          }
                        });
                      }
                    ),
                  Text("Results", style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                    tooltip: 'Scan Another',
                    onPressed: () {
                      setState(() {
                        _showingResults = false;
                        _capturedImage = null;
                        _recognizedText = null;
                        _aiTextBlocks = [];
                        _matchedCharacters = [];
                        _selectedWordIndices.clear();
                        _rawExtractedText = "";
                        _fullTranslation = "";
                      });
                    },
                  ),
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
                        _cameraController?.startImageStream(_processCameraImage);
                      }
                    ),
                    const SizedBox(width: 48),
                 ]
              ),
            ),
            Expanded(
              child: _capturedImage != null
                  ? InteractiveImageOverlay(
                      image: _capturedImage!,
                      blocks: _aiTextBlocks,
                      imageSize: _imageSize ?? const Size(1000, 1000),
                      onWordTapped: (word) {
                        _lookupSingleWord(word);
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (_recognizedText != null) {
                    _processExtractedText(_recognizedText!);
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

    if (_isArLensMode) {
      if (_cameraController == null) return const SizedBox.shrink();
      InputImageRotation rotation = InputImageRotation.rotation0deg;
      final sensorOrientation = _cameraController!.description.sensorOrientation;
      final rawRotation = InputImageRotationValue.fromRawValue(sensorOrientation);
      if (rawRotation != null) rotation = rawRotation;

      return GestureDetector(
        onTapUp: (details) {
          if (_detectedObjects.isEmpty) return;

          final size = MediaQuery.of(context).size;
          final imageSize = Size(
            _cameraController!.value.previewSize!.width,
            _cameraController!.value.previewSize!.height,
          );

          final bool isPortrait = rotation == InputImageRotation.rotation90deg || rotation == InputImageRotation.rotation270deg;
          final double imageWidth = isPortrait ? imageSize.height : imageSize.width;
          final double imageHeight = isPortrait ? imageSize.width : imageSize.height;

          final double scaleX = size.width / imageWidth;
          final double scaleY = size.height / imageHeight;

          for (final obj in _detectedObjects) {
            if (obj.labels.isEmpty) continue;

            final rect = ARBoundingBoxPainter.scaleRect(
              rect: obj.boundingBox,
              imageSize: imageSize,
              widgetSize: size,
              scaleX: scaleX,
              scaleY: scaleY,
              rotation: rotation,
            );

            if (rect.inflate(10.0).contains(details.localPosition)) {
              final label = obj.labels.first.text;
              final translated = _translationCache[label]?.hanzi ?? label;
              _lookupSingleWord(translated);
              return;
            }
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
          CustomPaint(
            painter: TranslationOverlayPainter(
              blocks: _translatedBlocks,
              imageSize: Size(
                _cameraController!.value.previewSize!.height,
                _cameraController!.value.previewSize!.width,
              ),
              screenSize: MediaQuery.of(context).size,
            ),
          ),
          CustomPaint(
            painter: ARBoundingBoxPainter(
              _detectedObjects,
              _translationCache,
              Size(
                _cameraController!.value.previewSize!.width,
                _cameraController!.value.previewSize!.height,
              ),
              rotation,
            ),
          ),
          const Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Point at Chinese text to translate",
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      );
    }

    return CustomPaint(
      painter: ScannerOverlayPainter(),
      child: const SizedBox.expand(),
    );
  }
  
  Widget _buildZoomSlider() {
    if (_minZoomLevel >= _maxZoomLevel) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.zoom_out, color: Colors.white70, size: 20),
          Expanded(
            child: Slider(
              value: _currentZoomLevel,
              min: _minZoomLevel,
              max: _maxZoomLevel,
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              onChanged: (value) async {
                setState(() => _currentZoomLevel = value);
                await _cameraController?.setZoomLevel(value);
              },
            ),
          ),
          const Icon(Icons.zoom_in, color: Colors.white70, size: 20),
        ],
      ),
    );
  }

  Widget _buildBottomControls(ThemeData theme, AppLocalizations l10n) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 32.0, left: 32.0, right: 32.0),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(40),
         child: BackdropFilter(
           filter: ui.ImageFilter.blur(sigmaX: 30, sigmaY: 30),
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
                  // Left Side: Gallery Button or spacing
                  if (!_isArLensMode)
                    _buildSideButton(
                      icon: Icons.photo_library_outlined,
                      onTap: _pickFromGallery,
                    )
                  else if (widget.intent != CameraIntent.textExtraction)
                    const SizedBox(width: 60), // Maintain layout balance
                  
                  // Center: Premium Shutter Button or Scanner mode return
                  if (!_isArLensMode || widget.intent == CameraIntent.travelAR)
                    GestureDetector(
                      onTap: () {
                         if (widget.intent == CameraIntent.textExtraction) {
                            // Raw capture is handled inside `_takePhoto` and `_processExtractedText`
                            _takePhoto();
                         } else {
                            _takePhoto();
                         }
                      },
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
                    )
                  else if (widget.intent != CameraIntent.textExtraction)
                    _buildSideButton(
                      icon: Icons.document_scanner,
                      isActive: false,
                      onTap: () => _setMode(false),
                    ),
                  
                  // Right Side: AR Lens Button
                  if (widget.intent != CameraIntent.textExtraction)
                    _buildSideButton(
                      icon: Icons.view_in_ar,
                      isActive: _isArLensMode,
                      onTap: () => _setMode(!_isArLensMode),
                    ),
                ],
             ),
           ),
         ),
       ),
     );
  }
  
  Widget _buildSideButton({required IconData icon, required VoidCallback onTap, bool isActive = false}) {
     return InkWell(
       onTap: onTap,
       borderRadius: BorderRadius.circular(30),
       child: AnimatedContainer(
         duration: const Duration(milliseconds: 200),
         padding: const EdgeInsets.all(16),
         decoration: BoxDecoration(
           color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.15),
           shape: BoxShape.circle,
         ),
         child: Icon(icon, color: isActive ? Colors.black : Colors.white, size: 28),
       ),
     );
  }

  Widget _buildResultsList(ThemeData theme, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (widget.intent == CameraIntent.textExtraction) {
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
                  color: isDark ? const Color(0xFF1A1A1B).withValues(alpha: 0.95) : Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Text(_rawExtractedText, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6, color: isDark ? Colors.white : Colors.black87)),
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
    
    if (widget.intent == CameraIntent.dictionary) {
      return _buildDictionaryResultsList(theme, l10n);
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
        if (_rawExtractedText.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1B).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.text_snippet, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 12),
                      Text("Extracted Text (Tap to lookup)", style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: SingleChildScrollView(
                      child: TappableHanziText(
                        _rawExtractedText,
                        style: theme.textTheme.bodyLarge?.copyWith(height: 1.5, color: Colors.white.withValues(alpha: 0.9)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (_fullTranslation.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1B).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.translate, size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 12),
                      Text("Full Translation", style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: SingleChildScrollView(
                      child: Text(_fullTranslation, style: theme.textTheme.bodyLarge?.copyWith(height: 1.5, color: Colors.white.withValues(alpha: 0.9), fontStyle: FontStyle.italic)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.foundNCharacters(_matchedCharacters.length),
                style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _createDeck,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                icon: const Icon(Icons.bookmark_add, size: 20),
                label: const Text("Save All", style: TextStyle(fontWeight: FontWeight.bold)),
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
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2B) : const Color(0xFFFDFCF0),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1), blurRadius: 8, offset: const Offset(0, 4)),
                      ],
                      border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(info.hanzi, style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: isDark ? Colors.white : const Color(0xFF1A1A1B), height: 1.0)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PinyinText(
                                text: info.pinyin,
                                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(info.meaning, style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (info.hskLevel > 0)
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'HSK ${info.hskLevel}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            Container(
                              decoration: BoxDecoration(
                                color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFF1A1A1B).withValues(alpha: 0.05),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                                onPressed: () => _addSingleCard(info),
                                tooltip: l10n.addToStudyDeck,
                              ),
                            ),
                          ],
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

  Widget _buildDictionaryResultsList(ThemeData theme, AppLocalizations l10n) {
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

    final existingCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Scan Results",
                    style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            if (_selectedWordIndices.length == _matchedCharacters.length) {
                              _selectedWordIndices.clear();
                            } else {
                              _selectedWordIndices = Set.from(List.generate(_matchedCharacters.length, (i) => i));
                            }
                          });
                          HapticsManager.light();
                        },
                        icon: Icon(
                          _selectedWordIndices.length == _matchedCharacters.length ? Icons.deselect : Icons.select_all, 
                          color: Colors.white70,
                          size: 20
                        ),
                        label: Text(
                          _selectedWordIndices.length == _matchedCharacters.length ? "Deselect All" : "Select All", 
                          style: const TextStyle(color: Colors.white70)
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _isCreatingSmartDeck ? null : _createSmartDeck,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade700,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        icon: _isCreatingSmartDeck 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                            : const Icon(Icons.auto_awesome, size: 20),
                        label: const Text("Smart Deck", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: _selectedWordIndices.isNotEmpty ? 100 : 24),
                itemCount: _matchedCharacters.length,
                itemBuilder: (context, index) {
                  final info = _matchedCharacters[index];
                  final isSelected = _selectedWordIndices.contains(index);
                  final isInLibrary = existingCards.any((c) => c.hanzi == info.hanzi);
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedWordIndices.remove(index);
                            } else {
                              _selectedWordIndices.add(index);
                            }
                          });
                          HapticsManager.light();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.15) : const Color(0xFF1A1A1B).withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? theme.colorScheme.primary : Colors.white.withValues(alpha: 0.1),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? theme.colorScheme.primary : Colors.white54,
                                    width: 2,
                                  ),
                                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                                ),
                                child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 18) : null,
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: 56,
                                height: 56,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(info.hanzi, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, height: 1.0)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PinyinText(
                                      text: info.pinyin,
                                      style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(info.meaning.isNotEmpty ? info.meaning : info.english, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isInLibrary ? Colors.green.withValues(alpha: 0.2) : theme.colorScheme.primary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isInLibrary ? "In Library" : "New",
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: isInLibrary ? Colors.green.shade300 : theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        
        if (_selectedWordIndices.isNotEmpty)
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      final selectedWords = _selectedWordIndices.map((i) => _matchedCharacters[i]).toList();
                      final flashcards = selectedWords.map<Flashcard>((w) => Flashcard(
                        id: '',
                        hanzi: w.hanzi,
                        pinyin: w.pinyin,
                        definition: w.meaning.isNotEmpty ? w.meaning : w.english,
                        hskLevel: w.hskLevel,
                        strokePaths: const [],
                        modeStats: const {},
                      )).toList();
                      
                      DeckSelectionSheet.show(context, cards: flashcards);
                    },
                    backgroundColor: theme.colorScheme.primary,
                    icon: const Icon(Icons.bookmark_add, color: Colors.white),
                    label: Text("Add to Deck (${_selectedWordIndices.length})", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Future<void> _createSmartDeck() async {
    if (_matchedCharacters.isEmpty) return;
    
    setState(() {
      _isCreatingSmartDeck = true;
    });
    
    try {
      final deckCtrl = ref.read(deckControllerProvider.notifier);
      final newDeck = await deckCtrl.createDeck(_smartDeckName);
      
      if (newDeck != null) {
        final flashcardCtrl = ref.read(flashcardControllerProvider.notifier);
        
        for (int i = 0; i < _matchedCharacters.length; i++) {
          final w = _matchedCharacters[i];
          final newCard = Flashcard(
            id: DateTime.now().millisecondsSinceEpoch.toString() + i.toString(),
            hanzi: w.hanzi,
            pinyin: w.pinyin,
            definition: w.meaning.isNotEmpty ? w.meaning : w.english,
            hskLevel: w.hskLevel,
            deckId: newDeck.id,
            strokePaths: const [],
            modeStats: const {},
          );
          await flashcardCtrl.addFlashcard(newCard);
        }
        
        if (mounted) {
          HapticsManager.success();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white),
                  const SizedBox(width: 12),
                  Text('Created smart deck: "$_smartDeckName" with ${_matchedCharacters.length} words!'),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context); // Close the scanner and return
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreatingSmartDeck = false;
        });
      }
    }
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
    
    const radius = 24.0;

    // Removed dimmed background outside the rect
    // Sleek Curved Brackets
    final bracketPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
      
    const bracketLength = 40.0;
    
    // Top Left
    canvas.drawPath(Path()
      ..moveTo(rect.left, rect.top + bracketLength)
      ..lineTo(rect.left, rect.top + radius)
      ..arcToPoint(Offset(rect.left + radius, rect.top), radius: const Radius.circular(radius))
      ..lineTo(rect.left + bracketLength, rect.top), bracketPaint);
      
    // Top Right
    canvas.drawPath(Path()
      ..moveTo(rect.right, rect.top + bracketLength)
      ..lineTo(rect.right, rect.top + radius)
      ..arcToPoint(Offset(rect.right - radius, rect.top), radius: const Radius.circular(radius), clockwise: false)
      ..lineTo(rect.right - bracketLength, rect.top), bracketPaint);
      
    // Bottom Left
    canvas.drawPath(Path()
      ..moveTo(rect.left, rect.bottom - bracketLength)
      ..lineTo(rect.left, rect.bottom - radius)
      ..arcToPoint(Offset(rect.left + radius, rect.bottom), radius: const Radius.circular(radius), clockwise: false)
      ..lineTo(rect.left + bracketLength, rect.bottom), bracketPaint);
      
    // Bottom Right
    canvas.drawPath(Path()
      ..moveTo(rect.right, rect.bottom - bracketLength)
      ..lineTo(rect.right, rect.bottom - radius)
      ..arcToPoint(Offset(rect.right - radius, rect.bottom), radius: const Radius.circular(radius))
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

class TranslatedTextBlock {
  final Rect boundingBox;
  final String originalText;
  final String translatedText;

  TranslatedTextBlock({
    required this.boundingBox,
    required this.originalText,
    required this.translatedText,
  });
}

class TranslationOverlayPainter extends CustomPainter {
  final List<TranslatedTextBlock> blocks;
  final Size imageSize;
  final Size screenSize;

  TranslationOverlayPainter({
    required this.blocks,
    required this.imageSize,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // We must use math.min to match BoxFit.contain
    final double scale = math.min(screenSize.width / imageSize.width, screenSize.height / imageSize.height);
    final double offsetX = (screenSize.width - imageSize.width * scale) / 2;
    final double offsetY = (screenSize.height - imageSize.height * scale) / 2;

    final Paint bgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFFDFCF0).withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final block in blocks) {
      final rect = Rect.fromLTRB(
        block.boundingBox.left * scale + offsetX,
        block.boundingBox.top * scale + offsetY,
        block.boundingBox.right * scale + offsetX,
        block.boundingBox.bottom * scale + offsetY,
      );

      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
      canvas.drawRRect(rrect, bgPaint);
      canvas.drawRRect(rrect, borderPaint);

      final textSpan = TextSpan(
        text: block.translatedText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        maxLines: 3,
        ellipsis: '...',
      );

      textPainter.layout(maxWidth: rect.width);
      
      final textY = rect.top + (rect.height - textPainter.height) / 2;
      textPainter.paint(canvas, Offset(rect.left + 2, textY));
    }
  }

  @override
  bool shouldRepaint(TranslationOverlayPainter oldDelegate) {
    return oldDelegate.blocks != blocks;
  }
}

