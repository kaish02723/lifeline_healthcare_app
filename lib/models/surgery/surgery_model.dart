class BookSurgeryModel {
  int? requestId;
  int? user_Id;
  String? name;
  String? phone_no;
  String? surgery_type;
  String? status;
  String? description;
  String? cancelReason;
  String? createdAt;

  BookSurgeryModel({
    this.requestId,
    this.user_Id,
    this.name,
    this.phone_no,
    this.surgery_type,
    this.status,
    this.description,
    this.cancelReason,
    this.createdAt
  });

  static BookSurgeryModel jsonToModal(Map<String, dynamic> data) {
    return BookSurgeryModel(
      requestId: data["request_id"],
      user_Id: data["user_id"],
      name: data["patient_name"],
      phone_no: data["phone_no"],
      surgery_type: data["surgery_type"],
      status: data["status"],
      description: data["description"],
      cancelReason: data["cancel_reason"],
      createdAt: data["created_at"]
    );
  }
}