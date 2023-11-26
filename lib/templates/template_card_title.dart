import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_template.dart';

class TemplateCardTitle extends MasterTemplate {
  const TemplateCardTitle({
    super.key,
    super.title,
    super.titleIcon,
    super.hasBackground = true,
    super.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fontHelper = FontHelper(context: context);

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: hasBackground ? backgroundColor : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 9,
          ),
          child: Row(
            children: [
              Icon(titleIcon, size: 16),
              const SizedBox(width: 5),
              Text(
                title == null ? "" : title as String,
                style: fontHelper.label(),
              ),
            ],
          ),
        )
      ],
    );
  }
}


// const Color.fromARGB(91, 0, 255, 229)