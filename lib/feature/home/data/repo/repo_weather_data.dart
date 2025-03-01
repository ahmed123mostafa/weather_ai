import 'package:dartz/dartz.dart';
import 'package:flutter_weather_ai/core/error/error.dart';
import 'package:flutter_weather_ai/feature/home/data/models/weather_model.dart';
import 'package:flutter_weather_ai/feature/home/data/remote_data_source/remote_data_source.dart';
import 'package:flutter_weather_ai/feature/home/domain/entities/weather_entities.dart';
import 'package:flutter_weather_ai/feature/home/domain/repo/weather_repo.dart';

class WeatherRepositryImpl implements WeatherRepositry {
  final RemoteDataResource remoteDataResource;
  WeatherRepositryImpl(this.remoteDataResource);
  @override
  Future<Either<Failuire, WeatherEntity>> getWeather({
    required String location,
  }) async {
    try {
      final WeatherModel weatherModel =
          await remoteDataResource.getWeather(location: location);
      return Right(weatherModel.toEntity());
    }  catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failuire, Map<String, dynamic>>> getWeatherpredection({required List<int> feature})async {
    try {
      Map<String, dynamic> result =
          await remoteDataResource.getPrediction(features: feature);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  
}