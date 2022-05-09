import 'package:cloudify_application/test/sett.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloudify_application/providers/user.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String _username = "";
String _avatar = "";

class DrawerS extends StatefulWidget {
  DrawerS({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerS> createState() => _DrawerSState();
}

class _DrawerSState extends State<DrawerS> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = (prefs.getString('USERNAME') ?? '');
      _avatar = (prefs.getString('AVATAR') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Users>(context, listen: false);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final String? username = prefs.getString('username');

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
                            backgroundImage: (_avatar.isNotEmpty)
                                ? NetworkImage(_avatar) as ImageProvider
                                : AssetImage(
                                    "assets/images/NoImageAvailable.jpg"),

                            //AssetImage("assets/images/ariana.jpeg")
                          ),
                          // Padding(
                          //   padding:
                          //       EdgeInsets.only(bottom: 0, left: 104, top: 0),
                          //   // child: CircleAvatar(
                          //   //   backgroundColor:
                          //   //       Color(0xFF232D3B), //Colors.black54,
                          //   //   child: IconButton(
                          //   //     icon: Icon(
                          //   //       Icons.edit,
                          //   //       color: Colors.white,
                          //   //     ),
                          //   //     onPressed: () {
                          //   //       //bottomSheet(context);
                          //   //       //to do add picture
                          //   //     },
                          //   //   ),
                          //   // ),
                          // )
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                //"Emna Charfi",
                                //getName(context),
                                _username,
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 20.0),
                              ),
                              // Text(
                              //   "EMNA@esprit.tn",
                              //   style: TextStyle(
                              //       color: Colors.white, fontSize: 15.0),
                              // ),
                            ],
                          ),
                        ],
                      )),
                    ),
                    // SizedBox(
                    //   height: 100,
                    //   child: DrawerHeader(
                    //       child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "EMNA",
                    //         style:
                    //             TextStyle(color: Colors.white, fontSize: 20.0),
                    //       ),
                    //       Text(
                    //         "EMNA@esprit.tn",
                    //         style:
                    //             TextStyle(color: Colors.white, fontSize: 15.0),
                    //       ),
                    //     ],
                    //   )),
                    // ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/home/profil");
                            },
                            leading: Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                            title: Text(
                              "Edit Profil",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/home");
                              //Navigator.pop(context);
                            },
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
                            onTap: () {
                              Navigator.pushNamed(context, "/setting");
                            },
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
                              Navigator.pushNamed(context, "/home/profil");
                            },
                            leading: Icon(
                              Icons.wallet_giftcard,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Wallet",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              //Navigator.pushNamed(context, "/order");
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: const Text(
                              //         "Our Number",
                              //         style: TextStyle(),
                              //         textAlign: TextAlign.center,
                              //       ),
                              //       content: Row(
                              //         children: [
                              //           IconButton(
                              //               onPressed: () {},
                              //               icon: Icon(
                              //                 Icons.phone,
                              //                 color: Colors.green,
                              //               )),
                              //           Spacer(),
                              //           Text(
                              //             "55 55 55 88",
                              //             style: TextStyle(
                              //                 color: Colors.orange,
                              //                 fontSize: 18),
                              //             //textAlign: TextAlign.center,
                              //           ),
                              //         ],
                              //       ),
                              //       actions: [
                              //         TextButton(
                              //             onPressed: () {
                              //               Navigator.pop(context);
                              //             },
                              //             child: Text("OK"))

                              //       ],
                              //     );
                              //   },
                              // );
                              launch(emailLaunchUri.toString());
                            },
                            leading: Icon(
                              Icons.contact_mail,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Contact us",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     Navigator.pushReplacementNamed(
                          //         context, "/signin");
                          //   },
                          //   leading: Icon(
                          //     Icons.login_rounded,
                          //     color: Colors.orange,
                          //   ),
                          //   title: Text(
                          //     "Connexion",
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),

                          ListTile(
                            onTap: () {
                              if (getConnection(context) == true) {
                                deconnect(context);
                                Navigator.pushNamed(context, "/home");
                              } else {
                                deconnect(context);
                                Navigator.pushNamed(context, "/signin");
                              }
                            },
                            leading: Icon(
                              userProvider.getStat()
                                  ? Icons.logout
                                  : Icons.login,
                              color: Colors.orange,
                            ),
                            title: Text(
                              userProvider.getStat()
                                  ? "Disconnect"
                                  : "Connecxion",
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

  String getName(BuildContext context) {
    final userProvider = Provider.of<Users>(context);

    return userProvider.users.username!;
  }

  bool getConnection(BuildContext context) {
    final userProvider = Provider.of<Users>(context, listen: false);

    return userProvider.getStat();
  }

  deconnect(BuildContext context) {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final String? username = prefs.getString('username');

    final userProvider = Provider.of<Users>(context, listen: false);
    userProvider.RemoveUser();
    print("deconn" + userProvider.users.email!);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'smith@example.com',
  );
}
