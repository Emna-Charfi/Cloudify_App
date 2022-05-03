import 'package:cloudify_application/const/world_languages.dart';
import 'package:cloudify_application/game.dart';
import 'package:cloudify_application/home.dart';
import 'package:cloudify_application/home_page.dart';
import 'package:cloudify_application/pages/BuyPage.dart';
import 'package:cloudify_application/pages/ChangeAddressScreen.dart';
import 'package:cloudify_application/pages/ProfilePage.dart';
import 'package:cloudify_application/pages/chekout.dart';
import 'package:cloudify_application/pages/order_sceen.dart';
import 'package:cloudify_application/pages/secretvault_screen.dart';
import 'package:cloudify_application/pages/setting.dart';
import 'package:cloudify_application/panier.dart';

import 'package:cloudify_application/providers/cart.dart';
import 'package:cloudify_application/providers/games.dart';
import 'package:cloudify_application/providers/list_games.dart';
import 'package:cloudify_application/providers/orders.dart';
import 'package:cloudify_application/providers/user.dart';

import 'package:cloudify_application/reset_password.dart';
import 'package:cloudify_application/resetpassword.dart';
import 'package:cloudify_application/signin.dart';
import 'package:cloudify_application/signup.dart';
import 'package:cloudify_application/splash_screen.dart';
import 'package:cloudify_application/store.dart';
import 'package:cloudify_application/widgets/drower_screen.dart';
import 'package:cloudify_application/widgets/freegame.dart';
import 'package:cloudify_application/widgets/paidgames.dart';
import 'package:cloudify_application/widgets/web_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  Stripe.publishableKey =
      'pk_test_51Kn0qoBlWZdiLH02aBBjgcqtf8D2hiAWgY9jMGyhHnZViHgjE3jMEr81D41uOfOmMf6qWZhYxUzFlolIZuSQnwr900goTHKnwy';
  //runApp(const MyApp());
  runApp(GetMaterialApp(
    home: MyApp(),
    translations: WorldLanguage(), //Language class from world_languages.dart
    locale: Locale('en', 'US'), // translations will be displayed in that locale
    fallbackLocale: Locale('en',
        'US'), // specify the fallback locale in case an invalid locale is selected.
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Games(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => GamesList(),
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
            return ProfilePage();
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
          "/setting": (BuildContext context) {
            return Setting();
          },
          "/scren": (BuildContext context) {
            return SecretVaultScreen();
          },
          "/webview": (BuildContext context) {
            return WebViewD();
          },
        },
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
