import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/color/color.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_body_weather.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_card.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.kbaBackcolor,
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: AppStyle.primarystyle.copyWith(
                              color: Colors.lightBlueAccent, fontSize: 18),
                        ),
                        Text(
                          "Ahmed Mostafa",
                          style: AppStyle.primarystyle
                              .copyWith(color: Colors.blue, fontSize: 20),
                        )
                      ],
                    ),
                    Icon(
                      Icons.wallet_giftcard_outlined,
                      color: Colors.black,
                      size: 30,
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                CustomSearch(),
                Spacer(),
                BodyWeather(),
                SizedBox(
                  height: 80,
                ),
                Row(
                  children: [
                    CustomCard(),
                    SizedBox(
                      width: 15,
                    ),
                    CustomCard(),
                    SizedBox(
                      width: 15,
                    ),
                    CustomCard()
                  ],
                )
              ],
            ),
          )),
    );
  }
}
