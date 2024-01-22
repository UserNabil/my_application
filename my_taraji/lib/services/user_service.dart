// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/api_response_model.dart';
import 'package:my_taraji/core/models/user_model.dart';

class UserService {
  late String baseUrl = "https://devmytarajiapi.azurewebsites.net";

  UserService();

  Future<APIResponseModel<UserData>> getUserData() async {
    const path = "api/v1/users";
    final url = Uri.parse('$baseUrl/$path');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return APIResponseModel<UserData>.fromJson(
          jsonData,
          (data) => UserData.fromJson(data),
        );
      } else {
        print('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed API call: ${response.reasonPhrase}');
      }
    } catch (e) {
      if (e.toString().contains('400')) {
        throw Exception('Failed to load user data');
      } else {
        throw Exception('Failed to connect to the server for user data $e');
      }
    }
  }
}
