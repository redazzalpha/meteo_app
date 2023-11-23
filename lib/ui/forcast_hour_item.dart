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
        left: 15,
        right: 15,
      ),
      // main column
      child: Column(
        children: [
          // time text
          Text(
            previsionHour.hour,
          ),

          // image icon
          Image.network(
            previsionHour.icon,
            width: 30,
          ),

          // temperature
          Text(
            "${previsionHour.temperature}°",
          ),

          Row(
            children: [
              Image.asset(
                "assets/weather/humidity.png",
                width: 18,
              ),
              Text("${previsionHour.humidity}%"),
            ],
          ),
          // humidity
        ],
      ),
    );
  }
}
