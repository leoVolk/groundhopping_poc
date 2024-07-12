import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

//TODO: FIND WAY TO REALIZE DESIGN
class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
/*         appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
                child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            )),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                  child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                  child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
              )),
            )
          ],
        ), */
/*       body: Column(
        children: [
          SizedBox(
            height: 356,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Image.network(
                    'https://pbs.twimg.com/profile_banners/605734189/1708339393/1500x500',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: CircleAvatar(
                                  radius: 64,
                                  child: Text('PR'),
                                ))
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                  10,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilledButton(
                          style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 12),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer)),
                          onPressed: () => {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.flag,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4)),
                              Text(
                                'Badge Name',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer),
                              )
                            ],
                          ),
                        ),
                      )),
            ),
          ),
        ],
      ), */
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.list), Text('Overview')],
                        ),
                      ),
                      Tab(
                        text: 'History',
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView(
                children: List.generate(
                    200,
                    (index) => Card(
                          child: Text('FOOBAR$index'),
                        )),
              ),
              ListView(
                children: List.generate(
                    200,
                    (index) => Card(
                          child: Text('FOOBAR$index'),
                        )),
              )
            ],
          )),
    );
  }
}
