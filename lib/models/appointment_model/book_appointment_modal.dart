import 'dart:core';

class BookAppointmentModal {
  int? id;
  int? doctor_id;
  int? user_id;
  int? slot_id;
  int? hospital_id;
  String? status;
  String? payment_status;
  String? created_at;
  String? updated_at;
  String? cancle_reason;
  int? payment_id;
  String? dr_name;
  String? slot_date;
  String? start_time;
  String? end_time;

  BookAppointmentModal(
    this.id,
    this.doctor_id,
    this.user_id,
    this.slot_id,
    this.hospital_id,
    this.status,
    this.payment_status,
    this.created_at,
    this.updated_at,
    this.cancle_reason,
    this.payment_id,
    this.dr_name,
    this.slot_date,
    this.start_time,
    this.end_time,
  );

  static BookAppointmentModal convertToModel(Map<String, dynamic> ApiData) {
    return BookAppointmentModal(
      ApiData['id'],
      ApiData['doctor_id'],
      ApiData['user_id'],
      ApiData['slot_id'],
      ApiData['hospital_id'],
      ApiData['status'],
      ApiData['payment_status'],
      ApiData['created_at'],
      ApiData['updated_at'],
      ApiData['cancle_reason'],
      ApiData['payment_id'],
      ApiData['dr_name'],
      ApiData['slot_date'],
      ApiData['start_time'],
      ApiData['end_time'],
    );
  }
}
