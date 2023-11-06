import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision.dart';
import 'package:meteo_app_v2/ui/forcast_item.dart';

class ForcastView extends StatelessWidget {
  final List<Prevision> previsions;

  const ForcastView({super.key, required this.previsions});

  List<Widget> buildItems() {
    List<Widget> forcastItems = <Widget>[];
    for (int i = 0; i < 9; i++) {
      forcastItems.add(ForcastItem(
          hour: previsions[i].hour,
          icon: previsions[i].icon,
          temperature: previsions[i].temperature));
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
        children: [
          const Text("Prévision heure par heure"),
          SizedBox(
            width: 300,
            height: 300,
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
