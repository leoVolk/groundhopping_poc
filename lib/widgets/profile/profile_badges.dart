import 'package:flutter/material.dart';

class ProfileBadges extends StatelessWidget {
  const ProfileBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.secondaryContainer)),
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.military_tech,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                        Text(
                          'Badge',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        )
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
