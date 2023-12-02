import 'package:flutter/material.dart';

class BarSearch extends StatefulWidget {
  const BarSearch({super.key});

  @override
  State<StatefulWidget> createState() => _BarSearchState();
}

class _BarSearchState extends State<BarSearch> {
  final double _width = 800;
  final double _height = 35;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
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
          viewConstraints: BoxConstraints(
            maxWidth: _width,
            minWidth: _width,
          ),
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              return ListTile(
                  title: Text('item $index'),
                  onTap: () {
                    setState(() {
                      controller.closeView('item $index');
                    });
                  });
            });
          }),
    );
  }
}
