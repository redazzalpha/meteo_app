import 'package:flutter/material.dart';

/// this class should be used
/// with linear gradient class
/// and is used to store color and
/// stop gradient segment
class ColorStops {
  final Color color;
  final double stop;

  const ColorStops({
    required this.color,
    required this.stop,
  });
}
