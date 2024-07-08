import 'package:flutter/material.dart';
import 'package:learning_flutter/views/explore_view.dart';
import 'package:learning_flutter/views/feed_view.dart';
import 'package:learning_flutter/views/messages_view.dart';
import 'package:learning_flutter/views/search_view.dart';

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
              seedColor: Colors.blue, brightness: Brightness.light),
          typography: Typography.material2021()),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.dark),
          typography: Typography.material2021()),
      themeMode: ThemeMode.dark,
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
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        FeedView(title: 'Feed'),
        ExploreView(),
        SearchView(),
        MessagesView()
      ][_currentPageIndex],
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
          _currentPageIndex = index;
        }),
        selectedIndex: _currentPageIndex,
      ),
    );
  }
}
