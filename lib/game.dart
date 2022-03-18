import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/pages/selectedgamepage.dart';
import 'package:cloudify_application/util/game_utils.dart';
import 'package:cloudify_application/widgets/gamecard.dart';
import 'package:cloudify_application/widgets/gameplaycard.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    //CategorySelectionService catSelection = Provider.of<CategorySelectionService>(context, listen: false);
    //CategoryService catService = Provider.of<CategoryService>(context, listen: false);
    List<GameModels> games = GameUtils.getMockedGames();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text('Your Games:',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: games.length,
          itemBuilder: (BuildContext ctx, int index) {
            return GamePlayCard(
                game: games[index],
                onCardClick: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => selectedGamepage(
                  //               index: index,
                  //             )));
                });
          },
        ),
      )
    ]);
  }
}
