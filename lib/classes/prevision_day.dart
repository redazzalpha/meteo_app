class PrevisionDay {
  final String dayShort;
  final String icon;
  final int min;
  final int max;
  final double currentTemperature;

  const PrevisionDay(
      {required this.dayShort,
      required this.icon,
      required this.min,
      required this.max,
      required this.currentTemperature});
}
