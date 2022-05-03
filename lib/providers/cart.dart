import 'package:flutter/foundation.dart';

class CartI {
  final String? id;
  final String? title;
  final String? image;
  final int? price;

  CartI({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartI> _items = {};

  Map<String, CartI> get items {
    return {..._items};
  }

  Map<String, CartI> get idOfGame {
    List<String> list1 = [];
    _items.forEach((key, cartItem) {
      list1.add(cartItem.id!);
    });
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price!;
    });
    return total;
  }

  void addItem(
    String productId,
    int price,
    String title,
    String image,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      // _items.update(
      //   productId,
      //   (existingCartItem) => CartItem(
      //         id: existingCartItem.id,
      //         title: existingCartItem.title,
      //         price: existingCartItem.price,
      //         quantity: existingCartItem.quantity + 1,
      //       ),
      // );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartI(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          image: image,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
