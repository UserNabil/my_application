class JokerRequest {
  String stepId;
  String questionId;
  JokerRequest({required this.stepId, required this.questionId});
  factory JokerRequest.fromJson(Map<String, dynamic> json) {
    return JokerRequest(stepId: json['stepId'], questionId: json['questionId']);
  }
  factory JokerRequest.fromMap(Map<String, dynamic> map) {
    return JokerRequest(stepId: map['stepId'], questionId: map['questionId']);
  }
  Map<String, dynamic> toMap() {
    return {'stepId': stepId, 'questionId': questionId};
  }
}
