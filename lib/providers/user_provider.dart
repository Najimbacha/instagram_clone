import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
import 'package:instagram_clone/models/user.dart' as model;

class UserProvider with ChangeNotifier {
  model.User? _users;

  final AuthMetod _authMetod = AuthMetod();

  model.User get getUser => _users!;

  Future<void> refreshUser() async {
    model.User? user = await _authMetod.getUserDetail();

    _users = user;
    notifyListeners();
  }
}
