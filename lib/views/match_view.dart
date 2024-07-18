import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/match/matchticker.dart';

class MatchView extends StatefulWidget {
  const MatchView({super.key, required this.matchId});

  final String matchId;

  @override
  State<MatchView> createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  late final ScrollController _scrollController = ScrollController();

  double _scrollPos = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
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
                                        Text(
                                            'Vfl Bochum vs. \nFC Bayern Munich',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 32,
                                                color: Colors.white)),
                                        Padding(padding: EdgeInsets.all(4)),
                                        Text(
                                          'Vonovia Ruhrstadion, 15:30pm, 21.01.2024',
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
                              image: NetworkImage(
                                  'https://vfl-magazin.de/wp-content/uploads/2023/05/220424_MN_01847-768x511.jpg'),
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
                            '3 - 2',
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
                        'Vonovia Ruhrstadion',
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
