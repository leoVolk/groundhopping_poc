import 'package:flutter/material.dart';
import 'package:groundhopper/widgets/match/matchticker.dart';

enum Tab { ticker, info, statistics }

class MatchOverview extends StatefulWidget {
  const MatchOverview({super.key});

  @override
  State<MatchOverview> createState() => MatchOverviewState();
}

class MatchOverviewState extends State<MatchOverview> {
  Tab currentTab = Tab.ticker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SegmentedButton(
                segments: [
                  ButtonSegment<Tab>(value: Tab.ticker, label: Text('Ticker')),
                  ButtonSegment<Tab>(value: Tab.info, label: Text('Info')),
                  ButtonSegment<Tab>(
                      value: Tab.statistics, label: Text('Statistics'))
                ],
                selected: <Tab>{
                  currentTab
                },
                onSelectionChanged: (newSelection) {
                  setState(() {
                    currentTab = newSelection.first;
                  });
                }),
          ),
          Container(
            child: Builder(
              builder: (context) {
                if (currentTab == Tab.info) {
                  return Text('Match Info here');
                } else if (currentTab == Tab.statistics) {
                  return Text('Statistsics here');
                } else {
                  return MatchTicker();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
