import 'package:flutter/material.dart';
import 'package:meteo_app_v2/views/heading_view.dart';

class AppHeading extends StatelessWidget {
  final Map<String, dynamic> datas;
  const AppHeading({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadingView(
            cityName: datas["city_info"]["name"],
            condition: datas["current_condition"]["condition"],
            temperature: datas["current_condition"]["tmp"],
            min: datas["fcst_day_0"]["tmin"],
            max: datas["fcst_day_0"]["tmax"]),
      ],
    );
  }
}
