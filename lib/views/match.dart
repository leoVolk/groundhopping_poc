import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/match/matchheader.dart';
import 'package:learning_flutter/widgets/match/matchoverview.dart';

class MatchView extends StatelessWidget {
  const MatchView({super.key, required this.matchId});

  final String matchId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MatchHeader(
                matchId: matchId,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            return Theme.of(context)
                                .colorScheme
                                .secondaryContainer;
                            // Use the component's default.
                          },
                        ),
                      ),
                      child: Text(
                        '3 - 2',
                        style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      onPressed: () {
                        // ...
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Vonovia Ruhrstadion',
                      style: TextStyle(
                          fontSize: 24,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  )
                ],
              ),
              MatchOverview()
            ],
          ),
        ));
  }
}
