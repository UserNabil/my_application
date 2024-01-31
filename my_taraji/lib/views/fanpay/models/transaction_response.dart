import 'package:my_taraji/views/fanpay/imports.dart';

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
    debugPrint("authUserIzi: ${json}");
    String message = json['Data']['Message'] ?? json['Message'] ?? "";
    bool isSuccess = json['Data']['IsSuccess'] ?? json['IsSuccess'] ?? false;
    bool isIZIAuthenticated = json['Data']['IsIZIAuthenticated'] ??
        json['Data']['IsIZIAuthenticated'] ??
        false;
    bool isIZIAuthorized = json['Data']['IsIZIAuthorized'] ??
        json['Data']['IsIZIAuthorized'] ??
        false;

    return TransactionResponse(
      message: message,
      isSuccess: isSuccess,
      isIZIAuthenticated: isIZIAuthenticated,
      isIZIAuthorized: isIZIAuthorized,
    );
  }
}
