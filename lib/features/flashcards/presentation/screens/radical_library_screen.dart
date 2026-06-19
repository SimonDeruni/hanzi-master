import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/radical_detail_screen.dart';
import 'package:lpinyin/lpinyin.dart';

class RadicalLibraryScreen extends StatefulWidget {
  const RadicalLibraryScreen({super.key});

  @override
  State<RadicalLibraryScreen> createState() => _RadicalLibraryScreenState();
}

class _RadicalLibraryScreenState extends State<RadicalLibraryScreen> {
  Map<String, dynamic> _radicals = {};
  List<String> _radicalKeys = [];
  List<String> _filteredKeys = [];
  bool _isLoading = true;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadRadicals();
  }

  Future<void> _loadRadicals() async {
    try {
      final radicalString = await rootBundle.loadString('assets/data/radicals.json');
      final radicalData = json.decode(radicalString)['radicals'] as Map<String, dynamic>;
      
      if (mounted) {
        setState(() {
          _radicals = radicalData;
          _radicalKeys = _radicals.keys.toList();
          _filteredKeys = List.from(_radicalKeys);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _filterRadicals(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredKeys = List.from(_radicalKeys);
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredKeys = _radicalKeys.where((key) {
          final data = _radicals[key];
          final name = (data['name'] ?? '').toString().toLowerCase();
          final meaning = (data['meaning'] ?? '').toString().toLowerCase();
          return key.contains(lowerQuery) || name.contains(lowerQuery) || meaning.contains(lowerQuery);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Radicals Index",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                child: Text(
                  "Mastering radicals is the key to unlocking thousands of Hanzi. Select a radical to see all characters that use it.",
                  style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black54, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                child: TextField(
                  onChanged: _filterRadicals,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(
                    hintText: "Search radicals (e.g. Water, 氵)",
                    hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                    prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                    filled: true,
                    fillColor: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
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
                  : _filteredKeys.isEmpty
                      ? const Center(child: Text("No radicals found."))
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: _filteredKeys.length,
                          itemBuilder: (context, index) {
                            final key = _filteredKeys[index];
                            final data = _radicals[key];
                            return _buildRadicalCard(context, key, data, isDark);
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadicalCard(BuildContext context, String character, dynamic data, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RadicalDetailScreen(
              radicalChar: character,
              radicalData: data,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.indigo.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              character,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB22222), // Deep red color for radical
              ),
            ),
            const SizedBox(height: 4),
            Text(
              PinyinHelper.getPinyin(character, separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                data['name'] ?? '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
