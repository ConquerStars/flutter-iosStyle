import 'custDio_config.dart';

void getHttp() async {
  try {
    final res = await custDio.get('/api');
    print('getHttp catch Respond ==== Start');
    print(res);
    print('getHttp catch Respond ==== End');
  } catch (e) {
    print('getHttp catch Error ==== Start');
    print(e);
    print('getHttp catch Error ==== End');
  }
}