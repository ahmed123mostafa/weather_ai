import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lottie/Animation - 1739300922614.json"),
        Text(
          "welcome to my App",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 255, 199, 59),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
