import 'package:flutter_news/features/daily_new/data/data_sources/app_database.dart';
import 'package:flutter_news/features/daily_new/data/data_sources/news_api_service.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService _newsApiService;
  final DatabaseHelper _databaseHelper;

  NewsRepositoryImpl(this._newsApiService, this._databaseHelper);

  @override
  Future<List<NewsEntity>> getNews(String keyword) {
    return _newsApiService.fetchNews(keyword);
  }

  @override
  Future<List<NewsEntity>> getSaveNews() {
    return _databaseHelper.getNews();
  }

  @override
  Future<void> removeNews(NewsEntity news) {
    return _databaseHelper.deleteNews(news);
  }

  @override
  Future<void> saveNews(NewsEntity news) {
    return _databaseHelper.insertNews(news);
  }
}
