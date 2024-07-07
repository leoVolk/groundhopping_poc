import 'package:flutter/material.dart';

class MatchTicker extends StatelessWidget {
  const MatchTicker({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    return SafeArea(
        top: false,
        child: Column(
          children: List.generate(
              24,
              (index) => Column(
                    children: [
                      Container(
                          color: index == 0 ? scheme.error : scheme.surface,
                          child: Row(
                            children: [
                              Flexible(
                                  child: SizedBox(
                                      child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(16, 12, 16, 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '45+2`',
                                          style: TextStyle(
                                              color: index == 0
                                                  ? scheme.onError
                                                  : scheme.onSurface,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
                                          style: TextStyle(
                                              color: index == 0
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
                      if (index < 23)
                        Divider(
                          height: 0,
                        )
                    ],
                  )),
        ));
  }
}
