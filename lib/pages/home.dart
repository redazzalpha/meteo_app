import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_app_sliver.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/layouts/app_rain.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/pages/search.dart';
import 'package:meteo_app_v2/ui/bar_bottom.dart';
import 'package:meteo_app_v2/ui/sliver_app_heading.dart';
import 'package:meteo_app_v2/ui/sliver_app_item_shaped.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/utils/types.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Home extends StatefulWidget {
  // constructor
  const Home({super.key});

  // overrides
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // variables
  FutureDataNullable _futureData = Future(() => null);
  Data _data = Data();
  final List<FutureDataNullable> _futureFavCityDatas = <FutureDataNullable>[];
  final String _dataUrl = dataUrl;
  late String _cityName;
  late final FontHelper _fontHelper;
  late final ScrollController _scrollController;
  final int _timeoutRefreshTimer = 3000;
  final double _scrollOffsetAppHeading = 45;
  String _backgroundImage = defaultBackgroundImage;
  bool _isHeadingShort = false;

  // methods
  Future<DataNullable> _fetchData(final String localisation) async {
    try {
      final response = await http.get(Uri.parse("$_dataUrl/$localisation"));
      final result = jsonDecode(response.body) as Data;

      // if error on api response
      // return the old data
      if (result['errors'] != null) {
        showSnackBar("$localisation : ${result['errors'][0]['text']}");
        return _data;
      }

      // if no error return result
      // that will be set to _data
      // inside the FutureBuilder
      return result;
    }

    // if exception thrown
    // return the old data
    catch (e) {
      showSnackBar(
          "error fetch data : server is unavailable or network is not connected");
      return _data;
    }
  }

  Future<void> _refreshDataTimer(
      {final int milliseconds = defalutTimeoutTimer}) async {
    Timer.periodic(
      Duration(milliseconds: milliseconds),
      (_) {
        setState(() {
          _futureData = _fetchData(_cityName);
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

  MultiSliver _masterAppSlivers() {
    FontHelper fontHelper = FontHelper(context: context);
    // if (_data.isEmpty) return MultiSliver(children: const <MasterSliver>[]);

    return MultiSliver(
      children: <MasterAppSliver>[
        // if has heading
        //heading must be first

        // app heading
        SliverAppHeading(
          masterApp: AppHeading(
            datas: _data,
            isShort: _isHeadingShort,
            fontHelper: _fontHelper,
          ),
        ),

        // app forcast hour
        SliverAppItemShaped(
          masterApp: AppForcastHour(
            datas: _data,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app forcast day
        SliverAppItemShaped(
          masterApp: AppForcastDay(
            datas: _data,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app wind
        SliverAppItemShaped(
          masterApp: AppWind(
            datas: _data,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app air
        SliverAppItemShaped(
          masterApp: AppAir(
            datas: _data,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),

        // app rain
        SliverAppItemShaped(
          masterApp: AppRain(
            datas: _data,
            fontHelper: fontHelper,
          ),
          backgroundColor: defaultAppBackgroundColor,
        ),
      ],
    );
  }

  void setStatePage() {
    _backgroundImage =
        "assets/weather/${_data['current_condition']['condition_key']}.gif";
    _cityName = _data["city_info"]["name"];
  }

  List<Widget> _buildHomePage() {
    setStatePage();
    return [
      // first page
      Stack(
        children: <Widget>[
          // main content
          Container(
            padding: const EdgeInsets.all(basePadding),

            // shaped background
            decoration: BoxDecoration(
              color: const Color.fromARGB(49, 0, 0, 0),
              image: DecorationImage(
                image: AssetImage(
                  _backgroundImage,
                ),
                fit: BoxFit.cover,
              ),
            ),

            // scroll view
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // master sliver items
                _masterAppSlivers(),

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
    ];
  }

  List<Widget> _buildLoadingPage() {
    return <Widget>[
      Container(
        padding: const EdgeInsets.all(basePadding),

        // shaped background
        decoration: const BoxDecoration(
          color: Color.fromARGB(49, 0, 0, 0),
          image: DecorationImage(
            image: AssetImage(
              defaultBackgroundImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: Colors.grey,
                backgroundColor: Colors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text("loading please wait..."),
            ),
          ],
        ),
      ),
    ];
  }

  // event handlers
  void _onScroll() {
    setState(() {
      if (_scrollController.offset >= _scrollOffsetAppHeading) {
        _isHeadingShort = true;
      } else {
        _isHeadingShort = false;
      }
    });
  }

  Future<void> onNavigatorPush() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Search(
          data: _data,
          futureFavCityDatas: _futureFavCityDatas,
        ),
      ),
    );

    if (result.isNotEmpty) {
      setState(() {
        _futureData = _fetchData(result);
        _cityName = result;
      });
    }
  }

  // overrides
  @override
  void initState() {
    super.initState();

    // addFavCity("Paris");
    // addFavCity("Marseille");
    // addFavCity("Lyon");
    // clearSharedPrefs();
    getFavCity().then((cities) {
      late String lastCityName;
      for (int i = 0; i < cities.length; i++) {
        _futureFavCityDatas.add(_fetchData(cities[i]));
        lastCityName = cities[i];
      }

      setState(() {
        _cityName = lastCityName;
        _futureData = _futureFavCityDatas.last;
        _refreshDataTimer(milliseconds: _timeoutRefreshTimer);
      });
    });

    _fontHelper = FontHelper(context: context);
    _scrollController = ScrollController();
    _scrollController.addListener(() => _onScroll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<DataNullable> snapshot) {
          List<Widget> children;
          // home page
          if (snapshot.hasData) {
            _data = snapshot.data as Data;
            children = _buildHomePage();
          }

          // error page
          else if (snapshot.hasError) {
            children = <Widget>[];
          }

          // loading page
          else {
            children = _buildLoadingPage();
          }

          return PageView(children: children);
        },
      ),
    );
  }
}
