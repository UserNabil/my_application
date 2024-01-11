import 'package:my_taraji/core/models/challenge_model.dart';

class ChallengeById {
  int stepsNumber;
  int challengeTotal;
  int challengeScore;
  int totalAnswered;
  int? lastCheckPoint;
  int? checkPointsProgress;
  int termsAccepted;
  ChallengeType challengeType;
  List<Step> steps;
  String title;
  String description;
  String imageUrl;
  int stepNumber;
  Company company;
  List<CheckPoint> checkPoints;
  List<WiningRank> winingRanks;
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  ChallengeById({
    required this.stepsNumber,
    required this.challengeTotal,
    required this.challengeScore,
    required this.totalAnswered,
    required this.lastCheckPoint,
    required this.checkPointsProgress,
    required this.termsAccepted,
    required this.challengeType,
    required this.steps,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.stepNumber,
    required this.company,
    required this.checkPoints,
    required this.winingRanks,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChallengeById.fromJson(Map<String, dynamic> jsonApi) {
    Map<String, dynamic> json = jsonApi;
    return ChallengeById(
      stepsNumber: json['stepsNumber'],
      challengeTotal: json['challengeTotal'],
      challengeScore: json['challengeScore'],
      totalAnswered: json['totalAnswered'],
      lastCheckPoint: json['lastCheckPoint'],
      checkPointsProgress: json['checkPointsProgress'],
      termsAccepted: json['termsAccepted'],
      challengeType: ChallengeType.fromMap(json['challengeType']),
      steps: List<Step>.from(json['steps']?.map((x) => Step.fromMap(x)) ?? []),
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      stepNumber: json['stepNumber'],
      company: Company.fromMap(json['company']),
      checkPoints: List<CheckPoint>.from(
          json['checkPoints']?.map((x) => CheckPoint.fromMap(x)) ?? []),
      winingRanks: List<WiningRank>.from(
          json['winingRanks']?.map((x) => WiningRank.fromMap(x)) ?? []),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  factory ChallengeById.fromMap(Map<String, dynamic> map) {
    return ChallengeById(
      stepsNumber: map['stepsNumber'],
      challengeTotal: map['challengeTotal'],
      challengeScore: map['challengeScore'],
      totalAnswered: map['totalAnswered'],
      lastCheckPoint: map['lastCheckPoint'],
      checkPointsProgress: map['checkPointsProgress'],
      termsAccepted: map['termsAccepted'],
      challengeType: ChallengeType.fromMap(map['challengeType']),
      steps: List<Step>.from(map['steps']?.map((x) => Step.fromMap(x)) ?? []),
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      stepNumber: map['stepNumber'],
      company: Company.fromMap(map['company']),
      checkPoints: List<CheckPoint>.from(
          map['checkPoints']?.map((x) => CheckPoint.fromMap(x)) ?? []),
      winingRanks: List<WiningRank>.from(
          map['winingRanks']?.map((x) => WiningRank.fromMap(x)) ?? []),
      id: map['_id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stepsNumber': stepsNumber,
      'challengeTotal': challengeTotal,
      'challengeScore': challengeScore,
      'totalAnswered': totalAnswered,
      'lastCheckPoint': lastCheckPoint,
      'checkPointsProgress': checkPointsProgress,
      'termsAccepted': termsAccepted,
      'challengeType': challengeType.toMap(),
      'steps': List<dynamic>.from(steps.map((x) => x.toMap())),
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'stepNumber': stepNumber,
      'company': company.toMap(),
      'checkPoints': List<dynamic>.from(checkPoints.map((x) => x.toMap())),
      'winingRanks': List<dynamic>.from(winingRanks.map((x) => x.toMap())),
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class ChallengeType {
  String id;
  String name;
  String rules;
  List<Joker> jokerValues;

  ChallengeType(
      {required this.id,
      required this.name,
      required this.rules,
      required this.jokerValues});

  factory ChallengeType.fromMap(Map<String, dynamic> map) {
    return ChallengeType(
      id: map['_id'],
      name: map['name'],
      rules: map['rules'],
      jokerValues: List<Joker>.from(
          map['jokerValues']?.map((x) => Joker.fromMap(x)) ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'rules': rules,
      'jokerValues': List<dynamic>.from(jokerValues.map((x) => x.toMap())),
    };
  }
}

class Joker {
  String name;
  String cost;

  Joker({required this.cost, required this.name});

  factory Joker.fromMap(Map<String, dynamic> map) {
    return Joker(cost: map['cost'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {'cost': cost, 'name': name};
  }
}

class Step {
  String id;
  String title;
  String description;
  String status;
  int questionNumber;
  int stepTotal;
  int answersNumber;

  Step(
      {required this.id,
      required this.title,
      required this.description,
      required this.status,
      required this.questionNumber,
      required this.stepTotal,
      required this.answersNumber});

  factory Step.fromMap(Map<String, dynamic> map) {
    return Step(
        id: map['_id'],
        title: map['title'],
        description: map['description'],
        status: map['status'],
        questionNumber: map['questionNumber'],
        stepTotal: map['stepTotal'],
        answersNumber: map['answersNumber']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'status': status,
      'questionNumber': questionNumber,
      'stepTotal': stepTotal,
      'answersNumber': answersNumber,
    };
  }
}
