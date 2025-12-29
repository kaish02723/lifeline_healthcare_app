class BookAppointmentModal {
  int? id;
  int? doctorId;
  int? userId;
  int? slotId;
  int? hospitalId;
  String? status;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  String? cancelReason;
  int? paymentId;
  int? cancelledAt;
  String? drName;
  String? slotDate;
  String? startTime;
  String? endTime;

  BookAppointmentModal({
    this.id,
    this.doctorId,
    this.userId,
    this.slotId,
    this.hospitalId,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.cancelReason,
    this.paymentId,
    this.cancelledAt,
    this.drName,
    this.slotDate,
    this.startTime,
    this.endTime,
  });

  factory BookAppointmentModal.convertToModel(Map<String, dynamic> json) {
    return BookAppointmentModal(
      id: json['id'],
      doctorId: json['doctor_id'],
      userId: json['user_id'],
      slotId: json['slot_id'],
      hospitalId: json['hospital_id'],
      status: json['status'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      cancelReason: json['cancel_reason'] ?? '',
      paymentId: json['payment_id'],
      cancelledAt: json['Cancelled_at'],
      drName: json['dr_name'] ?? '',
      slotDate: json['slot_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
