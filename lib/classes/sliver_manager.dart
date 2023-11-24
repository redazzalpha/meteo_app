import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_header.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_heading.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverManager {
  // variables
  final List<Widget> slivers;
  final bool hasHeader;
  late RenderSliverHelpers _renderObject;
  late final List<GlobalKey> _sliverKeys;
  late final List<double> _sliverOpacities;
  late final List<double> _sliverVisibilities;
  final double _sliverMaxOverlap = 200;
  final double _sliverLimitOverlap = 50;
  final double _sliverLimitVisibility = 90;
  double _sliverOverlap = 0;

  //constructor
  SliverManager({
    required this.slivers,
    this.hasHeader = true,
  }) {
    _sliverKeys = List<GlobalKey>.generate(slivers.length, (_) => GlobalKey());
    _sliverOpacities = List<double>.generate(slivers.length, (_) => 0);
    _sliverVisibilities = List<double>.generate(slivers.length, (_) => 1);
  }

  // getters
  List<Widget> getSlivers() => slivers;

  // methods
  Widget sliverHeaderWrap({
    required final Widget widget,
    final double min = 200,
    final double max = 200,
  }) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeadingDelegate(
        widget: widget,
        min: min,
        max: max,
      ),
    );
  }

  Widget sliverWrap(
    final GlobalKey key,
    final Widget widget,
    final String title,
    final IconData titleIcon, {
    final double opacity = 1,
    final double visibility = 1,
    final double padding = 80,
    final double min = 15,
    final double max = 165,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 15),

      // main stack
      sliver: SliverAnimatedOpacity(
        opacity: visibility,
        duration: const Duration(milliseconds: 500),
        sliver: SliverStack(
          key: key,
          insetOnOverlap: true,
          children: [
            // background
            SliverPositioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(91, 0, 0, 0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      color: Colors.black26,
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),

            // app widget
            SliverClip(
              clipOverlap: true,
              child: SliverToBoxAdapter(
                child: Column(
                  children: [
                    widget,
                  ],
                ),
              ),
            ),

            // bottom header
            SliverClip(
              child: SliverPersistentHeader(
                delegate: SilverHeaderDelegate(
                  title: title,
                  titleIcon: titleIcon,
                  min: min,
                  max: max,
                  opacity: opacity,
                  padding: padding,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void sliverUpdate() {
    for (int i = 0; i < slivers.length; i++) {
      _renderObject = _sliverKeys[i].currentContext!.findRenderObject()
          as RenderSliverHelpers;
      _sliverOverlap = _renderObject.constraints.overlap;
      // if (_sliverVisibilities[i] == 0) continue;

      // sliver visibility
      if (_sliverOverlap >= _sliverLimitVisibility) {
        // if (_sliverVisibilities[i] != 0) {
        //   _scrollPhysic = const NeverScrollableScrollPhysics();
        //   Timer(
        //     const Duration(milliseconds: 30),
        //     () => _scrollPhysic = const AlwaysScrollableScrollPhysics(),
        //   );
        // }

        _sliverVisibilities[i] = 0;
      } else {
        _sliverVisibilities[i] = 1;

        // bottom header opacity
        if (_sliverOverlap >= _sliverLimitOverlap) {
          double factor = _sliverMaxOverlap - _sliverLimitOverlap;
          _sliverOpacities[i] =
              (_sliverMaxOverlap / factor) - (_sliverOverlap / factor);
        } else {
          _sliverOpacities[i] = 0;
        }
      }
    }
  }

  Widget sliverBuildHearder(
    final BuildContext context,
    final Map<String, dynamic> datas,
    final ScrollController controller,
    final double scrollOffset,
  ) {
    if (controller.offset >= scrollOffset) {
      final FontHelper fontHelper = FontHelper(context: context);
      return SizedBox(
        height: 150,
        child: Column(
          children: <Widget>[
            Text(
              datas["city_info"]["name"],
              style: fontHelper.headline(),
            ),
            Text(
              "${datas['current_condition']['tmp']}° | ${datas['current_condition']['condition']}",
              style: fontHelper.label(),
            ),
          ],
        ),
      );
    } else {
      return slivers[0];
    }
  }

  MultiSliver sliverBuild() {
    List<Widget> children = <Widget>[];

    for (int i = 0; i < slivers.length; i++) {
      if (i == 0 && hasHeader) {
        children.add(
          sliverHeaderWrap(widget: slivers[i]),
        );
        continue;
      }

      children.add(
        sliverWrap(
          _sliverKeys[i],
          slivers[i],
          "unknown title",
          Icons.device_unknown,
          opacity: _sliverOpacities[i],
          visibility: _sliverVisibilities[i],
        ),
      );
    }
    return MultiSliver(
      pushPinnedChildren: true,
      children: children,
    );
  }
}
