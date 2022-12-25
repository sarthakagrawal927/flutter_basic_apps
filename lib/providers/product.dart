import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool isFav) {
    isFavorite = isFav;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final updateUrl = Uri.parse(
        'https://shop-app-test-fc197-default-rtdb.firebaseio.com/products/${id}.json');
    final oldStatus = isFavorite;
    try {
      _setFavValue(!isFavorite);
      await http.patch(updateUrl,
          body: json.encode({'isFavorite': isFavorite}));
    } catch (err) {
      _setFavValue(oldStatus);
    }
  }
}
