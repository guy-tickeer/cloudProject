import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  bool isAdmin;

  User({
    this.isAdmin = false,
  });

  void changeAdmin() {
    isAdmin = !isAdmin;
    notifyListeners();
  }
}