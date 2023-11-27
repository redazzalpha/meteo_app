import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/views/heading_view.dart';

class AppHeading extends MasterApp {
  static String label = "";
  static IconData labelIcon = Icons.device_unknown;

  const AppHeading({
    super.key,
    required super.datas,
    super.width = 320,
    super.height = 200,
    super.minExt = 0,
    super.maxExt = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");

    return Column(
      children: [
        HeadingView(
          width: width,
          height: height,
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
