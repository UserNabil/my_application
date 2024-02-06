class TransactionResponse {
  bool isIZIAuthenticated;
  bool isIZIAuthorized;
  bool isSuccess;

  TransactionResponse({
    required this.isIZIAuthenticated,
    required this.isIZIAuthorized,
    this.isSuccess = false,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    bool isIZIAuthenticated = json['Data']?['IsIZIAuthenticated'] ??
        json['IsIZIAuthenticated'] ??
        false;
    bool isIZIAuthorized =
        json['Data']?['IsIZIAuthorized'] ?? json['IsIZIAuthorized'] ?? false;

    bool isSuccess = json['Data']?['IsSuccess'] ?? json['IsSuccess'] ?? false;

    return TransactionResponse(
      isIZIAuthenticated: isIZIAuthenticated,
      isIZIAuthorized: isIZIAuthorized,
      isSuccess: isSuccess,
    );
  }
}
