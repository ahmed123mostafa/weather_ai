import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "wlcome to descover my App",
            style: AppStyle.socondarystyle,
          ),
        )
      ],
    ));
  }
}
