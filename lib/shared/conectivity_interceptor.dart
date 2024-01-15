import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

final log = Logger('Logger');

class ConnectivityInterceptor extends Interceptor {
  final Connectivity connectivity;

  ConnectivityInterceptor(this.connectivity);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      log.info('ConnectivityInterceptor::onRequest - options: ${options}');
      // Handle case when there is no internet connection
      // throw DioException(
      //   requestOptions: options,
      //   response: Response(
      //     requestOptions: options,
      //     statusCode: 503, // You can set your custom status code
      //     statusMessage: 'No internet connection',
      //   ),
      // );
      //throw DioException(requestOptions: options);
      //throw Exception();
    }
    return super.onRequest(options, handler);
  }
}
