import os
import re

files_to_check = [
    'lib/features/reading/presentation/widgets/custom_story_creator_sheet.dart',
    'lib/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart',
    'lib/features/flashcards/presentation/widgets/ai_explainer_sheet.dart',
    'lib/features/flashcards/presentation/widgets/character_chat_sheet.dart',
    'lib/features/flashcards/presentation/widgets/deck_selection_sheet.dart',
    'lib/features/flashcards/presentation/widgets/flashcard_edit_dialog.dart',
    'lib/features/live_translate/presentation/screens/shadowing_studio_screen.dart',
    'lib/features/live_translate/presentation/screens/travel_interpreter_screen.dart',
    'lib/features/settings/presentation/screens/contact_screen.dart',
    'lib/shared/widgets/nuance_compare_sheet.dart'
]

for file_path in files_to_check:
    if not os.path.exists(file_path): continue
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if 'TextField(' not in content:
        continue
        
    content = content.replace('TextField(', 'HanziTextField(')
    
    if 'hanzi_text_field.dart' not in content:
        content = content.replace(\"import 'package:flutter/material.dart';\", \"import 'package:flutter/material.dart';\\nimport 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';\")
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f'Updated {file_path}')
