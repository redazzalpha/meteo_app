import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/ui/bar_value.dart';

class ForcastDayItem extends StatelessWidget {
  final PrevisionDay prevision;
  final bool isDot;

  const ForcastDayItem({
    super.key,
    required this.prevision,
    this.isDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      // main row
      child: Row(
        children: [
          // day text
          Text(prevision.dayShort),
          // image icon
          Container(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Image.network(
              prevision.icon,
              width: 30,
            ),
          ),
          // minimal temperature
          Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 10,
            ),
            child: Text(
              "${prevision.min}°",
            ),
          ),
          // bar value
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 300,
              child: BarValue(
                value: prevision.temperature,
                isDot: isDot,
                gradient: prevision.gradient,
              ),
            ),
          ),
          // minimal temperature
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              "${prevision.max}°",
            ),
          ),
        ],
      ),
    );
  }
}
