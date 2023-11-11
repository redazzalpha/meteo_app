import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/forcast_day_view.dart';

class AppForcastDay extends StatelessWidget {
  final Map<String, dynamic> datas;
  const AppForcastDay({super.key, required this.datas});

  String _normalizeDay(Map<String, dynamic> dailyDatas) {
    return dailyDatas["day_short"] == datas["fcst_day_0"]["day_short"]
        ? "Auj."
        : dailyDatas["day_short"];
  }

  LinearGradient _normalizeGradient(final int min, final int max) {
    final colorStops = generateDefaultColorStop();
    final List<Color> colors = colorStops.map((e) => e.color).toList();
    final List<double> stops = colorStops.map((e) => e.stop).toList();

    double step = diffTemp / colorStops.length;
    int minFactor = (((min - minTemp) / step)).floor();
    int maxFactor = (((max - minTemp) / step)).floor();

    if (minFactor < 2) minFactor = 2;
    if (maxFactor < 3) maxFactor = 3;

    for (int i = 0; i < minFactor - 2; i++) {
      if (i != 0 && i != colorStops.length - 1) {
        stops.remove(colorStops[i].stop);
        colors.remove(colorStops[i].color);
      }
    }
    for (int i = maxFactor; i < colorStops.length - 1; i++) {
      if (i != 0 && i != colorStops.length - 1) {
        stops.remove(colorStops[i].stop);
        colors.remove(colorStops[i].color);
      }
    }

    // stops.remove(colorStops[0].stop);
    // colors.remove(colorStops[0].color);
    // stops.remove(colorStops[1].stop);
    // colors.remove(colorStops[1].color);
    // stops.remove(colorStops[3].stop);
    // colors.remove(colorStops[3].color);
    // stops.remove(colorStops[4].stop);
    // colors.remove(colorStops[4].color);
    // stops.remove(colorStops[5].stop);
    // colors.remove(colorStops[5].color);
    // stops.remove(colorStops[6].stop);
    // colors.remove(colorStops[6].color);
    // stops.remove(colorStops[7].stop);
    // colors.remove(colorStops[7].color);
    // stops.remove(colorStops[8].stop);
    // colors.remove(colorStops[8].color);
    // stops.remove(colorStops[9].stop);
    // colors.remove(colorStops[9].color);
    // stops.remove(colorStops[10].stop);
    // colors.remove(colorStops[10].color);
    // stops.remove(colorStops[11].stop);
    // colors.remove(colorStops[11].color);

    return LinearGradient(
      colors: colors,
      // stops: stops,
      tileMode: TileMode.clamp,
    );
  }

  List<PrevisionDay> _buildPrevisions() {
    final List<PrevisionDay> previsions = <PrevisionDay>[];
    for (int i = 0; i < 5; i++) {
      final Map<String, dynamic> dailyDatas = datas["fcst_day_$i"];
      final min = dailyDatas["tmin"];
      final max = dailyDatas["tmax"];

      previsions.add(
        PrevisionDay(
          dayShort: _normalizeDay(dailyDatas),
          icon: dailyDatas["icon"],
          min: min,
          max: max,
          temperature: normalizeTemperature(
            datas["current_condition"]["tmp"],
          ),
          gradient: _normalizeGradient(
            min,
            max,
          ),
        ),
      );
    }
    return previsions;
  }

  @override
  Widget build(BuildContext context) {
    return ForcastDayView(
      previsions: _buildPrevisions(),
    );
  }
}
