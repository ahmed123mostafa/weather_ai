import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_ai/core/botton/custom_botton.dart';
import 'package:flutter_weather_ai/core/color/color.dart';
import 'package:flutter_weather_ai/core/function/location.dart';
import 'package:flutter_weather_ai/core/setup_locator/setup_locator.dart';

import 'package:flutter_weather_ai/feature/home/data/models/weather_model.dart';

import 'package:flutter_weather_ai/feature/home/presentation/manage/cubit/ai_model_cubit.dart';
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
  List<WeatherModel?> list = [];
  int index = 0;
  Color color = Colors.blue;
  final weatherCubit = sl<WeatherCubit>();

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    String position = await GetLocation.getCurrentLocation();
    await weatherCubit.getCurrentWeather(position);

    if (weatherCubit.state is WeatherSuccess) {
      setState(() {
        weather = (weatherCubit.state as WeatherSuccess).weatherentity;
        color = weatherCubit.getThemeColor(weather?.condition ?? '');

       
        list = weather?.forecast.map((forecast) {
          return WeatherModel(
            temp: forecast.averageTemp,         
            humidity: forecast.averageHumidity, 
            condition: forecast.condition,      
            uv: forecast.uv,                    
            rain: forecast.rainChance.toDouble(), 
            location: weather!.location,        
            forecast: [], 
          );
        }).toList() ?? [];

        index = list.isNotEmpty ? 0 : -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbaBackcolor,
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherFailuire) {
            Future.microtask(() {
              showSnackBar(context, message: state.errmessage, color: Colors.red);
            });
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            color: Colors.blueGrey,
            backgroundColor: AppColors.buttonPrimary,
            onRefresh: fetchWeatherData,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.2,
              ),
              children: [
                WelcomeMessage(
                  location: weather?.location ?? "Updating...",
                  userName: "Ahmed Mo",
                ),
                ForcastDaysList(
                  onTap: (index) {
                    weatherCubit.changeSelectedDay(index);
                  },
                  selectedIndex: weatherCubit.selectedDayIndex,
                ),
                Center(
                  child: TempertureItem(
                    temp: weatherCubit.selectedDayIndex == 0
                        ? weather?.temp.truncate().toString() ?? 'N/A'
                        : weather?.forecast[weatherCubit.selectedDayIndex]?.averageTemp.truncate().toString() ?? 'N/A',
                    type: weatherCubit.selectedDayIndex == 0
                        ? weather?.condition ?? '_'
                        : weather?.forecast[weatherCubit.selectedDayIndex]?.condition ?? 'N/A',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailsItem(
                      type: "Humidity",
                      value: weatherCubit.selectedDayIndex == 0
                          ? weather?.humidity.truncate() ?? 0
                          : weather?.forecast[weatherCubit.selectedDayIndex]?.averageHumidity.truncate() ?? 0,
                    ),
                    DetailsItem(
                      type: "UV",
                      value: weatherCubit.selectedDayIndex == 0
                          ? weather?.uv.truncate() ?? 0
                          : weather?.forecast[weatherCubit.selectedDayIndex]?.uv.truncate() ?? 0,
                    ),
                    DetailsItem(
                      type: "Rain",
                      value: weatherCubit.selectedDayIndex == 0
                          ? weather?.rain.truncate() ?? 0
                          : weather?.forecast[weatherCubit.selectedDayIndex]?.rainChance.truncate() ?? 0,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ReusableButton(
                  text: "Is the weather good?",
                  onPressed: () async {
                    if (list.isEmpty || index < 0 || index >= list.length) {
                      showSnackBar(context, message: "No weather data available!", color: Colors.red);
                      return;
                    }

                    int? i = await context.read<AiModelCubit>().getPrediction(list[index]);

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        
                        icon: Icon(
                          i == 1 ? Icons.check_circle_outline : Icons.warning_amber_outlined,
                          color: i == 1 ? Colors.green : Colors.red,
                        ),
                        content: Text(i == 1 ? "Weather is good" : "Weather is bad"),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, {required String message, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(message),
    ));
  }
}
