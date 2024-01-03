import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Campaign {
  String id;
  String imageUrl;
  String title;
  String subtitle;
  String description;
  String score;
  String theme;

  Campaign({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.score,
    required this.theme,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    Map<String, String> titleToImageNumber = {
      "Email": "2",
      "Téléphone": "3",
      "Social Media": "4"
    };

    String imgNumber = titleToImageNumber[json['title']] ?? '1';
    String desc = json['description'].toString().replaceAll(exp, '');
    return Campaign(
      id: json['_id'] ?? '',
      imageUrl: "images/pngs/compaigns$imgNumber.jpg",
      title: json['title'] ?? '',
      subtitle: desc,
      description: desc,
      score: (json['reward'] != null && json['reward']['coins'] != null)
          ? json['reward']['coins'].toString()
          : '',
      theme:
          (json['tag'] != null && json['tag'].isNotEmpty) ? json['tag'][0] : '',
    );
  }

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      id: map['campaign']['id'] ?? '',
      imageUrl: map['campaign']['imageUri'] ?? '',
      title: map['campaign']['title'] ?? '',
      subtitle: map['campaign']['subtitle'] ?? '',
      description: map['campaign']['description'] ?? '',
      score: map['campaign']['score'] ?? '',
      theme: map['campaign']['theme'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUri': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'score': score,
      'theme': theme,
    };
  }
}

List<Campaign> fromJsonListCampaign(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return [];
  } else {
    return jsonList.map((json) => Campaign.fromJson(json['campaign'])).toList();
  }
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
