import 'dart:ui';

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
      automaticallyImplyLeading: false,
      primary: true,
      title: const Text("météo"),
      pinned: true,
      toolbarHeight: 100,
      expandedHeight: 200,
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: bottom ?? const SizedBox(),
      ),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          expandedTitleScale: 1.3,
          title: Stack(
            alignment: Alignment.topCenter,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 0.5,
                  sigmaY: 0.5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.95),
                  ),
                ),
              ),
              const Text("météo"),
            ],
          )),
    );
  }
}
