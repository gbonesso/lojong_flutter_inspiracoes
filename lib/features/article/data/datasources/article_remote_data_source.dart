import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/models/article_content_model.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/models/article_model.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/models/articles_page_model.dart';

final log = Logger('Logger');

abstract class ArticleRemoteDataSource {
  Future<ArticlesPageModel?> getArticlesPage({required int page});
  Future<ArticleContentModel?> getArticleContent({required int articleId});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio dio;

  ArticleRemoteDataSourceImpl({required this.dio});

  @override
  Future<ArticlesPageModel?> getArticlesPage({required int page}) async {
    ArticlesPageModel? articlesPageModel;
    List<ArticleModel> articlesList = [];

    try {
      final response = await dio.get(
        'https://applojong.com/api/articles2?page=$page',
      );
      log.fine('response: $response');
      log.info('getArticlesPage:response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 304) {
        log.fine('response.data: ${response.data}');
        final rawArticleList = response.data['list'];
        final hasMore = response.data['has_more'];
        final currentPage = response.data['current_page'];
        final lastPage = response.data['last_page'];
        final nextPage = response.data['next_page'];

        for (final item in rawArticleList) {
          log.fine(item);
          final article = ArticleModel.fromJson(item);
          log.fine(article.toJson());
          articlesList.add(article);
        }
        articlesPageModel = ArticlesPageModel(
          hasMore: hasMore,
          currentPage: currentPage,
          lastPage: lastPage,
          nextPage: hasMore ? nextPage : -1,
          articlesList: articlesList,
        );
      } else {
        throw ServerFailure(
            errorMessage: 'status_code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        log.info('Sem conectividade...');
        throw ServerFailure(errorMessage: 'Sem conectividade');
      }
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
      throw ServerFailure(errorMessage: 'Erro: ${e.message}');
    }

    return Future.value(articlesPageModel);
  }

  @override
  Future<ArticleContentModel?> getArticleContent(
      {required int articleId}) async {
    ArticleContentModel? articleContent;

    try {
      final response = await dio.get(
        'https://applojong.com/api/article-content?articleid=$articleId',
      );
      log.fine('getArticleContent: response: $response');
      log.info('getArticleContent:response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 304) {
        log.fine('response.data: ${response.data}');

        articleContent = ArticleContentModel.fromJson(response.data);
        log.fine(articleContent.toJson());
      } else {
        throw ServerFailure(
            errorMessage: 'status_code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        log.info('Sem conectividade...');
        throw ServerFailure(errorMessage: 'Sem conectividade');
      }
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
      throw ServerFailure(errorMessage: 'Erro: ${e.message}');
    }

    return Future.value(articleContent);
  }
}
