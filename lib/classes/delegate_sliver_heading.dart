import 'package:flutter/material.dart';

class SliverHeadingDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  final double min;
  final double max;
  final int animationDuration;
  const SliverHeadingDelegate({
    required this.widget,
    this.min = 200,
    this.max = 200,
    this.animationDuration = 300,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: animationDuration),
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
