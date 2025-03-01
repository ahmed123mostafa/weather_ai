// ignore_for_file: camel_case_types

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_ai/core/error/error.dart';

import 'package:flutter_weather_ai/feature/home/domain/entities/weather_entities.dart';
import 'package:flutter_weather_ai/feature/home/domain/repo/weather_repo.dart';



abstract class GetWeatherUseCase {
  Future<Either<Failuire, WeatherEntity>> call({required String location});
}

class GetWeatherUseCaseImpl implements GetWeatherUseCase {
  final WeatherRepositry weatherRepositry;
  GetWeatherUseCaseImpl(this.weatherRepositry);
  @override
  Future<Either<Failuire, WeatherEntity>> call({required String location}) {
    return weatherRepositry.getWeather(location: location);
    
  }
}