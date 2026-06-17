import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/features/echo_hall/domain/entities/scenario.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';

class CustomScenarioDialog extends StatefulWidget {
  const CustomScenarioDialog({super.key});

  static Future<ConversationScenario?> show(BuildContext context) {
    return showDialog<ConversationScenario>(
      context: context,
      builder: (context) => const CustomScenarioDialog(),
    );
  }

  @override
  State<CustomScenarioDialog> createState() => _CustomScenarioDialogState();
}

class _CustomScenarioDialogState extends State<CustomScenarioDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _promptController = TextEditingController();
  int _hskLevel = 3;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text("Create Your Scenario", style: theme.textTheme.headlineSmall),
      content: SingleChildScrollView(
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
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final scenario = ConversationScenario(
                id: const Uuid().v4(),
                title: _titleController.text,
                description: _descController.text,
                initialAiMessage: "你好！我们可以开始对话了。",
                systemPrompt: _promptController.text,
                targetHskLevel: _hskLevel,
                avatarAssetPath: 'assets/mascot/friend_avatar.png',
                isCustom: true,
              );
              Navigator.pop(context, scenario);
            }
          },
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
