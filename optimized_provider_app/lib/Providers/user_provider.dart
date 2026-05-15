import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String name = 'Fazal';

  // Method for change name
  void changeName(String newName) {
    name = newName;
    notifyListeners();
  }
}
