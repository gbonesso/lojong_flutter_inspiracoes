class VideoEntity {
  final int id;
  final String name;
  final String description;
  final String file;
  final String url;
  final String url2;
  final String awsUrl;
  final String image;
  final String imageUrl;
  final int premium;
  final int order;
  const VideoEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.file,
    required this.url,
    required this.url2,
    required this.awsUrl,
    required this.image,
    required this.imageUrl,
    required this.premium,
    required this.order,
  });
}
