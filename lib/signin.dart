//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sqflite/sqflite.dart';
//import "package:http/http.dart" as http;
//import 'package:sqflite/sqlite_api.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String? _username;
  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232D3B), //Colors.blueGrey.shade700,

      appBar: AppBar(
        title: const Text("Sign In"),
        backgroundColor: const Color(0xFF232D3B),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(

                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/images/log.png"),
                //     fit: BoxFit.cover,
                //   ),
                // ),

                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Image.asset("assets/images/logo2.png",
                    width: 460, height: 215)),
            Container(
              //  color: Colors.white,
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email adresse",

                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.green,
                  ),

                  //hintStyle: TextStyle(color: Colors.white),
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
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                    color: Colors.green,
                  ),
                ),
                onSaved: (String? value) {
                  _password = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Le mot de passe ne doit pas etre vide";
                  } else if (value.length < 5) {
                    return "Le mot de passe doit avoir au moins 5 caractères";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text("Sing In"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                      Map<String, String> headers = {
                        "Content-Type": "application/json"
                      };
                      Map<String, String> body = {
                        "username": _username!,
                        "password": _password!
                      };
                      Navigator.pushNamed(context, "/buypage");

                      // http
                      //     .post(Uri.parse("http://127.0.0.1:9090/user/signin"),
                      //         headers: headers, body: jsonEncode(body))
                      //     .then((http.Response response) async {
                      //   if (response.statusCode == 200) {
                      //     Map<String, dynamic> userData =
                      //         jsonDecode(response.body);

                      //     //METHODE SHQRED PREF
                      //     SharedPreferences prefs =
                      //         await SharedPreferences.getInstance();
                      //     prefs.setString("userId", userData["_id"]);

                      //     //METHODE SQFLite

                      //     // Database database = await openDatabase(
                      //     //     join(await getDatabasesPath(),
                      //     //         "gstore_esprit_database.db"),
                      //     //     onCreate: (Database db, int version) {
                      //     //   db.transaction((Transaction txn) async {
                      //     //     await txn.execute(
                      //     //         "CREATE TABLE users (_id TEXT PRIMARY KEY, username TEXT, address TEXT, wallet INTEGER)");
                      //     //     await txn.execute(
                      //     //         "CREATE TABLE baskets (_id TEXT PRIMARY KEY, image TEXT, price INTEGER)");
                      //     //   });
                      //     // }, version: 1);

                      //     // await database.insert("users", userData,
                      //     //     conflictAlgorithm: ConflictAlgorithm.replace);

                      //     //TEST
                      //     // print(prefs.getString("userId"));
                      //     // List<Map<String, dynamic>> listUsers =
                      //     //     await database.query("users");
                      //     // print(listUsers);

                      //     Navigator.pushReplacementNamed(context, "/home");
                      //     // print("success");
                      //   } else {
                      //     print(response.body);
                      //     showDialog(
                      //         context: context,
                      //         builder: (context) {
                      //           return const AlertDialog(
                      //             content: Text("Username/password incorrect"),
                      //           );
                      //         });
                      //   }
                      // });
                    }
                  },
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text("Sign Up"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Forget Password ?"),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text("Cliquez ici",
                        style: TextStyle(color: Colors.green)),
                    onTap: () {
                      Navigator.pushNamed(context, "/resetPwd");
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
