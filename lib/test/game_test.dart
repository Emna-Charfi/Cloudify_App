import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/pages/selectedgamepage.dart';
import 'package:cloudify_application/util/game_utils.dart';
import 'package:cloudify_application/widgets/gamecard.dart';
import 'package:cloudify_application/widgets/gameplaycard.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import "package:http/http.dart" as http;

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final List<GameModels> _games = [];
  late Future<bool> fetchedGames = fetchGames();

  final String _baseUrl = "http://10.0.2.2:3000";

  Future<bool> fetchGames() async {
    http.Response response = await http.get(Uri.parse(_baseUrl + "/games"));
    if (response.statusCode == 200) {
      List<dynamic> gamesFromServer = json.decode(response.body);
      for (var i = 0; i < gamesFromServer.length; i++) {
        _games.add(GameModels(
            gamesFromServer[i]["id"],
            gamesFromServer[i]["title"],
            gamesFromServer[i]["image"],
            gamesFromServer[i]["description"],
            int.parse(gamesFromServer[i]["price"].toString())));
        return true;
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Information"),
              content: Text("Une erreur s'est produite. Veuillez réessayer !"),
            );
          });
    }

    return true;
    //return fetchedGames;
  }

  @override
  void initState() {
    fetchedGames = fetchGames();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //CategorySelectionService catSelection = Provider.of<CategorySelectionService>(context, listen: false);
    //CategoryService catService = Provider.of<CategoryService>(context, listen: false);

    // List<GameModels> games = GameUtils.getMockedGames();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text('Your Games:',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
      ),
      Expanded(
        child: FutureBuilder(
            future: fetchedGames,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: _games.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GamePlayCard(
                        game: _games[index],
                        onCardClick: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => selectedGamepage(
                          //               index: index,
                          //             )));
                        });
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      )
    ]);
  }
}
