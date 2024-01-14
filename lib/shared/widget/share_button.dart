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
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      onPressed: () {
        log.info('Compartilhar...');
      },
      icon: Icon(
        Icons.share,
        color: textColor,
        size: 18,
      ),
      label: Text(
        'Compartilhar',
        style: BrandTextStyles.cardTitle.copyWith(color: textColor),
      ),
    );
  }
}
