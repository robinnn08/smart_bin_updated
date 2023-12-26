import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? displayName;

  // void setDisplayName(String name) {
  //   displayName = name;
  //   notifyListeners();
  // }
  UserProvider() {
    // Load displayName from shared preferences when the provider is initialized
    _loadDisplayName();
  }

  void _loadDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('displayName');
    notifyListeners();
  }

  void setDisplayName(String name) async {
    displayName = name;
    notifyListeners();

    // Save displayName to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('displayName', name);
  }
}
