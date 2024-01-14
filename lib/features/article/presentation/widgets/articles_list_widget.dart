import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/widgets/article_card.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/error_dialog.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/no_conectivity_widget.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class ArticlesListWidget extends StatefulWidget {
  const ArticlesListWidget({
    super.key,
  });

  @override
  State<ArticlesListWidget> createState() => _ArticlesListWidgetState();
}

class _ArticlesListWidgetState extends State<ArticlesListWidget> {
  @override
  void initState() {
    Provider.of<ArticleProvider>(context, listen: false)
        .eitherFailureOrArticlesPage(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
        builder: (context, articleProvider, child) {
      if (articleProvider.error && articleProvider.lastPageRequested == 1) {
        if (articleProvider.failure != null) {
          if (articleProvider.failure!.errorMessage == "Sem conectividade") {
            return NoConectivityWidget(onTap: () {
              setState(() {
                Provider.of<ArticleProvider>(context, listen: false)
                    .eitherFailureOrArticlesPage(page: 1);
              });
            });
          }
        }
      }
      if (articleProvider.articlesPage != null) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: articleProvider.articleList.length +
                    (articleProvider.articlesPage!.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  log.info('articles - building index: $index '
                      'list length: ${articleProvider.articleList.length} '
                      'has_more: ${articleProvider.articlesPage!.hasMore} ');
                  // Chegando próximo ao final da lista, buscar mais artigos
                  if (index == articleProvider.articleList.length - 5) {
                    articleProvider.eitherFailureOrArticlesPage(
                        page: articleProvider.articlesPage!.nextPage);
                  }
                  if (index == articleProvider.articleList.length) {
                    if (articleProvider.error) {
                      return Center(
                        child: ErrorDialog(
                          onTap: () {
                            articleProvider.eitherFailureOrArticlesPage(
                                page: articleProvider.lastPageRequested);
                          },
                        ),
                      );
                    } else {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ));
                    }
                  }
                  return ArticleCard(
                    article: articleProvider.articleList[index],
                    index: index,
                  );
                },
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
