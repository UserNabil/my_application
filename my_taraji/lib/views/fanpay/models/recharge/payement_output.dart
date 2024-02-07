import 'package:my_taraji/views/fanpay/models/recharge/payement_response.dart';

class PaymentOutput {
  final PaymentResponse data;
  final bool isSuccess;

  PaymentOutput({
    required this.data,
    required this.isSuccess,
  });

  factory PaymentOutput.fromJson(Map<String, dynamic> json) {
    return PaymentOutput(
      data: PaymentResponse.fromJson(json['Data']),
      isSuccess: json['IsSuccess'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Data': data.toJson(),
      'IsSuccess': isSuccess,
    };
  }
}
