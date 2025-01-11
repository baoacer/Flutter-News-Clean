import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';

abstract class NewDao {
  Future<List<NewEntity>> getNews();
  Future<void> insertNews(NewEntity news);
  Future<void> deleteNews();
}
