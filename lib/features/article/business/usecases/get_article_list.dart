import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/articles_page_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/repositories/article_repository.dart';

class GetArticleList {
  final ArticleRepository repository;

  GetArticleList(this.repository);

  Future<Either<Failure, ArticlesPageEntity>> call({required int page}) async {
    return await repository.getArticleList(page: page);
  }
}
