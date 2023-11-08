import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';
import 'package:meteo_app_v2/templates/template_card_row.dart';
import 'package:meteo_app_v2/ui/forcast_hour_item.dart';

class ForcastHourView extends StatelessWidget {
  final List<PrevisionHour> previsions;

  const ForcastHourView({super.key, required this.previsions});

  List<Widget> buildItems() {
    List<Widget> forcastItems = <Widget>[];
    for (int i = 0; previsions.isNotEmpty && i < previsions.length; i++) {
      forcastItems.add(
        ForcastHourItem(
          prevision: previsions[i],
        ),
      );
    }

    return forcastItems;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateCardRow(
      widgets: buildItems(),
      title: "Prévisions heure par heure",
      titleIcon: Icons.access_time,
    );
  }
}
