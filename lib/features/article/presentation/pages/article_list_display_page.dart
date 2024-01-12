import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/widgets/articles_list_widget.dart';

final log = Logger('Logger');

class ArticlesListDisplayPage extends StatelessWidget {
  const ArticlesListDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //     //title: Text(AppLocalizations.of(context)!.userProfilePageTitle),
      //     ),
      body: kIsWeb
          ? const Row(children: [
              Expanded(child: Placeholder()),
              SizedBox(width: 400, child: ArticlesListWidget()),
              Expanded(child: Placeholder()),
            ])
          : const ArticlesListWidget(),
    ));
  }
}
