import '../entities/new_entity.dart';

abstract class NewsRepository {
  /// Future : Bat dong bo
  /// DataState : Trang thai cua data -> success || error
  Future<List<NewsEntity>> getNews(String keyword);

  Future<List<NewsEntity>> getSaveNews();

  Future<void> saveNews(NewsEntity news);

  Future<void> removeNews(NewsEntity news);
}
