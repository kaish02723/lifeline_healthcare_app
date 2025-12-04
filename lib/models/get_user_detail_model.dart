class GetUserDetailModel {
  String? message;
  UserDataModel? user;

  GetUserDetailModel({this.message, this.user});

  static GetUserDetailModel fromJson(Map<String, dynamic> json) {
    return GetUserDetailModel(
      message: json["message"],
      user: json["user"] != null ? UserDataModel.fromJson(json["user"]) : null,
    );
  }
}

class UserDataModel {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? roleSpecificData;
  String? picture;

  UserDataModel({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.roleSpecificData,
    this.picture,
  });

  static UserDataModel fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      email: json["email"],
      gender: json["gender"],
      dateOfBirth: json["date_of_birth"],
      address: json["address"],
      roleSpecificData: json["role_specific_data"],
      picture: json["picture"],
    );
  }
}
