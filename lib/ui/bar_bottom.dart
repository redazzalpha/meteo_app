import 'package:flutter/material.dart';

class BarBottom extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  const BarBottom({
    super.key,
    this.height = 50,
    this.backgroundColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWdith = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: 0,
      left: 0,
      // main container
      child: Container(
        width: screenWdith,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),

        // main content
        child: const Row(
          children: [
            Text("bottom bar"),
            Spacer(),
            Text("Test"),
          ],
        ),
      ),
    );
  }
}
