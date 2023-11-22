import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/classes/delegate_sliver_header.dart';
import 'package:meteo_app_v2/classes/delegate_sliver_heading.dart';
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/templates/template_card_title.dart';
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
  final String _dataUrl = dataUrl;
  final double _scrollOffset = 45;
  final int _sliverMinHeight = 100;
  final int _sliversLength = 6;
  final int _timeoutTimer = 3000;
  late final ScrollController _controller;
  late final List<GlobalKey> _sliverKeys;
  late final List<double> _sliverOpacities;
  late RenderSliverPinnedPersistentHeader _renderObject;
  late double _sliverHeight;
  late Widget _appHeading;
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
          as RenderSliverPinnedPersistentHeader;
      _sliverHeight = _renderObject.child!.size.height;

      if (_sliverHeight <= _sliverMinHeight) {
        _sliverOpacities[i] = _sliverHeight / _sliverMinHeight;
      } else {
        _sliverOpacities[i] = 1;
      }
    }
  }

  Widget _sliverWrap(
    final Widget widget,
    final String title,
    final IconData titleIcon,
    final GlobalKey key,
    final double opacity,
    final double expandedHeight,
    final double maxExtent,
  ) {
    return SliverOpacity(
      opacity: opacity,

      // sliver container
      sliver: SliverAppBar(
        key: key,
        expandedHeight: expandedHeight,
        toolbarHeight: 0,
        pinned: true,
        forceMaterialTransparency: true,

        // flexible space bar settings
        flexibleSpace: FlexibleSpaceBar.createSettings(
          toolbarOpacity: 1 - opacity,
          currentExtent: maxExtent,
          maxExtent: maxExtent,
          minExtent: 0,

          // flexible space bar
          child: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(
              left: 3,
            ),
            centerTitle: false,
            title: TemplateCardTitle(
              title: title,
              titleIcon: titleIcon,
            ),
            background: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget,
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSlivers() {
    if (_datas.isEmpty) return const <Widget>[];
    return <Widget>[
      // app heading
      SliverAppBar(
        title: _appHeading,
        centerTitle: true,
        toolbarHeight: 150,
        expandedHeight: 200,
        pinned: true,
        // snap: true,
        // floating: true,
        forceMaterialTransparency: true,

        // flexible space bar
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppHeading(datas: _datas),
            ],
          ),
        ),
      ),

      // app forcast hour
      _sliverWrap(
        AppForcastHour(datas: _datas),
        "Prévisions heure par heure",
        Icons.access_time,
        _sliverKeys[0],
        _sliverOpacities[0],
        160,
        160,
      ),

      // app forcast day
      _sliverWrap(
        AppForcastDay(datas: _datas),
        "Prévisions pour 5 jours",
        Icons.calendar_month,
        _sliverKeys[1],
        _sliverOpacities[1],
        200,
        200,
      ),

      // app test 1
      _sliverWrap(
        AppForcastDay(datas: _datas),
        "Prévisions pour 5 jours",
        Icons.calendar_month,
        _sliverKeys[2],
        _sliverOpacities[2],
        200,
        200,
      ),

      // app test 2
      _sliverWrap(
        AppForcastDay(datas: _datas),
        "Prévisions pour 5 jours",
        Icons.calendar_month,
        _sliverKeys[3],
        _sliverOpacities[3],
        200,
        200,
      ),

      // app test 3
      _sliverWrap(
        AppForcastDay(datas: _datas),
        "Prévisions pour 5 jours",
        Icons.calendar_month,
        _sliverKeys[4],
        _sliverOpacities[4],
        200,
        200,
      ),

      // app test 4
      _sliverWrap(
        AppForcastDay(datas: _datas),
        "Prévisions pour 5 jours",
        Icons.calendar_month,
        _sliverKeys[5],
        _sliverOpacities[5],
        200,
        200,
      ),

      // bottom padding
      const SliverPadding(
        padding: EdgeInsets.only(top: 300),
      )
    ];
  }

  Widget _sliverWrap1(final Widget widget, final String title,
      final IconData titleIcon, final double min, final double max) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 15),
      sliver: SliverStack(
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
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: SilverHeaderDelegate(
              title: title,
              titleIcon: titleIcon,
              min: 50,
              max: 100,
            ),
          ),
        ],
      ),
    );
  }

  MultiSliver _buildSlivers1() {
    if (_datas.isEmpty) return MultiSliver(children: const []);
    return MultiSliver(
      children: <Widget>[
        // app heading
        SliverPersistentHeader(
          delegate: SliverHeadingDelegate(
            datas: _datas,
            widget: _appHeading,
            min: 200,
            max: 200,
          ),
          pinned: true,
        ),

        // app forcast hour
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          50,
        ),

        // app tests
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
        _sliverWrap1(
          AppForcastHour(datas: _datas),
          "Prévisions heure par heure",
          Icons.access_time,
          50,
          100,
        ),
      ],
    );
  }

  // event handlers
  void _handleScroll() {
    // _updateSlivers();
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
    _sliverOpacities = List<double>.generate(_sliversLength, (index) => 1);
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
        child: CustomScrollView(
            controller: _controller, slivers: [_buildSlivers1()]
            // slivers: _buildSlivers(),
            ),
      ),
    );
  }
}
