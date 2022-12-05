import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/product_dummy_data.dart';
import "../models/product.dart";
import 'package:provider/provider.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items {
    return [..._items]; // copy, not reference
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
