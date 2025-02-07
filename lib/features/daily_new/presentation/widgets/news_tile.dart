import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/entities/news_entity.dart';

class NewsWidget extends StatelessWidget {
  final NewsEntity? newsEntity;

  NewsWidget(this.newsEntity);

  @override
  Widget build(BuildContext context) {
    // Nếu không có dữ liệu, hiển thị thông báo
    if (newsEntity == null) {
      return const Center(child: Text('No Data Available'));
    }

    // Lấy kích thước màn hình để tính toán chiều cao và chiều rộng
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      height: screenWidth / 2.2,
      child: Row(
        children: [
          _buildImage(context, screenWidth),
          _buildTitleAndDescription(),
        ],
      ),
    );
  }

  /// Widget hiển thị hình ảnh của bài báo
  Widget _buildImage(BuildContext context, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: screenWidth / 3,
          height: double.infinity,
          color: Colors.black.withOpacity(0.08),
          child: Image.network(
            (newsEntity?.urlToImage)?.trim() ?? '',
            fit: BoxFit.cover,
            // Hiển thị loader khi đang tải hình ảnh
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const CupertinoActivityIndicator();
            },
            // Hiển thị hình ảnh thay thế khi có lỗi tải hình ảnh
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'images/error.jpg',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Widget hiển thị tiêu đề, mô tả và ngày đăng của bài báo
  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
            Text(
              newsEntity?.title ?? 'No Title',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Comic',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            // Mô tả
            Expanded(
              child: Text(
                newsEntity?.description ?? 'No Description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            // Ngày đăng
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  newsEntity?.publishedAt ?? 'Unknown Date',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
