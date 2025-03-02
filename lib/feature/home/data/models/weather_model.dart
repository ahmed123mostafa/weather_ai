import 'package:flutter_weather_ai/feature/home/domain/entities/base%20weather.dart';
import 'package:flutter_weather_ai/feature/home/domain/entities/weather_entities.dart';

class WeatherModel {
  final double temp;
  final int humidity;
  final String condition;
  final double uv;
  final double rain;
  final String location;
  final List<ForecastWeatherModel> forecast;
  // final String? date;
  // final double? averageTemp;
  // final int? averageHumidity;
  // final String? dayCondition;
  // final double? dayUv;
  // final int? dayRain;
  WeatherModel({
    required this.forecast,
    required this.location,
    required this.uv,
    required this.condition,
    required this.temp,
    required this.humidity,
    required this.rain,
    // this.date,
    // this.averageTemp,
    // this.averageHumidity,
    // this.dayCondition,
    // this.dayUv,
    // this.dayRain
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
  return WeatherModel(
    temp: (json['current']['temp_c'] ?? 0.0).toDouble(),
    humidity: json['current']['humidity'] ?? 0,
    condition: json['current']['condition']['text'] ?? 'Unknown',
    uv: (json['current']['uv'] ?? 0.0).toDouble(),
    rain: (json['current']['precip_mm'] ?? 0.0).toDouble(),
    location: json['location']['region'] ?? 'Unknown',
    forecast: (json['forecast']['forecastday'] as List)
        .map((day) => ForecastWeatherModel.fromJson(day))
        .toList(), // ✅ Correct conversion
  );
}

  WeatherEntity toEntity() {
    return WeatherEntity(
        forecast: forecast.map((e) => e.toEntity()).toList(),
        rain: rain,
        temp: temp,
        humidity: humidity,
        condition: condition,
        uv: uv,
        location: location);
  }
}class ForecastWeatherModel {
  final String date;
  final double averageTemp;
  final int averageHumidity;
  final String condition;
  final double uv;
  final int rainChance;

  ForecastWeatherModel({
    required this.date,
    required this.averageTemp,
    required this.averageHumidity,
    required this.condition,
    required this.uv,
    required this.rainChance,
  });

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) =>
      ForecastWeatherModel(
        date: json['date'] ?? "",
        averageTemp: (json['day']?['avgtemp_c'] ?? 0.0).toDouble(),
        averageHumidity: (json['day']?['avghumidity'] ?? 0),
        condition: json['day']?['condition']?['text'] ?? "No weather",
        uv: (json['day']?['uv'] ?? 0.0).toDouble(),
        rainChance: (json['day']?['daily_chance_of_rain'] ?? 0).toInt(),
      );

  ForecastEntity toEntity() {
    return ForecastEntity(
      rainChance: rainChance.toDouble(),
      condition: condition,
      uv: uv,
      date: date,
      day: date,
      averageTemp: averageTemp,
      averageHumidity: averageHumidity,
    );
  }
}