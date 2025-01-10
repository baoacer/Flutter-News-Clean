import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/repository/new_repo.dart';

class GetNewsUseCase {
  final NewRepository _newRepository;

  GetNewsUseCase(this._newRepository);

  @override
  Future<List<NewEntity>> execute({void params}) {
    return _newRepository.getNew();
  }
}
