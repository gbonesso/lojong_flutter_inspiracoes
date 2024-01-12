import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quotes_page_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/repositories/quote_repository.dart';

class GetQuotesPage {
  final QuoteRepository repository;

  GetQuotesPage(this.repository);

  Future<Either<Failure, QuotesPageEntity>> call({required int page}) async {
    return await repository.getQuotesPage(page: page);
  }
}
