import 'package:flutter/material.dart';
import 'package:groundhopper/widgets/feed/feedcart.dart';
import 'package:groundhopper/widgets/main_drawer.dart';

class FeedView extends StatefulWidget {
  const FeedView({
    super.key,
  });

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          title: Text('Feed'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
        ),
        drawer: MainDrawerWidget(),
        body: ListView(
          children: List.generate(
              24,
              (index) => Hero(
                    tag: 'img_$index',
                    child: FeedCardWidget(matchId: index),
                  )),
        ));
  }
}
