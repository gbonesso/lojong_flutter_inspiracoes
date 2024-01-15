import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/datasource/quote_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/models/quote_model.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio_test.dart';

final log = Logger('Logger');

void main() {
  // Logger.root.level = Level.ALL; // defaults to Level.INFO
  // Logger.root.onRecord.listen((LogRecord rec) {
  //   debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  // });

  test('Quote data source', () async {
    final quoteRemoteDataSource =
        QuoteRemoteDataSourceImpl(dio: BaseDioTest().dio);

    // Primeira página de citações...
    final quotesPage1 = await quoteRemoteDataSource.getQuotesPage(page: 1);
    expect(quotesPage1.quotesList.length, 15);
    expect(quotesPage1.toJson(),
        {'hasMore': true, 'currentPage': 1, 'lastPage': 32, 'nextPage': 2});

    // Primeira citação da primeira página
    QuoteModel quoteModel = quotesPage1.quotesList[0] as QuoteModel;

    expect(quoteModel.toJson(), {
      'id': 60,
      'text':
          '"Por que você precisa meditar? Porque se você não praticar, eu te garanto que sua mente vai brincar com você, feliz e depois triste, animada e desanimada, mal humorada e depressiva, e depois excitada e sem controle, apenas seguindo o que sente. A meditação o ajuda a encontrar equilíbrio em sua vida. Por favor, entenda que equilíbrio vem de dentro, do relacionamento com sua própria mente, não tem nada a ver com o que acontece do lado de fora."',
      'author': 'Phakchok Rinpoche',
      'order': 1
    });

    // Última página de citações...
    final lastQuotesPage = await quoteRemoteDataSource.getQuotesPage(page: 32);
    expect(lastQuotesPage.quotesList.length, 4);
    expect(lastQuotesPage.toJson(),
        {'hasMore': false, 'currentPage': 32, 'lastPage': 32, 'nextPage': -1});

    // Última citação da última página
    quoteModel = lastQuotesPage.quotesList[lastQuotesPage.quotesList.length - 1]
        as QuoteModel;

    expect(quoteModel.toJson(), {
      'id': 2370,
      'text':
          '“O estresse é causado por estar ‘aqui’, mas querer estar ‘lá’, ou estar no presente, mas querer estar no futuro.”',
      'author': 'Eckhart Tolle',
      'order': 469
    });
  });
}
