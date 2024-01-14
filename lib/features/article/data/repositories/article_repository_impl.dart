import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_content_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/articles_page_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/repositories/article_repository.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/datasources/article_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  //final PokemonLocalDataSource localDataSource;

  //final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    //required this.localDataSource,
    //required this.networkInfo,
  });

  // Either is implemented in the dartz package
  // @override
  // Future<Either<Failure, PokemonModel>> getPokemon(
  //     {required PokemonParams params}) async {
  //   if (await networkInfo.isConnected!) {
  //     try {
  //       final remotePokemon = await remoteDataSource.getPokemon(params: params);

  //       localDataSource.cachePokemon(remotePokemon);
  //       // Return the Right side of the Either (PokemonModel)
  //       return Right(remotePokemon);
  //     } on ServerException {
  //       // Return the left side of the Either (Failure)
  //       return Left(ServerFailure(errorMessage: 'This is a server exception'));
  //     }
  //   } else {
  //     try {
  //       final localPokemon = await localDataSource.getLastPokemon();
  //       return Right(localPokemon);
  //     } on CacheException {
  //       return Left(CacheFailure(errorMessage: 'No local data found'));
  //     }
  //   }
  // }

  @override
  Future<Either<Failure, ArticlesPageEntity>> getArticlesPage({
    required int page,
  }) async {
    final articlesPage = await remoteDataSource.getArticlesPage(page: page);
    return Right(articlesPage as ArticlesPageEntity);
    //return Left(ServerFailure(errorMessage: 'This is a server exception'));
  }

  @override
  Future<Either<Failure, ArticleContentEntity>> getArticleContent(
      {required int articleId}) async {
    final articleContent =
        await remoteDataSource.getArticleContent(articleId: articleId);
    return Right(articleContent as ArticleContentEntity);
  }
}
