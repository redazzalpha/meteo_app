import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';

class ForcastDayItem extends StatelessWidget {
  final PrevisionDay prevision;
  const ForcastDayItem({super.key, required this.prevision});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Text(prevision.dayShort),
          const SizedBox(
            width: 2,
          )
        ],
      ),
    );
  }
}
