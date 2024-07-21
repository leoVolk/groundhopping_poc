import 'package:flutter/material.dart';
import 'package:groundhopper/widgets/league/domestic_fixtures.dart';
import 'package:groundhopper/widgets/league/domestic_standings.dart';
import 'package:groundhopper/widgets/league/seasons_list.dart';

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

  dynamic leagueSubType;

  @override
  void initState() {
    super.initState();
    leagueSubType = widget.league['sub_type'];
  }

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
            //TODO: make play offs etc. functional
            if (leagueSubType == 'domestic') ...[
              DomesticStandings(season: widget.season),
              DomesticFixtures(season: widget.season),
            ],
            if (leagueSubType == 'domestic_cup') ...[
              Text('FOOBAR'),
              Text('FOOBAR'),
            ],
            if (leagueSubType == 'cup_international') ...[
              Text('FOOBAR'),
              Text('FOOBAR'),
            ],
            if (leagueSubType == 'friendly') ...[
              Text('FOOBAR'),
              Text('FOOBAR'),
            ],
            if (leagueSubType == 'play-offs') ...[
              Text('FOOBAR'),
              Text('FOOBAR'),
            ],
            SeasonsList(
              league: widget.league,
            )
          ],
        ));
  }
}
