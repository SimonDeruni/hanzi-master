import 'package:hanzi_master/features/media/data/repositories/daily_discovery_repository.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = DailyDiscoveryRepository();
  try {
    final result = await repo.getDailyVideo(shownVideoIds: []);
    print("Success! Got video: ${result.item.title}");
    print("URL: ${result.item.url}");
    print("Image URL: ${result.item.imageUrl}");
  } catch (e, stack) {
    print("Error: $e");
    print(stack);
  }
}
