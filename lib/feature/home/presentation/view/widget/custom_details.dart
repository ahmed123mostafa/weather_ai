import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/color/color.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    super.key,
    required this.type,
    required this.value,
  });
  final String type;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        CircularPercentIndicator(
          backgroundColor: Colors.white.withAlpha(50),
          radius: 50.0,
          lineWidth: 10.0,
          percent: value.toDouble() / 100,
          center: Text(
            "$value%",
            style: AppStyle.socondarystyle.copyWith(
              color: Colors.blueAccent.withAlpha(250),
            ),
          ),
          progressColor: AppColors.activeColorIndicator,
        ),
        Text(
          type,
          style: AppStyle.socondarystyle.copyWith(
            color: AppColors.buttonLabelPrimary.withAlpha(250),
          ),
        ),
      ],
    );
  }
}
