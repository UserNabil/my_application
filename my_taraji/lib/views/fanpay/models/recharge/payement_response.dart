import 'package:my_taraji/views/fanpay/models/recharge/payement_provider.dart';

class PaymentResponse {
  final PaymentProvider data;
  final String message;
  final bool isSuccess;
  final bool isIziAuthenticated;
  final bool isIziAuthorized;

  PaymentResponse({
    required this.data,
    required this.message,
    required this.isSuccess,
    required this.isIziAuthenticated,
    required this.isIziAuthorized,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      data: PaymentProvider.fromJson(json['Data']),
      message: json['Message'],
      isSuccess: json['IsSuccess'],
      isIziAuthenticated: json['IsIZIAuthenticated'],
      isIziAuthorized: json['IsIZIAuthorized'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Data': data.toJson(),
      'Message': message,
      'IsSuccess': isSuccess,
      'IsIZIAuthenticated': isIziAuthenticated,
      'IsIZIAuthorized': isIziAuthorized,
    };
  }
}
