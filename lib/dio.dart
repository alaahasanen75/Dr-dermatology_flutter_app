import 'package:dio/dio.dart';

class DioHelperArticle {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://eng.caterieng.com/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
  }) async {
    return await dio.get(
      url,
    );
  }
}
