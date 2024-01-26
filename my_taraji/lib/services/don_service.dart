import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/models/don_model.dart';

class DonService {
  late String baseUrl = "https://devmytarajiapi.azurewebsites.net";

  DonService();

  Future<DonSettings> getDonSettings() async {
    const path = "api/v1/settings-mobile";
    final url = Uri.parse('$baseUrl/$path');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        return DonSettings.fromJson(jsonData);
      } else {
        throw Exception('Failed API call: ${response.reasonPhrase}');
      }
    } catch (e) {
      if (e.toString().contains('400')) {
        throw Exception('Failed to load Don data');
      } else {
        throw Exception('Failed to connect to the server for Don data $e');
      }
    }
  }

  Future<double> getCoinsConvertor(double amount) async {
    const path = "api/v1/settings-mobile/coins-convertor";
    final url = Uri.parse('$baseUrl/$path?amount=$amount');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        debugPrint('jsonData: $jsonData');
        return jsonData['data'];
      } else {
        throw Exception('Failed API call: ${response.reasonPhrase}');
      }
    } catch (e) {
      if (e.toString().contains('400')) {
        throw Exception('Failed to load Don data');
      } else {
        throw Exception('Failed to connect to the server for Don data $e');
      }
    }
  }

  Future<DonModel> createDonation(DonModel don) async {
    const path = "api/v1/donation";
    final url = Uri.parse('$baseUrl/$path');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(don.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      debugPrint('jsonData: $jsonData');
      return DonModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to create donation - ${response.reasonPhrase}');
    }
  }
}
