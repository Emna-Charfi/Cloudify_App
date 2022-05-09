import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/util/api.dart';

import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

late String _id = "";

class GameUtils {
  static List<GameModels> _games = [];

  static late Future<bool> fetchedGames;
  static Future<bool> fetchGames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = (prefs.getString('ID') ?? '');
    print("id get id*****" + (prefs.getString('ID') ?? ''));
    //getId();
    print("id**1***" + _id.toString());
    //final response = await http.get(Uri.http(api_keyM, "/games"));
    final response =
        await http.get(Uri.http(api_keyM, "/listuserGames/" + _id.toString()));

    if (response.statusCode == 200) {
      print("**********Status 200***********");
      var jsonD = jsonDecode(response.body);
      //print("json**********" + jsonD);
      // if (jsonD != []) {
      //   List<dynamic> gamesFromServer =
      //     (jsonD as Map<String, dynamic>)['games'];

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
          //gamesFromServer[i]['images']['url'],

          gamesFromServer[i]['images'][0]['url'],
          gamesFromServer[i]["name"],
          gamesFromServer[i]['description'],
          gamesFromServer[i]['price'],
          gamesFromServer[i]['link'],
          //123.44,
        ));
        print("list of game*****" + gamesFromServer[i]['images'].toString());
        // gamesFromServer[i]['images'].forEach((prodId, prodData) {
        //   GameModels.images.add(prodData[i]['url']);
        // });
      }
      ;
      _games = loadedProducts;
      //} else {}

      //notifyListeners();
    } else if (response.statusCode == 402) {
      print("**********Status 402***********");
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return const AlertDialog(
      //       title: Text("Information"),
      //       content: Text("Email already exists"),
      //     );
      //   },
      // );
    } else {
      print("**********there are problem***********");
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return const AlertDialog(
      //       title: Text("Information"),
      //       content: Text("There's a problem"),
      //     );
      //   },
      // );
    }

    return true;
    // return fetchedGames;
  }

  // @override
  // void initState() {
  //   fetchedGames = fetchGames();

  //   //super.initState();
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

  static getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = (prefs.getString('ID') ?? '');
    print("id get id*****" + (prefs.getString('ID') ?? ''));
  }
}
