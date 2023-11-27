import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class WindView extends MasterView {
  final String windDirection;
  final String windDirectionStr;
  final int windDirectionDegrees;
  final int windSpeed;
  final int windSpeed10m;
  final int windSpeedRafal;
  final double windChill;
  final double _degreeFactor = 0.79;

  const WindView({
    super.key,
    required this.windDirection,
    required this.windDirectionStr,
    required this.windDirectionDegrees,
    required this.windSpeed,
    required this.windSpeed10m,
    required this.windSpeedRafal,
    required this.windChill,
    super.fontHelper,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
  });

  double windDirectionToAngle() {
    double angle = 0;
    switch (windDirection) {
      case "N":
        break;
      case "NE":
        angle += _degreeFactor * 1;
      case "NO":
        angle += _degreeFactor * 2;
      case "S":
        angle += _degreeFactor * 3;
      case "SE":
        angle += _degreeFactor * 4;
      case "SO":
        angle += _degreeFactor * 5;
      case "E":
        angle += _degreeFactor * 6;
      case "O":
        angle += _degreeFactor * 7;
      default:
        return 0;
    }
    return angle;
  }

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

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
              top: 30,
              left: 115,
              child: Transform.rotate(
                origin: const Offset(0, 35),
                angle: windDirectionToAngle(),
                child: Image.asset(
                  width: 70,
                  "assets/weather/arrow.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Text(
          "Direction : $windDirection",
          style: fh.label(),
        ),
        Text(
          "Vitesse à 10m : $windSpeed km/h",
          style: fh.label(),
        ),
        Text(
          "Rafales à 10m : $windSpeedRafal km/h",
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
