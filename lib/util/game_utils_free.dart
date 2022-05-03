import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/util/api.dart';

import 'dart:convert';

import "package:http/http.dart" as http;

class GameUtilsFree {
  static List<GameModels> _games = [];

  static late Future<bool> fetchedGames;
  static Future<bool> fetchGames() async {
    //final response = await http.get(Uri.http(api_keyM, "/games"));
    final response = await http.get(Uri.http(api_keyM, "games/freegames"));

    if (response.statusCode == 200) {
      //  print("**********Status 200***********");
      var jsonD = jsonDecode(response.body);

      // if (jsonD != []) {
      List<dynamic> gamesFromServer = jsonD;
      // final extractedData =
      //     json.decode(response.body) as Map<String, dynamic>;
      // if (extractedData == null) {
      //   return;
      // }
      final List<GameModels> loadedProducts = [];
      for (var i = 0; i < gamesFromServer.length; i++) {
        loadedProducts.add(GameModels(
          gamesFromServer[i]['_id'],
          gamesFromServer[i]['images'][0]['url'],

          //"assets/images/Cyberpunk2077.jpg",
          gamesFromServer[i]["name"],
          gamesFromServer[i]['description'],
          gamesFromServer[i]['price'],
          //123.44,
        ));
        print("list of game*****" +
            gamesFromServer[i]['images'][0]['url'].toString());
        // gamesFromServer[i]['images'].forEach((prodId, prodData) {
        //   GameModels.images.add(prodData[i]['url']);
        // });
      }

      ;
      _games = loadedProducts;
      final List<String> listImg = [];
      for (var i = 0; i < _games.length; i++) {
        for (var j = 0; j < gamesFromServer.length; j++) {
          for (var k = 0; k < gamesFromServer[j]['images'].length; k++) {
            listImg.add(gamesFromServer[i]['images'][k]['url'].toString());
            print("Game" +
                k.toString() +
                gamesFromServer[i]['images'][k]['url'].toString());
          }
        }
        _games[i].setImages(listImg);
      }
      //} else {}
      // fetchImageGames();

      //notifyListeners();
    } else if (response.statusCode == 402) {
      print("**********Status 402***********");
    } else {
      print("**********there are problem***********");
    }

    return true;
    // return fetchedGames;
  }

  // static Future<bool> fetchImageGames() async {
  //   //final response = await http.get(Uri.http(api_keyM, "/games"));

  //   if (_games.length != 0) {
  //     for (var i = 1; i <= _games.length; i++) {
  //       final response = await http
  //           .get(Uri.http(api_keyM, "games/listGameImages/" + _games[i].id));

  //       if (response.statusCode == 200) {
  //         print("**********Status 200***********");
  //         //var jsonD = jsonDecode(response.body);

  //         // if (jsonD != []) {
  //         //List<dynamic> gamesFromServer = jsonD;
  //         final extractedData =
  //             json.decode(response.body) as Map<String, dynamic>;

  //         // final List<GameModels> loadedProducts = [];
  //         for (var j = 0; j < extractedData.length; j++) {
  //           _games[i].setImages(extractedData[j.toString()].toString());

  //           // print(extractedData.length);
  //           // print(
  //           //     "list of gamesss*****" + extractedData[j.toString()].toString());

  //           // gamesFromServer[i]['images'].forEach((prodId, prodData) {
  //           //   GameModels.images.add(prodData[i]['url']);
  //           // });
  //         }
  //         ;
  //         print("list of gamesss*****" + _games[i].image.toString());

  //         //} else {}

  //         //notifyListeners();
  //       } else if (response.statusCode == 402) {
  //         print("**********Status 402***********");
  //       } else {
  //         print("**********there are problem***********");
  //       }
  //     }
  //   }

  //   return true;
  //   // return fetchedGames;
  // }

  static List<GameModels> getMockedGames() {
    fetchedGames = fetchGames();
    // return [
    //   GameModels(
    //       "1",
    //       "assets/images/Cyberpunk2077.jpg",
    //       "Cyberpunk2077",
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    //           "sed do eiusmod tempor incididunt ut ",
    //       500),
    //   GameModels(
    //       "2",
    //       "assets/images/Dying_Light_2.jpg",
    //       "Dying Light 2",
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    //           "sed do eiusmod tempor incididunt ut ",
    //       300),
    //   GameModels(
    //       "3",
    //       "assets/images/Spellbreak.jpg",
    //       "Spellbreak",
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    //           "sed do eiusmod tempor incididunt ut ",
    //       200),
    //   GameModels(
    //       "4",
    //       "assets/images/Horizon_Forbidden_West.jpg",
    //       "Horizon Forbidden West",
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    //           "sed do eiusmod tempor incididunt ut ",
    //       100),
    //   GameModels(
    //       "5",
    //       "assets/images/fifa-world.jpg",
    //       "FiFa World",
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
    //           "sed do eiusmod tempor incididunt ut ",
    //       600),
    // ];
    return _games;
  }
}
