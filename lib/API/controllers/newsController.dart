import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiController {
  final String _baseUrl = 'https://newsapi.org/v2/everything';
  final String _apiKey = '63698bc82a554698948e6d1129a78ed0';

  Future<Map<String, dynamic>> fetchNews({
    String query = 'tesla', // Default search query
    String fromDate = '2024-07-29', // Default date
    String sortBy = 'publishedAt', // Default sort order
  }) async {
    final url = '$_baseUrl?q=$query&from=$fromDate&sortBy=$sortBy&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.body); // For debugging purposes
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
