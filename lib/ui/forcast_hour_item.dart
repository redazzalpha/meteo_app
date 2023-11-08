import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';

class ForcastHourItem extends StatelessWidget {
  final PrevisionHour prevision;

  const ForcastHourItem({super.key, required this.prevision});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 15,
        right: 15,
      ),
      child: Column(
        children: [
          Text(
            prevision.hour,
          ),
          Image.network(
            prevision.icon,
            width: 30,
          ),
          Text(
            "${prevision.temperature}°",
          ),
        ],
      ),
    );
  }
}
