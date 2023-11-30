import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/air_view.dart';

class AppAir extends MasterApp {
  static String label = "Conditions de l'air";
  static IconData labelIcon = Icons.air;

  const AppAir({
    super.key,
    required super.datas,
    super.fontHelper,
    super.width = defaultAppWidth,
    super.height = 355,
    super.hasHeader = false,
    super.hasBackground = true,
    super.backgroundColor = defaultAppBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final String currentTime = datas["current_condition"]["hour"];
    final Map<String, dynamic> hourly =
        datas["fcst_day_0"]["hourly_data"][normalizeTime(currentTime)];

    return AirView(
      atmosphericPressure: fixDouble(hourly["PRMSL"]),
      relativeHumidity: hourly["RH2m"],
      width: width,
      height: height,
      hasHeader: hasHeader,
      fontHelper: fontHelper,
    );
  }
}
