import 'package:flutter/material.dart';
import 'package:meteo_app_v2/views/heading_view.dart';

class AppHeading extends StatelessWidget {
  final Map<String, dynamic> datas;
  const AppHeading({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeadingView(),
      ],
    );
  }
}
