import 'package:flutter/material.dart';
import 'package:learning_flutter/views/explore.dart';
import 'package:learning_flutter/views/feed.dart';
import 'package:learning_flutter/views/messages.dart';
import 'package:learning_flutter/views/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.light),
          useMaterial3: true,
          typography: Typography.material2021()),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        FeedView(title: 'Feed'),
        ExploreView(),
        SearchView(),
        MessagesView()
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.language_outlined),
              selectedIcon: Icon(Icons.language),
              label: 'Feed'),
          NavigationDestination(
              icon: Icon(Icons.location_on_outlined),
              selectedIcon: Icon(Icons.location_on),
              label: 'Explore'),
          NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search),
              label: 'Search'),
          NavigationDestination(
              icon: Badge(
                label: Text("2"),
                child: Icon(Icons.mail_outline),
              ),
              selectedIcon: Icon(Icons.mail),
              label: 'Messages'),
        ],
        onDestinationSelected: (int index) => setState(() {
          currentPageIndex = index;
        }),
        selectedIndex: currentPageIndex,
      ),
    );
  }
}
