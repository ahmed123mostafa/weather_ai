import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/color/color.dart';

class ReusableInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final bool obscureText;
  final double heightPadding;

  const ReusableInputField({
    Key? key,
    required this.labelText,
    required this.keyboardType,
    required this.validator,
    this.controller,
    this.obscureText = false,
    this.heightPadding = 16,
  }) : super(key: key);

  @override
  _ReusableInputFieldState createState() => _ReusableInputFieldState();
}

class _ReusableInputFieldState extends State<ReusableInputField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: widget.heightPadding, horizontal: 15.0),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
      ),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.obscureText && !isPasswordVisible,
      cursorColor: AppColors.secondary,
    );
  }
}
