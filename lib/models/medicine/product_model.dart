import 'dart:convert';

class ProductModel {
  int? medId;
  String? medName;
  String? medImage;
  String? medBrandName;
  int? medPrice;
  String? medRating;
  String? medType;
  String? medPackSize;
  String? medReturnPolicy;
  String? medDescription;
  String? medDiscountPercentage;
  String? medInformationManufacture;
  String? medKnowMore;

  /// IMPORTANT
  String? categoryString;
  Category? category;

  ProductModel({
    this.medId,
    this.medName,
    this.medImage,
    this.medBrandName,
    this.medPrice,
    this.medRating,
    this.medType,
    this.medPackSize,
    this.medReturnPolicy,
    this.medDescription,
    this.medDiscountPercentage,
    this.medInformationManufacture,
    this.medKnowMore,
    this.categoryString,
    this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final categoryStr = json["category"];

    return ProductModel(
      medId: json["med_id"],
      medName: json["med_name"],
      medImage: json["med_image"],
      medBrandName: json["med_brand_name"],
      medPrice: json["med_price"],
      medRating: json["med_rating"],
      medType: json["med_type"],
      medPackSize: json["med_pack_size"],
      medReturnPolicy: json["med_return_policy"],
      medDescription: json["med_description"],
      medDiscountPercentage: json["med_discount_percentage"],
      medInformationManufacture: json["med_information_manufacture"],
      medKnowMore: json["med_know_more"],

      categoryString: categoryStr,
      category: categoryValues.map[categoryStr],
    );
  }


  Map<String, dynamic> toJson() => {
    "med_id": medId,
    "med_name": medName,
    "med_image": medImage,
    "med_brand_name": medBrandName,
    "med_price": medPrice,
    "med_rating": medRating,
    "med_type": medType,
    "med_pack_size": medPackSize,
    "med_return_policy": medReturnPolicy,
    "med_description": medDescription,
    "med_discount_percentage": medDiscountPercentage,
    "med_information_manufacture": medInformationManufacture,
    "med_know_more": medKnowMore,
    "category": categoryValues.reverse[category],
  };
}

enum Category {
  babyCare,
  coldCough,
  fever,
  painRelief,
  skinCare,
  vitaminsSupplements,
  womenCare,
}

final categoryValues = EnumValues({
  "Baby Care": Category.babyCare,
  "Cold & Cough": Category.coldCough,
  "Fever": Category.fever,
  "Pain Relief": Category.painRelief,
  "Skin Care": Category.skinCare,
  "Vitamins & Supplements": Category.vitaminsSupplements,
  "Women Care": Category.womenCare,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
