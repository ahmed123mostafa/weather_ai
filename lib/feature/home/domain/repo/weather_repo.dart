
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_ai/core/error/error.dart';

import 'package:flutter_weather_ai/feature/home/domain/entities/weather_entities.dart';


abstract class WeatherRepositry {
  Future<Either<Failuire, WeatherEntity>> getWeather({required String location});
  
}
