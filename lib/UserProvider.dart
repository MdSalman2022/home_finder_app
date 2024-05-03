import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this line

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners(); // Notify listeners when user changes
  }
}
