import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learning_flutter/views/explore_view.dart';
import 'package:learning_flutter/views/feed_view.dart';
import 'package:learning_flutter/views/messages_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:learning_flutter/views/search_view.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;
}

class _AppState extends State<App> {
  final storage = FlutterSecureStorage();
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    // setTheme();
    setThemeOnStartUp();
  }

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
      themeMode: _themeMode,
      home: const RouterOutlet(),
    );
  }

  ///sets theme on startup
  void setThemeOnStartUp() async {
    String? value = await storage.read(key: 'darkTheme');

    if (value == null) {
      await storage.write(
          key: 'darkTheme', value: (_themeMode == ThemeMode.dark).toString());
    } else {
      changeTheme(bool.parse(value) ? ThemeMode.dark : ThemeMode.light);
    }

    FlutterNativeSplash.remove();
  }

  void changeTheme(ThemeMode mode) async {
    setState(() {
      _themeMode = mode;
    });

    await storage.write(
        key: 'darkTheme', value: (mode == ThemeMode.dark).toString());
  }

  Future<ThemeMode> getTheme() async {
    String? value = await storage.read(key: 'darkTheme');

    if (value == null) {
      return ThemeMode.dark;
    } else {
      return bool.parse(value) ? ThemeMode.dark : ThemeMode.light;
    }
  }
}

class RouterOutlet extends StatefulWidget {
  const RouterOutlet({super.key});

  @override
  State<RouterOutlet> createState() => _RouterOutletState();
}

class _RouterOutletState extends State<RouterOutlet> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        FeedView(),
        ExploreView(),
        SearchView(),
        MessagesView(),
      ][_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
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
