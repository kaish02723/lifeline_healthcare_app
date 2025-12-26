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

      totalAmount: data['total_amount']?.toString(),
      paymentStatus: data['payment_status'],
      orderStatus: data['order_status'],

      orderedAt:
          data['ordered_at'] != null
              ? DateTime.parse(data['ordered_at'])
              : null,

      deliveryDate:
          data['delivery_date'] != null
              ? DateTime.parse(data['delivery_date'])
              : null,

      rating:
          data['rating'] == null
              ? null
              : double.parse(data['rating'].toString()),

      review: data['review'],

      updatedAt:
          data['updated_at'] != null
              ? DateTime.parse(data['updated_at'])
              : null,

      cancelReason: data['cancel_reason'],

      cancelledAt:
          data['cancelled_at'] != null
              ? DateTime.parse(data['cancelled_at'])
              : null,
    );
  }
}
