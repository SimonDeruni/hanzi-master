import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

final articleInsightCacheProvider =
    StateProvider<Map<String, ArticleInsight>>((ref) => {});
