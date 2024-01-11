import 'package:my_taraji/core/models/device_configuration.dart';

class CampaignResponse {
  String campaignId;
  String? userId;
  String? answerId;
  String? status;
  String? progress;
  String? addressIp;
  DeviceConfiguration deviceConfiguration;
  GeoLocation geoLocation;
  int? score;
  Reward rewards;
  List<Answer> answers;

  CampaignResponse({
    required this.campaignId,
    this.userId,
    this.answerId,
    this.status,
    this.progress,
    this.addressIp,
    required this.deviceConfiguration,
    required this.geoLocation,
    this.score,
    required this.rewards,
    required this.answers,
  });

  factory CampaignResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return CampaignResponse(
        campaignId: '',
        userId: '',
        answerId: '',
        status: '',
        progress: '',
        addressIp: '',
        deviceConfiguration: DeviceConfiguration.fromJson({}),
        geoLocation: GeoLocation.fromJson({}),
        score: 0,
        rewards: Reward(coins: 0, maxRep: 0, givenRep: 0),
        answers: [],
      );
    }

    return CampaignResponse(
      campaignId: json['campaignId'] ?? '',
      userId: json['userId'] ?? '',
      answerId: json['answerId'] ?? '',
      status: json['status'] ?? '',
      progress: json['progress'] ?? '',
      addressIp: json['addressIp'] ?? '',
      deviceConfiguration: DeviceConfiguration.fromJson(
        json['deviceConfiguration'] ?? {},
      ),
      geoLocation: GeoLocation.fromJson(json['geoLocation'] ?? {}),
      score: json['score'] ?? 0,
      rewards: Reward(
        coins: json['rewards']['coins'] ?? 0,
        maxRep: json['rewards']['maxRep'] ?? 0,
        givenRep: json['rewards']['givenRep'] ?? 0,
      ),
      answers: fromJsonListAnswers(json['answers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campaignId': campaignId,
      'userId': userId ?? '',
      'answerId': answerId ?? '',
      'status': status ?? '',
      'progress': progress ?? '',
      'addressIp': addressIp ?? '',
      'deviceConfiguration': deviceConfiguration.toJson(),
      'geoLocation': geoLocation.toJson(),
      'score': score ?? 0,
      'rewards': rewards.toJson(),
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
  String? questionId;
  String? questionTypeId;
  List<QuestionAnswer> questionAnswers;

  Answer({
    this.questionId,
    this.questionTypeId,
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

  QuestionAnswer({
    required this.value,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

List<Answer> fromJsonListAnswers(List<dynamic> jsonList) {
  return jsonList.map((json) => Answer.fromJson(json)).toList();
}

List<QuestionAnswer> fromJsonListQuestionAnswers(List<dynamic> jsonList) {
  return jsonList.map((json) => QuestionAnswer.fromJson(json)).toList();
}

class Reward {
  int coins;
  int maxRep;
  int givenRep;

  Reward({
    required this.coins,
    required this.maxRep,
    required this.givenRep,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      coins: json['coins'] ?? 0,
      maxRep: json['maxRep'] ?? 0,
      givenRep: json['givenRep'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coins': coins,
      'maxRep': maxRep,
      'givenRep': givenRep,
    };
  }
}
