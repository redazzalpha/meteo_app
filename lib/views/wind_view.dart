import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class WindView extends MasterView {
  final String direction;
  final String directionStr;
  final int directionDegrees;
  final int speed;
  final int speed10m;
  final int speedRafal;
  final double windChill;
  final double _angleFactor = 0.017346;

  const WindView({
    super.key,
    required this.direction,
    required this.directionStr,
    required this.directionDegrees,
    required this.speed,
    required this.speed10m,
    required this.speedRafal,
    required this.windChill,
    super.fontHelper,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
  });

  double directionToAngle() {
    return _angleFactor * directionDegrees;
  }

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);
    log(directionDegrees.toString());

    return TemplateCardColumn(
      title: AppWind.label,
      titleIcon: AppWind.labelIcon,
      width: width,
      height: height,
      fontHelper: fh,
      widgets: [
        Stack(
          children: [
            // compass
            Image.asset(
              "assets/weather/compass.png",
              fit: BoxFit.cover,
            ),

            // arrow
            Positioned(
              top: 50,
              left: 122,
              child: Transform.rotate(
                origin: const Offset(0, 0),
                angle: directionToAngle(),
                child: Image.asset(
                  width: 55,
                  "assets/weather/arrow.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Text(
          "Direction : $direction ($directionDegrees°)",
          style: fh.label(),
        ),
        Text(
          "Vitesse à 10m : $speed km/h",
          style: fh.label(),
        ),
        Text(
          "Rafales à 10m : $speedRafal km/h",
          style: fh.label(),
        ),
        Text(
          "Refroidissement éolien : $windChill",
          style: fh.label(),
        ),
      ],
    );
  }
}
