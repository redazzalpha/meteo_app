import 'package:flutter/material.dart';

abstract class MasterApp extends StatelessWidget {
  final Map<String, dynamic> datas;
  final String label;
  final IconData labelIcon;
  final double width;
  final double height;

  /// minExt should be used when wrap
  /// in SilverAppListView
  /// minExt is the minimun header item height
  /// when totaly collapsed
  final double minExt;

  /// maxExt should be used when wrap
  /// in SilverAppListView
  /// maxExt is the maximum header item height
  /// when totaly expanded
  final double maxExt;

  const MasterApp({
    super.key,
    required this.datas,
    required this.label,
    required this.labelIcon,
    required this.width,
    required this.height,
    required this.minExt,
    required this.maxExt,
  });

  bool isReady() => datas.isNotEmpty;
}
