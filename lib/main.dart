import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/data/datasource/quote_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/presentation/providers/quote_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/video/presentation/providers/video_provider.dart';
import 'package:lojong_flutter_inspiracoes/inspiration_page.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio.dart';
import 'package:provider/provider.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
        ChangeNotifierProvider(create: (context) => VideoProvider()),
        ChangeNotifierProvider(create: (context) => QuoteProvider()),
      ],
      child: MaterialApp(
        title: "Lojong Test",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainApp(),
        // routes: {
        //   '/login': (context) => const LoginPage(),
        // },
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
  @override
  void initState() {
    super.initState();
    Provider.of<ArticleProvider>(context, listen: false)
        .eitherFailureOrArticleList(page: 1);
    Provider.of<VideoProvider>(context, listen: false)
        .eitherFailureOrVideoList(page: 1);
    Provider.of<QuoteProvider>(context, listen: false)
        .eitherFailureOrQuotesPage(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.visibility),
                label: Text('Inspirações'),
                onPressed: () {
                  // Provider.of<ArticleProvider>(context, listen: false)
                  //     .eitherFailureOrArticleList(page: 1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InspirationPage()),
                  );
                },
              ),
              // ElevatedButton.icon(
              //   icon: const Icon(Icons.visibility),
              //   label: Text('getVideoList'),
              //   onPressed: () async {
              //     final videoRemoteDataSource =
              //         VideoRemoteDataSourceImpl(dio: BaseDio().dio);

              //     final videoList =
              //         await videoRemoteDataSource.getVideoList(page: 1);
              //     log.info(videoList);
              //   },
              // ),
              ElevatedButton.icon(
                icon: const Icon(Icons.visibility),
                label: Text('getQuoteList'),
                onPressed: () async {
                  log.info('getQuoteList Button pressed...');
                  final quoteRemoteDataSource =
                      QuoteRemoteDataSourceImpl(dio: BaseDio().dio);

                  final quotesPage =
                      await quoteRemoteDataSource.getQuotesPage(page: 1);
                  log.info(quotesPage.toJson());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
