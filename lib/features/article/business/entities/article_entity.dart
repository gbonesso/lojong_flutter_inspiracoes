class ArticleEntity {
  final int id;
  final String text;
  final String title;
  final String imageUrl;
  final String authorName;
  final String url;
  final int premium;
  final int order;
  const ArticleEntity({
    required this.id,
    required this.text,
    required this.title,
    required this.imageUrl,
    required this.authorName,
    required this.url,
    required this.premium,
    required this.order,
  });
}
