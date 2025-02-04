import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_news_view_model.dart';
import 'package:flutter_news/features/daily_new/presentation/pages/favorite_news_page.dart';
import 'package:flutter_news/features/daily_new/presentation/pages/news_details/news_details.dart';
import 'package:flutter_news/features/daily_new/presentation/widgets/news_tile.dart';
import 'package:provider/provider.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   final viewModel = context.watch<NewsViewModel>();

  //   return Scaffold(
  //     appBar: _buildAppbar(),
  //     body: viewModel.isLoading
  //         ? Center(child: CircularProgressIndicator())
  //         : ListView.builder(
  //             itemBuilder: (context, index) {
  //               return NewWidget(
  //                 newEntity: viewModel.news[index],
  //               );
  //             },
  //             itemCount: viewModel.news.length,
  //           ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () => viewModel.fetchNews(),
  //       child: Icon(Icons.refresh),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NewsViewModel>();

    return Scaffold(
      appBar: _buildAppbar(context),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                final news = viewModel.news[index]; // Lấy tin tức hiện tại

                return GestureDetector(
                  onTap: () {
                    // Chuyển hướng tới trang chi tiết bài báo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(news: news),
                      ),
                    );
                  },
                  child: NewWidget(
                    newEntity: news,
                  ),
                );
              },
              itemCount: viewModel.news.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchNews(),
        child: Icon(Icons.refresh),
      ),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple[200],
      centerTitle: true,
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoriteNewsPage()),
          ),
        ),
      ],
    );
  }
}
