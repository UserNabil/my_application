import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/user_model.dart';

class UserService {
  late String baseUrl = "http://localhost:5074";

  UserService();

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
}
