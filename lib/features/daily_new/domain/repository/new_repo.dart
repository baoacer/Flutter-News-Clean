import '../entities/new_entity.dart';

abstract class NewRepository {
  /// Future : Bat dong bo
  /// DataState : Trang thai cua data -> success || error
  Future<List<NewEntity>> getNew();

  Future<List<NewEntity>> getSaveNews();

  Future<void> saveNews(NewEntity newEntity);

  Future<void> removeNews();
}
