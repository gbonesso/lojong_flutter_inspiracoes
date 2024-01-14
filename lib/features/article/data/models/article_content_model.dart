import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_content_entity.dart';

final log = Logger('Logger');

class ArticleContentModel extends ArticleContentEntity {
  ArticleContentModel({
    required int id,
    required String text,
    required String title,
    required String imageUrl,
    required String authorName,
    required String url,
    required int premium,
    required int order,
    required String fullText,
    required String authorImage,
    required String authorDescription,
    required String image,
  }) : super(
          id: id,
          text: text,
          title: title,
          imageUrl: imageUrl,
          authorName: authorName,
          url: url,
          premium: premium,
          order: order,
          fullText: fullText,
          authorImage: authorImage,
          authorDescription: authorDescription,
          image: image,
        );

  factory ArticleContentModel.fromJson(Map<String, dynamic> json) {
    return ArticleContentModel(
      id: json['id'],
      text: json['text'] ?? "",
      title: json['title'] ?? "",
      imageUrl: json['image_url'] ?? "",
      authorName: json['author_name'] ?? "",
      url: json['url'] ?? "",
      premium: json['premium'] ?? -1,
      order: json['order'] ?? -1,
      fullText: json['full_text'] ?? "",
      authorImage: json['author_image'] ?? "",
      authorDescription: json['author_description'] ?? "",
      image: json['image'] ?? "",
    );
  }

  factory ArticleContentModel.empty() {
    return ArticleContentModel(
      id: -1,
      text: "",
      title: "",
      imageUrl: "",
      authorName: "",
      url: "",
      premium: -1,
      order: -1,
      fullText: "",
      authorImage: "",
      authorDescription: "",
      image: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'title': title,
      'imageUrl': imageUrl,
      'authorName': authorName,
      'url': url,
      'premium': premium,
      'order': order,
      'fullText': fullText,
      'authorImage': authorImage,
      'authorDescription': authorDescription,
      'image': image,
    };
  }
}
