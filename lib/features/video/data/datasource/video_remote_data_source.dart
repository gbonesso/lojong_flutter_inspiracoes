import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/models/video_model.dart';

final log = Logger('Logger');

abstract class VideoRemoteDataSource {
  Future<List<VideoModel>> getVideoList({required int page});
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final Dio dio;

  VideoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<VideoModel>> getVideoList({required int page}) async {
    List<VideoModel> videoList = [];

    try {
      final response = await dio.get(
        'https://applojong.com/api/videos?page=$page',
      );
      //log.info('response: ${response}');
      if (response.statusCode == 200) {
        log.info('response.data: ${response.data}');
        final rawVideoList = response.data;

        for (final item in rawVideoList) {
          log.info(item);
          final video = VideoModel.fromJson(item);
          log.info(video.toJson());
          videoList.add(video);
        }
      } else {
        //throw ServerException();
      }
    } on DioException catch (e) {
      log.info(e);
    }

    return Future.value(videoList);
  }
}
