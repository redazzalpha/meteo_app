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
      child: Row(
        children: [
          Text(prevision.dayShort),
          const SizedBox(
            width: 50,
          ),
          Image.network(
            prevision.icon,
            width: 30,
          ),
          const SizedBox(
            width: 50,
          ),
          Text(
            "${prevision.min}°",
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 150,
            child: BarValue(
              value: int.parse(prevision.temperature.toString().split(".")[0]),
              isDot: isDot,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            "${prevision.max}°",
          ),
        ],
      ),
    );
  }
}
