import 'package:dio/dio.dart';

import 'package:flutter_weather_ai/core/network/api_services.dart';
import 'package:flutter_weather_ai/feature/home/data/remote_data_source/remote_data_source.dart';
import 'package:flutter_weather_ai/feature/home/data/repo/repo_weather_data.dart';
import 'package:flutter_weather_ai/feature/home/domain/repo/weather_repo.dart';
import 'package:flutter_weather_ai/feature/home/domain/usecase/weather_predection.dart';
import 'package:flutter_weather_ai/feature/home/domain/usecase/weather_usecase.dart';
import 'package:flutter_weather_ai/feature/home/presentation/manage/cubit/weather_cubit.dart';
import 'package:get_it/get_it.dart';
final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Register Dio (for API requests)
  sl.registerLazySingleton<Dio>(() => Dio());

  // Register API Service (depends on Dio)
  sl.registerLazySingleton<WeatherApiService>(
    () => WeatherApiService(sl<Dio>()),
  );

  // Register Remote Data Source (depends on WeatherApiService)
  sl.registerLazySingleton<RemoteDataResource>(
    () => RemoteDataResource(sl<WeatherApiService>()),
  );

  // Register Repository (depends on RemoteDataResource)
  sl.registerLazySingleton<WeatherRepositry>(
    () => WeatherRepositryImpl(sl<RemoteDataResource>()),
  );

  // Register Use Case (depends on Repository)
  sl.registerLazySingleton<GetWeatherUseCase>(
    () => GetWeatherUseCaseImpl(sl<WeatherRepositry>()),
  );

  // ✅ FIX: Inject WeatherRepository, NOT GetWeatherUseCase
  sl.registerLazySingleton<WeatherPredection>(
    () => WeatherPreductionImpl(sl<WeatherRepositry>()), // Corrected
  );

  // Register WeatherCubit (ensuring no duplicate registrations)
  sl.registerLazySingleton<WeatherCubit>(
    () => WeatherCubit(sl<GetWeatherUseCase>(), sl<WeatherPredection>()),
  );
}