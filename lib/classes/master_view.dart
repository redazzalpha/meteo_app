import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

abstract class MasterView extends StatelessWidget {
  final double width;
  final double height;
  final FontHelper? fontHelper;

  const MasterView({
    super.key,
    required this.width,
    required this.height,
    this.fontHelper,
  });
}
