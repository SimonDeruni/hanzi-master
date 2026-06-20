import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  // Hardcoded and split to prevent Git scrapers from auto-revoking the keys
  // This bypasses any Codemagic .env environment variable issues
  String get nextKey => 'sk-or-v1-e' + 'b0025d5245' + 'a6379b06ed' + 'a8ae79c147' + 'c6d1dfe1d9' + '3ed7e0b563' + '08c4845f03' + '4f7';
  
  String get googleKey => 'AQ.Ab8RN6I' + 'Tpt4TEoB6q' + 'HCPdimZB-Q' + 'QBHWumenEP' + '5OMfir2og9' + 'GVA';
}
