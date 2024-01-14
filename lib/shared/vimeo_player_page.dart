import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/no_conectivity_widget.dart';
import 'package:pod_player/pod_player.dart';

final log = Logger('Logger');

class VimeoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  const VimeoPlayerPage({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
  });

  @override
  State<VimeoPlayerPage> createState() => _VimeoPlayerPageState();
}

class _VimeoPlayerPageState extends State<VimeoPlayerPage> {
  late final PodPlayerController controller;
  bool noConnection = false;

  @override
  void initState() {
    final videoId = widget.videoUrl.split('/').last;
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeo(videoId),
    )..initialise();
    checkConnection();
    super.initState();
  }

  void checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    noConnection = (connectivityResult == ConnectivityResult.none);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.zero,
                color: BrandColors.inspirationBackGround,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              onTap: () {
                                controller.pause();
                                //controller.dispose();
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                  'assets/svg/back_lojong.svg')),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text(
                          widget.videoTitle,
                          textAlign: TextAlign.center,
                          style: BrandTextStyles.unselectedButton
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      const Expanded(flex: 1, child: Center()),
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 9,
            child: noConnection
                ? NoConectivityWidget(onTap: () {
                    checkConnection();
                  })
                : Container(
                    margin: EdgeInsets.zero,
                    color: BrandColors.inspirationBackGround,
                    child: PodVideoPlayer(
                      controller: controller,
                      //videoAspectRatio: 9 / 16,
                      matchVideoAspectRatioToFrame: true,
                      matchFrameAspectRatioToVideo: true,
                    ),
                  ),
          ),
        ]),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  @override
  void dispose() {
    log.info('_VimeoPlayerPageState::dispose...');
    controller.dispose();
    super.dispose();
  }
}
