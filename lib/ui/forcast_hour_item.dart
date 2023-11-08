import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';

class ForcastHourItem extends StatelessWidget {
  final PrevisionHour prevision;

  const ForcastHourItem({super.key, required this.prevision});

  String computedHour() {
    log("current time: ${prevision.currentTime} - prevision.hour: ${prevision.hour}");
    if (int.parse((prevision.currentTime.split(":")[0])) ==
        int.parse(prevision.hour.split(" ")[0])) return "Maint.";
    final String computedHour =
        prevision.hour.length == 3 ? "0${prevision.hour}" : prevision.hour;

    return computedHour;
  }

  int temperatureToInt(double temperature) {
    List<String> temperatureSplit = temperature.toString().split(".");
    int computedTemperature = int.parse(temperatureSplit[0]);
    int decimal = int.parse(temperatureSplit[1]);
    if (decimal > 4) return (computedTemperature + 1);
    return computedTemperature;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      child: Column(
        children: [
          Text(
            computedHour(),
          ),
          Image.network(
            prevision.icon,
            width: 30,
          ),
          Text(
            "${temperatureToInt(prevision.temperature)}°",
          ),
        ],
      ),
    );
  }
}
