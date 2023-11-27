import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/ui/bar_bottom.dart';
import 'package:meteo_app_v2/ui/sliver_app_list.dart';
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
  late final ScrollController _controller;
  final String _dataUrl = dataUrl;
  final int _timeoutTimer = 3000;
  final double _scrollOffset = 45;
  late ScrollPhysics _scrollPhysic;
  late SliverAppList _sliverAppList;
  String _background = defaultBackground;

  // methods
  Future<Map<String, dynamic>?> _fetchData(final String localisation) async {
    try {
      final response = await http.get(Uri.parse("$_dataUrl/$localisation"));
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      log("-- error fetch data: $e");
      return null;
    }
  }

  void _refreshDataTimer({final int milliseconds = defalutTimeoutTimer}) async {
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

  List<MasterApp> _masterAppsList() {
    return <MasterApp>[
      AppHeading(datas: _datas),
      AppForcastHour(
        datas: _datas,
      ),
      AppForcastDay(datas: _datas),
      AppWind(datas: _datas),
      AppAir(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
      AppForcastDay(datas: _datas),
    ];
  }

  // event handlers
  void updateScrollPhysic(ScrollPhysics scrollPhysic) {
    _scrollPhysic = scrollPhysic;
  }

  // overrides
  @override
  void initState() {
    _scrollPhysic = const AlwaysScrollableScrollPhysics();
    _controller = ScrollController();
    super.initState();
    _refreshDataTimer(milliseconds: _timeoutTimer);
  }

  @override
  Widget build(BuildContext context) {
    _sliverAppList = SliverAppList(
      masterApps: _masterAppsList(),
      controller: _controller,
      scrollOffset: _scrollOffset,
      onScrollPhysic: updateScrollPhysic,
    );

    return PageView(
      children: [
        // first page
        Stack(
          children: [
            // main content
            Container(
              padding: const EdgeInsets.all(basePadding),
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
                physics: _scrollPhysic,
                controller: _controller,
                slivers: [
                  _sliverAppList,

                  // padding for stacked bottom bar
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 80),
                  ),
                ],
              ),
            ),

            // bottom bar
            const BarBottom(),
          ],
        ),

        // other pages here
        // ...
      ],
    );
  }
}
