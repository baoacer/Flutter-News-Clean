import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class GetSaveNewsUsecase {
  final NewRepository _newRepository;

  GetSaveNewsUsecase(this._newRepository);

  Future<List<NewsEntity>> execute({void params}) {
    return _newRepository.getSaveNews();
  }
}
