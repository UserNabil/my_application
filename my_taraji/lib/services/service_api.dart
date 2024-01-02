import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/models/user_model.dart';

class ApiService {
  late String baseUrl = "http://localhost:5074";

  ApiService();

  Future<UserData> getUserData() async {
    const path = "api/v1/users";
    final url = Uri.parse('$baseUrl/$path');

    try {
      final response = await http.get(url);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final userData = UserData.fromJson(jsonData);
      return userData;
    } catch (e) {
      throw Exception('Failed to connect to the server for user data $e');
    }
  }

  Future<List<Campaign>> getAllCampaigns() async {
    const path = "api/v1/campaigns/targetedAudience?Page=0&Limit=10";
    final url = Uri.parse('$baseUrl/$path');
    List<Campaign> campaigns = [];

    try {
      final response = await http.get(url);
      final List<dynamic> jsonData = json.decode(response.body);
      campaigns = fromJsonListCampaign(jsonData);
      return campaigns;
    } catch (e) {
      throw Exception('Failed to connect to the server for campaign data $e');
    }
  }

  Future<Campaign> getCampaignById(String id) async {
    const path = "";
    final url = Uri.parse('$baseUrl/$path/$id');
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

  Future<List<Challenge>> getAllChallenges() async {
    const path = "api/v1/challenges?Page=0&Limit=10";
    final url = Uri.parse('$baseUrl/$path');
    List<Challenge> challenges = [];

    try {
      var response = await http.get(url);
      final dynamic jsonData = json.decode(response.body);
      challenges = fromJsonListChallenge(jsonData['data']);
      return challenges;
    } catch (e) {
      throw Exception('Failed to connect to the server for challenge data $e');
    }
  }
}
