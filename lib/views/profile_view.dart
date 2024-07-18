import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/profile/profile_badges.dart';
import 'package:learning_flutter/widgets/profile/tabs/profile_comments.dart';
import 'package:learning_flutter/widgets/profile/tabs/profile_history.dart';
import 'package:learning_flutter/widgets/profile/tabs/profile_overview.dart';
import 'package:learning_flutter/widgets/profile/tabs/profile_photos.dart';
import 'package:learning_flutter/widgets/profile/tabs/profile_videos.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 5,
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

  //TODO: FIND GOOD ICON/TEXT SOLUTION
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
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
                  title: _scrollPos > 356 ? Text('User Name') : null,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                  pinned: true,
                  expandedHeight: 356,
                  actions: [],
                  flexibleSpace: ClipRect(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://pbs.twimg.com/profile_banners/605734189/1708339393/1500x500'),
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
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ProfileBadges(),
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
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.language),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8)),
                            Text('Overview')
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.show_chart),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8)),
                            Text('History')
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.list),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8)),
                            Text('Comments')
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.photo_camera_outlined),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8)),
                            Text('Photos')
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.video_camera_front_outlined),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8)),
                            Text('Videos')
                          ],
                        ),
                      ),
                    ]),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              ProfileOverview(),
              ProfileHistory(),
              ProfileComments(),
              ProfilePhotos(),
              ProfileVideos(),
            ],
          )),
    );
  }
}
