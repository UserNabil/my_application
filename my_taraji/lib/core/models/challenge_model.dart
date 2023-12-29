import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Challenge {
  String imagePath;
  String title;
  String subtitle;
  String coins;
  String challengeName;

  Challenge({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.coins,
    required this.challengeName,
  });

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      imagePath: map['imagePath'],
      title: map['title'],
      subtitle: map['subtitle'],
      coins: map['coins'],
      challengeName: map['challengeName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'title': title,
      'subtitle': subtitle,
      'coins': coins,
      'challengeName': challengeName,
    };
  }
}

void saveChallenges(List<Challenge> challenges) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'challenges';
  final value =
      jsonEncode(challenges.map((campaign) => campaign.toMap()).toList());
  prefs.setString(key, value);
}

Future<List<Challenge>> getChallenges() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'challenges';
  final value = prefs.getString(key);

  if (value != null) {
    // ignore: non_constant_identifier_names
    List<dynamic> ChallengeList = jsonDecode(value);
    return ChallengeList.map((challengeMap) => Challenge.fromMap(challengeMap))
        .toList();
  } else {
    return [];
  }
}
