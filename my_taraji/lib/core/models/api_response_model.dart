class APIResponseModel<T> {
  bool isSuccess;
  T? data;

  APIResponseModel({
    this.isSuccess = false,
    this.data,
  });

  factory APIResponseModel.fromJson(
      Map<String, dynamic> json, Function fromJsonT) {
    return APIResponseModel(
      isSuccess: json['IsSuccess'] ?? false,
      data: json['Data'] != null && json['IsSuccess']
          ? fromJsonT(json['Data'])
          : null,
    );
  }
}
