import 'package:my_taraji/core/models/challenge_answer_request_model.dart';

class ChallengeAnswerResponse {
  String stepId;
  String status;
  int score;
  int extraTimeUsed;
  int spyUsed;
  int fiftyUsed;
  String userId;
  // GeoLocation? geoLocation;
  // DeviceConfiguration? deviceConfig;
  List<Answer> answers;
  ChallengeAnswerResponse(
      {required this.stepId,
      required this.userId,
      required this.status,
      required this.score,
      required this.extraTimeUsed,
      required this.spyUsed,
      required this.fiftyUsed,
      // required this.deviceConfig,
      //required this.geoLocation,
      required this.answers});
  factory ChallengeAnswerResponse.fromJson(Map<String, dynamic> json) {
    return ChallengeAnswerResponse(
        stepId: json['stepId'],
        userId: json['userId'],
        status: json['status'],
        score: json['score'],
        extraTimeUsed: json['extraTimeUsed'],
        spyUsed: json['spyUsed'],
        fiftyUsed: json['fiftyUsed'],
        // deviceConfig: DeviceConfiguration.(json['deviceConfig']),
        // geoLocation: GeoLocation.fromMap(json['geoLocation']),
        answers: List<Answer>.from(
            json['answers']?.map((x) => Answer.fromMap(x)) ?? []));
  }
  factory ChallengeAnswerResponse.fromMap(Map<String, dynamic> map) {
    return ChallengeAnswerResponse(
      stepId: map['stepId'],
      userId: map['userId'],
      status: map['status'],
      score: map['score'],
      extraTimeUsed: map['extraTimeUsed'],
      spyUsed: map['spyUsed'],
      fiftyUsed: map['fiftyUsed'],
      // deviceConfig: map['deviceConfig'],
      //geoLocation: GeoLocation.fromMap(map['geoLocation']),
      answers: List<Answer>.from(
          map['answers']?.map((x) => Answer.fromMap(x)) ?? []),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'stepId': stepId,
      'userId': userId,
      'status': status,
      'score': score,
      'extraTimeUsed': extraTimeUsed,
      'spyUsed': spyUsed,
      'fiftyUsed': fiftyUsed,
      // 'deviceConfig': deviceConfig,
      //'geoLocation': geoLocation!.toMap(),
      'answers': List<dynamic>.from(answers.map((x) => x.toMap()))
    };
  }
}
