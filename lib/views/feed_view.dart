import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/feed/feedcart.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: Text(title),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.account_circle))
          ],
        ),
        body: ListView(
          children: List.generate(
              24,
              (index) => Hero(
                    tag: 'img_$index',
                    child: FeedCardWidget(matchId: 'match_$index'),
                  )),
        ));
  }
}
