import 'package:flutter_news/features/daily_new/data/data_sources/app_database.dart';
import 'package:flutter_news/features/daily_new/data/data_sources/news_api_service.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class NewRepositoryImpl implements NewRepository {
  final NewsApiService _newsApiService;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  NewRepositoryImpl(this._newsApiService);

  @override
  Future<List<NewEntity>> getNew() {
    return _newsApiService.fetchNews();
  }

  @override
  Future<List<NewEntity>> getSaveNews() {
    return _databaseHelper.getNews();
  }

  @override
  Future<void> removeNews() {
    return _databaseHelper.deleteNews();
  }

  @override
  Future<void> saveNews(NewEntity news) {
    return _databaseHelper.insertNews(news);
  }
}
