import 'dart:convert';
import 'package:my_taraji/core/models/campaign_type_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Campaign {
  String id;
  String imageUrl;
  String title;
  String description;
  int rewardCoins;
  String tag;
  CampaignType? campaignType;
  List<QuestionCampaign>? questionCampaign;

  Campaign({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.rewardCoins,
    required this.tag,
    this.campaignType,
    this.questionCampaign,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    Map<String, String> titleToImageNumber = {
      "Verification Mail": "2",
      "Téléphone": "3",
      "Social Media": "4",
      "Date picker": "5",
      "Digital Number 4": "6",
      "Champs de text": "7",
      "Radio": "8",
      "Select": "9",
      "Rating": "10",
    };

    String imgNumber = titleToImageNumber[json['Title']] ?? '1';
    String desc = json['Description'].toString().replaceAll(exp, '');

    return Campaign(
      id: json['Id'] ?? '',
      imageUrl: "images/pngs/campaigns/campaigns$imgNumber.jpg",
      title: json['Title'] ?? '',
      description: desc,
      rewardCoins: json['RewardCoins'] ?? '',
      tag: json['Tag'] ?? '',
      campaignType: json['CampaignType'] != null
          ? CampaignType.fromJson(json['CampaignType'])
          : null,
      questionCampaign: json['Questions'] != null
          ? fromJsonListQuestion(json['Questions'])
          : null,
    );
  }

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      id: map['id'] ?? '',
      imageUrl: map['imageUri'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      rewardCoins: map['rewardCoins'] ?? '',
      tag: map['tag'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'rewardCoins': rewardCoins,
      'tag': tag,
    };
  }
}

List<Campaign> fromJsonListCampaign(dynamic jsonList) {
  List<Campaign> campaigns = [];

  if (jsonList != null && jsonList is List) {
    for (var jsonItem in jsonList) {
      if (jsonItem != null && jsonItem is Map<String, dynamic>) {
        campaigns.add(Campaign.fromJson(jsonItem));
      }
    }
  }

  return campaigns;
}

void saveCampaigns(List<Campaign> campaigns) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'campaigns';
  final value =
      jsonEncode(campaigns.map((campaign) => campaign.toMap()).toList());
  prefs.setString(key, value);
}

Future<List<Campaign>> getCampaigns() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'campaigns';
  final value = prefs.getString(key);

  if (value != null) {
    List<dynamic> campaignList = jsonDecode(value);
    return campaignList
        .map((campaignMap) => Campaign.fromMap(campaignMap))
        .toList();
  } else {
    return [];
  }
}
