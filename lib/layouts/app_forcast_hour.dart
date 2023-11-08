import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';
import 'package:meteo_app_v2/views/forcast_hour_view.dart';

class AppForcastHour extends StatelessWidget {
  final Map<String, dynamic> datas;

  const AppForcastHour({super.key, required this.datas});

  void createPrevisions(int currentHour, Map<String, dynamic> hourlyData,
      List<PrevisionHour> previsions) {
    int i = 0;

    // day part
    while (currentHour + i < 24) {
      final hourly = hourlyData["${currentHour + i}H00"];
      previsions.add(
        PrevisionHour(
          hour: "${currentHour + i} h",
          icon: hourly["ICON"],
          temperature: double.parse((hourly["TMP2m"]).toString()),
          currentTime: datas["current_condition"]["hour"],
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
          hour: "${currentHour + i} h",
          icon: hourly["ICON"],
          temperature: double.parse((hourly["TMP2m"]).toString()),
          currentTime: datas["current_condition"]["hour"],
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
