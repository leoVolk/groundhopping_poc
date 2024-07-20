import 'package:flutter/material.dart';
import 'package:groundhopper/services/sportmonks.service.dart';

class LeagueFixtures extends StatefulWidget {
  const LeagueFixtures({super.key, required this.season, this.league});

  final dynamic season;
  final dynamic league;

  @override
  State<LeagueFixtures> createState() => _LeagueFixturesState();
}

class _LeagueFixturesState extends State<LeagueFixtures>
    with TickerProviderStateMixin {
  final sportMonksService = SportmonkService();

  dynamic schedules;
  List<dynamic> rounds = List.empty();
  dynamic currentRound;
  dynamic currentRoundIndex;
  List<dynamic> fixtures = List.empty();

  Future<void> getSeasonSchedule(var id) async {
    var resp = await sportMonksService.getSeasonSchedule(id);

    setState(() {
      schedules = resp[0];
      rounds = schedules['rounds'] as List;
      currentRound = rounds.where((r) => r['is_current']).firstOrNull;

      currentRound ??= rounds[0];

      currentRoundIndex =
          currentRound != null ? int.parse(currentRound['name']) : 0;

      print(currentRoundIndex - 1);

      fixtures = currentRound['fixtures'];
    });
  }

  @override
  void initState() {
    super.initState();
    getSeasonSchedule(widget.season['id']);
  }

  Future<void> _handleRefresh() async {
    getSeasonSchedule(widget.season['id']);
  }

  @override
  Widget build(BuildContext context) {
    if (schedules == null) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ));
    }

    const textStyle = TextStyle(fontSize: 16);

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                if (currentRound != null)
                  Text(
                    'Matchday ${currentRound['name']}',
                    style: TextStyle(fontSize: 24),
                  ),
                if (currentRound == null)
                  Text(
                    'Matchday 0',
                    style: TextStyle(fontSize: 24),
                  ),
              ],
            ),
          ),
          Column(
            children: List.generate(fixtures.length, (index) {
              var f = fixtures[index];
              var team1 = f['participants'][0];
              var team2 = f['participants'][1];

              var startTime = DateTime.parse(f['starting_at']);

              bool isFinishedOrCurrent = startTime.isBefore(DateTime.now());

              var scoresTeam1 = (f['scores'] as List)
                  .where(
                    (element) => element['score']['participant'] == 'home',
                  )
                  .length;

              var scoresTeam2 = (f['scores'] as List)
                  .where(
                    (element) => element['score']['participant'] == 'away',
                  )
                  .length;

              return Card(
                clipBehavior: Clip.hardEdge,
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          team1['name'],
                          style: textStyle,
                        )),
                        if (isFinishedOrCurrent)
                          Expanded(
                              child: Container(
                            color: Theme.of(context).colorScheme.surface,
                            child: Text(
                              '$scoresTeam1:$scoresTeam2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )),
                        if (!isFinishedOrCurrent)
                          Expanded(
                              child: (Text(
                            '${startTime.day}.${startTime.month}.',
                            textAlign: TextAlign.center,
                          ))),
                        Expanded(
                            child: Text(
                          team2['name'],
                          textAlign: TextAlign.end,
                          style: textStyle,
                        ))
                      ],
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
