import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/live_translate/domain/entities/translation_session.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/translation_session_detail_screen.dart';

class TranslationHistoryScreen extends ConsumerWidget {
  const TranslationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final box = Hive.box<TranslationSession>('translation_sessions');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Session History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              box.clear();
            },
          ),
        ],
      ),
      body: CalligraphyBackground(
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box<TranslationSession> box, _) {
            if (box.isEmpty) {
              return const Center(child: Text("No saved sessions."));
            }

            final sessions = box.values.toList()..sort((a, b) => b.date.compareTo(a.date));

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                final preview = session.messages.isNotEmpty 
                    ? session.messages.first.text 
                    : "Empty session";

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.history, color: Colors.white),
                    ),
                    title: Text(session.modeName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${session.date.toLocal()}".split('.')[0]),
                        Text(preview, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TranslationSessionDetailScreen(session: session),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
