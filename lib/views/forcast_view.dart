import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision.dart';
import 'package:meteo_app_v2/ui/forcast_item.dart';

class ForcastView extends StatelessWidget {
  final List<Prevision> previsions;

  const ForcastView({super.key, required this.previsions});

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
        ForcastItem(
          hour: i == 0 ? "Maint." : previsions[i].hour,
          icon: previsions[i].icon,
          temperature: temperatureToInt(previsions[i].temperature),
        ),
      );
    }

    return forcastItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(91, 255, 255, 255),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Prévision heure par heure"),
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white))),
          ),
          SizedBox(
            width: 800,
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: buildItems(),
            ),
          )
        ],
      ),
    );
  }
}
