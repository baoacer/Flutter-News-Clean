import '../entities/news_entity.dart';

abstract class FetchNewsRepo {
  Future<List<NewsEntity>> fetchNews(String keyword);
}
