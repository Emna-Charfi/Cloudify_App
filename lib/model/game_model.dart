import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class GameModels with ChangeNotifier {
  final String id;
  String image;
  final String title;
  final String description;
  final int price;
  bool isFavorite = false;
  static List<String> images = [];

  GameModels(
    this.id,
    this.image,
    this.title,
    this.description,
    this.price,
  );

  void setImages(List<String> img) {
    if (images.isEmpty) {
      images.addAll(img);
    }
  }

  List<String> get gameImages {
    return [...images];
  }

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
