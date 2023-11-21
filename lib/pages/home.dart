import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';

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
  final String _dataUrl = "https://www.prevision-meteo.ch/services/json";
  Map<String, dynamic> _datas = <String, dynamic>{};
  String _background = "assets/weather/base.gif";
  final double _scrollOffset = 45;
  final int _sliverMinHeight = 100;
  final int _sliversLength = 6;
  late final ScrollController _controller;
  late final List<GlobalKey> _keys;
  late final List<double> _opacities;
  late RenderSliverPinnedPersistentHeader _renderObject;
  late double _sliverHeight;
  late Widget _appHeadingTitle;

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

  void _updateSlivers() {
    for (int i = 0; i < _sliversLength; i++) {
      _renderObject = _keys[i].currentContext!.findRenderObject()
          as RenderSliverPinnedPersistentHeader;
      _sliverHeight = _renderObject.child!.size.height;

      if (_sliverHeight <= _sliverMinHeight) {
        _opacities[i] = 0;
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

  List<Widget> _buildLayouts() {
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
      SliverAnimatedOpacity(
        opacity: _opacities[0],
        duration: const Duration(milliseconds: 500),
        sliver: SliverAppBar(
          key: _keys[0],
          toolbarHeight: 0,
          expandedHeight: 140,
          // collapsedHeight: 100,
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
      SliverAnimatedOpacity(
        opacity: _opacities[1],
        duration: const Duration(milliseconds: 500),
        sliver: SliverAppBar(
          key: _keys[1],
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
      SliverAnimatedOpacity(
        opacity: _opacities[2],
        duration: const Duration(milliseconds: 500),
        sliver: SliverAppBar(
          key: _keys[2],
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
      SliverAnimatedOpacity(
        opacity: _opacities[3],
        duration: const Duration(milliseconds: 500),
        sliver: SliverAppBar(
          key: _keys[3],
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
      SliverAnimatedOpacity(
        opacity: _opacities[4],
        duration: const Duration(milliseconds: 500),
        sliver: SliverAppBar(
          key: _keys[4],
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
      SliverAnimatedOpacity(
        opacity: _opacities[5],
        duration: const Duration(milliseconds: 500),
        sliver: SliverAppBar(
          key: _keys[5],
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
    _keys = List<GlobalKey>.generate(_sliversLength, (index) => GlobalKey());
    _opacities = List<double>.generate(_sliversLength, (index) => 1);
    _controller = ScrollController();
    _controller.addListener(_handleScroll);
    _refreshDataTimer(milliseconds: 3000);
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
          slivers: _buildLayouts(),
        ),
      ),
    );
  }
}
