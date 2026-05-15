import 'package:flutter/material.dart';
import 'package:optimized_provider_app/Models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> products = [];
  bool loading = false;
  int page = 0;

  // Method for load products in list
  Future<void> loadProduct() async {
    if (loading) return;

    loading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));
    // Add items in list
    products.addAll(
      List.generate(10, (index) => ProductModel('Item ${page * 10 + index}')),
    );
    page++;
    loading = false;
    notifyListeners();
  }
}
