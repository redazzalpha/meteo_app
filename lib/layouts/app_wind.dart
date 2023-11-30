import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/wind_view.dart';

class AppWind extends MasterApp {
  static String label = "Conditions du vent";
  static IconData labelIcon = Icons.waves;

  const AppWind({
    super.key,
    required super.datas,
    super.fontHelper,
    super.width = 320,
    super.height = 415,
    super.hasHeader = false,
    super.hasBackground = true,
    super.backgroundColor = defaultAppBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");
    final String currentTime = datas["current_condition"]["hour"];
    final Map<String, dynamic> hourly =
        datas["fcst_day_0"]["hourly_data"][normalizeTime(currentTime)];

    return WindView(
      direction: datas["current_condition"]["wnd_dir"],
      speed: datas["current_condition"]["wnd_spd"],
      directionStr: hourly["WNDDIRCARD10"],
      directionDegrees: hourly["WNDDIR10m"],
      speed10m: hourly["WNDSPD10m"],
      speedRafal: hourly["WNDGUST10m"],
      windChill: fixInt(hourly["WNDCHILL2m"]),
      width: width,
      height: height,
      hasHeader: hasHeader,
      fontHelper: fontHelper,
    );
  }
}
