import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/product_dummy_data.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items {
    return [..._items]; // copy, not reference
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  void addProduct(Product product) {
    _items.add(Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl));
    notifyListeners();
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
