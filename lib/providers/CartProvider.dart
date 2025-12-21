import 'package:flutter/material.dart';

import '../core/utils/local_database/cart_db.dart';
import '../models/medicine/medicine_product_model.dart';
import 'medicine_provider/medicineCart_provider.dart';

class CartDataProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  bool isInCart(int productId) {
    return items.any((i) => i.product.medId == productId);
  }

  double get totalAmount => _items.fold(
    0,
        (sum, item) =>
    sum + (item.product.medPrice ?? 0) * item.quantity,
  );

  /// LOAD FROM DB (CALL IN initState)
  Future<void> loadCart() async {
    final data = await CartDB.getAll();
    _items =
        data
            .map(
              (e) => CartItem(
            product: ProductModel(
              medId: e['productId'],
              medName: e['name'],
              medPrice: e['price'],
              medImage: e['image'],
            ),
            quantity: e['quantity'],
          ),
        )
            .toList();

    notifyListeners();
  }

  /// ADD
  Future<void> addToCart(ProductModel product) async {
    final index =
    _items.indexWhere((i) => i.product.medId == product.medId);

    if (index >= 0) {
      _items[index].quantity++;
      await CartDB.updateQty(
        product.medId!,
        _items[index].quantity,
      );
    } else {
      _items.add(CartItem(product: product));
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

  /// INCREASE
  Future<void> increaseQuantity(int productId) async {
    final index =
    _items.indexWhere((i) => i.product.medId == productId);
    if (index == -1) return;

    _items[index].quantity++;
    await CartDB.updateQty(
      productId,
      _items[index].quantity,
    );
    notifyListeners();
  }

  /// DECREASE
  Future<void> decreaseQuantity(int productId) async {
    final index =
    _items.indexWhere((i) => i.product.medId == productId);
    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
      await CartDB.updateQty(
        productId,
        _items[index].quantity,
      );
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
