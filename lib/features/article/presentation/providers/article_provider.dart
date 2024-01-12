import 'package:flutter/material.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/articles_page_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/usecases/get_article_list.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/datasources/article_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/repositories/article_repository_impl.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';

class ArticleProvider extends ChangeNotifier {
  ArticlesPageEntity? articlesPage;

  final baseDioSingleton = BaseDio().dio;

  void eitherFailureOrArticleList({
    required int page,
  }) async {
    ArticleRepositoryImpl repository = ArticleRepositoryImpl(
      remoteDataSource: ArticleRemoteDataSourceImpl(dio: baseDioSingleton),
      //networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrArticleList = await GetArticleList(repository).call(
      page: page,
    );

    failureOrArticleList.fold(
      (newFailure) {
        // pokemon = null;
        // failure = newFailure;
        notifyListeners();
      },
      (newArticlesPage) {
        articlesPage = newArticlesPage;
        // failure = null;
        // pokemonImageProvider.eitherFailureOrPokemonImage(
        //     pokemonEntity: newPokemon);
        notifyListeners();
      },
    );
  }
}
