import 'package:meteo_app_v2/classes/master_prevision.dart';

class PrevisionSun extends MasterPrevison {
  final String hour;
  final String text;

  const PrevisionSun({
    required this.hour,
    required super.icon,
    required this.text,
    super.temperature = "",
  });
}
