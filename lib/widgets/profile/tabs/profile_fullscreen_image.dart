import 'package:flutter/material.dart';

class ProfileFullscreenImage extends StatelessWidget {
  const ProfileFullscreenImage(
      {super.key, required this.imgLink, required this.tag});

  final String imgLink;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          title: Text(tag),
          actions: [
            IconButton(
                onPressed: () => {/*TODO: download */},
                icon: Icon(Icons.download))
          ],
        ),
        body: Stack(
          children: [
            GestureDetector(
              child: Center(
                child: Hero(
                  tag: 'image$tag',
                  child: Image.network(
                    imgLink,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
