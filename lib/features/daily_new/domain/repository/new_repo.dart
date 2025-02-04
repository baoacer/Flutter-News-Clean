import '../entities/new_entity.dart';

abstract class NewRepository {
  /// Future : Bat dong bo
  /// DataState : Trang thai cua data -> success || error
  Future<List<NewsEntity>> getNew();

  Future<List<NewsEntity>> getSaveNews();

  Future<void> saveNews(NewsEntity newEntity);

  Future<void> removeNews(int newId);
}
