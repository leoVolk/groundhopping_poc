import 'package:flutter/material.dart';
import 'package:groundhopper/main.dart';
import 'package:groundhopper/views/mymatches_view.dart';
import 'package:groundhopper/views/profile_view.dart';
import 'package:groundhopper/views/settings_view.dart';
import 'package:groundhopper/views/subscription_view.dart';

class MainDrawerWidget extends StatefulWidget {
  const MainDrawerWidget({super.key});

  @override
  State<MainDrawerWidget> createState() => _MainDrawerWidgetState();
}

class _MainDrawerWidgetState extends State<MainDrawerWidget> {
  int _selectedIndex = -1;

  var _destinations = [
    ProfileView(),
    MyMatchesView(),
    SubscriptionView(),
    SettingsView()
  ];
  late bool darkTheme = true;

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  void getTheme() async {
    bool d = await App.of(context).getTheme() == ThemeMode.dark;

    setState(() {
      darkTheme = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (value) => Navigator.push(context,
          MaterialPageRoute(builder: (context) => _destinations[value])),
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    child: Text('PR'),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Text(
                            'Peter Neururer',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.workspace_premium_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(),
        ),
        NavigationDrawerDestination(
          icon: Icon(
            Icons.person_outline_rounded,
          ),
          label: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(
            Icons.sports_soccer_outlined,
          ),
          label: Text(
            'My Matches',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(
            Icons.workspace_premium_outlined,
          ),
          label: Text(
            'Subscription',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(
            Icons.settings_outlined,
          ),
          label: Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Theme (pre.)'),
                value: darkTheme,
                onChanged: (bool value) {
                  setState(() {
                    darkTheme = value;
                  });

                  App.of(context)
                      .changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                },
                secondary:
                    Icon(darkTheme ? Icons.dark_mode : Icons.wb_sunny_outlined),
              )
            ],
          ),
        )
      ],
    );
  }
}
