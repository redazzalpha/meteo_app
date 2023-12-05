import 'package:flutter/material.dart';
import 'package:meteo_app_v2/ui/bar_search.dart';
import 'package:meteo_app_v2/ui/sliver_header_bar.dart';
import 'package:meteo_app_v2/ui/sliver_meteo_card.dart';
import 'package:meteo_app_v2/utils/defines.dart';
import 'package:meteo_app_v2/utils/types.dart';

class Search extends StatefulWidget {
  // variables
  final ListDataNullable futureFavCityDatas;

  // constructor
  const Search({
    super.key,
    required this.futureFavCityDatas,
  });

  // overrides
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final ListDataNullable _favCityDatas;

  // methods
  List<Widget> _buildSearchPage() {
    List<Widget> meteoCards = <Widget>[
      const SliverHeaderBar(
        bottom: BarSearch(),
      )
    ];

    for (int i = 0; i < _favCityDatas.length; i++) {
      meteoCards.add(
        SliverMeteoCard(
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

    return meteoCards;
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

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Future(() => widget.futureFavCityDatas),
      builder:
          (BuildContext context, AsyncSnapshot<ListDataNullable> snapshot) {
        List<Widget> children;

        // search page
        if (snapshot.hasData) {
          _favCityDatas = snapshot.data as ListDataNullable;
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
