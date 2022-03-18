import 'dart:math';

import 'package:flutter/material.dart';

class DrawerS extends StatelessWidget {
  const DrawerS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300,
      child: Drawer(
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.grey,
                  Color(0xFF232D3B),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0, 1],
              )),
            ),
            SafeArea(
              child: Container(
                width: 220.0,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 270,
                      child: DrawerHeader(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 90.0,
                              backgroundImage:
                                  AssetImage("assets/images/ariana.jpeg")),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 0, left: 104, top: 0),
                            child: CircleAvatar(
                              backgroundColor:
                                  Color(0xFF232D3B), //Colors.black54,
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  //bottomSheet(context);
                                  //to do add picture
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                    ),
                    SizedBox(
                      height: 100,
                      child: DrawerHeader(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "EMNA",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Text(
                            "EMNA@esprit.tn",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      )),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                            title: Text(
                              "Update Profil",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/resetPwd");
                            },
                            leading: Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                            title: Text(
                              "Update Password",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
                              Icons.settings,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Setting",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/order");
                            },
                            leading: Icon(
                              Icons.payment,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Orders",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/signin");
                            },
                            leading: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Disconnect",
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
            // TweenAnimationBuilder(
            //   tween: Tween<double>(begin: 0, end: value),
            //   duration: Duration(milliseconds: 500),
            //   builder: (_, double val, __) {
            //     return (Transform(
            //       transform: Matrix4.identity()
            //         ..setEntry(3, 2, 0.001)
            //         ..setEntry(0, 3, 200 * val)
            //         ..rotateY((pi / 6) * val),
            //     ));
            //   },
            // ),
          ],
        )),
      ),
    );
  }

  // Widget bottomSheet(BuildContext context) {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: 20,
  //       vertical: 20,
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Text(
  //           "Choose Profile photo",
  //           style: TextStyle(
  //             fontSize: 20.0,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           FlatButton.icon(
  //             icon: Icon(Icons.camera),
  //             onPressed: () {
  //               //takePhoto(ImageSource.camera);
  //             },
  //             label: Text("Camera"),
  //           ),
  //           FlatButton.icon(
  //             icon: Icon(Icons.image),
  //             onPressed: () {
  //               //takePhoto(ImageSource.gallery);
  //             },
  //             label: Text("Gallery"),
  //           ),
  //         ])
  //       ],
  //     ),
  //   );
  // }

  // void takePhoto(ImageSource source) async {
  //   // final pickedFile = await _picker.getImage(
  //   //   source: source,
  //   // );
  //   // setState(() {
  //   //   _imageFile = pickedFile!;
  //   // });
  // }
}
