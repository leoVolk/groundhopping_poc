import 'package:flutter/material.dart';
import 'package:groundhopper/views/match_view.dart';

class FeedCardWidget extends StatelessWidget {
  const FeedCardWidget({super.key, required this.matchId});

  final String matchId;

  @override
  Widget build(BuildContext context) {
    navigateToMatch() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MatchView(
                    matchId: matchId,
                  )));
    }

    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    navigateToMatch();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          "https://vfl-magazin.de/wp-content/uploads/2023/05/220424_MN_01847-768x511.jpg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 24,
                                    child: Text(
                                      'PR',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Peter Neururer',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        'Vonovia Ruhrstadion, 21.01.2024',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  navigateToMatch();
                                },
                                icon: Icon(Icons.arrow_forward))
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
