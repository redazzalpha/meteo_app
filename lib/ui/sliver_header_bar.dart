import 'package:flutter/material.dart';

class SliverHeaderBar extends StatelessWidget {
  final Widget? bottom;

  const SliverHeaderBar({
    super.key,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text("sliver app bar title"),
      centerTitle: true,
      pinned: true,
      expandedHeight: 200,
      backgroundColor: Colors.blue,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: bottom ?? const SizedBox(),
      ),
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 1.3,
        background: Text("flexiblespacebar"),
      ),
    );
  }
}
