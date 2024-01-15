import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/features/article/data/datasources/article_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/presentation/providers/quote_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/video/presentation/providers/video_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

final log = Logger('Logger');

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  // Only allow portrait mode, not landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Para debugar no meu iPhone...
  if (Platform.isIOS) {
    ChuckerFlutter.showOnRelease = true;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
        ChangeNotifierProvider(create: (context) => VideoProvider()),
        ChangeNotifierProvider(create: (context) => QuoteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Lojong Test",
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: BrandColors.inspirationBackGround,
        ),
        home: const MainApp(),
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<void> test() async {
    final articleRemoteDataSource =
        ArticleRemoteDataSourceImpl(dio: BaseDio().dio);

    final articlesPage1 =
        await articleRemoteDataSource.getArticlesPage(page: 5);

    log.info(articlesPage1!.toJson());
  }

  @override
  Widget build(BuildContext context) {
    test();

    return const Scaffold(
      body: Center(
        child: Text('Teste...'),
      ),
    );
  }
}
