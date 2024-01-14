import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/video/presentation/providers/video_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/video/presentation/widgets/video_card.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/error_dialog.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/no_conectivity_widget.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class VideoListWidget extends StatefulWidget {
  const VideoListWidget({
    super.key,
  });

  @override
  State<VideoListWidget> createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  @override
  void initState() {
    Provider.of<VideoProvider>(context, listen: false)
        .eitherFailureOrVideoList(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log.info('_VideoListWidgetState::build...');
    return Consumer<VideoProvider>(builder: (context, videoProvider, child) {
      if (videoProvider.error) {
        if (videoProvider.failure != null) {
          if (videoProvider.failure!.errorMessage == "Sem conectividade") {
            return NoConectivityWidget(onTap: () {
              setState(() {
                Provider.of<VideoProvider>(context, listen: false)
                    .eitherFailureOrVideoList(page: 1);
              });
            });
          }
        }
      }
      if (videoProvider.videoList.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: videoProvider.videoList.length,
                itemBuilder: (context, index) {
                  log.info('video - building index: $index');

                  // Chegando próximo ao final da lista, buscar mais videos
                  if (index == videoProvider.videoList.length - 5) {
                    videoProvider.eitherFailureOrVideoList(
                        page: videoProvider.actualPage + 1);
                  }
                  if (index == videoProvider.videoList.length) {
                    if (videoProvider.error) {
                      return const Center(child: ErrorDialog());
                    } else {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ));
                    }
                  }
                  return VideoCard(
                    video: videoProvider.videoList[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
