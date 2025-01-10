import '../entities/new_entity.dart';
import '../repository/new_repo.dart';

class SaveNewsUsecase {
  final NewRepository _newRepository;

  SaveNewsUsecase(this._newRepository);

  @override
  Future<void> execute({NewEntity? params}) {
    return _newRepository.saveNews(params!);
  }
}
