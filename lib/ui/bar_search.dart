import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/utils/defines.dart';

class BarSearch extends StatefulWidget {
  const BarSearch({super.key});

  @override
  State<StatefulWidget> createState() => _BarSearchState();
}

class _BarSearchState extends State<BarSearch> {
  List<dynamic> _searchResult = <dynamic>[];
  final double _width = 800;
  final double _height = 35;
  late final SearchController _controller;

// event handlers
  void onActionController() async {
    if (_controller.text.isNotEmpty) {
      final response =
          await http.get(Uri.parse("$searchUrl/${_controller.text}"));

      setState(() {
        _searchResult = jsonDecode(response.body) as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    _controller = SearchController();
    _controller.addListener(onActionController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: SearchAnchor(
        isFullScreen: true,
        searchController: _controller,

        // search bar
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            onTap: () {
              controller.openView();
            },
            onChanged: (final String input) {
              log("input: $input");
              controller.openView();
            },
            leading: const Icon(Icons.search),
            constraints: BoxConstraints(
              minHeight: _height,
              maxHeight: _height,
              minWidth: _width,
              maxWidth: _width,
            ),
            hintText: "rechercher une ville",
          );
        },

        // list result
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(_searchResult.length, (int index) {
            return ListTile(
                title: Text("${_searchResult[index]['nom']}"),
                onTap: () {
                  setState(() {
                    // if (_searchResult[index]['index'])
                    controller.closeView(null);
                    if (_searchResult[index]['nom'].isNotEmpty) {
                      Navigator.pop(context, _searchResult[index]['nom']);
                    }
                  });
                });
          });
        },
      ),
    );
  }
}
