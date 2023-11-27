import 'package:flutter/material.dart';

abstract class MasterApp extends StatelessWidget {
  final Map<String, dynamic> datas;
  final double width;
  final double height;

  /// minExt should be used when wrap
  /// in SilverAppListView
  /// minExt is the minimun header item height
  /// when totaly collapsed
  final double? minExt;

  /// maxExt should be used when wrap
  /// in SilverAppListView
  /// maxExt is the maximum header item height
  /// when totaly expanded
  final double? maxExt;

  const MasterApp({
    super.key,
    required this.datas,
    required this.width,
    required this.height,
    this.minExt,
    this.maxExt,
  });
  bool isReady() => datas.isNotEmpty;
}
