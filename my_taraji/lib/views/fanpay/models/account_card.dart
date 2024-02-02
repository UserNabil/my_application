class AccountCard {
  Data? data;
  String? responseMessage;
  bool? successStatus;
  bool? exceptionRaised;
  int? responseCode;
  bool? isIZIAuthenticated;
  bool? isIZIAuthorized;

  AccountCard({
    this.data,
    this.responseMessage,
    this.successStatus,
    this.exceptionRaised,
    this.responseCode,
    this.isIZIAuthenticated,
    this.isIZIAuthorized,
  });

  factory AccountCard.fromJson(Map<String, dynamic> json) {
    return AccountCard(
      data: json['Data'] != null ? Data.fromJson(json['Data']) : null,
      responseMessage: json['ResponseMessage'],
      successStatus: json['SuccessStatus'],
      exceptionRaised: json['ExceptionRaised'],
      responseCode: json['ResponseCode'],
      isIZIAuthenticated: json['IsIZIAuthenticated'],
      isIZIAuthorized: json['IsIZIAuthorized'],
    );
  }
}

class Data {
  String? id;
  String? phone;
  String? accountId;
  int? balance;
  String? rib;
  String? cardNumber;
  String? cardType;
  String? expiryDate;
  String? cardDeliveryDate;
  int? monthlyCapacity;
  dynamic dailyCapacity;

  Data({
    this.id,
    this.phone,
    this.accountId,
    this.balance,
    this.rib,
    this.cardNumber,
    this.cardType,
    this.expiryDate,
    this.cardDeliveryDate,
    this.monthlyCapacity,
    this.dailyCapacity,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      phone: json['phone'],
      accountId: json['accountId'],
      balance: json['balance'],
      rib: json['rib'],
      cardNumber: json['cardNumber'],
      cardType: json['cardType'],
      expiryDate: json['expiryDate'],
      cardDeliveryDate: json['cardDeliveryDate'],
      monthlyCapacity: json['monthlyCapacity'],
      dailyCapacity: json['dailyCapacity'],
    );
  }
}
