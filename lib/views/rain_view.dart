import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/layouts/app_rain.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';

class RainView extends MasterView {
  const RainView({
    super.key,
    required super.width,
    required super.height,
    super.fontHelper,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

    return TemplateCardColumn(
      title: AppRain.label,
      titleIcon: AppRain.labelIcon,
      width: width,
      height: height,
      fontHelper: fh,
      widgets: [],
    );
  }
}
