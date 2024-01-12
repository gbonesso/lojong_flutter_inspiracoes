import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quote_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quotes_page_entity.dart';

final log = Logger('Logger');

class QuotesPageModel extends QuotesPageEntity {
  QuotesPageModel({
    required bool hasMore,
    required int currentPage,
    required int lastPage,
    required int nextPage,
    required List<QuoteEntity> quotesList,
  }) : super(
          hasMore: hasMore,
          currentPage: currentPage,
          lastPage: lastPage,
          nextPage: nextPage,
          quotesList: quotesList,
        );

  Map<String, dynamic> toJson() {
    return {
      'hasMore': hasMore,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'nextPage': nextPage,
      //'articlesList': articlesList,
    };
  }
}
