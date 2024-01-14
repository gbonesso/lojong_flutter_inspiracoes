import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/no_conectivity_widget.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/share_button_article_content.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class ArticleContentPage extends StatefulWidget {
  final int articleId;
  const ArticleContentPage({
    super.key,
    required this.articleId,
  });

  @override
  State<ArticleContentPage> createState() => _ArticleContentPageState();
}

class _ArticleContentPageState extends State<ArticleContentPage> {
  @override
  void initState() {
    Provider.of<ArticleProvider>(context, listen: false)
        .eitherFailureOrArticleContent(articleId: widget.articleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;
    log.info('shortestSide: $shortestSide');

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
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
                            child:
                                SvgPicture.asset('assets/svg/back_lojong.svg')),
                      ),
                    ),
                    const Expanded(
                      flex: 8,
                      child: Center(),
                    ),
                    const Expanded(flex: 1, child: Center()),
                  ],
                ),
              )),
          Expanded(
            flex: 9,
            child: Container(
              color: BrandColors.inspirationBackGround,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                color: Colors.white,
                child: Consumer<ArticleProvider>(
                    builder: (context, articleProvider, child) {
                  log.info('${articleProvider.articleContent}');
                  if (articleProvider.articleContent == null) {
                    if (articleProvider.error) {
                      if (articleProvider.failure != null) {
                        if (articleProvider.failure!.errorMessage ==
                            "Sem conectividade") {
                          return NoConectivityWidget(onTap: () {
                            setState(() {
                              Provider.of<ArticleProvider>(context,
                                      listen: false)
                                  .eitherFailureOrArticleContent(
                                      articleId: widget.articleId);
                            });
                          });
                        }
                      }
                    }
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
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: articleProvider
                                        .articleContent!.imageUrl,
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
                              child: AutoSizeText(
                                articleProvider.articleContent!.title,
                                textAlign: TextAlign.center,
                                style: BrandTextStyles.cardTitle.copyWith(
                                    fontSize: useMobileLayout ? 20 : 30),
                              ),
                            ),
                            // Texto do artigo
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 15),
                              child: Html(
                                  data:
                                      articleProvider.articleContent!.fullText),
                            ),
                            // Dados do Autor
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: AspectRatio(
                                aspectRatio: useMobileLayout ? 2 / 1 : 6 / 1,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        if (articleProvider.articleContent!
                                            .authorImage.isNotEmpty)
                                          Expanded(
                                            flex: 2,
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                final radius =
                                                    constraints.maxHeight * 0.4;
                                                return Center(
                                                  child: CircleAvatar(
                                                    radius: radius,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                      articleProvider
                                                          .articleContent!
                                                          .authorImage,
                                                    ),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        Expanded(
                                          flex: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: AutoSizeText(
                                                    articleProvider
                                                        .articleContent!
                                                        .authorName,
                                                    textAlign: TextAlign.left,
                                                    style: BrandTextStyles
                                                        .cardTitle
                                                        .copyWith(fontSize: 25),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 8,
                                                    articleProvider
                                                        .articleContent!
                                                        .authorDescription,
                                                    style: BrandTextStyles
                                                        .cardTitle
                                                        .copyWith(fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
          ),
        ]),
      ),
    );
  }
}
