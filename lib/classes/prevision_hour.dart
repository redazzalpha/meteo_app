import 'package:meteo_app_v2/classes/master_prevision.dart';

class PrevisionHour extends MasterPrevison {
  final String hour;

  const PrevisionHour({
    required this.hour,
    required super.icon,
    required super.temperature,
    required super.currentTime,
  });
}
