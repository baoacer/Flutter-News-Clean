import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/get_news_usecase.dart';

class NewsViewModel extends ChangeNotifier {
  final GetNewsUseCase getNewsUseCase;

  List<NewsEntity> _news = [];
  List<NewsEntity> get news => _news;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  NewsViewModel(this.getNewsUseCase);

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      _news = await getNewsUseCase.execute();
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
