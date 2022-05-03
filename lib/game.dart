import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/pages/selectedgamepage.dart';
import 'package:cloudify_application/providers/list_games.dart';
import 'package:cloudify_application/util/game_utils.dart';
import 'package:cloudify_application/widgets/gamecard.dart';
import 'package:cloudify_application/widgets/gameplaycard.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<GamesList>(context, listen: false).getfetchedGames();
  }

  @override
  Widget build(BuildContext context) {
    //final games = Provider.of<GamesList>(context, listen: false);
    //CategorySelectionService catSelection = Provider.of<CategorySelectionService>(context, listen: false);
    //CategoryService catService = Provider.of<CategoryService>(context, listen: false);
    List<GameModels> games = GameUtils.getMockedGames();
    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: games.length,
          itemBuilder: (_, i) => Column(
            children: [
              GamePlayCard(
                  game: games[i],
                  onCardClick: () {
                    // print("this game here" + games[i].toString());
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => selectedGamepage(
                    //               index: games[i],
                    //             )));

                    // _launchURL();
                  }),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  // void _launchURL() async {
  //   const _url = 'https://flutter.io';
  //   if (!await launch(_url)) throw 'Could not launch $_url';
  // }
}
