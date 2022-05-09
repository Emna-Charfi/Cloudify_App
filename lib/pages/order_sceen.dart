import 'dart:convert';

import 'package:cloudify_application/const/colors.dart';
import 'package:cloudify_application/pages/ProfilePage.dart';
import 'package:cloudify_application/providers/cart.dart';
import 'package:cloudify_application/services/payement.dart';
import 'package:cloudify_application/util/api.dart';
import 'package:cloudify_application/util/helper.dart';

import 'package:cloudify_application/widgets/badge.dart';

import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:cloudify_application/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/orders.dart' show Orders;
import "package:http/http.dart" as http;

String _amount = "";
String _id = "";

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final PaymentController controller = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _amount = (prefs.getString('AMOUNT') ?? '');
      _id = (prefs.getString('ID') ?? '');
      print("iddddddddd*************" + _id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gamePanier = Provider.of<Cart>(context, listen: false);
    final orderData = Provider.of<Orders>(context, listen: true);

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
            onPressed: () async {
              int num = price.toInt();
              print("********the price******" + price.toString());
              print("********the price******" + _amount.toString());
              if (int.parse(_amount) < num) {
                //print("*********" + accpt.toString());

                showDialog(
                    context: this.context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            "Your Amount not enough",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 22.0,
                            ),
                          ),
                          content:
                              Text("You have to charge your Wallet or Buy Now"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                Navigator.of(context).pop(false);
                                if (await controller.makePayment(
                                        amount: num.toString(),
                                        currency: 'USD') ==
                                    true) {
                                  if (AddBase(this.context)) {
                                    gamePanier.clear();

                                    orderData.clear();

                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        isScrollControlled: true,
                                        isDismissible: false,
                                        context: this.context,
                                        builder: (context) {
                                          return Container(
                                            height: Helper.getScreenHeight(
                                                    context) *
                                                0.8,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                                this.context)
                                                            .pop();
                                                      },
                                                      icon: Icon(Icons.clear),
                                                    ),
                                                  ],
                                                ),
                                                Image.asset(
                                                  Helper.getAssetName(
                                                    "vector4.png",
                                                    "virtual",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Thank You!",
                                                  style: TextStyle(
                                                    color: AppColor.primary,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "for your order",
                                                  style:
                                                      Helper.getTheme(context)
                                                          .headline4!
                                                          .copyWith(
                                                              color: AppColor
                                                                  .primary),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  child: Text(
                                                      "Your order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your order"),
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed("/home");
                                                      },
                                                      child:
                                                          Text("Back To Home"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                }
                              },
                              child: Text("Buy Now"),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                                Navigator.pushNamed(
                                    this.context, "/home/profil");
                              },
                              child: Text("Charge my Wallet"),
                            ),
                          ],
                        ));
              } else {
                if (AddBase(this.context)) {
                  gamePanier.clear();

                  orderData.clear();
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      isScrollControlled: true,
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: Helper.getScreenHeight(context) * 0.8,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                ],
                              ),
                              Image.asset(
                                Helper.getAssetName(
                                  "vector4.png",
                                  "virtual",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Thank You!",
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "for your order",
                                style: Helper.getTheme(context)
                                    .headline4!
                                    .copyWith(color: AppColor.primary),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                    "Your order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your order"),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed("/home");
                                    },
                                    child: Text("Back To Home"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              }

              //cart.clear();

              //AddBase(context);
              //Navigator.push(
              //  context, MaterialPageRoute(builder: (context) => Home()));
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

  bool AddBase(BuildContext context) {
    final gamePanier = Provider.of<Cart>(context, listen: false);
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    print("lenth of card" + gamePanier.itemCount.toString());

    // for (var i = 0; i < gamePanier.itemCount; i++) {
    // gamePanier.items.forEach((key, cartItem) {
    // for (var i = 0; i < gamePanier.items.length; i++) {
    // print("Id Of Game    " + gamePanier.items[i].toString());
    http
        .post(
      Uri.http(api_keyM, "buyGame/" + _id + "/" + "6278eb6a0ccfaf87a55a1864"),
      headers: headers,
    )
        .then((http.Response response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("AMOUNT", userData['solde'].toString());
        return true;

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
        return false;
      } else if (response.statusCode == 402) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text("Information"),
                content: Text("Email doesn't exist"),
              );
            });
        return false;
      } else if (response.statusCode == 400) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text("Information"),
                content: Text("Bad Request 400 "),
              );
            });
        return false;
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
        return false;
      }
    });
    //}
    return true;
  }
}
