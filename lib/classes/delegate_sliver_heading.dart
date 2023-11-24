import 'package:flutter/material.dart';

class SliverHeadingDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  final double minExt;
  final double maxExt;
  final int animationDuration;
  const SliverHeadingDelegate({
    required this.widget,
    this.minExt = 200,
    this.maxExt = 200,
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
  double get minExtent => minExt;

  @override
  double get maxExtent => maxExt;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
