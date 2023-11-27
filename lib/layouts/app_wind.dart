import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
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

  String normalizeHour() {
    final String hour = datas["current_condition"]["hour"];
    if (hour[0] == "0") {
      return "${hour[1]}H${hour[3]}${hour[4]}";
    } else {
      return hour.replaceAll(":", "H");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");
    return WindView(
      windDirection: datas["current_condition"]["wnd_dir"],
      windDirectionStr: datas["fcst_day_0"]["hourly_data"][normalizeHour()]
          ["WNDDIRCARD10"],
      windDirectionDegrees: datas["fcst_day_0"]["hourly_data"][normalizeHour()]
          ["WNDDIR10m"],
      windSpeed: datas["current_condition"]["wnd_spd"],
      windSpeed10m: datas["fcst_day_0"]["hourly_data"][normalizeHour()]
          ["WNDSPD10m"],
      windSpeedRafal: datas["fcst_day_0"]["hourly_data"][normalizeHour()]
          ["WNDGUST10m"],
      windChill: datas["fcst_day_0"]["hourly_data"][normalizeHour()]
          ["WNDCHILL2m"],
      width: width,
      height: height,
      fontHelper: fontHelper,
    );
  }
}
