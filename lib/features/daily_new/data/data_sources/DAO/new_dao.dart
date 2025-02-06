import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';

abstract class NewDao {
  Future<List<NewsEntity>> getNews();
  Future<void> insertNews(NewsEntity news);
  Future<void> deleteNews(NewsEntity news);
}
