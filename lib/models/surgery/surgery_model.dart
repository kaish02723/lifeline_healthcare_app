class BookSurgeryModel {
  int? user_Id;
  String? name;
  String? phone_no;
  String? surgery_type;
  String? status;
  String? description;
  String? booked_At;

  BookSurgeryModel({
    this.user_Id,
    this.name,
    this.phone_no,
    this.surgery_type,
    this.status,
    this.description,
    this.booked_At
  });

  static BookSurgeryModel jsonToModal(Map<String, dynamic> data) {
    return BookSurgeryModel(
      user_Id: data["user_Id"],
      name: data["name"],
      phone_no: data["phone_no"],
      surgery_type: data["surgery_type"],
      status: data["status"],
      description: data["description"],
      booked_At: data["booked_at"]
    );
  }
}