import 'package:flutter/material.dart';

class ForcastItem extends StatelessWidget {
  final String hour, icon;
  final double temperature;

  const ForcastItem(
      {super.key,
      required this.hour,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            hour,
          ),
          Image.asset(
            icon,
            width: 30,
          ),
          Text(
            "$temperature°",
          ),
        ],
      ),
    );
  }
}
