import 'package:cloudify_application/game.dart';
import 'package:cloudify_application/home_page.dart';
import 'package:cloudify_application/pages/ProfilePage.dart';
import 'package:cloudify_application/panier.dart';
import 'package:cloudify_application/store.dart';

import 'package:cloudify_application/widgets/badge.dart';
import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';

import 'package:cloudify_application/providers/cart.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });
  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex = 0;
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  final List<Widget> _interfaces = const [
    HomePage(),
    Store(),
    Game(),
    Panier(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
        // body: const TabBarView(
        //   children: [Store(), Store(), Game(), Panier()],
        // )
        body: _interfaces[_currentIndex],

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 0;
            });
          },
          backgroundColor: Color(0xFFF17532),
          child: Icon(Icons.home),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          color: Colors.transparent,
          elevation: 9.0,
          clipBehavior: Clip.antiAlias,
          child: IconTheme(
              data:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
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
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = 4;
                                  });
                                },
                              ),
                              //if (BottomBar.centerLocations.contains(fabLocation))
                              const Spacer(),
                              IconButton(
                                tooltip: 'Sorie',
                                color: Colors.black,
                                icon: const Icon(Icons.store),
                                // disabledColor: Colors.yellow,
                                highlightColor: Colors.yellow,
                                autofocus: true,
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = 1;
                                  });
                                },
                              ),
                              // if (centerLocations.contains(fabLocation))
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
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = 2;
                                  });
                                },
                              ),
                              // if (centerLocations.contains(fabLocation))
                              const Spacer(),

                              // IconButton(
                              //   tooltip: 'Panier',
                              //   color: Colors.black,
                              //   icon: const Icon(Icons.shopping_basket_rounded),
                              //   onPressed: () {
                              //     setState(() {
                              //       _currentIndex = 3;
                              //     });
                              //   },
                              // ),
                              Consumer<Cart>(
                                builder: (_, cart, ch) => Badge(
                                  child: ch,
                                  value: cart.itemCount.toString(),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _currentIndex = 3;
                                    });
                                    // Navigator.of(context).pushNamed(CartScreen.routeName);
                                  },
                                ),
                              ),
                              // if (centerLocations.contains(fabLocation))
                              const Spacer(),
                            ],
                          )),
                    ]),
              )),
        ),
      ),
    );
  }
}
