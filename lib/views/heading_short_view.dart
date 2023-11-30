import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class HeadingShortView extends MasterView {
  final String cityName, condition;
  final int temperature;

  const HeadingShortView({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
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
        children: <Widget>[
          // city name
          Text(
            cityName,
            style: fh.headline(),
          ),

          // temperature | conditions
          Text(
            "$temperature° | $condition",
            style: fh.label(),
          ),
        ],
      ),
    );
  }
}
