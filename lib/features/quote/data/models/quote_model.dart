import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quote_entity.dart';

final log = Logger('Logger');

class QuoteModel extends QuoteEntity {
  QuoteModel({
    required int id,
    required String text,
    required String author,
    required int order,
    r,
  }) : super(
          id: id,
          text: text,
          author: author,
          order: order,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'],
      text: json['text'] ?? "",
      author: json['author'] ?? "",
      order: json['order'] ?? -1,
    );
  }

  factory QuoteModel.empty() {
    return QuoteModel(
      id: -1,
      text: "",
      author: "",
      order: -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'order': order,
    };
  }
}
