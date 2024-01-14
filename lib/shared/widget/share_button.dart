import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';

final log = Logger('Logger');

class ShareButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  const ShareButton({
    super.key,
    required this.backgroundColor,
    this.textColor = BrandColors.shareButton,
  });

  @override
  Widget build(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;
    log.info('shortestSide: $shortestSide');

    return TextButton.icon(
      style: ButtonStyle(
        //maximumSize: ,
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2)),
      ),
      onPressed: () {
        log.info('Compartilhar...');
      },
      icon: Icon(
        Icons.share,
        color: textColor,
        size: useMobileLayout ? 18 : 25,
      ),
      label: AutoSizeText(
        'Compartilhar',
        style: BrandTextStyles.cardTitle.copyWith(
          color: textColor,
          fontSize: useMobileLayout ? 14 : 20,
        ),
      ),
    );
  }
}
