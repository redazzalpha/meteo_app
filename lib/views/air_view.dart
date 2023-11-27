import 'package:flutter/cupertino.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class AirView extends MasterView {
  final double atmosphericPressure;
  final int relativeHumidity;

  const AirView({
    super.key,
    required this.atmosphericPressure,
    required this.relativeHumidity,
    super.fontHelper,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

    return TemplateCardColumn(
      title: AppAir.label,
      titleIcon: AppAir.labelIcon,
      width: width,
      height: height,
      widgets: [
        Text(
          "Pression atmosphérique : $atmosphericPressure",
          style: fh.label(),
        ),
        Text(
          "Humidité relative : $relativeHumidity%",
          style: fh.label(),
        ),
      ],
    );
  }
}
