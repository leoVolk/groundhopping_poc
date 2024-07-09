import 'package:flutter/material.dart';
import 'package:learning_flutter/widgets/messages/messagepreview.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Text('Messages'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: ListView(
        children: List.generate(
            24,
            (index) => MessagePreviewWidget(
                  isUnread: false,
                  chatId: 123456,
                )),
      ),
    );
  }
}
