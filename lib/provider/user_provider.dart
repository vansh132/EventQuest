import 'package:event_quest/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    username: '',
    password: '',
    type: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
