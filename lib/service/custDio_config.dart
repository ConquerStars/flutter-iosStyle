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
    onResponse: (Response response){
      print('=====返回拦截器Start=====');
      print(response);
      print('=====返回拦截器End=====');
    },
    onError: (DioError dioError){
      print('=====报错拦截器Start=====');
      print(dioError);
      print('=====报错拦截器End=====');
    },
    onRequest: (RequestOptions options){
      print('=====请求拦截器Start=====');
      print(options);
      print('=====请求拦截器End=====');
    }
  ));
}
// 为所有请求方法添加拦截器
final custDio = addInterceptors(dio);