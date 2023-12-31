import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_prevision.dart';
import 'package:meteo_app_v2/classes/master_view.dart';
import 'package:meteo_app_v2/templates/template_card_row.dart';
import 'package:meteo_app_v2/ui/forcast_hour_item.dart';
import 'package:meteo_app_v2/ui/forcast_sun_item.dart';
import 'package:meteo_app_v2/utils/defines.dart';

class ForcastHourView extends MasterView {
  final List<MasterPrevison> previsions;

  const ForcastHourView({
    super.key,
    required this.previsions,
    super.width = defaultAppWidth,
    super.height = defaultAppHeight,
    super.hasHeader = true,
    super.hasBackground = true,
    super.backgroundColor = Colors.transparent,
    super.fontHelper,
  });

  void _insertItem(final List<Widget> items, MasterPrevison prevision) {
    if (prevision.runtimeType.toString() == "PrevisionHour") {
      items.add(ForcastHourItem(prevision: prevision));
    } else {
      items.add(ForcastSunItem(prevision: prevision));
    }
  }

  List<Widget> _buildItems() {
    List<Widget> forcastItems = <Widget>[];
    for (int i = 0; previsions.isNotEmpty && i < previsions.length; i++) {
      _insertItem(forcastItems, previsions[i]);
    }

    return forcastItems;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateCardRow(
      widgets: _buildItems(),
      title: "Prévisions heure par heure",
      titleIcon: Icons.access_time,
      width: width,
      height: height,
      hasHeader: hasHeader,
      hasBackground: hasBackground,
      backgroundColor: backgroundColor,
      fontHelper: fontHelper,
    );
  }
}
