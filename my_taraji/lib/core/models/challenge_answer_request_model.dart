class ChallengeAnswerRequest {
  String userId;
  String answerStatus;
  int score;
  int extraTimeUsed;
  int spyUsed;
  int fiftyUsed;
  String deviceConfiguration;
  GeoLocation geoLocation;
  List<Answer> answers;
  ChallengeAnswerRequest(
      {required this.userId,
      required this.answerStatus,
      required this.score,
      required this.extraTimeUsed,
      required this.spyUsed,
      required this.fiftyUsed,
      required this.deviceConfiguration,
      required this.geoLocation,
      required this.answers});

  factory ChallengeAnswerRequest.fromJson(Map<String, dynamic> json) {
    return ChallengeAnswerRequest(
        userId: json['userId'],
        answerStatus: json['answerStatus'],
        score: json['score'],
        extraTimeUsed: json['extraTimeUsed'],
        spyUsed: json['spyUsed'],
        fiftyUsed: json['fiftyUsed'],
        deviceConfiguration: json['deviceConfiguration'],
        geoLocation: GeoLocation.fromMap(json['geoLocation']),
        answers: List<Answer>.from(
            json['answers']?.map((x) => Answer.fromMap(x)) ?? []));
  }
  factory ChallengeAnswerRequest.fromMap(Map<String, dynamic> map) {
    return ChallengeAnswerRequest(
      userId: map['userId'],
      answerStatus: map['answerStatus'],
      score: map['score'],
      extraTimeUsed: map['extraTimeUsed'],
      spyUsed: map['spyUsed'],
      fiftyUsed: map['fiftyUsed'],
      deviceConfiguration: map['deviceConfiguration'],
      geoLocation: GeoLocation.fromMap(map['geoLocation']),
      answers: List<Answer>.from(
          map['answers']?.map((x) => Answer.fromMap(x)) ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'answerStatus': answerStatus,
      'score': score,
      'extraTimeUsed': extraTimeUsed,
      'spyUsed': spyUsed,
      'fiftyUsed': fiftyUsed,
      'deviceConfiguration': deviceConfiguration,
      'geoLocation': geoLocation.toMap(),
      'answers': List<dynamic>.from(answers.map((x) => x.toMap()))
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

  factory GeoLocation.fromMap(Map<String, dynamic> map) {
    return GeoLocation(
      longitude: map['longitude'],
      latitude: map['latitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}

class Answer {
  String questionId;
  String questionTypeId;
  String? value;
  int score;
  int answerTime;

  Answer({
    required this.questionId,
    required this.value,
    required this.answerTime,
    required this.questionTypeId,
    required this.score,
  });

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      questionId: map['questionId'],
      value: map['value'],
      answerTime: map['answerTime'],
      questionTypeId: map['questionTypeId'],
      score: map['score'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'value': value,
      'answerTime': answerTime,
      'questionTypeId': questionTypeId,
      'score': score,
    };
  }
}
