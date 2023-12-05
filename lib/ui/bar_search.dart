import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/utils/defines.dart';

class BarSearch extends StatefulWidget {
  final void Function(String) onAdd;
  final void Function(BuildContext context, String) onNavigatorPop;
  // final void Function(String) setCityName;
  const BarSearch({
    super.key,
    required this.onAdd,
    required this.onNavigatorPop,
    // required this.setCityName,
  });

  @override
  State<StatefulWidget> createState() => _BarSearchState();
}

class _BarSearchState extends State<BarSearch> {
  List<dynamic> _searchResults = <dynamic>[];
  final double _height = 35;
  late SearchController _searchController;
  bool _isAdding = false;

// methods
  String checkZipCode(final int index) {
    if (_searchResults[index]['codesPostaux'].isNotEmpty) {
      return "${_searchResults[index]['codesPostaux'][0]}";
    } else {
      return "(code postal indéfini)";
    }
  }

// event handlers
  Future<void> _onSearchAction(final String input) async {
    if (input.isNotEmpty) {
      final response = await http.get(Uri.parse("$searchUrl/$input"));
      _searchResults = jsonDecode(response.body) as List<dynamic>;
    }
  }

  void addToFavorite() {
    _isAdding = true;
    _searchController.openView();
  }

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 35,
            bottom: 35,
            left: 15,
            right: 15,
          ),
          child: SearchAnchor(
            searchController: _searchController,
            // search bar
            builder: (BuildContext context, SearchController controller) {
              return Container(
                width: double.maxFinite,
                height: _height,
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    // search icon
                    const Icon(Icons.search),
                    // padding
                    const SizedBox(width: 15),
                    // placeholder
                    const Text("rechercher une ville"),
                    // spacer
                    const Spacer(),
                    // add buttonIcon
                    IconButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onPressed: addToFavorite,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              );
            },

            // result list
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
              await _onSearchAction(controller.text);

              return List<ListTile>.generate(_searchResults.length,
                  (int index) {
                String cityName = _searchResults[index]['nom'];
                String zipCode = checkZipCode(index);
                String suggestion = "$cityName - $zipCode";

                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    if (_isAdding) {
                      widget.onAdd(cityName);
                      _isAdding = false;
                    }

                    // widget.setCityName(cityName);
                    controller.closeView(suggestion);
                    widget.onNavigatorPop(context, cityName);

                    // Navigator.pop(context, cityName);
                    // if (_cityName.isNotEmpty) {
                    // }
                  },
                );
              });
            },
          ),
        )
      ],
    );
  }
}
