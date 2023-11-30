import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverContent extends StatelessWidget {
  final MasterApp masterApp;
  final FontHelper? fontHelper;

  const SliverContent({
    super.key,
    required this.masterApp,
    this.fontHelper,
  });

  @override
  Widget build(BuildContext context) {
    return SliverClip(
      child: SliverList(
        delegate: SliverChildListDelegate(
          [
            masterApp,
          ],
        ),
      ),
    );
  }
}
