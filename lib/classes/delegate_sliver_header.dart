import 'package:flutter/material.dart';
import 'package:meteo_app_v2/templates/template_card_title.dart';

class SilverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final IconData titleIcon;
  final double min;
  final double max;
  final double _maxOffset = 40;

  const SilverHeaderDelegate({
    required this.title,
    required this.titleIcon,
    required this.min,
    required this.max,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TemplateCardTitle(
      title: title,
      titleIcon: titleIcon,
    );
    // log(shrinkOffset.toString());
    // if (shrinkOffset >= _maxOffset) {
    //   return TemplateCardTitle(
    //     title: title,
    //     titleIcon: titleIcon,
    //   );
    // } else {
    //   return Container();
    // }
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
