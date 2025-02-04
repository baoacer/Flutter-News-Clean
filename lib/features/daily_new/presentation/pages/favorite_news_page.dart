import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/local_news_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteNewsPage extends StatelessWidget {
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
            title: Text(news.title ?? 'No Title'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => viewModel.removeFromBookmark(news.id ?? -1),
            ),
          );
        },
      ),
    );
  }
}
