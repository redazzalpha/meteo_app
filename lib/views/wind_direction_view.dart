import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';

class WindDirectionView extends MasterView {
  final String windDirection;
  final double _degreeFactor = 0.79;

  const WindDirectionView({
    super.key,
    required this.windDirection,
    super.width = 320,
    super.height = 300,
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
    log("wind direction: $windDirection");
    return TemplateCardColumn(
      title: "Direction du vent",
      titleIcon: Icons.air,
      width: 320,
      height: 300,
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
      ],
    );
  }
}
