import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/product_dummy_data.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final url = Uri.parse(
    "https://shop-app-test-fc197-default-rtdb.firebaseio.com/products.json");

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items]; // copy, not reference
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          price: value['price'],
          description: value['description'],
          isFavorite: value['isFavorite'],
          imageUrl: value['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'imageUrl': product.imageUrl,
            'description': product.description,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
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
