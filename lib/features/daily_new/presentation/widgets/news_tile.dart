import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/features/daily_new/domain/entities/new_entity.dart';

class NewWidget extends StatelessWidget {
  final NewsEntity? newEntity;

  const NewWidget({super.key, this.newEntity});

  @override
  Widget build(BuildContext context) {
    if (newEntity == null) {
      return const Center(child: Text('No Data Available'));
    }
    return Container(
      padding: const EdgeInsetsDirectional.only(
          start: 14, end: 14, top: 10, bottom: 10),
      height: MediaQuery.of(context).size.width / 2.2,
      child: Row(
        children: [
          _buildImage(context),
          _buildTitleAndDescription(),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: Image.network(
            newEntity?.urlToImage ?? '', // URL hình ảnh
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const CupertinoActivityIndicator(); // Hiển thị khi đang tải
            },
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

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Text(
              newEntity?.title ?? 'No Title', // Dùng toán tử ?. để bảo vệ null
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Comic',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  newEntity?.description ??
                      'No Description', // Dùng toán tử ?. để bảo vệ null
                  maxLines: 2,
                ),
              ),
            ),

            // date
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  newEntity?.publishedAt ??
                      'Unknown Date', // Dùng toán tử ?. để bảo vệ null
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
