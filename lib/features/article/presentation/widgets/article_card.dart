import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/pages/article_content_page.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/share_button.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;
  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
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
                style: BrandTextStyles.cardTitle,
                // style: GoogleFonts.asap(
                //   textStyle: TextStyle(
                //     color: Color(0xFF80848F),
                //     fontWeight: FontWeight.w700,
                //     fontSize: 13,
                //   ),
                //),
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
                      Provider.of<ArticleProvider>(context, listen: false)
                          .eitherFailureOrArticleContent(articleId: article.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ArticleContentPage()),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      // progressIndicatorBuilder:
                      //     (context, url, downloadProgress) =>
                      //         CircularProgressIndicator(
                      //             value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  //child: Image.network(article.imageUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                article.text,
                style: BrandTextStyles.articleCardText,
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
