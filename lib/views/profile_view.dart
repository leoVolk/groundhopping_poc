import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
                child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            )),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 356,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    Image.network(
                      'https://pbs.twimg.com/profile_banners/605734189/1708339393/1500x500',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                                      child: CircleAvatar(
                                    radius: 64,
                                    child: Text('PR'),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                    10,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilledButton(
                            onPressed: () => {},
                            child: Row(
                              children: [Icon(Icons.flag), Text('Badge Name')],
                            ),
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
