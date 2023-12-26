import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Campaign {
  String id;
  String imagePath;
  String title;
  String subtitle;
  String description;
  String coins;
  String compagneName;

  Campaign({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.coins,
    required this.compagneName,
  });

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      id: map['id'],
      imagePath: map['imagePath'],
      title: map['title'],
      subtitle: map['subtitle'],
      description: map['description'],
      coins: map['coins'],
      compagneName: map['compagneName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'coins': coins,
      'compagneName': compagneName,
    };
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
