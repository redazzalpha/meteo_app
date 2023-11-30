import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            sliver: SliverStack(
              children: [
                SliverPositioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SliverAppBar(
                  primary: true,
                  backgroundColor: Colors.purple,
                  toolbarHeight: 150,
                  pinned: true,
                  centerTitle: true,
                  title: Text("Sliver app bar heading"),
                ),
              ],
            ),
          ),
          const SliverItemShaped(
            backgroundColor: Colors.red,
          ),
          const SliverItemShaped(
            backgroundColor: Colors.green,
          ),
          const SliverItemShaped(
            backgroundColor: Colors.blue,
          ),
          const SliverItemShaped(
            backgroundColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      toolbarHeight: 70,
      forceMaterialTransparency: true,
      title: Text("Appbar title"),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverClip(
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 50,
          (context, index) => Text("sliver n°${index + 1}"),
        ),
      ),
    );
  }
}

class SliverItem extends StatelessWidget {
  const SliverItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: const <Widget>[
        AppBar(),
        Content(),
      ],
    );
  }
}

class SliverItemShaped extends StatelessWidget {
  final Color backgroundColor;

  const SliverItemShaped({
    super.key,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 15),
      sliver: SliverStack(
        children: [
          SliverPositioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
          const SliverItem(),
        ],
      ),
    );
  }
}
