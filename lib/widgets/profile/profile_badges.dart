import 'package:flutter/material.dart';
import 'package:learning_flutter/main.dart';

class Badge {
  String name = '';
  String description = '';
  int? id;
}

class ProfileBadges extends StatelessWidget {
  const ProfileBadges({super.key});

  @override
  Widget build(BuildContext context) {
    var badges = [
      {"name": "First Step", "description": "For visiting your first ground."},
      {
        "name": "Local Legend",
        "description": "For visiting all the stadiums in your local area."
      },
      {
        "name": "Away Day Warrior",
        "description": "For attending 5 away matches."
      },
      {
        "name": "Home Comforts",
        "description": "For visiting the same ground multiple times."
      },
      {
        "name": "Regional Rumbler",
        "description": "For visiting 10 different grounds in a specific region."
      },
      {
        "name": "National Nomad",
        "description":
            "For visiting grounds in every state/region in your country."
      },
      {
        "name": "Continental Cruiser",
        "description": "For visiting grounds on multiple continents."
      },
      {
        "name": "Global Groundhopper",
        "description": "For visiting grounds in 10 different countries."
      },
      {
        "name": "Historical Hunter",
        "description":
            "For visiting grounds with a significant history or heritage."
      },
      {
        "name": "Cup Conqueror",
        "description": "For attending a cup final match."
      },
      {
        "name": "Derby Dynamo",
        "description": "For attending a local derby match."
      },
      {
        "name": "Stadium Sleuth",
        "description": "For visiting lesser-known or smaller stadiums."
      },
      {
        "name": "Match Marathoner",
        "description": "For attending matches on consecutive days."
      },
      {
        "name": "Top Tier Traveler",
        "description":
            "For visiting grounds in the top division of your country."
      },
      {
        "name": "Underdog Enthusiast",
        "description": "For visiting lower league or non-league grounds."
      },
      {"name": "Night Owl", "description": "For attending a night match."},
      {
        "name": "Weekend Wanderer",
        "description": "For attending matches on weekends."
      },
      {
        "name": "Seasoned Supporter",
        "description":
            "For visiting a ground at least once every season for 5 years."
      },
      {
        "name": "Milestone Match",
        "description":
            "For attending a significant milestone match, such as the 100th ground visited."
      },
      {
        "name": "All-Star Access",
        "description":
            "For visiting a ground that has hosted a major international tournament."
      },
      {
        "name": "Rivalry Rusher",
        "description":
            "For attending matches of rival teams in their respective grounds."
      },
      {
        "name": "Skyline Seeker",
        "description": "For visiting grounds with iconic skyline views."
      },
      {
        "name": "Seaside Supporter",
        "description": "For visiting grounds located near the coast."
      },
      {
        "name": "Mountain Matcher",
        "description": "For visiting grounds located in mountainous regions."
      },
      {
        "name": "Urban Explorer",
        "description": "For visiting grounds in major metropolitan areas."
      },
      {
        "name": "Countryside Crawler",
        "description": "For visiting rural or countryside stadiums."
      },
      {
        "name": "VIP Viewer",
        "description": "For attending matches with VIP or special access."
      },
      {
        "name": "Family Fixture",
        "description": "For attending matches with family or friends."
      },
      {"name": "Solo Hopper", "description": "For attending matches alone."},
      {
        "name": "Cultural Connoisseur",
        "description":
            "For visiting grounds with unique cultural or architectural significance."
      }
    ];

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(
            badges.length,
            (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ActionChip(
                  label: Text(badges[index].values.first),
                  avatar: Icon(
                    Icons.military_tech_outlined,
                    color: Colors.amber,
                  ),
                  onPressed: () =>
                      {context.showSnackBar(badges[index].values.last)},
                ))),
      ),
    );
  }
}
