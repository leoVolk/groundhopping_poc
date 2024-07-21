import 'package:flutter/material.dart';
import 'package:groundhopper/services/sportmonks.service.dart';

class SeasonsList extends StatefulWidget {
  const SeasonsList({super.key, this.season, required this.league});

  final dynamic season;
  final dynamic league;

  @override
  State<SeasonsList> createState() => _SeasonsListState();
}

class _SeasonsListState extends State<SeasonsList>
    with TickerProviderStateMixin {
  final sportMonksService = SportmonkService();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleRefresh() async {
    // getSeasonStandings(widget.season['id']);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Seasons',
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt))
              ],
            ),
          ),
          Divider(),
          Column(
            children: List.generate(widget.league['seasons'].length, (index) {
              var season = widget.league['seasons'][index];

              return InkWell(
                onTap: () {},
                child: Container(
                  color: index.isEven
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [Text(season['name'])],
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
