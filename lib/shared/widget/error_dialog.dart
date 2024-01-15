import 'package:flutter/material.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';

class ErrorDialog extends StatelessWidget {
  final Function onTap;
  const ErrorDialog({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;

    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: Card(
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ocorreu um erro...',
                    style: BrandTextStyles.cardTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Botão recarregar
                  SizedBox(
                    height: useMobileLayout ? 30 : 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFECECEC)),
                      ),
                      onPressed: () {
                        onTap();
                      },
                      child: Text(
                        "Recarregar",
                        style: BrandTextStyles.cardTitle.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
