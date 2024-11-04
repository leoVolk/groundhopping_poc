import 'package:flutter/material.dart';

class MatchTicker extends StatelessWidget {
  const MatchTicker({super.key, required this.comments});

  final dynamic comments;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    return comments == null || comments.length == 0
        ? Center(
            child: Text('No Comments available'),
          )
        : SafeArea(
            top: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: List.generate(comments.length, (index) {
                var c = comments[index];

                return Column(
                  children: [
                    Container(
                        color:
                            c['is_important'] ? scheme.error : scheme.surface,
                        child: Row(
                          children: [
                            Flexible(
                                child: SizedBox(
                                    child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${c['minute']}`${c['extra_minute'] ?? ''}',
                                        style: TextStyle(
                                            color: c['is_important'] ||
                                                    c['is_goal']
                                                ? scheme.onError
                                                : scheme.onSurface,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        c['comment'].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: c['is_important'] ||
                                                    c['is_goal']
                                                ? scheme.onError
                                                : scheme.onSurface),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))),
                          ],
                        )),
                    if (index < comments.length - 1)
                      Divider(
                        height: 0,
                      )
                  ],
                );
              }),
            ),
          );
  }
}
