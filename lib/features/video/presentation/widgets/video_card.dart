import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojong_flutter_inspiracoes/features/video/business/entities/video_entity.dart';
import 'package:lojong_flutter_inspiracoes/shared/vimeo_player_page.dart';

final log = Logger('Logger');

class VideoCard extends StatelessWidget {
  final VideoEntity video;
  // final int? index;
  // final bool showButtons;
  // final bool showDivider;
  const VideoCard({
    super.key,
    required this.video,
    // required this.index,
    // required this.showButtons,
    // required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                video.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.asap(
                  textStyle: TextStyle(
                    color: Color(0xFF80848F),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
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
                style: GoogleFonts.asap(
                  textStyle: TextStyle(
                    color: Color(0xFF80848F),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFECECEC)),
              ),
              onPressed: () {
                log.info('Compartilhar...');
              },
              icon: Icon(
                Icons.share,
                color: Color(0xFF80848F),
                size: 18,
              ),
              label: Text(
                'Compartilhar',
                style: GoogleFonts.asap(
                  textStyle: TextStyle(
                    color: Color(0xFF80848F),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
