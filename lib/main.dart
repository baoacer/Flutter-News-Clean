import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/data/data_sources/app_database.dart';
import 'package:flutter_news/features/daily_new/data/data_sources/news_api_service.dart';
import 'package:flutter_news/features/daily_new/data/repository/new_repo_impl.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/delete_news_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/get_news_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/get_save_news_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/open_url_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/usecases/save_news_usecase.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_news_detail_view_model.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_news_view_model.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_local_news_view_model.dart';
import 'package:flutter_news/features/daily_new/presentation/pages/home/daily_news.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  final appDatabase = DatabaseHelper();
  final newApiService = NewsApiService();
  final repository = NewsRepositoryImpl(newApiService, appDatabase);
  final getNewsUseCase = GetNewsUseCase(repository);
  final saveNewsUsecase = SaveNewsUseCase(repository);
  final getSaveNewsUsecase = GetSaveNewsUseCase(repository);
  final deleteNewsUsecase = DeleteNewsUseCase(repository);
  final openUrlUseCase = OpenUrlUseCase();

  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    MyApp(
      getNewsUseCase: getNewsUseCase,
      saveNewsUsecase: saveNewsUsecase,
      getSaveNewsUsecase: getSaveNewsUsecase,
      deleteNewsUsecase: deleteNewsUsecase,
      openUrlUseCase: openUrlUseCase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetNewsUseCase getNewsUseCase;
  final SaveNewsUseCase saveNewsUsecase;
  final GetSaveNewsUseCase getSaveNewsUsecase;
  final DeleteNewsUseCase deleteNewsUsecase;
  final OpenUrlUseCase openUrlUseCase;

  const MyApp({
    super.key,
    required this.getNewsUseCase,
    required this.saveNewsUsecase,
    required this.getSaveNewsUsecase,
    required this.deleteNewsUsecase,
    required this.openUrlUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsViewModel(getNewsUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => LocalNewsViewModel(
              saveNewsUsecase, getSaveNewsUsecase, deleteNewsUsecase),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsDetailViewModel(openUrlUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DailyNews(),
      ),
    );
  }
}
