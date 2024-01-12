import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/models/article_model.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/models/articles_page_model.dart';

final log = Logger('Logger');

abstract class ArticleRemoteDataSource {
  Future<ArticlesPageModel?> getArticlesPage({required int page});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio dio;

  ArticleRemoteDataSourceImpl({required this.dio});

  @override
  Future<ArticlesPageModel?> getArticlesPage({required int page}) async {
    // const userToken =
    //     'O7Kw5E2embxod5YtL1h1YsGNN7FFN8wIxPYMg6J9zFjE6Th9oDssEsFLVhxf';

    ArticlesPageModel? articlesPageModel;
    List<ArticleModel> articlesList = [];

    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) {
    //       // Add the access token to the request header
    //       options.headers['Authorization'] = 'Bearer $userToken';
    //       return handler.next(options);
    //     },
    //     // onError: (DioException e, handler) async {
    //     //   if (e.response?.statusCode == 401) {
    //     //     // If a 401 response is received, refresh the access token
    //     //     //String newAccessToken = await refreshToken();

    //     //     // Update the request header with the new access token
    //     //     //e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

    //     //     // Repeat the request with the updated header
    //     //     //return handler.resolve(await dio.fetch(e.requestOptions));
    //     //     log.info(e);
    //     //   }
    //     //   return handler.next(e);
    //     // },
    //   ),
    // );

    try {
      final response = await dio.get(
        'https://applojong.com/api/articles2?page=$page',
      );
      //log.info('response: ${response}');
      if (response.statusCode == 200) {
        log.info('response.data: ${response.data}');
        final rawArticleList = response.data['list'];
        final hasMore = response.data['has_more'];
        final currentPage = response.data['current_page'];
        final lastPage = response.data['last_page'];
        final nextPage = response.data['next_page'];

        for (final item in rawArticleList) {
          log.info(item);
          final article = ArticleModel.fromJson(item);
          log.info(article.toJson());
          articlesList.add(article);
        }
        articlesPageModel = ArticlesPageModel(
          hasMore: hasMore,
          currentPage: currentPage,
          lastPage: lastPage,
          nextPage: nextPage,
          articlesList: articlesList,
        );
      } else {
        //throw ServerException();
      }
    } on DioException catch (e) {
      log.info(e);
    }

    return Future.value(articlesPageModel);
  }
}
