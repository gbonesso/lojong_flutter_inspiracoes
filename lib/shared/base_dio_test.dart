import 'package:dio/dio.dart';

class BaseDioTest {
  static final BaseDioTest _singleton = BaseDioTest._internal();
  static const _userToken =
      'O7Kw5E2embxod5YtL1h1YsGNN7FFN8wIxPYMg6J9zFjE6Th9oDssEsFLVhxf';
  final Dio dio = Dio();

  factory BaseDioTest() => _singleton;

  // TODO: Configurar data de expiração para 7 dias
  BaseDioTest._internal() {
    // *** Desabilitei o cache para os testes unitários
    // // private constructor that creates the singleton instance
    // late CacheStore cacheStore;

    // getTemporaryDirectory().then((dir) {
    //   cacheStore = FileCacheStore(dir.path);

    //   var cacheOptions = CacheOptions(
    //     store: cacheStore,
    //     policy: CachePolicy.forceCache,
    //     priority: CachePriority.high,
    //     hitCacheOnErrorExcept: [401, 404], // for offline behaviour
    //     // Overrides any HTTP directive to delete entry past this duration.
    //     // Useful only when origin server has no cache config or custom behaviour is desired.
    //     // Defaults to [null].
    //     maxStale: const Duration(days: 7),
    //     //policy: CachePolicy.request, // Not necessary, request is the default
    //   );

    //   dio.interceptors.add(
    //     DioCacheInterceptor(options: cacheOptions),
    //   );
    // });

    // Para tratar rede indisponível...
    // Connectivity connectivity = Connectivity();
    // dio.interceptors.add(ConnectivityInterceptor(connectivity));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the access token to the request header
          options.headers['Authorization'] = 'Bearer $_userToken';
          return handler.next(options);
        },
      ),
    );

    // *** Desabilitei o ChuckerDioInterceptor para os testes unitários
    //dio.interceptors.add(ChuckerDioInterceptor());
  }
}
