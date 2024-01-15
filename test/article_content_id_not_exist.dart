//import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/datasources/article_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio_test.dart';

final log = Logger('Logger');

void main() {
  // Logger.root.level = Level.ALL; // defaults to Level.INFO
  // Logger.root.onRecord.listen((LogRecord rec) {
  //   debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  // });

  test('Article data source - ArticleContent - Invalid ID', () async {
    final articleRemoteDataSource =
        ArticleRemoteDataSourceImpl(dio: BaseDioTest().dio);

    // Quando o id do artigo for inválido a implementação do Datasource
    // vai lançar uma exceção.
    expect(() => articleRemoteDataSource.getArticleContent(articleId: -1),
        throwsA(isA<ServerFailure>()));
  });
}
