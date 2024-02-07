class PaymentProvider {
  final String transactionId;
  final String paymentUrl;

  PaymentProvider({required this.transactionId, required this.paymentUrl});

  factory PaymentProvider.fromJson(Map<String, dynamic> json) {
    return PaymentProvider(
      transactionId: json['TransactionId'],
      paymentUrl: json['PaymentURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TransactionId': transactionId,
      'PaymentURL': paymentUrl,
    };
  }
}
