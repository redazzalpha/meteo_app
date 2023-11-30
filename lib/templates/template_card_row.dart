import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_template.dart';

class TemplateCardRow extends MasterTemplate {
  final List<Widget> widgets;
  final double width;
  final double height;

  const TemplateCardRow({
    super.key,
    required this.widgets,
    super.title,
    super.titleIcon,
    super.hasHeader = true,
    super.hasBackground = true,
    super.backgroundColor = Colors.transparent,
    super.fontHelper,
    this.width = 800,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: hasBackground ? backgroundColor : Colors.transparent,
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  title ?? "",
                  style: fh.label(),
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
