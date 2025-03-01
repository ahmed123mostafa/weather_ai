class BaseWeather{
  final dynamic temp;
  final dynamic humidity;
  final String condition;
  final dynamic uv;
  final dynamic rain;

  BaseWeather({
    required this.temp,
    required this.humidity,
    required this.condition,
    required this.uv,
    required this.rain,
  });

  static List<int> feature(BaseWeather entity) {
    List<int> features = [];
   
    entity.rain > 0.5 ? features.add(1) : features.add(0);
  
    entity.uv > 5 || entity.condition == 'Sunny'
        ? features.add(1)
        : features.add(0);
   
    entity.temp > 30 ? features.add(1) : features.add(0);
   
    entity.temp > 20 && entity.temp < 30 ? features.add(1) : features.add(0);
   
    entity.humidity > 50 ? features.add(1) : features.add(0);
    return features;
  }
}