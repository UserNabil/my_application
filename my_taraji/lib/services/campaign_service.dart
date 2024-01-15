import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/api_response_model.dart';
import 'dart:convert';

import 'package:my_taraji/core/models/campaign_response.dart';
import 'package:my_taraji/core/models/compaign_model.dart';

class CampaignService {
  late String baseUrl = "http://localhost:5074";
  CampaignService();

  Future<APIResponseModel<List<Campaign>>> getAllCampaigns() async {
    const path = "api/v1/campaigns/targetedAudience";
    final url = Uri.parse('$baseUrl/$path');

    try {
      var response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData['IsSuccess'] == true) {
        if (jsonData['Data'] is List) {
          try {
            return APIResponseModel<List<Campaign>>.fromJson(
              jsonData,
              (data) => fromJsonListCampaign(data),
            );
          } catch (e) {
            throw Exception('fromJsonListCampaign error : $e');
          }
        } else {
          throw Exception('Unexpected response format: ${response.body}');
        }
      } else {
        throw Exception('API Error: ${jsonData['Data']}');
      }
    } catch (e) {
      throw Exception('getAllCampaigns from Service error : $e');
    }
  }

  Future<APIResponseModel<Campaign>> getCampaignById(String id) async {
    const path = "api/v1/campaigns";
    final url = Uri.parse('$baseUrl/$path/$id');

    try {
      final response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      try {
        return APIResponseModel<Campaign>.fromJson(
          jsonData,
          (data) => Campaign.fromJson(data),
        );
      } catch (e) {
        throw Exception('fromJsonListCampaign error : $e');
      }
    } catch (e) {
      throw Exception(
          'Failed to connect to the server for campaign data by id $e');
    }
  }

  Future<APIResponseModel<CampaignResponse>> submitCampaignAnswers(
      CampaignResponse answers) async {
    const path = "api/v1/campaigns-answers";
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
          return APIResponseModel<CampaignResponse>.fromJson(
            jsonData,
            (data) => CampaignResponse.fromJson(data),
          );
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
