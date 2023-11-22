import 'package:flutter/material.dart';

class SliverHeadingDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final Map<String, dynamic> datas;

  final double min;
  final double max;
  const SliverHeadingDelegate({
    required this.min,
    required this.max,
    required this.widget,
    required this.datas,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        widget,
      ],
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
