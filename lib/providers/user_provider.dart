import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
import 'package:instagram_clone/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _users;

  final AuthMetod _authMetod = AuthMetod();

  User get getUser => _users!;

  Future<void> refreshUser() async {
    User? user = await _authMetod.getUserDetail();

    _users = user;
    notifyListeners();
  }
}
