import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/views/wind_direction_view.dart';

class AppWindDirection extends MasterApp {
  const AppWindDirection({
    super.key,
    required super.datas,
    super.label = "Direction du vent",
    super.labelIcon = Icons.air,
    super.width = 300,
    super.height = 300,
    super.minExt = 0,
    super.maxExt = 375,
  });

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");
    return WindDirectionView(
      windDirection: datas["current_condition"]["wnd_dir"],
      width: width,
      height: height,
    );
  }
}
