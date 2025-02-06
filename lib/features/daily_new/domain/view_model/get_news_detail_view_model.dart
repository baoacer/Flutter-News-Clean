import 'package:flutter/foundation.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/open_url_usecase.dart';

class NewsDetailViewModel extends ChangeNotifier {
  final OpenUrlUseCase openUrlUseCase;

  NewsDetailViewModel(this.openUrlUseCase);

  Future<void> openNewsUrl(String url) async {
    try {
      await openUrlUseCase.execute(url);
    } catch (e) {
      debugPrint("Error opening URL: $e");
    }
  }
}
