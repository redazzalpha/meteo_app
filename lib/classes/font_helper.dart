import 'package:flutter/material.dart';

class FontHelper {
  final BuildContext context;
  const FontHelper({required this.context});

  TextStyle headline() => Theme.of(context).textTheme.headlineLarge!.copyWith();
  TextStyle display() => Theme.of(context).textTheme.displayLarge!.copyWith();
  TextStyle label() => Theme.of(context).textTheme.labelLarge!.copyWith();
}
