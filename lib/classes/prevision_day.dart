import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_prevision.dart';

class PrevisionDay extends MasterPrevison {
  final String dayShort;
  final int min;
  final int max;
  final LinearGradient gradient;

  const PrevisionDay({
    required this.dayShort,
    required this.min,
    required this.max,
    required super.icon,
    required super.temperature,
    this.gradient = const LinearGradient(
      colors: <Color>[],
    ),
  });
}
