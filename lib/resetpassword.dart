import 'package:flutter/material.dart';

class ResetP extends StatefulWidget {
  const ResetP({Key? key}) : super(key: key);

  @override
  _ResetPState createState() => _ResetPState();
}

class _ResetPState extends State<ResetP> {
  late String? _pass1;
  late String? _pass2;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232D3B),
      appBar: AppBar(
        title: const Text("CLOUDIFY "),
        backgroundColor: const Color(0xFF232D3B),
        elevation: 4.0,
        actions: [
          // ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          //     textStyle: MaterialStateProperty.all(
          //       const TextStyle(fontSize: 15),
          //     ),
          //     overlayColor: MaterialStateProperty.all(Colors.green),
          //     // padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
          //     // minimumSize: MaterialStateProperty.all(const Size(2, 2)),
          //     fixedSize: MaterialStateProperty.all(const Size(110, 20)),
          //     shape: MaterialStateProperty.all(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(100),
          //       ),
          //     ),
          //   ),
          //   child: const Text("Connexion"),
          //   onPressed: () {
          //     Navigator.pushNamed(context, "/signin");
          //   },
          // ),
          IconButton(
            onPressed: () => {
              //SharedPreferences prefs = await SharedPreferences.getInstance();
              // await prefs.clear();
              Navigator.pushReplacementNamed(context, "/signin"),
            },
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 40, 20, 90),
                child: Image.asset("assets/images/logo2.png",
                    width: 460, height: 215)),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Password",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                    color: Colors.green,
                  ),
                ),
                onSaved: (String? value) {
                  _pass1 = value;
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
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                    color: Colors.green,
                  ),
                ),
                onSaved: (String? value) {
                  _pass2 = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Le mot de passe ne doit pas etre vide";
                  } else if (_pass2!.compareTo(_pass1!) == 0) {
                    return "You have to write the same Password";
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
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
