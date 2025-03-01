import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_ai/core/color/color.dart';
import 'package:flutter_weather_ai/core/function/location.dart';
import 'package:flutter_weather_ai/core/setup_locator/setup_locator.dart';
import 'package:flutter_weather_ai/feature/home/domain/entities/base%20weather.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_details.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_welcome.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/forcast_list.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/tempreture.dart';

import '../../../domain/entities/weather_entities.dart';
import '../../manage/cubit/weather_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  WeatherEntity? weather;
    List<int> features = [];
  Color color = Colors.blue;
    final weatherCubit = sl<WeatherCubit>();
  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    String position = await GetLocation.getCurrentLocation();
    await sl<WeatherCubit>().getCurrentWeather(
      position,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoading) {
            print("loading.....");
          }
          if (state is WeatherFailuire) {
            print(state.errmessage);
            showSnackBar(context, message: state.errmessage, color: Colors.red);
          }
          if (state is WeatherSuccess) {
            print("suceess");
            weather = state.weatherentity;
            color = BlocProvider.of<WeatherCubit>(context)
                .getThemeColor(weather?.condition ?? '');
               // features = BaseWeather.feature(weather!);
          weatherCubit.getweatherpredection(features);

          }
          if (state is WeatherChanged) {
            print("weather changed");
            print(sl<WeatherCubit>().selectedDayIndex);
            color = BlocProvider.of<WeatherCubit>(context).getThemeColor(
                sl<WeatherCubit>().selectedDayIndex == 0
                    ? weather?.condition ?? ''
                    : weather
                        ?.forecast[BlocProvider.of<WeatherCubit>(context)
                            .selectedDayIndex]
                        .condition);
          }
        },
        builder: (context, state) {
          final cubit = sl<WeatherCubit>();
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: AppColors.buttonPrimary,
            onRefresh: () async {
              await fetchWeatherData();
              cubit.changeSelectedDay(0);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withAlpha(100)],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.2,
                ),
                child: ListView(
                  children: [
                    Column(
                      spacing: MediaQuery.of(context).size.height * 0.07,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WelcomeMessage(
                          location: weather?.location ?? "updating....",
                          userName: "Ahmed mo",
                        ),
                        ForcastDaysList(
                          onTap: (index) {
                            cubit.changeSelectedDay(index);
                            print('on tap pressed index $index');
                            print(
                                'on tap pressed selected index cubit ${sl<WeatherCubit>().selectedDayIndex}');
                          },
                          selectedIndex: sl<WeatherCubit>().selectedDayIndex,
                        ),
                        Center(
                          child: TempertureItem(
                            temp: sl<WeatherCubit>().selectedDayIndex == 0
                                ? weather?.temp.truncate().toString() ??
                                    'no weather'
                                : weather
                                        ?.forecast[
                                            sl<WeatherCubit>().selectedDayIndex]
                                        .averageTemp
                                        .truncate()
                                        .toString() ??
                                    '_',
                            type: sl<WeatherCubit>().selectedDayIndex == 0
                                ? weather?.condition ?? '_'
                                : weather
                                        ?.forecast[
                                            sl<WeatherCubit>().selectedDayIndex]
                                        .condition ??
                                    'no weather',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailsItem(
                              type: "humidity",
                              value: sl<WeatherCubit>().selectedDayIndex == 0
                                  ? weather?.humidity.truncate() ?? 0
                                  : weather
                                          ?.forecast[sl<WeatherCubit>()
                                              .selectedDayIndex]
                                          .averageHumidity
                                          .truncate() ??
                                      0,
                            ),
                            DetailsItem(
                              type: "uv",
                              value: sl<WeatherCubit>().selectedDayIndex == 0
                                  ? weather?.uv.truncate() ?? 0
                                  : weather
                                          ?.forecast[sl<WeatherCubit>()
                                              .selectedDayIndex]
                                          .uv
                                          .truncate() ??
                                      0,
                            ),
                            DetailsItem(
                                type: "rain",
                                value: sl<WeatherCubit>().selectedDayIndex == 0
                                    ? weather?.rain.truncate() ?? 0
                                    : weather
                                            ?.forecast[sl<WeatherCubit>()
                                                .selectedDayIndex]
                                            .rainChance
                                            .truncate() ??
                                        0),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showSnackBar(context, {required String message, required Color color}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(message),
      ));
}
