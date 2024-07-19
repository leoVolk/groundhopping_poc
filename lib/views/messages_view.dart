import 'package:flutter/material.dart';
import 'package:groundhopper/widgets/main_drawer.dart';
import 'package:groundhopper/widgets/messages/messagepreview.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text('Messages'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      drawer: MainDrawerWidget(),
      body: ListView(
        children: List.generate(
            24,
            (index) => MessagePreviewWidget(
                  isUnread: false,
                  chatId: 123456 + index,
                )),
      ),
    );
  }
}
