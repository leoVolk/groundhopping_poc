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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
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
                Icons.share,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            )),
          )
        ],
      ),
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
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
                    ProfileBadges(),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  ],
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
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
              ),
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
