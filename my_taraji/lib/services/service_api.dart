import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/models/user_model.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<UserData> getUserData(String path) async {
    final url = Uri.parse('$baseUrl/$path');
    final response = await http.get(url);
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final userData = UserData.fromJson(jsonData);
    return userData;

    // try {
    //   final response = await http.get(url);

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> jsonData = json.decode(response.body);
    //     final userData = UserData.fromJson(jsonData);
    //     return userData;
    //   } else {
    //     throw Exception('Failed to load user data');
    //   }
    // } catch (e) {
    //   throw Exception(e);
    // }
  }

  Future<List<Campaign>> getAllCampaigns(String path) async {
    final url = Uri.parse('$baseUrl/$path');
    List<Campaign> campaigns = [];
    final response = await http.get(url);
    final List<dynamic> jsonData = json.decode(response.body);
    campaigns = fromJsonList(jsonData);
    return campaigns;
    // try {
    //   final response = await http.get(url);
    //   final List<dynamic> jsonData = json.decode(response.body);
    //   campaigns = fromJsonList(jsonData);
    //   return campaigns;
    // } catch (e) {
    //   throw Exception(e);
    //   // throw Exception('Failed to connect to the server $e');
    // }
  }

  Future<Campaign> getCampaignById(String path, String id) async {
    // final url = Uri.parse('$baseUrl/$path/$id');
    return Campaign(
        id: "",
        imageUri: "",
        title: "",
        subtitle: "",
        description: "",
        score: "",
        theme: "");
    // try {
    //   final response = await http.get(url);

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> jsonData = json.decode(response.body);
    //     print(jsonData);
    //     Campaign campaign = /*Campaign.fromJson(jsonData)*/ Campaign(
    //         id: "",
    //         imageUri: "",
    //         title: "",
    //         subtitle: "",
    //         description: "",
    //         score: "",
    //         theme: "");
    //     return campaign;
    //   } else {
    //     throw Exception('Failed to load campaign data');
    //   }
    // } catch (e) {
    //   throw Exception('Failed to connect to the server');
    // }
  }
}
