import 'package:flutter/material.dart';

class MainNavigationWidget extends StatefulWidget {
  const MainNavigationWidget({super.key});

  @override
  State<MainNavigationWidget> createState() => _MainNavigationWidgetState();
}

class _MainNavigationWidgetState extends State<MainNavigationWidget> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
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
    );
  }
}
