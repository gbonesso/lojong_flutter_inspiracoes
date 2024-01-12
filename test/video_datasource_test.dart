import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/datasource/video_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Video datasource test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ArticleProvider(),
          ),
        ],
        child: MaterialApp(
          home: Container(),
        )));
    final BuildContext context = tester.element(find.byType(Container));

    final videoRemoteDataSource = VideoRemoteDataSourceImpl(dio: BaseDio().dio);

    final videoList = await videoRemoteDataSource.getVideoList(page: 1);

    print(videoList);
    expect(videoList, '2 dias,\n2 horas e\n30 minutos\n');
  });
}
