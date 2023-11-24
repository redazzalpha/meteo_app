import 'package:flutter/material.dart';

abstract class MasterApp extends StatelessWidget {
  final Map<String, dynamic> datas;
  final String label;
  final IconData labelIcon;
  final double minExt;
  final double maxExt;

  const MasterApp({
    super.key,
    required this.datas,
    required this.label,
    required this.labelIcon,
    required this.minExt,
    required this.maxExt,
  });

  bool isReady() => datas.isNotEmpty;
}
