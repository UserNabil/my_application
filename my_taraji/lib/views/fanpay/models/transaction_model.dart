class TransactionModel {
  final int contributionMethod;
  final int amountContributed;
  final int coinsCountContributed;

  TransactionModel({
    required this.contributionMethod,
    required this.amountContributed,
    required this.coinsCountContributed,
  });

  factory TransactionModel.fromJson(Map<String, dynamic>? json) {
    return TransactionModel(
      contributionMethod: json?['contributionMethod'] ?? 0,
      amountContributed: json?['amountContributed'] ?? 0,
      coinsCountContributed: json?['coinsCountContributed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'contributionMethod': contributionMethod,
        'amountContributed': amountContributed,
        'coinsCountContributed': coinsCountContributed,
      };
}

class TransactionSettings {
  final List<AuthorizedAmounts> authorizedAmounts;
  final bool isFreeInputAmountActivated;
  final bool isMinimumThresholdAmountActive;
  final int minimumThresholdAmount;
  final String minimumThresholdViloationMessage;
  // final int organizationAgentCode;
  final bool isAnonymosContributionActivated;
  final int transactionType;

  TransactionSettings({
    required this.authorizedAmounts,
    required this.isFreeInputAmountActivated,
    required this.isMinimumThresholdAmountActive,
    required this.minimumThresholdAmount,
    required this.minimumThresholdViloationMessage,
    // required this.organizationAgentCode,
    required this.isAnonymosContributionActivated,
    required this.transactionType,
  });

  factory TransactionSettings.fromJson(Map<String, dynamic> json) {
    return TransactionSettings(
      authorizedAmounts: fromJsonListTransactions(json['authorizedAmounts']),
      isFreeInputAmountActivated: json['isFreeInputAmountActivated'],
      isMinimumThresholdAmountActive: json['isMinimumThresholdAmountActive'],
      minimumThresholdAmount: json['minimumThresholdAmount'],
      minimumThresholdViloationMessage:
          json['minimumThresholdViloationMessage'],
      // organizationAgentCode: json['organizationAgentCode'],
      isAnonymosContributionActivated: json['isAnonymosContributionActivated'],
      transactionType: json['transactionType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'authorizedAmounts': authorizedAmounts,
        'isFreeInputAmountActivated': isFreeInputAmountActivated,
        'isMinimumThresholdAmountActive': isMinimumThresholdAmountActive,
        'minimumThresholdAmount': minimumThresholdAmount,
        'minimumThresholdViloationMessage': minimumThresholdViloationMessage,
        // 'organizationAgentCode': organizationAgentCode,
        'isAnonymosContributionActivated': isAnonymosContributionActivated,
        'transactionType': transactionType,
      };
}

class AuthorizedAmounts {
  final int amount;

  AuthorizedAmounts({
    required this.amount,
  });

  factory AuthorizedAmounts.fromJson(Map<String, dynamic> json) {
    return AuthorizedAmounts(
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
      };
}

List<AuthorizedAmounts> fromJsonListTransactions(dynamic jsonList) {
  List<AuthorizedAmounts> authorizedAmounts = [];

  if (jsonList != null && jsonList is List) {
    for (var jsonItem in jsonList) {
      if (jsonItem != null && jsonItem is Map<String, dynamic>) {
        authorizedAmounts.add(AuthorizedAmounts.fromJson(jsonItem));
      }
    }
  }

  return authorizedAmounts;
}
