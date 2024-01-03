import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Challenge {
  String title;
  String description;
  String imageUrl;
  int stepNumber;
  Company company;
  List<CheckPoint> checkPoints;
  List<WiningRank> winingRanks;
  String id;

  Challenge({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.stepNumber,
    required this.company,
    required this.checkPoints,
    required this.winingRanks,
    required this.id,
  });

  factory Challenge.fromJson(Map<String, dynamic> jsonApi) {
    Map<String, dynamic> json = jsonApi;
    return Challenge(
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
    );
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'stepNumber': stepNumber,
      'company': company.toMap(),
      'checkPoints': List<dynamic>.from(checkPoints.map((x) => x.toMap())),
      'winingRanks': List<dynamic>.from(winingRanks.map((x) => x.toMap())),
      '_id': id,
    };
  }
}

class Company {
  String id;
  String companyName;
  String imageUrl;

  Company({
    required this.id,
    required this.companyName,
    required this.imageUrl,
  });

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['_id'],
      companyName: map['companyName'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'companyName': companyName,
      'imageUrl': imageUrl,
    };
  }
}

class CheckPoint {
  String name;
  String description;

  CheckPoint({
    required this.name,
    required this.description,
  });

  factory CheckPoint.fromMap(Map<String, dynamic> map) {
    return CheckPoint(
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class WiningRank {
  int rank;
  int reward;
  bool claimed;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  WiningRank({
    required this.rank,
    required this.reward,
    required this.claimed,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WiningRank.fromMap(Map<String, dynamic> map) {
    return WiningRank(
      rank: map['rank'],
      reward: map['reward'],
      claimed: map['claimed'],
      id: map['_id'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime(0),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime(0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'reward': reward,
      'claimed': claimed,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

List<Challenge> fromJsonListChallenge(List<dynamic>? jsonList) {
  if (jsonList == null) {
    return [];
  }

  return jsonList.map((json) => Challenge.fromJson(json)).toList();
}

void saveChallenges(List<Challenge> challenges) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'challenges';
  if (challenges.isEmpty) {
    return;
  } else {
    final value =
        jsonEncode(challenges.map((campaign) => campaign.toMap()).toList());
    prefs.setString(key, value);
  }
}

Future<List<Challenge>> getChallenges() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'challenges';
  final value = prefs.getString(key);

  if (value != null) {
    // ignore: non_constant_identifier_names
    List<dynamic> challengeList = jsonDecode(value);
    return challengeList
        .map((challengeMap) => Challenge.fromMap(challengeMap))
        .toList();
  } else {
    return [];
  }
}
