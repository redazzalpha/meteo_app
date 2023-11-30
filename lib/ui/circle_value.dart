import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';

class CircleValue extends StatelessWidget {
  final double value;
  final String holeLabel;
  final double width;
  final double height;
  final double min = 0;
  final double max = 100;

  const CircleValue({
    super.key,
    required this.value,
    this.holeLabel = "",
    this.width = 300,
    this.height = 300,
  });

  List<CircularStackEntry> charData() {
    return <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(value, Colors.blue, rankKey: 'Q1'),
          CircularSegmentEntry(max - value, Colors.grey, rankKey: 'Q2'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> chartKey =
        GlobalKey<AnimatedCircularChartState>();

    return AnimatedCircularChart(
      initialChartData: charData(),
      key: chartKey,
      duration: const Duration(milliseconds: 0),
      edgeStyle: SegmentEdgeStyle.round,
      holeLabel: holeLabel,
      size: Size(width, height),
      chartType: CircularChartType.Radial,
    );
  }
}
