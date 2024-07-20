import 'package:flutter/material.dart';
import 'package:groundhopper/services/sportmonks.service.dart';

class LeagueView extends StatefulWidget {
  const LeagueView({super.key, required this.season, this.league});

  final dynamic season;
  final dynamic league;

  @override
  State<LeagueView> createState() => _LeagueViewState();
}

class _LeagueViewState extends State<LeagueView> {
  final sportMonksService = SportmonkService();

  var standings = List.empty();

  Future getSeasonStandings(var id) async {
    var s = await sportMonksService.getSeasonStandings(id);

    setState(() {
      standings = s;
    });
  }

  @override
  void initState() {
    super.initState();
    getSeasonStandings(widget.season['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.league['name'] + ' ' + widget.season['name']),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                  columns: [
                    DataColumn(label: Text('Rank')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Points'), numeric: true)
                  ],
                  rows: List.generate(standings.length, (index) {
                    var team = standings[index];

                    return DataRow(
                        color: index.isEven
                            ? WidgetStatePropertyAll(Colors.transparent)
                            : WidgetStatePropertyAll(
                                Colors.grey.withOpacity(0.1)),
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                Text('${index + 1}.'),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8)),
                                Image.network(
                                  team['participant']['image_path'],
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(team['participant']['name']),
                          ),
                          DataCell(
                            Text('${team['points']}'),
                          )
                        ]);
                  }))
            ],
          ),
        ));
  }
}
