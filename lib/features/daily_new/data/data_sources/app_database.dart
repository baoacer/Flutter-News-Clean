import 'package:flutter_news/features/daily_new/data/data_sources/DAO/new_dao.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper implements NewDao {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Open the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'news.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE news (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            author TEXT,
            title TEXT,
            description TEXT,
            url TEXT,
            urlToImage TEXT,
            publishedAt TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<int> insertNews(NewsEntity news) async {
    final db = await database;
    return await db.insert(
      'news',
      news.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<NewsEntity>> getNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news');
    return List.generate(maps.length, (i) => NewsEntity.fromMap(maps[i]));
  }

  @override
  Future<void> deleteNews(NewsEntity news) async {
    final db = await database;
    await db.delete('news', where: 'title = ?', whereArgs: [news.title]);
  }
}
