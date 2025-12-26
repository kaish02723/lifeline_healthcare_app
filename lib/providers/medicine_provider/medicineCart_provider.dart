import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../models/medicine_models/medicine_product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0;
    for (var item in _items.values) {
      total += (item.product.medPrice ?? 0) * item.quantity;
    }
    return total;
  }

  void addToCart(ProductModel product) {
    final id = product.medId!;

    if (_items.containsKey(id)) {
      _items[id]!.quantity++;
    } else {
      _items[id] = CartItem(product: product);
    }

    notifyListeners();
  }

  bool isInCart(int productId) {
    return items.any((item) => item.product.medId == productId);
  }

  void increaseQuantity(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
