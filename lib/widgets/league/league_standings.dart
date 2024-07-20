import 'package:flutter/material.dart';
import 'package:groundhopper/services/sportmonks.service.dart';

class LeagueStandings extends StatefulWidget {
  const LeagueStandings({super.key, required this.season, this.league});

  final dynamic season;
  final dynamic league;

  @override
  State<LeagueStandings> createState() => _LeagueStandingsState();
}

class _LeagueStandingsState extends State<LeagueStandings>
    with TickerProviderStateMixin {
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

  Future<void> _handleRefresh() async {
    getSeasonStandings(widget.season['id']);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                  columnSpacing: 12,
                  columns: [
                    DataColumn(label: Text('Rank')),
                    DataColumn(label: Text('Name')),
                    //DataColumn(label: Text('W/D/L')),
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
                          // DataCell(Text('1/0/0')),
                          DataCell(
                            Text('${team['points']}'),
                          )
                        ]);
                  })),
            ],
          ),
        ],
      ),
    );
  }
}
