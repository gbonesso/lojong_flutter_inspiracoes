import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/features/video/business/entities/video_entity.dart';
import 'package:lojong_flutter_inspiracoes/shared/vimeo_player_page.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/share_button.dart';

final log = Logger('Logger');

class VideoCard extends StatelessWidget {
  final VideoEntity video;
  const VideoCard({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Nome do vídeo
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                'EP. ${video.order.toString().padLeft(2, '0')}: ${video.name.toUpperCase()}',
                textAlign: TextAlign.center,
                style: BrandTextStyles.cardTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: video.imageUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      // progressIndicatorBuilder:
                      //     (context, url, downloadProgress) =>
                      //         CircularProgressIndicator(
                      //             value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned.fill(
                    child: InkWell(
                      onTap: () {
                        log.info('play vídeo... ${video.url}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VimeoPlayerPage(
                                    videoUrl: video.url,
                                    videoTitle: video.name,
                                  )),
                        );
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/play_video.svg',
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                video.description,
                style: BrandTextStyles.videoCardText,
              ),
            ),
            const ShareButton(
              backgroundColor: Color(0xFFECECEC),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
