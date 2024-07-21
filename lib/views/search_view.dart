import 'package:flutter/material.dart';
import 'package:groundhopper/services/sportmonks.service.dart';
import 'package:groundhopper/views/league_view.dart';
import 'package:groundhopper/widgets/main_drawer.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final sportMonksService = SportmonkService();

  late var leagues = List<dynamic>.empty();

  Future getLeagues() async {
    var resp = await sportMonksService.getLeagues();

    setState(() {
      // leagues = resp.where((l) => l['sub_type'] != 'play-offs').toList();
      leagues = resp;
    });
  }

  @override
  void initState() {
    super.initState();
    getLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Leagues'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      drawer: MainDrawerWidget(),
      body: ListView.builder(
          itemCount: leagues.length,
          itemBuilder: (BuildContext context, int index) {
            var league = leagues[index];

            return ListTile(
                contentPadding: EdgeInsets.all(8),
                title: Text(league['name']),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(league['image_path']),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeagueView(
                              season: league['currentseason'],
                              league: league,
                            ))));
          }),
    );
  }
}
