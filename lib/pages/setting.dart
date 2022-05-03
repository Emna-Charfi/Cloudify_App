import 'package:cloudify_application/signin.dart';
import 'package:cloudify_application/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

bool _iconBool = false;
IconData _iconLight = Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;

ThemeData _lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
);
ThemeData _darkTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
);

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232D3B),
        elevation: 4.0,
        // leadingWidth: 0,
        title: Align(
            child: Text(
              'Shop Page ',
              // textAlign: Alignment.bottomLeft,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            alignment: Alignment.bottomLeft),
      ),
      drawer: DrawerS(),
      body: MaterialApp(
        theme: _iconBool ? _darkTheme : _lightTheme,
        home: Scaffold(
          appBar: AppBar(
            title: Text("settings".tr),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _iconBool = !_iconBool;
                  });
                },
                icon: Icon(_iconBool ? _iconDark : _iconLight),
              ),
            ],
          ),
          body: Row(
            children: [
              Container(
                  child: IconButton(
                icon: Image.asset('assets/icons/tn.jpeg'),
                iconSize: 50,
                onPressed: () {
                  var locale = Locale('ru', 'RU');
                  Get.updateLocale(locale);
                },
              )),
              Container(
                  child: IconButton(
                icon: Image.asset('assets/icons/fr.webp'),
                iconSize: 50,
                onPressed: () {
                  var locale = Locale('es', 'ES');
                  Get.updateLocale(locale);
                },
              )),
              Container(
                  child: IconButton(
                icon: Image.asset('assets/icons/usa.webp'),
                iconSize: 50,
                onPressed: () {
                  var locale = Locale('en', 'US');
                  Get.updateLocale(locale);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
