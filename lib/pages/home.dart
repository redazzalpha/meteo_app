import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/classes/delegate_sliver_header.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_heading.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Home extends StatefulWidget {
  // constructor
  const Home({
    super.key,
  });

  // overrides
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // variables
  Map<String, dynamic> _datas = const <String, dynamic>{};
  late final ScrollController _controller;
  late final List<GlobalKey> _sliverKeys;
  late final List<double> _sliverOpacities;
  late final List<double> _sliverVisibilities;
  late RenderSliverHelpers _renderObject;
  late Widget _appHeading;
  final String _dataUrl = dataUrl;
  final double _scrollOffset = 45;
  final int _sliversLength = 10;
  final int _timeoutTimer = 3000;
  final double _sliverMaxOverlap = 200;
  final double _sliverLimitOverlap = 50;
  final double _sliverLimitVisibility = 90;
  double _sliverOverlap = 0;
  String _background = defaultBackground;

  // methods
  Future<Map<String, dynamic>?> _fetchData(String localisation) async {
    try {
      var response = await http.get(Uri.parse("$_dataUrl/$localisation"));
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      log("-- error fetch data: $e");
      return null;
    }
  }

  void _refreshDataTimer({int milliseconds = defalutTimeoutTimer}) async {
    Timer.periodic(
      Duration(milliseconds: milliseconds),
      (_) {
        _fetchData("Paris").then((datas) {
          if (datas != null) {
            setState(() {
              _datas = datas;
              _background =
                  "assets/weather/${_datas['current_condition']['condition_key']}.gif";
              _buildAppHeading();
              log("-- async data fetched");
            });
          }
        });
      },
    );
  }

  void _buildAppHeading() {
    if (_controller.offset >= _scrollOffset) {
      _appHeading = Column(
        children: <Widget>[
          Text(_datas["city_info"]["name"]),
          Text(
            "${_datas['current_condition']['tmp']}° | ${_datas['current_condition']['condition']}",
          ),
        ],
      );
    } else {
      _appHeading = AppHeading(datas: _datas);
    }
  }

  /// updateSilvers function updates
  /// slivers opacity on scrolling
  void _updateSlivers() {
    for (int i = 0; i < _sliversLength; i++) {
      _renderObject = _sliverKeys[i].currentContext!.findRenderObject()
          as RenderSliverHelpers;
      _sliverOverlap = _renderObject.constraints.overlap;

      // log("index: $i - overlap: $_sliverOverlap");

      if (_sliverOverlap >= _sliverLimitVisibility) {
        _sliverVisibilities[i] = 0;
      } else {
        _sliverVisibilities[i] = 1;

        if (_sliverOverlap >= _sliverLimitOverlap) {
          double factor = _sliverMaxOverlap - _sliverLimitOverlap;
          _sliverOpacities[i] =
              (_sliverMaxOverlap / factor) - (_sliverOverlap / factor);
        } else {
          _sliverOpacities[i] = 0;
        }
      }
    }
    // log("============================================");
  }

  Widget _sliverWrap(
    final GlobalKey key,
    final Widget widget,
    final String title,
    final IconData titleIcon,
    final double min,
    final double max,
    final double opacity,
    final double visibility,
  ) {
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

            // header
            SliverClip(
              child: SliverPersistentHeader(
                // pinned: false,
                // floating: true,
                delegate: SilverHeaderDelegate(
                  title: title,
                  titleIcon: titleIcon,
                  min: 35,
                  max: 150,
                  opacity: opacity,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  MultiSliver _buildSlivers() {
    if (_datas.isEmpty) return MultiSliver(children: const []);
    return MultiSliver(
      pushPinnedChildren: true,
      children: <Widget>[
        // app heading
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeadingDelegate(
            datas: _datas,
            widget: _appHeading,
            min: 200,
            max: 200,
          ),
        ),

        // app forcast hour
        _sliverWrap(
          _sliverKeys[0],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          50,
          _sliverOpacities[0],
          _sliverVisibilities[0],
        ),

        // app tests
        _sliverWrap(
          _sliverKeys[1],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[1],
          _sliverVisibilities[1],
        ),
        _sliverWrap(
          _sliverKeys[2],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[2],
          _sliverVisibilities[2],
        ),
        _sliverWrap(
          _sliverKeys[3],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[3],
          _sliverVisibilities[3],
        ),
        _sliverWrap(
          _sliverKeys[4],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[4],
          _sliverVisibilities[4],
        ),
        _sliverWrap(
          _sliverKeys[5],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[5],
          _sliverVisibilities[5],
        ),
        _sliverWrap(
          _sliverKeys[6],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[6],
          _sliverVisibilities[6],
        ),
        _sliverWrap(
          _sliverKeys[7],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[7],
          _sliverVisibilities[7],
        ),
        _sliverWrap(
          _sliverKeys[8],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[8],
          _sliverVisibilities[8],
        ),
        _sliverWrap(
          _sliverKeys[9],
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
          _sliverOpacities[9],
          _sliverVisibilities[9],
        ),
      ],
    );
  }

  // event handlers
  void _handleScroll() {
    _updateSlivers();
    setState(() {
      _buildAppHeading();
    });
  }

  // overrides
  @override
  void initState() {
    _refreshDataTimer(milliseconds: _timeoutTimer);
    _controller = ScrollController();
    _controller.addListener(_handleScroll);
    _sliverKeys =
        List<GlobalKey>.generate(_sliversLength, (index) => GlobalKey());
    _sliverOpacities = List<double>.generate(_sliversLength, (index) => 0);
    _sliverVisibilities = List<double>.generate(_sliversLength, (index) => 1);
    _appHeading = const Text("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // main container
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(49, 0, 0, 0),
          image: DecorationImage(
            image: AssetImage(
              _background,
            ),
            fit: BoxFit.cover,
          ),
        ),

        // scroll view
        child:
            CustomScrollView(controller: _controller, slivers: [_buildSlivers()]
                // slivers: _buildSlivers(),
                ),
      ),
    );
  }
}
