import 'package:cloudify_application/model/game_model.dart';

import 'package:cloudify_application/util/game_utils_paid.dart';
import 'package:flutter/material.dart';

class Games with ChangeNotifier {
  List<GameModels> _items = GameUtilsPaid.getMockedGames();

  List<GameModels> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<GameModels> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  GameModels findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  bool findByIdFav(String id) {
    GameModels game = _items.firstWhere((prod) => prod.id == id);

    return game.isFavorite;
  }

  void toggleFavoriteStatus(String id) {
    GameModels game = _items.firstWhere((prod) => prod.id == id);
    game.isFavorite = !game.isFavorite;
    notifyListeners();
  }

  void freeItem() {
    _items = [];
    notifyListeners();
  }
}
