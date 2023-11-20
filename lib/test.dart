import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/templates/template_title.dart';

class Test extends StatefulWidget {
  // constructor
  const Test({
    super.key,
  });

  // overrides
  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test> {
  // variables
  late final ScrollController _controller;
  final String _dataUrl = "https://www.prevision-meteo.ch/services/json";
  Map<String, dynamic> _datas = <String, dynamic>{};
  String _background = "assets/weather/base.gif";
  final double _scrollOffset = 80;
  final double _scrollOffset1 = 290;
  final double _scrollOffset2 = 510;
  late Widget _appHeadingTitle;
  double _opacityForcastHour = 0;
  double _opacityForcastDay = 0;

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
        snap: true,
        floating: true,
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
        pinned: true,
        toolbarHeight: 60,
        expandedHeight: 155.0,
        forceMaterialTransparency: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Opacity(
            opacity: _opacityForcastHour,
            child: const TemplateTitle(
              height: 60,
              titleIcon: Icons.access_time,
              title: "Prévision heure par heure",
            ),
          ),
          background: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              AppForcastHour(
                datas: _datas,
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),

      // app forcast day
      SliverAppBar(
        pinned: true,
        toolbarHeight: 60,
        expandedHeight: 225.0,
        forceMaterialTransparency: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Opacity(
            opacity: _opacityForcastDay,
            child: const TemplateTitle(
              height: 60,
              titleIcon: Icons.calendar_month,
              title: "Prévisions pour 5 jours",
            ),
          ),
          background: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              AppForcastDay(
                datas: _datas,
              ),
            ],
          ),
          centerTitle: true,
          // title: Text('Meteo app'),
        ),
      ),

      // app forcast day
      SliverAppBar(
        pinned: true,
        expandedHeight: 225.0,
        forceMaterialTransparency: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              AppForcastDay(
                datas: _datas,
              ),
            ],
          ),
          centerTitle: true,
          // title: Text('Meteo app'),
        ),
      ),

      // app forcast day
      SliverAppBar(
        pinned: true,
        expandedHeight: 225.0,
        forceMaterialTransparency: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              AppForcastDay(
                datas: _datas,
              ),
            ],
          ),
          centerTitle: true,
          // title: Text('Meteo app'),
        ),
      ),

      // app forcast day
      SliverAppBar(
        pinned: true,
        expandedHeight: 225.0,
        forceMaterialTransparency: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              AppForcastDay(
                datas: _datas,
              ),
            ],
          ),
          centerTitle: true,
          // title: Text('Meteo app'),
        ),
      ),
    ];
  }

  // event handlers
  void _handleScroll() {
    log(_controller.offset.toString());
    setState(() {
      if (_controller.offset >= _scrollOffset) {
        updateAppHeadingTitle(visible: true);
      } else {
        updateAppHeadingTitle(visible: false);
      }
      if (_controller.offset >= _scrollOffset1) {
        _opacityForcastHour = 1;
      } else {
        _opacityForcastHour = 0;
      }
      if (_controller.offset >= _scrollOffset2) {
        _opacityForcastDay = 1;
      } else {
        _opacityForcastDay = 0;
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
        child: ListView(
          children: [
            SizedBox(
              child: CustomScrollView(
                controller: _controller,
                slivers: _buildLayouts(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
