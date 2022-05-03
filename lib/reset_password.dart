import 'dart:convert';

import 'package:cloudify_application/providers/cart.dart';
import 'package:cloudify_application/util/api.dart';
import 'package:cloudify_application/widgets/badge.dart';
import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

String _id = "";

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = (prefs.getString('USERNAME') ?? '');
      _id = (prefs.getString('ID') ?? '');
    });
  }

  late String? _username;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232D3B),
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
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Image.asset("assets/images/logo2.png",
                    width: 460, height: 215)),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
                onSaved: (String? value) {
                  _username = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Le username ne doit pas etre vide";
                  } else if (value.length < 5) {
                    return "Le username doit avoir au moins 5 caractères";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                      //Navigator.pushNamed(context, "/resetP");
                      change();
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  void change() {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    Map<String, dynamic> body = {
      'username': _username,
    };
    http
        .post(
      Uri.http(api_keyM, "edit/" + _id.toString()),
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
                    Text("Your username is changed !"),
                    Spacer(),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.email,
                    //       color: Colors.green,
                    //     ))
                  ],
                ),
              );
            });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("USERNAME", _username!);

        Navigator.pushReplacementNamed(context, "/home/profil");
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
}
