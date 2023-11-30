import 'package:flutter/material.dart';
import 'package:meteo_app_v2/ui/sliver_heading.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverHeading(),
        ],
      ),
    );
  }
}
