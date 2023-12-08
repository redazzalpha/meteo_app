import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/ui/bar_search.dart';
import 'package:meteo_app_v2/ui/sliver_header_bar.dart';
import 'package:meteo_app_v2/ui/sliver_meteo_card.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/functions.dart';
import 'package:meteo_app_v2/utils/types.dart';

class Search extends StatefulWidget {
  final FontHelper? fontHelper;

  // constructor
  const Search({
    super.key,
    this.fontHelper,
  });

  // overrides
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final String _dataUrl = dataUrl;
  final ListDataNullable _favCityDatas = <DataNullable>[];
  late final FontHelper _fontHelper;

  // event handlers
  void _onTapMeteoCard(BuildContext context, final String cityName) {
    Navigator.pop(context, cityName);
  }

  void _onRemove(final String cityName) async {
    await removeFavCity(cityName);
    _getFavoriteCityDatas();
  }

  void _onNavigatorPop(BuildContext context, final String cityName) {
    if (cityName.isNotEmpty) {
      Navigator.pop(context, cityName);
    }
  }

  Future<void> _onAddFavorite(final String cityName) async {
    DataNullable data = await _fetchData(cityName);
    if (data != null) {
      addFavCity(cityName);
      _favCityDatas.insert(0, data);
    }

    setState(() {});
  }

  // methods
  Future<void> _getFavoriteCityDatas() async {
    _favCityDatas.clear();

    getFavCity().then((cities) async {
      for (int i = 0; i < cities.length; i++) {
        _favCityDatas.add(await _fetchData(cities[i]));
      }
      setState(() {});
    });
  }

  List<Widget> _buildSearchPage() {
    List<Widget> children = <Widget>[
      SliverHeaderBar(
        bottom: BarSearch(
          onNavigatorPop: _onNavigatorPop,
          onAdd: _onAddFavorite,
        ),
      ),
    ];

    for (int i = 0; i < _favCityDatas.length; i++) {
      children.add(
        SliverMeteoCard(
          onTap: _onTapMeteoCard,
          onRemove: _onRemove,
          cityName: _favCityDatas[i]?["city_info"]["name"],
          conditions: _favCityDatas[i]?["current_condition"]["condition"],
          currentTemperature: _favCityDatas[i]?["current_condition"]["tmp"],
          minTemperature: _favCityDatas[i]?["fcst_day_0"]["tmin"],
          maxTemperature: _favCityDatas[i]?["fcst_day_0"]["tmax"],
          backgroundImage:
              "assets/weather/${_favCityDatas[i]?['current_condition']['condition_key']}.gif",
        ),
      );
    }

    return children;
  }

  List<Widget> _buildLoadingPage() {
    return <Widget>[
      SliverFillViewport(
        delegate: SliverChildListDelegate(
          [
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
          ],
        ),
      )
    ];
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

  Future<DataNullable> _fetchData(final String localisation) async {
    try {
      final response = await http.get(Uri.parse("$_dataUrl/$localisation"));
      final resultsData = jsonDecode(response.body) as Data;

      // if error on api response
      // return the old data
      if (resultsData['errors'] != null) {
        showSnackBar("$localisation : ${resultsData['errors'][0]['text']}");
        return null;
      }

      // if no error return resultsData
      // that will be set to _data
      // inside the FutureBuilder
      return resultsData;
    }

    // if exception thrown
    // return the old data
    catch (e) {
      showSnackBar(
          "error fetch data : server is unavailable or network is not connected");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _getFavoriteCityDatas();
    _fontHelper = widget.fontHelper ?? FontHelper(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Future(() => _favCityDatas),
      builder:
          (BuildContext context, AsyncSnapshot<ListDataNullable> snapshot) {
        List<Widget> children;

        // search page
        if (snapshot.hasData) {
          children = _buildSearchPage();
        }

        // error page
        else if (snapshot.hasError) {
          children = <Widget>[];
        }

        // loading page
        else {
          children = _buildLoadingPage();
        }

        return CustomScrollView(
          slivers: children,
        );
      },
    ));
  }
}
