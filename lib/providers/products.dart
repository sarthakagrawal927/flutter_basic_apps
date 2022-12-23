import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/product_dummy_data.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items {
    return [..._items]; // copy, not reference
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> addProduct(Product product) {
    final url = Uri.parse(
        "https://shop-app-test-fc197-default-rtdb.firebaseio.com/products.json");
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'imageUrl': product.imageUrl,
              'description': product.description,
              'price': product.price,
              'isFavorite': product.isFavorite,
            }))
        .then((response) {
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    });
  }

  void updateProduct(Product newProduct) {
    final prodIdx =
        _items.indexWhere((element) => (element.id == newProduct.id));
    if (prodIdx < 0) return;
    _items[prodIdx] = newProduct;
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
