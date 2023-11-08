import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/templates/template_card_column.dart';
import 'package:meteo_app_v2/ui/forcast_day_item.dart';

class ForcastDayView extends StatelessWidget {
  final List<PrevisionDay> previsions;

  const ForcastDayView({super.key, required this.previsions});

  int temperatureToInt(double temperature) {
    List<String> temperatureSplit = temperature.toString().split(".");
    int computedTemperature = int.parse(temperatureSplit[0]);
    int decimal = int.parse(temperatureSplit[1]);
    if (decimal > 4) return (computedTemperature + 1);
    return computedTemperature;
  }

  List<Widget> buildItems() {
    List<Widget> forcastItems = <Widget>[];
    for (int i = 0; previsions.isNotEmpty && i < previsions.length; i++) {
      forcastItems.add(
        ForcastDayItem(
          prevision: previsions[i],
          isDot: i == 0 ? true : false,
        ),
      );
    }

    return forcastItems;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateCardColumn(
      widgets: buildItems(),
      height: 150,
      title: "Prévisions pour 5 jours",
      titleIcon: Icons.calendar_month,
    );
  }
}
