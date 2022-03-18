import 'dart:math';

import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  // late PickedFile _imageFile;
  // final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    double value = 0;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xFF232D3B),
                Colors.grey,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topCenter,
            )),
          ),
          SafeArea(
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              AssetImage("assets/images/logo2.png")),
                      Text(
                        "EMNA",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      // Text(
                      //   "EMNA@esprit.tn",
                      //   style: TextStyle(color: Colors.white, fontSize: 20.0),
                      // ),
                    ],
                  )),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Home",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Profil",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Setting",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Disconnect",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.payment,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Orders",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: Duration(milliseconds: 500),
            builder: (_, double val, __) {
              return (Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
              ));
            },
          ),
          GestureDetector(
            onTap: () {
              // setState(() {
              //   value == 0 ? value = 1 : value = 0;
              // });
            },
          ),
        ],
      ),
    );
  }
}
