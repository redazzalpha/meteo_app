import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/views/heading_view.dart';

class AppHeading extends MasterApp {
  const AppHeading({
    super.key,
    required super.datas,
    super.label = "App heading",
    super.labelIcon = Icons.device_unknown,
    super.width = 320,
    super.height = 300,
    super.minExt = 0,
    super.maxExt = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");

    return Column(
      children: [
        HeadingView(
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
