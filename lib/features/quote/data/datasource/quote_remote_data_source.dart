import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/models/quote_model.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/models/quotes_page_model.dart';

final log = Logger('Logger');

abstract class QuoteRemoteDataSource {
  Future<QuotesPageModel> getQuotesPage({required int page});
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final Dio dio;

  QuoteRemoteDataSourceImpl({required this.dio});

  @override
  Future<QuotesPageModel> getQuotesPage({required int page}) async {
    List<QuoteModel> quotesList = [];
    QuotesPageModel? quotesPageModel;

    log.info('QuoteRemoteDataSourceImpl::getQuoteList: page $page');

    try {
      final response = await dio.get(
        'https://applojong.com/api/quotes2?page=$page',
      );
      log.info('response: $response');
      if (response.statusCode == 200) {
        log.info('response.data: ${response.data}');
        final rawQuoteList = response.data['list'];
        final hasMore = response.data['has_more'];
        final currentPage = response.data['current_page'];
        final lastPage = response.data['last_page'];
        final nextPage = response.data['next_page'];

        for (final item in rawQuoteList) {
          log.info(item);
          final quote = QuoteModel.fromJson(item);
          log.info(quote.toJson());
          quotesList.add(quote);
        }
        quotesPageModel = QuotesPageModel(
          hasMore: hasMore,
          currentPage: currentPage,
          lastPage: lastPage,
          nextPage: nextPage,
          quotesList: quotesList,
        );
      } else {
        //throw ServerException();
      }
    } on DioException catch (e) {
      log.info(e);
    }

    return Future.value(quotesPageModel);
  }
}
