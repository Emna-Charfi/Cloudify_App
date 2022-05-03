import 'package:cloudify_application/pages/order_sceen.dart';

import 'package:cloudify_application/providers/cart.dart';
import 'package:cloudify_application/providers/orders.dart';
import 'package:cloudify_application/widgets/drawer/drawer.dart';

import 'package:cloudify_application/widgets/panier_game_card.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    //CategorySelectionService catSelection = Provider.of<CategorySelectionService>(context, listen: false);
    //CategoryService catService = Provider.of<CategoryService>(context, listen: false);

    final gamePanier = Provider.of<Cart>(context);
    //final gamePanierList = gamePanier.

    int price = 0;
    // int items = gameList.length;
    int items = gamePanier.itemCount;

    price = gamePanier.totalAmount;

    // print(paniers.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232D3B),
        elevation: 4.0,
        // leadingWidth: 0,
        title: Align(
            child: Text(
              'Shop Page ',
              // textAlign: Alignment.bottomLeft,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            alignment: Alignment.bottomLeft),
      ),
      drawer: DrawerS(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(),
        ),
        Expanded(
          child: ListView.builder(
            //  itemCount: games.length,
            itemCount: items,
            itemBuilder: (BuildContext ctx, int i) {
              return PanierGameCard(
                  id: gamePanier.items.values.toList()[i].id,
                  productId: gamePanier.items.keys.toList()[i],
                  title: gamePanier.items.values.toList()[i].title,
                  price: gamePanier.items.values.toList()[i].price,
                  image: gamePanier.items.values.toList()[i].image,
                  onCardClick: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => selectedGamePanier(
                    //               index: i,
                    //             )));

                    //Rien a Faire
                  });
            },
          ),
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(children: [
              Align(
                  child: Text(
                    ' All: ',
                    // textAlign: Alignment.bottomLeft,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.bottomLeft),
              SizedBox(width: 20),
              Align(
                  child: Text(
                    price.toString() + "DT",
                    // textAlign: Alignment.bottomLeft,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.centerRight),
              SizedBox(width: 70),
              SizedBox(
                width: 120, // <-- Your width
                height: 40, // <-- Your height
                child: ElevatedButton(
                  child: const Text("Buy Now"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent, // background

                    onPrimary: Colors.white, // foreground
                    shape: StadiumBorder(),

                    // side: BorderSide(width: 2, color: Colors.red),
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, "/buypage");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => BuyPage(
                    //               price: price,
                    //             )));
                    Provider.of<Orders>(context, listen: false).addOrder(
                      gamePanier.items.values.toList(),
                      gamePanier.totalAmount,
                    );
                    //cart.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersScreen()));
                  },
                ),
              ),
            ]))
      ]),
    );
  }
}
