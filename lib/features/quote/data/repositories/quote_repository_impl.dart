import 'package:dartz/dartz.dart';
import 'package:lojong_flutter_inspiracoes/core/errors/failure.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quotes_page_entity.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/repositories/quote_repository.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/datasource/quote_remote_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, QuotesPageEntity>> getQuotesPage({
    required int page,
  }) async {
    final quotesPage = await remoteDataSource.getQuotesPage(page: page);
    return Right(quotesPage as QuotesPageEntity);
    //return Left(ServerFailure(errorMessage: 'This is a server exception'));
  }
}
