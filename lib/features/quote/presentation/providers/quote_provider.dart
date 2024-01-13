import 'package:flutter/material.dart';
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

  void eitherFailureOrQuotesPage({
    required int page,
  }) async {
    QuoteRepositoryImpl repository = QuoteRepositoryImpl(
      remoteDataSource: QuoteRemoteDataSourceImpl(dio: BaseDio().dio),
      //networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrQuotesPage = await GetQuotesPage(repository).call(
      page: page,
    );

    failureOrQuotesPage.fold(
      (newFailure) {
        notifyListeners();
      },
      (newQuotesPage) {
        quotesPage = newQuotesPage;
        quoteList.addAll(quotesPage!.quotesList);
        notifyListeners();
      },
    );
  }
}
