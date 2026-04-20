import 'dart:convert';
import 'dart:io';

class CatalogApi {
  const CatalogApi({
    this.baseUrl = 'https://wantapi.com',
  });

  final String baseUrl;

  Uri _uri(String path) => Uri.parse(baseUrl).resolve(path);

  Future<List<Map<String, dynamic>>> fetchProductsRaw() async {
    final uri = _uri('/products.php');

    final client = HttpClient();
    try {
      final request = await client.getUrl(uri);
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');
      final response = await request.close();

      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpException('HTTP ${response.statusCode}: $body', uri: uri);
      }

      final decoded = jsonDecode(body);
      if (decoded is List) {
        return decoded.whereType<Map>().map((e) => e.cast<String, dynamic>()).toList();
      }
      if (decoded is Map && decoded['products'] is List) {
        return (decoded['products'] as List)
            .whereType<Map>()
            .map((e) => e.cast<String, dynamic>())
            .toList();
      }
      throw const FormatException('Unexpected JSON shape');
    } finally {
      client.close(force: true);
    }
  }
}

