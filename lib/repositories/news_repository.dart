import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infoware/models/news.dart';

class NewsRepository {
  final String apiUrl;
  final String apiKey;

  NewsRepository({
    required this.apiUrl,
    required this.apiKey,
  });

  // Fetch news without search query (default method)
  Future<List<News>> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl?apiKey=$apiKey&country=us&category=technology'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List articles = data['articles'];

        return articles
            .map((article) => News.fromJson(article as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  // Fetch news based on search query
  Future<List<News>> searchNews(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl?apiKey=$apiKey&q=$query&country=us&category=technology'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List articles = data['articles'];

        return articles
            .map((article) => News.fromJson(article as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
