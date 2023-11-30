import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

abstract class MasterView extends StatelessWidget {
  final double width;
  final double height;
  final bool hasHeader;
  final bool hasBackground;
  final Color backgroundColor;
  final FontHelper? fontHelper;

  const MasterView({
    super.key,
    required this.width,
    required this.height,
    required this.hasHeader,
    required this.hasBackground,
    required this.backgroundColor,
    this.fontHelper,
  });
}
