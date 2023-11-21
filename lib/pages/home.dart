import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/utils/defines.dart';

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
  late final ScrollController _controller;
  late final List<GlobalKey> _sliverKeys;
  late final List<double> _opacities;
  late RenderSliverPinnedPersistentHeader _renderObject;
  late double _sliverHeight;
  late Widget _appHeadingTitle;
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

  void _refreshDataTimer({int milliseconds = 1000}) async {
    Timer.periodic(
      Duration(milliseconds: milliseconds),
      (_) {
        _fetchData("Paris").then((datas) {
          if (datas != null) {
            setState(() {
              _datas = datas;
              _background =
                  "assets/weather/${_datas['current_condition']['condition_key']}.gif";
              log("-- async data fetched");
            });
          }
        });
      },
    );
  }

  void _updateAppHeadingTitle({final bool visible = true}) {
    if (visible) {
      _appHeadingTitle = Column(
        children: <Widget>[
          Text(_datas["city_info"]["name"]),
          Text(
            "${_datas['current_condition']['tmp']}° | ${_datas['current_condition']['condition']}",
          ),
        ],
      );
    } else {
      _appHeadingTitle = const Text("");
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
        _opacities[i] = _sliverHeight / 100;
      } else {
        _opacities[i] = 1;
      }
    }
  }

  void _updateHeading() {
    if (_controller.offset >= _scrollOffset) {
      _updateAppHeadingTitle(visible: true);
    } else {
      _updateAppHeadingTitle(visible: false);
    }
  }

  List<Widget> _buildSlivers() {
    if (_datas.isEmpty) return const <Widget>[];
    return <Widget>[
      // app heading
      SliverAppBar(
        title: _appHeadingTitle,
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
      SliverOpacity(
        opacity: _opacities[0],
        sliver: SliverAppBar(
          key: _sliverKeys[0],
          toolbarHeight: 0,
          expandedHeight: 140,
          pinned: true,
          forceMaterialTransparency: true,

          // flexible space bar
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: 140,
            maxExtent: 140,
            minExtent: 0,
            child: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppForcastHour(datas: _datas),
                ],
              ),
            ),
          ),
        ),
      ),

      // app forcast day
      SliverOpacity(
        opacity: _opacities[1],
        sliver: SliverAppBar(
          key: _sliverKeys[1],
          toolbarHeight: 0,
          expandedHeight: 200,
          pinned: true,
          forceMaterialTransparency: true,

          // flexible space bar
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: 200,
            maxExtent: 200,
            minExtent: 0,
            child: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppForcastDay(datas: _datas),
                ],
              ),
            ),
          ),
        ),
      ),

      // app test 1
      SliverOpacity(
        opacity: _opacities[2],
        sliver: SliverAppBar(
          key: _sliverKeys[2],
          toolbarHeight: 0,
          expandedHeight: 200,
          pinned: true,
          forceMaterialTransparency: true,

          // flexible space bar
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: 200,
            maxExtent: 200,
            minExtent: 0,
            child: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppForcastDay(datas: _datas),
                ],
              ),
            ),
          ),
        ),
      ),

      // app test 2
      SliverOpacity(
        opacity: _opacities[3],
        sliver: SliverAppBar(
          key: _sliverKeys[3],
          toolbarHeight: 0,
          expandedHeight: 200,
          pinned: true,
          forceMaterialTransparency: true,

          // flexible space bar
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: 200,
            maxExtent: 200,
            minExtent: 0,
            child: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppForcastDay(datas: _datas),
                ],
              ),
            ),
          ),
        ),
      ),

      // app test 3
      SliverOpacity(
        opacity: _opacities[4],
        sliver: SliverAppBar(
          key: _sliverKeys[4],
          toolbarHeight: 0,
          expandedHeight: 200,
          pinned: true,
          forceMaterialTransparency: true,

          // flexible space bar
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: 200,
            maxExtent: 200,
            minExtent: 0,
            child: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppForcastDay(datas: _datas),
                ],
              ),
            ),
          ),
        ),
      ),

      // app test 4
      SliverOpacity(
        opacity: _opacities[5],
        sliver: SliverAppBar(
          key: _sliverKeys[5],
          toolbarHeight: 0,
          expandedHeight: 200,
          pinned: true,
          forceMaterialTransparency: true,

          // flexible space bar
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: 200,
            maxExtent: 200,
            minExtent: 0,
            child: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppForcastDay(datas: _datas),
                ],
              ),
            ),
          ),
        ),
      ),

      // bottom padding
      const SliverPadding(padding: EdgeInsets.only(top: 300))
    ];
  }

  // event handlers
  void _handleScroll() {
    _updateSlivers();
    setState(() {
      _updateHeading();
    });
  }

  // overrides
  @override
  void initState() {
    _refreshDataTimer(milliseconds: 3000);
    _controller = ScrollController();
    _controller.addListener(_handleScroll);
    _sliverKeys =
        List<GlobalKey>.generate(_sliversLength, (index) => GlobalKey());
    _opacities = List<double>.generate(_sliversLength, (index) => 1);
    _appHeadingTitle = const Text("");
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
          controller: _controller,
          slivers: _buildSlivers(),
        ),
      ),
    );
  }
}
