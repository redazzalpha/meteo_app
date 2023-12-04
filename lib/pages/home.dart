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
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/utils/types.dart';
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
  final List<FutureDataNullable> _favCityDatas = <FutureDataNullable>[];
  late String _cityName;
  late String _cityNameTemp;
  late final ScrollController _controller;
  final String _dataUrl = dataUrl;
  final int _timeoutTimer = 3000;
  final double _scrollOffset = 45;
  late final FontHelper _fontHelper;
  Data _datas = Data();
  String _background = defaultBackground;
  bool _headingShort = false;

  // methods

  Future<DataNullable> _fetchData(final String localisation) async {
    try {
      _cityName = localisation;
      final response = await http.get(Uri.parse("$_dataUrl/$localisation"));
      return jsonDecode(response.body) as Data;
    } catch (e) {
      log("-- error fetch data: $e");
      return null;
    }
  }

  void _refreshDataTimer({final int milliseconds = defalutTimeoutTimer}) async {
    Timer.periodic(
      Duration(milliseconds: milliseconds),
      (_) {
        _fetchData(_cityName).then((datas) {
          if (datas != null) {
            if (datas["errors"] != null) {
              // possible values for errors
              // 'code', 'text' or 'description'
              showSnackBar("$_cityName : ${datas['errors'][0]['text']} !");

              // switch back to the old value
              _cityName = _cityNameTemp;
            } else {
              setState(() {
                _datas = datas;
                _background =
                    "assets/weather/${_datas['current_condition']['condition_key']}.gif";
                // store current value to get it back if needeed
                _cityNameTemp = _cityName;
                log("-- async data fetched");
              });
            }
          } else {
            showSnackBar("error fetch data server is unavailable");
          }
        });
      },
    );
  }

  void showSnackBar(final String message) {
    ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);

    scaffoldMessengerState.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Text(
          message,
          style: _fontHelper.label(),
        ),
        action: SnackBarAction(
          textColor: _fontHelper.label().color,
          label: "Close",
          onPressed: scaffoldMessengerState.hideCurrentSnackBar,
        ),
      ),
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

  Future<void> onNavigatorPush() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Search(
          datas: _datas,
          favCityDatas: _favCityDatas,
        ),
      ),
    );

    if (result.isNotEmpty) {
      setState(() {
        _cityName = result;
      });
    }
  }

  // overrides
  @override
  void initState() {
    super.initState();
    // clearSharedPrefs();
    // addFavCity("Paris");
    // addFavCity("Marseille");
    // addFavCity("Lyon");

    getFavCity().then((cities) {
      late String lastCityName;
      for (int i = 0; i < cities.length; i++) {
        _favCityDatas.add(_fetchData(cities[i]));
        lastCityName = cities[i];
      }
      setState(() {
        _cityName = lastCityName;
        _cityNameTemp = _cityName;
      });
    });

    _fontHelper = FontHelper(context: context);
    _controller = ScrollController();
    _controller.addListener(() => _onScroll());
    _refreshDataTimer(milliseconds: _timeoutTimer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
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
                onPressIconList: () => onNavigatorPush(),
              ),
            ],
          ),

          // other pages here
          // ...
        ],
      ),
    );
  }
}
