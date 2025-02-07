import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_local_news_view_model.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_news_detail_view_model.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsEntity news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LocalNewsViewModel>();
    final viewModelDetails = context.watch<NewsDetailViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title ?? 'News Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () => viewModel.addToBookmark(news),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title ?? 'No Title',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  news.urlToImage != null
                      ? Image.network(news.urlToImage!.trim())
                      : const Placeholder(fallbackHeight: 200),
                  const SizedBox(height: 16),
                  Text(
                    news.description ?? 'No Description',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    news.content ?? 'No Content',
                    style: const TextStyle(fontSize: 14),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ),
          // Button "More" ở dưới cùng
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => viewModelDetails.openNewsUrl(news.url ?? ''),
                child: const Text('More'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
