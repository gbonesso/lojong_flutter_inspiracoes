import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quote_entity.dart';

class QuotesPageEntity {
  final bool hasMore;
  final int currentPage;
  final int lastPage;
  final int nextPage;
  final List<QuoteEntity> quotesList;

  const QuotesPageEntity({
    required this.hasMore,
    required this.currentPage,
    required this.lastPage,
    required this.nextPage,
    required this.quotesList,
  });
}
