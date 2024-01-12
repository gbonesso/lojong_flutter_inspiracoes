import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/video/business/repositories/video_repository.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/models/video_model.dart';

class GetVideoList {
  final VideoRepository repository;

  GetVideoList(this.repository);

  Future<Either<Failure, List<VideoModel>>> call({required int page}) async {
    return await repository.getVideoList(page: page);
  }
}
