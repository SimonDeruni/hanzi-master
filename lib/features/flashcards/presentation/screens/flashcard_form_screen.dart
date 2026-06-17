import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/flashcard.dart';
import '../providers/flashcard_controller.dart';
import '../utils/haptics_manager.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';

class FlashcardFormScreen extends ConsumerStatefulWidget {
  final Flashcard? cardToEdit; // If this is null, we are creating a NEW card

  const FlashcardFormScreen({super.key, this.cardToEdit});

  @override
  ConsumerState<FlashcardFormScreen> createState() => _FlashcardFormScreenState();
}

class _FlashcardFormScreenState extends ConsumerState<FlashcardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _hanziController;
  late TextEditingController _pinyinController;
  late TextEditingController _defController;

  @override
  void initState() {
    super.initState();
    // Pre-fill the boxes if we are editing an existing card
    _hanziController = TextEditingController(text: widget.cardToEdit?.hanzi ?? '');
    _pinyinController = TextEditingController(text: widget.cardToEdit?.pinyin ?? '');
    _defController = TextEditingController(text: widget.cardToEdit?.definition ?? '');
  }

  @override
  void dispose() {
    _hanziController.dispose();
    _pinyinController.dispose();
    _defController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      
      // 1. Logic for NEW Card
      if (widget.cardToEdit == null) {
        final newCard = Flashcard(
          id: const Uuid().v4(),
          hanzi: _hanziController.text,
          pinyin: _pinyinController.text,
          definition: _defController.text,
          hskLevel: 1,
          strokePaths: const [],
          modeStats: const {},
        );

        // We use the controller to save (it handles the repository for us)
        ref.read(flashcardControllerProvider.notifier).addFlashcard(newCard);
      } 
      // 2. Logic for EDITING Existing Card
      else {
        ref.read(flashcardControllerProvider.notifier).editFlashcard(
          widget.cardToEdit!, 
          _hanziController.text, 
          _pinyinController.text, 
          _defController.text
        );
      }

      // 3. FEEL THE SUCCESS 📳
      HapticsManager.success();

      // 4. Close the screen (ONLY ONCE!)
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.cardToEdit != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Card" : "New Card")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // HANZI
              HanziTextField(
                controller: _hanziController,
                hintText: '',
                decoration: const InputDecoration(labelText: "Hanzi (Character)", border: OutlineInputBorder()),
                style: const TextStyle(fontSize: 24),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              
              // PINYIN
              TextFormField(
                controller: _pinyinController,
                decoration: const InputDecoration(labelText: "Pinyin", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // DEFINITION
              TextFormField(
                controller: _defController,
                decoration: const InputDecoration(labelText: "Definition", border: OutlineInputBorder()),
                maxLines: 3,
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 32),

              // SAVE BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.indigo,
                ),
                onPressed: _save,
                child: const Text("Save Card", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}