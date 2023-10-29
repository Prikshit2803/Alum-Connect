//import 'package:flutter/foundation.dart';

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_flutter/models/user.dart';
import 'package:insta_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  //? means nullable

  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();

    _user = user;

    notifyListeners(); //notify listeners that user value has changed
  }
}
