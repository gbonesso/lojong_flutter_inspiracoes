import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/video/business/usecases/get_video_list.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/datasource/video_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/models/video_model.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/repositories/video_repository_impl.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';

final log = Logger('Logger');

class VideoProvider extends ChangeNotifier {
  List<VideoModel> videoList = [];
  int actualPage = 1;
  bool error = false;
  Failure? failure;

  void eitherFailureOrVideoList({
    required int page,
  }) async {
    actualPage = page;

    VideoRepositoryImpl repository = VideoRepositoryImpl(
      remoteDataSource: VideoRemoteDataSourceImpl(dio: BaseDio().dio),
      //networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrVideoList = await GetVideoList(repository).call(
      page: page,
    );

    failureOrVideoList.fold(
      (newFailure) {
        log.info(
            'eitherFailureOrVideoList: failure: ${newFailure.errorMessage}');
        error = true;
        failure = newFailure;
        notifyListeners();
      },
      (newVideoList) {
        for (final video in newVideoList) {
          log.info('video: ${video.id}');
          // Check for duplicates
          if (videoList
              .where((videoInList) => (videoInList.id == video.id))
              .isEmpty) {
            videoList.add(video);
          } else {
            log.info('video already in list...');
          }
        }
        //videoList!.addAll(newVideoList);
        notifyListeners();
      },
    );
  }
}
