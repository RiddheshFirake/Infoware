class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'],
    );
  }
}

// models/news.dart
class News {
  final String title;
  final String description;
  final String url;
  final String imageUrl;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
  });

  // A method to convert JSON into a News object
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
    );
  }
}


