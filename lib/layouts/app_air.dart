import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/views/air_view.dart';

class AppAir extends MasterApp {
  static String label = "Air";
  static IconData labelIcon = Icons.air;

  const AppAir({
    super.key,
    required super.datas,
    super.width = defaultAppWidth,
    super.height = 100,
    super.minExt = 0,
    super.maxExt = 141,
  });

  @override
  Widget build(BuildContext context) {
    return AirView(
      pression: datas["current_condition"]["pressure"],
      humidity: datas["current_condition"]["humidity"],
      width: width,
      height: height,
    );
  }
}
