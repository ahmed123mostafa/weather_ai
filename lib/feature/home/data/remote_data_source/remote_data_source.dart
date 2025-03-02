import 'package:dio/dio.dart';
import 'package:flutter_weather_ai/core/network/api_services.dart';
import 'package:flutter_weather_ai/feature/home/data/models/weather_model.dart';

class RemoteDataResource {
  final WeatherApiService weatherApiService;
  RemoteDataResource(this.weatherApiService);
  final String apiKey = '732ffd4f1b1c45c6bdb132417251802';
  final String baseUrl = 'https://api.weatherapi.com/v1/';
   
  Future<WeatherModel> getWeather({required String location}) async {
    try {
      Response response = await weatherApiService.getWeather(
          url: '$baseUrl/forecast.json?q=$location&days=4&hour=24&key=$apiKey');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 400:
          return ServerException(AppStrings.badRequestMessage);
        case 401:
        case 403:
          return ServerException(AppStrings.unauthorizedAccessMessage);
        case 404:
          return ServerException(AppStrings.locationNotFoundMessage);
        case 500:
          return ServerException(AppStrings.serverErrorMessage);
        default:
          return ServerException('Unknown error: ${e.response!.statusCode}');
      }
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return ServerException(AppStrings.connectionTimeoutMessage);
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return ServerException(AppStrings.receiveTimeoutMessage);
    } else if (e.type == DioExceptionType.cancel) {
      return ServerException(AppStrings.requestCancelledMessage);
    } else {
      return ServerException(AppStrings.unexpectedErrorMessage);
    }
  }
}
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
class AppStrings {
  
  static const String serverFailure = "A server failure occurred.";
  static const String cacheFailure = "A cache failure occurred.";
 
  

 
  static const String badRequestMessage = 'Bad request. Please try again.';
  static const String unauthorizedAccessMessage =
      'Unauthorized access. Please check your login.';
  static const String locationNotFoundMessage =
      'Location not found. Try another city.';
  static const String serverErrorMessage =
      'Server error! Please try again later.';
  static const String connectionTimeoutMessage =
      'Connection timed out. Please check your internet!';
  static const String receiveTimeoutMessage =
      'The server did not respond in time!';
  static const String requestCancelledMessage = 'Request was cancelled!';
  static const String unexpectedErrorMessage = 'An unexpected error occurred!';
}


