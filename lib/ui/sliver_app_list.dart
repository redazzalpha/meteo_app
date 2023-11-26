import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_header.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_heading.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/utils/enums.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverAppList extends StatefulWidget {
  final List<MasterApp> masterApps;
  final ScrollController controller;
  final double scrollOffset;
  final void Function(ScrollPhysics) onScrollPhysic;
  final bool hasHeader;

  const SliverAppList({
    super.key,
    required this.masterApps,
    // required this.datas,
    required this.controller,
    required this.scrollOffset,
    required this.onScrollPhysic,
    this.hasHeader = true,
  });

  @override
  State<StatefulWidget> createState() => _SliverListViewState();
}

class _SliverListViewState extends State<SliverAppList> {
  // variables
  final double _sliverMaxOverlap = 200;
  final double _sliverLimitOverlap = 50;
  final double _sliverLimitVisibility = 90;
  late final List<GlobalKey> _sliverKeys;
  late final List<double> _sliverOpacities;
  late final List<double> _sliverVisibilities;
  late RenderSliverHelpers _renderObject;
  double _sliverOverlap = 0;
  Enum _scrollDir = ScrollDir.down;
  double _currentScroll = 0;

  // methods
  void _sliverInitKeys() {
    _sliverKeys =
        List<GlobalKey>.generate(widget.masterApps.length, (_) => GlobalKey());
    _sliverOpacities =
        List<double>.generate(widget.masterApps.length, (_) => 0);
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
        sliverKey.currentContext!.findRenderObject() as RenderSliverHelpers;
    _sliverOverlap = _renderObject.constraints.overlap;
  }

  void _sliverUpdateScrollDown() {
    if (_scrollDir == ScrollDir.down) {
      for (int i = widget.hasHeader ? 1 : 0;
          i < widget.masterApps.length;
          i++) {
        _sliverUpdateSliverOverlap(_sliverKeys[i]);

        if (_sliverVisibilities[i] == 1) {
          // hide sliver visibility
          if (_sliverOverlap >= _sliverLimitVisibility) {
            _sliverVisibilities[i] = 0;
          }

          // show sliver header bottom bar visibility
          else if (_sliverOverlap >= _sliverLimitOverlap) {
            double factor = _sliverMaxOverlap - _sliverLimitOverlap;
            _sliverOpacities[i] =
                (_sliverMaxOverlap / factor) - (_sliverOverlap / factor);
          }

          break;
        }
      }
    }
  }

  void _sliverUpdateScrollUp() {
    if (_scrollDir == ScrollDir.up) {
      for (int i = widget.masterApps.length - 1;
          i > (widget.hasHeader ? 0 : -1);
          i--) {
        _sliverUpdateSliverOverlap(_sliverKeys[i]);

        if (_sliverVisibilities[i] == 0) {
          // show sliver visibility
          if (_sliverOverlap < _sliverLimitVisibility) {
            _sliverVisibilities[i] = 1;
          }
        }

        // hide sliver header bottom bar visibility
        else if (_sliverOverlap < _sliverLimitOverlap &&
            _sliverOpacities[i] > 0) {
          _sliverOpacities[i] = 0;
          break;
        }
      }
    }
  }

  /// updateSilvers function updates
  /// slivers opacity on scrolling
  void _sliverUpdate() async {
    _updateScrollDirection();
    setState(() {
      _sliverUpdateScrollDown();
      _sliverUpdateScrollUp();
    });
  }

  Widget _sliverWrapHeader({
    required final Widget widget,
    // minExt and maxExt must set from
    // function arguments and not
    // from MasterApp properties cause
    // widget is not necessarily a
    // MasterApp object
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
    final MasterApp masterApp,
    final GlobalKey key, {
    final double opacity = 1,
    final double visibility = 1,
    final double padding = 80,
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
                    masterApp,
                  ],
                ),
              ),
            ),

            // bottom header
            SliverClip(
              child: SliverPersistentHeader(
                delegate: SilverHeaderDelegate(
                  title: masterApp.label,
                  titleIcon: masterApp.labelIcon,
                  opacity: opacity,
                  padding: padding,
                  minExt: masterApp.minExt,
                  maxExt: masterApp.maxExt,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sliverBuildHearder({
    final double height = 150,
  }) {
    // shortcut writing
    if (widget.controller.positions.isNotEmpty &&
        widget.controller.offset >= widget.scrollOffset) {
      final FontHelper fontHelper = FontHelper(context: context);
      return SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            // city name
            Text(
              widget.masterApps[0].datas["city_info"]["name"],
              style: fontHelper.headline(),
            ),

            // temperature | conditions
            Text(
              "${widget.masterApps[0].datas['current_condition']['tmp']}° | ${widget.masterApps[0].datas['current_condition']['condition']}",
              style: fontHelper.label(),
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

  MultiSliver _sliverBuildAppList() {
    if (!widget.masterApps[0].isReady()) {
      return MultiSliver(children: const []);
    }

    List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.masterApps.length; i++) {
      if (i == 0 && widget.hasHeader) {
        // build sliver header
        children.add(
          _sliverWrapHeader(
            widget: _sliverBuildHearder(),
          ),
        );
        continue;
      }

      // build sliver item
      children.add(
        _sliverWrapItem(
          widget.masterApps[i],
          _sliverKeys[i],
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
