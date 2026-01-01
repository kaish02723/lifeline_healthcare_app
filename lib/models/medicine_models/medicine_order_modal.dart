class MedicineOrderModal {
  int? orderId;
  String? orderCode;
  int? userId;
  double? totalAmount;
  String? paymentStatus;
  String? orderStatus;
  DateTime? orderedAt;
  DateTime? deliveryDate;
  double? rating;
  String? review;
  DateTime? updatedAt;
  String? cancelReason;
  DateTime? cancelledAt;
  String? paymentId;

  List<MedicineOrderItem>? items;

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
    this.paymentId,
    this.items,
  });

  factory MedicineOrderModal.fromJson(Map<String, dynamic> data) {
    return MedicineOrderModal(
      orderId: data['order_id'],
      orderCode: data['order_code'],
      userId: data['user_id'],

      totalAmount:
          data['total_amount'] != null
              ? double.parse(data['total_amount'].toString())
              : null,

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
          data['rating'] != null
              ? double.tryParse(data['rating'].toString())
              : null,

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

      paymentId: data['payment_id'],

      items:
          data['items'] != null
              ? (data['items'] as List)
                  .map((e) => MedicineOrderItem.fromJson(e))
                  .toList()
              : [],
    );
  }
}

class MedicineOrderItem {
  int? id;
  int? orderId;
  int? medicineId;
  String? name;
  double? price;
  int? quantity;
  String? image;

  MedicineOrderItem({
    this.id,
    this.orderId,
    this.medicineId,
    this.name,
    this.price,
    this.quantity,
    this.image,
  });

  factory MedicineOrderItem.fromJson(Map<String, dynamic> json) {
    return MedicineOrderItem(
      id: json['id'],
      orderId: json['order_id'],
      medicineId: json['medicine_id'],
      name: json['name'],
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      quantity: json['quantity'],
      image: json['image'],
    );
  }
}
