import 'package:flutter/material.dart';

class MyMatchesView extends StatelessWidget {
  const MyMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Matches'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(),
    );
  }
}
