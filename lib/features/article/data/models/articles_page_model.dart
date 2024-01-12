import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/articles_page_entity.dart';

final log = Logger('Logger');

class ArticlesPageModel extends ArticlesPageEntity {
  ArticlesPageModel({
    required bool hasMore,
    required int currentPage,
    required int lastPage,
    required int nextPage,
    required List<ArticleEntity> articlesList,
  }) : super(
          hasMore: hasMore,
          currentPage: currentPage,
          lastPage: lastPage,
          nextPage: nextPage,
          articlesList: articlesList,
        );

  Map<String, dynamic> toJson() {
    return {
      'hasMore': hasMore,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'nextPage': nextPage,
      //'articlesList': articlesList,
    };
  }
}
