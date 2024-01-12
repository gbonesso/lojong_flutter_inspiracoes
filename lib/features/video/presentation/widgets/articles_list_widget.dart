import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/video/presentation/providers/video_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/video/presentation/widgets/video_card.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class VideoListWidget extends StatelessWidget {
  const VideoListWidget({
    super.key,
  });

  //Color(0xFFE09090)

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(builder: (context, videoProvider, child) {
      if (videoProvider.videoList != null) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      for (final video in videoProvider.videoList!)
                        VideoCard(video: video)
                    ],
                  ),
                ],
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
