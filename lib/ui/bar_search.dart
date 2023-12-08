import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo_app_v2/utils/defines.dart';

class BarSearch extends StatefulWidget {
  final void Function(String) onAdd;
  final void Function(BuildContext context, String) onNavigatorPop;
  final String placeholder;
  const BarSearch({
    super.key,
    required this.onAdd,
    required this.onNavigatorPop,
    this.placeholder = "rechercher une ville",
  });

  @override
  State<StatefulWidget> createState() => _BarSearchState();
}

class _BarSearchState extends State<BarSearch> {
  List<dynamic> _suggestionResults = <dynamic>[];
  final double _height = 35;
  late SearchController _searchController;
  bool _isAdding = false;

// methods
  String _checkZipCode(final int index) {
    if (_suggestionResults[index]['codesPostaux'].isNotEmpty) {
      return "${_suggestionResults[index]['codesPostaux'][0]}";
    } else {
      return "(code postal indéfini)";
    }
  }

// event handlers
  Future<void> _fetchSuggestions(final String input) async {
    if (input.isNotEmpty) {
      final response = await http.get(Uri.parse("$searchUrl/$input"));
      _suggestionResults = jsonDecode(response.body) as List<dynamic>;
    }
  }

  void _onclikAddFavorite() {
    _isAdding = true;
    _searchController.openView();
  }

  void _onTapSuggestion(final String cityName, final String suggestion) {
    if (_isAdding) widget.onAdd(cityName);

    _searchController.closeView(suggestion);
    if (!_isAdding) {
      widget.onNavigatorPop(context, cityName);
    }
    _isAdding = false;
  }

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 35,
        bottom: 35,
        left: 15,
        right: 15,
      ),
      child: SearchAnchor(
        searchController: _searchController,

        /*NOTE: SearchAnchor (aka the search bar)
         auto handles on click events
        and auto open suggestion list*/
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
                Text(widget.placeholder),
                // spacer
                const Spacer(),
                // add buttonIcon
                IconButton(
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: _onclikAddFavorite,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                const SizedBox(width: 15),
              ],
            ),
          );
        },

        // suggestion list
        suggestionsBuilder:
            (BuildContext context, SearchController controller) async {
          await _fetchSuggestions(controller.text);

          return List<ListTile>.generate(_suggestionResults.length,
              (int index) {
            String cityName = _suggestionResults[index]['nom'];
            String zipCode = _checkZipCode(index);
            String suggestion = "$cityName - $zipCode";

            return ListTile(
              title: Text(suggestion),
              onTap: () => _onTapSuggestion(cityName, suggestion),
            );
          });
        },
      ),
    );
  }
}
