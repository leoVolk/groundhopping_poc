import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:groundhopper/views/explore_view.dart';
import 'package:groundhopper/views/feed_view.dart';
import 'package:groundhopper/views/messages_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:groundhopper/views/search_view.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  // ignore: library_private_types_in_public_api
  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}

class _AppState extends State<App> {
  final storage = FlutterSecureStorage();
  ThemeMode _themeMode = ThemeMode.light;

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
              icon: Icon(Icons.sports_soccer),
              selectedIcon: Icon(Icons.sports_soccer),
              label: 'Leagues'),
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
