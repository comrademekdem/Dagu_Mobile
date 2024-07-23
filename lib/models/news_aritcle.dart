class NewsArticle {
  final int id; // Ensure this is an integer
  final String title;
  final String author;
  final String description;
  final String url;
  final String urlToImage;
  final bool liked;
  final bool bookmarked; // Add this property

  NewsArticle({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.urlToImage,
    this.liked = false, // Default to false
    this.bookmarked = false,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] as int? ?? 0, // Ensure this is parsed as an integer
      title: json['title'] ?? 'No Title',
      author: json['author'] ?? 'Unknown Author',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      liked: json['liked'] ?? false, // Assign the liked status
      bookmarked: json['bookmarked'] ?? false,
    );
  }
}
