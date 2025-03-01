import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
    required this.location,
    required this.userName,
  });
  final String userName;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("hello",
                style: AppStyle.thirdstyle.copyWith(color: Colors.white)),
            const Spacer(),
            Text(location,
                style: AppStyle.socondarystyle.copyWith(color: Colors.white)),
          ],
        ),
        Text(
          userName,
          style: AppStyle.socondarystyle.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.white.withAlpha(150),
          ),
        )
      ],
    );
  }
}
