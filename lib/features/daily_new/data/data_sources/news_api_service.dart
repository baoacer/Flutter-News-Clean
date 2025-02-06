import 'package:flutter_news/core/constants/constants.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  String apiUrl = '';

  Future<List<NewsEntity>> fetchNews(String keyword) async {
    if (keyword.isNotEmpty && keyword != " ") {
      apiUrl = "$newApiBaseURL/everything?q=$keyword&apiKey=$apiKey";
    } else {
      apiUrl =
          "$newApiBaseURL/top-headlines?country=$countryQuery&category=$categoryQuery&apiKey=$apiKey";
    }
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['articles'] as List)
          .map((article) => NewsEntity(
                author: article['author'] ?? "",
                title: article['title'],
                description: article['description'] ?? "",
                url: article['url'],
                urlToImage: article['urlToImage'] ?? "",
                publishedAt: article['publishedAt'],
                content: article['content'] ?? "",
              ))
          .toList();
    } else {
      throw Exception("Failed to load news");
    }
  }
}
