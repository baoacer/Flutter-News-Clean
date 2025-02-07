import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/news_repo.dart';

class DeleteNewsUseCase {
  final NewsRepository _newRepository;

  DeleteNewsUseCase(this._newRepository);

  Future<void> execute(NewsEntity news) {
    return _newRepository.removeNews(news);
  }
}
