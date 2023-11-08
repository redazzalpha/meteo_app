import 'package:flutter/material.dart';

class BarValue extends StatefulWidget {
  final int value;
  final bool isDot;
  final List<Color> gradientColors;
  const BarValue({
    super.key,
    this.value = 0,
    this.isDot = false,
    this.gradientColors = const <Color>[
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
    ],
  });

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
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        WidgetsBinding.instance.addPostFrameCallback((_) => computeSliderPos());

        return Stack(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(50, 50),
                ),
              ),
              margin: const EdgeInsets.only(top: 1.4),
            ),
            Container(
              key: _containerKey,
              height: 7,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(50, 50),
                ),
                gradient: LinearGradient(
                  tileMode: TileMode.mirror,
                  colors: widget.gradientColors,
                ),
              ),
              margin: const EdgeInsets.only(top: 1.4),
            ),
            if (widget.isDot)
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
