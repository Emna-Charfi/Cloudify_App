import 'package:cloudify_application/game.dart';
import 'package:cloudify_application/panier.dart';
import 'package:cloudify_application/store.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    late int currentIndex = 0;

    final List<Widget> _interfaces = const [
      HomePage(),
      Store(),
      Game(),
      Panier()
    ];
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.white),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Profil',
                            color: Colors.black,
                            icon: const Icon(Icons.person_outline),
                            onPressed: () {},
                          ),
                          if (centerLocations.contains(fabLocation))
                            const Spacer(),
                          IconButton(
                            tooltip: 'Sorie',
                            color: Colors.black,
                            icon: const Icon(Icons.store),
                            onPressed: () {},
                          ),
                          if (centerLocations.contains(fabLocation))
                            const Spacer(),
                        ],
                      )),
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Games',
                            color: Colors.black,
                            icon: const Icon(Icons.games),
                            onPressed: () {},
                          ),
                          if (centerLocations.contains(fabLocation))
                            const Spacer(),
                          IconButton(
                            tooltip: 'Panier',
                            color: Colors.black,
                            icon: const Icon(Icons.shopping_basket_rounded),
                            onPressed: () {},
                          ),
                          if (centerLocations.contains(fabLocation))
                            const Spacer(),
                        ],
                      )),
                ]),
          )),
    );
  }
}
