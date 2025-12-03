class PopularTestModel {
  String? message;
  List<TestDataModel>? data;

  PopularTestModel(this.message, this.data);

  static PopularTestModel convertToModel(Map<String, dynamic> apiData) {
    return PopularTestModel(
      apiData['message'],
      (apiData['data'] as List)
          .map((e) => TestDataModel.convertToModel(e))
          .toList(),
    );
  }
}

class TestDataModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? currency;
  String? category;
  String? preparation;

  TestDataModel(
    this.id,
    this.name,
    this.description,
    this.price,
    this.currency,
    this.category,
    this.preparation,
  );

  static TestDataModel convertToModel(Map<String, dynamic> data) {
    return TestDataModel(
      data['id'],
      data['name'],
      data['description'],
      data['price'],
      data['currency'],
      data['category'],
      data['preparation'],
    );
  }
}
