import 'package:dio/dio.dart';
import 'package:flutter_weather_ai/core/network/api_services.dart';
import 'package:flutter_weather_ai/feature/home/data/models/weather_model.dart';

class RemoteDataResource {
  final WeatherApiService weatherApiService;
  RemoteDataResource(this.weatherApiService);
  final String apiKey = '732ffd4f1b1c45c6bdb132417251802';
  final String baseUrl = 'https://api.weatherapi.com/v1/';
   final String flaskUrl = 'http://10.0.2.2:5001/predict';
   Future<Map<String, dynamic>> getPrediction(
      {required List<int> features}) async {
    try {
      final url = Uri.parse(flaskUrl).toString();
      Map<String, dynamic> body = {'features': features};
      final response = await Dio().post(url, data: body);

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
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
  static const String signUp = 'Sign Up';
  static const String login = 'LogIn';
  static const String welcomeBack = 'Welcome Back!';
  static const String alreadyHaveAnAccount = 'Already have an account?';
  static const String dontHaveAnAccount = 'Don\'t have an account?';
  static const String hintName = 'Name:';
  static const String hintEmail = 'Email:';
  static const String hintPassword = 'Password:';
  static const String invalidEmail = 'Invalid email';
  static const String invalidPassword =
      'Password must be at least 8 characters';
  static const String nameIsRequired = 'Name is required';
  static const String emailIsRequired = 'Email is required';
  static const String passwordIsRequired = 'Password is required';
  static const String loginSuccess = 'Login Success';
  static const String signUpSuccess = 'Account Created Successfully';
  static const String firebaseAuthException = "Firebase Auth Error";
  static const String serverFailure = "A server failure occurred.";
  static const String cacheFailure = "A cache failure occurred.";
  static const String userNotFound = "user-not-found";
  static const String wrongPassword = "wrong-password";
  static const String weakPassword = "weak-password";
  static const String emailAlreadyInUse = "email-already-in-use";
  static const String userDisabled = "user-disabled";
  
  static const String updating = 'Updating...';
  static const String humidity = 'Humidity';
  static const String rain = 'Rain';
  static const String uv = 'UV';
  static const String hello = 'Hello';
 
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


