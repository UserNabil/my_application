class Level {
  final MyLevelStat currentLevel;
  final MyLevelStat nextLevel;
  final int currentPercentage;
  final int missingPercentage;

  Level({
    required this.currentLevel,
    required this.nextLevel,
    required this.currentPercentage,
    required this.missingPercentage,
  });

  factory Level.fromJson(Map<String, dynamic>? json) {
    return Level(
      currentLevel: MyLevelStat.fromJson(json?['currentLevel']),
      nextLevel: MyLevelStat.fromJson(json?['nextLevel']),
      currentPercentage: json?['currentPercentage'] ?? 0,
      missingPercentage: json?['missingPercentage'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentLevel': currentLevel.toMap(),
      'nextLevel': nextLevel.toMap(),
      'currentPercentage': currentPercentage,
      'missingPercentage': missingPercentage,
    };
  }
}

class MyLevelStat {
  final String? nameFR;
  final int? pointsMax;
  final String? imageUrl;

  MyLevelStat({
    required this.nameFR,
    required this.pointsMax,
    required this.imageUrl,
  });

  factory MyLevelStat.fromJson(Map<String, dynamic>? json) {
    return MyLevelStat(
      nameFR: json?['nameFR'],
      pointsMax: json?['pointsMax'],
      imageUrl: json?['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameFR': nameFR,
      'pointsMax': pointsMax,
      'imageUrl': imageUrl,
    };
  }
}
