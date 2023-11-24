import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/classes/prevision_day.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/views/forcast_day_view.dart';

class AppForcastDay extends MasterApp {
  const AppForcastDay({
    super.key,
    required super.datas,
    super.label = "Prévisions pour 5 jours",
    super.labelIcon = Icons.calendar_month,
    super.width = 800,
    super.height = 170,
    super.minExt = 0,
    super.maxExt = 220,
  });

  String _normalizeDay(Map<String, dynamic> dailyDatas) {
    return dailyDatas["day_short"] == datas["fcst_day_0"]["day_short"]
        ? "Auj."
        : dailyDatas["day_short"];
  }

  /// normalizeGradient is a function that updates gradient colors
  /// according min and max temperatures
  LinearGradient _normalizeGradient(final int min, final int max) {
    final colorStops = generateDefaultColorStop();
    final List<Color> colors = colorStops.map((e) => e.color).toList();
    List<double> stops = colorStops.map((e) => e.stop).toList();
    // step is the representation of the minimal part
    // of all temperatures based on colors grading
    double step = diffTemp / colorStops.length;
    // factors is the value that mark the corresponding
    // color on the gradient based on given value, in this case
    // min temperature and max temperature.
    // (min - minTemp) & (max - minTemp) is used to
    // to rescale given temperature on min max temperatures scale
    // in this case -20° 50°.
    int minFactor = (((min - minTemp) / step)).floor();
    int maxFactor = (((max - minTemp) / step)).floor();

    // minFactor & maxFactor must be at least 1
    if (minFactor < 1) minFactor = 1;
    if (maxFactor < 1) maxFactor = 1;

    // remove colors that don't correspond to the scale temperature
    for (int i = 0; i < minFactor - 1; i++) {
      colors.remove(colorStops[i].color);
    }
    for (int i = colorStops.length - 1; i > maxFactor - 1; i--) {
      colors.remove(colorStops[i].color);
    }

    // regenerate stops accoding the new gradient
    stops = generateDefaultGradientStops(size: colors.length);

    return LinearGradient(
      colors: colors,
      stops: stops,
    );
  }

  List<PrevisionDay> _buildPrevisions() {
    final List<PrevisionDay> previsions = <PrevisionDay>[];

    for (int i = 0; i < 5; i++) {
      final Map<String, dynamic> dailyDatas = datas["fcst_day_$i"];
      // const min = -20;
      // const max = 50;
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
          ).toString(),
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
    if (!isReady()) return const Text("");
    return ForcastDayView(
      previsions: _buildPrevisions(),
      height: height,
    );
  }
}
