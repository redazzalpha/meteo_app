import 'package:flutter/material.dart';

abstract class MasterTemplate extends StatelessWidget {
  final String? title;
  final IconData? titleIcon;
  final bool hasBackground;
  final Color backgroundColor;

  const MasterTemplate({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.hasBackground,
    required this.backgroundColor,
  });
}
