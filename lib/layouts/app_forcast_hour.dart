import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';
import 'package:meteo_app_v2/views/forcast_hour_view.dart';

class AppForcastHour extends StatelessWidget {
  final Map<String, dynamic> datas;

  const AppForcastHour({super.key, required this.datas});

  String computedHour(String currentTime) {
    if (currentTime == datas["current_condition"]["hour"]) return "Maint.";

    final String computedHour =
        currentTime.length == 4 ? "0$currentTime" : currentTime;

    return computedHour.replaceAll(":00", " h");
  }

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

  void createPrevisions(int currentHour, Map<String, dynamic> hourlyData,
      List<PrevisionHour> previsions) {
    int i = 0;

    // day part
    while (currentHour + i < 24) {
      final hourly = hourlyData["${currentHour + i}H00"];
      previsions.add(
        PrevisionHour(
          hour: computedHour("${currentHour + i}:00"),
          icon: hourly["ICON"],
          temperature: normalizeTemperature(hourly["TMP2m"]),
        ),
      );
      i++;
    }

    // set day after
    hourlyData = datas["fcst_day_1"]["hourly_data"];
    final int tempCurrentHour = currentHour;
    currentHour = 0;
    i = 0;

    // night part
    while (currentHour + i < tempCurrentHour) {
      final hourly = hourlyData["${currentHour + i}H00"];
      previsions.add(
        PrevisionHour(
          hour: computedHour("${currentHour + i}:00"),
          icon: hourly["ICON"],
          temperature: normalizeTemperature(hourly["TMP2m"]),
        ),
      );
      i++;
    }
  }

  List<PrevisionHour> buildPrevisions() {
    final List<PrevisionHour> previsions = <PrevisionHour>[];
    final Map<String, dynamic> hourlyData = datas["fcst_day_0"]["hourly_data"];
    final String hour = datas["current_condition"]["hour"].split(":")[0];
    final int currentHour = int.parse(hour);

    createPrevisions(currentHour, hourlyData, previsions);

    return previsions;
  }

  @override
  Widget build(BuildContext context) {
    return ForcastHourView(
      previsions: buildPrevisions(),
    );
  }
}
