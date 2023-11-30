import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/rain_view.dart';

class AppRain extends MasterApp {
  static String label = "Précipitations";
  static IconData labelIcon = Icons.cloudy_snowing;

  const AppRain({
    super.key,
    required super.datas,
    super.fontHelper,
    super.width = defaultAppWidth,
    super.height = 100,
    super.hasHeader = false,
    super.hasBackground = true,
    super.backgroundColor = defaultAppBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final String currentTime = datas["current_condition"]["hour"];
    final Map<String, dynamic> hourly =
        datas["fcst_day_0"]["hourly_data"][normalizeTime(currentTime)];

    return RainView(
      rain: fixDouble(hourly["APCPsfc"]),
      dewPoint: hourly["DPT2m"],
      width: width,
      height: height,
      hasHeader: hasHeader,
      fontHelper: fontHelper,
    );
  }
}
