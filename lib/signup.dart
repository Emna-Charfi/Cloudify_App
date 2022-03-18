import 'package:flutter/material.dart';

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

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Informations"),
                            content: Text(message),
                          );
                        },
                      );
                      Navigator.pushNamed(context, "/signin");
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
}
