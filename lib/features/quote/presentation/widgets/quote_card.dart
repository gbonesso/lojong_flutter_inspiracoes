import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quote_entity.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:lojong_flutter_inspiracoes/shared/widget/share_button.dart';

final log = Logger('Logger');

class QuoteCard extends StatelessWidget {
  final QuoteEntity quote;
  final int index;
  const QuoteCard({
    super.key,
    required this.quote,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;
    log.info('shortestSide: $shortestSide');

    const gradient0 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF8DC1E9),
        Color(0xFFFFFFFF),
      ],
    );
    const gradient1 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFE8D5A2),
        Color(0xFFF3B093),
      ],
    );
    const gradient2 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(0xff, 237, 154, 133),
        Color.fromARGB(0xff, 190, 101, 127),
      ],
    );

    final gradientToUse = [gradient0, gradient1, gradient2];
    final imageToUse = [
      const svg.Svg('assets/svg/mountains-5223649.svg'),
      const svg.Svg('assets/svg/lotus-4776450.svg'),
      const svg.Svg('assets/svg/buddhism-146177.svg'),
    ];
    final fontStyleToUse = [
      BrandTextStyles.quoteText0,
      BrandTextStyles.quoteText1,
      BrandTextStyles.quoteText2,
    ];
    final backgroundColorShareButton = [
      const Color(0xFF4067AB),
      const Color.fromARGB(0xFF, 176, 124, 103),
      const Color.fromARGB(0xff, 133, 73, 90),
    ];

    return Center(
      child: Container(
        color: BrandColors.inspirationBackGround,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: index == 0
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )
              : const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: gradientToUse[index % 3],
                      image: DecorationImage(
                        //scale: 0.8,
                        //fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.1), BlendMode.dstIn),
                        image: imageToUse[index % 3],
                      ),
                    ),
                    child: Column(children: [
                      // Texto
                      Expanded(
                        flex: 75,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AutoSizeText(
                              quote.text,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: fontStyleToUse[index % 3]
                                  .copyWith(fontSize: 30),
                            ),
                          ),
                        ),
                      ),

                      // Autor
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: AutoSizeText(
                            quote.author,
                            minFontSize: 10,
                            textAlign: TextAlign.center,
                            style: fontStyleToUse[index % 3]
                                .copyWith(fontSize: 25),
                          ),
                        ),
                      ),
                      // Botão para compartilhar
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          height: useMobileLayout ? 30 : 50,
                          child: ShareButton(
                            backgroundColor:
                                backgroundColorShareButton[index % 3],
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
//      ),
    );
  }
}
