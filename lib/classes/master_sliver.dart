import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';

abstract class MasterSliver extends StatelessWidget {
  final MasterApp masterApp;
  const MasterSliver({
    super.key,
    required this.masterApp,
  });
}
