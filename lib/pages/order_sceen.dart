import 'package:cloudify_application/pages/BuyPage.dart';
import 'package:cloudify_application/widgets/drawer/app_drawer.dart';
import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:cloudify_application/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
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
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 15),
              ),
              overlayColor: MaterialStateProperty.all(Colors.green),
              // padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              // minimumSize: MaterialStateProperty.all(const Size(2, 2)),
              fixedSize: MaterialStateProperty.all(const Size(110, 20)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            child: const Text("Connexion"),
            onPressed: () {
              Navigator.pushNamed(context, "/signin");
            },
          ),
          IconButton(
            onPressed: () => {
              //SharedPreferences prefs = await SharedPreferences.getInstance();
              // await prefs.clear();
              Navigator.pushReplacementNamed(context, "/signin"),
            },
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.green,
            ),
          )
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BuyPage(
                            price: price,
                          )));
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
}
