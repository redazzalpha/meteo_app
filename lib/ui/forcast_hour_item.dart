import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_forcast_item.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';

class ForcastHourItem extends MasterForcastItem {
  final FontHelper? fontHelper;

  const ForcastHourItem({
    super.key,
    required super.prevision,
    this.fontHelper,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);
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
            style: fh.label(),
          ),

          // image icon
          Image.network(
            previsionHour.icon,
            width: 30,
          ),

          // temperature
          Text(
            "${previsionHour.temperature}°",
            style: fh.label(),
          ),

          Row(
            children: [
              Image.asset(
                "assets/weather/humidity.png",
                width: 18,
              ),
              Text(
                "${previsionHour.humidity}%",
                style: fh.label(),
              ),
            ],
          ),
          // humidity
        ],
      ),
    );
  }
}
