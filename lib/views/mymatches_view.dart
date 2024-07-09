import 'package:flutter/material.dart';

class MyMatchesView extends StatelessWidget {
  const MyMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Matches'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate(
                  List.generate(200, (index) => Text(index.toString()))))
        ],
      ),
    );
  }
}
