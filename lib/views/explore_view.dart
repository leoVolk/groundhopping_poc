import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

//TODO: OPTIMIZE DATA FETCHING & FUNCTIONALITY
class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  var _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SearchAnchor(
                      viewOnSubmitted: (value) {},
                      builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                          shadowColor: WidgetStateColor.transparent,
                          controller: controller,
                          padding: const WidgetStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          // onSubmitted: (value) => getResults(value),
                          leading: const Icon(Icons.search),
                        );
                      },
                      suggestionsBuilder: (BuildContext context,
                          SearchController controller) async {
                        //TODO: OPTIMIZE
                        var search = controller.text;

                        if (search.isEmpty) return List.empty();

                        final response = await http.get(Uri.parse(
                            'https://nominatim.openstreetmap.org/search?q=$search.&format=json&limit=10'));

                        var result = jsonDecode(response.body);

                        return List<ListTile>.generate(result.length,
                            (int index) {
                          final item = result[index];
                          return ListTile(
                            title: Text(item['name']),
                            subtitle: Text(
                              item['display_name'],
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                            onTap: () {
                              controller.closeView(item['display_name']);
                              _mapController.move(
                                  LatLng(double.parse(item['lat']),
                                      double.parse(item['lon'])),
                                  17);
                            },
                          );
                        });
                      }),
                ),
              ),
            ),
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                    initialCenter: LatLng(51.489919, 7.236521),
                    initialZoom: 17),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  )
                ],
              ),
            )
          ],
        ));
  }
}
