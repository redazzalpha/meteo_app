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
    super.height = 100,
    super.minExt = 0,
    super.maxExt = 141,
  });

  @override
  Widget build(BuildContext context) {
    return AirView(
      atmosphericPressure: datas["fcst_day_0"]["hourly_data"]
          [normalizeTime(datas["current_condition"]["hour"])]["PRMSL"],
      relativeHumidity: datas["fcst_day_0"]["hourly_data"]
          [normalizeTime(datas["current_condition"]["hour"])]["RH2m"],
      width: width,
      height: height,
      fontHelper: fontHelper,
    );
  }
}
