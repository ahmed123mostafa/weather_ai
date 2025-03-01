import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';
class TempertureItem extends StatelessWidget {
  const TempertureItem({
    super.key,
    required this.temp,
    required this.type,
  });
  final String temp;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(temp, style: AppStyle.thirdstyle),
        Text(
          type,
          style: AppStyle.socondarystyle.copyWith(
            color: Colors.white.withAlpha(150),
          ),
        ),
      ],
    );
  }
}