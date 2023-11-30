import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

abstract class MasterApp extends StatelessWidget {
  final Map<String, dynamic> datas;
  final double width;
  final double height;
  final bool hasHeader;
  final bool hasBackground;
  final Color? backgroundColor;
  final FontHelper? fontHelper;

  const MasterApp({
    super.key,
    required this.datas,
    required this.width,
    required this.height,
    required this.hasHeader,
    required this.hasBackground,
    this.backgroundColor,
    this.fontHelper,
  });
  bool isReady() => datas.isNotEmpty;
}
