import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: "https://www.baidu.com",
    headers: {},
    connectTimeout: 5000,
    receiveTimeout: 3000,
  )
);

Dio addInterceptors(Dio dio) {
  dio.interceptors.add(CookieManager(CookieJar()));
  return dio..interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options){
      // print('=====请求拦截器Start=====');
      // print("url = ${options.uri.toString()}");
      // print("headers = ${options.headers}");
      // print("params = ${options.data}");
      // print('=====请求拦截器End=====');
    },
    onResponse: (Response response){
      print('=====返回拦截器Start=====');
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print('=====返回拦截器End=====');
    },
    onError: (DioError e){
      // print('=====报错拦截器Start=====');
      // print("type = ${e.type}");
      // print("message = ${e.message}");
      // print("stackTrace = ${e.stackTrace}");
      // print("code=${e.response??e.response.statusCode}");
      // print("data=${e.response??e.response.data ?? ""}");
      // print('=====报错拦截器End=====');
    }
  ));
}
// 为所有请求方法添加拦截器
final custDio = dio;
// final custDio = addInterceptors(dio);