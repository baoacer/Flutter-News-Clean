import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_local_news_view_model.dart';
import 'package:flutter_news/features/daily_new/presentation/pages/news_details/news_details.dart';
import 'package:provider/provider.dart';

class BookmarkNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LocalNewsViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite News")),
      body: ListView.builder(
        itemCount: viewModel.savedNews.length,
        itemBuilder: (context, index) {
          final news = viewModel.savedNews[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Bo góc ảnh
              child: news.urlToImage != null && news.urlToImage!.isNotEmpty
                  ? Image.network(
                      news.urlToImage!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/error.jpg',
                          width: 80,
                          height: 80),
                    )
                  : Image.asset('assets/images/error.jpg',
                      width: 80, height: 80),
            ),
            title: Text(news.title ?? 'No Title'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => viewModel.removeFromBookmark(news),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(news: news),
                ),
              )
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.loadBookmark(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
