import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class HeadingView extends MasterView {
  final String cityName, condition;
  final int temperature, minTemperature, maxTemperature;

  const HeadingView({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.minTemperature,
    required this.maxTemperature,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
    super.hasHeader = false,
    super.hasBackground = false,
    super.backgroundColor = Colors.transparent,
    super.fontHelper,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: hasBackground ? backgroundColor : Colors.transparent,
      ),

      // main column
      child: Column(
        children: [
          // city name
          Text(
            cityName,
            style: fh.headline(),
          ),

          // temperature
          Text(
            "$temperature°",
            style: fh.display(),
          ),

          // condition
          Text(
            condition,
            style: fh.label(),
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
                "$maxTemperature°",
                style: fh.label(),
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
                "$minTemperature°",
                style: fh.label(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
