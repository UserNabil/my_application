class JokerFiftyResponse {
  String id;
  String value;
  JokerFiftyResponse({required this.id, required this.value});
  factory JokerFiftyResponse.fromJson(Map<String, dynamic> json) {
    return JokerFiftyResponse(id: json['_id'], value: json['value']);
  }
  factory JokerFiftyResponse.fromMap(Map<String, dynamic> map) {
    return JokerFiftyResponse(id: map['_id'], value: map['value']);
  }
  Map<String, dynamic> toMap() {
    return {'_id': id, 'value': value};
  }
}

List<JokerFiftyResponse> fromJsonListJokerFiftyResponse(
    List<dynamic>? jsonList) {
  if (jsonList == null) {
    return [];
  }

  return jsonList.map((json) => JokerFiftyResponse.fromJson(json)).toList();
}
