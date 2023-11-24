import 'package:flutter/material.dart';

abstract class MasterView extends StatelessWidget {
  final double width;
  final double height;

  const MasterView({
    super.key,
    required this.width,
    required this.height,
  });
}
