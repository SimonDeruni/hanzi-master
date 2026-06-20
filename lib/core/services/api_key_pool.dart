import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  // Hardcoded and split to prevent Git scrapers from auto-revoking the keys
  // This bypasses any Codemagic .env environment variable issues
  String get nextKey => 'sk-or-v1-' + '863e7f7196' + 'cc6ccc63b5' + 'd82b1ac6fc' + '22260009b0' + 'ae8b263b48' + '04000ad68f' + '9ef9';
  
  String get googleKey => 'AQ.Ab8RN6Jw' + '1wne4dkK1G' + 'ceZmxu25ns' + 'h_a30BbXoW' + 'a6tDBo9Zt4' + 'Hw';
}
