import 'package:flutter/material.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quote_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quotes_page_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/usecases/get_quotes_page.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/datasource/quote_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/repositories/quote_repository_impl.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';

class QuoteProvider extends ChangeNotifier {
  QuotesPageEntity? quotesPage;
  List<QuoteEntity> quoteList = [];
  bool error = false;
  Failure? failure;
  int lastPageRequested = 1;

  void eitherFailureOrQuotesPage({
    required int page,
  }) async {
    lastPageRequested = page;
    QuoteRepositoryImpl repository = QuoteRepositoryImpl(
      remoteDataSource: QuoteRemoteDataSourceImpl(dio: BaseDio().dio),
    );

    final failureOrQuotesPage = await GetQuotesPage(repository).call(
      page: page,
    );

    failureOrQuotesPage.fold(
      (newFailure) {
        error = true;
        failure = newFailure;
        notifyListeners();
      },
      (newQuotesPage) {
        error = false;
        failure = null;
        quotesPage = newQuotesPage;
        for (final quote in quotesPage!.quotesList) {
          log.info('quote: ${quotesPage!.currentPage} - ${quote.id}');
          // Check for duplicates
          if (quoteList
              .where((quoteInList) => (quoteInList.id == quote.id))
              .isEmpty) {
            quoteList.add(quote);
          } else {
            log.info('quote already in list...');
          }
        }

        notifyListeners();
      },
    );
  }
}
