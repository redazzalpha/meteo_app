import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_forcast_item.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/ui/bar_value.dart';

class ForcastDayItem extends MasterForcastItem {
  final bool hasDot;
  final FontHelper? fontHelper;

  const ForcastDayItem({
    super.key,
    required super.prevision,
    this.fontHelper,
    this.hasDot = false,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);
    final PrevisionDay previsionDay = prevision as PrevisionDay;

    return Container(
      padding: EdgeInsets.zero,
      // main row
      child: Row(
        children: [
          // day text
          Text(
            previsionDay.dayShort,
            style: fh.label(),
          ),

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
              style: fh.label(),
            ),
          ),

          // bar value
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 300,
              child: BarValue(
                value: int.parse(previsionDay.temperature),
                hasDot: hasDot,
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
              style: fh.label(),
            ),
          ),
        ],
      ),
    );
  }
}
