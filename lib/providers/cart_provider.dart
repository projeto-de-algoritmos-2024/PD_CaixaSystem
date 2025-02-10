import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];
  double _total = 0.0;

  List<Product> get cartItems => _cartItems;
  double get total => _total;

  void addProduct(Product product) {
    _cartItems.add(product);
    _total += product.price;
    notifyListeners();
  }

  void removeProduct(Product product) {
    _cartItems.remove(product);
    _total -= product.price;
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _total = 0.0;
    notifyListeners();
  }
}
