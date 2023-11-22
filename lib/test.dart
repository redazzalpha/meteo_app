import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverTestDelegate extends SliverPersistentHeaderDelegate {
  final String text;
  const SliverTestDelegate({
    required this.text,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: Column(children: [Text(text)]));
  }

  @override
  double get maxExtent => 500;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MultiSliver(
          pushPinnedChildren: true,
          children: <Widget>[
            SliverStack(
              children: [
                SliverPositioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          color: Colors.black26,
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SliverClip(
                  clipOverlap: true,
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 6,
                      (context, index) => const Text("bbbbb"),
                    ),
                  ),
                ),
                const SliverPersistentHeader(
                  delegate: SliverTestDelegate(text: "sliverstack app bar"),
                  pinned: false,
                ),
              ],
            ),
            const SliverPersistentHeader(
              delegate: SliverTestDelegate(text: "first app bar"),
              pinned: true,
            ),
            SliverClip(
              clipOverlap: true,
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 15,
                  (context, index) => const Text("bbbbb"),
                ),
              ),
            ),
            const SliverPersistentHeader(
              delegate: SliverTestDelegate(text: "second app bar"),
              pinned: true,
            ),
            SliverClip(
              clipOverlap: true,
              child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: 15, (context, index) => const Text("cccc"))),
            ),
          ],
        )
      ],
    );
  }
}
