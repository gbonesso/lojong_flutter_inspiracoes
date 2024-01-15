import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/pages/article_content_page.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/share_button.dart';

final log = Logger('Logger');

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;
  final int index;

  const ArticleCard({
    super.key,
    required this.article,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;
    log.fine('shortestSide: $shortestSide');

    return Center(
      child: Card(
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
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Título do artigo
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                article.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: BrandTextStyles.cardTitle.copyWith(
                  fontSize: useMobileLayout ? 13 : 18,
                ),
              ),
            ),
            // Imagem do artigo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      log.info('Artigo selecionado...');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticleContentPage(articleId: article.id),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      //fit: BoxFit.contain,
                      imageUrl: article.imageUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  //child: Image.network(article.imageUrl),
                ),
              ),
            ),
            // Texto do artigo
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                textAlign: TextAlign.center,
                article.text,
                style: BrandTextStyles.articleCardText.copyWith(
                  fontSize: useMobileLayout ? 14 : 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: useMobileLayout ? 30 : 50,
                child: const ShareButton(
                  backgroundColor: Color(0xFFECECEC),
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
