import 'package:cloudify_application/providers/cart.dart';
import 'package:cloudify_application/services/payement.dart';
import 'package:cloudify_application/util/api.dart';

import 'package:cloudify_application/widgets/badge.dart';

import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:cloudify_application/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import "package:http/http.dart" as http;

class OrdersScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    final gamePanier = Provider.of<Cart>(context, listen: false);
    final orderData = Provider.of<Orders>(context, listen: false);

    double price = 0.0;
    for (int i = 0; i < orderData.orders.length; i++) {
      price = price + orderData.orders[i].amount!;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("CLOUDIFY "),
        backgroundColor: const Color(0xFF232D3B),
        elevation: 4.0,
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              color: Color(0xFFF17532),
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                // setState(() {
                //   _currentIndex = 3;
                // });
                Navigator.of(context).pushNamed("/home/panier");
              },
            ),
          ),
        ],
      ),
      drawer: DrawerS(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text('Your Order:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 20, 40),
          child: ElevatedButton(
            onPressed: () async {
              int num = price.toInt();
              controller.makePayment(amount: num.toString(), currency: 'USD');
              gamePanier.clear();

              //AddBase(context);
              //Navigator.push(
              //  context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: const Text(
              "Pay My Order Now",
              style: TextStyle(color: Colors.black),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
          ),
        ),
      ]),
    );
  }

  void AddBase(BuildContext context) {
    final gamePanier = Provider.of<Cart>(context, listen: false);
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    print("lenth of card" + gamePanier.itemCount.toString());

    // for (var i = 0; i < gamePanier.itemCount; i++) {
    gamePanier.items.forEach((key, cartItem) {
      print("Id Of Game    " + gamePanier.idOfGame[cartItem].toString());
      http
          .post(
        Uri.http(api_keyM, "buyGame/62352c1ae2c7cce027bad381"),
        headers: headers,
      )
          .then((http.Response response) async {
        if (response.statusCode == 200) {
          //Map<String, dynamic> userData = jsonDecode(response.body);

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Information"),
                  content: Row(
                    children: [
                      Text("Added"),
                    ],
                  ),
                );
              });

          //Navigator.pushReplacementNamed(context, "/home");
          // print("success");
        } else if (response.statusCode == 401) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Information"),
                  content: Text("Password is incorrect"),
                );
              });
        } else if (response.statusCode == 402) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Information"),
                  content: Text("Email doesn't exist"),
                );
              });
        } else if (response.statusCode == 400) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Information"),
                  content: Text("Bad Request 400 "),
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Information"),
                  content:
                      Text("Une erreur s'est produite. Veuillez réessayer !"),
                );
              });
        }
      });
    });
  }
}
