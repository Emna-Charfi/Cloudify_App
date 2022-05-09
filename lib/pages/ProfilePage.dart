import 'dart:convert';
import 'dart:developer';

import 'package:cloudify_application/const/colors.dart';
import 'package:cloudify_application/home.dart';
import 'package:cloudify_application/providers/user.dart';
import 'package:cloudify_application/services/payement.dart';
import 'package:cloudify_application/util/api.dart';
import 'package:cloudify_application/util/helper.dart';

import 'package:cloudify_application/widgets/badge.dart';
import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloudify_application/providers/cart.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import "package:http/http.dart" as http;

String _username = "";
String _email = "";
String _id = "";

String _avatar = "";
String mount = "";
String mountt = "";
final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  late String _securityCode = "";

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = (prefs.getString('USERNAME') ?? '');
      _email = (prefs.getString('EMAIL') ?? '');
      _avatar = (prefs.getString('AVATAR') ?? '');
      _id = (prefs.getString('ID') ?? '');
      print(_id + "   ******************");
      mount = (prefs.getString('AMOUNT') ?? '');
    });
  }

  Widget textfield({@required hintText, onPress}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                //Navigator.of(context).pushNamed(onPress);
                // _launchURL();
                forget();
              },
              icon: Icon(Icons.edit),
              color: Colors.green,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stripe.publishableKey =
        'pk_test_51Kn0qoBlWZdiLH02aBBjgcqtf8D2hiAWgY9jMGyhHnZViHgjE3jMEr81D41uOfOmMf6qWZhYxUzFlolIZuSQnwr900goTHKnwy';

    final PaymentController controller = Get.put(PaymentController());
    //final userProvider = Provider.of<Users>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          this._securityCode;
          await Future.value({});
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("CLOUDIFY "),
            backgroundColor: const Color(0xFF232D3B),
            //backgroundColor: Colors.transparent,
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
          body: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                painter: HeaderCurvedContainer(),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            elevation: 4,
                            shadowColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: _username,
                                  hintStyle: TextStyle(
                                    letterSpacing: 2,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      //showModalBottomSheet(this.context);
                                      Navigator.of(context)
                                          .pushNamed("/resetPwd");
                                    },
                                    icon: Icon(Icons.edit),
                                    color: Colors.green,
                                  ),
                                  fillColor: Colors.white30,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                          // EMAIL  $$$$$$$
                          Material(
                            elevation: 4,
                            shadowColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: _email,
                                  hintStyle: TextStyle(
                                    letterSpacing: 2,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  fillColor: Colors.white30,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none)),
                            ),
                          ),

                          //textfield(hintText: _email, onPress: ""),
                          textfield(hintText: 'Password', onPress: "/resetPwd"),
                          Material(
                              elevation: 4,
                              shadowColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(children: [
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(10.0),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      mount + " US",
                                      style: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 29,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      //shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.all(10.0),
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      //shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                        // fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/visa.png"),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        isScrollControlled: true,
                                        isDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: Helper.getScreenHeight(
                                                    context) *
                                                0.4,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: Icon(
                                                          Icons.clear,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Add Your preferred amount ",
                                                          style:
                                                              Helper.getTheme(
                                                                      context)
                                                                  .headline6,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    child: Divider(
                                                      color: AppColor
                                                          .placeholder
                                                          .withOpacity(0.5),
                                                      thickness: 1.5,
                                                      height: 10,
                                                    ),
                                                  ),
                                                  Form(
                                                    key: _keyForm,
                                                    child: Container(
                                                      //  color: Colors.white,
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 20, 10, 10),
                                                      child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .placeholder,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: "Amount",

                                                          labelStyle: TextStyle(
                                                            color: AppColor
                                                                .placeholder,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                            color: AppColor
                                                                .placeholder,
                                                          )),

                                                          //hintStyle: TextStyle(color: Colors.white),
                                                        ),
                                                        onSaved:
                                                            (String? value) {
                                                          print(value);
                                                          //_cardNumber = value;
                                                          setState(() {
                                                            mountt = value!;
                                                          });
                                                        },
                                                        validator:
                                                            (String? value) {
                                                          if (value!.isEmpty) {
                                                            return "Can not be empty !";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .deepOrangeAccent, // background
                                                            onPrimary: Colors
                                                                .white, // foreground
                                                          ),
                                                          onPressed: () async {
                                                            if (_keyForm
                                                                .currentState!
                                                                .validate()) {
                                                              _keyForm
                                                                  .currentState!
                                                                  .save();
                                                              //updateMount();
                                                              if (await controller.makePayment(
                                                                      amount:
                                                                          mountt,
                                                                      currency:
                                                                          'USD') ==
                                                                  true) {
                                                                updateMount();

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                              updateMount();

                                                              print("test");
                                                            }
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.save,
                                                              ),
                                                              SizedBox(
                                                                  width: 40),
                                                              Text("Save"),
                                                              SizedBox(
                                                                  width: 40),
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ])),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (_avatar.isNotEmpty)
                            ? NetworkImage(_avatar) as ImageProvider
                            : AssetImage("assets/images/NoImageAvailable.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    const _url = api_key;
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  void forget() {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map<String, dynamic> body = {
      'email': _email,
    };
    http
        .post(
      Uri.http(api_keyM, "forgot"),
      headers: headers,
      body: json.encode(body),
    )
        .then((http.Response response) async {
      // try {
      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return const AlertDialog(
      //           title: Text("Response"),
      //           content: Text(response.statusCode.toString()),
      //         );
      //       });
      // } catch (erreur) {}

      if (response.statusCode == 200) {
        //Map<String, dynamic> userData = jsonDecode(response.body);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Information"),
                content: Row(
                  children: [
                    Text("CheQ your EMail"),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          _launchURL();
                        },
                        icon: Icon(
                          Icons.email,
                          color: Colors.green,
                        ))
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
  }

  void updateMount() {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map<String, dynamic> body = {
      'solde': mountt,
    };
    http
        .post(
      Uri.http(api_keyM, "addSolde/" + _id),
      headers: headers,
      body: json.encode(body),
    )
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("AMOUNT", userData['solde'].toString());
        //prefs.setInt("AMOUNTT", userData['solde'] as int);
        //print("**********Amounttt" + userData['solde']);
        print(userData['solde'].toString());
        print("user******" + userData.toString());
        setState(() {
          mount = userData['solde'].toString();
        });

        log("updated succes");
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
                content: Text("mount doesn't exist"),
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
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF232D3B); //Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
