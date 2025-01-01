import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infoware/models/news_article.dart';

class ApiService {
  final String apiKey = 'f452e9c8f26749198359f5e0b56e3f32';
  final String baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<NewsArticle>> fetchNewsArticles() async {
    final response = await http.get(
      Uri.parse('$baseUrl?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['articles'];
      return data.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
