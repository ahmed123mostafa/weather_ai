import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/color/color.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';
import 'package:flutter_weather_ai/feature/Authentication/presentation/view/widget/custom_form_field.dart';

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

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _SearchState();
}

class _SearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(12),
          height: 80,
          decoration: BoxDecoration(
              color: AppColors.bgColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter your country .....",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ))
      ],
    );
  }
}

class BodyWeather extends StatelessWidget {
  const BodyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.location_city),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ahmed",
                  style: AppStyle.socondarystyle
                      .copyWith(color: Colors.black, fontSize: 20),
                ),
                Text("Egypt",
                    style: AppStyle.primarystyle
                        .copyWith(color: Colors.black, fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Sunny",
                  style: AppStyle.primarystyle.copyWith(color: Colors.white),
                ),
                Text(
                  "30",
                  style: AppStyle.primarystyle.copyWith(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.sunny,
              color: Colors.white,
              size: 50,
            )
          ],
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.grey),
        child: Column(
          children: [
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Icon(
              Icons.sunny,
              color: Colors.white,
              size: 24,
            ),
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
