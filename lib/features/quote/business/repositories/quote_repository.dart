import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quotes_page_entity.dart';

abstract class QuoteRepository {
  Future<Either<Failure, QuotesPageEntity>> getQuotesPage({
    required int page,
  });
}
