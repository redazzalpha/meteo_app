import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_prevision.dart';

abstract class MasterForcastItem extends StatelessWidget {
  final MasterPrevison prevision;

  const MasterForcastItem({super.key, required this.prevision});
}
