import 'package:flutter/material.dart';

class MatchHeader extends StatelessWidget {
  const MatchHeader({super.key, required this.matchId});

  final String matchId;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 356,
        child: Stack(
          children: [
            Hero(
              tag: matchId,
              child: Image.network(
                "https://vfl-magazin.de/wp-content/uploads/2023/05/220424_MN_01847-768x511.jpg",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black87,
                  ],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vfl Bochum vs. \nFC Bayern Munich',
                                  style: TextStyle(
                                    color: isDarkTheme
                                        ? scheme.onPrimaryContainer
                                        : scheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(4)),
                                Text(
                                  'Vonovia Ruhrstadion, 15:30pm, 21.01.2024',
                                  style: TextStyle(
                                    color: isDarkTheme
                                        ? scheme.onPrimaryContainer
                                        : scheme.onPrimary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(4)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RawChip(
                                      onPressed: () {},
                                      label: Text('Add to my matches'),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer,
                                      avatar: Icon(Icons.date_range),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    CircleAvatar(
                                      child: Icon(Icons.people_alt_outlined),
                                    )
                                  ],
                                ),
                                Padding(padding: EdgeInsets.all(4)),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
