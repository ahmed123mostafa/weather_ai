import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.grey),
        child: Column(
          children: [
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Icon(
              Icons.sunny,
              color: Colors.white,
              size: 24,
            ),
            Text(
              "data",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
