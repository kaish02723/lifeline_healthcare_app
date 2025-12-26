import 'medicine_product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice =>
      (product.medPrice ?? 0).toDouble() * quantity;
}
