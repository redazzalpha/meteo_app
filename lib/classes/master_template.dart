import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

abstract class MasterTemplate extends StatelessWidget {
  final String? title;
  final IconData? titleIcon;
  final bool hasHeader;

  final bool hasBackground;
  final Color backgroundColor;
  final FontHelper? fontHelper;

  const MasterTemplate({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.hasHeader,
    required this.hasBackground,
    required this.backgroundColor,
    this.fontHelper,
  });
}
