import 'package:flutter/material.dart';
import 'package:groundhopper/services/sportmonks.service.dart';
import 'package:groundhopper/utils/sportmonks.utils.dart';
import 'package:groundhopper/views/match_view.dart';

class DomesticFixtures extends StatefulWidget {
  const DomesticFixtures({super.key, required this.season});

  final dynamic season;
  //final dynamic league;

  @override
  State<DomesticFixtures> createState() => _DomesticFixturesState();
}

class _DomesticFixturesState extends State<DomesticFixtures>
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
          currentRound != null ? int.parse(currentRound['name']) - 1 : 0;

      fixtures = currentRound['fixtures'];
    });
  }

  @override
  void initState() {
    super.initState();
    getSeasonSchedule(widget.season['id']);
  }

  Future<void> _handleRefresh() async {
    //TODO: Rewrite to not reset matchday scrolling
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
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    disabledColor: Colors.transparent,
                    onPressed: currentRoundIndex == 0
                        ? null
                        : () {
                            setState(() {
                              currentRoundIndex -= 1;
                              currentRound = rounds[currentRoundIndex];
                              fixtures = currentRound['fixtures'];
                            });
                          },
                    icon: Icon(Icons.arrow_back)),
                Text(
                  'Matchday ${currentRound['name']}',
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(
                    disabledColor: Colors.transparent,
                    onPressed: currentRoundIndex == rounds.length - 1
                        ? null
                        : () {
                            setState(() {
                              currentRoundIndex += 1;
                              currentRound = rounds[currentRoundIndex];
                              fixtures = currentRound['fixtures'];
                            });
                          },
                    icon: Icon(Icons.arrow_forward)),
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
              bool isCurrent = SportMonksUtils.checkIfGameIsCurrent(startTime);

              print(isCurrent);

              var currentTeam1 = (f['scores'] as List)
                  .where(
                    (element) =>
                        element['score']['participant'] == 'home' &&
                        element['description'] == 'CURRENT',
                  )
                  .firstOrNull;

              var currentTeam2 = (f['scores'] as List)
                  .where(
                    (element) =>
                        element['score']['participant'] == 'away' &&
                        element['description'] == 'CURRENT',
                  )
                  .firstOrNull;

              var scoresTeam1 =
                  currentTeam1 != null ? currentTeam1['score']['goals'] : 0;

              var scoresTeam2 =
                  currentTeam2 != null ? currentTeam2['score']['goals'] : 0;

              return Card(
                clipBehavior: Clip.hardEdge,
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchView(
                                  matchId: f['id'],
                                )));
                  },
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
                            color: Theme.of(context).colorScheme.onSecondary,
                            child: Text(
                              '$scoresTeam1:$scoresTeam2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isCurrent ? Colors.amberAccent : null),
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
