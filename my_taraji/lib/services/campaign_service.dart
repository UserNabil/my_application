import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampaignService {
  late String baseUrl = "http://localhost:5074";
  CampaignService();

  Future<List<Campaign>> getAllCampaigns() async {
    const path = "api/v1/campaigns/targetedAudience?Page=0&Limit=10";
    final url = Uri.parse('$baseUrl/$path');
    List<Campaign> campaigns = [];

    try {
      var response = await http.get(url);
      final List<dynamic> jsonData = json.decode(response.body);
      campaigns = fromJsonListCampaign(jsonData);
      return campaigns;
    } catch (e) {
      throw Exception('getAllCampaigns from Service error : $e');
    }
  }

  Future<Campaign> getCampaignById(String id) async {
    const path = "api/v1/campaigns";
    final url = Uri.parse('$baseUrl/$path/65951a9713058011787530bd');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        Campaign campaign = Campaign.fromJson(jsonData);
        return campaign;
      } else {
        throw Exception('Failed to load campaign data');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for campaign data by id $e');
    }
  }
}
