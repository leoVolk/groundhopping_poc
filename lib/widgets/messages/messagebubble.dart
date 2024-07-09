import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    Random r = Random();
    bool isIncoming = r.nextDouble() <= 0.7;

    return Padding(
      padding:
          isIncoming ? EdgeInsets.only(right: 48) : EdgeInsets.only(left: 48),
      child: Column(
        crossAxisAlignment:
            isIncoming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Padding(
              padding: EdgeInsets.all(8),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: isIncoming
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.inversePrimary,
                    child: Column(
                      children: [
                        Text(
                          content,
                          style: TextStyle(
                              color: isIncoming
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
