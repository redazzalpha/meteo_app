import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/layouts/app_forcast.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';

class Home extends StatefulWidget {
  // constructor
  const Home({super.key});
  final String test = "salut les coupains comment ça va chez ?";
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
  void fetchData(String localisation) async {
    var response = await http.get(Uri.parse("$_dataUrl/$localisation"));
    try {
      setState(() {
        _datas = jsonDecode(response.body) as Map<String, dynamic>;
      });

      log("data fetched!");
    } catch (e) {
      log("-- error fetch data: $e");
    }
  }

  void refreshDataTimer({int milliseconds = 1000}) async {
    Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      fetchData("Paris");
      if (_datas.isNotEmpty) {
        setState(() {
          _background =
              "assets/weather/${_datas["fcst_day_0"]["condition"]}.gif";
        });
      }
    });
  }

  // overrides
  @override
  void initState() {
    super.initState();
    refreshDataTimer(milliseconds: 3000);
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
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(color: Color.fromARGB(49, 0, 0, 0)),
            child: ListView(
              children: [
                Column(
                  children: [
                    AppHeading(
                      datas: _datas,
                    ),
                    AppForcast(
                      datas: _datas,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
