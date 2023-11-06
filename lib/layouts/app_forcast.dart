import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision.dart';
import 'package:meteo_app_v2/views/forcast_view.dart';

class AppForcast extends StatelessWidget {
  final Map<String, dynamic> datas;

  const AppForcast({super.key, required this.datas});

  void createPrevisions(int currentHour, Map<String, dynamic> hourlyData,
      List<Prevision> previsions) {
    int i = 0;

    // day part
    while (currentHour + i < 24) {
      final hourly = hourlyData["${currentHour + i}H00"];
      previsions.add(Prevision(
          hour: "${currentHour + i} h",
          icon: hourly["ICON"],
          temperature: double.parse((hourly["TMP2m"]).toString())));
      i++;
    }

    // set day after
    hourlyData = datas["fcst_day_1"]["hourly_data"];
    int tempCurrentHour = currentHour;
    currentHour = 0;
    i = 0;

    // night part
    while (currentHour + i < tempCurrentHour) {
      final hourly = hourlyData["${currentHour + i}H00"];
      previsions.add(Prevision(
          hour: "${currentHour + i} h",
          icon: hourly["ICON"],
          temperature: double.parse((hourly["TMP2m"]).toString())));
      i++;
    }
  }

  List<Prevision> buildPrevisions() {
    final List<Prevision> previsions = <Prevision>[];
    Map<String, dynamic> hourlyData = datas["fcst_day_0"]["hourly_data"];
    final String hour = datas["current_condition"]["hour"].split(":")[0];
    int currentHour = int.parse(hour);

    createPrevisions(currentHour, hourlyData, previsions);

    return previsions;
  }

  @override
  Widget build(BuildContext context) {
    return ForcastView(
      previsions: buildPrevisions(),
    );
  }
}
