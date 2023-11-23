import 'package:flutter/material.dart';

class SliverHeadingDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final Map<String, dynamic> datas;

  final double min;
  final double max;
  const SliverHeadingDelegate({
    required this.widget,
    required this.datas,
    this.min = 200,
    this.max = 200,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: widget,
        ),
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
