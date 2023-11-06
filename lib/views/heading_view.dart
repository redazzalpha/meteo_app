import 'package:flutter/material.dart';

class HeadingView extends StatelessWidget {
  const HeadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(0),
      child: const Column(
        children: [
          Text("Paris"),
          Text("11°"),
          Text("Nuages prédominants"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_upward),
              Text("19°"),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.arrow_downward),
              Text("8°"),
            ],
          ),
        ],
      ),
    );
  }
}
