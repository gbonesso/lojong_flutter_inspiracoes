import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/presentation/providers/quote_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/presentation/widgets/quote_card.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class QuotesListWidget extends StatelessWidget {
  const QuotesListWidget({
    super.key,
  });

  //Color(0xFFE09090)

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(builder: (context, quoteProvider, child) {
      if (quoteProvider.quotesPage != null) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      for (final quote in quoteProvider.quotesPage!.quotesList)
                        QuoteCard(
                          quote: quote,
                        )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
