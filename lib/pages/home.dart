import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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
  late final ScrollController _controller;
  final String _dataUrl = "https://www.prevision-meteo.ch/services/json";
  Map<String, dynamic> _datas = <String, dynamic>{};
  String _background = "assets/weather/base.gif";
  final double _scrollOffset = 80;
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

  void updateAppHeadingTitle({final bool visible = true}) {
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

  List<Widget> _buildLayouts() {
    if (_datas.isEmpty) return const <Widget>[];
    return <Widget>[
      // app heading
      SliverAppBar(
        primary: true,
        toolbarHeight: 100,
        expandedHeight: 200.0,
        pinned: true,
        forceMaterialTransparency: true,
        flexibleSpace: FlexibleSpaceBar(
          title: _appHeadingTitle,
          background: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              AppHeading(
                datas: _datas,
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),

      // app forcast hour
      SliverAppBar(
        toolbarHeight: 40,
        expandedHeight: 155.0,
        pinned: true,
        forceMaterialTransparency: true,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: FlexibleSpaceBarSettings(
            currentExtent: 200,
            maxExtent: 200,
            minExtent: 200,
            toolbarOpacity: 1,
            child: FlexibleSpaceBar(
              background: Column(
                children: [
                  AppForcastHour(
                    height: 90,
                    datas: _datas,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // app forcast day
      SliverAppBar(
        toolbarHeight: 40,
        expandedHeight: 220.0,
        pinned: true,
        forceMaterialTransparency: true,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: FlexibleSpaceBarSettings(
            currentExtent: 241,
            maxExtent: 241,
            minExtent: 241,
            toolbarOpacity: 1,
            child: FlexibleSpaceBar(
              background: Column(
                children: [
                  AppForcastDay(
                    height: 155,
                    datas: _datas,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // app forcast day
      SliverAppBar(
        toolbarHeight: 40,
        expandedHeight: 220.0,
        pinned: true,
        forceMaterialTransparency: true,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: FlexibleSpaceBarSettings(
            currentExtent: 241,
            maxExtent: 241,
            minExtent: 241,
            toolbarOpacity: 1,
            child: FlexibleSpaceBar(
              background: Column(
                children: [
                  AppForcastDay(
                    height: 155,
                    datas: _datas,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // app forcast day
      SliverAppBar(
        toolbarHeight: 40,
        expandedHeight: 220.0,
        pinned: true,
        forceMaterialTransparency: true,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: FlexibleSpaceBarSettings(
            currentExtent: 241,
            maxExtent: 241,
            minExtent: 241,
            toolbarOpacity: 1,
            child: FlexibleSpaceBar(
              background: Column(
                children: [
                  AppForcastDay(
                    height: 155,
                    datas: _datas,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // app forcast day
      SliverAppBar(
        toolbarHeight: 40,
        expandedHeight: 220.0,
        pinned: true,
        forceMaterialTransparency: true,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: FlexibleSpaceBarSettings(
            currentExtent: 241,
            maxExtent: 241,
            minExtent: 241,
            toolbarOpacity: 1,
            child: FlexibleSpaceBar(
              background: Column(
                children: [
                  AppForcastDay(
                    height: 155,
                    datas: _datas,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // bottom padding
      const SliverPadding(
        padding: EdgeInsets.only(top: 300),
      ),
    ];
  }

  // event handlers
  void _handleScroll() {
    setState(() {
      if (_controller.offset >= _scrollOffset) {
        updateAppHeadingTitle(visible: true);
      } else {
        updateAppHeadingTitle(visible: false);
      }
    });
  }

  // overrides
  @override
  void initState() {
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
