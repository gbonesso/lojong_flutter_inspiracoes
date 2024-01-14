import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/share_button_article_content.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class ArticleContentPage extends StatelessWidget {
  const ArticleContentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     //title: Text(widget.title),
        //     ),
        body: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
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
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                  'assets/svg/back_lojong.svg')),
                        ),
                      ),
                      const Expanded(
                        flex: 8,
                        child: Center(),
                      ),
                      const Expanded(flex: 1, child: Center()),
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 9,
            child: Container(
              color: Colors.white,
              child: Consumer<ArticleProvider>(
                  builder: (context, articleProvider, child) {
                log.info('${articleProvider.articleContent}');
                if (articleProvider.articleContent == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  log.info(
                      'authorImage: ${articleProvider.articleContent!.authorImage}');
                  return ListView(
                    children: [
                      // Imagem do artigo
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              elevation: 8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      articleProvider.articleContent!.imageUrl,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          // Título do artigo
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              articleProvider.articleContent!.title,
                              textAlign: TextAlign.center,
                              style: BrandTextStyles.cardTitle
                                  .copyWith(fontSize: 22),
                            ),
                          ),
                          // Texto do artigo
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Html(
                                data: articleProvider.articleContent!.fullText),
                          ),
                          // Dados do Autor
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              child: ListTile(
                                leading: articleProvider
                                        .articleContent!.authorImage.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          articleProvider
                                              .articleContent!.authorImage,
                                        ),
                                        backgroundColor: Colors.transparent,
                                      )
                                    : null,
                                title: Text(
                                  articleProvider.articleContent!.authorName,
                                  style: BrandTextStyles.cardTitle
                                      .copyWith(fontSize: 12),
                                ),
                                subtitle: Text(
                                  articleProvider
                                      .articleContent!.authorDescription,
                                  style: BrandTextStyles.cardTitle
                                      .copyWith(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          // Botão compartilhar
                          const Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: ShareButtonArticleContent(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ]),
      ),
    );
  }
}
