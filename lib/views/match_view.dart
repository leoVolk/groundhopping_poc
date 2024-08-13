import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groundhopper/services/sportmonks.service.dart';
import 'package:groundhopper/widgets/match/matchticker.dart';

class MatchView extends StatefulWidget {
  const MatchView({super.key, required this.matchId});

  final int matchId;

  @override
  State<MatchView> createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  late final ScrollController _scrollController = ScrollController();
  final sportMonksService = SportmonkService();

  double _scrollPos = 0;

  dynamic fixture;
  dynamic venue;
  dynamic scores;

  Future<void> getFixtureById(int id) async {
    var resp = await sportMonksService.getFixtureById(widget.matchId);

    setState(() {
      fixture = resp;
      venue = fixture['venue'];
      scores = fixture['scores'];
    });
  }

  _scrollListener() {
    setState(() {
      if (_scrollController.hasClients) {
        _scrollPos = _scrollController.position.pixels;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getFixtureById(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            var currentTeam1 = (scores as List)
                .where(
                  (element) =>
                      element['score']['participant'] == 'home' &&
                      element['description'] == 'CURRENT',
                )
                .firstOrNull;

            var currentTeam2 = (scores as List)
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

            return [
              SliverAppBar(
                  toolbarHeight: kToolbarHeight,
                  leading: IconButton(
                    icon: Icon(Icons.navigate_before),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(Colors.white),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.black26)),
                  ),
                  pinned: true,
                  collapsedHeight: 100,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(156),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black.withAlpha(0),
                            Colors.black87,
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${fixture?['name']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 32,
                                                color: Colors.white)),
                                        Padding(padding: EdgeInsets.all(4)),
                                        Text(
                                          '${venue?['name']},${fixture?['starting_at']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Padding(padding: EdgeInsets.all(4)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RawChip(
                                              onPressed: () {},
                                              label: Text('Add to my matches'),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceContainer,
                                              avatar: Icon(Icons.date_range),
                                              clipBehavior: Clip.hardEdge,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.people_alt_outlined),
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                  iconColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.white),
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.black26)),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.all(4)),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  expandedHeight: 356,
                  flexibleSpace: ClipRect(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(venue?['image_path'] ??
                                  'https://plus.unsplash.com/premium_photo-1664297688755-84ecc3f6a0f7?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                              fit: BoxFit.cover)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: (_scrollPos / 150).clamp(0, 5),
                            sigmaY: (_scrollPos / 150).clamp(0, 5)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    ),
                  )),
              SliverToBoxAdapter(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                return Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer;
                                // Use the component's default.
                              },
                            ),
                          ),
                          child: Text(
                            '$scoresTeam1:$scoresTeam2',
                            style: TextStyle(
                                fontSize: 32,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          ),
                          onPressed: () {
                            // ...
                          },
                        ))
                  ])),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '${venue?['name']}',
                        style: TextStyle(
                            fontSize: 24,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    )
                  ],
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Theme.of(context).colorScheme.surface,
                pinned: true,
                title: null,
                primary: false,
                flexibleSpace: TabBar(
                    controller: _tabController,
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.sports_soccer_outlined),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4)),
                            Text('Ticker')
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.show_chart),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4)),
                            Text('Statistics')
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.info_outline),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4)),
                            Text('Match Info')
                          ],
                        ),
                      ),
                    ]),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [MatchTicker(), MatchTicker(), MatchTicker()],
          )),
    );
  }
}
