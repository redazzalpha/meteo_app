import 'package:flutter/material.dart';
import 'package:meteo_app_v2/ui/bar_search.dart';
import 'package:meteo_app_v2/ui/sliver_header_bar.dart';
import 'package:meteo_app_v2/ui/sliver_meteo_card.dart';
import 'package:meteo_app_v2/utils/types.dart';

class Search extends StatefulWidget {
  final Data datas;
  final List<FutureDataNullable> favCityDatas;

  const Search({
    super.key,
    required this.datas,
    required this.favCityDatas,
  });

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final Future<List<Data>> _computation;
  final List<Data> _cityDatas = <Data>[];

  // methods
  List<Widget> _buildSliverMeteo() {
    List<Widget> meteoCards = <Widget>[
      const SliverHeaderBar(
        bottom: BarSearch(),
      )
    ];

    for (int i = 0; i < _cityDatas.length; i++) {
      meteoCards.add(
        SliverMeteoCard(
          cityName: _cityDatas[i]["city_info"]["name"],
          conditions: _cityDatas[i]["current_condition"]["condition"],
          currentTemperature: _cityDatas[i]["current_condition"]["tmp"],
          minTemperature: _cityDatas[i]["fcst_day_0"]["tmin"],
          maxTemperature: _cityDatas[i]["fcst_day_0"]["tmax"],
          backgroundImage:
              "assets/weather/${_cityDatas[i]['current_condition']['condition_key']}.gif",
        ),
      );
    }

    return meteoCards;
  }

  @override
  void initState() {
    super.initState();

    _computation = Future<List<Data>>.delayed(
      const Duration(seconds: 1),
      () async {
        for (int i = 0; i < widget.favCityDatas.length; i++) {
          DataNullable data = await widget.favCityDatas[i];
          if (data != null) _cityDatas.add(data);
        }
        return _cityDatas;
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _computation,
      builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = _buildSliverMeteo();
        } else if (snapshot.hasError) {
          children = <Widget>[];
        } else {
          children = <Widget>[
            SliverFillViewport(
              delegate: SliverChildListDelegate(
                [
                  const Column(
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
                ],
              ),
            ),
          ];
        }
        return CustomScrollView(
          slivers: children,
        );
      },
    ));
  }
}

// @override
// Widget build(BuildContext context) {
//   return DefaultTextStyle(
//     style: Theme.of(context).textTheme.displayMedium!,
//     textAlign: TextAlign.center,
//     child: FutureBuilder<String>(
//       future: _computation, // a previously-obtained Future<String> or null
//       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//         List<Widget> children;
//         if (snapshot.hasData) {
//           children = <Widget>[
//             const Icon(
//               Icons.check_circle_outline,
//               color: Colors.green,
//               size: 60,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 16),
//               child: Text('Result: ${snapshot.data}'),
//             ),
//           ];
//         } else if (snapshot.hasError) {
//           children = <Widget>[
//             const Icon(
//               Icons.error_outline,
//               color: Colors.red,
//               size: 60,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 16),
//               child: Text('Error: ${snapshot.error}'),
//             ),
//           ];
//         } else {
//           children = const <Widget>[
//             SizedBox(
//               width: 60,
//               height: 60,
//               child: CircularProgressIndicator(),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 16),
//               child: Text('Awaiting result...'),
//             ),
//           ];
//         }




//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: children,
//           ),
//         );
//       },
//     ),
//   );
// }
















      // CustomScrollView(
      //   slivers: <Widget>[
      //     const SliverHeaderBar(
      //       bottom: BarSearch(),
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //     SliverMeteoCard(
      //       cityName: widget.datas["city_info"]["name"],
      //       conditions: widget.datas["current_condition"]["condition"],
      //       currentTemperature: widget.datas["current_condition"]["tmp"],
      //       minTemperature: widget.datas["fcst_day_0"]["tmin"],
      //       maxTemperature: widget.datas["fcst_day_0"]["tmax"],
      //       backgroundImage:
      //           "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
      //     ),
      //   ],
      // ),

