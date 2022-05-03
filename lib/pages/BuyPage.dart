import 'package:cloudify_application/const/colors.dart';
import 'package:cloudify_application/model/cardmodel.dart';
import 'package:cloudify_application/pages/chekout.dart';
import 'package:cloudify_application/pages/customtextinput.dart';
import 'package:cloudify_application/util/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyPage extends StatefulWidget {
  double? price;

  BuyPage({Key? key, this.price}) : super(key: key);

  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late CardModel card; //= new CardModel("cardNumber", "mmExperation",
  //  "yyExperation", "securityCode", "firstName", "lastName");

  late String? _firstName = "";
  late String? _lastName = "";
  late String? _yydate = "";
  late String? _mmdate = "";
  late String? _securityCode = "";
  late String? _cardNumber = "**** **** **** ****";
  // @override
  // void initState() {
  //   //_cardNumber = _cardNumber;

  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Payment Details",
                              style: Helper.getTheme(context).headline5,
                            ),
                          ),
                          Image.asset(
                            ("assets/images/cart.png"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            "Customize your payment method",
                            style: Helper.getTheme(context).headline6,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: AppColor.placeholder,
                        thickness: 1.5,
                        height: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            "Details Panier",
                            style: Helper.getTheme(context).headline6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price :",
                            style: TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            widget.price.toString(),
                            style: TextStyle(
                                color: AppColor.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: AppColor.placeholder,
                        thickness: 1.5,
                        height: 30,
                      ),
                    ),
                    Container(
                      height: 170,
                      width: Helper.getScreenWidth(context),
                      decoration: BoxDecoration(
                        color: AppColor.placeholderBg,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.placeholder.withOpacity(0.5),
                            offset: Offset(0, 20),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Cash/Card on delivery",
                                  style: TextStyle(
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.check,
                                  color: AppColor.orange,
                                )
                              ],
                            ),
                            Divider(
                              color: AppColor.placeholder,
                              thickness: 1,
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                      ("assets/images/visa.png"),
                                    )),

                                Text(_cardNumber.toString()),

                                //Text("2187"),
                                //  Text(widget.cardNumber.toString()),
                                OutlinedButton(
                                  style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                        BorderSide(
                                          color: AppColor.orange,
                                        ),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        StadiumBorder(),
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              AppColor.orange)),
                                  onPressed: () {},
                                  child: Text("Delete Card"),
                                )
                              ],
                            ),
                            Divider(
                              color: AppColor.placeholder,
                              thickness: 1,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                isScrollControlled: true,
                                isDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height:
                                        Helper.getScreenHeight(context) * 0.8,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Add Credit/Debit Card",
                                                  style:
                                                      Helper.getTheme(context)
                                                          .headline6,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Divider(
                                              color: AppColor.placeholder
                                                  .withOpacity(0.5),
                                              thickness: 1.5,
                                              height: 10,
                                            ),
                                          ),
                                          Form(
                                            key: _keyForm,
                                            child: Container(
                                              //  color: Colors.white,
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 20, 10, 10),
                                              child: TextFormField(
                                                style: TextStyle(
                                                  color: AppColor.placeholder,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Card Number",

                                                  labelStyle: TextStyle(
                                                    color: AppColor.placeholder,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                    color: AppColor.placeholder,
                                                  )),

                                                  //hintStyle: TextStyle(color: Colors.white),
                                                ),
                                                onSaved: (String? value) {
                                                  print(value);
                                                  _cardNumber = value;
                                                  setState(() {
                                                    _cardNumber = value;
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Expiry"),
                                                SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20.0),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .placeholder,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintStyle: TextStyle(
                                                            color: AppColor
                                                                .placeholder,
                                                          ),
                                                          labelText: "MM",
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
                                                        ),
                                                        onSaved:
                                                            (String? value) {
                                                          _mmdate = value;
                                                        },
                                                        // validator:
                                                        //     (String? value) {
                                                        //   if (value!.isEmpty) {
                                                        //     return "Can not be empty !";
                                                        //   }
                                                        //   if (value.length < 2 ||
                                                        //       value.length > 2) {
                                                        //     return "The length must to be 2 !";
                                                        //   } else {
                                                        //     return null;
                                                        //   }
                                                        // },
                                                      ),
                                                    )),
                                                SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20.0),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .placeholder,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintStyle: TextStyle(
                                                            color: AppColor
                                                                .placeholder,
                                                          ),
                                                          labelText: "YY",
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
                                                        ),
                                                        onSaved:
                                                            (String? value) {
                                                          _yydate != value;
                                                        },
                                                        // validator:
                                                        //     (String? value) {
                                                        //   if (value == null) {
                                                        //     return "Can not be empty !";
                                                        //   }
                                                        //   if (value.length < 2 ||
                                                        //       value.length > 2) {
                                                        //     return "The length must to be 2 !";
                                                        //   } else {
                                                        //     return null;
                                                        //   }
                                                        // },
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: TextFormField(
                                              style: TextStyle(
                                                color: AppColor.placeholder,
                                              ),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintStyle: TextStyle(
                                                  color: AppColor.placeholder,
                                                ),
                                                labelText: "Security Code",
                                                labelStyle: TextStyle(
                                                  color: AppColor.placeholder,
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: AppColor.placeholder,
                                                )),
                                              ),
                                              onSaved: (String? value) {
                                                _securityCode != value;
                                              },
                                              // validator: (String? value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Can not be empty !";
                                              //   }
                                              //   if (value.length < 4 ||
                                              //       value.length > 4) {
                                              //     return "The length of the code must to be 4 !";
                                              //   } else {
                                              //     return null;
                                              //   }
                                              // },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: TextFormField(
                                              style: TextStyle(
                                                color: AppColor.placeholder,
                                              ),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintStyle: TextStyle(
                                                  color: AppColor.placeholder,
                                                ),
                                                labelText: "First Name",
                                                labelStyle: TextStyle(
                                                  color: AppColor.placeholder,
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: AppColor.placeholder,
                                                )),
                                              ),
                                              onSaved: (String? value) {
                                                _firstName != value;
                                              },
                                              // validator: (String? value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Can not be empty !";
                                              //   } else {
                                              //     return null;
                                              //   }
                                              // },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: TextFormField(
                                              style: TextStyle(
                                                color: AppColor.placeholder,
                                              ),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintStyle: TextStyle(
                                                  color: AppColor.placeholder,
                                                ),
                                                labelText: "Last Name",
                                                labelStyle: TextStyle(
                                                  color: AppColor.placeholder,
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: AppColor.placeholder,
                                                )),
                                              ),
                                              onSaved: (String? value) {
                                                _lastName != value;
                                              },
                                              // validator: (String? value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Can not be empty !";
                                              //   } else {
                                              //     return null;
                                              //   }
                                              // },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "You can remove this card"),
                                                Switch(
                                                  value: false,
                                                  onChanged: (_) {},
                                                  thumbColor:
                                                      MaterialStateProperty.all(
                                                          //AppColor.secondary,
                                                          Colors.deepOrange),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: SizedBox(
                                              height: 50,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (_keyForm.currentState!
                                                        .validate()) {
                                                      _keyForm.currentState!
                                                          .save();

                                                      print("test");
                                                      card = new CardModel(
                                                          _cardNumber!,
                                                          _mmdate!,
                                                          _yydate!,
                                                          _securityCode!,
                                                          _firstName!,
                                                          _lastName!);
                                                      // Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CheckoutScreen(
                                                                    price: widget
                                                                        .price,
                                                                    card: card,
                                                                  )));
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                      ),
                                                      SizedBox(width: 40),
                                                      Text("Add Card"),
                                                      SizedBox(width: 40),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text("Add Credit/Debit Card"),
                            ],
                          )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(40, 20, 20, 40),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       if (card.yyExperation.toString() == "") {
                    //         showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return AlertDialog(
                    //               title: const Text("Informations"),
                    //               content: Text("Your Have first Add Cart"),
                    //             );
                    //           },
                    //         );
                    //       } else {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => CheckoutScreen(
                    //                       price: widget.price,
                    //                       card: card,
                    //                     )));
                    //       }
                    //     },
                    //     child: const Text(
                    //       "Go to Next",
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     style: ButtonStyle(
                    //       backgroundColor:
                    //           MaterialStateProperty.all<Color>(Colors.red),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   child: CustomNavBar(),
              // ),
            ],
          ),
        ),
      ),
      onRefresh: () async {
        this._securityCode;
        await Future.value({});
      },
    );
  }
}
