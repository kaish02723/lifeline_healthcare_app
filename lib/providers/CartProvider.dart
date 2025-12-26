import 'package:flutter/material.dart';

import '../services/cart_db.dart';
import '../models/medicine_models/cart_item_model.dart';
import '../models/medicine_models/medicine_product_model.dart';

class CartDataProvider with ChangeNotifier {
  List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  bool isInCart(int productId) {
    return items.any((i) => i.product.medId == productId);
  }

  double get totalAmount => _items.fold(
    0.0,
    (sum, item) => sum + (item.product.medPrice ?? 0.0) * item.quantity,
  );

  Future<void> loadCart() async {
    final data = await CartDB.getAll();

    _items =
        data.map((e) {
          return CartItemModel(
            product: ProductModel(
              medId: e['productId'] as int,
              medName: e['name'] as String,
              medImage: e['image'] as String?,
              medPrice: (e['price'] as num).toInt(), // FIX
            ),
            quantity: e['quantity'] as int,
          );
        }).toList();

    notifyListeners();
  }

  /// ADD
  Future<void> addToCart(ProductModel product) async {
    final index = _items.indexWhere((i) => i.product.medId == product.medId);

    if (index >= 0) {
      _items[index].quantity++;
      await CartDB.updateQty(product.medId!, _items[index].quantity);
    } else {
      _items.add(CartItemModel(product: product));
      await CartDB.insert({
        'productId': product.medId,
        'name': product.medName,
        'price': product.medPrice,
        'image': product.medImage,
        'quantity': 1,
      });
    }

    notifyListeners();
  }

  Future<void> increaseQuantity(int productId) async {
    final index = _items.indexWhere((i) => i.product.medId == productId);
    if (index == -1) return;

    _items[index].quantity++;
    await CartDB.updateQty(productId, _items[index].quantity);
    notifyListeners();
  }

  /// DECREASE
  Future<void> decreaseQuantity(int productId) async {
    final index = _items.indexWhere((i) => i.product.medId == productId);
    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
      await CartDB.updateQty(productId, _items[index].quantity);
    } else {
      _items.removeAt(index);
      await CartDB.delete(productId);
    }

    notifyListeners();
  }

  Future<void> clearCart() async {
    _items.clear();
    await CartDB.clear();
    notifyListeners();
  }
}
