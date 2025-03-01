

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_ai/core/error/error.dart';
import 'package:flutter_weather_ai/feature/home/domain/repo/weather_repo.dart';

abstract class WeatherPredection {
  Future<Either<Failuire, Map<String, dynamic>>> call(
      {required List<int> features});
}

class WeatherPreductionImpl extends WeatherPredection {
  final WeatherRepositry weatherRepositry;
  WeatherPreductionImpl(this.weatherRepositry);
  @override
  Future<Either<Failuire, Map<String, dynamic>>> call(
      {required List<int> features}) {
    return weatherRepositry.getWeatherpredection(feature: features);
  }
}
