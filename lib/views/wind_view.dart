import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class WindView extends MasterView {
  final String windDirection;
  final int windSpeed;
  final int windSpeedRafal;
  final double _degreeFactor = 0.79;

  const WindView({
    super.key,
    required this.windDirection,
    required this.windSpeed,
    required this.windSpeedRafal,
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
    FontHelper fontHelper = FontHelper(context: context);

    return TemplateCardColumn(
      title: "${AppWind.label} : $windDirection",
      titleIcon: AppWind.labelIcon,
      width: width,
      height: height,
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
          "Vitesse du vent: $windSpeed",
          style: fontHelper.label(),
        ),
        Text(
          "Vitesse du vent en rafale: $windSpeedRafal",
          style: fontHelper.label(),
        ),
      ],
    );
  }
}
