import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/ui/circle_value.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class AirView extends MasterView {
  final double atmosphericPressure;
  final int relativeHumidity;

  const AirView({
    super.key,
    required this.atmosphericPressure,
    required this.relativeHumidity,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
    super.hasHeader = true,
    super.hasBackground = true,
    super.backgroundColor = Colors.transparent,
    super.fontHelper,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

    return TemplateCardColumn(
      title: AppAir.label,
      titleIcon: AppAir.icon,
      width: width,
      height: height,
      hasHeader: hasHeader,
      hasBackground: hasBackground,
      backgroundColor: backgroundColor,
      widgets: [
        // humidity circle value
        CircleValue(
          holeLabel: "Humidité relative $relativeHumidity%",
          value: double.parse(
            "$relativeHumidity",
          ),
        ),

        Text(
          "Pression atmosphérique : $atmosphericPressure",
          style: fh.label(),
        ),
      ],
    );
  }
}
