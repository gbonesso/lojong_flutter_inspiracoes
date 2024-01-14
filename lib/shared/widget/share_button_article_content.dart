import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';

final log = Logger('Logger');

class ShareButtonArticleContent extends StatelessWidget {
  const ShareButtonArticleContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(30),
        backgroundColor: BrandColors.inspirationBackGroundDarker,
        //padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      ),
      onPressed: () {
        log.info('Compartilhar...');
      },
      child: const Text(
        'COMPARTILHAR',
        style: BrandTextStyles.unselectedButton,
      ),
    );
  }
}
