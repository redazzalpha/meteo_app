import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

class HeadingView extends StatelessWidget {
  final String cityName, condition;
  final int temperature, min, max;
  const HeadingView({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final FontHelper fontHelper = FontHelper(context: context);

    return Container(
      width: 320,
      padding: const EdgeInsets.all(0),

      // main column
      child: Column(
        children: [
          // city name
          Text(
            cityName,
            style: fontHelper.headline(),
          ),

          // temperature
          Text(
            "$temperature°",
            style: fontHelper.display(),
          ),

          // condition
          Text(
            condition,
            style: fontHelper.label(),
          ),

          // min max row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon arrow up
              const Icon(
                Icons.arrow_upward,
              ),

              // max temperature
              Text(
                "$max°",
                style: fontHelper.label(),
              ),

              // padding boxed
              const SizedBox(
                width: 5,
              ),

              // icon arrow down
              const Icon(
                Icons.arrow_downward,
              ),

              // min temperature
              Text(
                "$min°",
                style: fontHelper.label(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
