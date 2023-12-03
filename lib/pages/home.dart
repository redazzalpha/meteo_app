import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_sliver.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/layouts/app_rain.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/pages/search.dart';
import 'package:meteo_app_v2/ui/bar_bottom.dart';
import 'package:meteo_app_v2/ui/sliver_heading.dart';
import 'package:meteo_app_v2/ui/sliver_item_shaped.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Home extends StatefulWidget {
  final String? currentCity;

  // constructor
  const Home({
    super.key,
    this.currentCity,
  });

  // overrides
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // variables
  late String _city = widget.currentCity ?? "paris";
  Map<String, dynamic> _datas = const <String, dynamic>{};
  late final ScrollController _controller;
  final String _dataUrl = dataUrl;
  final int _timeoutTimer = 3000;
  final double _scrollOffset = 45;
  late final FontHelper _fontHelper;
  String _background = defaultBackground;
  bool _headingShort = false;

  // methods
  Future<Map<String, dynamic>?> _fetchData(final String localisation) async {
    _city = localisation;
    try {
      final response = await http.get(Uri.parse("$_dataUrl/$_city"));
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
        _fetchData(_city).then((datas) {
          if (datas != null && datas['current_condition'] != null) {
            setState(() {
              _datas = datas;
              _background =
                  "assets/weather/${_datas['current_condition']['condition_key']}.gif";
              log("-- async data fetched");
            });
          } else {}
        });
      },
    );
  }

  MultiSliver _masterSlivers() {
    FontHelper fontHelper = FontHelper(context: context);
    if (_datas.isEmpty) return MultiSliver(children: const <MasterSliver>[]);

    return MultiSliver(
      children: <MasterSliver>[
        // if has heading
        //heading must be first

        // app heading
        SliverHeading(
          masterApp: AppHeading(
            datas: _datas,
            isShort: _headingShort,
            fontHelper: _fontHelper,
          ),
        ),

        // app forcast hour
        SliverItemShaped(
          masterApp: AppForcastHour(
            datas: _datas,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app forcast day
        SliverItemShaped(
          masterApp: AppForcastDay(
            datas: _datas,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app wind
        SliverItemShaped(
          masterApp: AppWind(
            datas: _datas,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app air
        SliverItemShaped(
          masterApp: AppAir(
            datas: _datas,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app rain
        SliverItemShaped(
          masterApp: AppRain(
            datas: _datas,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),
      ],
    );
  }

  // event handlers
  void _onScroll() {
    setState(() {
      if (_controller.offset >= _scrollOffset) {
        _headingShort = true;
      } else {
        _headingShort = false;
      }
    });
  }

  Future<void> onPushReturnData() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Search(datas: _datas),
      ),
    );

    if (result.isNotEmpty) {
      setState(() {
        _city = result;
      });
    }
  }

  // overrides
  @override
  void initState() {
    _fontHelper = FontHelper(context: context);
    _controller = ScrollController();
    _controller.addListener(() => _onScroll());
    super.initState();
    _refreshDataTimer(milliseconds: _timeoutTimer);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        // first page
        Stack(
          children: [
            // main content
            Container(
              padding: const EdgeInsets.all(basePadding),

              // shaped background
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
                slivers: [
                  // master sliver items
                  _masterSlivers(),

                  // padding for stacked bottom app bar
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 80),
                  ),
                ],
              ),
            ),

            // bottom bar
            BarBottom(
              onPressIconList: () => onPushReturnData(),
            ),
          ],
        ),

        // other pages here
        // ...
      ],
    );
  }
}
