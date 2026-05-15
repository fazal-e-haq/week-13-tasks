import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  String name;
  bool favorite = false;

  ProductModel(this.name);

  void toggleFavorite() {
    favorite = !favorite;
    notifyListeners();
  }
}
