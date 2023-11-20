import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_forcast_item.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/ui/bar_value.dart';

class ForcastDayItem extends MasterForcastItem {
  final bool isDot;

  const ForcastDayItem({
    super.key,
    required super.prevision,
    this.isDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final PrevisionDay previsionDay = prevision as PrevisionDay;

    return Container(
      padding: EdgeInsets.zero,
      // main row
      child: Row(
        children: [
          // day text
          Text(previsionDay.dayShort),

          // image icon
          Container(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Image.network(
              previsionDay.icon,
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
              "${previsionDay.min}°",
            ),
          ),

          // bar value
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 300,
              child: BarValue(
                value: int.parse(previsionDay.temperature),
                isDot: isDot,
                gradient: previsionDay.gradient,
                min: previsionDay.min,
                max: previsionDay.max,
              ),
            ),
          ),

          // minimal temperature
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              "${previsionDay.max}°",
            ),
          ),
        ],
      ),
    );
  }
}
