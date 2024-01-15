import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/datasources/article_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio_test.dart';

final log = Logger('Logger');

void main() {
  // Logger.root.level = Level.ALL; // defaults to Level.INFO
  // Logger.root.onRecord.listen((LogRecord rec) {
  //   debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  // });

  test('Article data source', () async {
    final articleRemoteDataSource =
        ArticleRemoteDataSourceImpl(dio: BaseDioTest().dio);

    debugPrint('getArticlesPage(page: 1)...');
    // Primeira página de artigos...
    final articlesPage1 =
        await articleRemoteDataSource.getArticlesPage(page: 1);
    //log.info(articlesPage1!.toJson());
    expect(articlesPage1!.articlesList.length, 15);
    expect(articlesPage1.toJson(),
        {'hasMore': true, 'currentPage': 1, 'lastPage': 5, 'nextPage': 2});

    debugPrint('getArticlesPage(page: 5)...');
    // A última página é a cinco e tem 11 artigos
    final articlesLast = await articleRemoteDataSource.getArticlesPage(page: 5);
    expect(articlesLast!.articlesList.length, 11);
    expect(articlesLast.toJson(),
        {'hasMore': false, 'currentPage': 5, 'lastPage': 5, 'nextPage': -1});

    // Conteúdo de um artigo
    final article5 =
        await articleRemoteDataSource.getArticleContent(articleId: 5);
    log.info('\n\n\n${article5!.toJson()}');
    // expect(article5.toJson(),
    //     {'id': 5, 'currentPage': 500, 'lastPage': 5, 'nextPage': -1});
    expect(article5.id, 5);
    expect(article5.text,
        'Falamos muito da possibilidade de mudança. Como isso acontece no contexto da formação contemplativa?');
    expect(article5.title, 'A libertação dos pensamentos');
    expect(article5.imageUrl,
        'https://d2g3qjbxchhsv1.cloudfront.net/images/artigos/iamgeartigo2.jpg');
    expect(article5.authorName, 'Matthieu Ricard');
    expect(article5.url,
        'https://lojongapp.com/blog/article/5/a-libertacao-dos-pensamentos');
    expect(article5.premium, 0);
    expect(article5.order, 2);
    expect(article5.fullText.length, 5827);
    expect(article5.authorDescription.length, 211);
    expect(article5.authorImage, '');
    expect(article5.image,
        'https://d2g3qjbxchhsv1.cloudfront.net/images/artigos/iamgeartigo2.jpg');
  });
}
