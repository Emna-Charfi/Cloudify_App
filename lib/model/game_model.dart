import 'package:flutter/foundation.dart';

class GameModels with ChangeNotifier {
  final String id;
  final String image;
  final String title;
  final String description;
  final double price;
  bool isFavorite = false;

  GameModels(
    this.id,
    this.image,
    this.title,
    this.description,
    this.price,
  );

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  // factory Category.fromJson(Map<String, dynamic> json) {

  //   return Category(
  //     color: Color(int.parse('0xFF' + json['color'])),
  //     icon: json['icon'],
  //     name: json['name'],
  //     imgName: json['imgName'],
  //     subCategories: SubCategory.fromJsonArray(json['subCategories'])
  //   );
  // }
}
