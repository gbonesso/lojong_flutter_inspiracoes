class ArticleContentEntity {
  final int id;
  final String text;
  final String title;
  final String imageUrl;
  final String authorName;
  final String url;
  final int premium;
  final int order;
  final String fullText;
  final String authorImage;
  final String authorDescription;
  final String image;
  const ArticleContentEntity({
    required this.id,
    required this.text,
    required this.title,
    required this.imageUrl,
    required this.authorName,
    required this.url,
    required this.premium,
    required this.order,
    required this.fullText,
    required this.authorImage,
    required this.authorDescription,
    required this.image,
  });
}
