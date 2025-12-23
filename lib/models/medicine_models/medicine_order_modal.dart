class MedicineOrderModal {
  int? orderId;
  String? orderCode;
  int? userId;
  String? totalAmount;
  String? paymentStatus;
  String? orderStatus;
  DateTime? orderedAt;
  DateTime? deliveryDate;
  double? rating;
  String? review;
  DateTime? updatedAt;
  String? cancelReason;
  DateTime? cancelledAt;

  MedicineOrderModal({
    this.orderId,
    this.orderCode,
    this.userId,
    this.totalAmount,
    this.paymentStatus,
    this.orderStatus,
    this.orderedAt,
    this.deliveryDate,
    this.rating,
    this.review,
    this.updatedAt,
    this.cancelReason,
    this.cancelledAt,
  });

  factory MedicineOrderModal.fromJson(Map<String, dynamic> data) {
    return MedicineOrderModal(
      orderId: data['order_id'],
      orderCode: data['order_code'],
      userId: data['user_id'],
      totalAmount: data['total_amount'],
      paymentStatus: data['payment_status'],
      orderStatus: data['order_status'],
      orderedAt: DateTime.parse(data['ordered_at']),
      deliveryDate: DateTime.parse(data['delivery_date']),
      rating: data['rating'] == null
          ? null
          : double.parse(data['rating'].toString()),
      review: data['review'],
      updatedAt: DateTime.parse(data['updated_at']),
      cancelReason: data['cancel_reason'],
      cancelledAt: data['cancelled_at'] == null
          ? null
          : DateTime.parse(data['cancelled_at']),
    );
  }
}

class OrderResponse {
  bool success;
  List<MedicineOrderModal> orders;

  OrderResponse({
    required this.success,
    required this.orders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json['success'],
      orders: List<MedicineOrderModal>.from(
        json['orders'].map(
              (x) => MedicineOrderModal.fromJson(x),
        ),
      ),
    );
  }
}
