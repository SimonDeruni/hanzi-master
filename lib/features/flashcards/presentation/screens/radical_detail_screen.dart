import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

class RadicalDetailScreen extends ConsumerStatefulWidget {
  final String radicalChar;
  final dynamic radicalData;

  const RadicalDetailScreen({
    super.key,
    required this.radicalChar,
    required this.radicalData,
  });

  @override
  ConsumerState<RadicalDetailScreen> createState() => _RadicalDetailScreenState();
}

class _RadicalDetailScreenState extends ConsumerState<RadicalDetailScreen> {
  List<Map<String, dynamic>> _matchingCharacters = [];
  List<Map<String, dynamic>> _filteredCharacters = [];
  bool _isLoading = true;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadMatchingCharacters();
  }

  Future<void> _loadMatchingCharacters() async {
    try {
      final metadataString = await rootBundle.loadString('assets/data/hanzi_metadata.json');
      final metadata = json.decode(metadataString) as Map<String, dynamic>;
      
      final List<Map<String, dynamic>> matches = [];
      metadata.forEach((char, data) {
        if (data['radical'] == widget.radicalChar) {
          String pinyinStr = '';
          if (data['pinyin'] is List) {
            pinyinStr = (data['pinyin'] as List).join(', ');
          } else {
            pinyinStr = (data['pinyin'] ?? '').toString();
          }

          matches.add({
            'char': char,
            'pinyin': pinyinStr,
            'definition': data['definition'] ?? '',
          });
        }
      });
      
      if (mounted) {
        setState(() {
          _matchingCharacters = matches;
          _filteredCharacters = List.from(matches);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _filterCharacters(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCharacters = List.from(_matchingCharacters);
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredCharacters = _matchingCharacters.where((item) {
          final char = (item['char'] ?? '').toString().toLowerCase();
          final pinyin = (item['pinyin'] ?? '').toString().toLowerCase();
          final def = (item['definition'] ?? '').toString().toLowerCase();
          return char.contains(lowerQuery) || pinyin.contains(lowerQuery) || def.contains(lowerQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              // Radical Hero
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.indigo.withValues(alpha: 0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.red.withValues(alpha: 0.2), width: 2),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.red.withValues(alpha: 0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          widget.radicalChar,
                          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(0xFFB22222)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.radicalData['name'] ?? 'Unknown Radical',
                            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.radicalData['meaning'] ?? '',
                            style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              if (widget.radicalData['mnemonic'] != null) ...[
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, color: Colors.amber),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.radicalData['mnemonic'],
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: isDark ? Colors.white70 : Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 32),
              
              // Character Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "CHARACTERS WITH THIS RADICAL (${_matchingCharacters.length})",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                child: TextField(
                  onChanged: _filterCharacters,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(
                    hintText: "Search by pinyin or meaning...",
                    hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                    prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                    filled: true,
                    fillColor: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.indigo.withValues(alpha: 0.2)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.indigo.withValues(alpha: 0.1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.indigo, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              Expanded(
                child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.indigo))
                  : _filteredCharacters.isEmpty
                      ? const Center(child: Text("No characters found."))
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: _filteredCharacters.length,
                          itemBuilder: (context, index) {
                            final item = _filteredCharacters[index];
                            return _buildCharacterItem(context, item, isDark);
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterItem(BuildContext context, Map<String, dynamic> item, bool isDark) {
    return GestureDetector(
      onTap: () {
        final existingCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
        final existingCard = existingCards.where((c) => c.hanzi == item['char']).firstOrNull;

        final targetCard = existingCard ?? Flashcard(
          id: 'temp_${item['char']}',
          hanzi: item['char'],
          pinyin: item['pinyin'],
          definition: item['definition'],
          hskLevel: 0,
          strokePaths: const [],
          modeStats: const {},
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(card: targetCard),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withValues(alpha: 0.2), width: 1.5),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item['char'],
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF2C2C2C),
              ),
            ),
            if (item['pinyin'].toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  item['pinyin'].toString().split(' ').first,
                  style: TextStyle(
                    fontSize: 10, 
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
