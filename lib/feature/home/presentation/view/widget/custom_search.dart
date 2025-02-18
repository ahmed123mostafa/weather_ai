import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/color/color.dart';

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
