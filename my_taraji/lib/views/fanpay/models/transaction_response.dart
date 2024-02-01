class TransactionResponse {
  bool isIZIAuthenticated;
  bool isIZIAuthorized;

  TransactionResponse({
    required this.isIZIAuthenticated,
    required this.isIZIAuthorized,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    bool isIZIAuthenticated = json['Data']?['IsIZIAuthenticated'] ??
        json['IsIZIAuthenticated'] ??
        false;
    bool isIZIAuthorized =
        json['Data']?['IsIZIAuthorized'] ?? json['IsIZIAuthorized'] ?? false;

    return TransactionResponse(
      isIZIAuthenticated: isIZIAuthenticated,
      isIZIAuthorized: isIZIAuthorized,
    );
  }
}
