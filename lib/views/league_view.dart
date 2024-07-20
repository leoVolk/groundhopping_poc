import 'package:flutter/material.dart';
import 'package:groundhopper/widgets/league/league_fixtures.dart';
import 'package:groundhopper/widgets/league/league_standings.dart';

class LeagueView extends StatefulWidget {
  const LeagueView({super.key, required this.season, this.league});

  final dynamic season;
  final dynamic league;

  @override
  State<LeagueView> createState() => _LeagueViewState();
}

class _LeagueViewState extends State<LeagueView> with TickerProviderStateMixin {
  late final TabController tabController = TabController(
    length: 3,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.league['name'] + ' ' + widget.season['name']),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: 'Standings',
              ),
              Tab(
                text: 'Fixtures',
              ),
              Tab(
                text: 'League History',
              )
            ],
          ),
        ),
        floatingActionButton: Text('${widget.season['id']}'),
        body: TabBarView(
          controller: tabController,
          children: [
            LeagueStandings(season: widget.season),
            LeagueFixtures(season: widget.season),
            Text('Foobar')
          ],
        ));
  }
}
