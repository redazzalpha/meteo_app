import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/defines.dart';
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
    super.minExt = 0,
    super.maxExt = 141,
  });

  @override
  Widget build(BuildContext context) {
    return RainView(
      width: width,
      height: height,
      fontHelper: fontHelper,
    );
  }
}
