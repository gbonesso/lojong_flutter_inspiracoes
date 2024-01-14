import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/entities/article_content_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/article/business/repositories/article_repository.dart';

class GetArticleContent {
  final ArticleRepository repository;

  GetArticleContent(this.repository);

  Future<Either<Failure, ArticleContentEntity>> call(
      {required int articleId}) async {
    return await repository.getArticleContent(articleId: articleId);
  }
}
