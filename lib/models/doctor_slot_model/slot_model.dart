class SlotModel {
  bool? success;
  bool? generated;
  List<SlotDataModel>? slots;

  SlotModel(this.success, this.generated, this.slots);

  static SlotModel convertToModel(Map<String, dynamic> data) {
    return SlotModel(
      data['success'],
      data['generated'],
      (data['slots'] as List)
          .map((e) => SlotDataModel.convertToModel(e))
          .toList(),
    );
  }
}

class SlotDataModel {
  int? id;
  int? doctorId;
  String? date;
  String? start_time;
  String? end_time;
  String? slot_type;
  String? is_avaiable;
  String? createdAt;
  String? UpdatedAt;
  String? status;
  String? slot_duration;

  SlotDataModel(
    this.id,
    this.doctorId,
    this.date,
    this.start_time,
    this.end_time,
    this.slot_type,
    this.is_avaiable,
    this.createdAt,
    this.UpdatedAt,
    this.status,
    this.slot_duration,
  );

  static SlotDataModel convertToModel(Map<String, dynamic> apiData) {
    return SlotDataModel(
      apiData['id'],
      apiData['doctor_id'],
      apiData['date'],
      apiData['start_time'],
      apiData['end_time'],
      apiData['slot_type'],
      apiData['is_available'].toString(),
      apiData['created_at'],
      apiData['updated_at'],
      apiData['status'],
      apiData['slot_duration'].toString(),
    );
  }
}
