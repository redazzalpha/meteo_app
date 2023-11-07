import 'package:flutter/material.dart';
import 'package:meteo_app_v2/ui/bar_value.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(5),
          child: const BarValue(
            value: 30,
          ),
        ),
      ),
    );
  }
}
