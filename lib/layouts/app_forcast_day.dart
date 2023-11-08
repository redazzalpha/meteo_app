import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/views/forcast_day_view.dart';

class AppForcastDay extends StatelessWidget {
  final Map<String, dynamic> datas;

  const AppForcastDay({super.key, required this.datas});

  int normalizeTemperature(dynamic temperature) {
    if (temperature.runtimeType.toString() == "double") {
      List<String> temperatureSplit = temperature.toString().split(".");
      int computedTemperature = int.parse(temperatureSplit[0]);
      int decimal = int.parse(temperatureSplit[1]);
      if (decimal > 4) return (computedTemperature + 1);
      return computedTemperature;
    }
    return temperature;
  }

  List<PrevisionDay> buildPrevisions() {
    final List<PrevisionDay> previsions = <PrevisionDay>[];
    for (int i = 0; i < 5; i++) {
      final Map<String, dynamic> dailyDatas = datas["fcst_day_$i"];
      previsions.add(
        PrevisionDay(
          dayShort: dailyDatas["day_short"],
          icon: dailyDatas["icon"],
          min: dailyDatas["tmin"],
          max: dailyDatas["tmax"],
          temperature: normalizeTemperature(datas["current_condition"]["tmp"]),
        ),
      );
    }
    return previsions;
  }

  @override
  Widget build(BuildContext context) {
    return ForcastDayView(
      previsions: buildPrevisions(),
    );
  }
}
