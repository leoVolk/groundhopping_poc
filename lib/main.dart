import 'package:flutter/material.dart';
import 'package:learning_flutter/views/explore_view.dart';
import 'package:learning_flutter/views/feed_view.dart';
import 'package:learning_flutter/views/messages_view.dart';
import 'package:learning_flutter/views/search_view.dart';
import 'package:learning_flutter/views/settings_view.dart';
import 'package:learning_flutter/widgets/main_navigation.dart';

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
      home: const RouterOutlet(title: 'Flutter Demo Home Page'),
    );
  }
}

class RouterOutlet extends StatefulWidget {
  const RouterOutlet({super.key, required this.title});

  final String title;

  @override
  State<RouterOutlet> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RouterOutlet> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        FeedView(title: 'Feed'),
        ExploreView(),
        SearchView(),
        MessagesView(),
        SettingsView()
      ][_currentPageIndex],
      bottomNavigationBar: MainNavigationWidget(),
    );
  }
}
