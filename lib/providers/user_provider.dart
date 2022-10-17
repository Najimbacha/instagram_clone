import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
import 'package:instagram_clone/models/user.dart' as model;

class UserProvider with ChangeNotifier {
  model.User? _user;

  final AuthMetod _authMetod = AuthMetod();

  model.User get getUser => _user!;

  Future<void> refreshUser() async {
    model.User user = await _authMetod.getUserDetail();

    _user = user;
    notifyListeners();
  }
}
