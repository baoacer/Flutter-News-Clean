import 'package:flutter/foundation.dart' show kIsWeb;
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
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  // Đảm bảo Flutter Binding đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // Cấu hình databaseFactory phù hợp với nền tảng (Web hoặc không phải Web)
  databaseFactory = kIsWeb ? databaseFactoryFfiWeb : databaseFactoryFfi;

  // Khởi tạo các dependency
  final appDatabase = DatabaseHelper();
  final newsApiService = NewsApiService();
  final repository = NewsRepositoryImpl(newsApiService, appDatabase);

  // Khởi tạo các use case
  final getNewsUseCase = GetNewsUseCase(repository);
  final saveNewsUseCase = SaveNewsUseCase(repository);
  final getSaveNewsUseCase = GetSaveNewsUseCase(repository);
  final deleteNewsUseCase = DeleteNewsUseCase(repository);
  final openUrlUseCase = OpenUrlUseCase();

  // Khởi chạy ứng dụng với các dependency đã được truyền vào
  runApp(MyApp(
    getNewsUseCase: getNewsUseCase,
    saveNewsUseCase: saveNewsUseCase,
    getSaveNewsUseCase: getSaveNewsUseCase,
    deleteNewsUseCase: deleteNewsUseCase,
    openUrlUseCase: openUrlUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetNewsUseCase getNewsUseCase;
  final SaveNewsUseCase saveNewsUseCase;
  final GetSaveNewsUseCase getSaveNewsUseCase;
  final DeleteNewsUseCase deleteNewsUseCase;
  final OpenUrlUseCase openUrlUseCase;

  const MyApp({
    required this.getNewsUseCase,
    required this.saveNewsUseCase,
    required this.getSaveNewsUseCase,
    required this.deleteNewsUseCase,
    required this.openUrlUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Cung cấp NewsViewModel cho việc lấy tin tức
        ChangeNotifierProvider(
          create: (_) => NewsViewModel(getNewsUseCase),
        ),
        // Cung cấp LocalNewsViewModel cho các thao tác lưu, lấy và xóa tin tức
        ChangeNotifierProvider(
          create: (_) => LocalNewsViewModel(
            saveNewsUseCase,
            getSaveNewsUseCase,
            deleteNewsUseCase,
          ),
        ),
        // Cung cấp NewsDetailViewModel để mở URL tin tức chi tiết
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
