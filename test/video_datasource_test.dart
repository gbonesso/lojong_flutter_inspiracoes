import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/features/video/data/datasource/video_remote_data_source.dart';
import 'package:lojong_flutter_inspiracoes/shared/base_dio_test.dart';

final log = Logger('Logger');

void main() {
  // Logger.root.level = Level.ALL; // defaults to Level.INFO
  // Logger.root.onRecord.listen((LogRecord rec) {
  //   debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  // });

  test('Video data source', () async {
    final videoRemoteDataSource =
        VideoRemoteDataSourceImpl(dio: BaseDioTest().dio);

    // Primeira página de vídeos...
    // Só existe uma página com 12 vídeos.
    final videoListPage1 = await videoRemoteDataSource.getVideoList(page: 1);
    expect(videoListPage1.length, 12);
    expect(
      videoListPage1[0].toJson(),
      {
        'id': 12,
        'name': 'Introdução ao Lojong',
        'description':
            'Saiba como o Lojong pode te ajudar a iniciar o treino da mente.',
        'file': '',
        'url': 'https://vimeo.com/223279488',
        'url2': 'https://youtu.be/7p9pihdUmbw',
        'awsUrl': 'https://1366057841.rsc.cdn77.org/pt/videos/6introlojong.mp4',
        'image':
            'https://applojong.com/files/yatxhjt9zaxka1gdntqw/introthumb.jpg',
        'imageUrl':
            'https://1776471859.rsc.cdn77.org/images/videos/introducao.jpg',
        'premium': 0,
        'order': 1
      },
    );

    // Ao solicitar a lista de vídeos com uma página inválida a API sempre
    // retorna a primeira página, com os mesmos 12 vídeos. O App real tb
    // só mostra 12 vídeos.
    // Com base nesse teste eu retirei a opção de página na chamada da API
    final videoListInvalidPage =
        await videoRemoteDataSource.getVideoList(page: 100);
    //expect(videoListInvalidPage.length, 0); // Deveria vir zerada...
    expect(videoListInvalidPage.length, 12);
    expect(
      videoListInvalidPage[0].toJson(),
      {
        'id': 12,
        'name': 'Introdução ao Lojong',
        'description':
            'Saiba como o Lojong pode te ajudar a iniciar o treino da mente.',
        'file': '',
        'url': 'https://vimeo.com/223279488',
        'url2': 'https://youtu.be/7p9pihdUmbw',
        'awsUrl': 'https://1366057841.rsc.cdn77.org/pt/videos/6introlojong.mp4',
        'image':
            'https://applojong.com/files/yatxhjt9zaxka1gdntqw/introthumb.jpg',
        'imageUrl':
            'https://1776471859.rsc.cdn77.org/images/videos/introducao.jpg',
        'premium': 0,
        'order': 1
      },
    );
  });
}
