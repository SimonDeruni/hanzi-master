import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';

class CustomScenarioDialog extends ConsumerStatefulWidget {
  const CustomScenarioDialog({super.key});

  static Future<ConversationScenario?> show(BuildContext context) {
    return showDialog<ConversationScenario>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomScenarioDialog(),
    );
  }

  @override
  ConsumerState<CustomScenarioDialog> createState() => _CustomScenarioDialogState();
}

class _CustomScenarioDialogState extends ConsumerState<CustomScenarioDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _promptController = TextEditingController();
  int _hskLevel = 3;
  bool _isLoading = false;
  String _loadingText = "Generating scenario...";

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _generateAndReturn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _loadingText = "Generating Avatar...";
    });

    try {
      final gemini = ref.read(geminiServiceProvider);
      final apiKeyPool = ref.read(apiKeyPoolProvider);
      final googleKey = apiKeyPool.googleKey;
      
      final scenarioId = const Uuid().v4();
      final dir = await getApplicationDocumentsDirectory();
      
      // 1. Ask Gemini to craft the perfect image generation prompt based on the user's input
      final promptCrafter = 'You are a master AI prompt engineer for a mobile game. The user wants to create a custom conversation scenario.\nTitle: ${_titleController.text}\nContext: ${_descController.text}\nPersona: ${_promptController.text}\n\nWrite a 1-sentence prompt for an image generation model to create the avatar. The prompt MUST specify:\n1. A 3D animated portrait of a young adult (not a kid) matching the Persona.\n2. The character and a highly blurred (strong bokeh) background matching the Context MUST be strictly contained INSIDE a circular frame.\n3. The image must look exactly like a mobile game profile picture.\n4. Warm color palette, Pixar/Disney aesthetic.\n\nReply ONLY with the prompt itself, nothing else.';
      
      final craftedPrompt = await gemini.generateText(promptCrafter);

      // Call Google's direct API (Imagen-4.0) using HTTP
      final imageRes = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/imagen-4.0-generate-001:predict'),
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': googleKey,
        },
        body: jsonEncode({
          "instances": [
            {
              "prompt": craftedPrompt.trim()
            }
          ],
          "parameters": {
            "sampleCount": 1
          }
        }),
      );

      String localImagePath = 'assets/mascot/waiter_avatar.png'; // Fallback
      if (imageRes.statusCode == 200) {
        final json = jsonDecode(imageRes.body);
        if (json['predictions'] != null && json['predictions'].isNotEmpty) {
          final base64Image = json['predictions'][0]['bytesBase64Encoded'];
          final imageBytes = base64Decode(base64Image);
          final imageFile = File('${dir.path}/avatar_$scenarioId.jpg');
          await imageFile.writeAsBytes(imageBytes);
          localImagePath = imageFile.path;
        }
      }

      // 2. Generate Audio (Temporarily disabled per user request)
      String? localAudioPath;
      
      /*
      setState(() => _loadingText = "Finding Ambient Audio...");
      
      // Ask Gemini for a 1-word search query
      final queryRes = await gemini.generateText('Given the scenario: "${_descController.text}", reply with exactly ONE or TWO English keywords to search a sound effects database for background ambiance (e.g., "restaurant", "traffic", "office"). No punctuation.');
      final searchQuery = queryRes.trim().split(' ').take(2).join(' ').toLowerCase();

      final freesoundKey = "YOUR_FREESOUND_KEY"; 
      
      if (freesoundKey != "YOUR_FREESOUND_KEY") {
        final fsSearchRes = await http.get(
          Uri.parse('https://freesound.org/apiv2/search/text/?query=$searchQuery&filter=license:"Creative+Commons+0"&fields=id,previews'),
          headers: {'Authorization': 'Token $freesoundKey'},
        );
        if (fsSearchRes.statusCode == 200) {
          final fsJson = jsonDecode(fsSearchRes.body);
          if (fsJson['results'] != null && fsJson['results'].isNotEmpty) {
            final previewUrl = fsJson['results'][0]['previews']['preview-hq-mp3'];
            final audioRes = await http.get(Uri.parse(previewUrl));
            if (audioRes.statusCode == 200) {
              final audioFile = File('${dir.path}/bg_$scenarioId.mp3');
              await audioFile.writeAsBytes(audioRes.bodyBytes);
              localAudioPath = audioFile.path;
            }
          }
        }
      }
      */

      final scenario = ConversationScenario(
        id: scenarioId,
        title: _titleController.text,
        description: _descController.text,
        initialAiMessage: "你好！我们可以开始对话了。",
        systemPrompt: _promptController.text,
        targetHskLevel: _hskLevel,
        avatarAssetPath: localImagePath,
        backgroundAudioPath: localAudioPath,
        isCustom: true,
      );

      if (mounted) {
        Navigator.pop(context, scenario);
      }
    } catch (e) {
      debugPrint("Error generating scenario: $e");
      setState(() {
        _isLoading = false;
        _loadingText = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text("Create Your Scenario", style: theme.textTheme.headlineSmall),
      content: _isLoading 
        ? Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(_loadingText, textAlign: TextAlign.center),
              ],
            ),
          )
        : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HanziTextField(
                controller: _titleController,
                hintText: '',
                decoration: const InputDecoration(labelText: "Title (e.g. Wedding Reception)"),
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              HanziTextField(
                controller: _descController,
                hintText: '',
                decoration: const InputDecoration(labelText: "Description (Context)"),
                maxLines: 2,
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              HanziTextField(
                controller: _promptController,
                hintText: '',
                decoration: const InputDecoration(labelText: "AI Persona (e.g. A curious relative)"),
                maxLines: 2,
                validator: (v) => v == null || v.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Difficulty", style: theme.textTheme.titleSmall),
                  DropdownButton<int>(
                    value: _hskLevel,
                    items: List.generate(6, (i) => i + 1).map((i) => DropdownMenuItem(value: i, child: Text("HSK $i"))).toList(),
                    onChanged: (v) => setState(() => _hskLevel = v ?? 3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: _isLoading ? [] : [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: _generateAndReturn,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("Create"),
        ),
      ],
    );
  }
}
