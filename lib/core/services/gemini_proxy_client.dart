import 'package:http/http.dart' as http;

/// A custom HTTP client that intercepts requests made by the google_generative_ai SDK
/// and redirects them to our secure Firebase Cloud Function proxy.
class GeminiProxyClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final String proxyUrl;

  GeminiProxyClient({required this.proxyUrl});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (request.url.host.contains('generativelanguage.googleapis.com')) {
      // Rewrite the URL to point to our proxy
      final newUrl = Uri.parse(proxyUrl);
      
      // We must copy the request since BaseRequest is single-use and its URL is final.
      final proxyRequest = http.Request(request.method, newUrl);
      proxyRequest.headers.addAll(request.headers);
      
      // If it's a Request (has body), copy the body
      if (request is http.Request) {
        proxyRequest.bodyBytes = request.bodyBytes;
      }
      
      return _inner.send(proxyRequest);
    }
    
    // Pass through any other requests normally (shouldn't happen with the SDK)
    return _inner.send(request);
  }
}
