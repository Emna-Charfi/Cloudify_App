import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/util/api.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String _id = "";

class GamesList with ChangeNotifier {
  List<GameModels> _itemsList = [];
  late Future<bool> fetchedGames;

  List<GameModels> get itemsList {
    return [..._itemsList];
  }

  Future<bool> getfetchedGames() {
    fetchedGames = fetchAndSetProducts();
    return fetchedGames;
  }

  Future<bool> fetchAndSetProducts() async {
    //const url = '10.0.2.2:3000';
    getId();
    final response =
        await http.get(Uri.http(api_keyM, "/listuserGames/" + _id));
    if (response.statusCode == 200) {
      print("**********Status 200***********");
      var jsonD = jsonDecode(response.body);
      List<dynamic> gamesFromServer = (jsonD as Map<String, dynamic>)['games'];
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

          "assets/images/Cyberpunk2077.jpg",
          gamesFromServer[i]["name"],
          gamesFromServer[i]['description'],
          gamesFromServer[i]['price'],
          //123.44,
        ));
      }
      ;
      _itemsList = loadedProducts;
      notifyListeners();
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
  }

  static getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = (prefs.getString('ID') ?? '');
  }
}
