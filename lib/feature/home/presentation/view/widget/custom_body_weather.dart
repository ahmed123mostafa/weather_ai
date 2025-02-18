import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';

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
                  "cold",
                  style: AppStyle.primarystyle.copyWith(color: Colors.white),
                ),
                Text(
                  "50",
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
