import 'package:cloudify_application/db/panierdb.dart';
import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/util/game_utils.dart';

class PanierUtils {
  static late List<GameModels> games = GameUtils.getMockedGames();
  static late List<GameModels> _paniers = [];
  // new List<GameModels> (); //= GameUtils.getMockedGames();
  // static late List<GameModels>? gameList = [];

  // static Future RefreshNotes() async {
  //   //PanierDatabase.instance;
  //   List<String> nomberOfIndex = new List.empty();
  //   List<Panier> list = new List.empty();

  //   list = await PanierDatabase.instance.readAllPaniers();

  //   for (int i = 0; i < list.length; i++) {
  //     nomberOfIndex.add(list[i].idGame.toString());
  //   }
  //   print(nomberOfIndex.length);

  //   for (int i = 0; i < games.length; i++) {
  //     _paniers.add(games[i]);
  //     for (int j = 0; j < nomberOfIndex.length; j++) {
  //       if (games[i].id == nomberOfIndex[j]) {
  //         _paniers.add(games[i]);
  //       }
  //     }
  //   }
  //   for (int j = 0; j < _paniers.length; j++) {
  //     print(_paniers[j].price.toString());
  //   }

  //   return _paniers;
  //   //setState(() => isLoading = false);
  // }
  static Future<List<GameModels>> RefreshNotes() async {
    var dbClient = await PanierDatabase.instance.database;

    List<Map> list = await dbClient.rawQuery('SELECT * FROM paniers');
    List<String> nomberOfIndex = [];

    int m = 0;

    for (int i = 0; i < list.length; i++) {
      nomberOfIndex.add(list[i]["idGame"]);
      m++;
    }
    var nbr = nomberOfIndex.length;
    for (int i = 0; i < nbr; i++) {
      for (int j = i + 1; j < nbr;) {
        if (nomberOfIndex[j] == nomberOfIndex[i]) {
          for (int k = j; k < nbr; k++) {
            nomberOfIndex[k] = nomberOfIndex[k + 1];
          }
          nbr--;
        } else
          j++;
      }
    }
    print("the nomber is " + nbr.toString());

    print("the variable M is " + m.toString());
    print(nomberOfIndex.length);

    for (int i = 0; i < games.length; i++) {
      for (int j = 0; j < nomberOfIndex.length; j++) {
        if (games[i].id == nomberOfIndex[j]) {
          print("le titre de game in the boucle" + games[i].title);
          _paniers.add(games[i]);
        }
      }
    }
    var nbrGames = _paniers.length;
    for (int i = 0; i < nbrGames; i++) {
      for (int j = i + 1; j < nbrGames;) {
        if (nomberOfIndex[j] == nomberOfIndex[i]) {
          for (int k = j; k < nbrGames; k++) {
            nomberOfIndex[k] = nomberOfIndex[k + 1];
          }
          nbrGames--;
        } else
          j++;
      }
    }
    //_paniers.length = nbrGames;
    // for (int j = 0; j < _paniers.length; j++) {
    //   print("prices mssssssg");
    //   print(_paniers[j].price);
    // }

    return _paniers;
  }

  static void reflesh() async {
    await RefreshNotes();
  }

  static List<GameModels> getMockedGames() {
    reflesh();
    return _paniers;
  }
}
