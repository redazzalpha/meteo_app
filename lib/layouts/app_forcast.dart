import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision.dart';
import 'package:meteo_app_v2/views/forcast_view.dart';

class AppForcast extends StatelessWidget {
  final Map<String, dynamic> datas;

  const AppForcast({super.key, required this.datas});

  List<Prevision> buildPrevisions() {
    if (datas.isEmpty) return <Prevision>[];

    final List<Prevision> previsions = <Prevision>[];
    final hourlyData = datas["fcst_day_0"]["hourly_data"];

    for (int i = 0; i < 9; i++) {
      final hourly = hourlyData["${i}H00"];
      previsions.add(Prevision(
          hour: "${i}h00", icon: hourly["ICON"], temperature: hourly["TMP2m"]));
    }

    return previsions;
  }

  @override
  Widget build(BuildContext context) {
    return ForcastView(
      previsions: buildPrevisions(),
    );
  }
}
