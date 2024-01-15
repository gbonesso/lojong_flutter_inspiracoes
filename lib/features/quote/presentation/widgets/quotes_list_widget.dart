import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/presentation/providers/quote_provider.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/presentation/widgets/quote_card.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/error_dialog.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/no_conectivity_widget.dart';
import 'package:provider/provider.dart';

final log = Logger('Logger');

class QuotesListWidget extends StatefulWidget {
  const QuotesListWidget({
    super.key,
  });

  @override
  State<QuotesListWidget> createState() => _QuotesListWidgetState();
}

class _QuotesListWidgetState extends State<QuotesListWidget> {
  @override
  void initState() {
    Provider.of<QuoteProvider>(context, listen: false)
        .eitherFailureOrQuotesPage(page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuoteProvider>(builder: (context, quoteProvider, child) {
      if (quoteProvider.error && quoteProvider.lastPageRequested == 1) {
        if (quoteProvider.failure != null) {
          if (quoteProvider.failure!.errorMessage == "Sem conectividade") {
            return NoConectivityWidget(onTap: () {
              setState(() {
                Provider.of<QuoteProvider>(context, listen: false)
                    .eitherFailureOrQuotesPage(page: 1);
              });
            });
          }
        }
      }
      if (quoteProvider.quotesPage != null) {
        return Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: quoteProvider.quoteList.length +
                      (quoteProvider.quotesPage!.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    log.info(
                      'quote: building index: $index - '
                      'page: ${quoteProvider.quotesPage!.currentPage} '
                      'has_more: ${quoteProvider.quotesPage!.hasMore} ',
                    );
                    // Chegando próximo ao final da lista, buscar mais citações
                    if (index == quoteProvider.quoteList.length - 5) {
                      if (quoteProvider.quotesPage!.hasMore) {
                        quoteProvider.eitherFailureOrQuotesPage(
                            page: quoteProvider.quotesPage!.nextPage);
                      }
                    }
                    if (index == quoteProvider.quoteList.length) {
                      if (quoteProvider.error) {
                        return Center(
                          child: ErrorDialog(
                            onTap: () {
                              quoteProvider.eitherFailureOrQuotesPage(
                                  page: quoteProvider.lastPageRequested);
                            },
                          ),
                        );
                      } else {
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ));
                      }
                    }
                    return QuoteCard(
                      quote: quoteProvider.quoteList[index],
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      } else {
        return Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
