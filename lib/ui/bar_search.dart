import 'package:flutter/material.dart';

class BarSearch extends StatefulWidget {
  const BarSearch({super.key});

  @override
  State<StatefulWidget> createState() => _BarSearchState();
}

class _BarSearchState extends State<BarSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
          constraints: const BoxConstraints(
            minHeight: 35,
            maxHeight: 35,
          ),
          hintText: "rechercher une ville",
        );
      }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              });
        });
      }),
    );
  }
}
