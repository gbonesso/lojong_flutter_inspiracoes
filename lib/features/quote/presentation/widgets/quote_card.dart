import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/business/entities/quote_entity.dart';

final log = Logger('Logger');

// TODO: Implementar 3 estilos de cards diferentes como no App e no Figma
class QuoteCard extends StatelessWidget {
  final QuoteEntity quote;
  // final int? index;
  // final bool showButtons;
  // final bool showDivider;
  const QuoteCard({
    super.key,
    required this.quote,
    // required this.index,
    // required this.showButtons,
    // required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  quote.text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.asap(
                    textStyle: TextStyle(
                      color: Color(0xFF446DAF),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     elevation: 8,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(20),
              //       child: CachedNetworkImage(
              //         imageUrl: article.imageUrl,
              //         placeholder: (context, url) => CircularProgressIndicator(),
              //         // progressIndicatorBuilder:
              //         //     (context, url, downloadProgress) =>
              //         //         CircularProgressIndicator(
              //         //             value: downloadProgress.progress),
              //         errorWidget: (context, url, error) => Icon(Icons.error),
              //       ),
              //       //child: Image.network(article.imageUrl),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Text(
                  quote.author,
                  style: GoogleFonts.asap(
                    textStyle: TextStyle(
                      color: Color(0xFF80848F),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFECECEC)),
                ),
                onPressed: () {
                  log.info('Compartilhar...');
                },
                icon: Icon(
                  Icons.share,
                  color: Color(0xFF80848F),
                  size: 18,
                ),
                label: Text(
                  'Compartilhar',
                  style: GoogleFonts.asap(
                    textStyle: TextStyle(
                      color: Color(0xFF80848F),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
