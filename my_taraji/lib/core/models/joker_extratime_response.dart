class JokerExtraTimeResponse {
  bool success;
  JokerExtraTimeResponse({required this.success});
  factory JokerExtraTimeResponse.fromJson(Map<String, dynamic> json) {
    {
      return JokerExtraTimeResponse(success: json['success']);
    }
  }
  factory JokerExtraTimeResponse.fromMap(Map<String, dynamic> map) {
    return JokerExtraTimeResponse(success: map['success']);
  }
  Map<String, dynamic> toMap() {
    return {'success': success};
  }
}
