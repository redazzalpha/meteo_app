import 'package:flutter/material.dart';

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
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(91, 0, 0, 0),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 6,
            bottom: 5,
            left: 9,
            right: 5,
          ),
          child: Row(
            children: [
              Icon(titleIcon, size: 16),
              const SizedBox(width: 5),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }
}
