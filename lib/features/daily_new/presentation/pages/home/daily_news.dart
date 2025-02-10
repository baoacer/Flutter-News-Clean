import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_news_view_model.dart';
import 'package:flutter_news/features/daily_new/presentation/pages/bookmark_news_page.dart';
import 'package:flutter_news/features/daily_new/presentation/pages/news_details/news_details.dart';
import 'package:flutter_news/features/daily_new/presentation/widgets/news_tile.dart';
import 'package:provider/provider.dart';

class DailyNews extends StatefulWidget {
  const DailyNews({super.key});

  @override
  _DailyNewsState createState() => _DailyNewsState();
}

class _DailyNewsState extends State<DailyNews> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FetchNewsViewModel>();

    // Lọc danh sách tin tức dựa trên từ khóa tìm kiếm
    final filteredNews = viewModel.news
        .where((news) =>
            news.title?.toLowerCase().contains(searchQuery.toLowerCase()) ??
            false)
        .toList();

    return Scaffold(
      appBar: _buildAppbar(context),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredNews.length,
              itemBuilder: (context, index) {
                final news = filteredNews[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(news: news),
                      ),
                    );
                  },
                  child: NewsWidget(news),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchNews(""),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple[200],
      centerTitle: true,
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        // Search
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            _showSearchDialog(context);
          },
        ),
        // Filter
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            _showFilterDialog(context);
          },
        ),
        // Bookmark
        IconButton(
          icon: const Icon(Icons.bookmark),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookmarkNewsPage()),
            );
          },
        ),
      ],
    );
  }

  // Hộp thoại tìm kiếm API
  void _showSearchDialog(BuildContext context) {
    String searchQuery = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Search News"),
          content: TextField(
            decoration:
                const InputDecoration(hintText: "Enter search keywords..."),
            onChanged: (value) {
              searchQuery = value; // Cập nhật giá trị tìm kiếm
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                if (searchQuery.isNotEmpty) {
                  final viewModel = context.read<FetchNewsViewModel>();
                  await viewModel.fetchNews(searchQuery); // Gọi API với query
                }
              },
              child: const Text("Search"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // Hiển thị hộp thoại lọc
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Search News"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter keywords..."),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng hộp thoại
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
