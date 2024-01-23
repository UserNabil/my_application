class UserData {
  final String id;
  final MyRewards myRewards;
  final MyGamification myGamification;
  final String pseudo;
  final String phone;
  // final String currentToken;
  // final Level level;
  // final bool onBoardingDone;
  // final String birthday;
  // final String loggedIn;
  // final String gender;
  // final String civility;
  // final String profession;
  // final String studyLevel;
  // final String friendInvitationCode;
  // final String situation;
  // final String language;
  // final List<dynamic> ignoreCampaigns;
  // final LegalPolicies legalPolicies;
  // final List<dynamic> campaignInProgress;
  // final Address address;
  // final List<String> roles;
  // final List<dynamic> interests;
  // final List<dynamic> friendInvitationCodeHistory;
  // final List<dynamic> fidelityHistory;
  // final List<dynamic> followedCommunities;
  // final List<dynamic> profileSettings;
  // final List<dynamic> badges;
  // final List<dynamic> campaignAnswers;
  // final String createdAt;
  // final String updatedAt;

  UserData({
    required this.id,
    required this.myRewards,
    required this.myGamification,
    required this.pseudo,
    required this.phone,
    // required this.currentToken,
    // required this.level,
    // required this.onBoardingDone,
    // required this.birthday,
    // required this.loggedIn,
    // required this.gender,
    // required this.civility,
    // required this.profession,
    // required this.studyLevel,
    // required this.friendInvitationCode,
    // required this.situation,
    // required this.language,
    // required this.ignoreCampaigns,
    // required this.legalPolicies,
    // required this.campaignInProgress,
    // required this.address,
    // required this.roles,
    // required this.interests,
    // required this.friendInvitationCodeHistory,
    // required this.fidelityHistory,
    // required this.followedCommunities,
    // required this.profileSettings,
    // required this.badges,
    // required this.campaignAnswers,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['user']['_id'],
      // currentToken: json['user']['currentToken'],
      myRewards: MyRewards.fromJson(json['user']['myRewards']),
      myGamification: MyGamification.fromJson(json['user']['myGamification']),
      pseudo: json['user']['pseudo'],
      phone: json['user']['phone'],
      // level: Level.fromJson(json['user']['level']),
      // currentToken: json['user']['currentToken'],
      // onBoardingDone: json['user']['onBoardingDone'],
      // birthday: json['user']['birthday'],
      // loggedIn: json['user']['loggedIn'],
      // gender: json['user']['gender'],
      // civility: json['user']['civility'],
      // profession: json['user']['profession'],
      // studyLevel: json['user']['studyLevel'],
      // friendInvitationCode: json['user']['friendInvitationCode'],
      // situation: json['user']['situation'],
      // language: json['user']['language'],
      // ignoreCampaigns: json['user']['ignoreCampaigns'],
      // legalPolicies: LegalPolicies.fromJson(json['user']['legalPolicies']),
      // campaignInProgress: json['user']['campaignInProgress'],
      // address: Address.fromJson(json['user']['address']),
      // roles: json['user']['roles'].cast<String>(),
      // interests: json['user']['interests'],
      // friendInvitationCodeHistory: json['user']['friendInvitationCodeHistory'],
      // fidelityHistory: json['user']['fidelityHistory'],
      // followedCommunities: json['user']['followedCommunities'],
      // profileSettings: json['user']['profileSettings'],
      // badges: json['user']['badges'],
      // campaignAnswers: json['user']['campaignAnswers'],
      // createdAt: json['user']['createdAt'],
      // updatedAt: json['user']['updatedAt'],
    );
  }
}

class LegalPolicies {
  final String id;
  final bool cookies;
  final bool cookiesBanner;
  final bool gameRules;
  final bool privacy;
  final bool terms;
  final List<LegalPolicyHistory> history;
  final String createdAt;
  final String updatedAt;

  LegalPolicies({
    required this.id,
    required this.cookies,
    required this.cookiesBanner,
    required this.gameRules,
    required this.privacy,
    required this.terms,
    required this.history,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LegalPolicies.fromJson(Map<String, dynamic> json) {
    return LegalPolicies(
      id: json['_id'],
      cookies: json['cookies'],
      cookiesBanner: json['cookiesBanner'],
      gameRules: json['gameRules'],
      privacy: json['privacy'],
      terms: json['terms'],
      history: List<LegalPolicyHistory>.from(
          json['history'].map((x) => LegalPolicyHistory.fromJson(x))),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class LegalPolicyHistory {
  final String id;
  final String legalPolicyId;
  final String createdAt;
  final String updatedAt;

  LegalPolicyHistory({
    required this.id,
    required this.legalPolicyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LegalPolicyHistory.fromJson(Map<String, dynamic> json) {
    return LegalPolicyHistory(
      id: json['_id'],
      legalPolicyId: json['legalPolicyId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class MyRewards {
  // final String id;
  final int coins;
  // final List<dynamic> redeemHistory;
  // final String createdAt;
  // final String updatedAt;

  MyRewards({
    // required this.id,
    required this.coins,
    // required this.redeemHistory,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory MyRewards.fromJson(Map<String, dynamic> json) {
    return MyRewards(
      // id: json['_id'],
      coins: json['coins'],
      // redeemHistory: json['redeemHistory'],
      // createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
    );
  }
}

class MyGamification {
  final String id;
  final int expPoints;
  final List<ExpPointsHistory> expPointsHistory;
  final String createdAt;
  final String updatedAt;

  MyGamification({
    required this.id,
    required this.expPoints,
    required this.expPointsHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyGamification.fromJson(Map<String, dynamic> json) {
    return MyGamification(
      id: json['_id'],
      expPoints: json['expPoints'],
      expPointsHistory: List<ExpPointsHistory>.from(
          json['expPointsHistory'].map((x) => ExpPointsHistory.fromJson(x))),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ExpPointsHistory {
  final String id;
  final List<dynamic> communities;
  final int points;
  final String action;
  final String createdAt;
  final String updatedAt;

  ExpPointsHistory({
    required this.id,
    required this.communities,
    required this.points,
    required this.action,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExpPointsHistory.fromJson(Map<String, dynamic> json) {
    return ExpPointsHistory(
      id: json['_id'],
      communities: json['communities'],
      points: json['points'],
      action: json['action'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Address {
  final String id;
  final String longitude;
  final String latitude;
  final String address;
  final String createdAt;
  final String updatedAt;

  Address({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      address: json['address'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

// class Level {
//   final CurrentLevel currentLevel;
//   final NextLevel nextLevel;
//   final int currentPercentage;
//   final int missingPercentage;

//   Level({
//     required this.currentLevel,
//     required this.nextLevel,
//     required this.currentPercentage,
//     required this.missingPercentage,
//   });

//   factory Level.fromJson(Map<String, dynamic> json) {
//     return Level(
//       currentLevel: CurrentLevel.fromJson(json['currentLevel']),
//       nextLevel: NextLevel.fromJson(json['nextLevel']),
//       currentPercentage: json['currentPercentage'],
//       missingPercentage: json['missingPercentage'],
//     );
//   }
// }

// class CurrentLevel {
//   final String id;
//   final String nameEN;
//   final String nameFR;
//   final int pointsMax;
//   final String imageUrl;

//   CurrentLevel({
//     required this.id,
//     required this.nameEN,
//     required this.nameFR,
//     required this.pointsMax,
//     required this.imageUrl,
//   });

//   factory CurrentLevel.fromJson(Map<String, dynamic> json) {
//     return CurrentLevel(
//       id: json['_id'],
//       nameEN: json['nameEN'],
//       nameFR: json['nameFR'],
//       pointsMax: json['pointsMax'],
//       imageUrl: json['imageUrl'],
//     );
//   }
// }

// class NextLevel {
//   final String id;
//   final String nameEN;
//   final String nameFR;
//   final int pointsMax;
//   final String imageUrl;

//   NextLevel({
//     required this.id,
//     required this.nameEN,
//     required this.nameFR,
//     required this.pointsMax,
//     required this.imageUrl,
//   });

//   factory NextLevel.fromJson(Map<String, dynamic> json) {
//     return NextLevel(
//       id: json['_id'],
//       nameEN: json['nameEN'],
//       nameFR: json['nameFR'],
//       pointsMax: json['pointsMax'],
//       imageUrl: json['imageUrl'],
//     );
//   }
// }
