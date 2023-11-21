import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        padding: EdgeInsets.zero,
        child: const Column(
          children: [
            Flexible(
              flex: 1,
              child: Text("flexible"),
            ),
            Flexible(
              flex: 1,
              child: Text("flexible"),
            ),
          ],
        ),
      ),
    );
  }
}
