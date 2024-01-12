import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/articles_page_entity.dart';

abstract class ArticleRepository {
  Future<Either<Failure, ArticlesPageEntity>> getArticlesPage({
    required int page,
  });
}
