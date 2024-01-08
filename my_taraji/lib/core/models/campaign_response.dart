class CampaignResponse {
  String campaignId;
  String userId;
  String answerId;
  String status;
  String progress;
  String addressIp;
  String deviceConfiguration;
  GeoLocation geoLocation;
  int score;
  List<Answer> answers;

  CampaignResponse({
    required this.campaignId,
    required this.userId,
    required this.answerId,
    required this.status,
    required this.progress,
    required this.addressIp,
    required this.deviceConfiguration,
    required this.geoLocation,
    required this.score,
    required this.answers,
  });

  factory CampaignResponse.fromJson(Map<String, dynamic> json) {
    return CampaignResponse(
      campaignId: json['campaignId'] ?? '',
      userId: json['userId'] ?? '',
      answerId: json['answerId'] ?? '',
      status: json['status'] ?? '',
      progress: json['progress'] ?? '',
      addressIp: json['addressIp'] ?? '',
      deviceConfiguration: json['deviceConfiguration'] ?? '',
      geoLocation: GeoLocation.fromJson(json['geoLocation'] ?? {}),
      score: json['score'] ?? 0,
      answers: fromJsonListAnswers(json['answers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campaignId': campaignId,
      'userId': userId,
      'answerId': answerId,
      'status': status,
      'progress': progress,
      'addressIp': addressIp,
      'deviceConfiguration': deviceConfiguration,
      'geoLocation': geoLocation.toJson(),
      'score': score,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

class GeoLocation {
  double longitude;
  double latitude;

  GeoLocation({
    required this.longitude,
    required this.latitude,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      longitude: json['longitude'] ?? 0.0,
      latitude: json['latitude'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}

class Answer {
  String questionId;
  String questionTypeId;
  List<QuestionAnswer> questionAnswers;

  Answer({
    required this.questionId,
    required this.questionTypeId,
    required this.questionAnswers,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      questionId: json['questionId'] ?? '',
      questionTypeId: json['questionTypeId'] ?? '',
      questionAnswers:
          fromJsonListQuestionAnswers(json['questionAnswers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionTypeId': questionTypeId,
      'questionAnswers': questionAnswers.map((qa) => qa.toJson()).toList(),
    };
  }
}

class QuestionAnswer {
  String value;
  String status;
  String interactions;
  String comments;

  QuestionAnswer({
    required this.value,
    required this.status,
    required this.interactions,
    required this.comments,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
      value: json['value'] ?? '',
      status: json['status'] ?? '',
      interactions: json['interactions'] ?? '',
      comments: json['comments'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'status': status,
      'interactions': interactions,
      'comments': comments,
    };
  }
}

List<Answer> fromJsonListAnswers(List<dynamic> jsonList) {
  return jsonList.map((json) => Answer.fromJson(json)).toList();
}

List<QuestionAnswer> fromJsonListQuestionAnswers(List<dynamic> jsonList) {
  return jsonList.map((json) => QuestionAnswer.fromJson(json)).toList();
}
