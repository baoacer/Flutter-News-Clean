import '../entities/news_entity.dart';
import '../repository/news_repo.dart';

class SaveNewsUseCase {
  final NewsRepository _newRepository;

  SaveNewsUseCase(this._newRepository);

  Future<void> execute(NewsEntity news) {
    return _newRepository.saveNews(news);
  }
}
