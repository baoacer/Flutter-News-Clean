import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/fetch_news_repo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService implements FetchNewsRepo {
  @override
  Future<List<NewsEntity>> fetchNews(String url) async {
    final response = await http.get(Uri.parse(url));

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
