class WeatherEntity {
  final double temp;
  final int humidity;
  final  String condition;
  final double uv;
  final double rain;
  final  String location;
  final List<ForecastEntity> forecast;

  WeatherEntity(
      {required this.forecast,
      required  this.location,
      required this.rain,
      required this.uv,
      required this.condition,
      required this.temp,
      required this.humidity});
}
class ForecastEntity {
  final String day;
  final double averageTemp;
  final int averageHumidity;
  final double uv;
  final double rainChance;
  final String condition;


  ForecastEntity({
    
    required this.day,
    required this.averageTemp,
    required this.averageHumidity,
    required this.uv,
    required this.rainChance,
    required this.condition,
    required String date,
  });
}