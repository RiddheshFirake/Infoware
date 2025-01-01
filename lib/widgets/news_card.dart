import 'package:flutter/material.dart';
import 'package:infoware/models/news_article.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage.isNotEmpty)
            Image.network(article.urlToImage),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.description ?? '',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // You can open the article link in browser
                // Optionally add navigation to the detail screen
              },
              child: Text('Read More'),
            ),
          ),
        ],
      ),
    );
  }
}
