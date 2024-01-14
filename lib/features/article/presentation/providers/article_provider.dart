import 'package:flutter/material.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_content_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/articles_page_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/usecases/get_article_content.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/usecases/get_articles_page.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/datasources/article_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/repositories/article_repository_impl.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';

class ArticleProvider extends ChangeNotifier {
  ArticlesPageEntity? articlesPage;
  List<ArticleEntity> articleList = [];
  bool error = false;
  Failure? failure;
  ArticleContentEntity? articleContent;

  void eitherFailureOrArticlesPage({
    required int page,
  }) async {
    ArticleRepositoryImpl repository = ArticleRepositoryImpl(
      remoteDataSource: ArticleRemoteDataSourceImpl(dio: BaseDio().dio),
      //networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrArticleList = await GetArticlesPage(repository).call(
      page: page,
    );

    failureOrArticleList.fold(
      (newFailure) {
        error = true;
        failure = newFailure;
        notifyListeners();
      },
      (newArticlesPage) {
        error = false;
        failure = null;
        articlesPage = newArticlesPage;
        //articleList.addAll(articlesPage!.articlesList);
        for (final article in articlesPage!.articlesList) {
          log.info(
              'page: ${articlesPage!.currentPage} - id: ${article.id} - ${article.title}');
          if (articleList
              .where((articleInList) => (articleInList.id == article.id))
              .isEmpty) {
            articleList.add(article);
          } else {
            log.info('article already in list...');
          }
        }
        notifyListeners();
      },
    );
  }

  void eitherFailureOrArticleContent({
    required int articleId,
  }) async {
    articleContent = null;
    error = false;
    ArticleRepositoryImpl repository = ArticleRepositoryImpl(
      remoteDataSource: ArticleRemoteDataSourceImpl(dio: BaseDio().dio),
      //networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrArticleContent = await GetArticleContent(repository).call(
      articleId: articleId,
    );

    failureOrArticleContent.fold(
      (newFailure) {
        error = true;
        failure = newFailure;
        notifyListeners();
      },
      (newArticleContent) {
        error = false;
        failure = null;
        articleContent = newArticleContent;
        notifyListeners();
      },
    );
  }
}
