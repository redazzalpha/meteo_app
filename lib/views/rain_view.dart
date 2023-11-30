import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_rain.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class RainView extends MasterView {
  final double rain;
  final double dewPoint;

  const RainView({
    super.key,
    required this.rain,
    required this.dewPoint,
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
      title: AppRain.label,
      titleIcon: AppRain.icon,
      width: width,
      height: height,
      hasHeader: hasHeader,
      hasBackground: hasBackground,
      backgroundColor: backgroundColor,
      fontHelper: fh,
      widgets: [
        Text(
          "Précipitations : $rain mm",
          style: fh.label(),
        ),
        Text(
          "Point de rosée : $dewPoint°",
          style: fh.label(),
        ),
      ],
    );
  }
}
