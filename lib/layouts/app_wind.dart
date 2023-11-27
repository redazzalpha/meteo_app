import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/views/wind_view.dart';

class AppWind extends MasterApp {
  static String label = "Direction du vent";
  static IconData labelIcon = Icons.waves;

  const AppWind({
    super.key,
    required super.datas,
    super.width = 320,
    super.height = 300,
    super.minExt = 0,
    super.maxExt = 375,
  });

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");
    return WindView(
      width: width,
      height: height,
      windDirection: datas["current_condition"]["wnd_dir"],
      windSpeed: datas["current_condition"]["wnd_spd"],
      windSpeedRafal: datas["current_condition"]["wnd_gust"],
    );
  }
}
