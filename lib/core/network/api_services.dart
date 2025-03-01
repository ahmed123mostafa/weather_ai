import 'package:dio/dio.dart';

class WeatherApiService {
  final Dio dio;
  WeatherApiService(this.dio);
  Future<Response> getWeather({required String url}) async {
    Response response = await dio.get(url);
    return response;
  }
}