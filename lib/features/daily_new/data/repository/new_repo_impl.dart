import 'package:flutter_news/features/daily_new/data/data_sources/news_api_service.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class NewRepositoryImpl implements NewRepository {
  final NewsApiService _newsApiService;

  NewRepositoryImpl(this._newsApiService);

  @override
  Future<List<NewEntity>> getNew() {
    return _newsApiService.fetchNews();
  }

  @override
  Future<List<NewEntity>> getSaveNews() {
    throw UnimplementedError();
  }

  @override
  Future<void> removeNews(NewEntity newEntity) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveNews(NewEntity newEntity) {
    throw UnimplementedError();
  }
}
