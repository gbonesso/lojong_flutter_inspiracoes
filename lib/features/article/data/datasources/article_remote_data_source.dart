import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
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
        //throw ServerException();
      }
    } on DioException catch (e) {
      log.info(e);
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
        //throw ServerException();
      }
    } on DioException catch (e) {
      log.info(e);
    }

    return Future.value(articleContent);
  }
}
