import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/master_sliver.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverHeading extends MasterSliver {
  final Color backgroundColor;

  const SliverHeading({
    super.key,
    required super.masterApp,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return SliverStack(
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
        SliverAppBar(
          primary: true,
          pinned: true,
          toolbarHeight: 200,
          centerTitle: true,
          forceMaterialTransparency: true,
          title: masterApp,
        ),
      ],
    );
  }
}
