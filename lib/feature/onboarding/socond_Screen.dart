import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SocondScreen extends StatelessWidget {
  const SocondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lottie/Animation - 1739301146317.json"),
        Text(
          "No ads to watch\n weather",
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
