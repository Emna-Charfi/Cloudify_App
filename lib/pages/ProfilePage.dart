import 'dart:convert';

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
String _avatar = "";
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

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = (prefs.getString('USERNAME') ?? '');
      _email = (prefs.getString('EMAIL') ?? '');
      _avatar = (prefs.getString('AVATAR') ?? '');
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
          Column(
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
                        decoration: InputDecoration(
                            hintText: _username,
                            hintStyle: TextStyle(
                              letterSpacing: 2,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                //showModalBottomSheet(context);
                                Navigator.of(context).pushNamed("/resetPwd");
                              },
                              icon: Icon(Icons.edit),
                            ),
                            fillColor: Colors.white30,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    textfield(hintText: _email, onPress: "/resetPwd"),
                    textfield(hintText: 'Password', onPress: "/resetPwd"),
                    Material(
                        elevation: 4,
                        shadowColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              //shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                // fit: BoxFit.cover,
                                image: AssetImage("assets/images/visa.png"),
                              ),
                            ),
                          ),
                          onTap: () async {
                            //Navigator.of(context).pushNamed("/buypage");

                            // try {
                            //   Map<String, dynamic> body = {
                            //     'amount': '120',
                            //     'currency': 'USD',
                            //     'payment_method_types[]': 'card'
                            //   };
                            //   var response = await http.post(
                            //       Uri.parse(
                            //           'https://api.stripe.com/v1/payment_intents/sk_test_51Kn0qoBlWZdiLH02uoOIBmah1ekndPrKN0PAiVveidTmMJtg5hQcCr0If232t9jiBItPjEHXr7Gx7Oaw21bgmhaB00urtUD0Jp'),
                            //       body: body,
                            //       headers: {
                            //         'Authorization':
                            //             'Bearer sk_test_51Kn0qoBlWZdiLH02uoOIBmah1ekndPrKN0PAiVveidTmMJtg5hQcCr0If232t9jiBItPjEHXr7Gx7Oaw21bgmhaB00urtUD0Jp',
                            //         'Content-Type':
                            //             'application/x-www-form-urlencoded'
                            //       });
                            //   print(jsonDecode(response.body));
                            //   return jsonDecode(response.body);
                            // } catch (err) {
                            //   print('err charging user: ${err.toString()}');
                            // }

                            controller.makePayment(
                                amount: '5', currency: 'USD');
                          },
                        )),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.of(context).pushNamed("/buypage");
                          //to Do
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        //color: Colors.black54,
                        style: ElevatedButton.styleFrom(
                          primary: Color(
                              0xFF232D3B), // Colors.black54, // background
                          onPrimary: Colors.orange, // foreground
                        ),
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
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
          Padding(
            padding: EdgeInsets.only(bottom: 270, left: 184),
            child: CircleAvatar(
              backgroundColor: Color(0xFF232D3B), //Colors.black54,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  //to do add picture
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _launchURL() async {
    const _url = 'http://192.168.1.118:1080/#/';
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

  Widget showModalBottomSheet(BuildContext context) {
    return Container(
      height: Helper.getScreenHeight(context) * 0.8,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.clear,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  "Change UserName",
                  style: Helper.getTheme(context).headline6,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: AppColor.placeholder.withOpacity(0.5),
              thickness: 1.5,
              height: 10,
            ),
          ),
          Form(
            key: _keyForm,
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextFormField(
                style: TextStyle(
                  color: AppColor.placeholder,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "User Name",

                  labelStyle: TextStyle(
                    color: AppColor.placeholder,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColor.placeholder,
                  )),

                  //hintStyle: TextStyle(color: Colors.white),
                ),
                onSaved: (String? value) {
                  print(value);
                  _username = value!;
                  setState(() {
                    _username = value;
                  });
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Can not be empty !";
                  }
                  // if (value.length < 16) {
                  //   return "The length of the card Number is 16 !";
                  // }
                  else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();

                      print("test");

                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      SizedBox(width: 40),
                      Text("Save change"),
                      SizedBox(width: 40),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      )),
    );
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
