import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_app.dart';

abstract class MasterAppSliver extends StatelessWidget {
  final MasterApp masterApp;
  const MasterAppSliver({
    super.key,
    required this.masterApp,
  });
}
