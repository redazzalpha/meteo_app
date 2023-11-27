import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/wind_view.dart';

class AppWind extends MasterApp {
  static String label = "Conditions du vent";
  static IconData labelIcon = Icons.air;

  const AppWind({
    super.key,
    required super.datas,
    super.fontHelper,
    super.width = 320,
    super.height = 300,
    super.minExt = 0,
    super.maxExt = 375,
  });

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");
    final String currentTime = datas["current_condition"]["hour"];
    final Map<String, dynamic> hourly =
        datas["fcst_day_0"]["hourly_data"][normalizeTime(currentTime)];

    return WindView(
      windDirection: datas["current_condition"]["wnd_dir"],
      windSpeed: datas["current_condition"]["wnd_spd"],
      windDirectionStr: hourly["WNDDIRCARD10"],
      windDirectionDegrees: hourly["WNDDIR10m"],
      windSpeed10m: hourly["WNDSPD10m"],
      windSpeedRafal: hourly["WNDGUST10m"],
      windChill: hourly["WNDCHILL2m"],
      width: width,
      height: height,
      fontHelper: fontHelper,
    );
  }
}
