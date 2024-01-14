import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';

final log = Logger('Logger');

class ShareButtonArticleContent extends StatelessWidget {
  //final Color backgroundColor;
  const ShareButtonArticleContent({
    super.key,
    //required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: BrandColors.inspirationBackGroundDarker,
      ),
      onPressed: () {
        log.info('Compartilhar...');
      },
      child: Text(
        'COMPARTILHAR',
        style: BrandTextStyles.unselectedButton,
      ),
    );
  }
}
