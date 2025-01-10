import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/view_model/get_news_view_model.dart';
import 'package:flutter_news/features/daily_new/presentation/widgets/news_tile.dart';
import 'package:provider/provider.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NewsViewModel>();

    return Scaffold(
      appBar: _buildAppbar(),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                return NewWidget(
                  newEntity: viewModel.news[index],
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

  //  ListView.builder(

  //             itemCount: viewModel.news.length,
  //             itemBuilder: (context, index) {
  //               final NewEntity article = viewModel.news[index];
  //               return ListTile(
  //                 title: Text(article.title!),
  //                 subtitle: Text(article.description!),
  //               );
  //             },
  //           ),

  _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.deepPurple[200],
      centerTitle: true,
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
