// lib/models/news_article.dart
class NewsArticle {
  final String title;
  final String author;
  final String description;
  final String url;
  final String urlToImage;

  NewsArticle({
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      author: json['author'] ?? 'Unknown Author',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150', // Default image if none provided
    );
  }
}
