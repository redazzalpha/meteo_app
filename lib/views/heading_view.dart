import 'package:flutter/material.dart';

class HeadingView extends StatelessWidget {
  final String cityName, condition;
  final int temperature, min, max;
  const HeadingView(
      {super.key,
      required this.cityName,
      required this.temperature,
      required this.condition,
      required this.min,
      required this.max});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Text(cityName),
          Text("$temperature°"),
          Text(condition),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_upward),
              Text("$max°"),
              const SizedBox(
                width: 5,
              ),
              const Icon(Icons.arrow_downward),
              Text("$min°"),
            ],
          ),
        ],
      ),
    );
  }
}
