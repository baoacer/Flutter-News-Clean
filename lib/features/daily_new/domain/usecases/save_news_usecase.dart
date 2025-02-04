import '../entities/new_entity.dart';
import '../repository/new_repo.dart';

class SaveNewsUsecase {
  final NewRepository _newRepository;

  SaveNewsUsecase(this._newRepository);

  Future<void> execute(NewsEntity news) {
    return _newRepository.saveNews(news);
  }
}
