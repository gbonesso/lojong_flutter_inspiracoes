import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/video/business/entities/video_entity.dart';

final log = Logger('Logger');

class VideoModel extends VideoEntity {
  VideoModel({
    required int id,
    required String name,
    required String description,
    required String file,
    required String url,
    required String url2,
    required String awsUrl,
    required String image,
    required String imageUrl,
    required int premium,
    required int order,
  }) : super(
          id: id,
          name: name,
          description: description,
          file: file,
          url: url,
          url2: url2,
          awsUrl: awsUrl,
          image: image,
          imageUrl: imageUrl,
          premium: premium,
          order: order,
        );

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      file: json['file'] ?? "",
      url: json['url'] ?? "",
      url2: json['url2'] ?? "",
      awsUrl: json['aws_url'] ?? "",
      image: json['image'] ?? "",
      imageUrl: json['image_url'] ?? "",
      premium: json['premium'] ?? -1,
      order: json['order'] ?? -1,
    );
  }

  factory VideoModel.empty() {
    return VideoModel(
      id: -1,
      name: "",
      description: "",
      file: "",
      url: "",
      url2: "",
      awsUrl: "",
      image: "",
      imageUrl: "",
      premium: -1,
      order: -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'file': file,
      'url': url,
      'url2': url2,
      'awsUrl': awsUrl,
      'image': image,
      'imageUrl': imageUrl,
      'premium': premium,
      'order': order,
    };
  }
}
