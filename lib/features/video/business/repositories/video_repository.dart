import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/models/video_model.dart';

abstract class VideoRepository {
  Future<Either<Failure, List<VideoModel>>> getVideoList({
    required int page,
  });
}
