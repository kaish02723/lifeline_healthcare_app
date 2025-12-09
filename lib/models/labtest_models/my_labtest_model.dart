class MyLabTestModel {
  String? message;
  List<MyTestDataModel>? data;

  MyLabTestModel(this.message, this.data);

  static MyLabTestModel convertToModel(Map<String, dynamic> apiData) {
    return MyLabTestModel(
      apiData['message'],
      (apiData['data'] as List)
          .map((e) => MyTestDataModel.convertToModel(e))
          .toList(),
    );
  }
}

class MyTestDataModel {
  int? bookingid;
  int? user_id;
  String? user_name;
  String? test_name;
  String? category;
  String? phone;
  String? status;
  String? booking_date;
  String? testID;

  MyTestDataModel(
    this.bookingid,
    this.user_id,
    this.user_name,
    this.test_name,
    this.category,
    this.phone,
    this.status,
    this.booking_date,
    this.testID,
  );

  static MyTestDataModel convertToModel(Map<String, dynamic> apiData) {
    return MyTestDataModel(
      apiData['bookingid'],
      apiData['user_id'],
      apiData['user_name'],
      apiData['test_name'],
      apiData['category'],
      apiData['phone'],
      apiData['status'],
      apiData['booking_date'],
      apiData['testID'],
    );
  }
}
