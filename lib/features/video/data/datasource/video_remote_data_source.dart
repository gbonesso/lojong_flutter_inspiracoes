import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
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
        //'https://applojong.com/api/videos?page=$page',
        // TODO: Aparentemente sempre a primeira página é enviada.
        'https://applojong.com/api/videos',
      );
      log.fine('getVideoList:response: $response');
      log.info('getVideoList:response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 304) {
        log.info('response.data - page ($page): ${response.data}');
        final rawVideoList = response.data;

        for (final item in rawVideoList) {
          log.info(item);
          final video = VideoModel.fromJson(item);
          log.info(video.toJson());
          videoList.add(video);
        }
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

    return Future.value(videoList);
  }
}
