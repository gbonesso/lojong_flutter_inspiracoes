import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/video/business/repositories/video_repository.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/datasource/video_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/models/video_model.dart';

final log = Logger('Logger');

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl({
    required this.remoteDataSource,
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
  Future<Either<Failure, List<VideoModel>>> getVideoList({
    required int page,
  }) async {
    try {
      final videoList = await remoteDataSource.getVideoList(page: page);
      return Right(videoList);
    } on ServerFailure catch (failure) {
      log.info('getVideoList: ServerFailure: ${failure.errorMessage}');
      return Left(failure);
    }
  }
}
