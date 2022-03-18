import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late String? _username;

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
                      Navigator.pushNamed(context, "/resetP");
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
