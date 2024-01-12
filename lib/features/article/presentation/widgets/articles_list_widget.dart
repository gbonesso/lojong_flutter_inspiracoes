import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/widgets/article_card.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class ArticlesListWidget extends StatelessWidget {
  //final UserProfileModel userProfile;
  const ArticlesListWidget({
    super.key,
    //required this.userProfile,
  });

  //Color(0xFFE09090)

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
        builder: (context, articleProvider, child) {
      if (articleProvider.articlesPage != null) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      for (final article
                          in articleProvider.articlesPage!.articlesList)
                        ArticleCard(
                          article: article,
                        )
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
