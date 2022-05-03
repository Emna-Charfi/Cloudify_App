import 'dart:convert';

import 'dart:io' show Platform;
import 'package:cloudify_application/home.dart';
import 'package:cloudify_application/pages/authentication.dart';
import 'package:cloudify_application/pages/secretvault_screen.dart';
import 'package:cloudify_application/pages/signin_page.dart';
import 'package:cloudify_application/providers/user.dart';
import 'package:cloudify_application/util/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String? _username = "";
  late String? _password = "";
  static bool btnLog = false;

  final LocalAuthentication auth = LocalAuthentication();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  bool userHasTouchId = false;
  String email = "", password = "";
  bool _useTouchId = false;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getSecureStorage();
    btnLog = false;
  }

  void getSecureStorage() async {
    final isUsingBio = await storage.read(key: 'usingBiometric');
    setState(() {
      userHasTouchId = isUsingBio == 'true';
    });
  }

  // Map<String, String> _authData = {
  //   'username': '',
  //   'password': '',
  // };
  // var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Users>(context);
    signIn(String em, String pw) {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8"
      };
      Map<String, dynamic> body = {'username': em, 'password': pw};
      //  Navigator.pushNamed(context, "/buypage");

      http
          .post(
        Uri.http(api_keyM, "login"),
        headers: headers,
        body: json.encode(body),
      )
          .then((http.Response response) async {
        if (response.statusCode == 200) {
          Map<String, dynamic> userData = jsonDecode(response.body);

          //METHODE SHQRED PREF
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("ID", userData['user']['_id'].toString());
          prefs.setString("USERNAME", userData['user']['username'].toString());
          prefs.setString("EMAIL", userData['user']['email'].toString());
          prefs.setString("TOKEN", userData['token'].toString());
          prefs.setString("AVATAR", userData['user']['avatar'].toString());
          //    userData["username"].toString());
          print("username of userData");
          print(userData);
          print("Token " + userData['token']);
          print(userData['user']['email'].toString());

          print("****AVATAR******" + userData['user']['avatar'].toString());

          print("id in lognin" + userData['user']['_id'].toString());

          userProvider.addUser(new User(
              id: userData['user']['id'].toString(),
              username: userData['user']['username'].toString(),
              email: userData['user']['email'].toString(),
              token: userData['token'].toString()));

          //Navigator.pushReplacementNamed(context, "/home");

          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) {
          //   return SignedInPage(
          //     user: userData,
          //     wantsTouchId: _useTouchId,
          //     password: password,
          //   );
          // }));
          // print("success");

          if (btnLog) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    SecretVaultScreen(userName: em, password: pw),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          }
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

    // void authenticate() async {
    //   final canCheck = await auth.canCheckBiometrics;

    //   if (canCheck) {
    //     List<BiometricType> availableBiometrics =
    //         await auth.getAvailableBiometrics();

    //     if (Platform.isAndroid) {
    //       if (availableBiometrics.contains(BiometricType.face)) {
    //         // Face ID.
    //         final authenticated = await auth.authenticate(
    //             localizedReason: 'Enable Face ID to sign in more easily');
    //         if (authenticated) {
    //           final userStoredEmail = await storage.read(key: 'email');
    //           final userStoredPassword = await storage.read(key: 'password');

    //           signIn(userStoredEmail!, userStoredPassword!);
    //         }
    //       } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
    //         // Touch ID.
    //       }
    //     }
    //   } else {
    //     print('cant check');
    //   }
    // }

    Future<bool> authentication() async {
      final LocalAuthentication localAuthentication = LocalAuthentication();
      bool isBiometricSupported = await localAuthentication.isDeviceSupported();
      bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

      bool isAuthenticated = false;

      if (isBiometricSupported && canCheckBiometrics) {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'Please complete the biometrics to proceed.',
          biometricOnly: true,
        );
        final userStoredEmail = await storage.read(key: 'email');
        final userStoredPassword = await storage.read(key: 'password');

        print("****the username is**BA :" + userStoredEmail!);
        print("the psw is *****BA" + userStoredPassword!);
        signIn(userStoredEmail.toString(), userStoredPassword.toString());
      }

      return isAuthenticated;
    }

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
                  } else if (value.length < 3) {
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
                  } else if (value.length < 2) {
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
                      setState(() {
                        btnLog = true;
                      });
                      signIn(_username!, _password!);
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
            ),
            SizedBox(
              height: 20.0,
            ),
            userHasTouchId
                ? InkWell(
                    onTap: () => {authentication()},
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.purple,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          FontAwesomeIcons.fingerprint,
                          size: 30,
                        )),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.orange,
                        value: _useTouchId,
                        onChanged: (newValue) {
                          setState(() {
                            _useTouchId = newValue!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Use Touch ID',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // Future<void> _submit() async {
  //   try {
  //     await Provider.of<Auth>(context, listen: false).login(
  //       _authData['username']!,
  //       _authData['password']!,
  //     );
  //   } on HttpException catch (error) {
  //     var errorMessage = 'Authentication failed';
  //     if (error.toString().contains('EMAIL_EXISTS')) {
  //       errorMessage = 'This email address is already in use.';
  //     } else if (error.toString().contains('INVALID_EMAIL')) {
  //       errorMessage = 'This is not a valid email address';
  //     } else if (error.toString().contains('WEAK_PASSWORD')) {
  //       errorMessage = 'This password is too weak.';
  //     } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
  //       errorMessage = 'Could not find a user with that email.';
  //     } else if (error.toString().contains('INVALID_PASSWORD')) {
  //       errorMessage = 'Invalid password.';
  //     }
  //     _showErrorDialog(errorMessage);
  //   } catch (error) {
  //     const errorMessage =
  //         'Could not authenticate you. Please try again later.';
  //     _showErrorDialog(errorMessage);
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text('An Error Occurred!'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
//   void log() async {
//     List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

// if (Platform.isIOS) {
//     if (availableBiometrics.contains(BiometricType.face)) {
//         // Face ID.
//     } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
//         // Touch ID.
//     }
// }
//   }

}
