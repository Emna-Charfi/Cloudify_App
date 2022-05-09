import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/pages/selectedgamepage.dart';
import 'package:cloudify_application/pages/selectedgamepanier.dart';
import 'package:cloudify_application/util/game_utils.dart';
import 'package:cloudify_application/util/game_utils_free.dart';
import 'package:cloudify_application/widgets/gamecardFree.dart';
import 'package:flutter/material.dart';

class FreeGame extends StatelessWidget {
  const FreeGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GameModels> games = GameUtilsFree.getMockedGames();

    return Scaffold(
      backgroundColor: const Color(0xFF232D3B),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text('Your Free Game:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (BuildContext ctx, int index) {
              return FreeGameCard(
                  game: games[index],
                  onCardClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                selectedGamePanier(index: index)));

                    //Play Now
                  });
            },
          ),
        )
      ]),
    );
  }
}
