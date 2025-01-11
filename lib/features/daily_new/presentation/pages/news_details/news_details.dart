import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';

class NewsDetailPage extends StatelessWidget {
  final NewEntity news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title ?? 'News Detail')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title ?? 'No Title',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              news.urlToImage != null
                  ? Image.network(news.urlToImage!)
                  : const Placeholder(fallbackHeight: 200),
              const SizedBox(height: 16),
              Text(
                news.description ?? 'No Description',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Đảm bảo text content không bị giới hạn
              Text(
                news.content ?? 'No Content',
                style: const TextStyle(fontSize: 14),
                softWrap: true, // Cho phép wrap nội dung
                overflow:
                    TextOverflow.visible, // Đảm bảo nội dung không bị cắt bớt
              ),
            ],
          ),
        ),
      ),
    );
  }
}
