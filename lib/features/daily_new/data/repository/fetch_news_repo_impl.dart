import 'package:flutter_news/features/daily_new/data/data_sources/news_api_service.dart';
import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/fetch_news_repo.dart';

class FetchNewsRepoImpl extends FetchNewsRepo {
  final NewsApiService _newsApiService;

  FetchNewsRepoImpl(this._newsApiService);

  @override
  Future<List<NewsEntity>> fetchNews(String url) {
    return _newsApiService.fetchNews(url);
  }
}
