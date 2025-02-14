// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/feature/Authentication/presentation/view/login_view.dart';
import 'package:flutter_weather_ai/feature/onboarding/first_screen.dart';
import 'package:flutter_weather_ai/feature/onboarding/socond_Screen.dart';
import 'package:flutter_weather_ai/feature/onboarding/third_screen.dart';
import 'package:flutter_weather_ai/feature/onboarding/widget/custom_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  // ignore: prefer_final_fields
  PageController _controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: PageView(
            onPageChanged: (value) {
              setState(() {
                index = value;
              });
            },
            controller: _controller,
            children: [FirstScreen(), SocondScreen(), ThirdScreen()],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIndicator(active: index == 0),
              SizedBox(width: 5),
              CustomIndicator(active: index == 1),
              SizedBox(width: 5),
              CustomIndicator(active: index == 2),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
                  },
                  child: Text(
                    index == 2 ? "Register" : "Skip",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
                    if (index == 2) {
                    } else {
                      _controller.animateToPage(index + 1,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.linear);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 199, 59),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      index == 2 ? "Login" : "Next",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
