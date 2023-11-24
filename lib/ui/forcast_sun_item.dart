import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_forcast_item.dart';
import 'package:meteo_app_v2/classes/prevision_sun.dart';

class ForcastSunItem extends MasterForcastItem {
  const ForcastSunItem({
    super.key,
    required super.prevision,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fontHelper = FontHelper(context: context);

    final PrevisionSun previsionSun = prevision as PrevisionSun;

    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 15,
        right: 15,
      ),

      // main column
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // time text
          Text(
            previsionSun.hour,
            style: fontHelper.label(),
          ),

          // image icon
          Image.asset(
            previsionSun.icon,
            width: 30,
          ),

          // sun state text
          Text(
            previsionSun.text,
            style: fontHelper.label(),
          ),
        ],
      ),
    );
  }
}
