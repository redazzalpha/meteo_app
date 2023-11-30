import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/ui/forcast_day_item.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class ForcastDayView extends MasterView {
  final List<PrevisionDay> previsions;

  const ForcastDayView({
    super.key,
    required this.previsions,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
    super.hasHeader = true,
    super.hasBackground = true,
    super.backgroundColor = Colors.transparent,
    super.fontHelper,
  });

  List<Widget> _buildItems() {
    List<ForcastDayItem> forcastItems = <ForcastDayItem>[];
    for (int i = 0; previsions.isNotEmpty && i < previsions.length; i++) {
      forcastItems.add(
        ForcastDayItem(
          prevision: previsions[i],
          hasDot: i == 0 ? true : false,
        ),
      );
    }

    return forcastItems;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateCardColumn(
      widgets: _buildItems(),
      title: "Prévisions pour 5 jours",
      titleIcon: Icons.calendar_month,
      width: width,
      height: height,
      hasHeader: hasHeader,
      hasBackground: hasBackground,
      backgroundColor: backgroundColor,
      fontHelper: fontHelper,
    );
  }
}
