import 'package:flutter/material.dart';
import 'package:meteo_app_v2/ui/bar_search.dart';
import 'package:meteo_app_v2/ui/sliver_header_bar.dart';
import 'package:meteo_app_v2/ui/sliver_meteo_card.dart';

class Search extends StatefulWidget {
  final Map<String, dynamic> datas;
  const Search({
    super.key,
    required this.datas,
  });

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          const SliverHeaderBar(
            bottom: BarSearch(),
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
          SliverMeteoCard(
            cityName: widget.datas["city_info"]["name"],
            conditions: widget.datas["current_condition"]["condition"],
            currentTemperature: widget.datas["current_condition"]["tmp"],
            minTemperature: widget.datas["fcst_day_0"]["tmin"],
            maxTemperature: widget.datas["fcst_day_0"]["tmax"],
            backgroundImage:
                "assets/weather/${widget.datas['current_condition']['condition_key']}.gif",
          ),
        ],
      ),
    );
  }
}
