import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/views/heading_view.dart';

class AppHeading extends MasterApp {
  static String label = "";
  static IconData labelIcon = Icons.device_unknown;

  const AppHeading({
    super.key,
    required super.datas,
    super.fontHelper,
    super.width = 320,
    super.height = 200,
    super.hasHeader = false,
    super.hasBackground = true,
    super.backgroundColor = defaultAppBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");

    return Column(
      children: [
        HeadingView(
          width: width,
          height: height,
          fontHelper: fontHelper,
          cityName: datas["city_info"]["name"],
          condition: datas["current_condition"]["condition"],
          temperature: datas["current_condition"]["tmp"],
          minTemperature: datas["fcst_day_0"]["tmin"],
          maxTemperature: datas["fcst_day_0"]["tmax"],
        ),
      ],
    );
  }
}
