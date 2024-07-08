import 'package:flutter/material.dart';
import 'package:learning_flutter/views/settings_view.dart';
import 'package:learning_flutter/widgets/feed/feedcart.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key, required this.title});

  final String title;

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  int _selectedIndex = -1;

  var _destinations = [SettingsView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          title: Text(widget.title),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.account_circle))
          ],
        ),
        drawer: NavigationDrawer(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => _destinations[value])),
          children: [
            NavigationDrawerDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
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
