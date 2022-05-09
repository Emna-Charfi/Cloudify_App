import 'package:cloudify_application/model/http_exception.dart';
import 'package:cloudify_application/providers/auth.dart';
import 'package:cloudify_application/util/api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

import 'package:provider/provider.dart';

import "package:http/http.dart" as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String? _username;
  late String? _email;
  late String? _pwd;
  late String? _birth;
  Map<String, String> _authData = {
    'username': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232D3B),
      appBar: AppBar(
        title: const Text("Sing Up"),
        backgroundColor: const Color(0xFF232D3B),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Image.asset("assets/images/logo2.png",
                    width: 460, height: 215)),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                  _authData['username'] = value!;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return "Le Username doit avoir au moins 5 caractères !";
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
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
                onSaved: (String? value) {
                  _email = value;
                  _authData['email'] = value!;
                },
                validator: (String? value) {
                  RegExp regex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value!.isEmpty || !regex.hasMatch(value)) {
                    return "L'adresse email n'est pas valide !";
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
                  labelText: "Mot de passe",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
                onSaved: (String? value) {
                  _pwd = value;
                  _authData['password'] = _pwd!;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return "Le mot de passe doit avoir au moins 5 caractères !";
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Age",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
                onSaved: (String? value) {
                  _birth = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || int.parse(value) > 2021) {
                    return "L'année de naissance est invalide !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Sign Up"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      String message = "Username : " +
                          _username! +
                          "\n" +
                          "Email : " +
                          _email! +
                          "\n" +
                          "Mot de passe : " +
                          _pwd! +
                          "\n" +
                          "Année de naissance : " +
                          _birth!;

                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: const Text("Informations"),
                      //       content: Text(message),
                      //     );
                      //   },
                      // );

                      Map<String, dynamic> userData = {
                        "username": _username!,
                        "email": _email!,
                        'password': _pwd!,
                      };
                      print(userData.toString());
                      print(userData["email"].toString());
                      print(userData["password"].toString());

                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8"
                      };

                      http
                          .post(
                        Uri.http(api_keyM, "/register"),
                        //Uri.http("10.0.2.2:3000", "/register"),
                        headers: headers,
                        body: json.encode(userData),
                      )
                          .then((http.Response response) {
                        if (response.statusCode == 200) {
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

                          Navigator.pushNamed(context, "/signin");
                        } else if (response.statusCode == 402) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Information"),
                                content: Text("Email already exists"),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Information"),
                                content: Text("There's a problem"),
                              );
                            },
                          );
                        }
                      });

                      // try {
                      //   await Provider.of<Auth>(context, listen: false).signup(
                      //     _authData['username']!,
                      //     _authData['email']!,
                      //     _authData['password']!,
                      //   );
                      // } on HttpException catch (error) {
                      //   var errorMessage = 'Authentication failed';
                      //   if (error.toString().contains('EMAIL_EXISTS')) {
                      //     errorMessage =
                      //         'This email address is already in use.';
                      //   } else if (error.toString().contains('INVALID_EMAIL')) {
                      //     errorMessage = 'This is not a valid email address';
                      //   } else if (error.toString().contains('WEAK_PASSWORD')) {
                      //     errorMessage = 'This password is too weak.';
                      //   } else if (error
                      //       .toString()
                      //       .contains('EMAIL_NOT_FOUND')) {
                      //     errorMessage =
                      //         'Could not find a user with that email.';
                      //   } else if (error
                      //       .toString()
                      //       .contains('INVALID_PASSWORD')) {
                      //     errorMessage = 'Invalid password.';
                      //   }
                      //   _showErrorDialog(errorMessage);
                      // } catch (error) {
                      //   const errorMessage =
                      //       'Could not authenticate you. Please try again later.';
                      //   _showErrorDialog(errorMessage);
                      // }

                      // setState(() {
                      //   _isLoading = false;
                      // });
                    }
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  child: const Text("Cancel"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    _formKey.currentState!.reset();
                    Navigator.pushReplacementNamed(context, "/");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _launchURL() async {
    const _url = api_key;
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
