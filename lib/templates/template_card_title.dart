import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

class TemplateCardTitle extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  const TemplateCardTitle({
    super.key,
    required this.title,
    required this.titleIcon,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fontHelper = FontHelper(context: context);

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            // color: Color.fromARGB(91, 0, 0, 0),
            borderRadius: BorderRadius.all(
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
                title,
                style: fontHelper.label(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
