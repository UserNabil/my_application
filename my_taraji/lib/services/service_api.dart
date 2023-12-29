import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/models/user_model.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<UserData> getUserData(String path) async {
    final url = Uri.parse('$baseUrl/$path');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final userData = UserData.fromJson(jsonData);
        return userData;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<List<Campaign>> getAllCampaigns(String path) async {
    final url = Uri.parse('$baseUrl/$path');
    List<Campaign> campaigns = [];
    try {
      final response = await http.get(url);
      final List<dynamic> jsonData = json.decode(response.body);
      campaigns = fromJsonList(jsonData);
      return campaigns;
    } catch (e) {
      throw Exception('Failed to connect to the server $e');
    }
  }
}