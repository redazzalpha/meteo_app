import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/layouts/app_rain.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/utils/enums.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverAppList extends StatefulWidget {
  final List<MasterApp> masterApps;
  final ScrollController controller;
  final double scrollOffset;
  final void Function(ScrollPhysics) onScrollPhysic;
  final bool hasHeading;

  const SliverAppList({
    super.key,
    required this.masterApps,
    required this.controller,
    required this.scrollOffset,
    required this.onScrollPhysic,
    this.hasHeading = true,
  });

  @override
  State<StatefulWidget> createState() => _SliverListState();
}

class _SliverListState extends State<SliverAppList> {
  // variables
  late final List<GlobalKey> _sliverKeys;
  late final List<double> _sliverVisibilities;
  final double _sliverLimitVisibility = 90;
  late RenderSliverList _renderObject;
  Enum _scrollDir = ScrollDir.down;
  double _currentScroll = 0;
  // late final List<double> _sliverOpacities;
  // final double _sliverMaxOverlap = 200;
  double _sliverOverlap = 0;

  // methods
  void _sliverInitProps() {
    _sliverKeys =
        List<GlobalKey>.generate(widget.masterApps.length, (_) => GlobalKey());
    _sliverVisibilities =
        List<double>.generate(widget.masterApps.length, (_) => 1);
  }

  void _updateScrollDirection() {
    if (widget.controller.offset > _currentScroll) {
      _scrollDir = ScrollDir.down;
    } else {
      _scrollDir = ScrollDir.up;
    }
    _currentScroll = widget.controller.offset;
  }

  void _sliverUpdateSliverOverlap(final GlobalKey sliverKey) {
    _renderObject =
        sliverKey.currentContext!.findRenderObject() as RenderSliverList;
    _sliverOverlap = _renderObject.constraints.overlap;
  }

  void _sliverUpdateScrollDown() {
    if (_scrollDir == ScrollDir.down) {
      // updates counter i according to
      // heading is present or not
      for (int i = widget.hasHeading ? 1 : 0;
          i < widget.masterApps.length;
          i++) {
        _sliverUpdateSliverOverlap(_sliverKeys[i]);

        log("index: $i - ${_renderObject.lastChild!.size.height} - ${widget.controller.offset} - ${_sliverOverlap}");
        // log("- index: $i "
        //     " - remaining: ${_renderObject.constraints.viewportMainAxisExtent - _renderObject.constraints.remainingPaintExtent}"
        //     " - remainingPaintExtent: ${_renderObject.constraints.remainingPaintExtent}"
        //     " - viewportMainAxisExtent: ${_renderObject.constraints.viewportMainAxisExtent}");

        if (_sliverVisibilities[i] == 1) {
          // hide sliver visibility
          if (_sliverOverlap >= _sliverLimitVisibility) {
            _sliverVisibilities[i] = 0;
          }

          break;
        }
      }
      log("====================================================");
    }
  }

  void _sliverUpdateScrollUp() {
    if (_scrollDir == ScrollDir.up) {
      for (int i = widget.masterApps.length - 1;
          i > (widget.hasHeading ? 0 : -1);
          i--) {
        _sliverUpdateSliverOverlap(_sliverKeys[i]);

        if (_sliverVisibilities[i] == 0) {
          // show sliver visibility
          if (_sliverOverlap < _sliverLimitVisibility) {
            _sliverVisibilities[i] = 1;
          }
        }
      }
    }
  }

  String masterAppLabel(final MasterApp masterApp) {
    switch (masterApp.runtimeType) {
      case AppHeading:
        return AppHeading.label;
      case AppForcastHour:
        return AppForcastHour.label;
      case AppForcastDay:
        return AppForcastDay.label;
      case AppWind:
        return AppWind.label;
      case AppAir:
        return AppAir.label;
      case AppRain:
        return AppRain.label;
      default:
        return "Unknown";
    }
  }

  IconData masterAppLabelIcon(final MasterApp masterApp) {
    switch (masterApp.runtimeType) {
      case AppHeading:
        return AppHeading.labelIcon;
      case AppForcastHour:
        return AppForcastHour.labelIcon;
      case AppForcastDay:
        return AppForcastDay.labelIcon;
      case AppWind:
        return AppWind.labelIcon;
      case AppAir:
        return AppAir.labelIcon;
      case AppRain:
        return AppRain.labelIcon;
      default:
        return Icons.device_unknown;
    }
  }

  /// updates slivers opacity on scrolling
  void _sliverUpdate() async {
    _updateScrollDirection();
    setState(() {
      _sliverUpdateScrollDown();
      _sliverUpdateScrollUp();
    });
  }

  /// this function is used to
  /// tooggle the sliver heading
  /// between long and short writing
  /// according the scroll offset value
  Widget _sliverBuildHeader({
    final double height = 150,
  }) {
    // shortcut writing
    if (widget.controller.positions.isNotEmpty &&
        widget.controller.offset >= widget.scrollOffset) {
      final FontHelper fh =
          widget.masterApps[0].fontHelper ?? FontHelper(context: context);

      return SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            // city name
            Text(
              widget.masterApps[0].datas["city_info"]["name"],
              style: fh.headline(),
            ),

            // temperature | conditions
            Text(
              "${widget.masterApps[0].datas['current_condition']['tmp']}° | ${widget.masterApps[0].datas['current_condition']['condition']}",
              style: fh.label(),
            ),
          ],
        ),
      );
    }

    // heading writing
    else {
      return widget.masterApps[0];
    }
  }

  Widget _sliverWrapHeading({required final Widget widget}) {
    return SliverAppBar(
      pinned: true,
      forceMaterialTransparency: true,
      toolbarHeight: 180,
      centerTitle: true,
      title: widget,
    );
  }

  Widget _sliverWrapItem(final MasterApp masterApp, GlobalKey sliverKey,
      {double visibility = 1}) {
    return SliverClip(
      clipOverlap: true,

      // padding
      child: SliverPadding(
        padding: const EdgeInsets.only(top: 30),

        // sliver container
        sliver: MultiSliver(
          pushPinnedChildren: true,

          // child
          children: [
            // sliver header
            SliverAppBar(
              toolbarHeight: 35,
              pinned: true,
              forceMaterialTransparency: true,
              flexibleSpace: FlexibleSpaceBar(
                // background container
                background: Container(
                  decoration: BoxDecoration(
                    color: masterApp.hasBackground
                        ? masterApp.backgroundColor
                        : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),

              // header title
              title: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        masterAppLabelIcon(masterApp),
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        masterAppLabel(masterApp),
                        style: masterApp.fontHelper?.label(),
                      )
                    ],
                  )
                ],
              ),
            ),

            // sliver body
            SliverClip(
              clipOverlap: true,
              child: SliverStack(
                children: [
                  // body background
                  if (masterApp.hasBackground)
                    SliverPositioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: masterApp.backgroundColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),

                  // body content
                  MultiSliver(
                    children: [
                      SliverList(
                        key: sliverKey,
                        delegate: SliverChildListDelegate([
                          Column(
                            children: [masterApp],
                          )
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MultiSliver _sliverBuildAppList() {
    if (!widget.masterApps[0].isReady()) {
      return MultiSliver(children: const <Widget>[]);
    }

    List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.masterApps.length; i++) {
      // build sliver header
      if (i == 0 && widget.hasHeading) {
        children.add(
          _sliverWrapHeading(
            widget: _sliverBuildHeader(),
          ),
        );
        continue;
      }

      // build sliver item
      children.add(
        _sliverWrapItem(
          widget.masterApps[i],
          _sliverKeys[i],
          visibility: _sliverVisibilities[i],
          // opacity: _sliverOpacities[i],
        ),
      );
    }

    return MultiSliver(children: children);
  }

  // overrides
  @override
  void initState() {
    _sliverInitProps();
    widget.controller.addListener(() => _sliverUpdate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _sliverBuildAppList();
  }
}
