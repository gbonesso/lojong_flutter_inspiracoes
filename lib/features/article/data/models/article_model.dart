import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_entity.dart';

final log = Logger('Logger');

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required int id,
    required String text,
    required String title,
    required String imageUrl,
    required String authorName,
    required String url,
    required int premium,
    required int order,
  }) : super(
          id: id,
          text: text,
          title: title,
          imageUrl: imageUrl,
          authorName: authorName,
          url: url,
          premium: premium,
          order: order,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      text: json['text'] ?? "",
      title: json['title'] ?? "",
      imageUrl: json['image_url'] ?? "",
      authorName: json['author_name'] ?? "",
      url: json['url'] ?? "",
      premium: json['premium'] ?? -1,
      order: json['order'] ?? -1,
    );
  }

  factory ArticleModel.empty() {
    return ArticleModel(
      id: -1,
      text: "",
      title: "",
      imageUrl: "",
      authorName: "",
      url: "",
      premium: -1,
      order: -1,
    );
  }

  ArticleModel copyWith({
    int? id,
    String? text,
    String? title,
    String? imageUrl,
    String? authorName,
    String? url,
    int? premium,
    int? order,
  }) {
    return ArticleModel(
      id: id ?? super.id,
      text: text ?? super.text,
      title: title ?? super.title,
      imageUrl: imageUrl ?? super.imageUrl,
      authorName: authorName ?? super.authorName,
      url: url ?? super.url,
      premium: premium ?? super.premium,
      order: order ?? super.order,
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
    };
  }
}
