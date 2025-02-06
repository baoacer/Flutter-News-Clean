import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class GetNewsUseCase {
  final NewsRepository _newRepository;

  GetNewsUseCase(this._newRepository);

  Future<List<NewsEntity>> execute(String keyword) {
    return _newRepository.getNews(keyword);
  }
}
