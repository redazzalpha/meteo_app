import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/color_stops.dart';

/// normalizeTemperature is a function that convert
/// the given temperature in double to int
/// according the decimal value
int normalizeTemperature(final dynamic temperature) {
  if (temperature.runtimeType.toString() == "double") {
    List<String> temperatureSplit = temperature.toString().split(".");
    int computedTemperature = int.parse(temperatureSplit[0]);
    int decimal = int.parse(temperatureSplit[1]);
    if (decimal > 4) return (computedTemperature + 1);
    return computedTemperature;
  }
  return temperature;
}

List<double> generateDefaultGradientStops({required final int size}) {
  return List<double>.generate(size, (index) {
    return (index + .5) / size;
  });
}

List<Color> generateDefaultGradientColors() {
  return <Color>[
    // const Color.fromARGB(58, 135, 135, 135),
    const Color.fromARGB(255, 255, 255, 255),
    Colors.cyanAccent,
    Colors.cyan,
    Colors.blueAccent,
    Colors.blue,
    Colors.greenAccent,
    Colors.green,
    Colors.yellowAccent,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.orange,
    Colors.redAccent,
    Colors.red,
    const Color.fromARGB(255, 255, 0, 225),
    Colors.purpleAccent,
    Colors.purple,
    // const Color.fromARGB(58, 135, 135, 135),
  ];
}

LinearGradient generateDefaultGradient() {
  final List<Color> defaultColors = generateDefaultGradientColors();
  final List<double> defaultStops =
      generateDefaultGradientStops(size: defaultColors.length);

  return LinearGradient(
    colors: defaultColors,
    stops: defaultStops,
    tileMode: TileMode.mirror,
  );
}

List<ColorStops> generateDefaultColorStop() {
  final defaultColors = generateDefaultGradientColors();
  final defaultStops = generateDefaultGradientStops(size: defaultColors.length);

  return List<ColorStops>.generate(
    defaultColors.length,
    (index) {
      return ColorStops(
        color: defaultColors[index],
        stop: defaultStops[index],
      );
    },
  );
}

/// this function returns the hour
/// from the data [current_condition][hour]
/// as defined in datas
/// should be used in the map dynamic datas
/// received from the api to get hourly datas
/// @params [time] : the string from [current_condition][hour]
String normalizeTime(final String time) {
  // remove zero first and
  // replace from ":" to "H"
  if (time[0] == "0") {
    return "${time[1]}H${time[3]}${time[4]}";
  } else {
    return time.replaceAll(":", "H");
  }
}
