class JokerSpyResponse {
  String choiceId;
  String value;
  int percentage;
  JokerSpyResponse(
      {required this.choiceId, required this.value, required this.percentage});
  factory JokerSpyResponse.fromJson(Map<String, dynamic> json) {
    return JokerSpyResponse(
        choiceId: json['choiceId'],
        value: json['value'],
        percentage: json['percentage']);
  }
  factory JokerSpyResponse.fromMap(Map<String, dynamic> map) {
    return JokerSpyResponse(
        choiceId: map['choiceId'],
        value: map['value'],
        percentage: map['percentage']);
  }
  Map<String, dynamic> toMap() {
    return {'choiceId': choiceId, 'value': value, 'percentage': percentage};
  }
}
