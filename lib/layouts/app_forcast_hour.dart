import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_prevision.dart';
import 'package:meteo_app_v2/classes/prevision_hour.dart';
import 'package:meteo_app_v2/classes/prevision_sun.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/forcast_hour_view.dart';

class AppForcastHour extends StatelessWidget {
  final Map<String, dynamic> datas;

  const AppForcastHour({
    super.key,
    required this.datas,
  });

  String _normalizeHour(String currentTime) {
    if ((currentTime.length == 4 ? "0$currentTime" : currentTime) ==
        datas["current_condition"]["hour"]) return "Maint.";

    final String normalizedHour =
        currentTime.length == 4 ? "0$currentTime" : currentTime;

    return normalizedHour.replaceAll(":00", " h");
  }

  void _insertPrevision(final List<MasterPrevison> previsions,
      final Map<String, dynamic> hourly, final int currentHour) {
    final String sunrise = datas["city_info"]["sunrise"];
    final String sunset = datas["city_info"]["sunset"];
    final String sunriseHour = "${sunrise.split(':')[0]} h";
    final String sunsetHour = "${sunset.split(':')[0]} h";
    late String hour, icon, temperature;
    String text = "";
    bool isSunInfo = false;

    hour = _normalizeHour("$currentHour:00");
    icon = hourly["ICON"];
    temperature = normalizeTemperature(hourly["TMP2m"]).toString();
    previsions.add(
      PrevisionHour(
        hour: hour,
        icon: icon,
        temperature: temperature,
      ),
    );

    if ("${currentHour > 9 ? '' : '0'}$currentHour h" == sunriseHour) {
      hour = sunrise;
      icon = "assets/weather/sunrise.png";
      text = "Lever";
      isSunInfo = true;
    } else if ("${currentHour > 9 ? '' : '0'}$currentHour h" == sunsetHour) {
      hour = sunset;
      icon = "assets/weather/sunset.png";
      text = "Coucher";
      isSunInfo = true;
    }

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

  void _createPrevisions(int currentHour, Map<String, dynamic> hourlyData,
      List<MasterPrevison> previsions) {
    int i = 0;

    // day part
    while (currentHour + i < 24) {
      final hourly = hourlyData["${currentHour + i}H00"];
      _insertPrevision(previsions, hourly, currentHour + i);
      i++;
    }

    // set day after
    final int tempCurrentHour = currentHour;
    currentHour = 0;
    i = 0;

    // night part
    while (currentHour + i < tempCurrentHour) {
      final hourly = hourlyData["${currentHour + i}H00"];
      _insertPrevision(previsions, hourly, currentHour + i);
      i++;
    }
  }

  List<MasterPrevison> _buildPrevisions() {
    final List<MasterPrevison> previsions = <MasterPrevison>[];
    final Map<String, dynamic> hourlyData = datas["fcst_day_0"]["hourly_data"];
    final String hour = datas["current_condition"]["hour"].split(":")[0];
    final int currentHour = int.parse(hour);

    _createPrevisions(currentHour, hourlyData, previsions);

    return previsions;
  }

  @override
  Widget build(BuildContext context) {
    return ForcastHourView(
      previsions: _buildPrevisions(),
    );
  }
}
