import 'package:flutter_news/core/constants/constants.dart';
import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/fetch_news_repo.dart';

class FetchNewsUseCase {
  final FetchNewsRepo _fetchNewsRepo;

  FetchNewsUseCase(this._fetchNewsRepo);

  String apiUrl = '';

  Future<List<NewsEntity>> execute(String keyword) async {
    if (keyword.isNotEmpty && keyword != " ") {
      apiUrl = "$newApiBaseURL/everything?q=$keyword&apiKey=$apiKey";
    } else {
      apiUrl =
          "$newApiBaseURL/top-headlines?country=$countryQuery&category=$categoryQuery&apiKey=$apiKey";
    }
    return _fetchNewsRepo.fetchNews(apiUrl);
  }
}
