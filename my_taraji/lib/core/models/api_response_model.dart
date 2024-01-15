class APIResponseModel<T> {
  T? data;
  bool isSuccess;

  APIResponseModel({
    this.data,
    this.isSuccess = false,
  });

  factory APIResponseModel.fromJson(
      Map<String, dynamic> json, Function fromJsonT) {
    return APIResponseModel(
      data: json['Data'] != null ? fromJsonT(json['Data']) : null,
      isSuccess: json['IsSuccess'] ?? false,
    );
  }
}
