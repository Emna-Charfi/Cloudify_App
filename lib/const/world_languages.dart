import 'package:get/get.dart';

class WorldLanguage extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'welcome': 'Welcome back!',
          'email': 'Hello @name, your email is @email',
          'settings': 'settings',
          'password': 'password'
        },

        'es_ES': {
          'sign': 'Content de te revoir!',
          'email': 'e-mail',
          'going': '¿Adónde vas?',
          'email1': 'Hola @name, tu correo electrónico es @email',
          'settings': 'parametres',
          'password': 'mot de passe'
        },

        'ru_RU': {
          'hello': 'Привет, как дела?',
          'email': 'البريد الإلكتروني',
          'going': 'Куда ты направляешься?',
          'settings': 'الإعدادات',
          'password': 'كلمه السر'
        }

        //add more language here
      };
}
