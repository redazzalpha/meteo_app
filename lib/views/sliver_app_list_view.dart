import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_header.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_heading.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverAppListView extends StatefulWidget {
  final Map<String, dynamic> datas;
  final ScrollController controller;
  final double scrollOffset;

  final List<Widget> slivers;
  final bool hasHeader;

  const SliverAppListView({
    super.key,
    required this.slivers,
    required this.datas,
    required this.controller,
    required this.scrollOffset,
    this.hasHeader = true,
  });

  @override
  State<StatefulWidget> createState() => _SliverListViewState();
}

class _SliverListViewState extends State<SliverAppListView> {
  // variables
  final double _sliverMaxOverlap = 200;
  final double _sliverLimitOverlap = 50;
  final double _sliverLimitVisibility = 90;
  late final List<GlobalKey> _sliverKeys;
  late final List<double> _sliverOpacities;
  late final List<double> _sliverVisibilities;
  late RenderSliverHelpers _renderObject;
  double _sliverOverlap = 0;

  // Enum _scrollDir = ScrollDir.down;
  // double _currentScroll = 0;

  // methods
  void _sliverInitKeys() {
    _sliverKeys =
        List<GlobalKey>.generate(widget.slivers.length, (_) => GlobalKey());
    _sliverOpacities = List<double>.generate(widget.slivers.length, (_) => 0);
    _sliverVisibilities =
        List<double>.generate(widget.slivers.length, (_) => 1);
  }

  Widget _sliverWrapHeader({
    required final Widget widget,
    final double minExt = 200,
    final double maxExt = 200,
  }) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeadingDelegate(
        widget: widget,
        minExt: minExt,
        maxExt: maxExt,
      ),
    );
  }

  Widget _sliverWrapItem(
    final GlobalKey key,
    final Widget widget,
    final String title,
    final IconData titleIcon, {
    final double opacity = 1,
    final double visibility = 1,
    final double padding = 80,
    final double minExt = 15,
    final double maxExt = 165,
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
                  opacity: opacity,
                  padding: padding,
                  minExt: minExt,
                  maxExt: maxExt,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// updateSilvers function updates
  /// slivers opacity on scrolling
  void _sliverUpdate() {
    // TOFIX: SLIVERS UPDATES BEHAVE BADLY ON SCROLL UP DOWN  FAST FIRST TO LAST\
    // (FIRST DOES NOT APPEARS CORRECTLY CAUSE OF SCROLL BIG SCROLL STEPS)

    setState(() {
      for (int i = widget.hasHeader ? 1 : 0; i < widget.slivers.length; i++) {
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
    });
  }

  Widget _sliverBuildHearder() {
    // shortcut writing
    if (widget.controller.positions.isNotEmpty &&
        widget.controller.offset >= widget.scrollOffset) {
      final FontHelper fontHelper = FontHelper(context: context);
      return SizedBox(
        height: 150,
        child: Column(
          children: <Widget>[
            // city name
            Text(
              widget.datas["city_info"]["name"],
              style: fontHelper.headline(),
            ),

            // temperature | conditions
            Text(
              "${widget.datas['current_condition']['tmp']}° | ${widget.datas['current_condition']['condition']}",
              style: fontHelper.label(),
            ),
          ],
        ),
      );
    }

    // heading writing
    else {
      return widget.slivers[0];
    }
  }

  MultiSliver _sliverBuildAppList() {
    if (widget.datas.isEmpty) return MultiSliver(children: const []);

    List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.slivers.length; i++) {
      if (i == 0 && widget.hasHeader) {
        // build sliver header
        children.add(
          _sliverWrapHeader(
            widget: _sliverBuildHearder(),
          ),
        );
        continue;
      }

      // build sliver header
      children.add(
        _sliverWrapItem(
          _sliverKeys[i],
          widget.slivers[i],
          (widget.slivers[i] as MasterApp).label,
          (widget.slivers[i] as MasterApp).labelIcon,
          opacity: _sliverOpacities[i],
          visibility: _sliverVisibilities[i],
          maxExt: (widget.slivers[i] as MasterApp).maxExt,
        ),
      );
    }
    return MultiSliver(
      pushPinnedChildren: true,
      children: children,
    );
  }

  // overrides
  @override
  void initState() {
    _sliverInitKeys();
    widget.controller.addListener(() => _sliverUpdate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _sliverBuildAppList();
  }
}
