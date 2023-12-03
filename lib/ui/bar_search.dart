import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/utils/defines.dart';

class BarSearch extends StatefulWidget {
  const BarSearch({super.key});

  @override
  State<StatefulWidget> createState() => _BarSearchState();
}

class _BarSearchState extends State<BarSearch> {
  List<dynamic> _searchResults = <dynamic>[];
  final double _height = 35;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 60,
        bottom: 40,
        left: 15,
        right: 15,
      ),
      child: SearchAnchor(
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
            child: const Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 15),
                Text("rechercher une ville")
              ],
            ),
          );
        },

        // result list
        suggestionsBuilder:
            (BuildContext context, SearchController controller) async {
          await _onSearchAction(controller.text);

          return List<ListTile>.generate(_searchResults.length, (int index) {
            String cityName = _searchResults[index]['nom'];
            String zipCode = checkZipCode(index);
            String suggestion = "$cityName - $zipCode";

            return ListTile(
                title: Text(suggestion),
                onTap: () {
                  // setState(() {});
                  controller.closeView(suggestion);
                  Navigator.pop(context, cityName);
                  // if (_cityName.isNotEmpty) {
                  // }
                });
          });
        },
      ),
    );
  }
}
