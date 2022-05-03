import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/pages/selectedgamepage.dart';
import 'package:cloudify_application/util/game_utils.dart';
import 'package:cloudify_application/util/game_utils_paid.dart';
import 'package:cloudify_application/widgets/gamecard.dart';
import 'package:flutter/material.dart';

class PaidGame extends StatelessWidget {
  const PaidGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GameModels> games = GameUtilsPaid.getMockedGames();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text('Our New Game:',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: games.length,
          itemBuilder: (BuildContext ctx, int index) {
            return GameCard(
                game: games[index],
                onCardClick: () {
                  // catSelection.selectedCategory = categories[index];
                  // Utils.mainAppNav.currentState!
                  //     .pushNamed('/selectedcategorypage');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              selectedGamepage(index: games[index])));
                });
          },
        ),
      )
    ]);
  }
}
