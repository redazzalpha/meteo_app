import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_forcast_item.dart';
import 'package:meteo_app_v2/classes/prevision_sun.dart';

class ForcastSunItem extends MasterForcastItem {
  const ForcastSunItem({super.key, required super.prevision});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 15,
        right: 15,
      ),
      child: Column(
        children: [
          Text(
            (prevision as PrevisionSun).hour,
          ),
          Image.asset(
            prevision.icon,
            width: 30,
          ),
          Text(
            (prevision as PrevisionSun).text,
          ),
        ],
      ),
    );
  }
}
