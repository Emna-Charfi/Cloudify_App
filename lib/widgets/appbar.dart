import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("CLOUDIFY "),
      backgroundColor: const Color(0xFF232D3B),
      elevation: 4.0,
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 15),
            ),
            overlayColor: MaterialStateProperty.all(Colors.green),
            // padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
            // minimumSize: MaterialStateProperty.all(const Size(2, 2)),
            fixedSize: MaterialStateProperty.all(const Size(110, 20)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          child: const Text("Connexion"),
          onPressed: () {
            Navigator.pushNamed(context, "/signin");
          },
        ),
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
    );
  }
}
