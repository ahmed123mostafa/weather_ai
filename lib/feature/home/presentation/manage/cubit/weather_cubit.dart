import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_weather_ai/feature/home/domain/entities/weather_entities.dart';
import 'package:flutter_weather_ai/feature/home/domain/usecase/weather_predection.dart';
import 'package:flutter_weather_ai/feature/home/domain/usecase/weather_usecase.dart';

import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this.getWeatherUseCase,
    this.weatherPredection
  ) : super(WeatherInitial());
  final GetWeatherUseCase getWeatherUseCase;
  final WeatherPredection weatherPredection;
   Future<Map<String, dynamic>?>? getweatherpredection(
    List<int> features,
  ) async {
    emit(PerdictionLoading());
    final failureOrWeather = await weatherPredection(features: features);
    failureOrWeather.fold(
        (failure) => emit(PerdictionFailuire(errmessage: failure.message)),
        (result) => emit(PerdictionSuccess(get: result)));
    return null;
  }

  Future<WeatherEntity?>? getCurrentWeather(
    String location,
  ) async {
    emit(WeatherLoading());
    final failureOrWeather = await getWeatherUseCase(location: location);
    failureOrWeather.fold(
        (failure) => emit(WeatherFailuire(errmessage: failure.message)),
        (weather) => emit(WeatherSuccess(weatherentity: weather)));
    return null;
  }

  int selectedDayIndex = 0;

  void changeSelectedDay(int index) {
    selectedDayIndex = index;
    emit(WeatherChanged());
  }

  MaterialColor getThemeColor(String? condition) {
    if (condition == null) {
      return Colors.red;
    }
    switch (condition) {
      case 'Sunny':
        return Colors.amber;
      case 'Partly cloudy':
      case 'Partly Cloudy ':
      case 'Cloudy':
      case 'cloudy':
      case 'Overcast':
        return Colors.blueGrey;
      case 'Fog':
      case 'Freezing fog':
        return Colors.grey;
      case 'Mist':
      case 'Patchy rain possible':
      case 'Patchy rain nearby':
      case 'Patchy light drizzle':
      case 'Light drizzle':
      case 'Patchy light rain':
      case 'Light rain':
      case 'Light rain shower':
        return Colors.lightBlue;
      case 'Moderate rain at times':
      case 'Moderate rain':
      case 'Heavy rain at times':
      case 'Heavy rain':
      case 'Moderate or heavy rain shower':
      case 'Torrential rain shower':
        return Colors.blue;
      case 'Thundery outbreaks possible':
      case 'Moderate or heavy rain with thunder':
        return Colors.purple;
      case 'Blowing snow':
      case 'Blizzard':
      case 'Patchy light snow':
      case 'Light snow':
      case 'Patchy moderate snow':
      case 'Moderate snow':
      case 'Patchy heavy snow':
      case 'Heavy snow':
      case 'Light snow showers':
      case 'Moderate or heavy snow showers':
        return Colors.grey;
      case 'Freezing drizzle':
      case 'Heavy freezing drizzle':
      case 'Light freezing rain':
      case 'Moderate or heavy freezing rain':
        return Colors.lightGreen;
      case 'Light sleet':
      case 'Moderate or heavy sleet':
      case 'Light sleet showers':
      case 'Moderate or heavy sleet showers':
        return Colors.teal;
      case 'Ice pellets':
      case 'Light showers of ice pellets':
      case 'Moderate or heavy showers of ice pellets':
        return Colors.cyan;

      default:
        return Colors.red;
    }
  }
}
