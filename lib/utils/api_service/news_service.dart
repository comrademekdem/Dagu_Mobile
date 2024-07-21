// lib/services/news_service.dart
import 'dart:convert';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = APIConstants.apiKey;
  final String baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse('$baseUrl?q=top-headlines&page=1&pageSize=20&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> articlesJson = jsonData['articles'];
      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
