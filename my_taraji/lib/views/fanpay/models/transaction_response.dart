class TransactionResponse {
  String message;
  bool isSuccess;
  bool isIZIAuthenticated;
  bool isIZIAuthorized;

  TransactionResponse({
    required this.message,
    required this.isSuccess,
    required this.isIZIAuthenticated,
    required this.isIZIAuthorized,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    String message = json['Message'] ?? json['message'] ?? "";
    bool isSuccess = json['IsSuccess'] ??= json['isSuccess'] ?? false;
    bool isIZIAuthenticated =
        json['IsIZIAuthenticated'] ?? json['isIZIAuthenticated'] ?? false;
    bool isIZIAuthorized =
        json['IsIZIAuthorized'] ?? json['isIZIAuthorized'] ?? false;

    return TransactionResponse(
      message: message,
      isSuccess: isSuccess,
      isIZIAuthenticated: isIZIAuthenticated,
      isIZIAuthorized: isIZIAuthorized,
    );
  }
}
