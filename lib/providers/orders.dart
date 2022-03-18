import 'package:cloudify_application/providers/cart.dart';
import 'package:flutter/foundation.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartI>? games;
  final DateTime? dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.games,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartI> cartProducts, double total) {
    if (_orders.isEmpty) {
      _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          games: cartProducts,
        ),
      );
      notifyListeners();
    }
  }
}
