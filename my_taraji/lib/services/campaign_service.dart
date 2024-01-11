import 'package:flutter/foundation.dart';
import 'package:my_taraji/core/models/campaign_response.dart';
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
      try {
        campaigns = fromJsonListCampaign(jsonData);
        return campaigns;
      } catch (e) {
        throw Exception('fromJsonListCampaign error : $e');
      }
    } catch (e) {
      throw Exception('getAllCampaigns from Service error : $e');
    }
  }

  Future<Campaign> getCampaignById(String id) async {
    const path = "api/v1/campaigns";
    final url = Uri.parse('$baseUrl/$path/$id');

    try {
      final response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      try {
        Campaign campaign = Campaign.fromJson(jsonData);
        return campaign;
      } catch (e) {
        throw Exception('fromJsonListCampaign error : $e');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for campaign data by id $e');
    }
  }

  Future<CampaignResponse> submitCampaignAnswers(
      CampaignResponse answers) async {
    const path = "api/v1/campaigns-answers";
    debugPrint(jsonEncode(answers.toJson()));
    final url = Uri.parse('$baseUrl/$path');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(answers.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        try {
          CampaignResponse campaign = CampaignResponse.fromJson(jsonData);
          return campaign;
        } catch (e) {
          throw Exception('fromJsonCampaignResponse error : $e');
        }
      } else {
        throw Exception(
            'Failed to submit campaign answers - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
