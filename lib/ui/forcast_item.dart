import 'package:flutter/material.dart';

class ForcastItem extends StatelessWidget {
  final String hour, icon;
  final int temperature;

  const ForcastItem(
      {super.key,
      required this.hour,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      child: Column(
        children: [
          Text(
            hour,
          ),
          Image.network(
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
