import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/core/models/api_response_model.dart';
import 'package:my_taraji/views/init/models/user.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class UserService {
  late String baseUrl = "https://devmytarajiapi.azurewebsites.net";

  UserService();

  Future<APIResponseModel<User>> getUserData() async {
    const path = "api/v1/users";
    final url = Uri.parse('$baseUrl/$path');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        return APIResponseModel<User>.fromJson(
          jsonData,
          (data) => User.fromJson(data),
        );
      } else {
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

  Future<String> authUserIzi(String username, String password) async {
    // Future<bool> authUserIzi(String username, String password) async {
    const path = "api/v1/payments/auth";
    final url = Uri.parse('$baseUrl/$path');

    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        // final Map<String, dynamic> jsonData = json.decode(response.body);

        // return jsonData['isSuccess'];
        return response.body.toString();
      } else {
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

  // https://devmytarajiapi.azurewebsites.net/api/v1/payments/confirmAuth?pin=3442
  Future<bool> confirmAuthIzi(String pin) async {
    const path = "api/v1/payments/confirmAuth";
    final url = Uri.parse('$baseUrl/$path?pin=$pin');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        return jsonData['isSuccess'];
      } else {
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
