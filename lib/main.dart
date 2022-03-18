import 'package:cloudify_application/game.dart';
import 'package:cloudify_application/home.dart';
import 'package:cloudify_application/home_page.dart';
import 'package:cloudify_application/pages/BuyPage.dart';
import 'package:cloudify_application/pages/ChangeAddressScreen.dart';
import 'package:cloudify_application/pages/ProfilePage.dart';
import 'package:cloudify_application/pages/chekout.dart';
import 'package:cloudify_application/pages/order_sceen.dart';
import 'package:cloudify_application/panier.dart';
import 'package:cloudify_application/providers/cart.dart';
import 'package:cloudify_application/providers/games.dart';
import 'package:cloudify_application/providers/orders.dart';
import 'package:cloudify_application/reset_password.dart';
import 'package:cloudify_application/resetpassword.dart';
import 'package:cloudify_application/signin.dart';
import 'package:cloudify_application/signup.dart';
import 'package:cloudify_application/splash_screen.dart';
import 'package:cloudify_application/store.dart';
import 'package:cloudify_application/widgets/drawer/app_drawer.dart';
import 'package:cloudify_application/widgets/drower_screen.dart';
import 'package:cloudify_application/widgets/freegame.dart';
import 'package:cloudify_application/widgets/paidgames.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Games(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Cloudify',
        routes: {
          "/": (BuildContext context) {
            return const SplashScreen();
            //return DrawerApp();
          },
          "/resetPwd": (BuildContext context) {
            return const ResetPassword();
          },
          "/resetP": (BuildContext context) {
            return const ResetP();
          },
          "/home": (BuildContext context) {
            return const Home();
          },
          "/home/homePage": (BuildContext context) {
            return const HomePage();
          },
          "/signup": (BuildContext context) {
            return const SignUp();
          },
          "/signin": (BuildContext context) {
            return const SignIn();
          },
          "/home/games": (BuildContext context) {
            return const Game();
          },
          "/home/games/paidgames": (BuildContext context) {
            return const PaidGame();
          },
          "/home/games/freegames": (BuildContext context) {
            return const FreeGame();
          },
          "/home/store": (BuildContext context) {
            return const Store();
          },
          "/home/panier": (BuildContext context) {
            return const Panier();
          },
          "/home/profil": (BuildContext context) {
            return const ProfilePage();
          },
          "/buypage": (BuildContext context) {
            return BuyPage();
          },
          "/checkout": (BuildContext context) {
            return CheckoutScreen();
          },
          "/changeAddressScreen": (BuildContext context) {
            return ChangeAddressScreen();
          },
          "/order": (BuildContext context) {
            return OrdersScreen();
          },
          "/drwerscreen": (BuildContext context) {
            return DrowerScreen();
          },
        },
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
