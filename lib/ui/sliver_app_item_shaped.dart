import 'package:flutter/material.dart';
import 'package:meteo_app_v2/ui/sliver_app_item.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverAppItemShaped extends SliverAppItem {
  final Color backgroundColor;

  const SliverAppItemShaped({
    super.key,
    required super.masterApp,
    super.fontHelper,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return SliverClip(
      child: SliverPadding(
        padding: const EdgeInsets.only(top: 15),
        sliver: SliverStack(
          children: [
            // shape
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

            // item
            super.build(context),
          ],
        ),
      ),
    );
  }
}
