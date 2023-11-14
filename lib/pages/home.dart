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
  final String _dataUrl = "https://www.prevision-meteo.ch/services/json";
  Map<String, dynamic> _datas = <String, dynamic>{};
  String _background = "assets/weather/base.gif";

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

  List<Widget> _buildLayouts() {
    if (_datas.isEmpty) return const <Widget>[];
    return <Widget>[
      const SizedBox(
        height: 30,
      ),
      AppHeading(
        datas: _datas,
      ),
      const SizedBox(
        height: 25,
      ),
      AppForcastHour(
        datas: _datas,
      ),
      const SizedBox(
        height: 25,
      ),
      AppForcastDay(datas: _datas),
    ];
  }

  // overrides
  @override
  void initState() {
    super.initState();
    _refreshDataTimer(milliseconds: 3000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                _background,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(color: Color.fromARGB(49, 0, 0, 0)),
            child: ListView(
              children: [
                Column(
                  children: _buildLayouts(),
                ),
              ],
            ),
          )),
    );
  }
}
