import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/fetch_news_usecase.dart';

class FetchNewsViewModel extends ChangeNotifier {
  final FetchNewsUseCase getNewsUseCase;

  List<NewsEntity> _news = [];
  List<NewsEntity> get news => _news;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FetchNewsViewModel(this.getNewsUseCase);

  Future<void> fetchNews(String keyword) async {
    _isLoading = true;
    notifyListeners();

    try {
      _news = await getNewsUseCase.execute(keyword);
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
