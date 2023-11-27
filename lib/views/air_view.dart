import 'package:flutter/cupertino.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class AirView extends MasterView {
  final double pression;
  final int humidity;

  const AirView({
    super.key,
    required this.pression,
    required this.humidity,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fontHelper = FontHelper(context: context);

    return TemplateCardColumn(
      title: AppAir.label,
      titleIcon: AppAir.labelIcon,
      width: width,
      height: height,
      widgets: [
        Text("Pression de l'air: $pression", style: fontHelper.label()),
        Text("Humidité: $humidity%", style: fontHelper.label()),
      ],
    );
  }
}
