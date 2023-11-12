import 'package:flutter/material.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';

class BarValue extends StatefulWidget {
  final int value;
  final bool isDot;
  final LinearGradient gradient;
  const BarValue({
    super.key,
    this.value = 0,
    this.isDot = false,
    this.gradient = const LinearGradient(
      colors: <Color>[],
    ),
  });

  LinearGradient _linearGradient() {
    return gradient.colors.isEmpty ? generateDefaultGradient() : gradient;
  }

  @override
  State<StatefulWidget> createState() => _BarValueState();
}

class _BarValueState extends State<BarValue> {
  final GlobalKey _containerKey = GlobalKey();
  double _currentWidth = 0;
  double _step = 0;
  double _valuePos = 0;

  void _computeSliderPos() {
    _currentWidth = _containerKey.currentContext!.size!.width;
    _step = _currentWidth / diffTemp;
    _valuePos = (double.parse(widget.value.toString()) - minTemp) * _step;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _computeSliderPos());
        // main stack
        return Stack(
          children: [
            // sized box height padding
            const SizedBox(
              height: 10,
            ),
            // value bar
            Container(
              key: _containerKey,
              height: 7,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(50, 50),
                ),
                gradient: widget._linearGradient(),
              ),
              margin: const EdgeInsets.only(top: 1.4),
            ),
            // button slider
            if (widget.isDot)
              Positioned(
                left: _valuePos,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
