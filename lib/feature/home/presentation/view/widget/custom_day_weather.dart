
import 'package:flutter/material.dart';

import 'package:flutter_weather_ai/core/style/app_style.dart';

class ForcastDayItem extends StatelessWidget {
  const ForcastDayItem({
    super.key,
    required this.color,
    required this.date,
    required this.dayName,
  });
  final Color color;
  final String dayName;
  final String date;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.8 / 4,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              dayName,
              style: AppStyle.thirdstyle.copyWith(color: color),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              date,
              style: AppStyle.socondarystyle.copyWith(color: color),
            )
          ],
        ),
      ),
    );
  }
}