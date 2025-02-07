import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/news_repo.dart';

class GetSaveNewsUseCase {
  final NewsRepository _newRepository;

  GetSaveNewsUseCase(this._newRepository);

  Future<List<NewsEntity>> execute({void params}) {
    return _newRepository.getSaveNews();
  }
}
