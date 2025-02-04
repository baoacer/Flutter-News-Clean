import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class DeleteNewsUsecase {
  final NewRepository _newRepository;

  DeleteNewsUsecase(this._newRepository);

  Future<void> execute(int newsId) {
    return _newRepository.removeNews(newsId);
  }
}
