class DoctorModel {
  int? id;
  String? name;
  String? image;
  String? experience;
  String? fee;
  String? hospital;
  String? speciality;
  double? rating;
  int? totalConsult;
  List<String>? qualification;
  DoctorTimingDataModel? timing;

  DoctorModel({
    this.id,
    this.name,
    this.image,
    this.experience,
    this.fee,
    this.hospital,
    this.speciality,
    this.rating,
    this.totalConsult,
    this.qualification,
    this.timing,
  });

  /// API → Model
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      experience: json['experience'],
      fee: json['fee'],
      hospital: json['hospital'],
      speciality: json['speciality'],
      rating: (json['rating'] as num?)?.toDouble(),
      totalConsult: json['total_consult'],
      qualification: json['qualification'] != null
          ? List<String>.from(json['qualification'])
          : [],
      timing: json['timing'] != null
          ? DoctorTimingDataModel.fromJson(json['timing'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "experience": experience,
      "fee": fee,
      "hospital": hospital,
      "speciality": speciality,
      "rating": rating,
      "total_consult": totalConsult,
      "qualification": qualification,
      "timing": timing?.toJson(),
    };
  }
}


class DoctorTimingDataModel {
  String? start;
  String? end;
  String? day;

  DoctorTimingDataModel({
    this.start,
    this.end,
    this.day,
  });

  factory DoctorTimingDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorTimingDataModel(
      start: json['start'],
      end: json['end'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "start": start,
      "end": end,
      "day": day,
    };
  }
}

