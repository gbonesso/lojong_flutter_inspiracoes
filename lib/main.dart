import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/pages/article_list_display_page.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/providers/article_provider.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          //child: Text('Hello World!'),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.visibility),
            label: Text('getArticleList'),
            onPressed: () {
              Provider.of<ArticleProvider>(context, listen: false)
                  .eitherFailureOrArticleList(page: 1);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ArticlesListDisplayPage()),
              );
            },
          ),
        ),
      ),
    );
  }
}
