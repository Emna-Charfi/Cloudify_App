import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String? id;
  final String? username;
  final String? email;
  final String? token;

  User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.token,
  });
}

class Users with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;
  late Timer _authTimer;
  User _user = User(id: "", username: "", email: "", token: "");
  bool _state = false;
  User get users {
    return _user;
  }

  Future<void> getstate() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('USERNAME')!.isEmpty) {
      _state = false;
    }
    _state = true;
    User user = new User(
        id: prefs.getString('ID'),
        username: prefs.getString('USERNAME'),
        email: prefs.getString('EMAIL'),
        token: prefs.getString('TOKEN'));
    addUser(user);
  }

  bool getStat() {
    getstate();
    return _state;
  }

  void addUser(User user) {
    _user = user;
    _state = true;
    notifyListeners();
  }

  Future<void> Dec() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    _state = false;
    prefs.clear();
    getstate();
  }

  void RemoveUser() {
    _user = User(id: "", username: "", email: "", token: "");
    _state = false;
    Dec();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'].toString();
    _userId = extractedUserData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = "";
    _userId = "";

    if (_authTimer.isActive) {
      _authTimer.cancel();
      // _authTimer = null!;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer.isActive) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
