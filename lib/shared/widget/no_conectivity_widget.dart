import 'package:flutter/material.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';

class NoConectivityWidget extends StatelessWidget {
  final Function onTap;
  const NoConectivityWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OPS!',
              style: BrandTextStyles.cardTitle.copyWith(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 20, bottom: 20),
              child: Text(
                'Não foi possível conectar ao servidor, '
                'verifique se está conectado a internet',
                style: BrandTextStyles.videoCardText.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFECECEC)),
              ),
              onPressed: () {
                onTap();
              },
              child: Text(
                'Recarregar',
                style: BrandTextStyles.cardTitle.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
