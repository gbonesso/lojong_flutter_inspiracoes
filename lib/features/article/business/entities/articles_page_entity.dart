import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_entity.dart';

class ArticlesPageEntity {
  final bool hasMore;
  final int currentPage;
  final int lastPage;
  final int nextPage;
  final List<ArticleEntity> articlesList;

  const ArticlesPageEntity({
    required this.hasMore,
    required this.currentPage,
    required this.lastPage,
    required this.nextPage,
    required this.articlesList,
  });
}
