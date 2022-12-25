import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
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
      final response = await http.post(url, body: getJSONObject(product));
      final newProduct = Product(
          id: json.decode(response.body)['name'], // name of the key
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    final prodIdx =
        _items.indexWhere((element) => (element.id == newProduct.id));
    if (prodIdx < 0) return;
    final updateUrl = Uri.parse(
        'https://shop-app-test-fc197-default-rtdb.firebaseio.com/products/${newProduct.id}.json');
    await http.patch(updateUrl, body: getJSONObject(newProduct));
    _items[prodIdx] = newProduct;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    final deleteUrl = Uri.parse(
        'https://shop-app-test-fc197-default-rtdb.firebaseio.com/products/$id.json');
    final resp = await http.delete(deleteUrl);
    if (resp.statusCode >= 400) {
      throw HttpException("Something went wrong").toString();
    } else
      _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}

String getJSONObject(Product product) {
  return json.encode({
    'title': product.title,
    'imageUrl': product.imageUrl,
    'description': product.description,
    'price': product.price,
    'isFavorite': product.isFavorite,
  });
}
