import 'package:cloudify_application/widgets/freegame.dart';

import 'package:cloudify_application/widgets/paidgames.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor:
                  const Color(0xFF232D3B), //Color.fromARGB(255, 232, 120, 89),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    // icon: Icon(
                    //   Icons.home,
                    //   color: Colors.green,
                    // ),
                    //text: ("Store"),
                    child: Text("Free Game",
                        style: TextStyle(color: Colors.orange)),
                  ),
                  Tab(
                    // icon: Icon(
                    //   Icons.shopping_basket_rounded,
                    //   color: Colors.green,
                    // ),
                    child: Text("Paid Game",
                        style: TextStyle(color: Colors.orange)),
                  )
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [FreeGame(), PaidGame()],
          )),
    );
  }
}
