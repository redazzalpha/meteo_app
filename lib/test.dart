import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> chartKey =
        GlobalKey<AnimatedCircularChartState>();

    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(91, Colors.green, rankKey: 'Q1'),
          CircularSegmentEntry(9, Colors.grey, rankKey: 'Q2'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            AnimatedCircularChart(
              key: chartKey,
              holeLabel: "Humidity 95%",
              size: const Size(300.0, 300.0),
              initialChartData: data,
              chartType: CircularChartType.Radial,
            )
          ],
        ),
      ),
    );
  }
}
