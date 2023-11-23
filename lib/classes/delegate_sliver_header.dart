import 'package:flutter/material.dart';
import 'package:meteo_app_v2/templates/template_card_title.dart';

class SilverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final IconData titleIcon;
  final double min;
  final double max;
  final double opacity;
  final double padding;

  const SilverHeaderDelegate({
    required this.title,
    required this.titleIcon,
    this.opacity = 1,
    this.padding = 80,
    this.min = 0,
    this.max = 150,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: EdgeInsets.only(top: padding),
        child: TemplateCardTitle(
          title: title,
          titleIcon: titleIcon,
        ),
      ),
    );
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
