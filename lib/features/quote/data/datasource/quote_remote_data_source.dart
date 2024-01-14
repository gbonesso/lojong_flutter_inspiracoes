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
      log.fine('response: $response');
      log.info('getQuotesPage:response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 304) {
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
          nextPage: hasMore ? nextPage : -1,
          quotesList: quotesList,
        );
      } else {
        //throw ServerException();
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log.info(e.response!.data);
        log.info(e.response!.headers);
        log.info(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        log.info(e.requestOptions);
        log.info(e.message);
      }
    }

    return Future.value(quotesPageModel);
  }
}
