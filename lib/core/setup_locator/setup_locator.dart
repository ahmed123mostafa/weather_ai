import 'package:dio/dio.dart';

import 'package:flutter_weather_ai/core/network/api_services.dart';
import 'package:flutter_weather_ai/feature/home/data/remote_data_source/ai_data.dart';
import 'package:flutter_weather_ai/feature/home/data/remote_data_source/remote_data_source.dart';
import 'package:flutter_weather_ai/feature/home/data/repo/ai_repo_impl.dart';
import 'package:flutter_weather_ai/feature/home/data/repo/repo_weather_data.dart';
import 'package:flutter_weather_ai/feature/home/domain/repo/ai_weather.dart';
import 'package:flutter_weather_ai/feature/home/domain/repo/weather_repo.dart';
import 'package:flutter_weather_ai/feature/home/domain/usecase/weather_predection.dart';
import 'package:flutter_weather_ai/feature/home/domain/usecase/weather_usecase.dart';
import 'package:flutter_weather_ai/feature/home/presentation/manage/cubit/ai_model_cubit.dart';
import 'package:flutter_weather_ai/feature/home/presentation/manage/cubit/weather_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // Register Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Register API Service
  sl.registerLazySingleton<WeatherApiService>(
    () => WeatherApiService(sl<Dio>()),
  );

  // Register Remote Data Source
  sl.registerLazySingleton<RemoteDataResource>(
    () => RemoteDataResource(sl<WeatherApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<WeatherRepositry>(
    () => WeatherRepositryImpl(sl<RemoteDataResource>()),
  );

  // Register Use Case
  sl.registerLazySingleton<GetWeatherUseCase>(
    () => GetWeatherUseCaseImpl(sl<WeatherRepositry>()),
  );

  // Register WeatherCubit
  sl.registerLazySingleton<WeatherCubit>(
    () => WeatherCubit(sl<GetWeatherUseCase>()),
  );

  sl.registerLazySingleton<AiService>(
    () => AiService(dio: sl<Dio>()),
  );

  sl.registerLazySingleton<AiModel>(
    () => AiModelRepositoryImp(aiModelRepositoriesl: sl()),
  );

  sl.registerLazySingleton(
    () => AiUseCase(aiModel: sl()),
  );

  sl.registerFactory(() => AiModelCubit(sl()));
}