import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/color/color.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isOutlined;
  final double height;
  final bool isLoading;

  const ReusableButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primary,
    this.textColor = AppColors.textPrimary,
    this.isOutlined = false,
    this.height = 60.0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.85;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined ? Colors.transparent : color,
        side: isOutlined
            ? BorderSide(color: textColor, width: 2)
            : BorderSide.none,
        minimumSize: Size(buttonWidth, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.black,
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
    );
  }
}
