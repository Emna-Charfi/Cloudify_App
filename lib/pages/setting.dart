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
  primarySwatch: Colors.yellow,
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
              'Setting ',
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
            //backgroundColor: const Color(0xFF232D3B),
            title: Text("settings".tr),
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
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text("Setting"),
                  //         content: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Container(
                  //                 child: IconButton(
                  //               icon: Image.asset('assets/icons/tn.jpeg'),
                  //               iconSize: 50,
                  //               onPressed: () {
                  //                 var locale = Locale('ru', 'RU');
                  //                 Get.updateLocale(locale);
                  //               },
                  //             )),
                  //             Container(
                  //                 child: IconButton(
                  //               icon: Image.asset('assets/icons/fr.webp'),
                  //               iconSize: 50,
                  //               onPressed: () {
                  //                 var locale = Locale('es', 'ES');
                  //                 Get.updateLocale(locale);
                  //               },
                  //             )),
                  //             Container(
                  //                 child: IconButton(
                  //               icon: Image.asset('assets/icons/usa.webp'),
                  //               iconSize: 50,
                  //               onPressed: () {
                  //                 var locale = Locale('en', 'US');
                  //                 Get.updateLocale(locale);
                  //               },
                  //             )),
                  //           ],
                  //         ),
                  //         actions: [
                  //           FlatButton(
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: Text("Close")),
                  //         ],
                  //       );
                  //     });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
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
