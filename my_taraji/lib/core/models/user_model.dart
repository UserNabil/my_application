class UserData {
  final String id;
  final String currentToken;
  final bool onBoardingDone;
  final String birthday;
  final String loggedIn;
  final String gender;
  final String civility;
  final String profession;
  final String studyLevel;
  final String friendInvitationCode;
  final String situation;
  final String language;
  final List<dynamic> ignoreCampaigns;
  final LegalPolicies legalPolicies;
  final MyRewards myRewards;
  final MyGamification myGamification;
  final List<dynamic> campaignInProgress;
  final String pseudo;
  final Address address;
  final String phone;
  final List<String> roles;
  final List<dynamic> interests;
  final List<dynamic> friendInvitationCodeHistory;
  final List<dynamic> fidelityHistory;
  final List<dynamic> followedCommunities;
  final List<dynamic> profileSettings;
  final List<dynamic> badges;
  final List<dynamic> campaignAnswers;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.id,
    required this.currentToken,
    required this.onBoardingDone,
    required this.birthday,
    required this.loggedIn,
    required this.gender,
    required this.civility,
    required this.profession,
    required this.studyLevel,
    required this.friendInvitationCode,
    required this.situation,
    required this.language,
    required this.ignoreCampaigns,
    required this.legalPolicies,
    required this.myRewards,
    required this.myGamification,
    required this.campaignInProgress,
    required this.pseudo,
    required this.address,
    required this.phone,
    required this.roles,
    required this.interests,
    required this.friendInvitationCodeHistory,
    required this.fidelityHistory,
    required this.followedCommunities,
    required this.profileSettings,
    required this.badges,
    required this.campaignAnswers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['user']['_id'],
      currentToken: json['user']['currentToken'],
      onBoardingDone: json['user']['onBoardingDone'],
      birthday: json['user']['birthday'],
      loggedIn: json['user']['loggedIn'],
      gender: json['user']['gender'],
      civility: json['user']['civility'],
      profession: json['user']['profession'],
      studyLevel: json['user']['studyLevel'],
      friendInvitationCode: json['user']['friendInvitationCode'],
      situation: json['user']['situation'],
      language: json['user']['language'],
      ignoreCampaigns: json['user']['ignoreCampaigns'],
      legalPolicies: LegalPolicies.fromJson(json['user']['legalPolicies']),
      myRewards: MyRewards.fromJson(json['user']['myRewards']),
      myGamification: MyGamification.fromJson(json['user']['myGamification']),
      campaignInProgress: json['user']['campaignInProgress'],
      pseudo: json['user']['pseudo'],
      address: Address.fromJson(json['user']['address']),
      phone: json['user']['phone'],
      roles: json['user']['roles'].cast<String>(),
      interests: json['user']['interests'],
      friendInvitationCodeHistory: json['user']['friendInvitationCodeHistory'],
      fidelityHistory: json['user']['fidelityHistory'],
      followedCommunities: json['user']['followedCommunities'],
      profileSettings: json['user']['profileSettings'],
      badges: json['user']['badges'],
      campaignAnswers: json['user']['campaignAnswers'],
      createdAt: json['user']['createdAt'],
      updatedAt: json['user']['updatedAt'],
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
  final String id;
  final int coins;
  final List<dynamic> redeemHistory;
  final String createdAt;
  final String updatedAt;

  MyRewards({
    required this.id,
    required this.coins,
    required this.redeemHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyRewards.fromJson(Map<String, dynamic> json) {
    return MyRewards(
      id: json['_id'],
      coins: json['coins'],
      redeemHistory: json['redeemHistory'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
