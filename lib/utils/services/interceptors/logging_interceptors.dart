import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('\n');
    print('--> ${options.method.toUpperCase()} ${'' + (options.baseUrl) + (options.path)}');
    print('Headers:');
    options.headers.forEach((k, dynamic v) => print('$k: $v'));
    // if (options.queryParameters != null) {
    //   print('queryParameters:');
    //   options.queryParameters.forEach((k, dynamic v) => print('$k: $v'));
    // }
    print('queryParameters:');
    options.queryParameters.forEach((k, dynamic v) => print('$k: $v'));
    if (options.data != null) {
      print('Body: ${options.data}');
    }
    print('--> END ${options.method.toUpperCase()}');

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('\n');
    print('<-- ${err.message} ${err.response != null ? err.response!.realUri.path : 'Unknown Path'}');
    print('${err.response != null ? err.response!.data : 'Unknown Error'}');
    print('<-- End error');

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('\n\n');
    print('<--- HTTP CODE : ${response.statusCode} URL : ${response.realUri.path}');
    print('Headers: ');
    print('<--- END HTTP');

    super.onResponse(response, handler);
  }
}
