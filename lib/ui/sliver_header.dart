import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

class SliverHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final FontHelper? fontHelper;

  const SliverHeader({
    super.key,
    required this.title,
    required this.icon,
    this.fontHelper,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

    return SliverAppBar(
      pinned: true,
      toolbarHeight: 35,
      forceMaterialTransparency: true,
      title: Row(
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: fh.label(),
          ),
        ],
      ),
    );
  }
}
