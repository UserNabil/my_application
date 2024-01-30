enum TransactionType {
  other,
  donation,
  transfert,
  recharging,
}

List<Map<String, dynamic>> transactionTypes = [
  {"key": 0, "value": "Other"},
  {"key": 1, "value": "Donation"},
  {"key": 2, "value": "Transfert"},
  {"key": 3, "value": "Recharging"}
];

TransactionType getTransactionType(int key) {
  switch (key) {
    case 0:
      return TransactionType.other;
    case 1:
      return TransactionType.donation;
    case 2:
      return TransactionType.transfert;
    case 3:
      return TransactionType.recharging;
    default:
      return TransactionType.other;
  }
}
