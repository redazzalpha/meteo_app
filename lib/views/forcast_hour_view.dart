import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';
import 'package:meteo_app_v2/templates/template_card_row.dart';
import 'package:meteo_app_v2/ui/forcast_hour_item.dart';

class ForcastHourView extends StatelessWidget {
  final List<PrevisionHour> previsions;

  const ForcastHourView({super.key, required this.previsions});

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
      String computedHour = previsions[i].hour.length == 3
          ? "0${previsions[i].hour}"
          : previsions[i].hour;
      forcastItems.add(
        ForcastHourItem(
          hour: i == 0 ? "Maint." : computedHour,
          icon: previsions[i].icon,
          temperature: temperatureToInt(previsions[i].temperature),
        ),
      );
    }

    return forcastItems;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateCardRow(
      widgets: buildItems(),
      title: "Prévision heure par heure",
      titleIcon: Icons.access_time,
    );
  }
}