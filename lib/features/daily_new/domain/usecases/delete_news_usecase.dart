import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class DeleteNewsUsecase {
  final NewRepository _newRepository;

  DeleteNewsUsecase(this._newRepository);

  @override
  Future<void> execute({NewEntity? params}) {
    return _newRepository.removeNews(params!);
  }
}
