import 'package:flutter/foundation.dart';
import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/delete_news_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/get_save_news_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/save_news_usecase.dart';

class LocalNewsViewModel extends ChangeNotifier {
  final SaveNewsUseCase saveNewsUsecase;
  final GetSaveNewsUseCase getSaveNewsUsecase;
  final DeleteNewsUseCase deleteNewsUsecase;

  LocalNewsViewModel(
      this.saveNewsUsecase, this.getSaveNewsUsecase, this.deleteNewsUsecase);

  List<NewsEntity> savedNews = [];

  Future<void> addToBookmark(NewsEntity news) async {
    await saveNewsUsecase.execute(news);
    await loadBookmark();
  }

  Future<void> removeFromBookmark(NewsEntity news) async {
    await deleteNewsUsecase.execute(news);
    await loadBookmark();
  }

  Future<void> loadBookmark() async {
    savedNews = await getSaveNewsUsecase.execute();
    notifyListeners();
  }
}
