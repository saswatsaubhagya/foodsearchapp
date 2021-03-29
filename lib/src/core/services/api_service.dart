import 'package:dio/dio.dart';

class ApiService {
  static const String base_url = "https://api.jsonbin.io/";
  static const String foodData = "b/5fce7e1e2946d2126fff85f0";

  Future<Dio> getDioClient() async {
    final Dio _dio = Dio();
    _dio
      ..options.headers.addAll({
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      })
      ..interceptors.clear()
      ..options.baseUrl = base_url;

    return _dio;
  }
}
