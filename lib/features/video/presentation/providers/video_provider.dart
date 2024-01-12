import 'package:flutter/material.dart';
import 'package:lojong_flutter_inspiracoes/features/video/business/usecases/get_video_list.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/datasource/video_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/models/video_model.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/repositories/video_repository_impl.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';

class VideoProvider extends ChangeNotifier {
  List<VideoModel>? videoList;

  void eitherFailureOrVideoList({
    required int page,
  }) async {
    VideoRepositoryImpl repository = VideoRepositoryImpl(
      remoteDataSource: VideoRemoteDataSourceImpl(dio: BaseDio().dio),
      //networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrVideoList = await GetVideoList(repository).call(
      page: page,
    );

    failureOrVideoList.fold(
      (newFailure) {
        notifyListeners();
      },
      (newVideoList) {
        videoList = newVideoList;
        notifyListeners();
      },
    );
  }
}
