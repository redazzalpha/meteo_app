import 'dart:developer';

import 'package:flutter/material.dart';

class BarValue extends StatefulWidget {
  final int value;
  const BarValue({super.key, this.value = 0});

  @override
  State<StatefulWidget> createState() => _BarValueState();
}

class _BarValueState extends State<BarValue> {
  final GlobalKey _containerKey = GlobalKey();
  double _currentWidth = 0;
  double _step = 0;
  double _valuePos = 0;

  void computeSliderPos() {
    _currentWidth = _containerKey.currentContext!.size!.width;
    _step = _currentWidth / 70;
    _valuePos = (double.parse(widget.value.toString()) + 20) * _step;
  }

  @override
  void initState() {
    super.initState();
    log("-- init state here");
  }

  @override
  Widget build(BuildContext context) {
    log("-- build here");

    return OrientationBuilder(
      builder: (context, orientation) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            computeSliderPos();
            log("-- setstate here with _currentWidth: ${_currentWidth.toString()}");
            log("-- setstate here with _step: ${_step.toString()}");
            log("-- setstate here with _valuePos: ${_valuePos.toString()}");
          },
        );

        return Stack(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              key: _containerKey,
              height: 7,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
                  gradient:
                      LinearGradient(tileMode: TileMode.mirror, colors: <Color>[
                    Colors.blueAccent,
                    Colors.blue,
                    Colors.greenAccent,
                    Colors.green,
                    Colors.yellowAccent,
                    Colors.yellow,
                    Colors.orangeAccent,
                    Colors.orange,
                    Colors.redAccent,
                    Colors.red,
                  ])),
              margin: const EdgeInsets.only(top: 1.4),
              child: const Column(
                children: [],
              ),
            ),
            Positioned(
              left: _valuePos,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
