part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final dynamic weatherentity;

  WeatherSuccess({required this.weatherentity});
}

final class WeatherFailuire extends WeatherState {
  final String errmessage;
  WeatherFailuire({required this.errmessage});
}

final class WeatherChanged extends WeatherState {}

final class PerdictionLoading extends WeatherState {}

final class PerdictionSuccess extends WeatherState {
  final Map<String, dynamic> result;
  PerdictionSuccess({required this.result});
}

final class PerdictionFailuire extends WeatherState {
  final String errmessage;
  PerdictionFailuire({required this.errmessage});
}
