import 'package:flutter/material.dart';

class TemplateCardRow extends StatelessWidget {
  final List<Widget> widgets;
  final String title;
  final IconData titleIcon;
  final double width;
  final double height;
  final bool hasHeader;
  final bool hasBackground;

  const TemplateCardRow({
    super.key,
    required this.widgets,
    required this.title,
    required this.titleIcon,
    this.width = 800,
    this.height = 80,
    this.hasHeader = true,
    this.hasBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: hasBackground
            ? const Color.fromARGB(91, 0, 0, 0)
            : Colors.transparent,
        borderRadius: const BorderRadius.all(
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
          //  title
          if (hasHeader)
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
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 15),
                ),
              ],
            ),

          // horizontal line
          if (hasHeader)
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
              scrollDirection: Axis.horizontal,
              children: widgets,
            ),
          )
        ],
      ),
    );
  }
}
