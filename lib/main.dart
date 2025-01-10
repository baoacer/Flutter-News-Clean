import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/data/data_sources/news_api_service.dart';
import 'package:flutter_news/features/daily_new/data/repository/new_repo_impl.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/get_news_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_news_view_model.dart';
import 'package:flutter_news/features/daily_new/presentation/pages/home/daily_news.dart';
import 'package:provider/provider.dart';

void main() {
  final newApiService = NewsApiService();
  final repository = NewRepositoryImpl(newApiService);
  final getNewsUseCase = GetNewsUseCase(repository);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(getNewsUseCase));
}

class MyApp extends StatelessWidget {
  final GetNewsUseCase getNewsUseCase;

  const MyApp(this.getNewsUseCase, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsViewModel(getNewsUseCase),
        ),
      ],
      child: MaterialApp(
        home: DailyNews(),
      ),
    );
  }
}
