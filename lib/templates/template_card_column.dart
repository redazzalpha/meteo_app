import 'package:flutter/material.dart';

class TemplateCardColumn extends StatelessWidget {
  final List<Widget> widgets;
  final String title;
  final IconData titleIcon;
  final double width;
  final double height;

  const TemplateCardColumn({
    super.key,
    required this.widgets,
    required this.title,
    required this.titleIcon,
    this.width = 800,
    this.height = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(91, 0, 0, 0),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 10,
        right: 10,
      ),

      // main column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title row
          Row(
            children: [
              Icon(
                titleIcon,
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
              ),
            ],
          ),

          // horizontal line
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white),
              ),
            ),
          ),

          // items list
          SizedBox(
            width: width,
            height: height,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: widgets,
            ),
          )
        ],
      ),
    );
  }
}
