import 'package:flutter/material.dart';
import 'package:groundhopper/main.dart';
import 'package:groundhopper/views/chat_view.dart';

class MessagePreviewWidget extends StatelessWidget {
  const MessagePreviewWidget(
      {super.key, required this.isUnread, required this.chatId});

  final bool isUnread;
  final int chatId;

  @override
  Widget build(BuildContext context) {
    navigateToChat() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ChatView(
                    chatId: 1234,
                  )));
    }

    return InkWell(
        child: InkWell(
      onLongPress: () => context.showSnackBar(chatId.toString()),
      onTap: () => navigateToChat(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text('A'),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            softWrap: false,
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,')
                      ],
                    ),
                  ),
                ),
                Text('19.01')
              ],
            ),
          ),
          Divider()
        ],
      ),
    ));
  }
}
