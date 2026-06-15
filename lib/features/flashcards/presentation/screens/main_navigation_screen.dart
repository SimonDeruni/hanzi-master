import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dictionary_screen.dart';
import 'package:hanzi_master/features/course/presentation/screens/course_selection_screen.dart';
import 'package:hanzi_master/features/chat/presentation/screens/ai_hub_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CourseSelectionScreen(),
    const AiHubScreen(),
    const DictionaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final flashcardsState = ref.watch(flashcardControllerProvider);

    if (flashcardsState.isLoading && flashcardsState.valueOrNull == null) {
      return const Scaffold(
        body: CalligraphyBackground(
          child: Center(
            child: CircularProgressIndicator(color: Colors.brown),
          ),
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            HapticsManager.light();
            setState(() => _selectedIndex = index);
          },
          backgroundColor: const Color(0xFFFDFCF0),
          selectedItemColor: const Color(0xFF1A1A1B),
          unselectedItemColor: const Color(0xFF1A1A1B).withValues(alpha: 0.5),
          showUnselectedLabels: true,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_motion),
              label: 'The Path',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome),
              label: 'AI Hub',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }
}

    