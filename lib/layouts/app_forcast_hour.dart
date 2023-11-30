import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/classes/master_prevision.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';
import 'package:meteo_app_v2/classes/prevision_sun.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/forcast_hour_view.dart';

class AppForcastHour extends MasterApp {
  static String label = "Prévisions heure par heure";
  static IconData labelIcon = Icons.access_time;

  const AppForcastHour({
    super.key,
    required super.datas,
    super.fontHelper,
    super.width = defaultAppWidth,
    super.height = 120,
    super.hasHeader = false,
    super.hasBackground = true,
    super.backgroundColor = defaultAppBackgroundColor,
  });

  String _formatTime(final int hourInt) {
    if (("$hourInt".length == 1 ? "0$hourInt:00" : "$hourInt:00") ==
        datas["current_condition"]["hour"]) return "Maint.";

    return "$hourInt".length == 1 ? "0$hourInt h" : "$hourInt h";
  }

  void _insertPrevision(
    final List<MasterPrevison> previsions,
    final Map<String, dynamic> hourly,
    final int hourInt,
  ) {
    final String sunrise = datas["city_info"]["sunrise"];
    final String sunset = datas["city_info"]["sunset"];
    final String sunriseHour = "${sunrise.split(':')[0]} h";
    final String sunsetHour = "${sunset.split(':')[0]} h";
    late String hour, icon, temperature;
    late int humidity;
    String text = "";
    bool isSunInfo = false;

    // add hour previsions
    hour = _formatTime(hourInt);
    icon = hourly["ICON"];
    temperature = normalizeTemperature(hourly["TMP2m"]).toString();
    humidity = hourly["RH2m"];

    previsions.add(
      PrevisionHour(
        hour: hour,
        icon: icon,
        temperature: temperature,
        humidity: humidity,
      ),
    );

    // check if sun previsions
    if ("${hourInt > 9 ? '' : '0'}$hourInt h" == sunriseHour) {
      hour = sunrise;
      icon = "assets/weather/sunrise.png";
      text = "Lever";
      isSunInfo = true;
    } else if ("${hourInt > 9 ? '' : '0'}$hourInt h" == sunsetHour) {
      hour = sunset;
      icon = "assets/weather/sunset.png";
      text = "Coucher";
      isSunInfo = true;
    }

    // add sun previsions
    if (isSunInfo) {
      previsions.add(
        PrevisionSun(
          hour: hour,
          icon: icon,
          temperature: temperature,
          text: text,
        ),
      );
    }
  }

  void _createPrevisions(int hourInt, final Map<String, dynamic> hourlyData,
      final List<MasterPrevison> previsions) {
    late Map<String, dynamic> hourly;
    int i = 0, max = 24;
    bool stop = false;

    // create previsons for 24 hours
    while (hourInt + i < max) {
      hourly = hourlyData["${hourInt + i}H00"];
      _insertPrevision(previsions, hourly, (hourInt + i++));
      if (hourInt + i == max && !stop) {
        max = hourInt;
        hourInt = 0;
        i = 0;
        stop = true;
      }
    }
  }

  List<MasterPrevison> _buildPrevisions() {
    final List<MasterPrevison> previsions = <MasterPrevison>[];
    final Map<String, dynamic> hourlyData = datas["fcst_day_0"]["hourly_data"];
    final String hourStr = datas["current_condition"]["hour"].split(":")[0];
    final int hourInt = int.parse(hourStr);

    _createPrevisions(hourInt, hourlyData, previsions);

    return previsions;
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady()) return const Text("");
    return ForcastHourView(
      previsions: _buildPrevisions(),
      width: width,
      height: height,
      hasHeader: hasHeader,
      fontHelper: fontHelper,
    );
  }
}
