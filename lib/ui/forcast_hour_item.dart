import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_forcast_item.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';

class ForcastHourItem extends MasterForcastItem {
  const ForcastHourItem({
    super.key,
    required super.prevision,
  });

  @override
  Widget build(BuildContext context) {
    final PrevisionHour previsionHour = prevision as PrevisionHour;
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
            previsionHour.hour,
          ),
          Image.network(
            previsionHour.icon,
            width: 30,
          ),
          Text(
            "${previsionHour.temperature}°",
          ),
        ],
      ),
    );
  }
}
