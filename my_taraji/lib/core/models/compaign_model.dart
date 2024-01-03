import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Campaign {
  String id;
  String imageUri;
  String title;
  String subtitle;
  String description;
  String score;
  String theme;

  Campaign({
    required this.id,
    required this.imageUri,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.score,
    required this.theme,
  });

  factory Campaign.fromJson(Map<String, dynamic> jsonApi) {
    Map<String, dynamic> json = jsonApi;
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String imgNumber = json['campaign']['title'] == "Email" ? "2" : "3",
        desc = json['campaign']['description'].toString().replaceAll(exp, '');
    return Campaign(
      id: json['campaign']['_id'],
      imageUri: /*json['imageUri']*/ "images/pngs/compaigns$imgNumber.jpg",
      title: json['campaign']['title'],
      subtitle: desc,
      description: desc,
      score: json['campaign']['reward']['coins'].toString(),
      theme: json['campaign']['tag'][0],
    );
  }

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      id: map['id'],
      imageUri: map['imageUri'],
      title: map['title'],
      subtitle: map['subtitle'],
      description: map['description'],
      score: map['score'],
      theme: map['theme'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUri': imageUri,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'score': score,
      'theme': theme,
    };
  }
}

List<Campaign> fromJsonListCampaign(List<dynamic>? jsonList) {
  if (jsonList == null) {
    return [];
  }

  return jsonList.map((json) => Campaign.fromJson(json)).toList();
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
